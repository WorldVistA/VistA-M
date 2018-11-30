PXLOCK ;SLC/PKR - PCE Locking/Unlocking utility; 09/28/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;AUG 12, 1996;Build 244
 ;
 ;====================
FINDLOCK(VISITIEN,ERROR) ;Try to determine who has the lock on the
 ;encounter.
 N MSG,SUB,USER,USERNAME
 S SUB="PXLOCK:"_VISITIEN
 S SUB=$O(^XTMP(SUB))
 I SUB="" Q
 S USER=$P(SUB,":",3),USERNAME=$$GET1^DIQ(200,USER_",",.01,"","","MSG")
 I USERNAME="" S USERNAME="UNKNOWN (DUZ="_USER_")"
 S ERROR("LOCK")="User "_USERNAME_" is editing this encounter."
 Q
 ;
 ;====================
LOCK(VISITIEN,USER,NUMTRIES,ERROR,SOURCE) ;Lock the encounter.
 I $G(VISITIEN)="" S ERROR("LOCK")="Could not get lock, Visit not specified." Q 0
 I $G(USER)="" S ERROR("LOCK")="Could not get lock, User not specified." Q 0
 N IND,LOCK,SUB
 S SUB="PXLOCK:"_VISITIEN_":"_USER_":"_$J
 ;See if the encounter is already locked.
 I $D(^XTMP(SUB,0)) Q 1
 S (IND,LOCK)=0
 F  Q:(LOCK)!(IND=NUMTRIES)  D
 . L +^PXLOCK(VISITIEN):DILOCKTM
 . I $T S LOCK=1 Q
 . S IND=IND+1
 I LOCK=0 D FINDLOCK(VISITIEN,.ERROR) Q 0
 S NOW=$$NOW^XLFDT
 S ^XTMP(SUB,0)=$$FMADD^XLFDT(NOW,1,0,0,0)_U_NOW_U_"PCE LOCKING"
 I $G(SOURCE)'="" S ^XTMP(SUB,"SOURCE")=SOURCE
 Q 1
 ;
 ;====================
PXCEAE(VISITIEN,USER,NUMTRIES) ;Locking for PXCEAE.
 N DONE,ERROR,INPUT,LOCK,START
 S LOCK=$$LOCK(VISITIEN,USER,NUMTRIES,.ERROR,"PXCEAE")
 I LOCK=1 Q 1
 W !,"Cannot open this encounter.",!,ERROR("LOCK")
 S DONE=0
 W !,"Waiting for file access, press ENTER to cancel..."
 S START=$$NOW^XLFDT
 F  Q:DONE  D
 . S LOCK=$$LOCK(VISITIEN,USER,NUMTRIES,.ERROR,"PXCEAE")
 . I LOCK=1 S DONE=1 Q
 . R INPUT:0
 . I $T S DONE=1 Q
 . I $$FMDIFF^XLFDT($$NOW^XLFDT,START,2)>DTIME D
 .. S DONE=1
 .. W !,"The maximum wait time has been exceeded."
 .. H 2
 Q LOCK
 ;
 ;====================
UNLOCK(VISITIEN,USER,SOURCE) ;Unlock the encounter.
 N SUB
 S SUB="PXLOCK:"_VISITIEN_":"_USER_":"_$J
 ;If a SOURCE has been stored and it does not match the input
 ;SOURCE do not unlock.
 I $G(^XTMP(SUB,"SOURCE"))'="",$G(SOURCE)'=^XTMP(SUB,"SOURCE") Q
 L -^PXLOCK(VISITIEN):DILOCKTM
 I $T K ^XTMP(SUB)
 Q
 ;

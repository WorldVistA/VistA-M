DGOTHD2 ;SLC/SS,RM,RED - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;12/27/17
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;     Last Edited: SHRPE/RED - May 2, 2018 15:11
 ;
 ;  IA:  10103   ^XLFDT (supported)  - [$$FMADD^XLFDT, $$FMTE^XLFDT , $$NOW^XLFDT]
 ;       10015   ^DIQ   (supported)  - [GETS^DIQ]
 ;       10026   ^DIR   (supported)
 ;        2053   ^DIE   (supported)  - [FILE^DIE, UPDATE^DIE]
 ;       10000   ^%DTC  (supported)  - [NOW^%DTC]
 Q
 ;
 ;create the new entry in file #33 (OTH ELIGIBILITY)
 ;DGDFN - patient's IEN
 ;returns 
 ;IEN of the file #33
 ;or -1^error message
CROTHENT(DGDFN) ;
 N DGVALS,DGIEN33
 I $$CHCKPAT(DGDFN)'>0 Q -2  ;patient does not exist
 S DGVALS(.01)=DGDFN
 S DGVALS(.02)=1 ;set to ACTIVE
 S DGIEN=$$INSREC(33,"",.DGVALS)
 ;create subfile 2 - ELIGIBILITY CHANGES (Multiple-33.02)
 D CRTEELCH^DGOTHEL(DGDFN,$$HASENTRY^DGOTHD2(DGDFN),$$NOW^XLFDT())
 Q DGIEN
 ;
 ;Get the user's current facility number.  If not found, it will
 ;return the facility number of the primary facility.
GETSITE(DUZ) ;
 ;Input:
 ;      DUZ array, pass by reference
 ;Output:
 ;      Function Value - facility number
 N FACILITY
 S FACILITY=""
 S:DUZ'=.5 FACILITY=DUZ(2)
 I 'FACILITY S FACILITY=+$$SITE^VASITE()
 Q FACILITY
 ;
 ;check if the patient has 2nd period authorization
 ;DGIEN33 - ien file #33
 ;DGI3301 - ien subfile #33.01
 ;CLCKNO - 90 days clock #
HAS2AUTH(DGIEN33,DGI3301,CLCKNO) ;
 N DGIEN90,DGRETDAT
 S DGIEN90=$$CHCK90(DGIEN33,DGI3301,CLCKNO)
 I DGIEN90'>0 Q -1  ; OTH clock entry in the file #33 doesn't exist
 S DGRETDAT=$G(^DGOTH(33,DGIEN33,1,DGI3301,1,DGIEN90,0))
 Q $P(DGRETDAT,U,3,4)
 ;
 ;does the patient have clock?
 ;DGDFN - patient IEN
HASENTRY(DGDFN) ;
 Q +$O(^DGOTH(33,"B",DGDFN,0))
 ;
 ;how many 365 days clock the patient has?
 ;DGIEN33 - ien of #33
CLCKS365(DGIEN33) ;
 Q $O(^DGOTH(33,DGIEN33,1,"B",99),-1)
 ;
 ;returns 
 ;-1 : if OTH clock entry in the file #33 doesn't exist
 ;0  : if 365 days clock with the number CLCKNO doesn't exist
 ;>0 : IEN of the 365 days clock with the number CLCKNO
CHCK365(DGIEN33,CLCKNO) ;
 I +$D(^DGOTH(33,DGIEN33,0))'>0 Q -1  ;clock doesn't exist
 Q +$O(^DGOTH(33,DGIEN33,1,"B",CLCKNO,0))
 ;
 ;returns 
 ;-1 : if OTH clock entry in the file #33 doesn't exist
 ;0  : if 90 days clock with the number CLCKNO doesn't exist
 ;>0 : IEN of the 90 days clock with the number CLCKNO
CHCK90(DGIEN33,DGI3301,CLCKNO) ;
 I +$D(^DGOTH(33,DGIEN33,0))'>0 Q -1  ;clock doesn't exist
 I +$D(^DGOTH(33,DGIEN33,1,DGI3301,0))'>0 Q -1  ;clock doesn't exist
 Q +$O(^DGOTH(33,DGIEN33,1,DGI3301,1,"B",CLCKNO,0))
 ;check DFN
CHCKPAT(DGDFN) ;
 Q +$D(^DPT(DGDFN,0))
 ;
 ;get patient IEN by ien of the file #33
GETPAT(DGIEN33) ;
 Q $P($G(^DGOTH(33,DGIEN33,0)),U)
 ;
 ;input:
 ;DGPROM - prompt text
 ;DGDFVL - default value (optional)
 ;returns:
 ; "response^"
PROMPT(DGPROM,DGDFVL) ;
 N DGRET,DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT
 S DGRET="^"
 S DIR(0)="F^::2",DIR("A")=DGPROM
 I $L($G(DGDFVL))>0 S DIR("B")=$G(DGDFVL)
 D ^DIR I $D(DIRUT) Q "^"
 S $P(DGRET,U)=Y
 Q DGRET
 ;
 ;This procedure is used to perform a patient lookup for an existing patient in the (#33) file.
 ;Parameters: 
 ;  None
 ;Returns:
 ; in DGPAT array where
 ;  DGPAT = IEN of patient in PATIENT (#33) file on success, -1 on failure
 ;  DGPAT(0) = zero node of entry selected
 ; return value IEN of patient in PATIENT (#33) file on success, -1 on failure
SELPAT(DGPAT) ;
 ;- int input vars for ^DIC call
 N DIC,DTOUT,DUPOT,X,Y
 S DIC="^DGOTH(33,",DIC(0)="AEMQZV"
 ;screen out all that are not ACTIVE
 S DIC("S")="I $P(^(0),U,2)=1"
 ;- lookup patient
 D ^DIC K DIC
 ;- result of lookup
 S DGPAT=Y
 ;- if success, setup return array using output vars from ^DIC call
 I (+DGPAT>0) D  Q +Y
 . S DGPAT=+Y              ;patient ien
 . S DGPAT(0)=$G(Y(0))     ;zero node of patient in (#33) file
 Q -1
 ;
 ;/**
 ;Creates a new entry (or node for multiple with .01 field)
 ;
 ;DGFILE - file/subfile number
 ;DGIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ;DGZFDA - array with values for the fields
 ; format for DGZFDA:
 ; DGZFDA(.01)=value for #.01 field
 ; DGZFDA(3)=value for #3 field
 ;DGRECNO -(optional) specify IEN if you want specific value
 ; Note: "" then the system will assign the entry number itself.
 ;DGFLGS - FLAGS parameter for UPDATE^DIE
 ;DGLCKGL - fully specified global reference to lock
 ;DGLCKTM - time out for LOCK, if LOCKTIME=0 then the function will not lock the file 
 ;DGNEWRE - optional, flag = if 1 then allow to create a new top level record 
 ;  
 ;output :
 ; positive number - record # created
 ; <=0 - failure^error message
 ;
 ;Example:
 ;top level:
 ;S DGVALS(.01)="OTHD" W $$INSREC^DG53952(8.1,"",.DGVALS,,,,,1)
 ;2nd level:
 ;K DGVALS S DGVALS(.01)=1 W $$INSREC^DGOTHD2(33.01,"8",.DGVALS)
 ;3rd level:
 ;K DGVALS S DGVALS(.01)=1 W $$INSREC^DGOTHD2(33.11,"1,8",.DGVALS)
INSREC(DGFILE,DGIEN,DGZFDA,DGRECNO,DGFLGS,DGLCKGL,DGLCKTM,DGNEWRE) ;*/
 I ('$G(DGFILE)) Q "0^Invalid parameter"
 I +$G(DGNEWRE)=0 I $G(DGRECNO)>0,'$G(DGIEN) Q "0^Invalid parameter"
 N DGSSI,DGIENS,DGERR,DGFDA,DIERR
 N DGLOCK S DGLOCK=0
 I '$G(DGRECNO) N DGRECNO S DGRECNO=$G(DGRECNO)
 I DGIEN'="" S DGIENS="+1,"_DGIEN_"," I $L(DGRECNO)>0 S DGSSI(1)=+DGRECNO
 I DGIEN="" S DGIENS="+1," I $L(DGRECNO)>0 S DGSSI(1)=+DGRECNO
 M DGFDA(DGFILE,DGIENS)=DGZFDA
 I $L($G(DGLCKGL)) L +@DGLCKGL:(+$G(DGLCKTM)) S DGLOCK=$T I 'DGLOCK Q -2  ;lock failure
 D UPDATE^DIE($G(DGFLGS),"DGFDA","DGSSI","DGERR")
 I DGLOCK L -@DGLCKGL
 I $D(DGERR) Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1),"Update Error")
 Q +$G(DGSSI(1))
 ;
HELP3 ;display help text for 1st 90-Day period
 I $G(Y)<1,X'="?",X'="??" W !,"  You have entered an invalid date, please enter a valid date." Q
 W !,"  The date entered cannot be more than 90 days in the past."
 W !,"  A future date cannot be entered."
 Q
 ;

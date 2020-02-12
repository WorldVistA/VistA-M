SDECLK ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627,686**;Aug 13, 1993;Build 53
 ;
 Q
 ;
LOCK(SDECY,REQ) ; -- Attempt to lock request record
 ;INPUT:
 ; REQ = Request - (required) Appt Request type - variable pointer pointer
 ;                            to one of these files:
 ;                         SDEC APPT REQUEST    - A|<APPT IEN>     A|123
 ;                         SD WAIT LIST         - E|<WL IEN>       E|123
 ;                         REQUEST/CONSULTATION - C|<CONSULT IEN>  C|123
 ;                         RECALL REMINDERS     - R|^<RECALL IEN>  R|123
 ;RETURN:
 ; A single entry in the global array indicating the success/failure of getting the lock:
 ;   1. CODE    -  1 if successful, or 0^Message if could not get lock
 ;   2. MESSAGE -  Message Text
 N RET,SDI,SDTYP,SDIEN
 N Y,SDECLK,NOW,NOW1
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S @SDECY@(0)="T00030CODE^T00030MESSAGE"_$C(30)
 I $G(REQ)="" S RET="0^Invalid Request input"_$C(30,31) Q
 S SDTYP=$P(REQ,"|",1) I "ACER"'[SDTYP S @SDECY@(1)="0^Invalid Request Type"_$C(30,31) Q
 S SDIEN=$P(REQ,"|",2) I SDIEN'?1.N S @SDECY@(1)="0^Invalid Request ID"_$C(30,31) Q
 S SDECLK=$G(^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)) I $P(SDECLK,U,1)=DUZ S @SDECY@(1)="1^You already have the lock"_$C(30,31) Q  ;*zeb 3/15/18 return this result for user for any $J
 L +^XTMP("SDECLK"_SDTYP_"-"_SDIEN):5 I '$T S @SDECY@(1)="0^"_$S(+SDECLK:$P($G(^VA(200,+SDECLK,0)),U),1:"Another person")_" is editing this request."_$C(30,31) Q
 I SDECLK,$P(SDECLK,U,1)'=DUZ S @SDECY@(1)="0^"_$S(+SDECLK:$P($G(^VA(200,+SDECLK,0)),U),1:"Another person")_" is editing this request."_$C(30,31) L -^XTMP("SDECLK"_SDTYP_"-"_SDIEN) Q  ;*zeb 3/15/18 respect locks from other users
 ;unlock user's previous locks
 S SDI="SDECLK" F  S SDI=$O(^XTMP(SDI)) Q:SDI'["SDECLK"  Q:SDI=""  D
 .I ($P($G(^XTMP(SDI,1)),U,1)=DUZ)!($P($G(^XTMP(SDI,1)),U,1)="") D
 ..L +^XTMP(SDI):5 ;*zeb+1 3/15/18 fix handling of system locks
 ..Q:'$T
 ..K ^XTMP(SDI)
 ..L -^XTMP(SDI)
 S NOW=$$NOW^XLFDT,NOW1=$$FMADD^XLFDT(NOW,1)
 S ^XTMP("SDECLK"_SDTYP_"-"_SDIEN,0)=NOW1_U_NOW_"^VSE GUI Request Lock"
 S ^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)=DUZ_U_$J
 S @SDECY@(1)="1^Lock successful"_$C(30,31)
 L -^XTMP("SDECLK"_SDTYP_"-"_SDIEN) ;*zeb 3/15/18 fix handling of system locks
 Q
 ;
UNLOCK(SDECY,REQ,FLG) ; -- Unlock request record
 ;INPUT:
 ; REQ = (required) - Appt Request type - variable pointer pointer
 ;                            to one of these files:
 ;                         SDEC APPT REQUEST    - A|<APPT IEN>     A|123
 ;                         SD WAIT LIST         - E|<WL IEN>       E|123
 ;                         REQUEST/CONSULTATION - C|<CONSULT IEN>  C|123
 ;                         RECALL REMINDERS     - R|^<RECALL IEN>  R|123
 ; FLG = (optional) Unlock if other job
 ;        0 = (default) only unlock if lock belongs to current user and current $J job
 ;        1 = unlock even if the lock does not belong to current user and current $J job
 ;RETURN:
 ; A single entry in the global array indicating the success of unlocking the record:
 ;   1. CODE    -  1 if successful, or 0^Message if could not get lock
 ;   2. MESSAGE -  Message Text
 ;                 If message text="Not your lock" you can call again and send 1 as the 2nd input to unlock anyway.
 N SDTYP,SDIEN
 N Y,SDECLK,NOW,NOW1,SDECUSER
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S @SDECY@(0)="T00030CODE^T00030MESSAGE"_$C(30)
 I $G(REQ)="" S @SDECY@(1)="0^Invalid Request input"_$C(30,31) Q
 S SDTYP=$P(REQ,"|",1) I "ACER"'[SDTYP S @SDECY@(1)="0^Invalid Request Type"_$C(30,31) Q
 S SDIEN=$P(REQ,"|",2) I SDIEN'?1.N S @SDECY@(1)="0^Invalid Request ID"_$C(30,31) Q
 L +^XTMP("SDECLK"_SDTYP_"-"_SDIEN):5 I '$T S @SDECY@(1)="0^Unable to access lock table."_$C(30,31) Q  ;*zeb 3/15/18 fix handling of system locks
 S SDECLK=$G(^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)) ;*zeb+2 3/15/18 only do this once
 S SDECUSER=$P(SDECLK,U,1)
 I $G(FLG)'=1,(SDECUSER]""),(SDECUSER'=DUZ) S @SDECY@(1)="1^Not your lock"_$C(30,31) L -^XTMP("SDECLK"_SDTYP_"-"_SDIEN) Q  ;*zeb 3/22/18 fix handling of system locks
 ;the previous line is a silent failure if the lock doesn't exist or if someone else has it; they already have been behaving as if they had the lock
 ;this is a "shouldn't happen" scenario since the user had the lock before they tried to get rid of it, but we don't want to delete the new user
 K ^XTMP("SDECLK"_SDTYP_"-"_SDIEN) ;*zeb+1 3/15/18 change node before unlocking it
 L -^XTMP("SDECLK"_SDTYP_"-"_SDIEN)
 S @SDECY@(1)="1^Unlock successful"_$C(30,31)
 Q
 ;
 ;*zeb+tag 3/19/18 686 fix lock handling
 ;--------------------
 ;UNLKALL - Remove users' appointment request locks interactively
 ;--------------------
UNLKALL ;interactive option to remove a user's locks
 N SDECUSER,DIC,Y,U,SDNODE,SDLKDATA,SDLKUSER,SDLKFILE,SDLKIEN
 S Y="",U="^"
 W !,"Release all appointment request locks held by a user",!
 F  D  I Y=-1 Q
 .K DIC,Y
 .S DIC="^VA(200,"
 .S DIC(0)="AEQ"
 .S DIC("A")="Whose locks to release? "
 .D ^DIC
 .Q:(Y=-1)
 .S SDECUSER=$P(Y,U,1)
 .S SDNODE="SDECLK"
 .F  S SDNODE=$O(^XTMP(SDNODE)) Q:SDNODE'["SDECLK"  D
 ..S SDLKDATA=$G(^XTMP(SDNODE,1))
 ..S SDLKUSER=$P(SDLKDATA,U,1)
 ..Q:SDLKUSER'=SDECUSER  ;only want locks for this user
 ..K ^XTMP(SDNODE)
 ..S SDLKFILE=$E(SDNODE,7)
 ..S SDLKFILE=$S(SDLKFILE="E":"EWL Request",SDLKFILE="R":"PtCSch Request",SDLKFILE="C":"Consult",1:"APPT Request")
 ..S SDLKIEN=$P(SDNODE,"-",2)
 ..W !,"Lock released for "_SDLKFILE_" "_SDLKIEN
 Q

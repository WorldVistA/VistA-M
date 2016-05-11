SDECLK ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
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
 S SDECLK=$G(^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)) I SDECLK=(DUZ_U_$J) S @SDECY@(1)="1^You already have the lock"_$C(30,31) Q
 L +^XTMP("SDECLK"_SDTYP_"-"_SDIEN):5 I '$T S @SDECY@(1)="0^"_$S(+SDECLK:$P($G(^VA(200,+SDECLK,0)),U),1:"Another person")_" is editing this request."_$C(30,31) Q
 ;unlock previous locks
 S SDI="SDECLK" F  S SDI=$O(^XTMP(SDI)) Q:SDI'["SDECLK"  Q:SDI=""  D
 .;I ^XTMP(SDI,1)=DUZ_U_$J D
 .I ($P($G(^XTMP(SDI,1)),U,1)=DUZ)!($P($G(^XTMP(SDI,1)),U,1)="") D
 ..L -^XTMP(SDI)
 ..K ^XTMP(SDI)
 S NOW=$$NOW^XLFDT,NOW1=$$FMADD^XLFDT(NOW,1)
 S ^XTMP("SDECLK"_SDTYP_"-"_SDIEN,0)=NOW1_U_NOW_"^VSE GUI Request Lock"
 S ^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)=DUZ_U_$J
 S @SDECY@(1)="1^Lock successful"_$C(30,31)
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
 N Y,SDECLK,NOW,NOW1
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S @SDECY@(0)="T00030CODE^T00030MESSAGE"_$C(30)
 I $G(REQ)="" S @SDECY@(1)="0^Invalid Request input"_$C(30,31) Q
 S SDTYP=$P(REQ,"|",1) I "ACER"'[SDTYP S @SDECY@(1)="0^Invalid Request Type"_$C(30,31) Q
 S SDIEN=$P(REQ,"|",2) I SDIEN'?1.N S @SDECY@(1)="0^Invalid Request ID"_$C(30,31) Q
 I $G(FLG)'=1,$D(^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)),$P($G(^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1)),U,1)'=DUZ S @SDECY@(1)="0^Not your lock"_$C(30,31) Q
 L -^XTMP("SDECLK"_SDTYP_"-"_SDIEN)
 ;I $G(^XTMP("SDECLK"_SDTYP_"-"_SDIEN,1))=(DUZ_U_$J)
 K ^XTMP("SDECLK"_SDTYP_"-"_SDIEN)
 S @SDECY@(1)="1^Unlock successful"_$C(30,31)
 Q

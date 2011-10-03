SDVSIT ;MJK/ALB - Visit Tracking Processing ; 3/28/01 2:12pm
 ;;5.3;Scheduling;**27,44,75,96,132,161,219**;Aug 13, 1993
 ;
AEUPD(SDVIEN,SDATYPE,SDOEP) ; -- update one entry in multiple
 ; input: SDVIEN := Visit file pointer
 ;        SDATYPE := Appointment Type                         [optional]
 ;         SDOEP := ien of ^SCE that is the parent encounter [optional]
 ;
 N SDOE,DA,DR,DE,DQ,DIE,SD0,SDVSIT,SDT,SDLOCK,SDCL0
 ;
 G AEUPDQ:'$G(^AUPNVSIT(+$G(SDVIEN),0)) S SD0=^(0)
 S SDT=+SD0
 S SDVSIT("DFN")=$P(SD0,U,5)
 I ('SDVSIT("DFN")) G AEUPDQ
 ;
 ; -- set lock data and lock
 S SDLOCK("DFN")=$P(SD0,U,5)
 S SDLOCK("EVENT DATE/TIME")=SDT
 D LOCK(.SDLOCK)
 ;
 ; -- quit if encounter does exist for visit
 IF $O(^SCE("AVSIT",SDVIEN,0)) G AEUPDQ
 ;
 S SDVSIT("DIV")=+$P($G(^SC(+$P(SD0,U,22),0)),U,15)
 S SDVSIT("DIV")=$$DIV(SDVSIT("DIV"))
 I ('SDVSIT("DIV")) G AEUPDQ
 ;
 S SDVSIT("CLN")=+$P(SD0,U,8)
 ; -- this may not be needed any longer but doesn't hurt (mjk)
 I $P($G(^DIC(40.7,+$P(SD0,U,8),0)),U,2)=900 S SDVSIT("CLN")=+$P($G(^SC(+$P(SD0,U,22),0)),U,7)
 I 'SDVSIT("CLN") G AEUPDQ
 ;
 S:$P(SD0,U,22) SDVSIT("LOC")=$P(SD0,U,22)
 S:$P(SD0,U,21) SDVSIT("ELG")=$P(SD0,U,21)
 S SDVSIT("TYP")=$G(SDATYPE)
 S SDVSIT("PAR")=$G(SDOEP)
 S SDVSIT("ORG")=2
 S SDVSIT("REF")=""
 S SDOE=$$SDOE(SDT,.SDVSIT,SDVIEN,$G(SDOEP))
 S SDCL0=$G(^SC(+SDVSIT("LOC"),0))
 D CSTOP(SDOE,SDCL0,.SDVSIT,SDT)  ;Process credit stop if applicable
AEUPDQ D UNLOCK(.SDLOCK)
 Q
 ;
APPT(DFN,SDT,SDCL,SDVIEN) ; -- process appt
 ; input        DFN = ien of patient file entry
 ;              SDT = visit date internal format
 ;             SDCL = ien of hospital location file entry
 ;           SDVIEN = Visit file pointer [optional]
 ;
 N SDVSIT,SDOE,DA,DIE,DR,SDPT,SDSC,SDCL0,SDDA,SDLOCK
 ;
 ; -- set lock data and lock
 S SDLOCK("DFN")=DFN
 S SDLOCK("EVENT DATE/TIME")=SDT
 D LOCK(.SDLOCK)
 ;
 ; -- set node vars
 S SDPT=$G(^DPT(DFN,"S",SDT,0))
 S SDCL0=$G(^SC(SDCL,0)),SDDA=+$$FIND^SDAM2(DFN,SDT,SDCL)
 S SDSC=$G(^SC(SDCL,"S",SDT,1,SDDA,0))
 S SDVSIT("CLN")=$P(SDCL0,U,7),SDVSIT("DIV")=$$DIV($P(SDCL0,U,15))
 ;
 ; -- do checks
 I 'SDPT!('SDSC)!($P(SDCL0,U,3)'="C") G APPTQ
 I SDCL,+SDPT'=SDCL G APPTQ
 I $P(SDPT,U,20) G APPTQ
 I 'SDVSIT("CLN")!('SDVSIT("DIV")) G APPTQ
 ;
 ; -- set the rest
 S SDVSIT("DFN")=DFN,SDVSIT("LOC")=SDCL
 S:$P(SDSC,U,10) SDVSIT("ELG")=$P(SDSC,U,10)
 S:$P(SDPT,U,16) SDVSIT("TYP")=$P(SDPT,U,16)
 ;
 ; -- call logic to add opt encounter(s)
 S SDVSIT("ORG")=1,SDVSIT("REF")=SDDA,SDOE=$$SDOE(SDT,.SDVSIT,$G(SDVIEN))
 I SDOE D
 .N DA,DIE,DR
 .S DA=SDT,DA(1)=DFN,DR="21////"_SDOE,DIE="^DPT("_DFN_",""S""," D ^DIE
 ;
 D CSTOP(SDOE,SDCL0,.SDVSIT,SDT)  ;Process credit stop if applicable
 ;
APPTQ D UNLOCK(.SDLOCK)
 Q
 ;
CSTOP(SDOE,SDCL0,SDVSIT,SDT) ;Process credit stop
 ;Input: SDOE=encounter ien
 ;Input: SDCL0=zeroeth node of HOSPITAL LOCATION file record
 ;Input: SDVSIT=visit data array (pass by reference)
 ;Input: SDT=encounter date/time
 ; -- does clinic have a credit stop code?
 ; -- process only if non non-count and not equal to credit
 ;
 I SDOE,$P(SDCL0,U,18),($P(SDCL0,U,18)'=SDVSIT("CLN")),($P(SDCL0,U,17)'="Y") D
 . N X,SDVIENSV,SDVIENOR
 . S X=$G(^DIC(40.7,$P(SDCL0,U,18),0))
 .; -- is stop code active?
 . I $S('$P(X,U,3):1,1:SDT<$P(X,U,3)) D
 . . S SDVSIT("CLN")=$P(SDCL0,U,18)
 . . S SDVIENOR=$G(SDVSIT("ORG"))
 . . S SDVSIT("ORG")=4
 . . S SDVSIT("PAR")=SDOE
 . . S SDVIENSV=$G(SDVSIT("VST"))
 . . K SDVSIT("VST")
 . . S X=$$SDOE(SDT,.SDVSIT)
 . . IF X D LOGDATA^SDAPIAP(X)
 . .;
 . .; -- restore SDVSIT
 . . S SDVSIT("CLN")=$P(SDCL0,U,7)
 . . S SDVSIT("ORG")=SDVIENOR
 . . S SDVSIT("VST")=SDVIENSV
 . . K SDVSIT("PAR")
 . . Q
 . Q
 Q
 ;
DISP(DFN,SDT,SDVIEN) ; -- process disposition
 ; input        DFN = ien of patient file entry
 ;              SDT = visit date internal format
 ;             SDIV = ien of med ctr file entry
 ;           SDVIEN = Visit file pointer [optional]
 ;
 N SDVSIT,SDOE,DA,DIE,DR,SDIS,SDDA,SDLOCK
 ;
 ; -- set lock data and lock
 S SDLOCK("DFN")=DFN
 S SDLOCK("EVENT DATE/TIME")=SDT
 D LOCK(.SDLOCK)
 ;
 ; -- set up array and other vars
 D ARRAY(.DFN,.SDT,.SDDA,.SDIS,.SDVSIT)
 ;
 ; -- do checks
 I $P(SDIS,U,2)=2!($P(SDIS,U,2)="")!($P(SDIS,U,18)) G DISPQ
 I 'SDVSIT("CLN")!('SDVSIT("DIV")) G DISPQ
 ;
 ; -- call logic to add opt encounter/visit
 S SDOE=$$SDOE(SDT,.SDVSIT,$G(SDVIEN))
 I SDOE S DA=SDDA,DA(1)=DFN,DR="18////"_SDOE,DIE="^DPT("_DFN_",""DIS""," D ^DIE
DISPQ D UNLOCK(.SDLOCK)
 Q
 ;
ARRAY(DFN,SDT,SDDA,SDIS,SDVSIT) ; -- setup sdvsit for disposition
 S SDDA=9999999-SDT
 S SDIS=$G(^DPT(DFN,"DIS",SDDA,0))
 S SDVSIT("CLN")=$O(^DIC(40.7,"C",102,0))
 S SDVSIT("DIV")=$$DIV(+$P(SDIS,U,4))
 S:$P(SDIS,U,13) SDVSIT("ELG")=$P(SDIS,U,13)
 S SDVSIT("DFN")=DFN
 S SDVSIT("ORG")=3
 S SDVSIT("REF")=SDDA
 S SDVSIT("VST")=""
 S SDVSIT("TYP")=9
 Q
 ;
LOCK(SDLOCK) ; -- lock "ADFN" node
 L +^SCE("ADFN",+$G(SDLOCK("DFN")),+$G(SDLOCK("EVENT DATE/TIME")))
 Q
 ;
UNLOCK(SDLOCK) ; -- unlock "ADFN" node
 L -^SCE("ADFN",+$G(SDLOCK("DFN")),+$G(SDLOCK("EVENT DATE/TIME")))
 Q
 ;
DIV(DIV) ; -- determine med div
 I $P($G(^DG(43,1,"GL")),U,2),$D(^DG(40.8,+DIV,0)) G DIVQ ; multi-div?
 S DIV=+$O(^DG(40.8,0))
DIVQ Q DIV
 ;
 ; -- see bottom of SDVSIT0 for additional doc
 ;
SDOE(SDT,SDVSIT,SDVIEN,SDOEP) ; -- get visit & encounter
 S SDVSIT("VST")=$G(SDVIEN)
 IF 'SDVSIT("VST") D VISIT^SDVSIT0(SDT,.SDVSIT)
 Q $$NEW^SDVSIT0(SDT,.SDVSIT)
 ;
 ;
DATECHCK(DATETIME) ;Validate FileMan date/time
 ;Input  : DATETIME - Date and optional time in FileMan format
 ;Output : DATETIME - Valid date/time in FileMan format
 ;Notes  : If time was not included on input, time will not be included
 ;         on output
 ;       : If time rolls past midnight, 235959 (one second before
 ;         midnight) will be used
 ;       : Current date/time will be returned on NULL input
 ;       : Current date will be used if input date is not valid
 ;
 ;Check input
 Q:($G(DATETIME)="") $$NOW^XLFDT()
 ;Declare variables
 N DATE,TIME,HR,MIN,SEC,X,Y,%DT
 ;Break out date & time
 S DATE=$P(DATETIME,".",1)
 S TIME=$P(DATETIME,".",2)_"000000"
 ;Validate date
 S X=DATE
 S %DT="X"
 D ^%DT
 ;Date not valid - use current date
 S:(Y<0) DATE=$$DT^XLFDT()
 ;No time - return date
 Q:('TIME) DATE
 ;Break out hours, minutes, and seconds
 S HR=$E(TIME,1,2)
 S MIN=$E(TIME,3,4)
 S SEC=$E(TIME,5,6)
 ;Validate seconds - increment minutes if needed
 S:(SEC>59) MIN=MIN+1,SEC=SEC-60
 ;Validate minutes - increment hours if needed
 S:(MIN>59) HR=HR+1,MIN=MIN-60
 ;Validate hours - revert to one second before midnight
 S:(HR>23) HR=23,MIN=59,SEC=59
 ;Append leading zeros to hours, minutes, and seconds
 S HR="00"_HR
 S HR=$E(HR,($L(HR)-1),$L(HR))
 S MIN="00"_MIN
 S MIN=$E(MIN,($L(MIN)-1),$L(MIN))
 S SEC="00"_SEC
 S SEC=$E(SEC,($L(SEC)-1),$L(SEC))
 ;Rebuild time
 S TIME=HR_MIN_SEC
 ;Done - return date and time (trailing zeros removed)
 Q +(DATE_"."_TIME)

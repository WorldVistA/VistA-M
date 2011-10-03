EASMTCHK ;ALB/SCK,PJR -  MEANS TEST BLOCKING CHECK ; 11/13/03 11:13am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,12,15,38,46**;MAR 15,2001
 ; This routine provides an API, which when called from Appointment Management will allow 
 ; for the blocking of future appointments and appointment check-in/out if the patient 
 ; requires a Means Test or has a Means Test Status of Required. $$LST^DGMTU is used 
 ; to determine if a MT is REQUIRED.  If a MT does not have a status of REQUIRED, 
 ; but is more than 365 days out (same criteria used in OLD^DGMTU4), the MT will 
 ; be considered "REQUIRED" for blocking purposes. If a Means Test is required, the 
 ; following combinations of appointment actions will be blocked:
 ;    o Making a future appt for a Regular appt type
 ;    o Check In/Out an appt which is either a Regular or Research type
 ;
 ; A Walk-in will see the alert notice, and will be warned NOT to CHECK-IN the walk-in 
 ; appointment. Unscheduled/Walk-ins can ONLY be checked out.
 ;
 ; This API may be passed a flag to "silence" the screen display of the alert message, and 
 ; will accept an array variable to return the alert text in. Inpatient appointments 
 ; are not affected in any way.  Domicilary are not considered inpatients for the purpose 
 ; of Means Test Blocking for appointments
 ;
MT(DFN,EASAPT,EASACT,EASDT,EASQT,EASMSG) ; Entry point for MT Check
 ; Input Variables
 ;    DFN    - Patient's IEN in File #2
 ;    EASAPT - Appointment Type (File #409.1) [Optional]
 ;    EASACT - Appointment Action Flag [Optional] Default = "Other"
 ;             "M"  - Make an Appointment
 ;             "C"  - Check In/Out an existing appointment
 ;             "W"  - Unscheduled/Walk-in appointment
 ;             "O"  - Other
 ;             "L"  - Letters
 ;
 ;    EASDT  - Appointment Date/Time [Optional]
 ;    EASQT  - Silent flag [Optional], if set will prevent display of alert message
 ;    EASMSG - Return array for alert message [Optional], if passed in, the alert 
 ;             message text will be copied to this array
 ;
 ; Output
 ;    1  - Block action (MT Required)
 ;    0  - Don't block action (MT Not required)
 ;
 N RSLT,EASMT,EASTXT,EASX,EAMTS,DSPLY,IENS
 ;
 S RSLT=0
 S EASQT=+$G(EASQT)
 S EASAPT=+$G(EASAPT)
 S EASDT=$G(EASDT)
 S EASACT=$G(EASACT)
 S:EASACT']"" EASACT="O"
 ; If Appt type is not defined, action is CI/CO, get appt date
 I 'EASAPT,EASACT="C",EASDT]"" D
 .N DGARRAY,SDCNT
 .S DGARRAY(4)=DFN,DGARRAY("SORT")="P",DGARRAY("FLDS")=10
 .S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 .S EASAPT=+$P($G(^TMP($J,"SDAMA301",DFN,EASDT)),U,10)
 .K DGARRAY,SDCNT,^TMP($J,"SDAMA301")
 ;
 Q:$$INP(DFN) RSLT       ; Quit if inpatient
 S EAMTS=$$MTCHK(DFN,EASACT)    ; Get MT Check flag
 Q:'EAMTS RSLT
 ;
 ;Build Alert message 
 D BLDMSG(EASACT,.EASTXT)
 I $D(EASMSG) M @EASMSG=EASTXT ; If output array defined,copy message test
 ;
 ; Check appointment action and appointment type.  Set blocking action
 I EASACT="M",EASAPT=9 S (DSPLY,RSLT)=1 ; Make an Appt.
 ;
 I EASACT="C" D  ; Check-in an appt.
 . I $G(EASAPT)=9 S (DSPLY,RSLT)=1
 ;
 I "W,O"[EASACT D  ; Walk-in/Other appt.
 . S:$G(EASAPT)=9 DSPLY=1
 ;
 I $G(DSPLY) D
 . Q:EASQT  ; If silent flag is set, do not display alert
 . S EASX=0
 . W !?5,$CHAR(7),"******************************************************"
 . F  S EASX=$O(EASTXT(EASX)) Q:'EASX  D
 . . W !?5,EASTXT(EASX)
 ;
 ; Check for override key on making appointments
 I EASACT="M" D
 . I $D(^XUSEC("EAS MTOVERRIDE",DUZ)) S RSLT=0
 Q $G(RSLT)
 ;
MTCHK(DFN,EASACT) ; Check Means Test Status
 ; Input
 ;     DFN
 ;
 ; Output  
 ;     0   OK
 ;     1   MEANS TEST Required
 ;
 N RSLT,EASTAT,EASDT
 ;
 S RSLT=0
 S EASTAT=$$LST^DGMTU(DFN,"",1)
 I EASTAT]"" D
 . I $P(EASTAT,U,4)="R" S RSLT=1 Q
 . ;; Condition Check: MT Stat="P" AND GMT Threshold>Threshold A
 . ;;  AND MT Date is after 10/5/1999 AND Agrees to pay Deductible
 . ;;  AND MT Date is older than 365 days, THEN MT is required
 . I $P(EASTAT,U,4)="P",$$GET1^DIQ(408.31,+EASTAT,.27,"I")>$$GET1^DIQ(408.31,+EASTAT,.12,"I"),$P(EASTAT,U,2)>2991005,$$GET1^DIQ(408.31,+EASTAT,.11,"I"),$$OLD^DGMTU4($P(EASTAT,U,2)) S RSLT=1 Q
 . ;; Condition Check: Cat C or Pending Adj.
 . ;;  AND Agrees to pay Deductible AND MT date after 10/5/1999
 . I "C,P"[$P(EASTAT,U,4),$$GET1^DIQ(408.31,+EASTAT,.11,"I"),$P(EASTAT,U,2)>2991005 Q
 . I $P(EASTAT,U,4)="P",$$GET1^DIQ(408.31,+EASTAT,.27,"I")>$$GET1^DIQ(408.31,+EASTAT,.12,"I"),$P(EASTAT,U,2)>2991005,$$GET1^DIQ(408.31,+EASTAT,.11,"I"),$$OLD^DGMTU4($P(EASTAT,U,2)) S RSLT=1 Q
 . ;; Condition Check: Cat C AND Declines to give income information AND Agreed to pay deductible
 . I $P(EASTAT,U,4)="C",$$GET1^DIQ(408.31,+EASTAT,.14,"I"),$$GET1^DIQ(408.31,+EASTAT,.11,"I") Q
 . S EASDT=$P(EASTAT,U,2)
 . I ($$FMDIFF^XLFDT(DT,EASDT)>365) S RSLT=1
 . I $G(EASACT)="L" D
 . . ;; For letters, need to check for letters past 60-day threshold
 . . I ($$FMDIFF^XLFDT(DT,EASDT)>304) S RSLT=1
 ;
 I $P(EASTAT,U,4)="N" S RSLT=0
 Q $G(RSLT)
 ;
BLDMSG(EASACT,EASTXT) ; Build alert message to user
 N LINE
 ;
 S LINE=1
 S EASTXT(LINE)="Means Test Alert",LINE=LINE+1
 S EASTXT(LINE)="A Means Test is required or needs to be completed.",LINE=LINE+1
 ;
 I "M,C,W"[EASACT D
 . S EASTXT(LINE)="Please perform MEANS TEST or instruct patient",LINE=LINE+1
 . S EASTXT(LINE)="to report for Means Test interview.",LINE=LINE+1
 ;
 I EASACT="M" D
 . S EASTXT(LINE)=">> A future appointment cannot be made at this time."
 . S:$D(^XUSEC("EAS MTOVERRIDE",DUZ)) EASTXT(LINE)=">> Override Key in Effect."
 . S LINE=LINE+1
 ;
 I EASACT="C" S EASTXT(LINE)=">> This action may not be completed at this time.",LINE=LINE+1
 I EASACT="W" D
 . S EASTXT(LINE)=">> Check-Out ONLY.  Do NOT Check-In (CI) a walk-in appointment",LINE=LINE+1
 . S EASTXT(LINE)="   You will not be able to check-out the appt. if you do so.",LINE=LINE+1
 Q
 ;
INP(DFN) ; Check on Inpatient status
 ;  Input
 ;     DFN   - IEN from patient file
 ;  Output
 ;     1 - Patient has Inpatient status 
 ;     0 - Patient does not have Inpatient status
 ;  Default
 ;     Inpatient API defaults to TODAY for inpatient status check
 ;
 N VAERR,EAIN,VAROOT,VAINDT
 ;
 S VAINDT=$$NOW^XLFDT,VAROOT="EAIN"
 ;; Modified to treat DOM patients as inpatients for the purpose of appointment blocking.
 ;; EAS*1*12
 D INP^VADPT
 Q $S(+$G(EAIN(1)):1,1:0)

RCRPU2 ;EDE/YMG - REPAYMENT PLAN UTILITIES;02/03/2021  8:40 AM
 ;;4.5;Accounts Receivable;**381,378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RECALL(BILL,RSN) ; recall bill from cross-servicing
 ;
 ; BILL - bill to recall (file 430 ien)
 ; RSN  - recall reason to use (code for field 430/154)
 ;
 ; returns 1 on success, 0^error on failure
 ;
 N DIERR,FDA,IENS
 I BILL'>0 Q "0^Invalid file 430 ien"
 I RSN="" Q "0^Invalid recall reason"
 L +^PRCA(430,BILL):5 I '$T Q "0^Unable to lock entry"
 S IENS=BILL_","
 S FDA(430,IENS,152)=1
 S FDA(430,IENS,154)=RSN
 D FILE^DIE("","FDA","DIERR")
 I $D(DIERR("DIERR")) Q "0^"_$G(DIERR("DIERR",1,"TEXT",1))
 L -^PRCA(430,BILL)
 D CSRCLPL^RCTCSPD5 ; CS Recall Placed comment tx in 433
 Q 1
 ;
DISPREF(TYPE) ; display referred bills
 ;
 ; TYPE - type of bills to display: 0 = TSCP, 1 = TOP/DMC
 ;
 ; assumes that ^TMP("RCRPP",$J,"CS") is populated
 ;
 N AMT,BILL,BILLNO,CAT,CATN,CS,DATA,DOS,HDRFLG,LEN,STAT,STATN,RCLRES,TSCP,Z
 S TSCP="",HDRFLG=0
 S Z="" F  S Z=$O(^TMP("RCRPP",$J,"CS",Z)) Q:'Z  D
 .S DATA=$G(^TMP("RCRPP",$J,"CS",Z)) Q:DATA=""
 .S BILL=$P(DATA,U)  ; file 430 ien
 .S CS=$P(DATA,U,7)  ; CS type: 1 = TSCP, 2 = DMC, 3 = TOP
 .I 'TYPE,CS'=1 Q    ; not at TSCP
 .I TYPE,CS'>1 Q     ; not at TOP/DMC
 .S BILLNO=$P(DATA,U,2),AMT=$P(DATA,U,3),DOS=$P(DATA,U,4),STAT=$P(DATA,U,5),CAT=$P(DATA,U,6)
 .S CATN=$P($G(^PRCA(430.2,CAT,0)),U),STATN=$P($G(^PRCA(430.3,STAT,0)),U)
 .I 'HDRFLG D
 ..I 'TYPE W !!,"Bills at Treasury for Cross-Servicing Debt Collection:",!
 ..I TYPE W !!,"Bills in either the Treasury Offset Program or the Debt Management Collection:",!
 ..S HDRFLG=1
 ..Q
 .; add bill to the list of TSCP bills
 .I 'TYPE S TSCP=$S(TSCP'="":",",1:"")_BILL
 .; display bill info
 .W !,BILLNO,?21,$E(CATN,1,24),?47,$TR($$FMTE^XLFDT(DOS,"2DZ"),"/","-"),?57,STATN,?67,"$",$J(AMT,8,2) W:TYPE ?77,$S(CS=2:"DMC",CS=3:"TOP",1:"")
 .Q
 I HDRFLG D
 .I TYPE W !!,"Review these bills to see if they should be included into the Repayment Plan.",! D PAUSE^RCRPU Q
 .; TSCP bills
 .W !
 .;Ask user if these bills should be recalled.
 .I $$ASKRCL()=1 S LEN=$L(TSCP,",") D
 ..F Z=1:1:LEN D
 ...; recall bill
 ...S BILL=$P(TSCP,",",Z),RCLRES=$$RECALL(BILL,"08")
 ...I +RCLRES<0 W !,"Recall failed for bill ",$$GET1^DIQ(430,BILL_",",.01)," - ",$P(RCLRES,U,2)
 ...Q
 ..W !!,"Recalls have been placed for the above bills."
 ..Q
 .Q
 Q
 ;
ASKRCL() ; display "recall bills?" prompt
 ;
 ; returns 1 for Yes, 0 for No, -1 for no selection
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you wish to recall these bills? (Y/N)",DIR("B")="NO"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
 ;
ASKCONT() ; display "press return to continue or ^ to quit" prompt
 ;
 ; returns 1 if user pressed <enter>, 0 on user exit.
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q 0
 Q 1
 ;
UPDRVW(RCIEN,RCFLG) ; Update the Review Flag
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;        RCFLG:  Value of the flag.
 ;                1        : To appear on the Term Length Exceeded Report
 ;                0 or NULL: Does not appear on the Term Length Exceeded Report
 ;
 N DA,DR,DIE,X,Y,RCDT
 ;
 S RCFLG=$G(RCFLG)  ;Ensure the review flag is defined.
 ;
 S DA=RCIEN,DIE="^RCRP(340.5,"
 S DR="1.01///"_RCFLG
 S RCDT=$S(RCFLG:$$DT^XLFDT,1:"@")
 S DR=DR_";1.05///"_RCDT
 D ^DIE
 ;
 ;Update the AR Metrics File either field 1.03 if needs review or field 1.04 if the plan no longer needs review.
 D:+RCFLG UPDMET^RCSTATU(1.03,1)
 D:'RCFLG UPDMET^RCSTATU(1.04,1)
 ;
 Q
 ;
UPDATCS(RCIEN,RCATCS,RCENTER) ; Update the AT CS Flag
 ;INPUT - RCIEN:   IEN of the Repayment Plan
 ;        RCATCS:  The new value of the AT CS? (field 1.04) in the Repayment Plan 
 ;        RCENTER: (Optional) Flag to indicate if the update is due to a new plan being entered
 ;
 N DA,DR,DIE,X,Y,RCFIELD,RCAUTO
 ;
 S RCENTER=+$G(RCENTER)
 S RCATCS=+$G(RCATCS)
 S DA=RCIEN,DIE="^RCRP(340.5,"
 S DR="1.04///"_RCATCS
 D ^DIE
 ;
 ;Update the AR Metrics File.  
 ;   If the plan no longer has bills at CS, update field 1.08
 ;   If the plan has bills at CS when created, update field 1.07
 ;   If the plan has new bills going to CS and the AUTO-ADD flag is no, update field 1.06 and send a bulletin
 ;   If the plan has new bills going to CS and the AUTO-ADD flag is Yes, update field 1.05 and send a bulletin
 I +RCATCS D  Q
 . ;Determine which field in the Metrics file to update
 . S RCAUTO=$$GET1^DIQ(340.5,RCIEN_",",.12,"I")
 . S RCFIELD=$S(RCENTER:1.07,+RCAUTO:1.05,1:1.06)
 . ;
 . D UPDMET^RCSTATU(RCFIELD,1)
 . ;
 . ; Send the appropriate Bulletin
 ;
 ; Flag was changed to No.
 D UPDMET^RCSTATU(1.08,1)
 Q
 ;
CALCTOT(RCIEN) ; Calculate the total amount due on a Repayment Plan.
 ;INPUT - RCIEN - IEN of the Repayment Plan
 ;Returns - RCTOT - Total amount due.
 N RCTOT,RCBLLP,RCBLNO,RCI,RCD7
 S RCTOT=0,RCBLLP=0
 F  S RCBLLP=$O(^RCRP(340.5,RCIEN,6,RCBLLP)) Q:'RCBLLP  D
 . S RCBLNO=$G(^RCRP(340.5,RCIEN,6,RCBLLP,0))
 . Q:'RCBLNO  ; Bill number not stored correctly, get next bill.
 . S RCD7=$G(^PRCA(430,RCBLNO,7))
 . F RCI=1:1:5 S RCTOT=RCTOT+$P(RCD7,U,RCI)  ;add fields 71-75 to running total
 Q RCTOT
 ;
PRTTMP(RCIEN) ; Entry Point to print Plan ID and Status.
 ;
 ;INPUT - (Required) Repayment Plan IEN
 ;
 N RCID,RCSTAT
 ;
 Q:$G(RCIEN)=""
 S RCID=$$GET1^DIQ(340.5,RCIEN_",",.01,"E")
 S RCSTAT=$$GET1^DIQ(340.5,RCIEN_",",.07,"E")
 W !,"REPAYMENT PLAN ID: ",RCID,?39,"STATUS: ",RCSTAT,!
 ;
 Q
 ;
UPDAUDIT(RCRPIEN,RCCHGDT,RCCTYPE,RCCMMNT,RCCMTXT) ; Update the Audit Log for the Plan
 ;
 ;INPUT - RCRPIEN - IEN of the repayment plan to update
 ;        RCCHGDT - date of the change
 ;        RCCTYPE - (N)ew, (E)dit, C)lose, OR (S)tatus Update
 ;        RCCMMNT - Code for the reason
 ;                NULL - No comment needed for Type
 ;                   N - New Plan
 ;                   T - Terms Adjustment
 ;                   F - Forbearance Granted
 ;                   S - System Termination
 ;                   D - Defaulted for Non Payment (manual Default)
 ;                   A - Administratively Closed (manual non default closing)
 ;        RCCMTXT - Free Text Reason (currently coded to Status Only).  Will not be defined if RCCMMNT is defined.
 ;
 ;Ensure that that RCCMMNT and RCCMTXT are defined.
 S RCCMMNT=$G(RCCMMNT)
 S RCCMTXT=$G(RCCMTXT)
 ;
 ;Retrieve Last Audit Log entry
 ;Check to see that the audit log entry is not a Repeat of last log entry.  If it is, don't file it.
 S RCTYPE=$S($G(RCCMMNT)'="":"C",1:"T")    ;Check for comment type
 S RCAUDIT=$$GETLSTAU(RCRPIEN,RCTYPE)
 I (RCTYPE="C"),($P(RCAUDIT,U)=RCCTYPE),(RCCMMNT=$P(RCAUDIT,U,2)) Q
 I (RCTYPE="T"),($P(RCAUDIT,U)=RCCTYPE),(RCCMTXT=$P(RCAUDIT,U,2)) Q
 N DLAYGO,DD,DO,DIC,DA,X,Y
 S RCCMMNT=$G(RCCMMNT)
 S RCCMTXT=$G(RCCMTXT)
 S DLAYGO=340.5,DA(1)=RCRPIEN,DIC(0)="L",DIC="^RCRP(340.5,"_DA(1)_",4,",X=RCCHGDT
 S DIC("DR")="1///"_RCCTYPE_";2///"_DUZ
 S:RCCMMNT'="" DIC("DR")=DIC("DR")_";3///"_RCCMMNT
 I RCCMMNT="",RCCMTXT'="" S DIC("DR")=DIC("DR")_";4///"_RCCMTXT
 D FILE^DICN
 Q
 ;
GETLSTAU(RCRPIEN,RCTYPE) ; Get the last entry in the Audit Log.
 ;INPUT:  RCRPIEN - Repayment Plan ID
 ;        RCTYPE  - retrieve (C)omment Code or (T)ext Comment
 ;OUTPUT: Audit Log Type (internal code) ^ Code or Comment
 ;
 N RCRP
 ;Find the last Audit Log entry
 S RCLSTAUD=$O(^RCRP(340.5,RCRPIEN,4,"A"),-1)
 ;Quit if the first entry
 Q:RCLSTAUD="" ""
 ;Extract the entry
 S RCAUDDTA=$G(^RCRP(340.5,RCRPIEN,4,RCLSTAUD,0))
 ;Retrieve the specified comment
 S RCCMTCD=$S(RCTYPE="C":$P(RCAUDDTA,U,4),1:$P(RCAUDDTA,U,5))
 ; Return Log entry and comment
 Q $P(RCAUDDTA,U,2)_U_RCCMTCD
 ;
BLDPLN(RCSTDT,RCLEN,RCSTFLG,RCRPIEN) ; Build the Payment Schedule
 ;INPUT - RCSTDT  - Initial proposed start date
 ;        RCLEN   - Total Number of months
 ;        RCSTFLG - (Optional) Flag to indicate if Start Date should be included in payment schedule
 ;        RCRPIEN - (Optional) Repayment Plan ID (if editing the plan amount)
 ; 
 N RCMNARY,RCSTART,RCMONTH,RCYEAR,RCCOUNT,RCDATE
 ;
 S RCRPIEN=$G(RCRPIEN)
 ;If Start flag is set, then skip the adding the start date to the schedule
 S RCSTFLG=$G(RCSTFLG)
 S RCSTART=$E(RCSTDT,1,5),RCMONTH=$E(RCSTART,4,5),RCYEAR=$E(RCSTART,1,3)
 ;
 S:'RCSTFLG RCMNARY(RCSTDT)=""
 S:RCSTFLG RCLEN=RCLEN+1
 ;
 F RCCOUNT=2:1:RCLEN D
 .  S RCMONTH=RCMONTH+1
 .  S:RCMONTH=13 RCMONTH=1,RCYEAR=RCYEAR+1
 .  I RCMONTH<10 S RCMONTH="0"_RCMONTH
 .  S RCDATE=RCYEAR_RCMONTH_28
 .  I RCRPIEN,$D(^RCRP(340.5,RCRPIEN,2,"B",RCDATE)) S RCLEN=RCLEN+1  ;Payment already scheduled for that month, don't reschedule
 .  S RCMNARY(RCDATE)=""
 M ^TMP("RCRPP",$J,"PLAN")=RCMNARY
 Q
 ;

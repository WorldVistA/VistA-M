RCRPENTR ;EDE/SAB - CREATE NEW REPAYMENT PLAN;11/16/2020  7:40 AM
 ;;4.5;Accounts Receivable;**377,381,378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
ENTER ; Main Entry Point
 ;
 N RCAUTO,RCDBTR,RCCTS,RCACPL,RCTOT,RCBLCH,RCALLFLG,RCDONE,RCSVFLG
 ;
 F  D  Q:+RCDBTR=0
 . ;
 . S RCDONE=0
 . W @IOF
 . ;Ask user for Debtor to build the plan for
 . S RCDBTR=$$GETDBTR^RCRPU
 . Q:+RCDBTR=0
 . ;
 . ;clear working array
 . K ^TMP("RCRPP",$J)
 . ;
 . ;Check for an active Repayment Plan
 . S RCACPL=$$CHKACT^RCRPU(+RCDBTR)
 . ;If an active repayment plan print warning message to user and exit.
 . I +RCACPL D  Q
 . . W !,"This Debtor already has a Repayment Plan that is active."
 . . W !,"A new plan was not created.",!
 . . D PAUSE^RCRPU ;Any key to continue prompt
 . ;Otherwise, print the list of Active Bills
 . W !,"This Debtor does not have a Repayment Plan",!!,"List of Active Bills:",!!
 . S RCCTS=$$GETACTS^RCRPU(+RCDBTR)
 . W @IOF
 . D PRTACTS^RCRPU(+RCCTS)
 . ;Ask user which Active bills to add to new plan (single, range, or all)
 . S RCBLCH=$$GETBILLS^RCRPU(+RCCTS)
 . S RCALLFLG=+RCBLCH,RCBLCH=$P(RCBLCH,U,2)
 . ;If no bills selected, exit.
 . I RCBLCH="" D  Q
 . . W !,"No Bills selected",!
 . . D PAUSE^RCRPU
 . . W @IOF
 . ;Display Bills selected if All Bills not selected
 . I 'RCALLFLG D  Q:'RCDONE
 . . S RCDONE=$$ECHOBL^RCRPADD($P(RCBLCH,U,2))
 . ;Display total sum of bills chosen and confirm with user, exit if no.
 . S RCTOT=$$TOT^RCRPU(RCBLCH)
 . I '+RCTOT D  Q
 . . D PAUSE^RCRPU    ;Any key to continue prompt
 . S RCAUTO=$$AUTOADD^RCRPU1(0) Q:RCAUTO<0  ; prompt for auto-adding bills to the RPP PRCA*4.5*378
 . ;Strip confirm flag to get total.
 . S RCTOT=$P(RCTOT,U,2)
 . ;Get the repayment plan details and save
 . S RCSVFLG=$$GETDET^RCRPU(RCBLCH,RCTOT,RCDBTR,RCAUTO)
 . Q:RCSVFLG<1
 . ;Display bills at CS and recall them if necessary
 . D DISPREF^RCRPU2(0)
 . ;Display bills at TOP/DMC
 . D DISPREF^RCRPU2(1)
 ;
 ;Clear working array when exiting.
 K ^TMP("RCRPP",$J)
 ;
 Q
 ;
EDIT ;Edit A Repayment Plan
 ;
 N RCEND
 ;
 F  D  Q:+RCEND<1
 . ;Ask user for Debtor to build the plan for
 . S RCEND=$$GETPLAN
 Q
 ;
GETPLAN() ;Get the Plan IEN using Debtor or Repayment Plan ID.
 N RCDATA,RCIEN,RCERROR,RCDBTR,RCDBTRN,RCRPID,RCMNAMT,RCLNG,RCSTAT,RCLP,RCEDTYPE
 N RCAUTO,RCIENC,RCMSCT,RCPYMD,RCSTDT,RCEXIT,RCEXIT1,RCAFLG,RCPYFB
 ;
 ;Ask user if they wish to perform the lookup by ID or by Debtor
 ;
 S RCEXIT=0
 F  D  Q:RCEXIT<0
 . W @IOF
 . S RCIEN=$$SELRPP^RCRPU1()
 . I +RCIEN<1 S RCEXIT=-1 Q
 . ;
 . ; don't allow editing of plans in "closed", "paid in full", and "terminated" status
 . I "^6^7^8^"[$$GET1^DIQ(340.5,RCIEN_",",.07,"I")_U W !!,"Can't edit a closed repayment plan.",! D PAUSE^RCRPRPU S RCEXIT=0 Q
 . ;
 . F  D  Q:RCEXIT1<1
 . . S (RCDATA,RCERROR)="",RCIENC=RCIEN_","
 . . ;Get the Plan information
 . . K RCDATA N RCDATA  ; Clear and redefine RCDATA before reprinting screen
 . . D GETS^DIQ(340.5,RCIENC,"**","EI","RCDATA","RCERROR")
 . . ;
 . . ;Get the Base info
 . . S RCRPID=RCDATA(340.5,RCIENC,.01,"E")
 . . S RCDBTRN=RCDATA(340.5,RCIENC,.02,"E")
 . . S RCDBTR=RCDATA(340.5,RCIENC,.02,"I")
 . . S RCSTDT=RCDATA(340.5,RCIENC,.04,"I")
 . . S RCMNAMT=RCDATA(340.5,RCIENC,.06,"E")
 . . S RCLNG=RCDATA(340.5,RCIENC,.05,"E")
 . . S RCSTAT=RCDATA(340.5,RCIENC,.07,"E")
 . . S RCAFLG=RCDATA(340.5,RCIENC,.12,"E")
 . . ; 
 . . ;Calculate the # payments remaining
 . . S RCLP="",RCMSCT=0
 . . F  S RCLP=$O(RCDATA(340.52,RCLP)) Q:'RCLP  D
 . . . S RCPYMD=RCDATA(340.52,RCLP,1,"I"),RCPYFB=RCDATA(340.52,RCLP,2,"I")
 . . . I 'RCPYMD,'RCPYFB S RCMSCT=RCMSCT+1
 . . ;
 . . ;Display the Plan summary information
 . . W @IOF,!,"--------------------------------------------------------------------------------"
 . . W !,"Repayment Plan Overview for AR Debtor: ",RCDBTRN,!
 . . W !,?23,"Repayment Plan ID: ",RCRPID,!
 . . W !,"Monthly Repayment Amount:",?32,"$",$J(RCMNAMT,0,2)
 . . W ?45,"Original # of Payments:",?70,RCLNG
 . . W !,"# of Remaining Payments:",?32,RCMSCT
 . . W ?45,"Current Status:",?70,RCSTAT
 . . W !,"Date First Payment Due:",?32,$$FMTE^XLFDT(RCSTDT,"5DZ")
 . . W ?45,"Auto Add New Bills:",?70,RCAFLG
 . . W !,"--------------------------------------------------------------------------------",!
 . . ;
 . . ;Ask user what to edit (Close Plan, Edit Monthly Payment, or Allow Auto Adding of Bills
 . . S RCEXIT1=0
 . . S RCEDTYPE=$$GETTYPE
 . . I RCEDTYPE=-1 S RCEXIT1=0 Q   ; Time out or user "^" to exit option
 . . ;
 . . ; PRCA*4.5*378 - Added 2 new user prompts
 . . I RCEDTYPE="Q" S RCEXIT1=0 Q     ;User requested Exit pla using prompt
 . . ;
 . . I RCEDTYPE="C" D CLOSE(RCIEN) K ^TMP($J,"RPPFLDNO") S RCEXIT1=0 Q
 . . ;
 . . I RCEDTYPE="E" D EDMN(RCDBTR,RCIEN,RCMSCT) S RCEXIT1=1 Q
 . . ;
 . . I RCEDTYPE="A" S RCAUTO=$$AUTOADD^RCRPU1 D:RCAUTO'<0 UPDAUTO^RCRPU1(RCIEN,RCAUTO) S RCEXIT1=1 Q
 ;
 Q RCEXIT
 ;
GETTYPE() ;Get the user requested type of editing.
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ; Prompt Summary or Detail version
 ;S DIR("A")="(C)lose the Plan or (E)dit Monthly Payment?  "
 S DIR("A")="(C)lose Plan, (E)dit Monthly Payment, (A)llow Bill Auto-Add, or (Q)uit?  "
 S DIR("B")="Q"
 S DIR(0)="SA^C:Close Plan;E:Edit Payment Amount;A:Allow Auto-add;Q:Quit"
 S DIR("?")="Select whether to Close the plan, Change the amount of the Monthly Payment, Turn on or off the Auto-add of bills ability, or Quit."
 ;
 D ^DIR K DIR
 ;
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="") Q -1
 ;
 Q Y
 ;
EDMN(RCDBTR,RCIEN,RCORLN) ;Edit the monthly payment
 ;INPUT - RCIEN - IEN of the Repayment Plan being edited.
 ;        RCORLN - Original # remaining Payments.
 ;
 N RCTOT,RCPLN,RCCRDT
 ;
 S RCCRDT=$$DT^XLFDT
 ;Determine actual amount remaining
 S RCTOT=$$CALCTOT^RCRPU2(RCIEN)
 ;
 ;Ask for the new amount and plan length
 S RCPLN=$$GETPLN^RCRPU(RCDBTR,RCTOT,1)
 Q:'RCPLN
 ;
 ;Confirm that this is correct
 Q:'$$CORRECT^RCRPU
 ;
 ;Update the amount per Month, # payments in the plan, Update the REVIEW field
 D UPDTERMS^RCRPU1(RCIEN,RCPLN)
 ;
 ;Determine if the Review flag should be set or cleared.
 S RCFLG=0
 I $P(RCPLN,U,2)>57 S RCFLG=1
 D UPDRVW^RCRPU2(RCIEN,RCFLG)
 ;
 ;Update the audit log.
 D UPDAUDIT^RCRPU2(RCIEN,RCCRDT,"E","T")  ;Post a Edit/Terms Adjusted entry in Audit log.
 ;
 ;Update Audit Log with Supervisor Approvals, if any.
 D:$G(^TMP("RCRPP",$J,"SUP25")) UPDAUDIT^RCRPU2(RCIEN,RCCRDT,"E","SA")
 D:$G(^TMP("RCRPP",$J,"SUP36")) UPDAUDIT^RCRPU2(RCIEN,RCCRDT,"E","SM")
 ;
 ;Update the schedule, removing any extra payments not needed.
 I RCORLN'=$P(RCPLN,U,2) D ADJSCHED(RCIEN,RCORLN,$P(RCPLN,U,2))
 ;
 ;File a transaction to signal the plan was edited.
 D UPDTRAN^RCRPU1(RCIEN)
 ;
 W !,"Plan Updated.  " D PAUSE^RCRPU
 ;
 Q
 ;
CLOSE(RCIEN) ;Close the Plan
 ;
 N RCREASON,RCCURST,RCFIELD
 ;
 ;Extract the Current sTatus
 S RCCURST=$$GET1^DIQ(340.5,RCIEN_",",.07,"I")
 ; Set up the field # array for the metrics file
 D BLDSTARY^RCRPNP
 ;
 ;Confirm that the user wishes to close the plan 
 Q:'$$CORRECT^RCRPU(3) -1
 ;
 ; Enter the reason for closing the plan (defaulting for non-payment or administrative)
 S RCREASON=$$GETRSN^RCRPU1
 Q:RCREASON=-1 -1
 ;
 ;Confirm that the reason and closure is correct
 Q:'$$CORRECT^RCRPU -1
 ;
 ;Update the Plan status to CLOSED
 D UPDSTAT^RCRPU1(RCIEN,7)
 ;
 ;Update the correct Status Movement Metric
 S RCFIELD=$G(^TMP($J,"RPPFLDNO",RCCURST,7))
 D UPDMET^RCSTATU(RCFIELD,1)
 ;
 ;Update the Close Reason Metric (Default reason updates field 1.28, otherwise, update 1.27 in the AR Metrics file (340.7)
 S RCFIELD=$S(RCREASON="D":1.28,1:1.27)
 D UPDMET^RCSTATU(RCFIELD,1)
 ;
 ;Update the audit log with the reason
 D UPDAUDIT^RCRPU2(RCIEN,$$DT^XLFDT,"C",RCREASON)
 ;
 ;Update the Bills on the plan to remove the REPAYMENT PLAN DATE and AR REPAYMENT PLAN ID
 ;Also, file a transaction indicating that the Plan was closed.
 D RMBILL^RCRPU1(RCIEN)
 ;
 W !,"Plan Closed.  " D PAUSE^RCRPU
 ;
 Q 1
 ;
ADJSCHED(RCIEN,RCORLN,RCNEWLN) ; Add or subtract payments from a plan's Schedule.
 ;INPUT - RCIEN - IEN of the Repayment Plan being adjusted
 ;        RCORLN - Original Term Length of the payments
 ;        RCNEWLN - New Term Length
 ;
 N RCLP,RCLP1,RCPD,RCSTDT,RCSUB,RCFB,RCFBCT
 ;
 ;Clear RPP Temp array
 K ^TMP("RCRPP",$J)
 ;
 I RCORLN>RCNEWLN D  Q
 .  ;Count the # of payments forborne
 .  S RCFBCT=0,RCLP=0
 .  F  S RCLP=$O(^RCRP(340.5,RCIEN,2,RCLP)) Q:'RCLP  D
 .  .  S RCFB=$P($G(^RCRP(340.5,RCIEN,2,RCLP,0)),U,3)
 .  .  I RCFB S RCFBCT=RCFBCT+1
 .  ;
 .  ;find all of the payments paid, stop on the first unpaid.
 .  S RCLP=0 F  S RCLP=$O(^RCRP(340.5,RCIEN,2,RCLP)) Q:'RCLP  S RCPD=$P($G(^RCRP(340.5,RCIEN,2,RCLP,0)),U,2) Q:'RCPD 
 .  ;
 .  ; Count the new remaining payment out.
 .  S RCLP1=RCLP+RCFBCT+RCNEWLN-1   ;first missing payment + # Forborne months + new length of payment - 1 for the first missing payment)
 .  ;
 .  ; remove the remaining payments from schedule
 .  F  S RCLP1=$O(^RCRP(340.5,RCIEN,2,RCLP1)) Q:'RCLP1  D
 .  .  ;Do not remove payments forborne
 .  .  S RCFBFLG=+$P($G(^RCRP(340.5,RCIEN,2,RCLP1,0)),U,3)
 .  .  Q:RCFBFLG
 .  .  ;
 .  .  ; Remove the month from the schedule.
 .  .  S DA(1)=RCIEN,DA=RCLP1,DIK="^RCRP(340.5,"_DA(1)_",2,"
 .  .  D ^DIK
 .  .  K DA,DIK
 ;
 ;Otherwise, add new payments to schedule.
 ;Find the last date by looking for the last entry and grabbing the first piece.
 S RCORIEN=$O(^RCRP(340.5,RCIEN,2,"A"),-1)
 S RCSTDT=$P($G(^RCRP(340.5,RCIEN,2,RCORIEN,0)),U,1)
 D BLDPLN^RCRPU2(RCSTDT,(RCNEWLN-RCORLN),1,RCIEN)
 ;
 ; Add the new months to the Schedule
 ; Update the Schedule Node
 S RCSUB=0
 F  S RCSUB=$O(^TMP("RCRPP",$J,"PLAN",RCSUB)) Q:'RCSUB  D UPDSCHED^RCRPU(RCIEN,RCSUB)
 ;
 ;Clear temp array
 K ^TMP("RCRPP",$J)
 ;
 Q
 ;

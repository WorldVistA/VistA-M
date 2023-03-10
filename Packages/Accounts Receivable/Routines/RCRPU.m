RCRPU  ;EDE/SAB - REPAYMENT PLAN UTILITIES;11/16/2020  8:40 AM
 ;;4.5;Accounts Receivable;**377,381,388,378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETDBTR() ;Look up debtor by name or bill #
 N DIC,X,Y,DTOUT,DUOUT,RCOK,RCDBTR,RCDBTRN
 ;
 ;Reset screen to the top.
 ;
 ;Ask for Debtor Name
 S RCOK=0,RCDBTR=""
 F  D  Q:RCOK
 . R "Select DEBTOR NAME: ",X:DTIME
 . I X["^"!(X="") S RCOK=1,RCDBTR=""
 . S X=$$UPPER^VALM1(X)
 . S DIC="^RCD(340,",DIC(0)="EX" D ^DIC W !
 . I $D(DTOUT)!($D(DUOUT)) S RCOK=1,RCDBTR=0 Q
 . Q:+Y=-1
 . Q:'$$CORRECT(2)
 . S RCOK=1,RCDBTR=+Y
 I +RCDBTR,$P(Y,U,2)[";DPT" S RCDBTRN=$$GET1^DIQ(2,$P($P(Y,U,2),";")_",",.01,"E")
 Q RCDBTR_U_$G(RCDBTRN)  ;If looked up by debtor name
 ;
PRTACTS(RCCTS) ;Display accounts in ARR
 ; RCCTS - # of Active bills in active node of ^TMP("RCRPP).
 ;
 N RCI,RCDATA,RCBILLNO,RCAMT,RCDOS,RCSTAT,RCCAT,RCSTATN,RCCATN,QUIT
 ;initialize screen and exit variables.
 S QUIT=0
 ;
 D PRTHDR
 S RCTOT=0
 ; Loop through Active Node in the ^TMP("RCRPP") array.
 F RCI=1:1:RCCTS D  Q:QUIT
 . S RCDATA=$G(^TMP("RCRPP",$J,"ACTIVE",RCI))
 . S RCBILLNO=$P(RCDATA,U,2),RCAMT=$P(RCDATA,U,3),RCDOS=$P(RCDATA,U,4),RCSTAT=$P(RCDATA,U,5),RCCAT=$P(RCDATA,U,6)
 . S RCCATN=$P($G(^PRCA(430.2,RCCAT,0)),U,1),RCSTATN=$P($G(^PRCA(430.3,RCSTAT,0)),U,1)
 . S RCTOT=RCTOT+RCAMT
 . I $Y+3>IOSL D PAUSE,PRTHDR W ! S $Y=0 I QUIT Q
 . W RCI,?5,RCBILLNO,?24,$E(RCCATN,1,24),?50,$$MDY(RCDOS,"-"),?61,RCSTATN,?70,"$",$J(RCAMT,8,2),!
 F X=1:1:(IOM-1) W "="
 W !,?55,"TOTAL OWED:",?70,"$",$J(RCTOT,8,2),!
 I QUIT Q 0
 W !
 Q
 ;
PRTHDR() ;  Print the header for account listing
 ;
 W !,?50,"DATE OF",?70," AMOUNT",!
 W "No.",?5,"BILL NO.",?24,"AR CATEGORY",?50,"SERVICE",?61,"STATUS",?70,"OWED ($)",!
 F X=1:1:(IOM-1) W "-"
 W !
 Q
 ;
GETACTS(RCDBTR) ;Find all active accounts for a debtor
 ;Input:
 ; RCDBTR  - Pointer to #340
 ;
 ; Returns: ARRAY(COUNTER,PRCABN)=BILL IEN (FILE 430)^BILL#^BALANCE DUE^DOS^STATUS^CATEGORY
 ;
 N RCSTAT,RCBILL,RCAMT,RCBILLNO,RCCAT,RCCS,RCDOS
 N D0,D7,D1,D4,RCACT,RCCSCT,RCEXIT
 S (RCACT,RCCSCT)=0       ;init counters
 S RCSTAT=+$O(^PRCA(430.3,"AC",102,0))     ; get active status ien
 S RCBILL=0 F  S RCBILL=$O(^PRCA(430,"AS",RCDBTR,RCSTAT,RCBILL)) Q:'RCBILL  D
 . S D0=$G(^PRCA(430,RCBILL,0))    ;General bill info
 . S D1=$G(^PRCA(430,RCBILL,1))    ;ELIG for RPP flag
 . S D4=$G(^PRCA(430,RCBILL,4))    ;Repayment Plan info in Bill
 . S D7=$G(^PRCA(430,RCBILL,7))    ;Remaining Balance info for bill
 . S RCAMT=$S(+D7:$P(D7,U,1)+$P(D7,U,2)+$P(D7,U,3)+$P(D7,U,4)+$P(D7,U,5),1:$P(D0,U,3))
 . S RCDOS=$P(D0,U,10)
 . S RCBILLNO=$P(D0,U,1),RCCAT=$P(D0,U,2)
 . ;
 . ;If the bill is already in a plan, then skip over adding it to list.
 . I ($P(D4,U,5)>0) Q
 . ;
 . ;If Bill has an AR Category that is not eligible (field 1.06 in the AR Cat file (430.2)
 . ;to be on a Repayment Plan, stop and get the next bill 
 . Q:'$$GET1^DIQ(430.2,RCCAT_",",1.06,"I")
 . ;
 . S RCCS=0
 . S:$D(^PRCA(430,"TCSP",RCBILL)) RCCS=1 ;Bill is in cross-servicing
 . S:+$G(^PRCA(430,RCBILL,12)) RCCS=2    ;Bill is in DMC
 . ;Disable TOP exclusion for now.
 . ;S:+$G(^PRCA(430,RCBILL,14)) RCCS=3    ;Bill is in TOP
 . ; If bill not in CS, add to Active Queue
 . I 'RCCS D  Q
 . . S RCACT=RCACT+1
 . . S ^TMP("RCRPP",$J,"ACTIVE",RCACT)=RCBILL_U_RCBILLNO_U_RCAMT_U_RCDOS_U_RCSTAT_U_RCCAT
 . ; If bill in CS, add to CS queue
 . S RCCSCT=RCCSCT+1
 . S ^TMP("RCRPP",$J,"CS",RCCSCT)=RCBILL_U_RCBILLNO_U_RCAMT_U_RCDOS_U_RCSTAT_U_RCCAT_U_RCCS
 Q RCACT_U_RCCSCT
 ;
MDY(DATE,DEL) ;Return date format of mm-dd-yy
 ; DATE - Date in FileMan format
 ; DEL - Delimiter used to separate month, day, year
 ;
 ; Returns: Date in mmddyy format delimited by DEL
 N %DT,X,Y
 S X=$G(DATE),DEL=$S($G(DEL)="":"-",1:DEL),%DT="T"
 D ^%DT S DATE=Y S:Y<0 DATE="0000000"
 Q $E(DATE,4,5)_DEL_$E(DATE,6,7)_DEL_$E(DATE,2,3)
 ;
PAUSE    ;Press Return to Continue
 N DIR,DUOUT,DTOUT,DIRUT
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S QUIT=1
 W !
 Q
 ;
GETBILLS(RCCTS) ;Select the bills to add to the plan
 ; RCCTS - The upper limit that can be chosen
 ;
 ; This function will eliminate duplicates and return choices in numerical error
 ; regardless of input order.
 ;
 ; Returns: All bills select flag ^ comma delimited list of pointers to file #430 in ascending date order
 ;
 N DIR,X,Y,DTOUT,DUOUT
 N RCOK,RCPC,RCLIST,RCSTR,RCCNT,RCERR,RCJ,RCFIRST,RCLAST,RCI,RCRPBILL,RCALLFLG
 ;
 S (RCOK,RCALLFLG)=0
 F RCCNT=1:1 I 'RCOK D  Q:RCOK
 . K RCSTR S RCERR=""
 . I RCCTS>1 W "   Select bills using the following formats: (A)ll or (N)one or 1,2,3 and/or 1-3",!
 . S DIR(0)="FO^^"
 . S DIR("A")="Choose Bills to Add to Repayment Plan: "
 . S DIR("B")="ALL"
 . S DIR("?")="Select bills using the following formats: (A)ll or (N)one or 1,2,3 and/or 1-3"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S RCLIST="",RCOK=1,RCEXIT=1 Q
 . S X=$$UPPER^VALM1(X)
 . I $E("NONE",1,$L(X))=X S RCLIST="",RCOK=1,RCEXIT=1 Q
 . I $E("ALL",1,$L(X))=X D  Q
 .. F RCI=1:1:RCCTS S RCSTR(RCI)=""
 .. S (RCOK,RCALLFLG)=1
 . F RCI=1:1:$L(X,",") S RCPC=$P(X,",",RCI) D  Q:RCERR]""
 .. I RCPC'?1.N,RCPC'?1.N1"-"1.N S RCERR="Invalid response" Q
 .. I RCPC'>0!(RCPC>RCCTS) S RCERR="Number out of range" Q
 .. I RCPC?1.N,RCPC>0,RCPC'>RCCTS S RCSTR(RCPC)="" Q
 .. I RCPC?1.N1"-"1.N D  Q:RCERR]""
 ... S RCFIRST=$P(RCPC,"-",1),RCLAST=$P(RCPC,"-",2)
 ... I RCFIRST'>0!(RCFIRST>RCCTS)!(RCLAST'>0)!(RCLAST>RCCTS) S RCERR="Number out of range" Q
 ... I RCFIRST>0,RCFIRST'>RCCTS,RCLAST>0,RCLAST'>RCCTS F RCJ=RCFIRST:1:RCLAST S RCSTR(RCJ)=""
 . I RCERR="" S RCOK=1 Q
 . S RCOK=0 W "  "_RCERR,!
 S RCI=0,RCLIST=""
 F  S RCI=$O(RCSTR(RCI)) Q:RCI=""  D
 . S RCLIST=RCLIST_$S(RCLIST="":"",1:",")_RCI
 . S RCRPBILL=$P($G(^TMP("RCRPP",$J,"ACTIVE",RCI)),U)
 . S ^TMP("RCRPP",$J,"BILLS",RCRPBILL)=""
 Q RCALLFLG_U_RCLIST
 ;
TOT(RCBLCH) ;  calculate the total amount into the Repayment Plan.
 ;
 N RCLN,RCTOT,RCI
 ;
 ;Find # of bills to sum up.
 S RCLN=$L(RCBLCH,","),RCTOT=0
 ;
 ;Calculate the total
 F RCI=1:1:RCLN D
 . S RCTOT=RCTOT+$P($G(^TMP("RCRPP",$J,"ACTIVE",$P(RCBLCH,",",RCI))),U,3)
 ;
 ; Display total, confirm with user, and exit
 W !,"Total Amount chosen is $",$J(RCTOT,8,2),!
 Q $$CORRECT_U_RCTOT
 ;
CORRECT(RCTYPE) ;Are you sure this is correct?
 ; Input: (Optional) Prompt to display
 ; Return: 1 for Yes
 ;         0 for No
 ;
 N DIR,X,Y,RCPROMPT
 S RCTYPE=$G(RCTYPE)
 I RCTYPE="" S RCTYPE=1
 S RCPROMPT="Is this correct"
 I RCTYPE=2 S RCPROMPT="Is this the correct Debtor"
 I RCTYPE=3 S RCPROMPT="Are you sure you wish to Close this plan"
 S DIR(0)="Y",DIR("B")="YES",DIR("A")=RCPROMPT_"? (Y/N) "
 D ^DIR
 W !
 Q Y
 ;
GETDET(RCBLCH,RCTOT,RCDBTR,RCAUTO) ;Finish Gathering the details and File
 ;
 ; RCBLCH - list of bills in plan.
 ; RCTOT - Amount due from selected bills
 ; RCDBTR - Debtor IEN^Debtor Name
 ; RCAUTO - auto-add flag
 ; Returns: 1 if completed
 ;
 N RCPLN,RCSTDT,RCDAY,RCCRDT,RCSVFLG
 ;
 ;Get site and # of RPP for the Debtor
 S RCRPID=$$GETID(+RCDBTR)
 Q:RCRPID=0 0
 ;
 ;Get Amount^# Payments
 S RCPLN=$$GETPLN(RCDBTR,RCTOT)
 Q:+RCPLN=0 0
 ;
 ;Set the Creation date and Start date. Build the plan schedule
 S RCCRDT=$$DT^XLFDT
 S RCSTDT=$$GETSTART(RCCRDT)
 D BLDPLN(RCSTDT,$P(RCPLN,U,2))
 ;
 ;Set the day of the month a payment is due to the 28th
 S RCDAY=28
 S RCSVFLG=$$RPDIS($P(RCDBTR,U,2),RCPLN,RCSTDT,RCCRDT,RCTOT)
 I 'RCSVFLG D  Q 0
 . W !,"Repayment Plan not Saved.",!
 . D PAUSE
 ;
 ;Save the plan
 S RCSVFLG=$$SAVEPLAN(+RCDBTR,RCRPID,RCPLN,RCCRDT,RCDAY,RCSTDT,RCTOT,RCAUTO)
 ;
 Q RCSVFLG
 ;
RPDIS(RCDBTR,RCPLN,RCSTDT,RCCRDT,RCTOT) ;Display Repayment Plan
 ;
 W !,"Summary of the Created Repayment Plan for AR Debtor: ",RCDBTR,!
 W "--------------------------------------------------------------------------------",!
 W "Monthly Repayment Amount:",?32,"$",$J($P(RCPLN,U),0,2)
 W ?45,"Number of Payments:",?72,$P(RCPLN,U,2),!
 W "Date Plan Created:",?32,$$FMTE^XLFDT(RCCRDT,2)
 W ?45,"Due Date of First Payment:",?72,$$FMTE^XLFDT(RCSTDT,2),!
 W "Total Amount of Bills in Plan:",?32,"$",$J(RCTOT,0,2),!
 W "--------------------------------------------------------------------------------",!
 Q $$CORRECT()
 ;
GETID(RCDBTR) ; Get the Site and # Plans for a debtor
 ;
 N RCSITEID,RCI,RCCT
 ;
 S RCSITEID=$P($$SITE^VASITE(),U)
 S RCCT=0,RCI=0
 F  S RCI=$O(^RCRP(340.5,"E",RCDBTR,RCI)) Q:RCI=""  S RCCT=RCCT+1
 ;
 ;Add 1 for new plan and add leading 0's
 S RCCT=RCCT+1,RCCT="00"_RCCT,RCCT=$E(RCCT,$L(RCCT)-1,$L(RCCT))
 ;
 Q RCSITEID_"-RPP-"_RCCT_"-"
 ;
GETPLN(RCDBTR,RCTOT,RCEDIT) ; Get the amount due and length of plan 
 ;Repayment amount
 ;INPUT RCTOT - Total $ amount of bills in plan
 ;      RCEDIT - (Optional) 1 - Editing a Plan
 ;                          NULL or 0 - Entering a new plan.  
 ;Returns Amount^# PAYMENTS or 0
 N DIR,X,Y,DIRUT
 N RCAMT,RCPAY,RCOK,QUIT,RCSPFLG
 ;
 S RCEDIT=$G(RCEDIT)
 S DIR(0)="NA^.01:999999:2"
 S DIR("A")=$S('RCEDIT:"",1:"New ")_"Monthly Payment Amount: "
 S DIR("?")="This is the amount the debtor will pay each month"
 S RCOK=0,QUIT=0 F  D  Q:RCOK!(QUIT)
 . S RCAMT=0
 . D ^DIR
 . I $D(DIRUT) S RCOK=1 Q
 . S RCAMT=+Y
 . ;If amount < 25, Supervisor approval needed, re-ask otherwise
 . I RCAMT<25 D  Q:RCSPFLG'=1
 . . S RCSPFLG=$$SUPAPPR(RCDBTR,1)
 . . Q:RCSPFLG'=1
 . . S ^TMP("RCRPP",$J,"SUP25")=1   ;Store the approval for an audit log later
 . ;continue
 . S RCPAY=RCTOT\RCAMT I RCTOT#RCAMT>0 S RCPAY=RCPAY+1
 . W !!,"Number of Payments will be ",RCPAY,!
 . I RCPAY>60 D  Q
 . . W !,"The number of payments cannot exceed 60. Please re-enter the payment amount.",!
 . I RCPAY>36 D  Q:RCSPFLG'=1
 . . W !,"The number of payments exceeds 36 payments.",!
 . . S RCSPFLG=$$SUPAPPR(RCDBTR,2)
 . . Q:RCSPFLG'=1
 . . S ^TMP("RCRPP",$J,"SUP36")=1   ;Store the approval for an audit log later
 . . D PAUSE
 . S RCOK=1
 I $D(DIRUT) Q 0
 I QUIT Q 0
 ;
 Q RCAMT_U_RCPAY
 ;
GETSTART(RCCRDT) ; Calculate the start date .
 ;
 ; This routine calculates the start date to be a minimum
 ; of 45 days after the creation date, and then finds the
 ; 28th of the month.
 ;
 N RCSTDT,RCSTYR,RCSTMN,RCSTDY,RES
 ;
 ;Calculate a minimum of 45 days
 S RCSTDT=$$FMADD^XLFDT(RCCRDT,45)
 ;
 S RCSTYR=$E(RCSTDT,1,3)
 S RCSTMN=$E(RCSTDT,4,5)
 S RCSTDY=$E(RCSTDT,6,7)
 ;
 ;If the day calculated is the 28th, return the date.
 I RCSTDY=28 S RES=RCSTDT
 ;
 ;Find the next 28th.
 ; If day <28 move to the 28th and quit
 I RCSTDY<28 S RES=RCSTYR_RCSTMN_28
 ;
 ;If start day needs to move into the next month, then add the necessary days and return the new date.
 I RCSTDY>28 D
 .S RCSTMN=RCSTMN+1
 .I RCSTMN<10 S RCSTMN="0"_RCSTMN
 .I RCSTMN>12 S RCSTMN="01",RCSTYR=RCSTYR+1
 .S RES=RCSTYR_RCSTMN_28
 .Q
 ;
 I RES<3211028 S RES=3211028  ; if calculated date is prior to 10/28/21, set it to 10/28/21
 Q RES
 ;
SUPAPPR(RCDBTR,RCTXTFLG) ;  Confirm Supervisor approval, file Debtor Comment for Supervisor Approval
 ;
 N DIR,X,Y,RCPROMPT
 S RCTYPE=$G(RCTYPE)
 S DIR(0)="Y"
 I RCTXTFLG=1 S DIR("A")="Has your Supervisor approved this amount? (Y/N) "
 I RCTXTFLG=2 S DIR("A")="Has your Supervisor approved the number of payments? (Y/N) "
 D ^DIR
 I +Y<1 Q -1
 ;
 Q 1
 ;
SAVEPLAN(RCDBTR,RCRPID,RCPLN,RCCRDT,RCDAY,RCSTDT,RCTOT,RCAUTO) ; Save the repayment plan details
 ;
 N FDA,FDAIEN,IENS,LIEN,RCRPIEN,RCSUB,RCRPIEN,RCIEN
 ;
 ;Lock the file to grab the Next IEN to construct the RPP ID before filing.
 ;
 L +^RCRP(340.5):5 I '$T W !,"Another user is creating a Repayment Plan.  Please try again later."  L -^RCRP(340.5) Q -1
 S RCIEN=$P($G(^RCRP(340.5,0)),U,3)+1,RCIEN="000000"_RCIEN
 ;
 S RCRPID=RCRPID_$E(RCIEN,$L(RCIEN)-5,$L(RCIEN))
 S IENS="+1,"
 S FDA(340.5,IENS,.01)=RCRPID         ;Plan ID
 S FDA(340.5,IENS,.02)=RCDBTR         ;Debtor
 S FDA(340.5,IENS,.03)=RCCRDT         ;Creation Date
 S FDA(340.5,IENS,.04)=RCSTDT         ;Start Date
 S FDA(340.5,IENS,.05)=$P(RCPLN,U,2)  ;Length (# payments)
 S FDA(340.5,IENS,.06)=$P(RCPLN,U,1)  ;Amount Per Month
 S FDA(340.5,IENS,.07)=1              ;Status (NEW on creation)
 S FDA(340.5,IENS,.08)=RCCRDT         ;Status Date
 S FDA(340.5,IENS,.11)=RCTOT          ;Total amount due in plan.
 S FDA(340.5,IENS,.12)=RCAUTO         ;Auto-add bills PRCA*4.5*378
 S FDA(340.5,IENS,.13)=RCTOT          ;Store total as original amount as well
 S FDA(340.5,IENS,.14)=$P(RCPLN,U,2)  ;Store Length as original # payments as well
 ;
 ; first parameter is currently "" so internal it is for now
 D UPDATE^DIE("","FDA","FDAIEN","RETURN")
 L -^RCRP(340.5)
 ;
 S RCRPIEN=FDAIEN(1)
 ;
 ;Update the Audit Log
 D UPDAUDIT^RCRPU2(RCRPIEN,RCCRDT,"N","N")
 ;
 ;Update Audit Log with Supervisor Approvals, if any.
 D:$G(^TMP("RCRPP",$J,"SUP25")) UPDAUDIT^RCRPU2(RCRPIEN,RCCRDT,"N","SA")
 D:$G(^TMP("RCRPP",$J,"SUP36")) UPDAUDIT^RCRPU2(RCRPIEN,RCCRDT,"N","SM")
 ;
 ;Update the Schedule Node
 S RCSUB=0
 F  S RCSUB=$O(^TMP("RCRPP",$J,"PLAN",RCSUB)) Q:'RCSUB  D UPDSCHED(RCRPIEN,RCSUB)
 ;
 ;Update Debtor file
 D UPDDBTR(RCRPIEN,RCDBTR)
 ;
 ;Update the Bills in file 430 and file transactions for each bill included,
 ;then update the Bill node in the Repayment Plan
 S RCSUB=0
 F  S RCSUB=$O(^TMP("RCRPP",$J,"BILLS",RCSUB)) Q:'RCSUB  D 
 . D ADDPLAN(RCRPIEN,RCSUB,RCCRDT)  ;Update the Bills and the Transaction file
 . D UPDBILL(RCRPIEN,RCSUB)  ;Update the Bill Node in the RPP
 ;
 ;PRCA*4.5*381
 ;If bills referral to CS was detected, updated AT CS field (#1.04)
 I $D(^TMP("RCRPP",$J,"CS")) D UPDATCS^RCRPU2(RCRPIEN,1,1)
 ;
 W !,"The Repayment Plan "_RCRPID_" has been established.",!!
 ;
 ;Update the Metrics File
 D UPDMET^RCSTATU(1.07,1)
 ;
 D PAUSE
 ;
 Q 1
 ;
UPDSCHED(RCRPIEN,RCSUB)  ; Add a month to the schedule in the RPP file (#340.5)
 ;
 N DA,DD,DIC,DLAYGO,DO,DR
 S DLAYGO=340.5,DA(1)=RCRPIEN,DIC(0)="L",X=RCSUB,DIC="^RCRP(340.5,"_DA(1)_",2,"
 D FILE^DICN
 Q
 ;
UPDDBTR(RCRPIEN,RCDBTR)  ; Add a Plan to the Debtor file (#340)
 ;
 N DA,DD,DIC,DLAYGO,DO,DR
 S DLAYGO=340,DA(1)=RCDBTR,DIC(0)="L",X=RCRPIEN,DIC="^RCD(340,"_DA(1)_",9,"
 D FILE^DICN
 Q
 ;
UPDBILL(RCRPIEN,RCBILLDA)  ; Add a new bill to the Bill Node in the RPP file (#340.5)
 ;
 N DA,DD,DIC,DLAYGO,DO,DR
 S DLAYGO=340.5,DA(1)=RCRPIEN,DIC(0)="L",X=RCBILLDA,DIC="^RCRP(340.5,"_DA(1)_",6,"
 D FILE^DICN
 Q
 ;
REMBILL(RCRPIEN,RCBILLDA) ; remove bill from sub-file 340.5
 ;
 ; RCRPIEN - file 340.5 ien
 ; RCBILLDA - file 430 ien (bill to remove)
 ;
 N DA,DIK
 I RCRPIEN'>0!(RCBILLDA'>0) Q
 S DA=$O(^RCRP(340.5,RCRPIEN,6,"B",RCBILLDA,"")) Q:DA'>0
 S DA(1)=RCRPIEN
 S DIK="^RCRP(340.5,"_DA(1)_",6,"
 D ^DIK
 Q
 ;
BLDPLN(RCSTDT,RCLEN,RCSTFLG) ; Build the Payment Schedule
 ;INPUT - RCSTDT  - Initial proposed start date
 ;        RCLEN   - Total Number of months
 ;        RCSTFLG - (Optional) Flag to indicate if Start Date should be included in payment schedule
 ; 
 N RCMNARY,RCSTART,RCMONTH,RCYEAR,RCCOUNT,RCDATE
 ;
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
 .  S RCMNARY(RCDATE)=""
 M ^TMP("RCRPP",$J,"PLAN")=RCMNARY
 Q
 ;
UPDPAYST(RCRPID) ;Update the Paid flag in the Schedule Multiple
 ;
 N RCD0,RCNOPY,RCAMTMN,RCAMT,RCLOOP,RCTOTPD,RCDL,RCAMTPD,RCCMP
 ;
 ;Calc total payments
 S RCD0=$G(^RCRP(340.5,RCRPID,0))
 S RCNOPY=$P(RCD0,U,5),RCAMTMN=$P(RCD0,U,6),RCAMT=$P(RCD0,U,11)
 ;
 ;Calc amount received (Payments Node)
 S RCLOOP=0,RCTOTPD=0
 F  S RCLOOP=$O(^RCRP(340.5,RCRPID,3,RCLOOP)) Q:RCLOOP=""  D
 . S RCDL=$G(^RCRP(340.5,RCRPID,3,RCLOOP,0))
 . S RCAMTPD=$P(RCDL,U,2),RCTOTPD=RCTOTPD+RCAMTPD
 ;
 ;Determine # payments completed
 S RCCMP=RCTOTPD\RCAMTMN
 ;
 ;If the total paid = total amount owed, add a month to the # payments completed
 ; (as the final month owed is not the full monthly amount) and change the status of the
 ; plan to Paid in Full.
 I RCAMT=RCTOTPD D
 . S RCCMP=RCCMP+1
 . D UPDSTAT^RCRPU1(RCRPID,8)
 ;
 ;Review and update the payment node (Schedule Node)
 D UPDPAID^RCRPU1(RCRPID,RCCMP)
 Q
 ;
ADDPLAN(RCRPIEN,RCBILLDA,RCCRDT) ;Record the Plan info into each bill and to the Transaction file.
 ; Input:  RCRPIEN -  IEN of the Repayment Plan (from file #340.5)
 ;         RCBILLDA - IEN of the Bill to add the plan to
 ;         RCCRDT -  Date to add to the plan.
 ;
 N X,Y,DIC,DIE,DR,RCAMT,PRCA
 ;Store the RPP IEN into the AR file (#430) AR Repayment Plan (#45) field. 
 S (DIC,DIE)="^PRCA(430,",DA=RCBILLDA,DR="41////"_RCCRDT_";45////"_RCRPIEN
 S PRCA("LOCK")=0 D LOCKF^PRCAWO1 D:PRCA("LOCK")=0 ^DIE
 K DA,DIC,DIE,DR
 ;get the current amount owed.
 S RCAMT=$P($G(^PRCA(430,RCBILLDA,7)),U)
 ;File a Transaction into the Transaction file.
 D TRAN(RCBILLDA,RCAMT,16)
 Q
 ;
TRAN(RCBILLDA,RCAMT,RCTRANS) ;File plan add transaction in 433
 N DIE,DA,DR,PRCAEN,PRCAKTY
 S PRCAKTY=$O(^PRCA(430.3,"AC",RCTRANS,""))
 S PRCAEN=-1 D SETTR^PRCAUTL Q:PRCAEN<0  S DA=PRCAEN
 S DIE="^PRCA(433,",DR=".03////"_RCBILLDA_";11///"_DT_";12///"_PRCAKTY_";15///0" D ^DIE
 S $P(^PRCA(433,PRCAEN,0),U,4)=2
 Q
 ;
CHKACT(RCDBTR) ;Check to see if the Debtor has an Active Repayment Plan.
 ;
 ;INPUT - RCDBTR - Debtor to check
 ;Return:  0 if no Active Plans, 1 if an Active Plan (non Terminated, closed, or Paid in Full plans)
 ;
 N RCACTV,RCLOOP,RCSTATUS,RCDATA
 ;
 S RCACTV=0
 ;
 S RCLOOP=0
 F  S RCLOOP=$O(^RCRP(340.5,"E",RCDBTR,RCLOOP)) Q:'RCLOOP  D  Q:RCACTV
 .  S RCDATA=$G(^RCRP(340.5,RCLOOP,0)),RCSTATUS=$P(RCDATA,U,7)
 .  I RCSTATUS<6 S RCACTV=1_U_RCLOOP  ;Active Plan
 Q RCACTV   ;No active plan
 ;
GETNXTPY(RCRPID) ; Retrieve the next payment due date
 ;
 ;Input - RCRPID - Repayment Plan IEN
 ;Output - Date of Next Repayment Plan Payment.
 ;
 N RCNXTDT,RCLOOP,RCDONE,RCDATA,RCPAID,RCFOR
 ;
 S RCLOOP="",RCDONE=0
 ;Loop through the Schedule Multiple.  Locate the next payment due.
 F  S RCLOOP=$O(^RCRP(340.5,RCRPID,2,RCLOOP)) Q:RCLOOP=""  D  Q:RCDONE
 . S RCDATA=$G(^RCRP(340.5,RCRPID,2,RCLOOP,0))
 . Q:RCDATA=""
 . S RCNXTDT=$P(RCDATA,U),RCPAID=$P(RCDATA,U,2),RCFOR=$P(RCDATA,U,3)
 . I 'RCPAID,'RCFOR S RCDONE=1
 ;Return the Payment Due date.
 Q RCNXTDT
 ;
GETPLANS(RCDBTR) ; Get a list of Repayment Plans for a debtor.
 ;
 ;INPUT - RCDBTR - Debtor to check
 ;Return:  0 if no Active Plans, 1 if an Active Plan (non Terminated, closed, or Paid in Full plans)
 ;
 N RCACTV,RCLOOP,RCPLNS
 ;
 S RCPLNS=0
 ;
 S RCLOOP=0
 F  S RCLOOP=$O(^RCRP(340.5,"E",RCDBTR,RCLOOP)) Q:'RCLOOP  D
 .  S RCPLNS=RCPLNS+1  ;Active Plan
 .  S ^TMP("RCRPP",$J,"PLANS",RCPLNS)=RCLOOP_U_$G(^RCRP(340.5,RCLOOP,0))
 Q RCPLNS   ;No active plan

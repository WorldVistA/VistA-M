PRCARPU  ;ALB/DRF-CREATE MULTIPLE ACCOUNT REPAYMENT DATE SCHEDULE FUNCTIONS;08/09/2016  4:40 PM
 ;;4.5;Accounts Receivable;**315,340**;Mar 20, 1995;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
DEBTOR() ;Look up debtor by name or bill #
 N DIC,X,Y,DEBT,DEBTOR,DIC,PRCADB,DTOUT,DUOUT
 W @IOF
 W "Enter/Edit Repayment Plan",!!
 R "Select DEBTOR NAME or BILL NUMBER: ",X:DTIME
 I X["^"!(X="") Q ""
 S X=$$UPPER^VALM1(X)
 S Y=$S($O(^PRCA(430,"B",X,0)):$O(^(0)),$O(^PRCA(430,"D",X,0)):$O(^(0)),1:-1)
 I Y>0 S DEBT=$P($G(^PRCA(430,Y,0)),"^",9) I DEBT D  Q DEBT  ;If found by bill number
 . S PRCADB=$P($G(^RCD(340,DEBT,0)),"^")
 . S ^DISV(DUZ,"^RCD(340,")=DEBT
 . S $P(DEBT,"^",2)=$$NAM^RCFN01(DEBT)
 S DIC="^RCD(340,",DIC(0)="EX" D ^DIC W ! I Y<0 Q 0
 I $D(DTOUT)!($D(DUOUT)) Q 0
 S ^DISV(DUZ,"^RCD(340,")=+Y,PRCADB=$P(Y,"^",2),DEBTOR=+Y_"^"_$P(@("^"_$P(PRCADB,";",2)_+PRCADB_",0)"),"^")
 Q DEBTOR  ;If looked up by debtor name
 ;
ACCOUNTS(DEBTOR,ARRALL,ARRPLN,ARRNON,ACT) ;Find all active accounts for a debtor
 ; DEBTOR  - Pointer to #340
 ; ARRALL  - Name of array (passed by reference) that holds all the accounts for this debtor
 ;   Ordered by date in the format ARRAY(1,xxxxxxx)="",ARRAY(2,xxxxxx)=""...
 ; ARRPLN  - Name of array (passed by reference) that holds the accounts for this debtor
 ;   that are part of a current payment plan
 ;   Ordered by date in the format ARRAY(1,xxxxxxx)="",ARRAY(2,xxxxxx)=""...
 ;   Check for ARRPLN>0 to see if there is an existing plan for this debtor
 ; ARRNON  - Name of array (passed by reference) that holds the accounts for this debtor
 ;   that are NOT part of a current payment plan
 ;   Ordered by date in the format ARRAY(1,xxxxxxx)="",ARRAY(2,xxxxxx)=""...
 ; ACT     - Variable that tracks the number of active accounts for the debtor. ARRALL displays
 ;   Cross-Serviced accounts, but they are not active for the purposes of repayment plans
 ;
 ; Returns: ARRAY(COUNTER,PRCABN)=BILL#^PART OF A PAYMENT PLAN=1^IN CROSS SERVICING=1^BALANCE DUE^DOS^STATUS^CATEGORY^PLAN DATE
 ;
 N AMT,BILL,CS,D0,D4,D7,DOS,PLNDT,PP,PRCABN,PRCAT,PRCS15,STAT
 K ARRALL,ARRPLN,ARRNON,ACT
 S (ARRALL,ARRPLN,ARRNON,ACT)=0
 S STAT=+$O(^PRCA(430.3,"AC",102,0))     ; get active status iens
 S PRCABN=0 F  S PRCABN=$O(^PRCA(430,"AS",DEBTOR,STAT,PRCABN)) Q:'PRCABN  D
 . S D0=$G(^PRCA(430,PRCABN,0))
 . S D4=$G(^PRCA(430,PRCABN,4)),D7=$G(^PRCA(430,PRCABN,7))
 . S AMT=$S(+D7:$P(D7,U,1)+$P(D7,U,2)+$P(D7,U,3)+$P(D7,U,4)+$P(D7,U,5),1:$P(D0,U,3)),DOS=$P(D0,U,10)
 . S BILL=$P(D0,U,1),PRCAT=$P(D0,U,2),PLNDT=$P(D4,U,1)
 . S PP=0 I PLNDT]"" S PP=1 ;Part of a payment plan?
 . S CS=0 I $D(^PRCA(430,"TCSP",PRCABN)) S CS=1 ;Bill is in cross-servicing
 . I 'CS S ACT=ACT+1
 . I ARRALL]"" S ARRALL=ARRALL+1,ARRALL(ARRALL,PRCABN)=BILL_U_PP_U_CS_U_AMT_U_DOS_U_STAT_U_PRCAT_U_PLNDT
 . I PP,ARRPLN]"" S ARRPLN=ARRPLN+1,ARRPLN(ARRPLN,PRCABN)=BILL_U_PP_U_CS_U_AMT_U_DOS_U_STAT_U_PRCAT_U_PLNDT Q
 . I 'PP,ARRNON]"" S ARRNON=ARRNON+1,ARRNON(ARRNON,PRCABN)=BILL_U_PP_U_CS_U_AMT_U_DOS_U_STAT_U_PRCAT Q
 Q
 ;
DISPLAY(ARR,NUM,QUIT) ;Display accounts in ARR
 ; ARR - An array of bills
 ; NUM - Display selection numbers in left column (defaults to no (0))
 ; QUIT - User requests exit = 1, default = 0
 ;
 N AMT,BILL,CS,CSMSG,DOS,I,PLN,PLNMSG,PRCABN,PRCAT,PRCATN,STAT,STATN,TAMT,Y
 S NUM=+$G(NUM)
 S TAMT=0,PLNMSG=0,CSMSG=0,QUIT=0
 F I=1:1:ARR D  Q:QUIT
 . S PRCABN=$O(ARR(I,0)),BILL=$P(ARR(I,PRCABN),U,1),PLN=$P(ARR(I,PRCABN),U,2),CS=$P(ARR(I,PRCABN),U,3)
 . S AMT=$P(ARR(I,PRCABN),U,4),DOS=$P(ARR(I,PRCABN),U,5),STAT=$P(ARR(I,PRCABN),U,6),PRCAT=$P(ARR(I,PRCABN),U,7)
 . I $G(CS)=0 S TAMT=TAMT+AMT
 . I PLN,'PLNMSG S PLNMSG=1
 . I CS,'CSMSG S CSMSG=1
 . S PRCATN=$P($G(^PRCA(430.2,PRCAT,0)),U,1),STATN=$P($G(^PRCA(430.3,STAT,0)),U,1)
 . I $Y+3>IOSL S $Y=0 D PAUSE W ! I QUIT Q
 . W $S(NUM:I,1:""),?5,BILL,$S(PLN:"**",CS:"#",1:""),?24,PRCATN,?50,$$MDY(DOS,"-"),?61,STATN,?70,"$",$J(AMT,8,2),!
 I QUIT Q 0
 W !
 I PLNMSG W "** Bill is currently in Repayment Plan",!
 I CSMSG W "# Bill is currently in Cross Servicing",!
 Q TAMT
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
SELECT(ARR) ;Select items up to number ARR
 ; ARR - The upper limit that can be chosen
 ; This function will eliminate duplicates and return choices in numerical error
 ; regardless of input order.
 ; Returns: comma delimited list of pointers to file #430 in ascending date order
 ;
 N CNT,DIR,ERR,FIRST,I,J,LAST,LIST,OK,PC,PRCABN,STR,X,Y
 S OK=0 F CNT=1:1 I 'OK D  Q:OK
 . I CNT>1 W "   Select bills using the following formats:(A)ll or (N)one or 1,2,3 and/or 1-3",!
 . S DIR(0)="FO^^"
 . S DIR("A")="Choose Bills to Add to Repayment Plan: "
 . S DIR("B")="ALL"
 . S DIR("?")="Select bills using the following formats:(A)ll or (N)one or 1,2,3 and/or 1-3"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S LIST="",OK=1 Q
 . S X=$$UPPER^VALM1(X)
 . I $E("NONE",1,$L(X))=X S LIST="",OK=1 Q
 . K STR S ERR=""
 . I $E("ALL",1,$L(X))=X D  Q:OK
 .. F I=1:1:ARR S STR(I)=""
 .. S OK=1
 . F I=1:1:$L(X,",") S PC=$P(X,",",I) D  Q:ERR]""
 .. I PC'?1.N,PC'?1.N1"-"1.N S ERR="Invalid response" Q
 .. I PC'>0!(PC>ARR) S ERR="Number out of range" Q
 .. I PC?1.N,PC>0,PC'>ARR S STR(PC)="" Q
 .. I PC?1.N1"-"1.N D  Q:ERR]""
 ... S FIRST=$P(PC,"-",1),LAST=$P(PC,"-",2)
 ... I FIRST'>0!(FIRST>ARR)!(LAST'>0)!(LAST>ARR) S ERR="Number out of range" Q
 ... I FIRST>0,FIRST'>ARR,LAST>0,LAST'>ARR F J=FIRST:1:LAST S STR(J)=""
 . I ERR="" S OK=1 Q
 . S OK=0 W "  "_ERR,!
 S I=0,LIST="" F  S I=$O(STR(I)) Q:I=""  D
 . S PRCABN=$O(ARR(I,0))
 . I $P(ARR(I,PRCABN),U,3) W !,I_". "_$P(ARR(I,PRCABN),U,1)_" is in Cross Servicing" Q
 . I $P(ARR(I,PRCABN),U,2) W !,I_". "_$P(ARR(I,PRCABN),U,1)_" is in a Payment Plan" Q
 . S LIST=LIST_$S(LIST="":"",1:",")_I
 Q LIST
 ;
RPDIS(DEBTOR,PLN) ;Display Repayment Plan
 ; DEBTOR  - Pointer to #340
 ; PLN - An array of bills
 ;
 D PLNDTL(.PLN)
 W !,"Summary of Current Repayment Plan for AR Debtor: ",$P(DEBTOR,U,2),!
 W "------------------------------------------------------------------",!
 W "Monthly Repayment Amount:",?32,"$",$J(PLNAMT,0,2)
 W ?45,"Day of Month Payment Due:",?72,PLNDAY,!
 W "Number of Payments Remaining:",?32,PLNRMN
 W ?45,"Due Date of First Payment:",?72,PLNFRST,!
 W "Current Total Due:",?32,"$",$J(PLNTDUE,0,2)
 W ?45,"Last Payment Due:",?72,PLNLST,!
 W "Plan Date:",?32,$$MDY(PLNDT)
 W ?45,"Next Payment Due:",?72,$S(PLNNXT="00/00/00":"DEFAULT",1:PLNNXT),!!
 W "Bills in Repayment Plan:",!
 Q
 ;
RPDEL(PLN,TRAN) ;Delete repayment plan
 ; PLN - An array of bills
 ;
 N I,PRCABN,PRCAPB,X
 I $G(TRAN)="" S TRAN=1 ; The default is to file a transaction
 F I=1:1:PLN D
 . S PRCABN=$O(PLN(I,0))
 . S X=PLN(I,PRCABN)
 . K ^PRCA(430,PRCABN,4),^PRCA(430,PRCABN,5)
 . I TRAN D TRANDEL
 Q
 ;
DBTCOM(DEBTOR,TEXT) ;Add DEBTOR comments
 ; DEBTOR  - Pointer to #340
 ; TEXT - Comment text
 ;
 N DIC,X,Y
 I $G(TEXT)="" Q
 S DIC="^RCD(340,"_DEBTOR_",2,",DIC(0)="L",X=TEXT
 D FILE^DICN
 Q
 ;
PLNDTL(ARR) ;Gather existing plan details
 ; ARR - An array of bills
 ;
 N BILL,PLAN,DA,D0,D1,D4,D7,I,PRCABN,PYMT,TODAY,LSTDATE
 S PLNRMN=0,PLNTDUE=0,PLNNXT=0,LSTDATE=0
 D DT^DILF("","T",.TODAY)
 F I=1:1:ARR D
 . S PRCABN=$O(ARR(I,0)),X=ARR(I,PRCABN)
 . S D4=$G(^PRCA(430,PRCABN,4))
 . S BILL=$P(X,U,1)
 . S PLNTDUE=PLNTDUE+$P(X,U,4)
 . I I=1 S PLNDT=$P(D4,U,1),PLNDAY=$P(D4,U,2),PLNAMT=$P(D4,U,3)
 . S PYMT=0 F  S PYMT=$O(^PRCA(430,PRCABN,5,PYMT)) Q:'PYMT  D
 .. S D1=^PRCA(430,PRCABN,5,PYMT,0)
 .. I I=1,PYMT=1 S PLNFRST=$P(D1,U,1)
 .. I $P(D1,U,1)>TODAY,$P(D1,U,1)>LSTDATE S PLNRMN=PLNRMN+1,LSTDATE=$P(D1,U,1)
 .. I 'PLNNXT,($P(D1,U,1)>TODAY) S PLNNXT=$P(D1,U,1)
 .. S PLNLST=$P(D1,U,1)
 S PLNFRST=$S($G(PLNFRST):$$MDY(PLNFRST,"/"),1:"N/A")    ; p340 - if no 5-node data on file
 S PLNNXT=$$MDY(PLNNXT,"/")
 S PLNLST=$S($G(PLNLST):$$MDY(PLNLST,"/"),1:"N/A")       ; p340 - if no 5-node data on file
 Q
 ;
SUMM(ARR,LIST,ADD) ;List bills from ARR to plan, new or existing
 ; ARR - An array of bills
 ; LIST - A comma delimited list of bills to be added
 ; ADD - An array of bills
 ;
 N I,J,PRCABN
 F J=1:1 S I=$P(LIST,",",J) Q:I=""  D  S ADD=J
 . S PRCABN=$O(ARR(I,""))
 . S ADD(J,PRCABN)=ARR(I,PRCABN)
 Q
 ;
CORRECT() ;Are you sure this is correct?
 ; Return: 1 for Yes
 ;         0 for No
 ;
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you sure this is correct"
 D ^DIR
 Q Y
 ;
INQPLAN(DUE,PLNDT) ;Prompt for plan details
 ; DUE - Total amount due for the current plan
 ; Returns: 1 if completed
 ;
 N DIR,OK,X,Y,NPAY
 ;
 ;Repayment amount
 S DIR(0)="NA^.01:999999:2" ;PRCA*4.5*340/DRF Allow two decimals, prevent zeroes
 S DIR("A")="Repayment Amount Due: "
 S DIR("?")="This is the amount the debtor will pay each month"
 S OK=0,QUIT=0 F  D  Q:OK!(QUIT)
 . D ^DIR
 . I $D(DIRUT) S OK=1 Q
 . S PRCAMT=Y
 . S NPAY=DUE\PRCAMT I DUE#PRCAMT>0 S NPAY=NPAY+1
 . W !!,"Number of Payments will be ",NPAY,!
 . I NPAY>60 D  Q
 .. W "The number of payments cannot exceed 60. Please re-enter the payment amount.",!
 . I NPAY>36 D  Q:QUIT
 .. W "The number of payments exceeds 36 payments. Ensure you have Supervisor Approval",!
 .. W "and enter Supervisor approval in the Expanded Comment.",!
 .. D PAUSE
 . S OK=1
 I $D(DIRUT) Q 0
 I QUIT Q 0
 ;
 ;Repayment plan date
 S PLNDT=$G(PLNDT)
 I PLNDT="" S %DT="AEFX",%DT("A")="Repayment Plan Date:  ",%DT("B")="T" D ^%DT K %DT I Y=-1!($D(DTOUT)) Q 0
 S PRCADT=$S(PLNDT]"":PLNDT,1:Y) ;Plan Date
 ;
 ;Day of month
 S DIR(0)="N"
 S DIR("A")="Day of Month Payment Due"
 S DIR("?")="Enter the day of the month (1-28) that the payment will be due."
 S OK=0 F  D  Q:OK
 . D ^DIR
 . I $D(DIRUT) S OK=1 Q
 . I Y>0,Y<29 S OK=1 Q
 . W "  Enter the day of the month (1-28) that the payment will be due.",!
 I $D(DIRUT) Q 0
 S PRCADAY=Y
 ;
 ;Date of first payment
 S %DT="AEFX",%DT(0)="NOW",%DT("A")="Due Date of First Payment:  " D ^%DT K %DT
 I Y=-1!($D(DTOUT)) Q 0
 S PRCAFPD=Y ;First payment date
 Q 1
 ;
DUEARR(ARR) ;Total outstanding balance for array ARR returned in PLNTDUE
 ; ARR - An array of bills
 ;
 ; Returns: Outstanding balance of Bills in ARR
 N PLNTDUE,I,PRCABN
 S PLNTDUE=0
 F I=1:1:ARR S PRCABN=$O(ARR(I,0)),PLNTDUE=PLNTDUE+$P(ARR(I,PRCABN),U,4)
 Q PLNTDUE
 ;
ADDPLAN(ADD,PRCAMT,PRCADAY,PRCAFPD,PRCADT,TRAN) ;Record plan on bills
 ; ADD - An array of bills to add to the repayment plan
 ; PRCAMT - Monthly amount the debtor will pay
 ; PRCADAY - Day of the month payment will be made
 ; PRCAFPD - Date of first payment
 ; PRCADT - Date plan is established
 ; TRAN - Flag to file a transaction for new plan
 ;
 N BILL,FP,PAYDATE,PRCAPB,PRCABN,X,XX,PRCANPAY,PRCAFP,PRCAREM,PRCA,PAY
 I $G(TRAN)="" S TRAN=1 ; the default action is to file a transaction
 S FP=PRCAMT,PAYDATE=PRCAFPD
 F BILL=1:1:ADD D
 . S PRCABN=$O(ADD(BILL,0))
 . S X=ADD(BILL,PRCABN)
 . S PRCAPB=$P(X,U,4)
 . K ^PRCA(430,PRCABN,5)
 . S XX=$$PAYMENTS(PRCAPB,FP,PRCAMT),PRCANPAY=$P(XX,U,1),PRCAFP=$P(XX,U,2),PRCAREM=$P(XX,U,3)
 . F PAY=1:1:PRCANPAY D
 .. S PAYDATE=$S(BILL=1&(PAY=1):PRCAFPD,PAY=1&(FP<PRCAMT):PAYDATE,1:$$INCDATE(PAYDATE,PRCADAY)) ;If remainder from previous bill, file on same date
 .. S ^PRCA(430,PRCABN,5,PAY,0)=PAYDATE_U_"0"
 . S ^PRCA(430,PRCABN,5,0)="^430.051DA^"_PRCANPAY_"^"_PRCANPAY
 . S (DIC,DIE)="^PRCA(430,",DA=PRCABN,DR="41///"_PRCADT_";42///"_PRCADAY_";43///"_PRCAMT_";44///"_PRCANPAY
 . S PRCA("LOCK")=0 D LOCKF^PRCAWO1 D:PRCA("LOCK")=0 ^DIE
 . K DA,DIC,DIE,DR
 . I TRAN D TRAN
 . D IXDIK
 . L -^PRCA(430,+$G(PRCABN))
 . S FP=$S(PRCAREM:PRCAREM,1:PRCAMT)
 Q
 ;
ADDTRAN(ADD)    ;Add transaction to bills being added to an exist repayment plan
 N BILL,PRCABN,PRCAPB,X
 F BILL=1:1:ADD D
 . S PRCABN=$O(ADD(BILL,0))
 . S X=ADD(BILL,PRCABN)
 . S PRCAPB=$P(X,U,4)
 . D TRAN
 Q
 ;
IXDIK    ;Reindex 5 node in 430
 N DA,DIK
 S DIK="^PRCA(430,"_PRCABN_",5,",DA(1)=PRCABN
 D IXALL^DIK
 Q
 ;
TRAN     ;File plan add transaction in 433
 N DIE,DA,DR,PRCAEN,PRCAKTY
 S PRCAKTY=$O(^PRCA(430.3,"AC",16,""))
 S PRCAEN=-1 D SETTR^PRCAUTL Q:PRCAEN<0  S DA=PRCAEN
 S DIE="^PRCA(433,",DR=".03////"_PRCABN_";11///"_DT_";12///"_PRCAKTY_";15///"_PRCAPB_"" D ^DIE
 S $P(^PRCA(433,PRCAEN,0),U,4)=2
 Q
 ;
TRANDEL  ;File plan delete transaction in 433
 N DIE,DA,DR,PRCAEN,PRCAKTY
 S PRCAKTY=$O(^PRCA(430.3,"AC",31,""))
 S PRCAEN=-1 D SETTR^PRCAUTL Q:PRCAEN<0  S DA=PRCAEN
 S DIE="^PRCA(433,",DR=".03////"_PRCABN_";11///"_DT_";12///"_PRCAKTY_";15///"_0_"" D ^DIE
 S $P(^PRCA(433,PRCAEN,0),U,4)=2
 Q
 ;
PAYMENTS(AMT,FP,PAY) ;How many payments?
 ; AMT - TOTAL DUE ON BILL
 ; FP - FIRST PAYMENT AMOUNT
 ; PAY - AMOUNT DEBTOR AGREES TO MONTHLY
 ;
 ; Returns:
 ;  NP - Number of payments for this bill
 ;  FP - First payment
 ;  REM - Remainder of payment to be applied
 ;
 N NP,RAMT,REM
 I FP'<AMT S NP=1,REM=FP-AMT,FP=AMT Q NP_U_FP_U_REM ;The first payment pays the bill
 I AMT>FP S RAMT=AMT-FP ;The first payment does not pay the bill. RAMT=remaining balance after first payment
 S NP=(RAMT\PAY)+1 ;The number of payments for RAMT plus the first payment
 S REM=$S(RAMT#PAY=0:0,PAY>RAMT:PAY-RAMT,1:PAY-(RAMT#PAY)) ;How much of the payment is left?
 I REM S NP=NP+1 ;If remainder add last payment
 Q NP_U_FP_U_REM
 ;
INCDATE(DATE,PRCADAY) ;Increment payment date
 ; DATE - Today's date in FileMan format
 ; PRCADAY - Day of the month payment is due
 ;
 ; Returns: Next payment date
 ;
 N PRCAYR,PRCAMON
 S PRCAYR=$E(DATE,1,3),PRCAMON=$E(DATE,4,5)
 I $L(PRCADAY)=1 S PRCADAY="0"_PRCADAY
 S PRCAMON=PRCAMON+1
 I PRCAMON=13 S PRCAMON=1,PRCAYR=PRCAYR+1
 Q PRCAYR_$S((PRCAMON<10&($E(PRCAMON,1)'=0)):0_PRCAMON,1:PRCAMON)_PRCADAY
 ;
PAYDISP(DEBTOR,PLNDT,QUIT) ;Display all payments for Debtor since Repayment Plan effective date
 ; DEBTOR  - Pointer to #340
 ; PLNDT - Effective date of repayment plan
 ; QUIT - User requests exit = 1, default = 0 
 ;
 N DEBTYP
 W "Payments Since Plan Date",!
 I $G(DEBTOR)="" W "None",! Q
 S DEBTYP=$P($P($G(^RCD(340,DEBTOR,0)),U),";",2) I DEBTYP="" W "None",! Q
 I $G(PLNDT)="" W "None",! Q
 I DEBTYP="DPT(" D PAYDISPP Q
 D PAYDISPO Q
 Q
 ;
PAYDISPP ;Display all payments for a patient debtor
 N PAY,DAT,TN,TXD0,TXD1
 S PAY=0,QUIT=0
 I '$D(^PRCA(433,"ATD",DEBTOR)) W "None",!! Q
 S DAT=PLNDT F  S DAT=$O(^PRCA(433,"ATD",DEBTOR,DAT)) Q:'DAT!(QUIT)  D
 . S TN="" F  S TN=$O(^PRCA(433,"ATD",DEBTOR,DAT,TN)) Q:'TN!(QUIT)  D
 .. S TXD0=$G(^PRCA(433,TN,0)),TXD1=$G(^PRCA(433,TN,1))
 .. I '$F(".2.34.41.","."_$P(TXD1,U,2)_".") Q    ; Transaction type must be a payment or refunded
 .. I $P(TXD0,U,4)'=2 Q  ; Transaction status must be complete (2)
 .. W $$MDY($P(DAT,".",1),"/"),"  ",$$GET1^DIQ(433,TN,.03),"  ",$J($P(TXD1,U,5),10,2),!
 .. I $Y+3>IOSL S $Y=0 D PAUSE W ! I QUIT Q
 .. S PAY=PAY+1
 I 'PAY W "None",!
 Q
 ;
PAYDISPO ;Display all payments for a vendor, employee, ex-employee or other debtor
 N PAY,TN,PRCBN,TXD0,TXD1,BDT,LN,DAT
 S PAY=0,QUIT=0
 S PRCBN=0 F  S PRCBN=$O(^PRCA(430,"C",DEBTOR,PRCBN)) Q:'PRCBN  D
 . S TN=0 F  S TN=$O(^PRCA(433,"C",PRCBN,TN)) Q:'TN  D
 .. S TXD0=$G(^PRCA(433,TN,0)),TXD1=$G(^PRCA(433,TN,1))
 .. I $P(TXD1,U,9)<PLNDT Q       ; Date entered is before repayment plan effective date so skip this one
 .. I '$F(".2.34.41.","."_$P(TXD1,U,2)_".") Q    ; Transaction type must be a payment or refunded
 .. I $P(TXD0,U,4)'=2 Q  ; Transaction status must be complete (2)
 .. S BDT=$$MDY($P(TXD1,U,9)\1,"/")
 .. S PAY=PAY+1,PAY($P(TXD1,U,9),TN)=BDT_U_$$GET1^DIQ(433,TN,.03)_U_$J($P(TXD1,U,5),10,2)
 I PAY D  Q:QUIT
 . S DAT=0 F  S DAT=$O(PAY(DAT)) Q:'DAT  D  Q:QUIT
 .. S TN=0 F  S TN=$O(PAY(DAT,TN)) Q:'TN  D  Q:QUIT
 ... S LN=PAY(DAT,TN)
 ... W $P(LN,U,1),"  ",$P(LN,U,2),"  ",$P(LN,U,3),!
 ... I $Y+3>IOSL S $Y=0 D PAUSE W ! I QUIT Q
 I 'PAY W "None",!
 Q
 ;
MERGE(PLN,ADD) ;Add ADD to PLN
 ; PLN - An array of bills
 ; ADD - An array of bills
 ;
 N TMP,OLD,X,CNT,I,PRCABN
 M OLD=PLN K PLN
 F CNT=1:1:OLD D
 . S PRCABN=$O(OLD(CNT,0))
 . S X=OLD(CNT,PRCABN),TMP(PRCABN)=X
 F CNT=1:1:ADD D
 . S PRCABN=$O(ADD(CNT,0))
 . S X=ADD(CNT,PRCABN),TMP(PRCABN)=X
 S PRCABN=0 F I=1:1 S PRCABN=$O(TMP(PRCABN)) Q:'PRCABN  D
 . S PLN(I,PRCABN)=TMP(PRCABN),PLN=I
 Q
 ;
MULTI(PLN) ;Multiple Repayment Plans?
 ; PLN - An array of bills
 ;
 ; Returns: 1 if multiple Repayment Plans, 0 if single plan
 N I,FIRDT,MULT,PRCABN,X
 S FIRDT=0,MULT=0
 F I=1:1:PLN D  Q:MULT
 . S PRCABN=$O(PLN(I,0))
 . S X=PLN(I,PRCABN),PLNDT=$P(X,U,8)
 . I 'FIRDT S FIRDT=PLNDT
 . I PLNDT'=FIRDT S MULT=1
 Q MULT
 ;
PAUSE    ;Press Return to Continue
 N DIR,DUOUT,DTOUT,DIRUT
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S QUIT=1
 Q
 ;
CMTMULT(DEBTOR) ;Enter multiple line comment
 ; DEBTOR  - Pointer to #340
 ;
 N TYPE
 S TYPE=1
 D ADJ(DEBTOR,TYPE)
 Q
 ;
CMTENTR(DEBTOR) ;Enter comments question
 ; DEBTOR  - Pointer to #340
 ;
 N DIR,ANS
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you wish to enter Debtor comments"
 D ^DIR
 S ANS=$S($E(X)="Y":1,$E(X)="y":1,$E(X)="N":0,1:0)
 I ANS W !! D CMTMULT(DEBTOR)
 Q
 ;
ADJ(DEBT,TYPE) ;Adjust an account for DEBT (340 entry)
 N DA,DIC,DIE,DR,ERR,EVN,SITE,X,Y
 S SITE=$$SITE^RCMSITE() G:SITE'>0 Q2
 S DEBT=$P($G(^RCD(340,+$G(DEBT),0)),"^") G:'DEBT Q2
 D OPEN^RCEVDRV1(TYPE,DEBT,DT,DUZ,SITE,.ERR,.EVN)
 I ERR]""!(EVN<0) W !,"Error (",ERR,") trying to open a new event",! G Q2
 W !,"Reference number assigned: ",$P(^RC(341,EVN,0),"^"),!
EDT S DR=$P($G(^RC(341.1,$O(^RC(341.1,"AC",TYPE,0)),1)),"^"),DIE="^RC(341,",DA=EVN D:DR]"" ^DIE
 S X=$$OK(EVN) G:X=0 EDT I X<0!(X["^") D DEL^RCEVDRV1(EVN) W " ... Deleted",! G Q2
 D CLOSE^RCEVDRV1(EVN,.ERR)
 I ERR]"" W !,"Error ("_ERR_")",!,"...  trying to close this event"
Q2 Q
 ;
OK(EVN)  ;OK an event or delete it
 NEW L,FLDS,BY,TO,DIC,IOP,DIR,DIRUT,DIROUT,DUOUT,Y
 W ! S DIR(0)="YA",DIR("B")="YES",DIR("A")="Is this OK? " D ^DIR K DIR
 S:$D(DTOUT) Y=-1
 Q Y
 ;
DSMPLNS(DEBTOR,PLN) ;Display multiple plans
 ; DEBTOR  - Pointer to #340
 ; PLN - An array of bills
 ;
 N CNT,J,OLDPLN,PLANDAT,PRCABN,TMP,X
 F CNT=1:1:PLN D
 . S PRCABN=$O(PLN(CNT,0))
 . S X=PLN(CNT,PRCABN),PLANDAT=$P(X,U,8)
 . S TMP(PLANDAT,CNT,PRCABN)=X
 S PLANDAT="" F  S PLANDAT=$O(TMP(PLANDAT)) Q:PLANDAT=""  D  Q:QUIT
 . K OLDPLN
 . S J=0
 . S CNT=0 F  S CNT=$O(TMP(PLANDAT,CNT)) Q:CNT=""  D
 .. S PRCABN="" F  S PRCABN=$O(TMP(PLANDAT,CNT,PRCABN)) Q:PRCABN=""  D
 ... S J=J+1
 ... S X=TMP(PLANDAT,CNT,PRCABN),OLDPLN(J,PRCABN)=X
 . S OLDPLN=J
 . D RPDIS(DEBTOR,.OLDPLN)
 . S T=$$DISPLAY(.OLDPLN,0,.QUIT) I QUIT Q
 . D PAUSE I QUIT Q
 Q
 ;
SCRNCHK ;Check to see if we need to pause the screen
 I $Y+3>IOSL S $Y=0 D PAUSE W !
 Q

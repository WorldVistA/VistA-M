IBJDF81 ;ALB/RRG - AR PRODUCTIVITY REPORT (COMPILE) ;29-AUG-00
 ;;2.0;INTEGRATED BILLING;**123,159,192**;21-MAR-94
 ;
ST ; - Tasked entry point.
 K IB,^TMP("IBJDF8",$J),^TMP("IBJDF8SUM",$J) S IBQ=0
 ;
 ; - Initialize the array IB
 F I=1:1:13 S IB(I)=0
 ;
 ; - Loops through all the AR Transactions by DATE ENTERED X-ref
 S IBTRDA="",IBTDATE=IBTDATE+.9
 S IBTRTP=0  ; - Don't include INCREASE ADJUSTMENTS transactions
 F  S IBTRTP=$O(^PRCA(433,"AT",IBTRTP)) Q:'IBTRTP  D  Q:IBQ
 . S IBDTEN=IBFDATE-.1
 . F  S IBDTEN=$O(^PRCA(433,"AT",IBTRTP,IBDTEN)) Q:'IBDTEN!(IBDTEN>IBTDATE)  D  Q:IBQ
 . . F  S IBTRDA=$O(^PRCA(433,"AT",IBTRTP,IBDTEN,IBTRDA)) Q:'IBTRDA  D  Q:IBQ
 . . . S IBTR0=$G(^PRCA(433,IBTRDA,0))
 . . . S IBARDA=$P(IBTR0,"^",2) Q:IBARDA=""
 . . . S IBTR1=$G(^PRCA(433,IBTRDA,1))
 . . . S IBTR5=$G(^PRCA(433,IBTRDA,5))
 . . . S IBTR8=$G(^PRCA(433,IBTRDA,8))
 . . . I IBARDA#100=0 S IBQ=$$STOP^IBOUTL("AR Productivity Report") Q:IBQ
 . . . S IBAR0=$G(^PRCA(430,IBARDA,0))
 . . . I 'IBAR0!($P(IBAR0,"^",8)=8) Q  ; No AR bill/bill terminated.
 . . . S IBAR7=$G(^PRCA(430,IBARDA,7))
 . . . S IBAR9=$G(^PRCA(430,IBARDA,9))
 . . . D TRDA
 ;
 I IBSEL'="",IBSEL'[",2," G PRT  ; AUDIT Transaction type not selected
 ;
 ; - Get AUDIT Transactions
 S IBARDA="",IBACTDT=IBFDATE-.1
 ;F  S IBACTDT=$O(^PRCA(430,"ACTDT",IBACTDT)) Q:'IBACTDT  D  Q:IBQ
 F  S IBACTDT=$O(^PRCA(430,"ACTDT",IBACTDT)) Q:'IBACTDT!(IBACTDT>IBTDATE)  D  Q:IBQ
 . F  S IBARDA=$O(^PRCA(430,"ACTDT",IBACTDT,IBARDA)) Q:'IBARDA  D  Q:IBQ
 . . S IBAR0=$G(^PRCA(430,IBARDA,0)) Q:'IBAR0
 . . S IBAR7=$G(^PRCA(430,IBARDA,7))
 . . S IBAR9=$G(^PRCA(430,IBARDA,9))
 . . D AUDIT
 ;
PRT I 'IBQ D EN^IBJDF82 ; Print the report.
 ;
ENQ K ^TMP("IBJDF8",$J),^TMP("IBJDF8SUM",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IBARDA,IBTRDA,IBAR0,IBAR7,IBAR9,IBTR0,IBTR1,IBTR5,IBTR8,IBTRTP,IBACTDT
 K IBBAL,IBDTEN,IBCLNU,IBCLNM,IBDATA,IBCONT,IBCOM,IBFUDT,IBTRAMT,IBQ
 K TRXCAT,TRXCATN,TRXTYPN,IB,I
 Q
 ;
AUDIT ; - Determine if bill has been audited and add to Audit Transaction
 ;   Total, then:
 ;   - Sets temporary detail global (for detail printing)
 ;   - Sets temporary summary global (for summary printing)
 ;
 S IBCLNU=$P(IBAR9,"^",1) I IBCLNU="" Q  ; Approved By (Clerk) not found
 ;
 I '$D(^IBE(351.73,IBCLNU,0)) Q          ; Clerk not set up
 I IBCLERK="S",'$D(IBCLERK(IBCLNU)) Q    ; Clerk not selected
 S IBCLNM=$P($G(^VA(200,IBCLNU,0)),"^",1)
 ;
 S IBBAL=0 F I=1:1:5 S IBBAL=IBBAL+$P(IBAR7,"^",I)  ; Current Bill Balance
 ;
 S IB(2)=($P(IB(2),"^",1)+1)_"^"_($P(IB(2),"^",2)+$P(IBAR0,"^",3))_"^AUDIT"
 S TRXCAT=2
 ;
 ; - Update TMP global with Summary information by Clerk
 S IBDATA=$G(^TMP("IBJDF8SUM",$J,IBCLNM,2))
 S $P(IBDATA,"^",1)=$P(IBDATA,"^",1)+1
 S $P(IBDATA,"^",2)=$P(IBDATA,"^",2)+$P(IBAR0,"^",3)
 S $P(IBDATA,"^",3)="AUDIT"
 S ^TMP("IBJDF8SUM",$J,IBCLNM,2)=IBDATA
 ;
 I IBRPT="S" Q  ; Don't set ^TMP for detail if only Summary was selected
 ;
 ; - Update TMP global with Detailed information 
 S ^TMP("IBJDF8",$J,IBCLNM,IBARDA,0)=$P(IBAR0,"^")_"^"_IBACTDT_"^"_$$DEBTOR(IBARDA)_"^AUDIT^"_$P(IBAR0,"^",3)_"^"_IBBAL
 ;
 Q
 ;
TRDA ; - Checks if Transactions is eligible for the Report, then:
 ;   - Sets temporary global (for detail printing)
 ;   - Sets temporary Summary global (for summary printing)
 ;
 S IBCLNU=$P(IBTR0,"^",9) I IBCLNU="" Q  ; No CLERK found on the AR Trans.
 ; 
 I '$D(^IBE(351.73,IBCLNU,0)) Q        ; Clerk not set up
 I IBCLERK="S",'$D(IBCLERK(IBCLNU)) Q  ; Clerk not selected to print
 ;
 S IBTRAMT=$P(IBTR1,"^",5)  ; TRX Amount
 ;
 I IBRPT'="S",IBTT'="ALL" Q:IBTT'[("|"_IBTRTP_"|")  ; TRX type not selected
 ;
 I '$$VALID^RCRJRCOT(IBTRDA) Q  ; Invalid TRX
 ;
 S IBCONT=$P(IBTR8,"^",8)  ; Contractual / Non-Contractual Transaction
 ; 
 S IBBAL=0 F I=1:1:5 S IBBAL=IBBAL+$P(IBAR7,"^",I)  ; Current Bill Balance
 ;
 ; - Set IB array with summary information
 I $T(@IBTRTP^IBJDF811)'="" D @(IBTRTP_"^IBJDF811")
 ;
 S IBCLNM=$P($G(^VA(200,$P(IBTR0,"^",9),0)),"^",1)  ; Clerk Name
 ;
 ; - Set TMP global with Summary information 
 S IBDATA=$G(^TMP("IBJDF8SUM",$J,IBCLNM,TRXCAT))
 S $P(IBDATA,"^",1)=$P(IBDATA,"^",1)+1
 S $P(IBDATA,"^",2)=$P(IBDATA,"^",2)+IBTRAMT
 S $P(IBDATA,"^",3)=TRXCATN
 S ^TMP("IBJDF8SUM",$J,IBCLNM,TRXCAT)=IBDATA
 ;
 I IBRPT="S" Q  ; Don't set ^TMP for detail if only Summary was selected
 ;
 S IBCOM=$P(IBTR5,"^",2)                 ; Brief Comments
 S IBFUDT=$P(IBTR5,"^",3)                ; Follow-Up Date
 ;
 ; - Set TMP global with Detailed information 
 S ^TMP("IBJDF8",$J,IBCLNM,IBARDA,IBTRDA)=$P(IBAR0,"^")_"^"_IBDTEN_"^"_$$DEBTOR(IBARDA)_"^"_TRXTYPN_"^"_IBTRAMT_"^"_IBBAL_"^"_IBFUDT_"^"_IBCOM
 ;
 Q
 ;
DEBTOR(ARDA) ; - Retrieve debtor name
 N Y,DIC,DA,DR,DIQ,DEB
 S DIC="^PRCA(430,",DA=ARDA,DR=9,DIQ="DEB" D EN^DIQ1
 S Y=$G(DEB(430,DA,9))
 Q Y

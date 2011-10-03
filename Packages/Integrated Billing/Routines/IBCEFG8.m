IBCEFG8 ;ALB/TMP - OUTPUT FORMATTER GENERIC FORM TEST PROCESSING ;21-MAR-96
 ;;2.0;INTEGRATED BILLING;**52,88,51,348**; 21-MAR-94;Build 5
 ;
 Q
 ;
TEST ;Select form from screen and entry from file to test
 N IBF2,IBTYP,IBFORM,IBQUE,IB2,IBPAR,IBCEXDA,IBFILE,IBXERR,DIC,POP,Z,ZTSK,PARAMX,IBIFN,IBXIEN,Z0
 ;Select form
 D FULL^VALM1
 D SELX^IBCEFG3 S IBFORM=$G(IBCEXDA)
 G:IBFORM="" TESTQ
 S IB2=$G(^IBE(353,IBFORM,2)),IBPAR=+$P(IB2,U,5)
 ;
 ; IB*2*348 - esg - no testing with old claim forms
 I IBPAR=12!(IBPAR=13) D  G TESTQ
 . W !!?3,"This local form is associated with an obsolete printed claim form."
 . W !?3,"Testing is not available for this form."
 . Q
 ;
 S IBTYP=$P(IB2,U,2),IBFILE=+IB2
 ;Select Entry #
 S DIC=IBFILE,DIC(0)="AEMQ" D ^DIC
 G:Y<0 TESTQ S (IBXIEN,IBIFN)=+Y
 ;
 S PARAMX("TEST")=1
 I IBTYP="P" D DEV^IBCEFG7(IBFORM,1) G:$G(POP) TESTQ
 I IBTYP="T" D QUE G:$G(IBQUE)="" TESTQ
 ;
 K ^TMP("IBXDATA",$J)
 ;
 ; Execute PRE-PROCESSOR
 I $G(^IBE(353,IBFORM,"FPRE"))'="" X ^("FPRE") ;Form pre-processor
 I $G(^IBE(353,IBFORM,"FPRE"))="",$G(^IBE(353,IBPAR,"FPRE"))'="" X ^("FPRE") ;Parent form pre-processor
 G:$G(IBXERR)'="" FQ
 ;
 ; Extract record
 I +$G(^IBE(353,IBFORM,2))=399 D
 .S PARAMX(1)="BILL-SEARCH",Z0=$G(^DGCR(399,IBIFN,0))
 .S Z=$P(Z0,U,21) S:Z="" Z="P" S PARAMX(2)=$P($G(^DGCR(399,IBIFN,"I"_($F("PST",Z)-1))),U),PARAMX(3)=$S($P(Z0,U,5)<3:"I",1:"O")
 S Z=$$EXTRACT^IBCEFG(IBFORM,IBIFN,1,.PARAMX)
 ;
 G:'$D(^TMP("IBXDATA",$J)) FQ
 ;
 ; If an output routine exists, use it, otherwise use the generic ones
 I $G(^IBE(353,IBFORM,"OUT"))'="" X ^("OUT") G FQ
 ;
 I IBTYP="P" D PRINT^IBCEFG7(IBFORM) D:'$D(ZTQUEUED) ^%ZISC G FQ
 I IBTYP="T" D:$G(IBQUE)'="" TRANSMIT^IBCEFG7(IBFORM,IBQUE) G FQ
 I IBTYP="S" D SCRN^IBCEFG70(IBFORM,IBIFN)
 ;
FQ ; Execute POST-PROCESSOR, if any
 I $G(^IBE(353,IBFORM,"FPOST"))'="" X ^("FPOST") ;Form post-processor
 I $G(^IBE(353,IBFORM,"FPOST"))="",$G(^IBE(353,IBPAR,"FPOST"))'="" X ^("FPOST") ;Parent form post-processor
TESTQ K ^TMP("IBXDATA",$J)
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
QUE ;Select QUEUE to receive transmission
 S %=1 W !,"Send transmission to your mailbox" D YN^DICN
 I (%+1#3) S IBQUE=DUZ Q
 S DIR(0)="F",DIR("A")="Enter a mail queue name: ",DIR(0)="A",DIR("?")="This is the mailman queue where the formatted test record should be sent"
 D ^DIR K DIR S IBQUE=$S('$D(DIRUT):Y,1:"")
 Q
 ;

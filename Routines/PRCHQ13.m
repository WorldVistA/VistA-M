PRCHQ13 ;(WASH IRMFO)/LKG-RFQ Award ;10/7/96  12:24
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN K DIC S DIC=444,DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,8)=3,$P($G(^(8,0)),U,4)>0" D ^DIC K DIC
 G OUT:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y
 L +^PRC(444,PRCDA):5 E  W !,"RFQ #"_$P(Y,U,2)_" is being edited by another user, please try later" G OUT
 S DDSFILE=444,DR="[PRCHQ5]",DA=PRCDA,DDSPARM="C" D ^DDS
 K DA,DDSFILE,DDSPARM,DIMSG,DR
 I $G(DDSCHANG)=1 D
 . S PRCI=0,PRCEVAL=1
 . F  S PRCI=$O(^PRC(444,PRCDA,2,PRCI)) Q:+PRCI'=PRCI  I $P($G(^PRC(444,PRCDA,2,PRCI,3)),U,8)="" S PRCEVAL=0 Q
 . I PRCEVAL D
 . . S DIE=444,DA=PRCDA,DR="7////4;25////^S X=DUZ" D ^DIE K DIE,DR,DA
 . . N PRC S PRC(1)="The status of RFQ #"_$P(^PRC(444,PRCDA,0),U)_" has been changed"
 . . S PRC(2)="from CLOSED to EVALUATION COMPLETE"
 . . D EN^DDIOL(.PRC)
 . K DIR S DIR(0)="YA",DIR("B")=$S(PRCEVAL:"YES",1:"NO")
 . S DIR("A")="Do you wish to now award items assigned to vendors? "
 . S DIR("?",1)="Enter 'YES' to create 2237(s) and PO(s) for items"
 . S DIR("?")="already assigned but not awarded"
 . D ^DIR K DIR Q:Y'=1
 . D AWARD^PRCHQ13A(PRCDA)
 L -^PRC(444,PRCDA) K DDSCHANG
 I '$D(DTOUT),'$D(DUOUT),'$D(DIRUT),'$D(DIROUT) G EN
OUT K PRCDA,DTOUT,DUOUT,PRCMSG,DA,X,Y,PRCI,PRCEVAL,DIRUT,DIROUT
 Q
BLDAR(PRCDA) ;Build array of Quoting Vendors for each RFQ Line Item
 N PRCDA1,PRCDA2,PRCLN,PRCVEN,PRCRDT
 K ^TMP($J,"VB"),^TMP($J,"VC")
 S PRCDA1=0
 F  S PRCDA1=$O(^PRC(444,PRCDA,8,PRCDA1)) Q:+PRCDA1'=PRCDA1  D
 . Q:'$D(^PRC(444,PRCDA,8,PRCDA1,0))  S PRCVEN=$P(^(0),U),PRCRDT=$P(^(0),U,4)
 . S PRCRDT=+$E(PRCRDT,4,5)_"/"_(+$E(PRCRDT,6,7))_"/"_$E(PRCRDT,2,3)_$S($P(PRCRDT,".",2)]"":"@"_$E($P(PRCRDT,".",2)_"000000",1,4),1:"")
 . S PRCDA2=0
 . F  S PRCDA2=$O(^PRC(444,PRCDA,8,PRCDA1,3,PRCDA2)) Q:+PRCDA2'=PRCDA2  D
 . . Q:'$D(^PRC(444,PRCDA,8,PRCDA1,3,PRCDA2,0))  S PRCLN=$P(^(0),U)
 . . S ^TMP($J,"VB",PRCLN,PRCDA1)=PRCDA2_"^"_PRCVEN
 . . S ^TMP($J,"VC",PRCLN,PRCDA1)=PRCDA1_$E("      ",$L(PRCDA1)+1,4)_$E($P(@("^"_$P(PRCVEN,";",2)_$P(PRCVEN,";")_",0)"),U),1,25)_"   Net Line Amt $"_$FN($P($G(^PRC(444,PRCDA,8,PRCDA1,3,PRCDA2,1)),U,7)+0,",",2)_"  Rcvd: "_PRCRDT
 Q
HLP(PRCLN) ;Executable help
 S ^TMP($J,"VC",PRCLN,.1)="Enter the index value for the selected quote."
 S ^TMP($J,"VC",PRCLN,.2)="The quotes which included RFQ Line Item #"_PRCLN_" are:"
 S ^TMP($J,"VC",PRCLN,.3)=" "
 D EN^DDIOL("","^TMP($J,""VC"",PRCLN)")
 Q
INVALID(PRCLN,PRCX) ;When passed RFQ Line # (in PRCLN), check if Quote #
 ;;(passed in PRCX) is valid
 N PRCY S PRCY=0
 S:$D(^TMP($J,"VB",PRCLN,PRCX))#10'=1 PRCY=1
 Q PRCY
QUOTECHK ;Reject selection if quote did not include the item
 N PRCZ S PRCZ=$P(^PRC(444,D0,2,D1,0),U)
 I $$INVALID(PRCZ,X) D EN^DDIOL("Selected quote did NOT include this item.") K X
 Q
EXHLP ;setup for executable help
 N PRCZ S PRCZ=$P(^PRC(444,D0,2,D1,0),U)
 D HLP(PRCZ)
 Q
PUT ;Stuff selected vendor and quote information on item
 N PRCDA1,PRCDA2,PRCLN,PRCVEN,PRCX
 I $G(X)="" D  Q
 . F PRCX=17,23.5,18,19 D PUT^DDSVAL(444.019,.DA,PRCX,"@","","E")
 S PRCDA1=X
 S PRCLN=$$GET^DDSVAL(444.019,.DA,.01)
 Q:'$D(^TMP($J,"VB",PRCLN,PRCDA1))  S PRCDA2=^(PRCDA1)
 S PRCVEN=$P(PRCDA2,"^",2),PRCDA2=$P(PRCDA2,"^")
 D PUT^DDSVAL(444.019,.DA,17,PRCVEN,"","I")
 D PUT^DDSVAL(444.019,.DA,23.5,PRCDA2,"","I")
 S PRCX=$P($G(^PRC(444,PRCDA,8,PRCDA1,3,PRCDA2,0)),U,3)
 I PRCX]"" D PUT^DDSVAL(444.019,.DA,18,PRCX,"","I")
 S PRCX=$P($G(^PRC(444,PRCDA,8,PRCDA1,3,PRCDA2,1)),U,3)
 I PRCX]"" D PUT^DDSVAL(444.019,.DA,19,PRCX,"","I")
 Q

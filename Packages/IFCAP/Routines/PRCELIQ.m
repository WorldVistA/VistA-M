PRCELIQ ;WISC/CLH/CTB-LIQUIDATE 1358 ;9/14/95  11:40 [1/27/99 3:19pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN K PO,PRCFA,PRC,X,X1,%,ER,Y,Z,CNT,IOINHI,IOINLOW,IOINORM,LD,LAMT,DIC,DIE,DR,DA
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 D LIQ^PRCH58LQ(.PRCFA,.Y,.ER,.PO)
 I 'ER G EXIT
EN1 ;entry point when obligation number defined
 K ^TMP($J,"PRCE","LIQ")
EN2 D SCREEN G EXIT:$D(OUT) S DIR("A")="Ok to post liquidation",DIR("B")="Yes",DIR(0)="YO" D ^DIR K DIR G:'Y EXIT
 S (X,Z)=$P(PO(0),"^") I '$D(^PRC(424,"C",PRCFA("PODA"))) W $C(7),!!,"This obligation has not yet established in the 1358 file." H 2 G EXIT
 D EN1^PRCSUT3 S X1=X,DLAYGO=424,DIC="^PRC(424,",DIC(0)="LXZ" D ^DIC K DLAYGO I Y<0 W !!,"YOU DO NOT HAVE THE RIGHT SECURITY ACCESS CODE FOR THIS FILE!!",$C(7) H 3 G EXIT
 W !!,"This 1358 Liquidation entry is assigned entry number ",X1,"."
 S ZX1=X1,DA=+Y
 S DIR(0)="D^"_$E($P($G(PO(12)),U,5),1,7)_":"_DT_".235959"_":EST",DIR("A")="LIQUIDATION DATE",DIR("?")="Enter liquidation date or '^' to quit "
 S DIR("B")=$$DATE^PRCH58 D ^DIR K DIR I $D(DIRUT) D DEL G OUT
 S LD=Y
R S DIR(0)="N^-999999999.99:999999999.99:2",DIR("A")="LIQUIDATION AMOUNT",DIR("?")="Enter the amount of this liquidation or '^' to QUIT"
 I $G(PRCFA("LIQAMT"))]"",+PRCFA("LIQAMT")'=0 S DIR("B")=PRCFA("LIQAMT")
 D ^DIR K DIR I $D(DIRUT) D DEL G OUT
 S LAMT=Y W "  $",$FN(LAMT,",",2)
 I ($P(PO(8),U,2)+LAMT)>+PO(8) D OVER G R
 I '$D(Y) S DIR(0)="Y",DIR("A")="OK to Post",DIR("B")="Yes",DIR("?")="Enter 'Yes' to POST, 'No' or an '^' to DELETE and quit" D ^DIR K DIR I $D(DIRUT)!('Y) D DEL G OUT
 S DIE="^PRC(424,",DR=".1;1.1;.02////^S X=PRCFA(""PODA"");.03////^S X=""L"";.04////^S X=LAMT;.07////^S X=LD;.08////^S X=DUZ;.15////^S X=$G(PRCFA(""TRDA""))" D ^DIE
 D WAIT^PRCFYN,POST^PRCH58LQ(.PRCFA,LAMT,.PO) S ^TMP($J,"PRCE","LIQ",ZX1)=LAMT,X="  ---POSTED---" D MSG^PRCFQ
 I $D(PRCFD("PAYMENT")) S ^TMP("PRCFDA",$J,"LIQ")=-LAMT_U_PRCFA("PODA")_U_ZX1_U_DA
OUT G:$D(PRCFD("PAYMENT")) EXIT W ! S DIR("A")="Would you like to enter another Liquidation for THIS OBLIGATION",DIR(0)="YO",DIR("B")="No"
 S DIR("?",1)="If you want to make further liquidations on this obligation",DIR("?")="enter (Y)es, <RETURN> or '^' to quit" D ^DIR K DIR I Y G EN2
 D SHOW
 S DIR("A")="Would you like to select another 1358 (obligation number)",DIR(0)="YO",DIR("?",1)="Enter yes to make liquidations on a different 1358 obligation"
 S DIR("?")="<RETURN> or '^' to quit",DIR("B")="Yes" D ^DIR K DIR I Y G EN
EXIT K DIRUT,DTOUT,DUOUT,DIRUT,DIROUT,%,^TMP($J,"PRCE","LIQ"),ZX1
 Q
SCREEN ;display balance data prior to posting
 K OUT S:'$D(CNT) CNT=0
 D HILO^PRCFQ W @IOF,IOINHI,"Post Liquidation to 1358",IOINLOW,?40,"Obligation #: ",IOINHI,$P(PO(0),"^")
 W !?20,IOINLOW,"Status: ",IOINHI,$S(+$P(PO(7),"^")>0:$P(^PRCD(442.3,$P(PO(7),"^"),0),"^"),1:"Unknown"),!!,IOINLOW,"Current amount obligated: ",IOINHI,"$ "_$FN($P(PO(8),U),",",2),IOINLOW
 W ?40,"   Authorization Balance: ",IOINHI,"$ "_$FN(+PO(8)-$P(PO(8),"^",3),",",2),IOINLOW,!!?41,"Unliquidated Balance: ",IOINHI,"$ "_$FN(+PO(8)-$P(PO(8),"^",2),",",2),IOINORM,!!
 S PRCUNLIQ=+PO(8)-(+$P(PO(8),U,2))
 S DIR(0)="YO",DIR("B")="No",DIR("A")="Do you wish to display/print the entire 1358"_$S($G(PRCOUNT)="":"",1:" again") D ^DIR K DIR I 'Y K PRCOUNT S OUT=""
 I Y S PRCSQ=1,DA=$P(PO(0),"^",12) D @$S($D(PRCFD("PAYMENT")):"EN1^PRCEFIS5",1:"^PRCEFIS5") K PRCSQ S PRCOUNT=1 G SCREEN
 K OUT
 Q
OVER ;over drawn notice
 N X
 S X=LAMT+$P(PO(8),U,2)-PO(8)
 W !,$C(7),"This amount EXCEEDS available funds by $ ",$FN(X,",",2),".",!
 S X="Liquidating an amount this large CANNOT occur until the responsible service has submitted and Fiscal obligates an increase adjustment." D MSG^PRCFQ
 Q:$P($G(PO(0)),U,3)=""  N MSG,XMSUB,XMDUZ,XMTEXT,CP,ZX S CP=+$P(PO(0),U,3)
 W !! S X="Control point being notified...." D MSG^PRCFQ W !!
 S MSG(1)="        ***    NOTICE   ***",MSG(2)=" ",MSG(3)="On "_$E(LD,4,5)_"/"_$E(LD,6,7)_"/"_$E(LD,2,3)_" Fiscal Service attempted to process a payment against"
 S MSG(4)="PAT#: "_$P($G(PO(0)),U)_" for $ "_$FN(LAMT,",",2)_".  The payment WAS NOT processed due to",MSG(5)="INSUFFICIENT FUNDS on the obligation."
 S MSG(6)=" ",MSG(7)="Review and take appropriate action on the above PAT Reference Number."
 S MSG(8)="Payment CANNOT be processed until action has been taken."
 S XMTEXT="MSG(",XMSUB="1358 PAYMENT NOT PROCESSED"
 S ZX=0 F  S ZX=$O(^PRC(420,PRC("SITE"),1,CP,1,ZX)) Q:'ZX  I $P($G(^(ZX,0)),U,2)<3 S XMY(ZX)="",XMY(ZX,1)="I"
 D:$O(XMY(0)) ^XMD
 Q
DEL S DIK="^PRC(424," D WAIT^PRCFYN,^DIK K DIK S X="Liquidation entry deleted*" D MSG^PRCFQ G EXIT
 ;
SHOW ;show all transactions posted
 N ZDA,ZTOT
 Q:'$D(^TMP($J,"PRCE","LIQ"))
 S ZTOT=0 W:$D(IOF) @IOF,!!,?27,"Obligation #:  ",$P(PO(0),"^")
 W !!,"Sequence #",?40,"Amount",!! S ZDA="" F  S ZDA=$O(^TMP($J,"PRCE","LIQ",ZDA)) Q:'ZDA  W ?6,$P(ZDA,"-",3),?36,$J(^TMP($J,"PRCE","LIQ",ZDA),10,2),! S ZTOT=ZTOT+^TMP($J,"PRCE","LIQ",ZDA)
 W !!,?29,"Total: ",$J(ZTOT,10,2),!!
 Q

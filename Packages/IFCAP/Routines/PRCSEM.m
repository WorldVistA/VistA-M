PRCSEM ;WISC/KMB-DELIVERY RECEIVING,OBLIGATION DATA ;6-6-95 12:00
V ;;5.1;IFCAP;**148**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S PRCSEM=1 D EDTD^PRCSEB0 K PRCSEM
 ;
 Q
ENOD ;ENTER OBLIGATION DATA
 ; The option to execute this entry (Obligation Data [PRCSENOD]) was
 ; was removed with PRC*5.1*148 to enforce segregation of duties.  This
 ; entry point should no longer be used.
 W !!,"This option is no longer available!" Q
 ;
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRCS(410,",DIE=DIC,DIC(0)="AEQM",DIC("S")="I +^(0),$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),""^"",5)=PRC(""SITE""),$P(^(0),""^"",2)=""O"" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 D ^PRCSDIC G EXIT:Y<0 K DIC("S") S (DA,PRCS)=+Y L +^PRCS(410,DA):5 G ENOD:$T=0
ENOD1 ;
 N VALUE,OBLAMT1 S VALUE=$P(^PRCS(410,DA,0),"^") I $D(^PRCS(410,DA,4)),$P(^(4),"^",3)>0 S OBLAMT1=$P(^(4),"^",3)
 W !,"Committed (Estimated) Cost:" I $D(^PRCS(410,DA,4)),$P(^(4),U)]"" W ?28,$J($P(^(4),U),0,2)
 E  W ?28,"None entered."
 S DR="[PRCSENOD]",DIE=DIC D ^DIE
 I $D(^PRCS(410,DA,4)),$P(^(4),"^",3)>0 D:$P(^(4),"^",10)]"" REMOVE^PRCSC2(DA) D ENCODE^PRCSC2(DA,DUZ),ERS410^PRC0G(DA_"^O")
 S:'$D(PRCS) PRCS=DA L -^PRCS(410,DA)
 N OBLAMT2 I $D(^PRCS(410,DA,4)),$P(^(4),"^",3)>0 S OBLAMT2=$P(^(4),"^",3)
 I $D(OBLAMT1),$D(OBLAMT2),OBLAMT2<OBLAMT1 D SENDIT
 D W3 G EXIT:%'=1 W !! G ENOD
SENDIT ;
 N XX,XMY,XMDUZ,XMSUB,XMTEXT S XX=$P($G(^PRCS(410,DA,7)),"^",1) S:XX="" XX=$P($G(^PRCS(410,DA,7)),"^",3) Q:XX=""
 S XMDUZ=DUZ,XMY(XX)=""
 S XMSUB="OBLIGATION DECREASE NOTIFICATION"
 N ARRAY S ARRAY(1)="The obligation amount for transaction "_VALUE,ARRAY(2)="has been decreased from $"_OBLAMT1_" to $"_OBLAMT2_"."
 S XMTEXT="ARRAY(" D ^XMD Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W3 W !!,"Would you like to enter another obligation" S %=1 D YN^DICN G W3:%=0 Q
EXIT K DA,DIC,DIE,DR,PRCS,PRCS58,PRCSL,T,X,X1,Y,DLAYGO Q

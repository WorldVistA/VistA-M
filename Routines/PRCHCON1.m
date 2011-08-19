PRCHCON1 ;WISC/KMB/DL/DXH - CONV. TEMP 2237 TO PC ORDER ;7.29.99
V ;;5.1;IFCAP;**108**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 I '$D(^PRC(440.5,"C",DUZ)) W !!,"You are not authorized to use this option." Q
START ;   get transaction number, convert to regular 2237
 N PRC,Y,PRCSIP,PRCSQ,ODA,PNW,TRY,TX1,T1,T2,T3,T4,PRCSY,PRCSDIC,PRCSAPP
 N PRCHCV,PRCHCPD
 I $G(QUIT)'="" K QUIT Q
 K PRC("SITE") W @IOF D EN3F^PRCSUT(1) G W5:'$D(PRC("SITE")) S:Y<0 QUIT=1 Q:Y<0
 D START1 G START
START1 ;
 W !!,"Select the existing transaction number to be converted",!
 ; don't select an order which is signed, or attached to PC already
 S DIC="^PRCS(410,",DIC(0)="AEFMQ"
 S DIC("S")="I $P(^(0),U,2)=""O"",$P(^(0),U,5)=PRC(""SITE""),$P(^(0),U,12)'=""A"",$D(^(3)),+$P(^(3),U)=+PRC(""CP""),$P($G(^(4)),U,5)="""""
 D ^DIC S:Y<0 QUIT=1 Q:Y<0  S (ODA,DA)=+Y,PRCSDIC=DIC
 I $P($G(^PRCS(410,DA,3)),U,4)="" W !,"This transaction has no entry in the Vendor File.",!,"Please edit this transaction's vendor before converting this order." H 4 Q
 I $P($G(^PRCS(410,DA,4)),U)>3000 W !,"The dollar amount for this transaction exceeds the $3000 purchase card cutoff." H 4 Q
 D W1^PRCSEB0 Q:%<0  S DIC=PRCSDIC
 L +^PRCS(410,DA):15 G:$T=0 START S T1=ODA,T2=^PRCS(410,DA,0),T4=$P(T2,"^",2),T2=$P(T2,"^"),T3=$P(^(3),"^")
 N REM,REM1 S REM=DA,REM1=+$P(PRC("CP")," ")
 L -^PRCS(410,DA) K DA,DIC,Y
 W !!,"Enter the information for the new transaction number",!
 D EN^PRCSUT3 Q:'$D(PRC("QTR"))  Q:'$D(PRC("CP"))
 S TX1=X,PRCSAPP=$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",3) I PRC("CP")'=T3,PRCSAPP["_" D PRCFY Q:PRCSAPP["_"
 S X=TX1 D EN1^PRCSUT3 Q:'X  S TX1=X,(DIC,DIE)="^PRCS(410,"
CK G:'+T2 CK1 K DA S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="LXZ" D ^DIC K DLAYGO Q:Y'>0  S DA=+Y
 K ^PRCS(410,"B",TX1,DA),^PRCS(410,"B2",$P(TX1,"-",5),DA),^PRCS(410,"B3",$P(TX1,"-",2)_"-"_$P(TX1,"-",5),DA),^PRCS(410,"AE",$P(TX1,"-",1,4),DA)
 K ^PRCS(410,"B",T2,T1),^PRCS(410,"B2",$P(T2,"-",5),T1),^PRCS(410,"B3",$P(T2,"-",2)_"-"_$P(T2,"-",5),T1),^PRCS(410,"AE",$P(T2,"-",1,4),T1)
 S $P(^PRCS(410,DA,0),U)=T2 S (^PRCS(410,"B",T2,DA),^PRCS(410,"B2",$P(T2,"-",5),DA),^PRCS(410,"B3",$P(T2,"-",2)_"-"_$P(T2,"-",5),DA),^PRCS(410,"AE",$P(T2,"-",1,4),DA))=""
CK1 S $P(^PRCS(410,T1,0),U)=TX1 S (^PRCS(410,"B",TX1,T1),^PRCS(410,"B2",$P(TX1,"-",5),T1),^PRCS(410,"B3",$P(TX1,"-",2)_"-"_$P(TX1,"-",5),T1),^PRCS(410,"AE",$P(TX1,"-",1,4),T1))=""
 S $P(^PRCS(410,T1,6),"^",4)="" K ^PRCS(410,"K",REM1,REM)
 I '+T2 S DA=ODA,DIE="^PRCS(410,",DR=".5///"_PRC("SITE")_";S X=X;15///"_PRC("CP") D ^DIE G EN
 S DIE="^PRCS(410,",DR=".5///"_+T2_";S X=X;15///"_T3_";60///Transaction "_T2_" replaced by trans. "_TX1
 D ^DIE S $P(^PRCS(410,DA,0),U,2)="CA" D ERS410^PRC0G(DA_"^C"),W5^PRCSEB W !,"Old transaction "_T2_" is now cancelled.",!
 I $D(^PRC(443,ODA,0)) S DA=ODA,DIK="^PRC(443," D ^DIK K DA,DIK
EN W !!,"Transaction '"_T2_"' has been replaced by "_TX1,! S PNW=ODA,PNW(1)=TX1
 S TRY=0
RETRY ;
 S TRY=TRY+1 Q:TRY>3
 N A,B S DA=PNW L +^PRCS(410,DA):15 G:$T=0 RETRY
 S DA=PNW
 S A=TX1 D RBQTR
 S DA=PNW,DR=B_$S(+T2:"1///"_T4,1:"")_$S(PRC("SITE")'=+T2:";S X=X;.5///"_PRC("SITE"),1:"")_$S(PRC("CP")'=T3:";S X=X;15///"_PRC("CP"),1:"")_$S($D(PRCSIP):";4////"_PRCSIP,1:"")
 D ^DIE S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCSAPP=$P(PRC("ACC"),"^",11),$P(^PRCS(410,DA,3),U)=PRC("CP"),$P(^(3),"^",2)=PRCSAPP,$P(^(3),"^",12)=$P(PRC("ACC"),"^",3)
 S $P(^PRCS(410,DA,3),"^",11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 N MYY S MYY="" D EN2B^PRCSUT3
 D K^PRCSUT1 K T1(1)
 L -^PRCS(410,DA)
 D ^PRCHCON2 QUIT
 ;;;;;;;;;;;;;;;;
PRCFY I '$D(PRC("FY")) D NOW^%DTC S PRC("FY")=$E(X,2,3) S:$E(X,4,5)>9 PRC("FY")=$E(100+PRC("FY")+1,2,3)
 S A=PRCSAPP I A["_/_" D FY2 G KILL
 I A["_" S PRCSAPP=$P(A,"_",1)_$E(PRC("FY"),$L(PRC("FY")))_$P(A,"_",2)
KILL K %DT,A,B,RES,X Q
FY2 ; two year appropriation
 W !!,"Enter first year of this two year appropriation: ",PRC("FY")," // " R RES:DTIME G:RES["^" FY21 I RES["?"!(RES'?.4N) W !,"Enter fiscal year in format '1' '81' or '1981'",!! G FY2
FY21 S:'RES RES=PRC("FY") S RES=$E(RES,$L(RES)),PRCSAPP=$P(A,"_",1)_RES_"/"_(RES+1#10)_$P(A,"_",3) Q
W5 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5
 Q
RBQTR N C,D S B="",B=$S(B="":$P(A,"-",2)_"^F",1:+$$DATE^PRC0C(B,"I")),C=$$QTRDT^PRC0G($P(A,"-",1)_"^"_$P(A,"-",4)_"^"_B)
 S D=$$QTRDATE^PRC0D($P(A,"-",2),$P(A,"-",3)),D=$P(D,"^",7)
 S B=$S(D<$P(C,"^",3):$P(C,"^",3),$P(C,"^",2)<D:$P(C,"^",2),1:D)
 S B="449////"_B_";"
 QUIT

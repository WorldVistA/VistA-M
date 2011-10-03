PRCSUT3 ;WISC/SAW/PLT/BGJ-TRANSACTION UTILITY PROGRAM ; 21 Apr 93  10:18 AM
V ;;5.1;IFCAP;**115,123,149**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN ;CREATE NEW TRANSACTION NUMBER
 D EN1^PRCSUT K DA,DIC G W5:'$D(PRC("SITE")) Q
EN1 G:'$D(X) OUT1 S NODE=0,PIECE=2 I $D(PRCS("TYPE")) G:'X OUT1 S T(1)=$O(^DD(410.1,"B",PRCS("TYPE"),0)) G:'T(1)!('$D(^DD(410.1,+T(1),0))) OUT1
 S DIC="^PRCS(410.1,",MSG="",ZERSW=0
 ;I $D(^PRCS(410.1,"B",X)) S N="",N=$O(^PRCS(410.1,"B",X,N)),DA=N L +^PRCS410.1,N):15 G:$T=0 OUT1 S T=$P(^PRCS(410.1,N,NODE),"^",PIECE)+1 S:T<1 T=1 L -^PRCS(410.1,N))
 I $D(^PRCS(410.1,"B",X)) S N="",N=$O(^PRCS(410.1,"B",X,N)),DA=N S T=$P(^PRCS(410.1,N,NODE),"^",PIECE)+1 S:T<1 T=1
 I '$D(^PRCS(410.1,"B",X)) S T=1,DLAYGO=410.1,DIC="^PRCS(410.1,",DIC(0)="FLXZ" D ^DIC K DLAYGO G:Y<0 W4 S DA=+Y
 S HDA=DA
T S T="000"_T,T=$E(T,$L(T)-3,$L(T))
T1 I $D(REP) S X=X_"-"_T I $D(^PRCS(410,"B",X)) S T=+T+1,X=$P(X,"-",1,4) G:T>9999 CANCK G T
 I '$D(REP),'$D(PRCS("TYPE")) S X=Z,X=X_"-"_T I $D(^PRCS(410,"B",X)) S T=+T+1 G:T>9999 CANCK G T
 I '$D(REP),$D(PRCS("TYPE")) S Z=X,X=X_"-"_T I $D(^PRC(424,"B",X)) S T=+T+1,X=Z G T
TEX S DA=HDA L +^PRCS(410.1,DA):15 S $P(^PRCS(410.1,DA,NODE),U,PIECE)=+T,$P(^(0),U,3)=DT L -^PRCS(410.1,DA)
OUT K DA,DIC,N,NODE,PIECE,PRCS("TYPE"),PRCSL,T,Z,HDA Q
OUT1 S X="",Y=-1 D OUT Q
EN2 ;add record in file 410
 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="LXZ" D ^DIC K DLAYGO G:Y<0 W4
EN2A S DA=+Y S:'$D(T(2)) T(2)=""
 S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCSAPP=$P(PRC("ACC"),"^",11)
 S ^PRCS(410,DA,0)=$P(^PRCS(410,DA,0),U)_"^^"_T(2)_"^^"_PRC("SITE"),^PRCS(410,DA,3)=PRC("CP")_"^"_PRCSAPP,$P(^(3),"^",12)=$P(PRC("ACC"),"^",3)
 S $P(^PRCS(410,DA,3),"^",11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 S ^PRCS(410,"AN",$E(PRC("CP"),1,30),DA)=""
 D ERS410^PRC0G(DA_"^E")
 S:T(2)'="" ^PRCS(410,"H",$E(T(2),1,30),DA)=DUZ,$P(^PRCS(410,DA,11),"^",2)=DUZ,^PRCS(410,"K",+$P(PRC("CP")," "),DA)="",$P(^PRCS(410,DA,6),"^",4)=+$P(PRC("CP")," ") K PRCSAPP
EN2B S:$D(PRC("SST")) $P(^PRCS(410,DA,0),"^",10)=PRC("SST")
 D:$D(MYY) ERS410^PRC0G(DA_"^E") Q
EN3 ;INPUT TRANSFORM FOR REORDERING 410 FILE ENTRIES
 ;Add mod (PRC*149) to insure that the next ien used is not below 20,000,000. 
 ;Start back at closest ien to last realistic ien using for loop check to look for last used ien when next ien is below 20,000,000.
 Q:'$D(X)  I $D(^PRCS(410,"B",X)) Q
 N PRCSIEN
 L +^PRCS(410,0):$S($G(DILOCKTM)>10:DILOCKTM,1:10) I '$T W $C(7),"ANOTHER USER IS EDITING FILE 410 CONTROL NODE! Please retry in a minute." K X Q
 S PRCSIEN=$P(^PRCS(410,0),"^",3)-1
 I PRCSIEN<20000000!(PRCSIEN>97999999) D  S:PRCSIEN=20000000 PRCSIEN=97999999
 . F I=90000000:-10000000:20000000 I $O(^PRCS(410,I))-I>1000 S PRCSIEN=$O(^PRCS(410,I)) Q
 F PRCSIEN=PRCSIEN:-1 I '$D(^PRCS(410,PRCSIEN)) L +^PRCS(410,PRCSIEN):$S($D(DILOCKTM):DILOCKTM,1:3) Q:$T
 L -^PRCS(410,0)
 I PRCSIEN'>0 K X
 E  S DINUM=PRCSIEN
 L -^PRCS(410,PRCSIEN)
 Q
CANCK ;Look for cancelled activity when all seq used
 I ZERSW=0 S ZERSW=1,T=1 G T
CK0 S ZZH=Z,ZHOLD=Z
CK1 S ZZH=$O(^PRCS(410,"B",ZZH)),IEN410=0 G CER:ZZH](Z_"-9999")
CK2 S IEN410=$O(^PRCS(410,"B",ZZH,IEN410)) G CK1:IEN410=""
 I $P($G(^PRCS(410,IEN410,0)),U,2)'="CA" G CK2
 S DA=IEN410,DIK="^PRCS(410," D ^DIK
 S T=$P(ZZH,"-",5)
CKQ S Z=ZHOLD K DA,DIK,ZZH,ZHOLD,IEN410
 G T1
CER S MSG="No open sequence number found for "_Z_" for adjustment transaction"
 I $G(PRCRMPR)=1 S X="#"
 K DA,DIK,ZZH,IEN410
 G OUT
W1 S %=2 Q:T4'="O"  W !!,"Would you like to edit this request" D YN^DICN G W1:%=0 Q
W4 W !!,"Another user is accessing this file...  Try later.",$C(7) R:$E(IOST,1,2)="C-" X:5 G EXIT
W5 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5
EXIT K %,DA,DIC,DIE,DR,I,L,N,PRCS,PRCSAPP,PRCSDIC,PRC("FY"),PRCSL,PRCSY,PRC("QTR"),T,T1,T2,T3,T4,X,X1,Z,ZERSW Q

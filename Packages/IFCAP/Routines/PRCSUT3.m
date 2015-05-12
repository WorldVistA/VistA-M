PRCSUT3 ;WISC/SAW/PLT/BGJ-TRANSACTION UTILITY PROGRAM ; 21 Apr 93  10:18 AM
V ;;5.1;IFCAP;**115,123,149,150,180,189**;Oct 20, 2000;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*150 RGB 4/23/12  Control the node 0 counter for file 410
 ;kill (DIK) since DIK call does not handle descending file logic
 ;
 ;PRC*5.1*180 RGB 10/22/12  Added switch coming from IFCAP 1358 
 ;processing to insure new entry check uses file 424, not file 410.
 ;
 ;PRC*5.1*189 RGB 6/12/14   Added check to file 424 new entry check
 ;                          that the user is alerted when there are
 ;                          only approx 100 entries left so they can
 ;                          finalize obligation for liquidation which
 ;                          needs extra file 424 entries available.
 ;                          Also added check for next sequence number
 ;                          for 1358 in 410.1 being 9999, reset to 
 ;                          9998 so don't hit the 10000 barrier with
 ;                          with original node seq plus 1.
 ;
EN ;CREATE NEW TRANSACTION NUMBER
 D EN1^PRCSUT K DA,DIC G W5:'$D(PRC("SITE")) Q
EN1 G:'$D(X) OUT1 S NODE=0,PIECE=2 I $D(PRCS("TYPE")) G:'X OUT1 S T(1)=$O(^DD(410.1,"B",PRCS("TYPE"),0)) G:'T(1)!('$D(^DD(410.1,+T(1),0))) OUT1
 S DIC="^PRCS(410.1,",MSG="",ZERSW=0
 ;I $D(^PRCS(410.1,"B",X)) S N="",N=$O(^PRCS(410.1,"B",X,N)),DA=N L +^PRCS410.1,N):15 G:$T=0 OUT1 S T=$P(^PRCS(410.1,N,NODE),"^",PIECE)+1 S:T<1 T=1 L -^PRCS(410.1,N))
 I $D(^PRCS(410.1,"B",X)) S N="",N=$O(^PRCS(410.1,"B",X,N)),DA=N S T=$P(^PRCS(410.1,N,NODE),"^",PIECE)+1 S:T>9999 T=9999 S:T<1 T=1     ;PRC*5.1*189
 I '$D(^PRCS(410.1,"B",X)) S T=1,DLAYGO=410.1,DIC="^PRCS(410.1,",DIC(0)="FLXZ" D ^DIC K DLAYGO G:Y<0 W4 S DA=+Y
 S HDA=DA
T S T="000"_T,T=$E(T,$L(T)-3,$L(T))
T1 I $D(REP),$G(PRCE424)'=1 S X=X_"-"_T I $D(^PRCS(410,"B",X)) S T=+T+1,X=$P(X,"-",1,4) G:T>9999 CANCK G T    ;PRC*5.1*180
 I '$D(REP),'$D(PRCS("TYPE")),$G(PRCE424)'=1 S X=Z,X=X_"-"_T I $D(^PRCS(410,"B",X)) S T=+T+1 G:T>9999 CANCK G T    ;PRC*5.1*180
 I ('$D(REP)&$D(PRCS("TYPE")))!($G(PRCE424)=1) S Z=X,X=X_"-"_T I $D(^PRC(424,"B",X)) S T=+T+1,X=Z G:T>9999 CER424 G T   ;PRC*5.1*180, PRC*5.1*189
 I ('$D(REP)&$D(PRCS("TYPE")))!($G(PRCE424)=1),T>9900 G CER424    ;PRC*5.1*189
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
 S PRCIENCT=$P(^PRCS(410,0),"^",3)+1      ;PRC*5.1*150
 S DA=IEN410,DIK="^PRCS(410," D ^DIK
 S $P(^PRCS(410,0),"^",3)=PRCIENCT K PRCIENCT     ;PRC*5.1*150
 S T=$P(ZZH,"-",5)
CKQ S Z=ZHOLD K DA,DIK,ZZH,ZHOLD,IEN410
 G T1
CER S MSG="No open sequence number found for "_Z_" for transaction"
 I $G(PRCRMPR)=1 S X="#"
 K DA,DIK,ZZH,IEN410
 G OUT1
CER424 ;424 AVAILABLE SLOT CHECK      ;PRC*5.1*189 CHECK FOR AVAILABLE 424 ENTRIES FOR 1358
 S PRCX1=$P(X,"-",1,2)_"-",PRCTT=0,PRCX3=0
 F PRCI=1:1:9999 S PRCX2=PRCX1_$E("0000",1,4-$L(PRCI))_PRCI S:$D(^PRC(424,"B",PRCX2)) PRCTT=PRCTT+1 I '$D(^PRC(424,"B",PRCX2)),'PRCX3 S PRCX3=PRCI
 K PRCX1,PRCX2,PRCI
 I PRCTT=9999,'PRCX3 W ! S MSG="<<NO>> open sequence number available for "_Z_" for transaction entry" K PRCTT,PRCX3 G OUT1
 I PRCTT>9900 D
 . I 9998-PRCTT>0 D
 .. W !!,"** You have ",9998-PRCTT," remaining and are dangerously close to"
 .. W !,"** running out of Authorization entries in file 424."
 .. W !,"** Authorizations and Liquidation REQUIRE available entries so you"
 .. W !,"** should be considering closing this obligation very soon as ONLY"
 .. W !,"** 9999 entries are allowed.",!
 . I 9998-PRCTT=0 D
 .. W !!,"** You have ZERO remaining and this is the last Authorization"
 .. W !,"** you will be able to enter for this 1358 (max 9999 entries). You"
 .. W !,"** will NO LONGER be able to liquidate any outstanding Authorizations."
 .. W !,"** You MUST close this 1358 and open a new 1358 to cover further activity.",!
 I ((PRCTT=9999)!(T>9999)),PRCX3 S T=PRCX3-1 K PRCTT,PRCX3 G T
 K PRCTT,PRCX3
 G TEX
W1 S %=2 Q:T4'="O"  W !!,"Would you like to edit this request" D YN^DICN G W1:%=0 Q
W4 W !!,"Another user is accessing this file...  Try later.",$C(7) R:$E(IOST,1,2)="C-" X:5 G EXIT
W5 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5
EXIT K %,DA,DIC,DIE,DR,I,L,N,PRCS,PRCSAPP,PRCSDIC,PRC("FY"),PRCSL,PRCSY,PRC("QTR"),T,T1,T2,T3,T4,X,X1,Z,ZERSW Q

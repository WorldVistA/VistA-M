PRCHE2 ;WISC/DJM,ID/RSD,SF-ISC/TKW-REMOVE 2237 FROM PO/PUT IN FILE 443 ;08/11/93  3:18 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ST^PRCHE Q:'$D(PRC("SITE"))
 ;
EN W !!,"Enter the Order number where the 2237 information resides."
 S PRCHP("S")="$P(^(0),U,2)<8!($P(^(0),U,2)=25)" S:$D(PRCHNRQ) PRCHP("A")="REQUISITION NO.: ",PRCHP("S")="$P(^(0),U,2)=8!($P(^(0),U,2)=25)" S:$D(PRCHIMP) PRCHP("A")="IMPREST FUND P.O.NO.: ",PRCHP("S")="$P(^(0),U,2)=7"
 D EN3^PRCHPAT Q:'$D(PRCHPO)
 I $S($D(PRCHIMP)&(X=22):0,X>9:1,1:0) W $C(7)," ??" G EN
 D LCK1^PRCHE G:'$D(DA) EN I '$O(^PRC(442,PRCHPO,13,0)) W !?3,"This Purchase Order contains no 2237 !",$C(7) G EN
 W !?3,"This Purchase Order contains the following 2237's : " S PRCHP=+$P(^PRC(442,PRCHPO,0),U,12),PRCHP=$S($D(^PRCS(410,PRCHP,0)):PRCHP,1:0) S:PRCHP PRCHP(0)=$P(^(0),U,1) D HLP S PRCHLC=I
 ;
EN1 W !?3,"Enter the 2237 reference number you want to remove. You cannot",!," remove the PRIMARY 2237 unless you remove all other 2237s.",!
 R !,"2237 REFERENCE NUMBER: ",X:DTIME G Q:X=""!(X=U) S PRCHY=$O(^PRCS(410,"B",$E(X,1,30),0))
 I 'PRCHY W " ??",$C(7),!?3,"You must enter the entire 2237 reference number. Choose from: ",! D HLP G EN1
 I PRCHY=PRCHP,PRCHLC>1 W " ??",$C(7) G EN1
 K PRCHI F I=0:0 S I=$O(^PRC(442,PRCHPO,2,I)) Q:'I  S X=^(I,0) I $P(X,U,10)=PRCHY S PRCHI(+X)=I_"^"_$G(^(1,1,0))
 I '$D(PRCHI) W !!,$C(7),"There are NO items from this 2237 on this Purchase Order!!",! G EN1
 W !?3,"The following items will be removed from this Purchase Order : " F I=0:0 S I=$O(PRCHI(I)) Q:'I  W !?5,I,".",?12,$P(PRCHI(I),"^",2)
 S %=2,%B="",%A="   Do you wish to proceed " D ^PRCFYN I %'=1 G Q
 S PRCHY(0)=$P(^PRCS(410,PRCHY,0),U,1) G:PRCHP=PRCHY PRCS S X="HAS BEEN CARRIED FORWARD TO TRANSACTION",Y=PRCHY D WP
 S X="REFLECTS ORIGINAL COST PLUS, $",Y=PRCHP D WP S DA(1)=PRCHY X ^DD(410.02,7,1,1,1)
 S Y=$P(^PRCS(410,PRCHY,4),U,8),X=$P(^PRCS(410,PRCHP,4),U,8)-Y,$P(^(4),U,1)=X,$P(^(4),U,8)=X,X=$G(^(7)) I $P(X,"^",6)]"" D REMOVE^PRCSC1(PRCHP),ENCODE^PRCSC1(PRCHP,$P(X,"^",3))
 ;
PRCS D WAIT^DICD S X=$P(^PRCS(410,PRCHY,4),U,5),$P(^(4),U,5)="",$P(^(10),U,3)="" I X]"" K ^PRCS(410,"D",X,PRCHY)
 S X=^PRCS(410,PRCHY,4) I $P(X,"^",10)]"" D REMOVE^PRCSC2(PRCHY),ENCODE^PRCSC2(PRCHY,$P(X,"^",3))
 F I=0:0 S I=$O(^PRCS(410,PRCHY,"IT",I)) Q:'I  S X=+^(I,0),^PRCS(410,PRCHY,"IT","AB",X,I)=""
 S PRCHPONO=$P(^PRC(442,PRCHPO,0),U,1) G:'$O(^PRC(442.8,"B",PRCHPONO,0)) PRCS2 S DIK="^PRC(442.8,",PRCHI=0
 ;F PRCHLC=0:1 S PRCHI=$O(PRCHI(PRCHI)) Q:'PRCHI  S PRCHLINO=$S($D(^PRC(442,PRCHPO,2,+PRCHI(PRCHI),0)):$P(^(0),U,1),1:"") I PRCHLINO F DA=0:0 S DA=$O(^PRC(442.8,"AC",PRCHPONO,PRCHLINO,DA)) Q:'DA  D ^DIK
 F PRCHLC=0:1 S PRCHI=$O(PRCHI(PRCHI)) Q:'PRCHI  S PRCHLINO=$P($G(^PRC(442,PRCHPO,2,+PRCHI(PRCHI),0)),U,1) I PRCHLINO F DA=0:0 S DA=$O(^PRC(442.8,"AC",PRCHPONO,PRCHLINO,DA)) Q:'DA  D ^DIK
 ;
PRCS2 S DIK="^PRC(442,PRCHPO,2,",PRCHI=0 F PRCHLC=0:1 S PRCHI=$O(PRCHI(PRCHI)) Q:'PRCHI  S DA=+PRCHI(PRCHI),DA(1)=PRCHPO I DA,$D(^PRC(442,PRCHPO,2,DA)) D ^DIK
 S $P(^PRC(442,PRCHPO,0),U,15)=0 K ^(9)
 S Y=^PRC(442,PRCHPO,13,PRCHY,0),^PRC(443,PRCHY,0)=Y,$P(^PRC(443,0),U,3,4)=PRCHY_"^"_($P(^PRC(443,0),U,4)+1)
 S ^PRC(443,"B",PRCHY,PRCHY)="",^PRC(443,"C",$P($P(^PRCS(410,PRCHY,0),U,1),"-",4,5),PRCHY)="" S:$P(Y,U,7) ^PRC(443,"AC",$P(Y,U,7),PRCHY)=""
 K ^PRC(442,PRCHPO,13,PRCHY) S $P(^(0),3,4)="0^"_($P(^(0),U,4)-1) I PRCHY=PRCHP S $P(^PRC(442,PRCHPO,0),U,12)="" K ^(13)
 I $O(^PRC(442,PRCHPO,4,0))!($O(^PRC(442,PRCHPO,19,0))) W !!,"You may need to edit P.O. Comments!",! S DIE="^PRC(442,",DA=PRCHPO,DR="20;5.7" D ^DIE
 ;
Q K DIE,DR,I,J,K,PRCHLC,PRCHLINO,PRCHI,PRCHP,PRCHPONO,PRCHY,X,Y
 G EN
 ;
HLP S X=0 F I=0:0 S X=$O(^PRC(442,PRCHPO,13,X)) Q:'X  I $D(^PRCS(410,X,0)) W !?5,$P(^(0),U,1) W:PRCHP=X "     PRIMARY",$C(7) S I=I+1
 Q
 ;
WP Q:'$D(^PRCS(410,Y,"CO",0))  F I=0:0 S I=$O(^PRCS(410,Y,"CO",I)) Q:'I  S J=^(I,0) I J[X,J["THE COST OF THIS REQUEST" K ^(0)
 S I=0 F J=1:1 S I=$O(^PRCS(410,Y,"CO",I)) Q:'I  I J'=I S K=^(I,0) K ^(0) S ^PRCS(410,Y,"CO",J,0)=K,I=J
 S $P(^PRCS(410,Y,"CO",0),"^",3,4)=J_"^"_J
 Q

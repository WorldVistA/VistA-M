PRCHREC1 ;ID/RSD,SF/TKW/RHD-CONT. OF RECEIVING ;2/9/93  14:53
V ;;5.1;IFCAP;**133**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 S PRCHRQ3="",DA=PRCHPO,D="C",DIC="^PRC(442,DA,2,",DIC(0)="QZXE" W !!?3,"Item: ",X D IX^DIC Q:Y<0
 S PRCHRDY=+$O(^PRC(442,DA,2,"AB",PRCHRD,+Y,0)) S:'$D(^PRC(442,DA,2,+Y,3,PRCHRDY,0)) PRCHRDY=0 S:PRCHRDY PRCHRQ3=$P(^(0),U,2),$P(^(0),U,2)=0
 S PRCHRIT=Y,PRCHRQ1=$P(Y(0),U,2),$P(^PRC(442,DA,2,+Y,2),U,8)=$P(^PRC(442,DA,2,+Y,2),U,8)-PRCHRQ3,PRCHRQ2=$P(^(2),U,8),PRCHRAM=$P(^(2),U,1),PRCHRDA=+$P(^(2),U,6) D WP^PRCHREC2
 W !,"UNIT OF PRCH: ",$P($G(^PRCD(420.5,+$P(Y(0),U,3),0)),U,1),"        QTY ORDERED: ",PRCHRQ1,"        PREVIOUSLY RECEIVED: ",PRCHRQ2,!
 I $D(^TMP("PRCHREC4",$J)) W !
 F I=0:0 S I=$O(^TMP("PRCHREC4",$J,+$P(^PRC(442,DA,2,+PRCHRIT,0),U,1),I)) Q:'I  S X=^(I) W ?10,"Delv.Location: ",$P($G(^PRCS(410.8,+X,0)),U,1),?56,"Delv.Qty.:"_$J(+$P(X,U,2),4),!
 N PRCCKER,PRCHITCV,PRCHITIN,PRCHITRQ,PRCHMULT,PRCHCALC
 S PRCHITRQ=$P(^PRC(442,DA,2,+PRCHRIT,0),U,11) I PRCHITRQ'="" S PRCHITIN=$P($G(^PRCS(410,PRCHITRQ,0)),U,6)
 S PRCHITCV=$P(^PRC(442,DA,2,+PRCHRIT,0),U,17),PRCHMULT=+$P(^PRC(442,DA,2,+PRCHRIT,0),U,12)
ENQTY W !?3,"QTY BEING RECEIVED: ",PRCHRQ3 W:PRCHRQ3]"" "// "
 S PRCHRTP=0,PRCCKER=0 R PRCHRQ:DTIME I PRCHRDY G DEL1^PRCHREC2:PRCHRQ="@" S:PRCHRQ3&((PRCHRQ="")!(PRCHRQ["^")) PRCHRQ=PRCHRQ3
 Q:PRCHRQ=""!(PRCHRQ["^")  G:PRCHRQ'=+PRCHRQ!(PRCHRQ<0)!(PRCHRQ?.E1"."3N.N) HLP
 I $P(PRCHRQ,".",2)>0 D
 . I PRCHMULT>0 S PRCHCALC=PRCHRQ*PRCHMULT I +$P(PRCHCALC,".",2)=0 Q
 . I PRCHITCV>0 S PRCHCALC=PRCHRQ*PRCHITCV I +$P(PRCHCALC,".",2)=0 Q
 . W !,"This appears to be an inventory item that will have PURCHASE ORDER RECEIVING TO"
 . W !,"INVENTORY. You CANNOT enter a fractional quantity as it WILL NOT be allowed to"
 . W !,"be received into Inventory.  Please OK the fractional amount is for a non"
 . W !,"inventory receipt.",!
 . W $C(7) S %A="Receiving a fractional quantity, is this a non-inventory item receipt",%B="",%=2 D ^PRCFYN I %'=1 S PRCCKER=1
 I PRCCKER=1 G ENQTY
 I PRCHRQ>(PRCHRQ1-PRCHRQ2) W $C(7) S %A="  You are receiving an overage, do you want to continue",%B="",%=2 D ^PRCFYN Q:%'=1  S PRCHROV=""
 ;
EN3 I PRCHRQ'=PRCHRQ1 S PRCHRAM=$P(^PRC(442,PRCHPO,2,+PRCHRIT,0),U,9),PRCHRAM=$J(PRCHRAM*PRCHRQ,0,2),PRCHRDA=PRCHRDA/PRCHRQ1*PRCHRQ
 K DIC I 'PRCHRDY S DA(2)=PRCHPO,DA(1)=+PRCHRIT,DIC="^PRC(442,DA(2),2,DA(1),3,",DIC(0)="LX",DLAYGO=442,X=PRCHRD S:'$D(@(DIC_"0)")) ^(0)="^442.08DA^^0" D ^DIC K DIC,DA,DLAYGO Q:Y<0  S PRCHRDY=+Y
 S $P(^(2),U,8)=$P(^PRC(442,PRCHPO,2,+PRCHRIT,2),U,8)+PRCHRQ,$P(^PRC(442,PRCHPO,2,+PRCHRIT,3,PRCHRDY,0),U,2,3)=PRCHRQ_U_+PRCHRAM,$P(^(0),U,5)=PRCHRDA
 W:'PRCHRTP ?35,"AMOUNT: ",PRCHRAM
 D:$P(PRC("PARAM"),U,7)=2 ^PRCHREC7 Q
 ;
LI R !!!,"LINE ITEM: ",X:DTIME G 2^PRCHREC:X=""!(X["^"),HLP1:$E(X)="?",LI1:"Aa"[$E(X),COM:"Cc"[$E(X)
 S X1="" F I=1:1 S Y=$P(X,",",I) Q:Y=""  S:Y'[":"&(Y?1N.N) X1=X1_Y_",",Y="" I Y]"" K:Y'[":"!($P(Y,":",1)'?1N.N)!($P(Y,":",2)'?1N.N) X Q:'$D(X)  S X1=X1_+Y_":1:"_$P(Y,":",2)_","
 G:'$D(X) 2^PRCHREC S X=$E(X1,1,$L(X1)-1) X "F PRCHX="_X_" S X=PRCHX D EN1"
 G LI
 ;
LI1 S PRCHX=0 F I=0:0 S PRCHX=$O(^PRC(442,PRCHPO,2,"C",PRCHX)) Q:PRCHX=""!(PRCHX'>0)  S X=PRCHX D EN1
 G LI
 ;
COM S %A="   Complete P.O. as is",%B="",%=1 D ^PRCFYN G:$D(PRCHIMP)&(%'=1) 2^PRCHREC G:%'=1 LI
 ;
COM1 ;ENTRY POINT FOR AUTOMATIC GENERATION OF PROOF OF ORDER FOR GUARANTEED DELIVERY P.O.S
 S I=0 F  S I=$O(^PRC(442,PRCHPO,2,"C",I)) Q:I=""!(I'>0)  S PRCHRIT=+$O(^(I,0))_"^"_I,PRCHRQ1=$P(^PRC(442,PRCHPO,2,+PRCHRIT,0),U,2),PRCHRQ2=$P(^(2),U,8),PRCHRAM=$P(^(2),U,1),PRCHRDA=$P(^(2),U,6) D COM2
 G 2^PRCHREC
 ;
COM2 Q:$O(^PRC(442,PRCHPO,2,"AB",PRCHRD,+PRCHRIT,0))&($D(^PRC(442,PRCHPO,2,+PRCHRIT,3,+$O(^(0)),0)))  S PRCHRTP=1,PRCHRQ=PRCHRQ1-PRCHRQ2,PRCHRDY=0 S:PRCHRQ<0 PRCHRQ=0 D EN3
 Q
 ;
HLP W !?3,"Enter a number between .01 and 99999" W:PRCHRDY " or '@' to delete" W "."
 Q
 ;
HLP1 W !?3,"Enter a Line Item number in the following format: 1,2,3,4 or 1:4 .",!?3,"You may also enter 'C' to complete P.O. as is, or 'A' to see all items."
 S X="??",D="C",DA=PRCHPO,DIC="^PRC(442,DA,2,",DIC(0)="QEM",DIC("S")="I '$D(^PRC(442,DA,2,""AB"",+Y))" D IX^DIC K DIC
 G LI

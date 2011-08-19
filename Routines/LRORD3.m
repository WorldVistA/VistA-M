LRORD3 ;SLC/CJS/DALOI/FHS - MORE LAZY ACCESSION LOGGING ;2/6/91  13:01
 ;;5.2;LAB SERVICE;**153,263**;Sep 27, 1994
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 Q
GSS ;from LRMIBL, LRORD1
 W !,"For ",$P(^TMP("LRSTIK",$J,LRSSX),U,2)
GS ;from LRMIBL, LRORD, LRORD2
 I $D(LRLWC),LRLWC="LC",'$P(^LAB(60,LRTSTS,0),U,9) W !!?10," Sorry ** No Lab collect sample Defined for this test ",$C(7),! S (LRSAMP,LRSPEC)=-1 Q
 S LRSAMP=-1,LRSPEC=-1 S:$D(LRSAME) LRSAMP=$P(LRSAME,U),LRSPEC=$P(LRSAME,U,2)
 K %
 I $D(LRLWC),LRLWC="LC",$P(^LAB(60,LRTSTS,0),U,9) S X=$P(^LAB(62,$P(^(0),U,9),0),U) W !,?5,"The Lab Will collect ",X,!?5,"IS THIS THE CORRECT SAMPLE ?  YES // " D % I %["N" W !!?15,$C(7),"LAB CAN ONLY COLLECT THIS TYPE SAMPLE "
 I $D(%),%["N" W !!,"For other samples use the WARD COLLECT OR SEND PATIENT options",! Q
 I $D(%),$D(LRLWC),LRLWC="LC",%'["N" S LRCSN=1,LRUNQ=$P(^LAB(60,LRTSTS,0),U,9),(Y,LRCS(1))=LRUNQ G G2
 I $D(LRLWC),LRLWC="LC" Q
 S J=$O(^LAB(60,LRTSTS,3,0)) G GSNO:J<1 S LRCSN=1,LRUNQ=+$P(^LAB(60,LRTSTS,0),U,8),LRCS(1)=+^(3,J,0) S X=$P(^LAB(62,LRCS(1),0),U) W:'$D(LRSAME) !,$S(LRUNQ:"The Sample ",1:""),"Is ",X,"   ",$P(^(0),U,3)
 G G2:LRUNQ Q:$D(LRSAME)  W " the correct sample to collect? Y//" D % G G2:%'["N"
 F  S J=$O(^LAB(60,LRTSTS,3,J)) Q:J<1  S LRCSN=LRCSN+1,LRCS(LRCSN)=+^(J,0)
 G GSNO:LRCSN<2
 W ! F I=1:1:LRCSN W !,I," ",$P(^LAB(62,LRCS(I),0),U),"  ",$P(^(0),U,3)
 R !,"Choose one: ",X:DTIME IF X>0&(X<(LRCSN+1)) S LRCSN=+X G G2
GSNO ;from LRORD1, LRWU1
 Q:$D(LRSAME)  S LRCSN=1,LRCS(1)=-1,DIC="^LAB(62,",DIC(0)="AEMOQ" D ^DIC K DIC S LRCS(1)=+Y
G2 S LRSAMP=LRCS(LRCSN) I LRSAMP<1 S Y=-1,LROT="" G G3
 I $P(^LAB(62,LRSAMP,0),U,2)'="" S LRSPEC=+$P(^(0),U,2) G G4
W18A S DIC="^LAB(61,",DIC(0)="EMOQ",D="E" R !,"Select SITE/SPECIMEN: ",X:DTIME
 D IX^DIC:X="?" G W18A:X="?" D ^DIC K DIC G W18A:'($D(DUOUT)!$D(DTOUT))&(Y<0) I $D(DTOUT)!$D(DUOUT) S LREND=1 Q
 I LRUNKNOW=+Y,'$D(LRLABKY) W !,"Unknown is not allowed." G W18A
G3 S LRSPEC=+Y
 I +LRSAMP=-1&(LRSPEC=-1),$D(LROT) W !,"Sample and source incompletely defined, test skipped." Q
G4 Q:+LRSAMP=-1&(LRSPEC=-1)!$D(LRSAME)!$D(LRBLEND)
 I $D(LRFLOG),$P(LRFLOG,U,3)="MI" Q
 I '$D(LRLABKY) K % Q
 I $D(LRLWC),LRLWC="LC" Q
 W !,"Same specimen/source for the rest of the order" S %=2 D YN^DICN G G4:%=0 S:%=1 LRSAME=LRSAMP_U_LRSPEC
 Q

LRAUMLK ;VAMC 695/MLK - AUTOPSY SLIDE LABELS;1/21/91 ;5/31/96  08:29
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 ;
 S LRDICS="AU" D ^LRAP G:'$D(Y) END D XR^LRU W !!?25,"Autopsy Slide Labels"
ASK ;SECTION WITH INPUTS
 S %DT="",X="T" D ^%DT S LRY=$E(Y,1,3),LR(5)=LRY+1700 W !,"Enter year: ",LR(5),"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LR(5)
 S %DT="EQ" D ^%DT G:Y<1 ASK S LR(2)=$E(Y,1,3) W "  ",LR(2)+1700
R R !!,"Enter Autopsy Case number: ",X:DTIME G:X=""!(X[U) END S LR(3)=X I +X'=X D HELP G R
 I '$D(^LR(LRXREF,LR(2),LRABV,LR(3))) W $C(7),!!,"Autopsy not entered",! G R
R1 W !,"Want labels for whole case" S %=1 D YN^DICN I '%!(%=0) W " Answer 'Y' or 'N'" G R1
 G:%<0 END I %=2 S J=0,WR=1 G ADDL
R2 R !,"Enter total number of blocks :",BLKS:DTIME G:'$T!BLKS=""!(BLKS["^") END I +BLKS'=BLKS D HELP G R2
SET S WR=BLKS\6 F I=0:1:(WR-1) F J=1:1:6 S ^TMP($J,I+1,J)=(I*6+J)_"^"_"H & E"
 I BLKS#6=0 S WR=WR+1,J=0 G ADDL
 F J=1:1:BLKS#6 S ^TMP($J,WR+1,J)=WR*6+J_"^"_"H & E"
 S WR=WR+1
ADDL W !,"Want to enter additional stains :" S %=2 D YN^DICN I '%!(%=0) W "Answer 'Y' or 'N'" G ADDL
 G:%<0 END I %=2 G TSK
ADDL1 R !,"Enter Block #: ",BLK:DTIME G:BLK="" TSK G:'$T!(BLK["^") END I +BLK'=BLK D HELP G ADDL1
STAIN S DIC=60,DIC("A")="Select stain: ",DIC(0)="AEQMZ",DIC("S")="I $P(^LAB(60,+Y,0),U,4)=""SP""" D ^DIC K DIC G:$D(DTOUT)!$D(DUOUT) END G:Y<0 STAIN
 S ST=$P(^LAB(60,+Y,.1),U,1) K DIC
SLIDE R !,"Enter # of slides for this block/stain: 1//",TS:DTIME G:'$T!(TS["^") END S:TS="" TS=1 I +TS'=TS D HELP G SLIDE
 F K=1:1:TS S J=J+1 S:J>6 WR=WR+1,J=1 S ^TMP($J,WR,J)=BLK_"^"_ST
 G ADDL1
TSK S ZTRTN="QUE^LRAUMLK",ZTDESC="Autopsy labels",ZTSAVE("LR*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("WR")="" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO W @IOF
 S LR(1)=$E(LR(2),2,3)_"-"_LR(3),LR("SITE")=+$$SITE^VASITE
PL F I=1:1:WR W:I>1 ! S X=LRABV D PL1 S X=LR(1) D PL1,PL2 S X=LR("SITE") D PL1
 D END^LRUTL,END Q
PL1 W !,X,?10,X,?20,X,?30,X,?40,X,?50,X Q
PL2 F C=1:1:2 W ! F B=0:1:5 W ?B*10,$S($D(^TMP($J,I,B+1)):$P(^TMP($J,I,B+1),U,C),1:"")
 Q
PL3 W !,X,?10,X+1,?20,X+2,?30,X+3,?40,X+4,?50,X+5 Q
HELP W $C(7),!!,"Enter numbers only",! Q
END D V^LRU Q

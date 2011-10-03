YTLIST ;SLC/TGA-LIST OF TESTS ;2/22/91  13:17 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 S YSBAT=0
 I YSTESTN?1"?"1.AN!(YSTESTN?1.AN1"?") S YSBAT=1 S (YSTESTN,X)=$TR(YSTESTN,"?","") S DIC="^YTT(601,",DIC(0)="EQZ" D ^DIC K DIC W:Y'>0 " No match found for ",X Q:Y'>0  S YSTESTN=X G TS
1 ;
 S YSLFT=0 I YSTESTN'["?" G TS
 S X3=$D(^XUSEC("YSP",YSORD))
 ;  I 'X3 G INT    <-- Commented 10/17/94 LJA.  Key check built into L1...
 S Z=59,YSNX="",N="" W !!?21,"--- LIST OF TESTS ---"
L1 ;
 S N="" F  S N=$O(^YTT(601,"ATN","T",N)) Q:N=""  S I=$O(^(N,0)) I I S X=^YTT(601,I,0) D
 .  I $P(X,U,2)="I",YSXT="CLERK^" QUIT  ;->
 .
 .  ;  If doesn't have YSP key, and not VOCATIONAL and not EXEMPT...
 .  I X3<1&($P(X,U,8)'["V")&($P(X,U,10)'="Y") QUIT  ;->
 .
 .  ;  Operational?
 .  I $P(X,U,13)="N" QUIT  ;->
 .
 .  S X2=$P(X,U,14),X2=$S(X2="N":"*",1:"") S X2=X2_$S($P(X,U,3)["Y":"+",1:"")
 .  S YSNX=$P(X,U)_$S(X2="*"&(YSXT'="CLERK^"):"*",1:"")
 .  S:X2["+" YSNX=YSNX_"+" S Z=Z+8#64
 .  W:Z=3 ! W ?Z,YSNX
 ;
INT ;
 Q:YSXT="CLERK^"
 S N="",I=0,Z=59 W !!?19,"--- LIST OF INTERVIEWS ---"
L2 ;
 S N="" F  S N=$O(^YTT(601,"ATN","I",N)) Q:N=""  S I=$O(^(N,0)) I I S X=^YTT(601,I,0) I $P(X,U,13)'="N" S Z=Z+8#64 W:Z=3 ! W ?Z,$P(^(0),U)
 ;Q:'YSBAT  I '$O(^YTT(601,"AI","B",0)) G LE     Commented 4/22/94  LJA
 I '$O(^YTT(601,"AI","B",0)) G LE
 W !!?19,"--- LIST OF BATTERIES ---",!!,?3,"Name",?11,"Instruments in Battery",!?3,"----",?11,"----------------------"
 S N="" F  S N=$O(^YTT(601,"ATN","B",N)) Q:N=""  S I=$O(^(N,0)) I I W !?3,$P(^YTT(601,I,0),U) S X=$P(^YTT(601,I,"A"),"""",2) F J=1:1 S Y=$P(X,U,J) Q:Y=""  W ?(8*J+3),$P(^YTT(601,Y,0),U)
LE ;
 W ! K YSBAT,YSNX,I,X,X1,X2,X3 Q
TS ;
 S Z=$F(YSTESTN,"?"),YSTESTN=$E(YSTESTN,1,Z-2)_$E(YSTESTN,Z,9) W !!
 S YSTEST=$O(^YTT(601,"B",YSTESTN,0)) G:'YSTEST TSB
 I $P(^YTT(601,YSTEST,0),U,9)="T",$D(^XUSEC("YSP",DUZ)) G T1
 I $P(^YTT(601,YSTEST,0),U,9)="I" G T2
 I $P(^YTT(601,YSTEST,0),U,9)="B" G T3
TSB ;
 W ?5,"COMMENTS NOT FOUND FOR : ",YSTESTN Q
T1 ;
 I $D(^YTT(601,YSTEST,"P")) S YSLN=$L($P(^("P"),U)) W ?(72-YSLN\2),$P(^("P"),U),!
 W !,"AUTHOR     : " W:$D(^YTT(601,YSTEST,1)) ^(1)
 W !,"PUBLISHER  : " W:$D(^YTT(601,YSTEST,2)) ^(2)
 W !,"FORM       : " W:$D(^YTT(601,YSTEST,3)) ^(3)
 W !,"NO. ITEMS  : ",$P(^YTT(601,YSTEST,0),U,11)
 W !,"NO. SCALES : ",$P(^YTT(601,YSTEST,0),U,12)
 W !,"NORMATIVE DATA:",! F K=1:1 Q:'$D(^YTT(601,YSTEST,6,K,0))  W ?5,^(0),!
 W "TEST USES:",! F K=1:1 Q:'$D(^YTT(601,YSTEST,7,K,0))  W ?5,^(0),!
 Q:'$D(^YTT(601,YSTEST,8,1,0))  W "INTERPRETIVE REPORT:",!
 F K=1:1 Q:'$D(^YTT(601,YSTEST,8,K,0))  W ?5,^(0),!
 Q
T2 ;
 I $D(^YTT(601,YSTEST,"P")) S YSLN=$L($P(^("P"),U)) W ?(72-YSLN\2),$P(^("P"),U),!
 W !,"NUMBER OF ITEMS: ",$P(^YTT(601,YSTEST,0),U,11)
 W !,"SOURCE:",! F K=1:1 Q:'$D(^YTT(601,YSTEST,4,K,0))  W ?5,^(0),!
 W "DESCRIPTION:",! F K=1:1 Q:'$D(^YTT(601,YSTEST,5,K,0))  W ?5,^(0),!
 Q
T3 ;
 W !,"TEST BATTERY CONSISTING OF:",! S X=$P(^YTT(601,YSTEST,"A"),"""",2) F I=1:1:$L(X,U)-1 W $P(^YTT(601,$P(X,U,I),0),U),"  "
 W ! Q
ENTB ;
 S YSORD=DUZ,YSBAT=0,YSTESTN="?" D 1 K I,K,X,X1,X2,X3,YSBAT,YSLN,YSNX,YSORD,YSTESTN,YSXT,Z Q

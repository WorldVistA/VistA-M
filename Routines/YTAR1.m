YTAR1 ;SLC/TGA,DKG-RESUME TESTS; ;5/30/02  14:57
 ;;5.01;MENTAL HEALTH;**37,76**;Dec 30, 1994
 ;
 ; 3/11/94 LJA
 I $D(^YTD(601.4,YSDFN,1,"AC")) D
 .  S (X,YSX)=$O(^YTD(601.4,+YSDFN,1,"AC",0))
 .  W !?2,"("
 .  I $G(^YTD(601.4,+YSDFN,1,14,99))'="MMPIR" W $P(^YTT(601,X,0),U)
 .  I $G(^YTD(601.4,+YSDFN,1,14,99))="MMPIR" D
 .  .  W $S(YSX=60:"MMPIR",YSX=61:"MMPR",1:"??")
 .  W " Test was discontinued in Clerical Entry mode)"
 ;
 S Z=0 F  S Z=$O(^YTD(601.4,YSDFN,1,Z)) Q:'Z  S Z1=$P(^YTT(601,Z,0),U) I Z1'="CLERK" S X2=$S($P(^YTD(601.4,YSDFN,1,Z,0),U,8):$P(^(0),U,8),1:$P(^(0),U,2)) D DAT I X S Z(Z1)=Z_"^"_$P(^YTD(601.4,YSDFN,1,Z,0),U,2)
R11 ;
 I $D(Z)>10 W !!,"Interactive instruments to restart: " S Z1="" F  S Z1=$O(Z(Z1)) Q:Z1=""  W ?36,Z1 W:$P(Z(Z1),U,2)']"" ! I $P(Z(Z1),U,2)]"" S M=$P(Z(Z1),U,2) W ?44,$$FMTE^XLFDT(M,"5ZD") W !
 I $D(Z)<11 G A10^YTAR
R2 ;
 R !!?2,"Restart Instrument: ",YSTEST:DTIME S YSTOUT='$T,YSUOUT=YSTEST["^" G:YSTOUT!YSUOUT KAR^YTS G:YSTEST["?" R11
 I YSTEST="",T1 D DEL G:"Nn^"[$E(A1) KAR^YTS
 I YSTEST="" G A10^YTAR
 I '$D(Z(YSTEST)) W "  ??",$C(7,7) G R2
 S (YSENT,YSTEST)=$P(Z(YSTEST),U)
 S (B,C)="",J=+$P(^YTD(601.4,YSDFN,1,YSENT,0),U,4),C=$P(^(0),U,5),YSORD=$P(^(0),U,7) S:$P(^(0),U,8) YSBEGIN=$P(^(0),U,8)
 I $D(^YTD(601.4,YSDFN,1,YSENT,"B"))#2 S B=^("B")
 S YSRP=$S(J#200=1:"",1:^YTD(601.4,YSDFN,1,YSENT,J+198\200)) S:'J J=1
MCMI2 ;
 I $P(^YTT(601,YSTEST,0),U)?1"MCMI"1N X ^YTT(601,YSTEST,"C") ;ASF 5/30/02
 S YSXT=YSTEST_"^" S:$D(^YTD(601.4,YSDFN,1,YSENT,"R")) YSXT=YSXT_^("R") S YSXTP=1,YSDEMO="N",YSRESTRT=1 G A3^YTAR
DEL ;
 W !!?2,"Delete discontinued ",$P(^YTT(601,YSXT,0),U) R "? Y// ",A1:DTIME S YSTOUT='$T,YSUOUT=A1["^" Q:YSTOUT!YSUOUT  S:A1="" A1="Y"
 I "Yy"[$E(A1) S YSTEST=YSXT,YSENT=$P(Z($P(^YTT(601,YSXT,0),U)),U) D ENKIL^YTFILE S YSTEST="" W !,"DELETED!" Q
 I "Yy"'[$E(A1) W !,$C(7),"You must either restart or delete this ",$P(^YTT(601,YSXT,0),U),"!"
 Q
DAT ;
 N YTLM S YTLM=YSRSLMT
 I T1,YSXT'=Z S X=0 Q
 I $P($G(^YTT(601,Z,0)),U,16) S YTLM=$P(^(0),U,16)
 S X=$$FMDIFF^XLFDT(DT,X2,1) I X'>YTLM S X=1 K YTLM Q
 W !!?2,Z1,?9,"discontinued " I $D(%Y),%Y W X," days ago "
 W "- not restartable" S X=0 K YTLM Q

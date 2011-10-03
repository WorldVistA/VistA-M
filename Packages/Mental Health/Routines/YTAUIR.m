YTAUIR ;ALB/ASF- AUIR DRIVER ;12/20/89  09:35 ;2/21/89  12:33
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 X ^%ZOSF("NO-TYPE-AHEAD")
 I '$D(J) S J=1,YSRP="",B="",YSBEGIN=DT
 I $P(^YTT(601,YSTEST,0),U,6)]"" S YSCH=$P(^(0),U,6),Y=$P(^(0),U,7) D DD^%DT S YSCD=Y I $D(^YTT(601.3,YSCH,0)) S YSCHN=YSCH,YSCH=$P(^(0),U) D CR
NX ;
 I $P($G(^YTT(601,YSTEST,"Q",J,0)),U,2)]"" S C=$P(^(0),U,2)
 S K=$G(^YTT(601,YSTEST,"Q",J,"B")) S:K'="" B=K
MAR ;
 I J=209 D MARQ,RD G BK:X="^",^YTAR2:X="*",MAR:X'=1&(X'=2) I X=1 S X="" D ^YTFILE Q
 I '$D(^YTT(601,YSTEST,"Q",J,"I",1,0)) G D1
 W @IOF F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"I",K))  W:$D(^(K,0)) !!?3,^(0)
 W !!!?3,"PRESS THE SPACE BAR TO CONTINUE."
I2 ;
 D RD I X'=" " G:X="*" ^YTAR2 W " ? " G I2
D1 ;
 W @IOF F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"T",K))  W:$D(^(K,0)) !!?3,^(0)
 X:B'="" B
D3 ;
 S YZT=$P($H,",",2) D RD G HOLD:YZT+1>$P($H,",",2),D4:C[X,BK:X="^",^YTAR2:X="*",WHERE:X="?" W " ? " G D3
D4 S YSRP=YSRP_X D:J#200=0 EN4^YTFILE S J=J+1 I $D(^YTT(601,YSTEST,"Q",J)) G NX
 D ^YTFILE Q
RD ;
 R *X:900 S:'$T X=42 G:X<32 RD S X=$C(X)
 Q
BK ;
 G:J=1 D1 S J=J-1,X=$L(YSRP),YSRP=$S(X>1:$E(YSRP,1,X-1),X=1:"",1:$E(^YTD(601.4,YSDFN,1,YSENT,J\200),1,199)) G NX
WHERE ;
 W !,YSTESTN,"  QUESTION # ",J,! X:B]"" B G D3
CR ;
 I YSCH="IPAT"!(YSCH="PSYC") S YSTNM=$P($P(^YTT(601,YSTEST,"P"),U),"---",2),YSTNM=$E(YSTNM,1,$L(YSTNM)-1) G IP:YSCH="IPAT",PS:YSCH="PSYC"
 W @IOF,!!!?3,^YTT(601.3,YSCHN,1,1,0)," ",YSCD," ",^YTT(601.3,YSCHN,1,2,0) S YSTX=2
NL ;
 S YSTX=$O(^YTT(601.3,YSCHN,1,YSTX)) G:'YSTX H5 W !?3,^(YSTX,0) G NL
H5 ;
 W !! H 5 K YSCH,YSCHN,YSCD,YSTX Q
IP ;
 W @IOF,!!!?3,^YTT(601.3,YSCHN,1,1,0),!?3,^YTT(601.3,YSCHN,1,2,0),YSTNM,",",!?3,^YTT(601.3,YSCHN,1,3,0)," ",YSCD," ",^YTT(601.3,YSCHN,1,4,0),!?3,^YTT(601.3,YSCHN,1,5,0),! H 5 K YSCH,YSCHN,YSCD,YSTX,YSTNM Q
PS W @IOF,!!!?3,^YTT(601.3,YSCHN,1,1,0),YSTNM,!?3,^YTT(601.3,YSCHN,1,2,0)," ",YSCD,!?3,^YTT(601.3,YSCHN,1,3,0),"  ",^YTT(601.3,YSCHN,1,4,0) H 5 K YSCH,YSCHN,YSCD,YSTX,YSTNM Q
HOLD ;
 W !!,"Please read each question carefully",$C(7) R X:3 K X G D1
MARQ ;
 W @IOF,!,"Have you been living in a marriage or marriage-type situation",!,"within the past six months?",!!!?3,"1. No",!!?3,"2. Yes" Q

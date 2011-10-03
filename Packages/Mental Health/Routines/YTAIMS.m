YTAIMS ;ALB/ASF-TEST PKG: AIMS ;8/18/99  09:19
 ;;5.01;MENTAL HEALTH;**54,66**;Dec 30, 1994
 ;
 ;Reference to ^%ZOSF("NO-TYPE-AHEAD" supported by IA #10096
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to $$GET1^DIQ() supported by IA #2056
 ;
 X ^%ZOSF("NO-TYPE-AHEAD")
 I '$D(J) S J=1,(YSRP,B)="",YSBEGIN=DT
NX ;
 I $D(^YTT(601,YSTEST,"Q",J,0))#2=1 S:$P(^(0),U,2)]"" C=$P(^(0),U,2)
 I $D(^YTT(601,YSTEST,"Q",J,"B")) S K=^("B") S:K'="" B=K
 I '$D(^YTT(601,YSTEST,"Q",J,"I",1,0)) G D1
 W @IOF F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"I",K))  W:'$D(^YTT(601,YSTEST,"Q",J,"I",5)) ! W:$D(^YTT(601,YSTEST,"Q",J,"I",K,0)) !?3,^(0)
 W !!!?3,"Press the Space bar to continue"
 W !?3,"Press 'E' to review the Examination Procedure "
I2 ;
 D RD I X'=" " G:X="*" ^YTAR2 G:X="E"!(X="e") EP W " ? " G I2
D1 ;
 W @IOF F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"T",K))  W:$D(^(K,0)) !?3,^(0)
 X:B'="" B
D3 ;
 S YZT=$P($H,",",2) D RD G HOLD:YZT+1>$P($H,",",2) G D4:C[X,BK:X="^",^YTAR2:X="*",WHERE:X="?" W " ? " G D3
D4 ;
 S YSRP=YSRP_X D:J#200=0 EN4^YTFILE S J=J+1 I $D(^YTT(601,YSTEST,"Q",J)) G NX
 D ^YTFILE Q
RD ;
 R "",*X:900 S:'$T X=42 G:X<32 RD S X=$C(X) Q
BK ;
 G:J=1 D1 S J=J-1,X=$L(YSRP),YSRP=$S(X>1:$E(YSRP,1,X-1),X=1:"",1:$E(^YTD(601.4,YSDFN,1,YSENT,J\200),1,199)) G NX
WHERE ;
 W !,YSTESTN,"  QUESTION # ",J,! X:B]"" B G D3
HOLD ;
 W @IOF,#,$C(7) R "Please read each question carefully!",X:3 K X G D1
 ;
EP ;exam procedure
 W @IOF
 F K=1:1 Q:'$D(^YTT(601,YSTEST,"M",1,1,K))  W !?3,^(K,0) D:($Y+4)>IOSL
 . R !!,"press any key",*X:900
 . W @IOF,!
 R !!,"press any key ",*X:900
 W @IOF
 G D1
 ;
REPT ;generate printout
 D DTA^YTREPT
 S YSNOITEM="DONE^YTAIMS"
 W !?7,"--- Abnormal Involuntary Movement Scale ---"
 S Y=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S R=0
 F I=1:1:7 S R=R+$E(Y,I)
 W !!?2,"AIMS score= ",R
 S YSORD=$P(^YTD(601.2,YSDFN,1,YSET,1,YSED,0),U,3)
 W ?20,"Ordered by: " I YSORD,$D(^VA(200,YSORD,0)) W $$GET1^DIQ(200,YSORD_",",.01)
 W !
 S J=0 F  S J=$O(^YTT(601,YSET,"G",1,1,J)) Q:J'>0  D
 . S X=^YTT(601,YSET,"G",1,1,J,0)
 . S YSQ=+X
 . S YSIND=$P($P(X,U),",",2)
 . S YSTEM=$P(X,U,2)
 . I YSQ&($E(Y,YSQ)'="X") W !?YSIND,$P(YSTEM,"#"),$P(X,U,$E(Y,YSQ)+3)
 . I YSQ&($E(Y,YSQ)="X") W !?YSIND,$P(YSTEM,"#"),"missing"
 . I 'YSQ W !?YSIND,$P(YSTEM,"#")
DONE ;
 K YSQ,YSTEM,YSIND
 Q

YTBI ;ALB/ASF-BECK INVENTORY DRIVERS ; 2/20/08 10:38am
 ;;5.01;MENTAL HEALTH;**76,96**;Dec 30, 1994;Build 46
 ;No external references
 S J=1,(YSRP,B)="",YSBEGIN=DT
 I $P(^YTT(601,YSTEST,0),U,6)]"" S YSCH=$P(^(0),U,6),Y=$P(^(0),U,7) D DD^%DT S YSCD=Y I $D(^YTT(601.3,YSCH,0)) S YSCHN=YSCH,YSCH=$P(^(0),U) D CR^YTDRIV
NX ;
 I $D(^YTT(601,YSTEST,"Q",J,0))#2=1 S:$P(^(0),U,2)]"" C=$P(^(0),U,2)
 I $D(^YTT(601,YSTEST,"Q",J,"B")) S K=^("B") S:K'="" B=K
 I '$D(^YTT(601,YSTEST,"Q",J,"I",1,0)) G D1
 W @IOF F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"I",K))  S X=^YTT(601,YSTEST,"Q",J,"I",K,0) W !!?3,X
 W !!!?3,"PRESS THE SPACE BAR TO CONTINUE."
I2 ;
 D RD I X'=" " G:X="*" ^YTAR2 W " ? " G I2
D1 ;
 W @IOF F K=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"T",K))  I $D(^(K,0)) W:^(0) ! W !?3,^(0)
 X:B'="" B
D3 ;
 S YZT=$P($H,",",2) D RD G HOLD:YZT+1>$P($H,",",2) G D4:C[X,BK:X="^",^YTAR2:X="*",WHERE:X="?" W " ? " G D3
D4 ;
 S YSRP=YSRP_X
 ; SKIP LOGIC ****
 I (J=5)&($E(YSRP,4,5)="00") S YSRP=YSRP_"              ",J=19
 I (J=20)&(X=0) S YSRP=YSRP_" ",J=21
 S J=J+1 I $D(^YTT(601,YSTEST,"Q",J)) G NX
 D ^YTFILE Q
RD ;
 R *X:900 S:'$T X=42 G:X<32 RD S X=$C(X) Q
BK ;
 G:J=1 D1 S J=J-1,X=$L(YSRP),YSRP=$S(X>1:$E(YSRP,1,X-1),X=1:"",1:$E(^YTD(601.4,YSDFN,1,YSENT,J\200),1,199)) G NX
WHERE ;
 W !,YSTESTN,"  QUESTION # ",J,! X:B]"" B G D3
HOLD ;
 W @IOF,#,"Please read each question carefully!",$C(7) R X:3 K X G D1
BAI ;
 W ?$X+3,$S(R<10:"normal",R<19:"mild to moderate",R<30:"moderate to severe",R<64:"severe",1:""),!!,^YTT(601,YSTEST,"G",1,1,1,0),! S X=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1) G B2:X'?.E1"3".E
 W !!?7,"Items marked Severe",! F I=1:1:21 I $E(X,I)=3 S Y=^YTT(601,YSTEST,"Q",I,"T",1,0) W:$X+$L(Y)>79 ! W $E(Y,1,$L(Y)-1),", "
B2 ;
 Q:X'?.E1"2".E
 W !!?7,"Items marked Moderate",! F I=1:1:21 I $E(X,I)=2 S Y=^YTT(601,YSTEST,"Q",I,"T",1,0) W:$X+$L(Y)>79 ! W $E(Y,1,$L(Y)-1),", "
 Q
BSIRPT ;
 W !!,"Responses",! S X=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1),YSLFT=0
 F I=1:1:21 S Y=$E(X,I) I Y?1N S K=0 F  S K=$O(^YTT(601,YSTEST,"Q",I,"T",K)) Q:K'>0  S Z=^(K,0) I $E(Z)=Y D:$Y+4>IOSL WAIT W !,$J(I,2),".(",Y,") ",$P(^(0),"  ",2,9) D BSI2 Q
 Q:X'?.E1"X".E  W !!,"The following questions were skipped: " F I=1:1:20 W:$E(X,I)="X" I,", " ;ASF 9/15/04 from refused
 Q
BSI2 ;
 F  S K=$O(^YTT(601,YSTEST,"Q",I,"T",K)) Q:K'>0  S Z=^(K,0) Q:'Z  W !?3,Z
 Q
WAIT ;
 ;  Added 5/6/94 LJA
 N A,B,B1,C,D,E,E1,F,F1,G,G1,H,I,J,J1,J2,J3,J4,K,L,L1,L2,M,N
 N N1,N2,N3,N4,P,P0,P1,P3,R,R1,S,S1,T,T1,T2,TT,V,V1,V2,V3
 N V4,V5,V6,W,X,X0,X1,X2,X3,X4,X7,X8,X9,Y,Y1,Y2,Z,Z1,Z3
 ;
 I IOST'?1"C".E D DTA^YTREPT Q
 F I0=1:1:IOSL-$Y-2 W !
 W $C(7) S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(YSUOUT),YSLFT=$D(DIRUT) W @IOF Q
BDI ;
 S YSTY="*",R=0,Z(1)=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1) F I=1:1:18,21,22 S R=R+$E(Z(1),I)
 S:$E(Z(1),20)="N" R=R+$E(Z(1),19) D REPT^YTREPT S YSLFT=0 W ?$X+3,$S(R<10:"asymptomatic",R<19:"mild-moderate",R<30:"moderate-severe",R>29:"extremely severe",1:""),!!,^YTT(601,YSTEST,"M",24,1,1,0),!,^YTT(601,YSTEST,"M",24,1,2,0)
 F Z=3,2,1 Q:YSLFT  I Z(1)[Z W !!?3,$S(Z=3:"Severe",Z=2:"Moderate",1:"Mild")," Symptoms:" F I=1:1:22 S Z(2)=$S(Z=3:1,Z=2:2,1:3) W:$E(Z(1),I)=Z !,$P(^YTT(601,YSTEST,"M",I,1,1,0),U,Z(2)) D:$Y+4>IOSL WAIT Q:YSLFT
 Q
BDI2 ;
 S R=0,(G,Z)=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 S Z1=$E(Z,16)
 S Z1=$S(Z1=0:0,Z1=1:1,Z1=2:1,Z1=3:2,Z1=4:2,Z1=5:3,Z1=6:3,1:"X")
 S Z2=$E(Z,18)
 S Z2=$S(Z2=0:0,Z2=1:1,Z2=2:1,Z2=3:2,Z2=4:2,Z2=5:3,Z2=6:3,1:"X")
 S Z=$E(Z,1,15)_Z1_$E(Z,17)_Z2_$E(Z,19,21)
 F I=1:1:21 S R=R+$E(Z,I)
 S S=$S(R>28:"severe",R>19:"moderate",R>13:"mild",R<12:"minimal",1:"")
 Q:YSTY'["*"
 S (YSTOUT,YSUOUT)=0
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT W !!?(72-$L(X)\2),X,!!!?(A-9\2+L1),"S C A L E",?(L2+1),"RAW  ",B,!
 W !?L1,$P(^YTT(601,YSTEST,"S",1,0),U,2),?L2,$J(R,4,0)
 W "   ",S
 F J=3,2,1 W:Z[J !!,$S(J=3:"Severe",J=2:"Moderate",J=1:"Mild",1:"")," symptoms",! D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . F K=1:1:21 I $E(Z,K)=J W:$X>60 ! W:$X>3 "," W $P(^YTT(601,YSTEST,"G",1,1,K,0),".",2,9) D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 .. I K=16 S G1=$E(G,16) W $S(G1=1:" (more)",G1=3:" (more)",G1=5:" (more)",G1=2:" (less)",G1=4:" (less)",G1=6:" (less)",1:"")
 .. I K=18 S G1=$E(G,18) W $S(G1=1:" (less)",G1=2:" (more)",G1=3:" (less)",G1=4:" (more)",G1=5:" (less)",G1=6:" (more)",1:"")
 Q:YSTOUT!YSUOUT  D:IOST?1"C-".E SCR^YTREPT
 Q:YSTOUT!YSUOUT  D IR^YTREPT
 Q:YSTOUT!YSUOUT  D:IOST?1"C-".E SCR^YTREPT

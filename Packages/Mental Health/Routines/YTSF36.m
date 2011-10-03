YTSF36 ;ALBANY/ASF SF-36 HEALTH SURVEY ;1/12/96  10:33
 ;;5.01;MENTAL HEALTH;**10,19**;Dec 30, 1994
SCOR ;GET RESPONSES
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 ;ARRAY SET
 F I=1:1:36 S YSX(I)=$E(X,I)
RV ;REVERSE SCORE 10 ITEMS
 F I=21,22,1,34,36,23,27,20,26,30 I YSX(I)'="X" S YSMX=$P(^YTT(601,YSTEST,"Q",I,0),U,2),YSMX=$E(YSMX,$L(YSMX)-1)+1,YSX(I)=YSMX-YSX(I)
 ;RECODE 3 ITEMS 
  S YSX(1)=YSX(1)+$S($E(X,1)=2:.4,$E(X,1)=3:.4,1:0)
  S:YSX(21)'="X" YSX(21)=YSX(21)+$S($E(X,21)=2:.4,$E(X,21)=3:.2,$E(X,21)=4:.1,$E(X,21)=5:.2,1:0)
 I ($E(X,22)=1)&($E(X,21)=1) S YSX(22)=6
 I $E(X,21)="X"&(YSX(22)'="X") S YSX(22)=YSX(22)+$S($E(X,22)=1:1,$E(X,22)=2:.75,$E(X,22)=3:.5,$E(X,22)=4:.25,1:0)
RAWER ;RAW CALCULATIONS
 K S S R="" F J=1:1:9 S YSN=0,YSXN=0 D RAW1 D:YSXN>0 MISS
 G STND Q
RAW1 S YSKK=^YTT(601,YSTEST,"S",J,"K",1,0)
 F I=1:2 S A=$P(YSKK,U,I) Q:A=""  D RAW2
 Q
RAW2 S $P(R,U,J)=$P(R,U,J)+YSX(A)
 I YSX(A)="X" S YSXN=YSXN+1
 S YSN=YSN+1
 Q
MISS ;MISSING ITEM RECODE BY MEANS
 S B=$P("10^4^2^5^4^2^3^5^1",U,J)
 I YSXN/B>.5 S $P(R,U,J)="*" Q
 S Y=$P(R,U,J)/(YSN-YSXN)
 S $P(R,U,J)=$P(R,U,J)+(Y*YSXN)
 Q
STND ;
 S S="",J=1,P="M"
ST ;
 S A=$P(R,U,J) G:A=""!(J=9) REPT
 S X=^YTT(601,YSTEST,"S",J,P),S=S_$J((A-$P(X,U)/$P(X,U,2)*100),0,2)_"^",J=J+1 G ST
REPT ;
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),L1=58-A\2,L2=L1+A+7 S:A<9 A=9
 D DTA^YTREPT W !!?(72-$L(X)\2),X,!!!?(A-9\2+L1),"S C A L E",?(L2+1),"RAW       0-100",!
 F J=1:1 S YSRS=$P(R,U,J) Q:YSRS=""  D
 .  D:IOST?1"C-".E&($Y>21) SCR Q:YSTOUT!YSUOUT
 .  W !?L1,$P(^YTT(601,YSTEST,"S",J,0),U,2)
 .  W ?L2,$S(YSRS="*":"   *",1:$J(YSRS,6,2))
 .  I YSRS="*" W ?(L2+10),"   *"
 .  I $P(^YTT(601,YSTEST,"S",J,0),U,2)="Reported Health Transition" D LS Q
 .  W ?(L2+10),$J($P(S,U,J),6,2)
 W !! F YSZZ=0:1 S YSTXT=$T(TEXT+YSZZ) Q:YSTXT=""  W ?7,$P(YSTXT,";;",2),!
 S YSNOITEM="ITMS^YTSF36"
 Q
 ;
LS ;
 W ?(L2+10),$S(YSRS=1:"Much Better",YSRS=2:"Somewhat Better",YSRS=3:"About the Same",YSRS=4:"Somewhat Worse",YSRS=5:"Much Worse",1:" ")
 Q
 ;
ITMS ;ITEM OUTPUT
 W:$Y>5 @IOF D DTA^YTREPT S (YSOUT,YSUOUT)=0,A=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 W !!?15,"Item Responses",!
 S K=0 F I=1:1 S K=$O(^YTT(601,YSTEST,"G",K)) Q:K'>0  D ITMS1
 Q
ITMS1 S J=0 F I=1:1 S J=$O(^YTT(601,YSTEST,"G",K,1,J)) Q:J'>0  S YSX=^(J,0) D:IOST?1"C-".E&($Y>21) SCR Q:YSOUT!YSUOUT  D ITMS2
 Q
ITMS2 I YSX?1N.E S YSN=+YSX W !,YSX Q
 I (J=1)&(YSX?1U.E) W !!?15,"<<<",YSX,">>>" Q
 I YSX?1"^".E W !?5,"Answer= ",$P(YSX,"^",$E(A,YSN)+1) Q
 W !,YSX
 Q
DONE ;
 K YSTY,X,Y,A,B,K,YSKK,YSXN,YSN,YSX,L,L1,L2,M,J,YSIT,YSRS,I,P,YSMX,YSTL,YSTTL,YSTXT,YSZZ
 Q
 ;
SCR ;
 N A,B,B1,C,D,E,E1,F,F1,G,G1,H,I,J,J1,J2,J3,J4,K,L,L1,L2,M,N
 N N1,N2,N3,N4,P,P0,P1,P3,R,R1,S,S1,T,T1,T2,TT,V,V1,V2,V3
 N V4,V5,V6,W,X,X0,X1,X2,X3,X4,X7,X8,X9,Y,Y1,Y2,Z,Z1,Z3
 ;
 F I0=1:1:(IOSL-$Y-2) W !
 N DTOUT,DUOUT,DIRUT,X
 S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT),YSLFT=$D(DIRUT)
 W @IOF Q
 ;
TEXT ;
 ;;The numbers for all but the last scale reflect the degree to
 ;;which the individual has given answers in the direction of
 ;;good health.  The 0-100 column will contain a zero if none
 ;;of the answers are in the direction of good health, and 100
 ;;if all the answers are in the direction of good health.
 ;;The last scale reflects how individuals rate the change in
 ;;their health over the prior year and ranges from 1 (Much Better)
 ;;to 5 (Much Worse).
 ;;
 ;
EOR ;YTSF36

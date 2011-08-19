YTBSI18 ;ALB/ASF-BRIEF SYMPTOM INVENTORY 18 ;8/1/02  12:24
 ;;5.01;MENTAL HEALTH;**76**;Dec 30, 1994
MAIN ;
 N X,T,J,RR,T,X,X1,YSAVE,YSINV
 S (T,X1,YSINV)=0
 S R="^^^^^^",S=R
 D RD
 D SOM
 D DEP
 D ANX
 I ($P(R,U,1)=-1)!($P(R,U,2)=-1)!($P(R,U,3)=-1) S YSINV=1
 S $P(R,U,4)=$P(R,U,1)+$P(R,U,2)+$P(R,U,3)
 F I=1:1:4 S $P(R,U,I+4)=$P(R,U,I) ;duplicate scales 1-4 TO 5-8
 D:YSINV=0 TSCOR
 D:YSTY["*" REPT
 Q
RD S X=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 F I=1:1:18 S T=T+$E(X,I) S:$E(X,I)="X" X1=X1+1
 S YSAVE=$J(T/(18-X1),1,0)
 Q
SOM ;
 S X1=0
 F I=1,4,7,10,13,16 D
 . S RR=$E(X,I)
 . S:RR="X" X1=X1+1,RR=YSAVE
 . S $P(R,U,1)=$P(R,U,1)+RR
 . S:X1>2 $P(R,U,1)=-1
 Q
DEP ;
 S X1=0
 F I=2,5,8,11,14,17 D
 . S RR=$E(X,I)
 . S:RR="X" X1=X1+1,RR=YSAVE
 . S $P(R,U,2)=$P(R,U,2)+RR
 . S:X1>2 $P(R,U,2)=-1
 Q
ANX ;
 S X1=0
 F I=3,6,9,12,15,18 D
 . S RR=$E(X,I)
 . S:RR="X" X1=X1+1,RR=YSAVE
 . S $P(R,U,3)=$P(R,U,3)+RR
 . S:X1>2 $P(R,U,1)=-1
 Q
TSCOR ;
 F I=1:1:8 S $P(S,U,I)=$P(^YTT(601,YSTEST,"S",I,YSSX),U,$P(R,U,I)+1)
 Q
REPT ;
 D DTA^YTREPT
 S X=$P(^YTT(601,YSTEST,"P"),U)
 W !!?(72-$L(X)\2),X
 I YSINV W !!,"Invaild administration: too many ommisions" Q  ;--> out
 W !!?10,"Community Norms"
 W !?31,"Raw   Tscore",!
 F J=1:1:4 D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT  W !?3,$P(^YTT(601,YSTEST,"S",J,0),U,2),?30,$J($P(R,U,J),4,0),?35,$J($P(S,U,J),4,0)
 W !!?10,"Oncology Norms"
 W !?31,"Raw   Tscore",!
 F J=5:1:8 D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT  W !?3,$P($P(^YTT(601,YSTEST,"S",J,0),U,2),"("),?30,$J($P(R,U,J),4,0),?35,$J($P(S,U,J),4,0)
 Q
TEST S YS("DFN")=YSDFN,YS("ADATE")=DT,YS("CODE")="BSI18" D SCOREIT^YTAPI2(.YSDATA,.YS)

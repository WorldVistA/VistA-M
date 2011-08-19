YTPAI ;ASF/ALB- PAI TEST ;7/14/00  10:26
 ;;5.01;MENTAL HEALTH;**10,66**;Dec 30, 1994
 ;
 ;Reference to $$SQRT^XLFMTH supported by IA #10105
 ;
 S YSLFT=0,YSNOITEM="DONE^YTPAI"
MAIN ;
 S (R,S)="^",YSMX=4
 D RD
 I $L(X,"X")>18 D DTA^YTREPT W !!!!,"PAI: Too many missing items to score" D:IOST?1"C".E SCR^YTREPT G OUT
 D SCOR,STND
 D ^YTPAI1 ;profile
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 D SUBS^YTPAI1
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 D ADDIT
 D FIT
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
 D CRIT ;critical items
 G DONE:YSLFT D:IOST?1"C-".E SCR^YTREPT
OUT D DTA^YTREPT,IR^YTPAI1
DONE K S,R,A,YSXBAR,YSYBAR,YSXSD,YSYSD Q
RD S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)_^YTD(601.2,YSDFN,1,YSET,1,YSED,2) Q
SCOR ;
 F YSKK=2:1:53 I $D(^YTT(601,YSTEST,"S",YSKK,"K")) S Y=^YTT(601,YSTEST,"S",YSKK,"K",1,0),YSTL=0 D KK S $P(R,U,YSKK)=YSTL
FS ;full scales
 F I=5,9,13,17,21,25,29,33,38,44 S $P(R,U,I)=$P(R,U,I+1)+$P(R,U,I+2)+$P(R,U,I+3) S:I=33 $P(R,U,I)=$P(R,U,I)+$P(R,U,I+4)
ICNR ;score ICN
 S YSICN=0
 S Y=(5-$E(X,75))-(5-$E(X,115)) D A
 S Y=$E(X,4)-$E(X,44) D A
 S Y=$E(X,60)-$E(X,100) D A
 S Y=$E(X,145)-(5-$E(X,185)) D A
 S Y=$E(X,65)-(5-$E(X,246)) D A
 S Y=$E(X,102)-(5-$E(X,103)) D A
 S Y=$E(X,22)-(5-$E(X,142)) D A
 S Y=(5-$E(X,301))-$E(X,140) D A
 S Y=5-(5-$E(X,270))-$E(X,53) D A
 S Y=5-(5-$E(X,190))-$E(X,13) D A
 S $P(R,U,1)=YSICN
 S X=^YTT(601,YSTEST,"S",1,"M"),$P(S,U,1)=$J((YSICN-$P(X,U)/$P(X,U,2)*10+50),0,0)
 Q
A ;icn absolutes
 S:Y<0 Y=-Y S YSICN=YSICN+Y Q
KK S YSNUMX=0
 F I=1:2 Q:$P(Y,U,I)=""  S YSIT=$P(Y,U,I),A=$P(Y,U,I+1),B=$E(X,YSIT),YSTL=YSTL+$S(B="X":0,A="D":B-1,1:YSMX-B) S:B="X" YSNUMX=YSNUMX+1
 I (YSNUMX/(I-1))>.2 S YSTL="X"
 Q
STND ;stanard T scores
 F J=2:1:53 S A=$P(R,U,J) S:A?.N X=^YTT(601,YSTEST,"S",J,"M"),S(J)=$J((A-$P(X,U)/$P(X,U,2)*10+50),0,0) S:A="X" S(J)="X" S S=S_S(J)_U
 Q
ADDIT ;additional indexes
 D DTA^YTREPT
 S YSINDX=0
 I $P(S,U,3)>109 S YSINDX=YSINDX+1
 I $P(S,U,3)-$P(S,U,2)>19 S YSINDX=YSINDX+1
 I $P(S,U,2)-$P(S,U,1)>14 S YSINDX=YSINDX+1 ;asf 7/14/00 =YSINDX+2
 I $P(S,U,27)-$P(S,U,26)>14 S YSINDX=YSINDX+1
 I $P(S,U,27)-$P(S,U,28)>14 S YSINDX=YSINDX+1
 I $P(S,U,24)-$P(S,U,23)>14 S YSINDX=YSINDX+1
 I ($P(S,U,17)>84)&($P(S,U,51)>44) S YSINDX=YSINDX+1
 I $P(S,U,40)-$P(S,U,39)>9 S YSINDX=YSINDX+1
 W !?2,"Malingering Index = ",YSINDX
 S YSINDX=0 ; RESET
 I $P(S,U,4)>44 S YSINDX=YSINDX+1 S:$P(S,U,4)>49 YSINDX=YSINDX+1
 I $P(S,U,51)>44 S YSINDX=YSINDX+1
 I $P(S,U,40)-$P(S,U,39)>9 S YSINDX=YSINDX+1
 I $P(S,U,41)-$P(S,U,39)>9 S YSINDX=YSINDX+1
 I $P(S,U,23)-$P(S,U,24)>9 S YSINDX=YSINDX+1
 I $P(S,U,14)-$P(S,U,11)>9 S YSINDX=YSINDX+1
 I $P(S,U,52)-$P(S,U,46)>14 S YSINDX=YSINDX+1
 I $P(S,U,22)-$P(S,U,49)>9 S YSINDX=YSINDX+1
 W !?2,"Defensivness Index = ",$J(YSINDX,3)
XBAR ;
 S YSINDX=0 F I=5,9,13,17,21,25,29,33,38,42,43 S YSINDX=YSINDX+$P(S,U,I)
 W !?2,"Mean Clinical Elevation = ",$J(YSINDX/11,4,0)
 Q
FIT ;coeff of fit
 W !!,"Database Profile",?30,"Coefficient of Fit"
 K A F K=1:1:41 D FIT1
 S N=0 F  S N=$O(A(N)) Q:N'>0  S K=0 F  S K=$O(A(N,K)) Q:K'>0  G DONE:YSLFT D:IOST?1"C-".E&($Y+4>IOSL) SCR^YTREPT D FITW
 Q
FITW W !,$P(^YTT(601,YSTEST,"G",1,1,K,0),U,1),?35,$J(9-N,6,3)
 Q
FIT1 S (X1,Y1,X12,Y12,YSXY)=0,N=1
 S YSFIT=^YTT(601,YSTEST,"G",1,1,K,0)
 F I=1,2,3,4,5,9,13,17,21,25,29,33,38,42,43,44,48:1:53 D FITLOOP
 ;stanadrd dev t scores
 S YSXBAR=X1/22
 S YSXSD=$$SQRT^XLFMTH(X12/22-(YSXBAR*YSXBAR))
 ;standard dev fit data
 S YSYBAR=Y1/22
 S YSYSD=$$SQRT^XLFMTH(Y12/22-(YSYBAR*YSYBAR))
 ; CORR
 S YSR=((YSXY/22)-(YSXBAR*YSYBAR))/(YSXSD*YSYSD)
 S A(9-YSR,K)=""
 Q
FITLOOP ;get individual items
 S N=N+1,X1=X1+$P(S,U,I),X12=X12+($P(S,U,I)*$P(S,U,I)),Y1=Y1+$P(YSFIT,U,N),Y12=Y12+($P(YSFIT,U,N)*$P(YSFIT,U,N)),YSXY=YSXY+($P(S,U,I)*$P(YSFIT,U,N))
 Q
CRIT ;
 D RD,DTA^YTREPT
 W !?10,"Critical Items",!!,"Delusions and Hallucinations"
 F I=90,130,170,210,309 D CRITW
 W !!,"Potential for Self-Harm" F I=100,183,206,220,340 D CRITW
 W !!,"Potential for Aggression" F I=21,61,101,181 D CRITW
 W !!,"Substance Abuse" F I=55,222 D CRITW
 W !!,"Potential Malingering" F I=9,49,129,249 D CRITW
 W !!,"Ureliability/Resistance" F I=31,71,311 D CRITW
 W !!,"Traumatic Stressors" F I=34,114,194,274 D CRITW
 Q
CRITW ; write critical items
 Q:$E(X,I)<2
 W !,$S($E(X,I)=2:"ST",$E(X,I)=3:"MT",1:"VT"),"  "
 W ^YTT(601,YSTEST,"Q",I,"T",1,0)
 W:$D(^YTT(601,YSTEST,"Q",I,"T",2,0)) !?7,^YTT(601,YSTEST,"Q",I,"T",2,0)
 Q

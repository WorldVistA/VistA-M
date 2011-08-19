DENTDCM ;WASH ISC/TJK-MODIFIED DICM ROUTINE  ;03:35 PM  Jul 27, 1987;11/26/90  3:15 PM
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 S:'$D(DICR(1)) DICR=0 I $A(X)=34,X?.E1"""" G N
 G:$D(^DD(+DO(2),0,"LOOK")) @^("LOOK") I DIC(0)["U" S DD=0 G W
R S %="B",Y=+DO(2),%Y=.01,DD=0 G 1
Z S %=$O(^DD(+DO(2),0,"IX",%)) S:%="" %=-1 S Y=$O(^(%,0)) S:Y="" Y=-1 S %Y=$O(^(Y,0)) S:%Y="" %Y=-1 S DD=1
1 G 2:Y<0,Z:$D(DICR(U,Y,%Y)),Z:D'=%&(DIC(0)'["M"),Z:'$D(^DD(Y,%Y,0)) S DICR(U,Y,%Y)=0,DS=^(0) I $D(^(7)) D RS K DS X ^(7) G Y
 S DIX=Y F Y="P","D","S","V",-1 I $P(DS,U,2)[Y D A D:'Y ^DENTDCM1,D Q
Y G R:Y<0
2 G K:Y+1 I X?.E1L.E,DIC(0)'["X" D RS D LC^DENTDCM1 G K:Y+1
 S DS="",DIX=$P(X,",",1) F %=2:1 S DD=$P(X,",",%) I DD'["""" S:$A(DD)=32 DD=$E(DD,2,999) Q:$L(DD)*2+$L(DS)>200!(DD="")  S DS=DS_" I %?.E1P1"""_DD_""".E!(D'=""B""&(%?1"""_DD_""".E))"
 ;Naked refernces in 2+3 is refs by line tag: 1
 I DS]"",DIC(0)'["X" D RS S X=DIX,DS="S %=$P(^(0),U,1)"_DS,DIC(0)=DIC(0)_"D" D 7 G K:Y+1
 I $L(X)>30 D RS S Y="DICR("_DICR_")",DS=$S(DIC(0)["X":"I $P(^(0),U,1)="_Y,1:"I '$L($P(^(0),"_Y_",1))"),X=$E(X,1,30) D 7
K S DD=$D(DICR(DICR,6)) K:'DICR DICR
 I Y+1 K DIC("W") G R^DENTDC:DIC(0)["Z",Q^DENTDC
W D U G:'$T NL:DIC(0)["N",DD I DO(2)'["Z" S Y=0 F DS=1:1 S @("Y=$O("_DIC_"Y))") S:Y="" Y=-1 Q:Y'>0  W:DIC(0)["E"&(DS#20=0) ".." I $P(^(Y,0),U,1)=X X:$D(DIC("S")) DIC("S") I  S DIY="" G GOT^DENTDC
NL I '$D(DICR) D NQ G GOT^DENTDC:$T
DD G B:DD
L I DIC(0)["L" K DD G ^DENTDCN
B G O^DENTDC1
 ;
N D RS S X=$E(X,2,$L(X)-1),DS=^DD(+DO(2),.01,0),%=D F Y="P","D","S","V" I $P(DS,U,2)[Y K:Y="P" DO D ^DENTDCM1 Q
 S Y=-1 D L:$D(X),E G B:Y<0,2
 ;
A G %:'DD I '$D(^DD(DIX,%Y,1,DD)) S DD=$O(^(DD)) S:DD="" DD=-1 G A:DD>0 S Y=-1 Q
 I $S($D(^(DD,0)):$P(^(0),U,3,9)]"",1:1) S DD=DD+1 G A
% S DICR(DICR+1,4)=% I %'="B"!(DIC(0)'["L") S DICR(DICR+1,8)=1
 I $D(DF) S DICR(DICR+1,9)=DF K DF
RS S DICR=DICR+1,DICR(DICR)=X,DICR(DICR,0)=DIC(0),DD="A" D DZ S DD="Q"
DZ S DIC(0)=$P(DIC(0),DD,1)_$P(DIC(0),DD,2) Q
 ;
D S (D,DF)=DICR(DICR,4),DD="M" S:D="B" DIC(0)=DIC(0)_"S" D DZ I $D(DS),$P(DS,U,2)["V" S DD="A" D DZ
RCR S DICRS=1
DIC ;
 I $D(DICR(DICR,8)) S DD="L" D DZ
 S Y=-1 I $D(X),$L(X)<31 D RENUM^DENTDC1
 S:DIC(0)["L" DICR(DICR-1,6)=1 K:$D(DICR(DICR,4)) DF
E S D="B",%=DICR,X=DICR(%),DIC(0)=DICR(%,0),DICR=%-1 S:$D(DICR(%,9)) (D,DF)=DICR(%,9) K DICRS,DICR(%) D DO^DENTDC1:'$D(DO) Q
 ;
U I @("$O("_DIC_"""A[""))=""""")
 Q
 ;
NQ I $L(X)<14,X?.NP,+X=X,@("$D("_DIC_"X,0))") S Y=X D S^DENTDC
 Q
 ;
SOUNDEX I DIC(0)["E",'$D(DICRS) W "  " D RS,SOU S DD="L" D DZ,RCR Q:Y>0
 G R
 ;
7 S Y=-1,%=$S($D(DIC("S")):DIC("S"),1:1) I $D(DS),'$D(DIC("S1")) S DIC("S")=DS,DD="L" S:'% DIC("S")=DIC("S")_" X DIC(""S1"")",DIC("S1")=% D:X]"" DZ,F^DENTDC K DIC("S") S:$D(DIC("S1")) DIC("S")=DIC("S1") K DIC("S1")
 G E
 ;
SOU G SOU^DENTDCM1

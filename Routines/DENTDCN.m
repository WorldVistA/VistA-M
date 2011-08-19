DENTDCN ;WASH ISC/TJK-MODIFIED DICN ROUTINE  ;10:24 AM  Jul 28, 1987;12/02/91  11:24 AM
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 S DO(1)=1
 I $S($D(DLAYGO):DO(2)\1-(DLAYGO\1),1:1),DUZ(0)'="@",$D(^DIC(+DO(2),0,"LAYGO")) F %=1:1 I DUZ(0)[$E(^("LAYGO"),%) G B:%>$L(^("LAYGO")) Q
 I $D(DD) S X=DD D N^DENTDCN1 G I:$D(X),B
 D DS S DIX=X I X?.NP,X,DIC(0)["E",'$D(DICR),DS'["DINUM",$P(DS,U,2)'["N",DIC(0)["N"!$D(^DD(+DO(2),.001,0)) D N^DENTDCN1 I $D(X) S DD=X G I
 S X=DIX D VAL G I:$D(X)
 S X=DIX
B K Y(0) G BAD^DENTDC1
 ;
1 I '$D(DIC("S")) W " (THE ",Y,$S(Y#10=1&(Y#100-11):"ST",Y#10=2&(Y#100-12):"ND",Y#10=3&(Y#100-13):"RD",1:"TH"),$S('$D(^DD(+DO(2),0,"UP")):"",1:" FOR THIS "_$O(^DD(^("UP"),0,"NM",0))),")"
YN ;
 W "? ",$P("YES// ^NO// ",U,%)
RX R %Y:DTIME E  S DTOUT=1,%Y=U W *7
 S:%Y]""!'% %=$A(%Y),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I '%,%Y'?."?" W *7,"??",!?4,"ANSWER 'YES' OR 'NO': " G RX
 W:$X>73 ! W $P("  (YES)^  (NO)",U,%) Q
 ;
DS S DS=^DD(+DO(2),.01,0) Q
 ;
VAL I X'?.ANP!($A(X)=45) K X Q
 I $P(DS,U,2)["*" S:DS["DINUM" DINUM=X Q
 S %=$F(DS,"%DT=""E"),DS=$E(DS,1,%-2)_$E(DS,%,999) X $P(DS,U,5,99) Q
 ;
I I DIC(0)["E",DO(2)'["A" S DJC=+DO(2),Y=X D Y^DENTDCM2 K DJC X:$Y>20 DJCP W *7,!?3,"ARE YOU ADDING " W:'$D(DD) "'"_Y_"' AS " S %=$P(DO,U,1) W !?7 W "A NEW "_% S %=0,Y=$P(DO,U,4)+1 D 1 G B:%-1
 G FILE:'$D(DD)
R D DS W !?3,$P(DS,U,1),": " R X:DTIME S:'$T X=U
 G B:X[U,R:X="" D VAL I '$D(X) W *7,"??" W:$D(^DD(+DO(2),.01,3)) !,^(3) G R
FILE D:'$D(DO) DO^DENTDC1 F DIX=0:0 S DIX=$O(^DD(+DO(2),.01,"LAYGO",DIX)) Q:DIX'>0  I $D(^(DIX,0)) X ^(0) I '$T S Y=-1 G A^DENTDC:$D(DO(1)),Q^DENTDC
 S DIX=X
F1 S X=$P(DO,U,3) D INCR S X=X\DIY*DIY+DIY
 I $D(DINUM) S X=DINUM D INCR
F2 I $D(@(DIC_"X)")) S X=X\DIY*DIY+DIY G B:$D(DINUM),F2
 S Y=$P(DO,"^",2) I $D(DD) S X=DD
 E  I 'Y,DUZ(0)'="@" G LOCK
 I DIC(0)["E",$D(^DD(+Y,.001,0)) G NUM^DENTDCN1
LOCK L @(DIC_"X):1") I $D(@(DIC_"X)"))!'$T L  W *7 G F1
 ;Nake reference in LOOK+4 is refs. in Line Tag: LOCK.
 ;DIC is set to ^DENT(xxx, where xxx is a file number.
 S ^(X,0)=DIX,DD=0 L  K D S:$D(DA)#2 D=DA S DA=X,X=DIX
 I $D(@(DIC_"0)")) S ^(0)=$P(^(0),"^",1,2)_"^"_DA_"^"_($P(^(0),"^",4)+1)
IX S DS=X,DD=$O(^DD(+DO(2),.01,1,DD)) S:DD="" DD=-1 I DD>0 G RIX^DENTDCN1:^(DD,0)["TRIGGER"!(^(0)["BULL") X ^(1) S X=DS G IX
 I DIC(0)["E"&($O(^DD(+DO(2),0,"ID",0))>0)!$D(DIC("DR")) G ^DENTDCN1
D ;
 S Y=DA_"^"_X_"^"_1 S:$D(D)#2 DA=D G R^DENTDC
 ;
INCR S DIY=1 I $P(DO,U,2)>1 F %=1:1:$L($P(X,".",2)) S DIY=DIY/10
 Q

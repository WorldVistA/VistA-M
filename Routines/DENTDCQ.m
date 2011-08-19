DENTDCQ ;WASH ISC/TJK-MODIFIED DICQ ROUTINE  ;9/8/92  08:16
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 S DZ=X D:DIC(0)]"" DQ S:$D(DZ) X=DZ K DZ,XQH G A^DENTDC
 ;
DQ W ! D:'$D(DO) DO^DENTDC1 K DS,%Y I DO="0^-1" K DO W "  Pointed-to File does not exist!" Q
 S DD="",Y=$P(DO,U,4),DIY=DO,DIX=D D DIY
 S X=$S($D(^DD(+DO(2),.001,0)):$P(^(0),U,1),DIC(0)["N":"NUMBER",1:""),DIZ=X]"",DIW=^DD(+DO(2),.01,0)
 S DIW=$P(DIW,U,2,3) G:$D(^DD(+DO(2),0,"QUES")) @^("QUES") I DIZ S DS=.001 D DS
IX I $D(DEBDIC),DEBDIC=DIC,$D(DEDF) S DIX=DEDF
 S X=$O(^DD(+DO(2),0,"IX",DIX,-1)) S:X="" X=-1 I X'<0 S DS=$O(^(X,0)) S:DS="" DS=-1 I $D(^DD(X,DS,0)) S %=$P(^(0),U,2,3),X=$P(^(0),U,1) D DS
 I @("$D("_DIC_"DIX))>9!$D(DF)"),DD="" S DD=DIX,DIW=% S:'Y Y=2 S:'$D(^(DD)) Y=0,DIZ=0
 S DIX=$O(@(DIC_"DIX)")) S:DIX="" DIX=-1 G IX:DIC(0)["M"&'DIX I DD="" S DIZ=1,YMLH=$O(^("AZ")) S:YMLH'=""&'YMLH Y=0
 I $D(DZ)#2 G C:DZ["??" S:DZ["BAD" Y=0
 W " ANSWER WITH ",$P(DO,U,1) S DS=0
 F X=1:1 S DS=$O(DS(DS)) S:DS="" DS=-1 Q:DS<0  W $P(", OR",U,X>1) W:$X+$L(DS(DS))>70 !?4 W " ",DS(DS) I $Y>21 R !,"Press <RETURN> to Continue: ",%Y:DTIME X DJCP
 K DS W $E(":",Y) ;G 0:'Y
20 D DCS^DENTDNQ G C:Y<6 W !," DO YOU WANT THE ENTIRE " W:DO(2)'["s"&'$D(DIC("S"))&'$D(DF) Y,"-ENTRY " W $P(DO,U,1)," LIST" S %=0 D YN^DENTDCN S:%=1 %Y=1 I %Y'="??" S %Y=$E(%Y,2,99)
 G 0:%#2=0!(%<0&(%Y="")),C:%Y=""
 S DIZ=$S(+%Y=%Y:1,DD]"":0,1:DIZ) I +%Y'=%Y G 20:DD="" I $P(DIW,U,1)["D" S DS=Y,X=%Y,%DT="T" D ^%DT K %DT S %Y=Y,Y=DS,DIZ=0 I %Y<0 W *7 G 20
C I $Y>20 D CONT^DENTDCQ1 Q:%Y=U  X DJCP
 D DCS^DENTDNQ W:Y>1&(DZ'="???") !,"CHOOSE FROM:" S X=$P(" D S Q:$G(%Y)=U  I ",U,$D(DIC("S"))!$D(DO("SCR")))
 I DIZ S DS="I $D(^(Y,0))#2 S X=$P(^(0),""^"",1)"_X_" W"_$S(DO(2)'["D":"",1:":$L(Y)<8")_" Y,?$X+5-$L(Y),"" """,DIX="S Y=$O("_DIC_"Y)) S:Y="""" Y=-1 I Y'>0" G A
 S DIX="S X=$O("_DIC_""""_DD_""",X)) I X=""""",DS=$S(X]""!$D(DIC("W")):"F Y=0:0 S Y=$O("_DIC_""""_DD_""",X,Y)) S:Y="""" Y=-1 Q:Y<0 "_$P(" I $D(^(Y))#2,'^(Y)",1,DD="B")_" I $D("_DIC_"Y,0))"_X,1:"I 1")_" W:$X>5 !?3"
A S X="X"
D S Y=$P(DIW,U,1) I Y["D" S DIY=27,X=" S %="_X_" D DT" G ^DENTDCQ1
 I Y["P",$P(DIW,U,2)["(" S DIY=U_$P(DIW,U,2),X="$S($D("_DIY_X_",0))#2:$P(^(0),""^"",1),1:"_X_")" I @("$D("_DIY_"0))") S DIY=^(0) D DIY S DIW=$P(^(0),U,2,3) G D
 I Y["S",Y[U S DS(95)=$P(DIW,U,2),X="$P($P(DS(95),"_X_"_"":"",2),"";"",1)"
 I Y["V" S X=" S %Y=Y,Y=X,DJC=+DO(2) D Y^DENTDCM2 K DJC W Y S Y=%Y" G ^DENTDCQ1
 S X=" W "_X
M G ^DENTDCQ1
 ;
0 K DIW,DIZ,DS G 0^DENTDCQ1:DIC(0)["L" Q
 ;
DIY S DIY=$P(^DD(+$P(DIY,U,2),.01,0),"$L(X)>",2),DIY=$S(DIY:DIY,1:30)+7 Q
 ;
SOUNDEX S Y=0 G IX
 ;
DS S:DO'[X DS(DS)=X
 Q

MCARDCQ ;WISC/TJK-MODIFIED DICQ ROUTINE FOR MEDICINE SCREENS ;8/23/96  12:33
 ;;2.3;Medicine;;09/13/1996
 S DZ=X D:DIC(0)]"" DQ S:$D(DZ) X=DZ K DZ,XQH G A^MCARDC
 ;
DQ W ! D:'$D(DO) DO^MCARDC1 K DS,MCPCTY I DO="0^-1" K DO W "  Pointed-to File does not exist!" Q
 S DD="",Y=$P(DO,U,4),DIY=DO,DIX=D D DIY
 S X=$S($D(^DD(+DO(2),.001,0)):$P(^(0),U,1),DIC(0)["N":"NUMBER",1:""),DIZ=X]"",DIW=^DD(+DO(2),.01,0)
 S DIW=$P(DIW,U,2,3) G:$D(^DD(+DO(2),0,"QUES")) @^("QUES") I DIZ S DS=.001 D DS
IX I $D(MCBDIC),MCBDIC=DIC,$D(MCDF) S DIX=MCDF
 S X=$O(^DD(+DO(2),0,"IX",DIX,-1)) S:X="" X=-1 I X'<0 S DS=$O(^(X,0)) S:DS="" DS=-1 I $D(^DD(X,DS,0)) S MCPCT=$P(^(0),U,2,3),X=$P(^(0),U,1) D DS
 I @("$D("_DIC_"DIX))>9!$D(DF)"),DD="" S DD=DIX,DIW=$G(MCPCT) S:'Y Y=2 S:'$D(^(DD)) Y=0,DIZ=0 ; $G() ADDED BY rew  8/10/95
 S DIX=$O(@(DIC_"DIX)")) S:DIX="" DIX=-1 G IX:DIC(0)["M"&'DIX I DD="" S DIZ=1,YMLH=$O(^("AZ")) S:YMLH'=""&'YMLH Y=0
 I $D(DZ)#2 G C:DZ["??" S:DZ["BAD" Y=0
 W " ANSWER WITH ",$P(DO,U,1) S DS=0
 F X=1:1 S DS=$O(DS(DS)) S:DS="" DS=-1 Q:DS<0  W $P(", OR",U,X>1) W:$X+$L(DS(DS))>70 !?4 W " ",DS(DS) I $Y>21 R !,"Press <RETURN> to Continue: ",MCPCTY:DTIME X DJCP
 K DS W $E(":",Y) ;G 0:'Y
20 D DCS^MCARDNQ G C:Y<6 W !," DO YOU WANT THE ENTIRE " W:DO(2)'["s"&'$D(DIC("S"))&'$D(DF) Y,"-ENTRY " W $P(DO,U,1)," LIST" S MCPCT=0 D YN^MCARDCN S:MCPCT=1 MCPCTY=1 I MCPCTY'="??" S MCPCTY=$E(MCPCTY,2,99)
 G 0:MCPCT#2=0!(MCPCT<0&(MCPCTY="")),C:MCPCTY=""
 S DIZ=$S(+MCPCTY=MCPCTY:1,DD]"":0,1:DIZ) I +MCPCTY'=MCPCTY G 20:DD="" I $P(DIW,U,1)["D" S DS=Y,X=MCPCTY,%DT="T" D ^%DT K %DT S MCPCTY=Y,Y=DS,DIZ=0 I MCPCTY<0 W *7 G 20
C I $Y>20 D CONT^MCARDCQ1 Q:MCPCTY=U  X DJCP
 D DCS^MCARDNQ W:Y>1&(DZ'="???") !,"CHOOSE FROM:" S X=$P(" D S Q:$G(MCPCTY)=U  I ",U,$D(DIC("S"))!$D(DO("SCR")))
 I DIZ S DS="I $D(^(Y,0))#2 S X=$P(^(0),""^"",1)"_X_" W"_$S(DO(2)'["D":"",1:":$L(Y)<8")_" Y,?$X+5-$L(Y),"" """,DIX="S Y=$O("_DIC_"Y)) S:Y="""" Y=-1 I Y'>0" G A
 S DIX="S X=$O("_DIC_""""_DD_""",X)) I X=""""",DS=$S(X]""!$D(DIC("W")):"F Y=0:0 S Y=$O("_DIC_""""_DD_""",X,Y)) S:Y="""" Y=-1 Q:Y<0 "_$P(" I $D(^(Y))#2,'^(Y)",1,DD="B")_" I $D("_DIC_"Y,0))"_X,1:"I 1")_" W:$X>5 !?3"
A S X="X"
D S Y=$P(DIW,U,1) I Y["D" S DIY=27,X=" S MCPCT="_X_" D DT" G ^MCARDCQ1
 I Y["P",$P(DIW,U,2)["(" S DIY=U_$P(DIW,U,2),X="$S($D("_DIY_X_",0))#2:$P(^(0),""^"",1),1:"_X_")" I @("$D("_DIY_"0))") S DIY=^(0) D DIY S DIW=$P(^(0),U,2,3) G D
 ;; ***ORIGINAL*** ;; I Y["S",Y[U S DS(95)=$P(DIW,U,2),X="$P($P(DS(95),"_X_"_"":"",2),"";"",1)"
 I Y["S" S DS(95)=$P(DIW,U,2),X="X_""  ""_$P($P(DS(95),"_X_"_"":"",2),"";"",1)"
 I Y["V" S X=" S MCPCTY=Y,Y=X,DJC=+DO(2) D Y^MCARDCM2 K DJC W Y S Y=MCPCTY" G ^MCARDCQ1
 S X=" W "_X
M G ^MCARDCQ1
 ;
0 K DIW,DIZ,DS G 0^MCARDCQ1:DIC(0)["L" Q
 ;
DIY S DIY=$P(^DD(+$P(DIY,U,2),.01,0),"$L(X)>",2),DIY=$S(DIY:DIY,1:30)+7 Q
 ;
SOUNDEX S Y=0 G IX
 ;
DS S:DO'[X DS(DS)=X
 Q

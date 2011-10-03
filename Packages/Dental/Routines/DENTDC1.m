DENTDC1 ;WASH ISC/TJK-READ X, SET UP ID'S, ASK OK ; 11-Aug-1987 9:39 am;06/08/88  2:37 PM
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 I $D(DIC("A")) S DD=DIC("A") G B
 D DO S Y=$P(DO,"^",1) I D="B",DO(2)>1.9 S X=$P(^DD(+DO(2),.01,0),"^",1) I X'[Y,Y'[X S Y=Y_" "_X
 S DD="Select "_Y_": "
B I $D(DIC("B")),DIC("B")]"" S Y=DIC("B"),X=$O(@(DIC_"D,Y)")) S:X="" X=-1 S DIY=$S($D(^(Y)):Y,$F(X,Y)-1=$L(Y):X,$D(@(DIC_"Y,0)")):$P(^(0),U),1:Y) W DD D WR R "// ",X:DTIME G DO:X]"",TIME:'$T S X=DIY S:DIC(0)'["O" DIC(0)=DIC(0)_"O" G DO
 W DD R X:DTIME E  G TIME:X=""
DO ;
 ;naked references in DO+2 is dependent on the calling routines.
 Q:$D(DO)  I $D(@(DIC_"0)")) S DO=^(0)
 E  S DO="0^-1" I $D(DIC("P")) S DO=U_DIC("P"),^(0)=DO ; naked reference reference to DO+1
DO2 S DO(2)=$P(DO,"^",2) I DO?1"^".E S YMLH=$O(^DD(+DO(2),0,"NM",0)) S:YMLH="" YMLH=-1 S DO=YMLH_DO
 I DO(2)["s",$D(^DD(+DO(2),0,"SCR")) S DO("SCR")=^("SCR")
 Q:DO(2)'["I"!$D(DIC("W"))  Q:'$D(^DD(+DO(2),0,"ID"))  S %=0,DIC("W")="" I DO(2)["P" D WOV S %=+DO(2),%Y=DIC G P
W ;
 S %=$O(^DD(+DO(2),0,"ID",%)) S:%="" %=-1 I %+1 G WOV:$L(DIC("W"))+$L(^(%))>244 S:^(%)'="W """"" DIC("W")=DIC("W")_" W ""   "" "_^(%) G W
 S DIC("W")=$E(DIC("W"),2,999) Q
P I %,$D(^DD(%,.01,0)),$D(^DIC(+$P($P(^(0),U,2),"P",2),0))#2 S %=+$P(^(0),U,2),%W=$S($D(^(0,"GL")):^("GL"),1:"") S:%W]"" DIC("W")=DIC("W")_" I '$D(DICR) S %Y=+"_%Y_"%Y,0) I $D("_%W_"%Y,0)) S %W="_%_",%Z="""_%W_""",%X=0 D WOV^DENTDCQ1",%Y=%W G P
 Q
WOV S DIC("W")="S %W=+DO(2),%X=0,%Y=Y,%Z=DIC D WOV^DENTDCQ1" Q
 ;
RENUM ;
 D DO I '$D(DF),X?.NP,^DD(+DO(2),.01,0)["DINUM",@("$D("_DENTDC_"X))") S Y=X G 1^DENTDC
 G F^DENTDC
 ;
WO W "  " D WR I $D(DIC("W")),$D(@(DIC_"Y,0)")) W "  " X DIC("W")
 Q
 ;
WR D DO Q:DIC(0)["S"&(X'=" ")
 I DO(2)["V" S %X=Y,DIYS=DIY D NAME^DENTDCM2 W DINAME S Y=%X,DIY=DIYS K DINAME,%X,DIYS Q
 I +DIY'=DIY W DIY Q
 I DO(2)["D" W:$E(DIY,4,5) +$E(DIY,4,5),"-" W:$E(DIY,6,7) +$E(DIY,6,7),"-" W DIY\10000+1700 W:DIY["." "@"_$E(DIY_0,9,10)_":"_$E(DIY_"000",11,12) Q
 I DO(2)["P",$D(@("^"_$P(^DD(+DO(2),.01,0),"^",3)_+DIY_",0)")) S %X=Y,DIYS=DIY,Y=DIY,DJC=+DO(2) D Y^DENTDCM2 K DJC W Y S Y=%X,DIY=DIYS K DIYS Q
 W DIY Q
 ;
Y ;
 S DZ=Y,DD=$O(DS(DD)) S:DD="" DD=-1 S Y=+DS(DD),DICR(DD)=DS(DD),DIY=DIY(DD) W:DIC(0)["E" !?5,DD,?9,$P(X,U,'$D(DICRS))_$P(DS(DD),U,2,9) D WO:DIC(0)["E" S Y=DZ I DIC(0)["Y" G Y:DD<DS F Y=DS:-1 G Q^DENTDC:'Y S Y(+DS(Y))=""
 G N:DIC(0)'["E" I DS>DD G Y:DD#5 W !,"TYPE '^' TO STOP, OR"
 W !,"CHOOSE "_$O(DS(0))_"-"_DD R ": ",DIY:DTIME E  D TIME G N
 I U[DIY S:DIY=U DUOUT=1 X DJCP G:DD=DS L^DENTDCM:DO(2)["O"&(DO(2)'["A"),A^DENTDC G Y^DENTDC:DIY="" S X=U G A^DENTDC
 I +DIY'=DIY X DJCP S D=$S($D(DF):DF,1:"B"),X=DIY K DIY,DS G X^DENTDC
 G BAD:'$D(DS(DIY)) S Y=+DS(DIY),DIY(+X)="" K DIC("W"),DIVP1 G C^DENTDC
 ;
TIME W *7 S DTOUT=1 Q
 ;
OK ;
 S %=1 I $D(DS),DS=1 W !?9,"...OK" D YN^DENTDCN
 I %>0 G R^DENTDC:%=1 S X=DIX X DJCP G L^DENTDCM
O I $D(DFAST)#2,X=DFAST S DFOUT=1 G N
BAD W:DIC(0)["Q" *7," ??" G A^DENTDC
N G NO^DENTDC
DS ;
 I '$D(DISMN) S DISMN=1000 I $D(^DD("OS"))#2 S DISMN=$S(+$P(^DD("OS",^("OS"),0),U,2):$P(^(0),U,2),1:DISMN)
 Q
 ;
MIX ;
 S DID=D_"^-1",DID(1)=2,D=$P(DID,U) G IX^DENTDC

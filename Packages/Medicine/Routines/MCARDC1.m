MCARDC1 ;WISC/TJK-READ X, SET UP ID'S, ASK OK ;7/19/96  15:06
 ;;2.3;Medicine;;09/13/1996
 I $D(DIC("A")) S DD=DIC("A") G B
 D DO S Y=$P(DO,"^",1) I D="B",DO(2)>1.9 S X=$P(^DD(+DO(2),.01,0),"^",1) I X'[Y,Y'[X S Y=Y_" "_X
 S DD="Select "_Y_": "
B I $D(DIC("B")),DIC("B")]"" S Y=DIC("B"),X=$O(@(DIC_"D,Y)")) S:X="" X=-1 S DIY=$S($D(^(Y)):Y,$F(X,Y)-1=$L(Y):X,$D(@(DIC_"Y,0)")):$P(^(0),U),1:Y) W DD D WR R "// ",X:DTIME G DO:X]"",TIME:'$T S X=DIY S:DIC(0)'["O" DIC(0)=DIC(0)_"O" G DO
 W DD R X:DTIME E  G TIME:X=""
DO ;
 ; Naked references in DO+2 is the global in the variable DIC
 Q:$D(DO)  I $D(@(DIC_"0)")) S DO=^(0)
 E  S DO="0^-1" I $D(DIC("P")) S DO=U_DIC("P"),^(0)=DO
DO2 S DO(2)=$P(DO,"^",2) I DO?1"^".E S YMLH=$O(^DD(+DO(2),0,"NM",0)) S:YMLH="" YMLH=-1 S DO=YMLH_DO
 I DO(2)["s",$D(^DD(+DO(2),0,"SCR")) S DO("SCR")=^("SCR")
 Q:DO(2)'["I"!$D(DIC("W"))  Q:'$D(^DD(+DO(2),0,"ID"))  S MCPCT=0,DIC("W")="" I DO(2)["P" D WOV S MCPCT=+DO(2),MCPCTY=DIC G P
W ;
 S MCPCT=$O(^DD(+DO(2),0,"ID",MCPCT)) S:MCPCT="" MCPCT=-1 I MCPCT+1 G WOV:$L(DIC("W"))+$L(^(MCPCT))>244 S:^(MCPCT)'="W """"" DIC("W")=DIC("W")_" W ""   "" "_^(MCPCT) G W
 S DIC("W")=$E(DIC("W"),2,999) Q
P I MCPCT,$D(^DD(MCPCT,.01,0)),$D(^DIC(+$P($P(^(0),U,2),"P",2),0))#2 S MCPCT=+$P(^(0),U,2),MCPCTW=$S($D(^(0,"GL")):^("GL"),1:"") D
 .S:MCPCTW]"" DIC("W")=DIC("W")_" I '$D(DICR) S MCPCTY=+"_MCPCTY_"MCPCTY,0) I $D("_MCPCTW_"MCPCTY,0)) S MCPCTW="_MCPCT_",MCPCTZ="""_MCPCTW_""",MCPCTX=0 D WOV^MCARDCQ1"
 Q
WOV S DIC("W")="S MCPCTW=+DO(2),MCPCTX=0,MCPCTY=Y,MCPCTZ=DIC D WOV^MCARDCQ1" Q
 ;
RENUM ;
 D DO I '$D(DF),X?.NP,^DD(+DO(2),.01,0)["DINUM",@("$D("_MCARDC_"X))") S Y=X G 1^MCARDC
 G F^MCARDC
 ;
WO W "  " D WR I $D(DIC("W")),$D(@(DIC_"Y,0)")) W "  " X DIC("W")
 Q
 ;
WR D DO Q:DIC(0)["S"&(X'=" ")
 I DO(2)["V" S MCPCTX=Y,DIYS=DIY D NAME^MCARDCM2 W DINAME S Y=MCPCTX,DIY=DIYS K DINAME,MCPCTX,DIYS Q
 I +DIY'=DIY W DIY Q
 I DO(2)["D" W:$E(DIY,4,5) +$E(DIY,4,5),"-" W:$E(DIY,6,7) +$E(DIY,6,7),"-" W DIY\10000+1700 W:DIY["." "@"_$E(DIY_0,9,10)_":"_$E(DIY_"000",11,12) Q
 I DO(2)["P",$D(@("^"_$P(^DD(+DO(2),.01,0),"^",3)_+DIY_",0)")) S MCPCTX=Y,DIYS=DIY,Y=DIY,DJC=+DO(2) D Y^MCARDCM2 K DJC W Y S Y=MCPCTX,DIY=DIYS K DIYS Q
 W DIY Q
 ;
Y ;
 S DZ=Y,DD=$O(DS(DD)) S:DD="" DD=-1 S Y=+DS(DD),DICR(DD)=DS(DD),DIY=DIY(DD) W:DIC(0)["E" !?5,DD,?9,$P(X,U,'$D(DICRS))_$P(DS(DD),U,2,9) D WO:DIC(0)["E" S Y=DZ I DIC(0)["Y" G Y:DD<DS F Y=DS:-1 G Q^MCARDC:'Y S Y(+DS(Y))=""
 ;; ***ORIGINAL*** ;; G N:DIC(0)'["E" I DS>DD G Y:DD#5 W !,"TYPE '^' TO STOP, OR"
 ;; ***ORIGINAL*** ;; W !,"CHOOSE "_$O(DS(0))_"-"_DD R ": ",DIY:DTIME E  D TIME G N
 G N:DIC(0)'["E" I DS>DD G Y:DD#$S($D(DIC("W")):3,1:5) W !,"TYPE '^' TO STOP, OR "
 W:DS'>DD ! W "CHOOSE "_$O(DS(0))_"-"_DD R ": ",DIY:DTIME E  D TIME G N
 I U[DIY S:DIY=U DUOUT=1 X DJCP G:DD=DS L^MCARDCM:DO(2)["O"&(DO(2)'["A"),A^MCARDC G Y^MCARDC:DIY="" S X=U G A^MCARDC
 I +DIY'=DIY X DJCP S D=$S($D(DF):DF,1:"B"),X=DIY K DIY,DS G X^MCARDC
 G BAD:'$D(DS(DIY)) S Y=+DS(DIY),DIY(+X)="" K DIC("W"),DIVP1 G C^MCARDC
 ;
TIME W *7 S DTOUT=1 Q
 ;
OK ;
 S MCPCT=1 I $D(DS),DS=1 W !?9,"...OK" D YN^MCARDCN
 I MCPCT>0 G R^MCARDC:MCPCT=1 S X=DIX X DJCP G L^MCARDCM
O I $D(DFAST)#2,X=DFAST S DFOUT=1 G N
BAD W:DIC(0)["Q" *7," ??" G A^MCARDC
N G NO^MCARDC
DS ;
 I '$D(DISMN) S DISMN=1000 I $D(^DD("OS"))#2 S DISMN=$S(+$P(^DD("OS",^("OS"),0),U,2):$P(^(0),U,2),1:DISMN)
 Q
 ;
MIX ;
 S DID=D_"^-1",DID(1)=2,D=$P(DID,U) G IX^MCARDC

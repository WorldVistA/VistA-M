MCARDCN ;WISC/TJK-MODIFIED DICN ROUTINE FOR MEDICINE SCREENS ;7/24/96  07:35
 ;;2.3;Medicine;;09/13/1996
 S DO(1)=1
 I $S($D(DLAYGO):DO(2)\1-(DLAYGO\1),1:1),DUZ(0)'="@",$D(^DIC(+DO(2),0,"LAYGO")) F MCPCT=1:1 I DUZ(0)[$E(^("LAYGO"),MCPCT) G B:MCPCT>$L(^("LAYGO")) Q
 I $D(DD) S X=DD D N^MCARDCN1 G I:$D(X),B
 D DS S DIX=X I X?.NP,X,DIC(0)["E",'$D(DICR),DS'["DINUM",$P(DS,U,2)'["N",DIC(0)["N"!$D(^DD(+DO(2),.001,0)) D N^MCARDCN1 I $D(X) S DD=X G I
 S X=DIX D VAL G I:$D(X)
 S X=DIX
B K Y(0) G BAD^MCARDC1
 ;
1 I '$D(DIC("S")) W " (THE ",Y,$S(Y#10=1&(Y#100-11):"ST",Y#10=2&(Y#100-12):"ND",Y#10=3&(Y#100-13):"RD",1:"TH"),$S('$D(^DD(+DO(2),0,"UP")):"",1:" FOR THIS "_$O(^DD(^("UP"),0,"NM",0))),")"
YN ;
 W "? ",$P("YES// ^NO// ",U,MCPCT)
RX R MCPCTY:DTIME E  S DTOUT=1,MCPCTY=U W *7
 S:MCPCTY]""!'MCPCT MCPCT=$A(MCPCTY),MCPCT=$S(MCPCT=89:1,MCPCT=121:1,MCPCT=78:2,MCPCT=110:2,MCPCT=94:-1,1:0)
 I 'MCPCT,MCPCTY'?."?" W *7,"??",!?4,"ANSWER 'YES' OR 'NO': " G RX
 W:$X>73 ! W $P("  (YES)^  (NO)",U,MCPCT) Q
 ;
DS S DS=^DD(+DO(2),.01,0) Q
 ;
VAL I X'?.ANP!($A(X)=45) K X Q
 I $P(DS,U,2)["*" S:DS["DINUM" DINUM=X Q
 S MCPCT=$F(DS,"%DT=""E"),DS=$E(DS,1,MCPCT-2)_$E(DS,MCPCT,999) X $P(DS,U,5,99) Q
 ;
 ;; ***ORIGINAL*** ;; I I DIC(0)["E",DO(2)'["A" S DJC=+DO(2),Y=X D Y^MCARDCM2 K DJC X:$Y>20 DJCP W *7,!?3,"ARE YOU ADDING " W:'$D(DD) "'"_Y_"' AS " S MCPCT=$P(DO,U,1) W !?7 W "A NEW "_MCPCT S MCPCT=0,Y=$P(DO,U,4)+1 D 1 G B:MCPCT-1
I I DIC(0)["E",DO(2)'["A" S DJC=+DO(2),Y=X D Y^MCARDCM2 K DJC X DJCP W *7,!?3,"ARE YOU ADDING " W:'$D(DD) "'"_Y_"' AS " S MCPCT=$P(DO,U,1) W !?7 W "A NEW "_MCPCT S MCPCT=0,Y=$P(DO,U,4)+1 D 1 G B:MCPCT-1
 G FILE:'$D(DD)
R D DS W !?3,$P(DS,U,1),": " R X:DTIME S:'$T X=U
 G B:X[U,R:X="" D VAL I '$D(X) W *7,"??" W:$D(^DD(+DO(2),.01,3)) !,^(3) G R
FILE D:'$D(DO) DO^MCARDC1 F DIX=0:0 S DIX=$O(^DD(+DO(2),.01,"LAYGO",DIX)) Q:DIX'>0  I $D(^(DIX,0)) X ^(0) I '$T S Y=-1 G A^MCARDC:$D(DO(1)),Q^MCARDC
 S DIX=X
F1 S X=$P(DO,U,3) D INCR S X=X\DIY*DIY+DIY
 I $D(DINUM) S X=DINUM D INCR
F2 I $D(@(DIC_"X)")) S X=X\DIY*DIY+DIY G B:$D(DINUM),F2
 S Y=$P(DO,"^",2) I $D(DD) S X=DD
 E  I 'Y,DUZ(0)'="@" G LOCK
 I DIC(0)["E",$D(^DD(+Y,.001,0)) G NUM^MCARDCN1
LOCK L @(DIC_"X):1") I $D(@(DIC_"X)"))!'$T L  W *7 G F1
 ; Nake Reference in LOCK+3 is refs in Line tag LOCK
 ; DIC is set to ^MCAR(xxx, where xxx is a file number.
 S ^(X,0)=DIX,DD=0 L  K D S:$D(DA)#2 D=DA S DA=X,X=DIX
 I $D(@(DIC_"0)")) S ^(0)=$P(^(0),"^",1,2)_"^"_DA_"^"_($P(^(0),"^",4)+1)
IX S DS=X,DD=$O(^DD(+DO(2),.01,1,DD)) S:DD="" DD=-1 I DD>0 G RIX^MCARDCN1:^(DD,0)["TRIGGER"!(^(0)["BULL") X ^(1) S X=DS G IX
 I DIC(0)["E"&($O(^DD(+DO(2),0,"ID",0))>0)!$D(DIC("DR")) G ^MCARDCN1
D ;
 S Y=DA_"^"_X_"^"_1 S:$D(D)#2 DA=D G R^MCARDC
 ;
INCR S DIY=1 I $P(DO,U,2)>1 F MCPCT=1:1:$L($P(X,".",2)) S DIY=DIY/10
 Q

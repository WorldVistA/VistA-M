DENTDCM2 ;WASH ISC/TJK-MODIFIED DICM2 ROUTINE  ; 2-Jul-1987 4:59 pm;12/16/91  4:15 PM
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 ;VAR PNTR
 S DIVDO=+DO(2),DIVDS=DS,DIVDIC=DIC F %="DR","S","A","V" I $D(DIC(%)) S @("DIV"_%)=DIC(%)
 K DIC("W"),DIC("S"),DIC("DR"),DO,DUOUT S DIEX=X G ALL:X'["." I $P(X,".",2)="" S Y=-1 G Q
V S DIVP=$P(DIEX,".",1),X=$P(DIEX,".",2) I DIVP]"",$D(^DD(DIVDO,.01,"V","P",DIVP)) S (DIVP,DIVPDIC)=+$O(^(DIVP,0)),DIVPDIC=$S($D(^DD(DIVDO,.01,"V",DIVP,0)):^(0),1:"") G Q:'DIVPDIC D DIC G Q
 S X="",DIVP=$P(DIEX,".",1) F %=0:0 S X=$O(^DD(DIVDO,.01,"V","M",X)) Q:X=""  I $P(X,DIVP,1)="" S (DIVP,DIVPDIC)=+$O(^(X,0)),DIVPDIC=$S($D(^DD(DIVDO,.01,"V",DIVP,0)):^(0),1:""),X=$P(DIEX,".",2) G Q:'DIVPDIC D DIC G Q:Y>0 S X=DIEX
 F DIVP=0:0 S DIVP=$O(^DD(DIVDO,.01,"V",DIVP)) S:DIVP="" DIVP=-1 Q:DIVP'>0  I $D(^(DIVP,0)) S DIVPDIC=^(0) I $D(^DIC(+DIVPDIC,0)) S %=$P(^(0),U,1) I $P(%,$P(DIEX,".",1),1)="" S X=$P(DIEX,".",2) D DIC G Q:Y>0 S X=DIEX
 K X G Q
ALL F DIVP1=0:0 S DIVP1=$O(^DD(DIVDO,.01,"V","O",DIVP1)) S:DIVP1="" DIVP1=-1 Q:DIVP1'>0  S DIVP=$O(^(DIVP1,0)) S:DIVP="" DIVP=-1 I $D(^DD(DIVDO,.01,"V",DIVP,0)) S DIVPDIC=^(0) D DIC G Q:Y>0!(%<0)!$D(DUOUT) S X=DIEX
 G Q:DICR>1!$D(DICR(DICR,"V")) S DICR(DICR,"V")=1 K DIVP G ALL
 ;
DIC ;
 Q:$D(DIVP(+DIVPDIC))  I $D(DIC("V")) S Y=DIVP,Y(0)=DIVPDIC X DIC("V") I '$T K Y S Y=-1 G DQ
 I '$D(^DIC(+DIVPDIC,0,"GL")) S Y=-1 G DQ
 S DIC=^DIC(+DIVPDIC,0,"GL"),%="DIC"_DICR
 IF DIC(0)'["L"!'$D(DICR(DICR,"V")) D
 .  S DIC("S")="X ""I 0"" F "_%_"=0:0 S "_%_"=$O("_DIVDIC_"""B"",(+Y_"";"_$E(DIC,2,99)_"""),"_%_")) S:"_%_"="""" "_%_"=-1 Q:"_%_"'>0  I $D("_DIVDIC_%_",0))"_$S($D(DIVS):" S %YV=Y,Y="_%_" X DIVS S Y=%YV I ",1:"")_" Q"
 .  Q
 ;END IF
 ;
 S %=DIC(0),DIC(0)="DM"_$E("E",%["E")_$E("O",%["O") I $P(DIVPDIC,U,6)="y",$D(DICR(DICR,"V")),%["L" S DIC(0)=DIC(0)_"L"
 I $D(DICR(DICR,"V")),$P(DIVPDIC,U,5)="y",$D(^DD(DIVDO,.01,"V",DIVP,1)),^(1)]"" S %=$S($D(DIC("S")):DIC("S"),1:"") X ^(1) S DIC("S")=DIC("S")_" "_%
 I DIC(0)["E",$D(DIVP1),$D(DICR(DICR,"V")) W !!?5,"Searching for a "_$P(DIVPDIC,U,2)
 I X?."?" S DZ=X_$E("?",'$D(DICR(DICR,"V"))) D DQ^DENTDCQ S X=$S($D(DZ):DZ,1:"?"),Y=-1 G DQ
 D DO^DENTDC1,X^DENTDC G DQ:$D(DUOUT) S X=+Y_";"_$E(DIC,2,99),%=1 K:Y<0 X I '$D(DICR(DICR,"V")) K DICR("^",+DIVPDIC) S DIVP(+DIVPDIC)=0
 I Y>0,$D(DIVP1),DIC(0)["E",'$P(Y,U,3),$P(^DIC(+DIVPDIC,0),U,2)'["O" W !?9,"...OK" D YN^DENTDCN S:%=2!(%<0) Y=-1
DQ K DIC,DO S DIC=DIVDIC,D=$S($D(DICR(DICR,4)):DICR(DICR,4),1:"B"),DIC(0)=DICR(DICR,0) I $D(DIVV) S DIC("V")=DIVV
 Q
 ;
Q I '$D(DUOUT),Y<0,DICR<2,'$D(DICR(DICR,"V")) S DICR(DICR,"V")=1 K DIVP G V
 K:Y<0 X S DS=DIVDS,DICR(DICR,"V")=1 S:$D(DIVDR) DIC("DR")=DIVDR S:$D(DIVA) DIC("A")=DIVA S:$D(DIVS) DIC("S")=DIVS
QQ K:Y DICR(DICR,6) K DUOUT,DIVV,DIVP,DIVDIC,DO,DIVDO,DIVDS,DIVS,DIVPDIC,DIEX,DIVP1,DIVDR,DIVA Q
 ;
NAME ;DETERMINE EXTERNAL FORM FROM INTERNAL FOR VP
 S DINAME=DIY Q:'DIY  S %=$P(DIY,";",2),DINAME="^"_%_+DIY_",0)",DINAME=$S($D(@DINAME)#2:$P(^(0),U,1),1:DIY),%=$S($D(@("^"_%_"0)")):$P(^(0),U,2),1:"") Q:%=""
 I %["P"!(%["S")!(%["D") S DJC=%,%YYY=DIY,%YY=Y,Y=DINAME D Y K DJC S DINAME=Y,DIY=%YYY,Y=%YY,C="," K %YY,%YYY
 Q
Y S C=$P(^DD(+DJC,.01,0),U,2) I C["O",$D(^(2)) X ^(2) Q
S I C["S" S C=";"_$P(^DD(+DJC,.01,0),U,3),%=$F(C,";"_Y_":") S:% Y=$P($E(C,%,999),";",1) Q
 I C["P",$D(@("^"_$P(^DD(+DJC,.01,0),U,3)_"0)")) S (C,DJC)=$P(^(0),U,2) I $D(^(+Y,0)) S Y=$P(^(0),U,1) I $D(^DD(+C,.01,0)) S C=$P(^(0),U,2) G S
 I C["V",+Y,$D(@("^"_$P(Y,";",2)_"0)")) S C=$P(^(0),U,2) I $D(^(+Y,0)) S Y=$P(^(0),U,1) I $D(^DD(+C,.01,0)) S C=$P(^(0),U,2) G S
 Q:C'["D"  Q:'Y
D S %=$E(Y,4,5)*3,Y=$E("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC",%-2,%)_" "_$S($E(Y,6,7):$J(+$E(Y,6,7),2)_", ",1:"")_($E(Y,1,3)+1700)_$S(Y[".":"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q

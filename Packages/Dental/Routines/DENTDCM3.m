DENTDCM3 ;WASH ISC/TJK-MODIFIED DICM3 ROUTINE FOR DENTAL SCREEN ;12/07/90  9:11 AM; 3/30/92  1:33 PM
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 ;;17.7;VA FileMan; 6/9/89
DIC ;
 Q:$D(DIVP(+DIVPDIC))
 I $D(DIC("V")) S Y=DIVP,Y(0)=DIVPDIC X DIC("V") I '$T K Y S Y=-1 G DQ
 I '$D(^DIC(+DIVPDIC,0,"GL")) S Y=-1 G DQ
 ;naked reference in DIC+5 is refs in line tag: DIC+3
 S DIC=^("GL"),%="DIC"_DICR
 ;FOLLOWING 2 LINES MODIFIED FOR VERIFICATION PER T. ASH 2/20/92 MLH
 I DIC(0)'["L"!'$D(DICR(DICR,"V"))
 I  S DIC("S")="X ""I 0"" F "_%_"=0:0 S "_%_"=$O("_DIVDIC_""""_D_""""_",(+Y_"";"_$E(DIC,2,99)_"""),"_%_")) S:"_%_"="""" "_%_"=-1 Q:"_%_"'>0  I $D("_DIVDIC_%_",0))"_$S($D(DIV("S")):" S %YV=Y,Y="_%_" X DIV(""S"") S Y=%YV I ",1:"")_" Q"
 S %=DIC(0),DIC(0)="DM"_$E("E",%["E")_$E("O",%["O") I $P(DIVPDIC,U,6)="y",$D(DICR(DICR,"V")),%["L" S DIC(0)=DIC(0)_"L"
 I $D(DICR(DICR,"V")),$P(DIVPDIC,U,5)="y",$D(^DD(DIVDO,DIVY,"V",DIVP,1)),^(1)]"" S %=$S($D(DIC("S")):DIC("S"),1:"") X ^(1) S DIC("S")=DIC("S")_" "_%
 I DIC(0)["E",$D(DIVP1),$D(DICR(DICR,"V")) W !!?5,"Searching for a "_$P(DIVPDIC,U,2)
 I X?."?" S DZ=X_$E("?",'$D(DICR(DICR,"V"))) D DQ^DENTDCQ S X=$S($D(DZ):DZ,1:"?"),Y=-1 G DQ
 D DO^DENTDC1
 S D="B" D X^DENTDC G DQ:$D(DUOUT) S X=+Y_";"_$E(DIC,2,99),%=1 K:Y<0 X
 I '$D(DICR(DICR,"V")) K DICR("^",+DIVPDIC) S DIVP(+DIVPDIC)=0
 I Y>0,$D(DIVP1),DIC(0)["E",'$P(Y,U,3),$P(^DIC(+DIVPDIC,0),U,2)'["O" W !?9,"...OK" D YN^DENTDCN S:%=2!(%<0) Y=-1
DQ K DIC,DO S DIC=DIVDIC,D=$S($D(DICR(DICR,4)):DICR(DICR,4),1:"B"),DIC(0)=DICR(DICR,0) I $D(DIV("V")) S DIC("V")=DIV("V")
 Q

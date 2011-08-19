MCARDCM3 ;WISC/TJK-MODIFIED DICM3 ROUTINE FOR MEDICINE SCREEN ;5/2/96  12:57
 ;;2.3;Medicine;;09/13/1996
 ;;17.7;VA FileMan; 6/9/89
DIC ;
 N DIVY
 Q:$D(DIVP(+DIVPDIC))
 I $D(DIC("V")) S Y=DIVP,Y(0)=DIVPDIC X DIC("V") I '$T K Y S Y=-1 G DQ
 I '$D(^DIC(+DIVPDIC,0,"GL")) S Y=-1 G DQ
 ; Naked Reference in DIC+5 is refs in line tag: DIC+3
 S DIC=^("GL"),MCPCT="DIC"_DICR
 ;FOLLOWING 2 LINES MODIFIED FOR VERIFICATION PER T. ASH 2/20/92 MLH
 I DIC(0)'["L"!'$D(DICR(DICR,"V")) D
 .  S DIC("S")="X ""I 0"" F "_MCPCT_"=0:0 S "_MCPCT_"=$O("_DIVDIC_""""_D_""""_",(+Y_"";"_$E(DIC,2,99)_"""),"_MCPCT_")) S:"_MCPCT_"="""" "
 .  S DIC("S")=DIC("S")_MCPCT_"=-1 Q:"_MCPCT_"'>0  I $D("_DIVDIC_MCPCT_",0))"_$S($D(DIV("S")):" S MCPCTYV=Y,Y="_MCPCT_" X DIV(""S"") S Y=MCPCTYV I ",1:"")_" Q"
 S MCPCT=DIC(0),DIC(0)="DM"_$E("E",MCPCT["E")_$E("O",MCPCT["O") I $P(DIVPDIC,U,6)="y",$D(DICR(DICR,"V")),MCPCT["L" S DIC(0)=DIC(0)_"L"
 I $D(DICR(DICR,"V")),$P(DIVPDIC,U,5)="y",$D(^DD(DIVDO,DIVY,"V",DIVP,1)),^(1)]"" S MCPCT=$S($D(DIC("S")):DIC("S"),1:"") X ^(1) S DIC("S")=DIC("S")_" "_MCPCT
 I DIC(0)["E",$D(DIVP1),$D(DICR(DICR,"V")) W !!?5,"Searching for a "_$P(DIVPDIC,U,2)
 I X?."?" S DZ=X_$E("?",'$D(DICR(DICR,"V"))) D DQ^MCARDCQ S X=$S($D(DZ):DZ,1:"?"),Y=-1 G DQ
 D DO^MCARDC1
 S D="B" D X^MCARDC G DQ:$D(DUOUT) S X=+Y_";"_$E(DIC,2,99),MCPCT=1 K:Y<0 X
 I '$D(DICR(DICR,"V")) K DICR("^",+DIVPDIC) S DIVP(+DIVPDIC)=0
 I Y>0,$D(DIVP1),DIC(0)["E",'$P(Y,U,3),$P(^DIC(+DIVPDIC,0),U,2)'["O" W !?9,"...OK" D YN^MCARDCN S:MCPCT=2!(MCPCT<0) Y=-1
DQ K DIC,DO S DIC=DIVDIC,D=$S($D(DICR(DICR,4)):DICR(DICR,4),1:"B"),DIC(0)=DICR(DICR,0) I $D(DIV("V")) S DIC("V")=DIV("V")
 Q

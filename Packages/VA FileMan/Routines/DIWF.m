DIWF ;SFISC/GFT-FORMS PRINT ;01:52 PM  13 Nov 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 D DT^DICRW,DICS,L S DIC("S")=DIC("S")_" I  "_L
 S DIC="^DIC(",DIC(0)="AEQMZ",DIC("A")="Select Document File: "
 D ^DIC K DIC Q:Y<0
FINDWORD X L I '$T S Y=-1 G Q
 S DJ=%,DIC=DIWF,D=$O(^DD(DIWFN,"SB",%,0)) S:D="" D=-1 Q:'$D(^DD(DIWFN,D,0))  S D=$P($P(^(0),U,4),";") S:+D'=D D=""""_D_"""" S DIWF=DIWF_"DIWFN,"_D_","
 S D=0 F  S D=$O(^DD(DIWFN,D)) Q:D'>0  I $D(^(D,0)),$P(^(0),U,3)="DIC(" S DIWF(0)=D Q
 S:D="" D=-1
DOC S DIC(0)="AEQM" D ^DIC G Q:Y<0
 I $D(DIWF(0)) S D=$P(^DD(DIWFN,DIWF(0),0),U,4),%=$P(D,";",1) I @("$D("_DIC_+Y_",%))") S D=$P(D,";",2),X=$S(D:$P(^(%),U,D),1:$E(^(%),+$E(D,2,9),+$P(D,",",2))) S:X DIWF(1)=X
 S DIWFN=+Y I @("$O("_DIWF_"0))'>0") W $C(7),!?7,"'"_$P(Y,U,2),"' HAS NO '"_$P(^DD(DJ,.01,0),U,1)_"' TEXT!",! G DOC
EN2 ;
 N DIC,DIA,DHIT,FLDS,DHD
 I $O(@(DIWF_"0)"))'>0 G Q
 S DIC(0)="AIQEMZ",DIC="^DIC(",DIC("A")="Print from what FILE: "
 I $D(DIWF(1)) S DIC(0)="ZIF",X=DIWF(1)
 D DICS:'$D(DIWF(1)),^DIC K DIC G Q:Y<0,Q:'$D(^DIC(+Y,0,"GL")) S DIC=^("GL")
 S %=1 I $D(BY)[0 W !,"WANT EACH ENTRY ON A SEPARATE PAGE" D YN^DICN G Q:%<1
 S L=0,DHD="@",FLDS="",DHIT="X "_$P("^UTILITY($J,1):$Y,",9,%)_"DIWFX D ^DIWW",DIWFX="S DIWF=""?W"",DIWL=1,DIWR=IOM,D=0 F  S D=$O("_DIWF_"D)) S:D="""" D=-1 Q:D'>0  I $D(^(D,0)) S X=^(0) D ^DIWP" K DIWF D EN1^DIP
Q K L,DIWF,DIWFN,DIWFX,DIFILE,DIAC Q
 ;
EN1 ;
 I DIC Q:'$D(^DIC(+DIC,0))  S Y=DIC D L G FINDWORD
 I @("$D("_DIC_"0))") S DIC=+$P(^(0),U,2) G EN1
 Q
 ;
DICS S DIC("S")="S DIFILE=+Y,DIAC=""RD"" D ^DIAC I %" Q
 ;
L S L="I $D(^DIC(+Y,0,""GL"")) S DIWF=^(""GL"") I $D(@(DIWF_""0)"")) S DIWFN=+$P(^(0),U,2) I $D(^DD(DIWFN,""SB"")) S %=0 F  S %=$O(^DD(DIWFN,""SB"",%)) S:%="""" %=-1 Q:%<0  I $P(^DD(%,.01,0),U,2)[""W"" Q"

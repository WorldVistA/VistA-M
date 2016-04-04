DINIT12 ;SFISC/GFT,XAK-INITIALIZE VA FILEMAN ;8AUG2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**104,1013,1033,1037,1050**
 ;
 ;**CCO/NI TAGS 'EGP'& 'EGP+1' ADDED TO CREATE NEW FIELDS IN PRINT TEMPLATES, TO REMEMBER THE DEVELOPER'S LANGUAGE, T+1 FOR DATE FORMAT
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G T:X?.P S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;.4,0 FIELD^^1819^21
 ;;.4,0,"DT" 2950909
 ;;.4,.01,0 NAME^F^^0;1^K:$L(X)<2!($L(X)>30) X
 ;;.4,.01,1,0 ^.1^2^2
 ;;.4,.01,1,1,0 .4^B
 ;;.4,.01,1,1,1 S @(DIC_"""B"",X,DA)=""""")
 ;;.4,.01,1,1,2 K @(DIC_"""B"",X,DA)")
 ;;.4,.01,1,2,0 ^^MUMPS
 ;;.4,.01,1,2,1 X "S %=$P("_DIC_"DA,0),U,4) S:$L(%) "_DIC_"""F""_+%,X,DA)=1"
 ;;.4,.01,1,2,2 X "S %=$P("_DIC_"DA,0),U,4) K:$L(%) "_DIC_"""F""_+%,X,DA)"
 ;;.4,.01,1,3,0 ^^MUMPS
 ;;.4,.01,1,3,1 Q
 ;;.4,.01,1,3,2 S X=-1 X "F  S X=$O("_DIC_"""AF"",X)) Q:X=""""  K:'X ^(X,DA) S Y=0 F  S Y=$O("_DIC_"""AF"",X,Y)) Q:Y'>0  K:$D(^(Y,DA)) ^(DA)" S X=-1 S:$G(Y)="" Y=-1
 ;;.4,.01,3 2-30 CHARACTERS
 ;;.4,2,0 DATE CREATED^D^^0;2^S %DT="ET" D ^%DT S X=Y K:Y<1 X
 ;;.4,3,0 READ ACCESS^F^^0;3^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;.4,4,0 FILE^P1'I^DIC(^0;4^Q
 ;;.4,4,1,0 ^.1^1^1
 ;;.4,4,1,1,0 ^^^MUMPS
 ;;.4,4,1,1,1 X "S %=$P("_DIC_"DA,0),U,1),"_DIC_"""F""_+X,%,DA)=1"
 ;;.4,4,1,1,2 Q
 ;;.4,5,0 USER #^N^^0;5^Q
 ;;.4,6,0 WRITE ACCESS^F^^0;6^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;.4,7,0 DATE LAST USED^D^^0;7^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;.4,1815,0 ROUTINE INVOKED^F^^ROU;E1,13^Q
 ;;.4,1815,9 @
 ;;.4,1815,1,0 ^.1^1^1
 ;;.4,1815,1,1,0 ^^^MUMPS
 ;;.4,1815,1,1,1 Q
 ;;.4,1815,1,1,2 D DELETROU^DIEZ($TR(X,U))
 ;;.4,1816,0 PREVIOUS ROUTINE INVOKED^F^^ROUOLD;E1,13^Q
 ;;.4,1816,9 @
 ;;.4,21409,0 CANONIC FOR THIS FILE^S^1:YES^CANONIC;1^I DA<1 K X
 ;;.4,21409,1,0 ^.1^1^1
 ;;.4,21409,1,1,0 ^^^MUMPS
 ;;.4,21409,1,1,1 N F S F=$P(@(DIC_"DA,0)"),U,4) I F S @(DIC_"""CANONIC"",F,DA)=""""")
 ;;.4,21409,1,1,2 N F S F=$P(@(DIC_"DA,0)"),U,4) I F K @(DIC_"""CANONIC"",F,DA)")
 ;;.4,21409,4 D HELP^DIUCANON
 ;;.4,10,0 DESCRIPTION^.4001^^%D;0
 ;;.4001,0 DESCRIPTION SUB-FIELD^^.01^1
 ;;.4001,0,"NM","DESCRIPTION"
 ;;.4001,0,"UP" .4
 ;;.4001,.01,0 DESCRIPTION^W^^0;1^Q
 ;
T ;
 ;;N D,D1,D2 S D2=^(0) S:$X>30 D1(1,"F")="!" S D=$P(D2,U,2) S:D D1(2)="("_$$DATE^DIUTL(D)_")",D1(2,"F")="?30" S D=$P(D2,U,5) S:D D1(3)=" User #"_D,D1(3,"F")="?50" S D=$P(D2,U,4) S:D D1(4)=" File #"_D,D1(4,"F")="?59" D EN^DDIOL(.D1)
 S ^DD(.4,0,"ID","WRITE")=$P($T(T+1),";",3,99)
 S %X="^DD(.4," S %Y="^DD(.402," D %XY^%RCR ;MAKE INPUT TEMPLATE DD FROM PRINT TEMPLATE DD!
 S %X="^DD(.4001," S %Y="^DD(.4021," D %XY^%RCR
 K ^DD(.402,1804),^("SB",.404),^DD(.402,"GL","RD",0,1804)
 S ^DIC(.4,"%D",0)="^^3^3^2940908^"
 S ^DIC(.4,"%D",1,0)="This file stores the PRINT FIELDS data and other information about print"
 S ^DIC(.4,"%D",2,0)="templates.  These templates are used in the Print, Filegram, Extract, and"
 S ^DIC(.4,"%D",3,0)="Export options."
 S ^DIC(.402,"%D",0)="^^1^1^2940908^^"
 S ^DIC(.402,"%D",1,0)="This file stores the EDIT FIELDS data from an input template."
DD1 F I=1:1 S X=$T(DD1+I),Y=$P(X," ",3,99) G DD2:X?.P S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;.4,0,"ID","WRIT" I $P(^(0),U,8) N D1 S @("D1=$P($P($C(59)_$S($D(^DD(.4,8,0)):$P(^(0),U,3),1:0)_$E("_DIC_"Y,0),0),$C(59)_$P(^(0),U,8)_"":"",2),$C(59),1)") D EN^DDIOL("**"_D1_"**","","?0")
 ;;.4,0,"ID","WRITED" I $G(DZ)?1"???".E N % S %=0 F  S %=$O(^DIPT(Y,"%D",%)) Q:%'>0  I $D(^(%,0))#2 D EN^DDIOL(^(0),"","!?5")
 ;;.402,0,"ID","WRITED" I $G(DZ)?1"???".E N % S %=0 F  S %=$O(^DIE(Y,"%D",%)) Q:%'>0  I $D(^(%,0))#2 D EN^DDIOL(^(0),"","!?5")
 ;;.4,1620,9 ^
 ;;.4,1620,9.01
 ;;.4,1620,9.1 
 ;;.402,1620,0 EDIT FIELDS^Cm^^ ; ^D EN^DIET
 ;;.402,1620,21,0 ^
 ;;.402,1620,21,1,0 This multi-line field displays all the "EDIT" prompts of this Input Template
 ;;.402,1620,23,0 ^
 ;;.402,1620,23,1,0 This Computed Multiple uses code in ^DIETED to build the entire displayable Input Template.  Then it is output node-by-node.
 ;;.402,1819,9.1 S X=$S('$D(^DIE(D0,"ROU"))#2:"NO",^("ROU")="":"NO",1:"YES")
 ;;.4,1819,0 COMPILED^CJ3^^ ; ^S X=$S('$D(^DIPT(D0,"ROU"))#2:"NO",^("ROU")="":"NO",1:"YES")
 ;;.4,1819,9 ^
 ;;.4,1819,9.01
 ;;.4,1819,9.1 S X=$S('$D(^DIPT(D0,"ROU"))#2:"NO",^("ROU")="":"NO",1:"YES")
EGP ;;.4,1819.1,0 LANGUAGE IN WHICH COMPILED^P.85^DI(.85,^ROULANG;1
 ;;.4,709.1,0 LANGUAGE OF HEADING^P.85^DI(.85,^HLANG;1
 ;;.402,1819,0 COMPILED^CJ3^^ ; ^S X=$S('$D(^DIE(D0,"ROU"))#2:"NO",^("ROU")="":"NO",1:"YES")
 ;;.402,1819,9.1 S X=$S('$D(^DIE(D0,"ROU"))#2:"NO",^("ROU")="":"NO",1:"YES")
 ;;.402,1819,9 ^
 ;;.402,1819,9.01
 ;;.402,21400,0 BUILD(S)^Cmp9.6^^ ; ^N DIENAME,D S DIENAME=$P($G(^DIE(D0,0)),U)_"    FILE #"_$P($G(^(0)),U,4) F D=0:0 S D=$O(^XPD(9.6,D)) Q:'D  I $D(^(D,"KRN",.402,"NM","B",DIENAME)) N D0 S D0=D,X=$P(^XPD(9.6,D,0),U) X DICMX Q:'$D(D)
 ;;
DD2 N DICNT F DICNT=0:1:7 D @("^DINIT12"_DICNT) ;---REDUNDANT?
 K DICNT G ^DINIT13

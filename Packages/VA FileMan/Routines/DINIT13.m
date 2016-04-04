DINIT13 ;SFISC/YJK-INITIALIZE VA FILEMAN ;6APR2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1001,1013**
 ;
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT14:X?.P S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;.402,10,0 DESCRIPTION^.4021^^%D;0
 ;;.4021,0,"UP" .402
 ;;.4,8,0 TEMPLATE TYPE^S^1:FILEGRAM;2:EXTRACT;3:EXPORT;7:SELECTED EXPORT FIELDS;^0;8^Q
 ;;.4,8,1,0 ^.1^^-1
 ;;.4,8,1,1,0 .4^FG^MUMPS
 ;;.4,8,1,1,1 S %=$S(X=1:"""FG""",1:"") I %]"" S A1=$P(@(DIC_"DA,0)"),U,1),@(DIC_%_",A1,DA)=""""") K %,A1
 ;;.4,8,1,1,2 S %=$S(X=1:"""FG""",1:"") I %]"" S A1=$P(@(DIC_"DA,0)"),U,1) K @(DIC_%_",A1,DA)"),%,A1
 ;;.4,8,1,1,"%D",0 ^^1^1^2921002^^^^
 ;;.4,8,1,1,"%D",0,"LE" 1
 ;;.4,8,1,1,"%D",1,0 Used to do a quick lookup of FILEGRAM type of print templates.
 ;;.4,8,1,1,"DT" 2901106
 ;;.4,8,3 Enter a 1 if this is a FILEGRAM template, 2 if this is an EXTRACT template, 3 if an EXPORT template, 7 if a SELECTED FIELDS template, as opposed to a normal PRINT template.
 ;;.4,8,"DT" 2960523
 ;;.4,20,0 DESTINATION FILE^*P1'^DIC(^0;9^S DIC("S")="I Y>1.99 S DIAC=""RD"" D ^DIAC I %" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;.4,20,3
 ;;.4,20,12 Allow files to which user has READ access.
 ;;.4,20,12.1 S DIC("S")="I Y>1.99 S DIAC=""RD"" D ^DIAC I %"
 ;;.4,20,21,0 ^^2^2^2921002^
 ;;.4,20,21,1,0 This field holds the number of the file that is designed to receive
 ;;.4,20,21,2,0 data from other files by using the Extract Tool.
 ;;.4,20,"DT" 2950909
 ;;.4,50,0 FILEGRAM/EXTR FILE^.41A^^1;0
 ;;.4,50,"DT" 2920514
 ;;.4,100,0 EXPORT FIELD^.42A^^100;0
 ;;.4,100,21,0 ^^1^1^2921123^^
 ;;.4,100,21,1,0 This multiple holds information about each field being exported.
 ;;.4,105,0 EXPORT FORMAT^P.44'^DIST(.44,^105;1^Q
 ;;.4,105,21,0 ^^1^1^2921123^
 ;;.4,105,21,1,0 This field contains the foreign format used to make the export template.
 ;;.4,105,"DT" 2920904
 ;;.4,110,0 EXPORT TEMPLATE CREATED?^S^1:YES;0:NO;^105;3^Q
 ;;.4,110,21,0 ^^2^2^2921119^
 ;;.4,110,21,1,0 If YES, this Selected Fields for Export template has been used to create
 ;;.4,110,21,2,0 an Export template.
 ;;.4,110,"DT" 2920904
 ;;.4,115,0 MULTIPLE PATH^F^^105;4^K:$L(X)>30!($L(X)<1) X
 ;;.4,115,3 Answer must be 1-30 characters in length.
 ;;.4,115,21,0 ^^2^2^2921119^
 ;;.4,115,21,1,0 This field holds a list of field numbers representing the deepest multiple
 ;;.4,115,21,2,0 contained in this Export template.
 ;;.4,115,"DT" 2921119
 ;;.4,704,0 HEADER^CJ60^^ ; ^S X=$S($D(^DIPT(D0,"H")):^("H"),1:"")
 ;;.4,707,0 SUB-HEADER SUPPRESSED^S^1:YES^SUB;1^Q
 ;;.4,1620,0 PRINT FIELDS^XCmJ50^^ ; ^N DIR,DIPT,DRK,D,C,J,L,DHD,DA S DIPT=D0  D GET^DIPTED("DIR") F D=0:0 S D=$O(DIR(D)) Q:'D  S X=DIR(D) X DICMX Q:'$D(D)
 ;;.4,21400,0 BUILD(S)^Cmp9.6^^ ; ^N DIPTNAME,D S DIPTNAME=$P($G(^DIPT(D0,0)),U)_"    FILE #"_$P($G(^(0)),U,4) F D=0:0 S D=$O(^XPD(9.6,D)) Q:'D  I $D(^(D,"KRN",.4,"NM","B",DIPTNAME)) N D0 S D0=D,X=$P(^XPD(9.6,D,0),U) X DICMX Q:'$D(D)

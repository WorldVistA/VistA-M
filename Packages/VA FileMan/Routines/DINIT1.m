DINIT1 ;SFISC/GFT,XAK-INITIALIZE VA FILEMAN ;6NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1042,1044**
 ;
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT11:X?.P S @("^DD(0,"_$E($P(X," ",2),3,99)_")=Y")
 ;;.26,0 COMPUTE ALGORITHM^FJ30^^9.1;E1,245^K:$L(X)>50 X
 ;;.27,0 SUB-FIELDS^CJ1^^ ; ^Q:$D(DIQ(0))  X ^DD(0,.27,9.2) S X="" I $D(Y)#2,Y=U S DN=0
 ;;.27,9.2 S %=$S($D(^DD(DFF,D0,0)):+$P(^(0),U,2),1:0) I %,$D(^DD(%,.01,0)),$P(^(0),U,2)'["W" S DR="DFF=%,DN=1 D ^DIO2 S X="""",DFF="_DFF_",DN="_DN,X="D0" X "F Z=1:1 S DR=X_""=0,""_DR_"",""_X_""=""""""_@X_"""""""",X=""D""_X Q:$D(@X)[0","S "_DR
 ;;.28,0 MULTIPLE-VALUED^CB^^ ; ^S X=$P(^DD(DFF,D0,0),U,2)>0
 ;;.29,0 DEPTH OF SUB-FIELD^CJ1^^ ; ^S %=DFF X "F X=0:1 Q:'$D(^DD(%,0,""UP""))  S %=^(""UP"")"
 ;;.3,0 POINTER^F^^0;3
 ;;.3,9 ^
 ;;.4,0 GLOBAL SUBSCRIPT LOCATION^RF^^0;4^K:X'?1.E1";"1.E X I $D(X),@("$D("_DIC_"""GL"",$P(X,"";""),$P(X,"";"",2)))") K X
 ;;.4,1,0 ^.1^1^1
 ;;.4,1,1,0 DA(2)^GL
 ;;.4,1,1,1 S:X'?.P @(DIC_"""GL"",$P(X,"";""),$P(X,"";"",2),DA)=""""")
 ;;.4,1,1,2 K:X'?.P @(DIC_"""GL"",$P(X,"";""),$P(X,"";"",2),DA)")
 ;;.4,9 ^
 ;;.5,0 INPUT TRANSFORM^CJ44^^ ; ^S @("X=$P("_DCC_"D0,0),U,5,99)")
 ;;.5,9 ^
 ;;1,0 CROSS-REFERENCE^.1^^1;0
 ;;1.1,0 AUDIT^S^y:YES, ALWAYS;n:NO;e:EDITED OR DELETED;^AUDIT;1^Q
 ;;1.1,1,0 ^.1
 ;;1.1,1,1,0 0^AUD^MUMPS
 ;;1.1,1,1,1 I "ye"[X,$P(^DD(DA(1),DA,0),U,2)'["a" S $P(^(0),U,2)=$P(^(0),U,2)_"a"
 ;;1.1,1,1,2 S $P(^(0),U,2)=$P($P(^DD(DA(1),DA,0),U,2),"a")_$P($P(^(0),U,2),"a",2,9)
 ;;1.1,1,2,0 0^AUDIT^MUMPS
 ;;1.1,1,2,1 S:"ye"[X ^DD(DA(1),"AUDIT",DA)=""
 ;;1.1,1,2,2 K ^DD(DA(1),"AUDIT",DA)
 ;;1.2,0 AUDIT CONDITION^K^^AX;E1,245^D ^DIM
 ;;1.2,3 Enter Mumps Code that will set $T to 1 for Audit to take place.
 ;;2,0 OUTPUT TRANSFORM^F^^2;E1,245^D ^DIM
 ;;3,0 'HELP'-PROMPT^F^^3;E1,245^K:X'?3.E!($L(X)>200) X
 ;;4,0 XECUTABLE 'HELP'^F^^4;E1,245^D ^DIM
 ;;7.5,0 PRE-LOOKUP TRANSFORM^F^^7.5;E1,245^D ^DIM
 ;;8,0 READ ACCESS (OPTIONAL)^F^^8;E1,245^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;8,3 ENTER A STRING OF CHARACTERS WHICH ARE IN YOUR OWN ACCESS CODE ('DUZ(0)')
 ;;8.5,0 DELETE ACCESS (OPTIONAL)^F^^8.5;E1,245^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;9,0 WRITE ACCESS (OPTIONAL)^F^^9;E1,245^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;9.01,0 COMPUTED FIELDS USED^F^^9.01;E1,250^Q
 ;;9.01,1,0 ^.1^1^1
 ;;9.01,1,1,0 DA(2)^ACOMP^MUMPS
 ;;9.01,1,1,1 F %=1:1 S I=$P(X,";",%) Q:I=""  S ^DD("ACOMP",+I,+$P(I,U,2),DA(1),DA)=""
 ;;9.01,1,1,2 F %=1:1 S I=$P(X,";",%) Q:I=""  K ^DD("ACOMP",+I,+$P(I,U,2),DA(1),DA)
 ;;10,0 SOURCE^F^^10;E1,99^K:$L(X)>99 X
 ;;10,3 WHERE THIS DATA ELEMENT COMES FROM (UP TO 99 CHARACTERS)
 ;;11,0 DESTINATION^.2LAP^^11;0
 ;;12,0 POINTER SCREEN^^^12;E1,250
 ;;12.1,0 CODE TO SET POINTER SCREEN^^^12.1;E1,250^D ^DIM
 ;;12.2,0 EXPRESSION FOR POINTER SCREEN^^^12.2;E1,250
 ;;20,0 GROUP^.3LA^^20;0
 ;;21,0 DESCRIPTION^.001^^21;0

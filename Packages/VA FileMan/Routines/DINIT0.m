DINIT0 ;SFISC/GFT,XAK-INITIALIZE VA FILEMAN ;2JUL2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**164,1040,1042**
 ;
 I '$D(^DD("SETPTCNODE")) S ^("SETPTCNODE")=$H W !! F I=0:0 S I=$O(^DD(I)) Q:'I  F J=0:0 S J=$O(^DD(I,J)) Q:'J  S %=+$P($P($G(^(J,0)),U,2),"p",2) I %,$D(^DD(%,0)) S ^(0,"PTC",I,J)="" ;COMPUTED POINTER
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT1:X?.P S @("^DD(0,"_$E($P(X," ",2),3,99)_")=Y")
 ;;0 ATTRIBUTE^N
 ;;"SB",.1,1
 ;;.001,0 NUMBER^N^^ ^K:$L(X)>12 X
 ;;.01,0 LABEL^RF^^0;1^K:$L(X)>30!(X?1E)!(X["""")!(X["=") X
 ;;.01,1,0 ^.1^1^1
 ;;.01,1,1,0 DA(2)^B
 ;;.01,1,1,1 S @(DIC_"""B"",X,DA)=""""")
 ;;.01,1,1,2 K @(DIC_"""B"",X,DA)")
 ;;.01,"DEL",.2,0 I DUZ(0)'="@",$P(^DD(DA(1),DA,0),"^",2)["X" W !,$C(7),"ONLY A PROGRAMMER CAN DELETE THIS FIELD!"
 ;;.01,"DEL",.3,0 W:$D(^DD("ACOMP",DA(1),DA)) !,$C(7),"WARNING-- A COMPUTED FIELD USES THIS FIELD!" I 0
 ;;.01,"DEL",1,0 I DA=.01 W $C(7),"??"
 ;;.01,"DEL","TRB",0 S %=+$P(^DD(DA(1),DA,0),U,2) I %,$D(^DD(%,"TRB")) S DA(0)=DA,DA=% D TRIG^DIDH S DA=DA(0)
 ;;.01,"DEL","T",0 I $O(^DD(DA(1),DA,5,0))>0 W $C(7),!,"CAN'T DELETE A FIELD THAT HAS A 'TRIGGER' POINTING TO IT!"
 ;;.01,"DEL","ID",0 I $D(^DD(DA(1),0,"ID",DA)) W !,"CAN'T DELETE IDENTIFIER!"
 ;;.1,0 TITLE^F^^.1;E1,999^K:$L(X)>100!(+X=X) X I $D(X),$L(X)<32,@("$D("_DIC_"""B"",X,DA))") K X
 ;;.1,1,0 ^.1^1^1
 ;;.1,1,1,0 DA(2)^B
 ;;.1,1,1,1 S:$L(X)<31 @(DIC_"""B"",X,DA)=1")
 ;;.1,1,1,2 K:$L(X)<31 @(DIC_"""B"",X,DA)")
 ;;.1,3 (OPTIONAL) FULL FIELD NAME  (MUST BE DIFFERENT FROM LABEL)
 ;;.12,0 VARIABLE POINTER^.12^^V;0
 ;;.2,0 SPECIFIER^F^^0;2
 ;;.2,1,0 ^.1^4^4
 ;;.2,1,1,0 DA(2)^SB^ (SUBFILE USED)
 ;;.2,1,1,1 S:X @(DIC_"""SB"",+X,DA)=""""")
 ;;.2,1,1,2 K:X @(DIC_"""SB"",+X,DA)")
 ;;.2,1,2,0 DA(2)^RQ^
 ;;.2,1,2,1 S:X["R" @(DIC_"""RQ"",DA)=""""")
 ;;.2,1,2,2 K:X["R" @(DIC_"""RQ"",DA)")
 ;;.2,1,3,0 ^
 ;;.2,1,3,1 S %=$P(X,"P",2) S:$A(%)=48!%&$D(^DD(+%,0)) ^(0,"PT",DA(1),DA)=""
 ;;.2,1,3,2 S %=$P(X,"P",2) K:$A(%)=48!% ^DD(+%,0,"PT",DA(1),DA)
 ;;.2,1,666,0 ^
 ;;.2,1,666,1 N % S %=+$P(X,"p",2) I %,$D(^DD(%,0)) S ^(0,"PTC",DA(1),DA)="" ;COMPUTED POINTER
 ;;.2,1,666,2 N % S %=+$P(X,"p",2) I %,$D(^DD(%,0)) K ^(0,"PTC",DA(1),DA)
 ;;.2,9 ^
 ;;.23,0 LENGTH^CJ3^^ ; ^S X=$S($D(@(DCC_"D0,0)")):$P(^(0),U,2),1:""),X=$P(X,"J",2),X=$S(X:+X,1:"")
 ;;.23,9 ^
 ;;.24,0 DECIMAL DEFAULT^CJ1^^ ; ^S @("X=$P($G("_DCC_"D0,0)),U,2)"),X=$P($P(X,"J",2),",",2)
 ;;.25,0 TYPE^CJ15^^ ; ^S X=$P($G(@(DCC_"D0,0)")),U,2),X=$S(X["C":6,X["N":2,X["P":7,X["S":3,X["D":1,X["V":8,X["K":9,X["W"!$S('X:0,'$D(^DD(+X,.01,0)):0,1:$P(^(0),U,2)["W"):5,1:0),X=$S($D(^DOPT("DICATT",X,0)):$P(^(0)," "),1:"FREE TEXT")
 ;;.25,9 ^

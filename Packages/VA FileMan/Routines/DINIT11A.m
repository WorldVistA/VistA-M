DINIT11A ;SFISC/XAK-INITIALIZE VA FILEMAN ;06:30 PM  5 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
EGP I '$D(^DD("DD")) S ^("DD")="S Y=$$FMTE^DILIBF(Y,""5U"")" ;**CCO/NI DO NOT WRITE OVER DATE-OUTPUT CODE
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) Q:X?.P  S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;.001,0 DESCRIPTION^
 ;;.001,.01,0 DESCRIPTION^W^^0;1
 ;;.12,0 FIELD^
 ;;.12,0,"NM","VARIABLE-POINTER"
 ;;.12,.01,0 VARIABLE-POINTER^R*P1'^DIC(^0;1^S:DUZ(0)'="@" DIC("S")="I 1 Q:'$D(^(0,""RD""))  F %=1:1:$L(^(""RD"")) I DUZ(0)[$E(^(""RD""),%) Q" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;.12,.01,1,0 ^.1
 ;;.12,.01,1,1,0 .12^B
 ;;.12,.01,1,1,1 S ^DD(DA(2),DA(1),"V","B",X,DA)=""
 ;;.12,.01,1,1,2 K ^DD(DA(2),DA(1),"V","B",X,DA)
 ;;.12,.01,1,2,0 .12^PT^MUMPS
 ;;.12,.01,1,2,1 S ^DD(+X,0,"PT",DA(2),DA(1))=""
 ;;.12,.01,1,2,2 K ^DD(+X,0,"PT",DA(2),DA(1))
 ;;.12,.01,4
 ;;.12,.01,12.1 S:DUZ(0)'="@" DIC("S")="I 1 Q:'$D(^(0,""RD""))  F %=1:1:$L(^(""RD"")) I DUZ(0)[$E(^(""RD""),%) Q"
 ;;.12,.02,0 MESSAGE^RF^^0;2^K:$L(X)>30!($L(X)<1) X
 ;;.12,.02,1,1,0 .12^M^MUMPS
 ;;.12,.02,1,1,1 S ^DD(DA(2),DA(1),"V","M",X,DA)=""
 ;;.12,.02,1,1,2 K ^DD(DA(2),DA(1),"V","M",X,DA)
 ;;.12,.02,3 ANSWER MUST BE 1-30 CHARACTERS IN LENGTH
 ;;.12,.03,0 ORDER^RNJ4,1X^^0;3^K:+X'=X!(X>99)!(X<1)!(X?.E1"."2N.N) X I $D(X),$D(^DD(DA(2),DA(1),"V","O",X)),$O(^(X,0))'=DA K X I $D(^DD(DA(2),DA(1),"V",$O(^(0)),0)) S %=+^(0) W:% "  Used by "_$S($D(^DIC(%,0)):$P(^(0),U,1),1:%)_" FILE "
 ;;.12,.03,1,0 ^.1
 ;;.12,.03,1,1,0 .12^O^MUMPS
 ;;.12,.03,1,1,1 S ^DD(DA(2),DA(1),"V","O",X,DA)=""
 ;;.12,.03,1,1,2 K ^DD(DA(2),DA(1),"V","O",X,DA)
 ;;.12,.03,3 Type a unique number between 1 and 99, one decimal point allowed.
 ;;.12,.04,0 PREFIX^RFX^^0;4^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>10 X I $D(X),$D(^DD(DA(2),DA(1),"V","P",X)),$O(^(X,0))'=DA K X I $D(^DD(DA(2),DA(1),"V",$O(^(0)),0)) S %=+^(0) W:% "  Used by "_$S($D(^DIC(%,0)):$P(^(0),U,1),1:%)_" FILE "
 ;;.12,.04,1,0 ^.1
 ;;.12,.04,1,1,0 .12^P^MUMPS
 ;;.12,.04,1,1,1 S ^DD(DA(2),DA(1),"V","P",X,DA)=""
 ;;.12,.04,1,1,2 K ^DD(DA(2),DA(1),"V","P",X,DA)
 ;;.12,.04,3 Answer must be a unique prefix, 1-10 characters in length
 ;;.12,.05,0 SHOULD ENTRIES BE SCREENED^S^y:YES;n:NO;^0;5^Q
 ;;.12,.06,0 LAYGO^S^y:YES;n:NO;^0;6^Q
 ;;.12,.06,.1 SHOULD USER BE ALLOWED TO ADD A NEW ENTRY
 ;;.12,1,0 SCREEN^RFX^^1;E1,240^K:$L(X)>240!($L(X)<1)!(X'["DIC(""S"")") X D:$D(X) ^DIM
 ;;.12,1,.1 MUMPS CODE THAT WILL SET DIC('S')
 ;;.12,1,3 ANSWER MUST BE 1-240 CHARACTERS IN LENGTH AND VALID MUMPS CODE
 ;;.12,1,4 I X?1"??".E D HELP^DICATT4
 ;;.12,1,"DEL",1,0 I $P(^DD(DA(2),DA(1),"V",DA,0),U,5)="y" W !?3,"Answer 'NO' to the 'SHOULD ENTRIES BE SCREENED' prompt to delete the screen"
 ;;.12,2,0 EXPLANATION OF SCREEN^FR^^2;1^K:$L(X)>240!($L(X)<1) X
 ;;.12,2,3 ANSWER MUST BE 1-240 CHARACTERS IN LENGTH
 ;;.15,0 TRIGGERED-BY^
 ;;.15,0,"NM","TRIGGERED-BY"
 ;;.15,.01,0 DD NUMBER^N^^0;1^K:'$D(^DD(X)) X
 ;;.15,2,0 FIELD NUMBER^N^^0;2
 ;;.15,3,0 CROSS-REFERENCE NUMBER^N^^0;3
 ;;.3,0 GROUP^
 ;;.3,0,"NM","GROUP"
 ;;.3,.01,0 GROUP^F^^0;1^K:$L(X)>30!(X'?.ANP)!($A(X)<32) X
 ;;.3,.01,3 UP TO 30 CHARACTERS, ALPHANUMERIC
 ;;.3,.01,1,0 ^.1^1^1
 ;;.3,.01,1,1,0 0^GR
 ;;.3,.01,1,1,1 S ^DD(DA(2),"GR",X,DA(1),DA)=""
 ;;.3,.01,1,1,2 K ^DD(DA(2),"GR",X,DA(1),DA)
 ;;"$O" S Y="%" F %=0:0 S Y=$O(@Y) Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 ;;"KWIC" ^AND^THE^THEN^FOR^FROM^OTHER^THAN^WITH^THEIR^SOME^THIS^and^the^then^for^from^other^than^with^their^some^this

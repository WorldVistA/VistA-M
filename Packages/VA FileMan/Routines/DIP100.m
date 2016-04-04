DIP100 ;SFISC/TKW - PROCESS BY(0) INPUT VARIABLES (CONT.OF DIP10) ;12:27 PM  13 Oct 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
ENBY0 ; Interactive dialogue to prompt for BY(0) data
 Q:DUZ(0)'["@"  K DPP,BY(0),L(0),FR(0),TO(0),DISPAR(0) N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
EDBY W ! S DIR(0)=".401,1622O",DIR("B")=$G(BY(0)) D ^DIR K DIR G:$G(DTOUT)!("^^@"[X) EXBY0 S:$E(Y)="^" Y=$E(Y,2,9999) S BY(0)="^"_$P(Y,U)
 S DIR(0)=".401,1623",DIR("B")=$G(L(0)) D ^DIR K DIR G:X="@" EDBY G:$G(DIRUT) EXBY0 S L(0)=$P(Y,U)
 F X=L(0):1:8 K FR(0,X),TO(0,X),DISPAR(0,X)
 G:L(0)'>1 BYOK N DISUB D  G:$G(DTOUT)!($G(DIROUT)) EXBY0 G BYOK
E2 . S DIR("?")="Enter 'YES' to experiment with these settings",DIR("?",1)="This will let you define sort ranges for any of the variable subscripts"
 . S DIR("?",2)="in the global referenced by BY(0).  It will also let you define sort",DIR("?",3)="qualifiers including page breaks and customized subheaders.",DIR("?",4)=""
 . W ! S DIR(0)="Y",DIR("A")="Edit ranges or subheaders",DIR("B")="NO" D ^DIR K DIR Q:'Y!$D(DIRUT)
 . W ! S DIR(0)=".4011624,.01^^K:X>(L(0)-1) X",DIR("B")=1 D ^DIR K DIR,DINUM Q:$G(DIRUT)  S DISUB=$P(Y,U)
E3 . S DIR(0)=".4011624,1",DIR("B")=$G(FR(0,DISUB)) D ^DIR K DIR Q:$G(DTOUT)  Q:$G(DIROUT)  G:X="^" E2 K FR(0,DISUB) I X'="@",Y]"" S FR(0,DISUB)=$P(Y,U)
 . S DIR(0)=".4011624,2",DIR("B")=$G(TO(0,DISUB)) D ^DIR K DIR Q:$G(DTOUT)  Q:$G(DIROUT)  G:X="^" E2 K TO(0,DISUB) I X'="@",Y]"" S TO(0,DISUB)=$P(Y,U) I $G(FR(0,DISUB))]$P(Y,U) D  G E3
EGP .. W !,$$EZBLD^DIALOG(1511) Q  ;**CCO/NI 'START WITH IS GREATER THAN GO TO!'
 . S DIR(0)=".4011624,3.1",DIR("B")=$P($G(DISPAR(0,DISUB)),U,1) D ^DIR K DIR D:X="@"  G:$D(DUOUT)!$D(DTOUT) E2 S:Y]"" $P(DISPAR(0,DISUB),U,1)=Y
 .. I $P($G(DISPAR(0,DISUB)),U,2)]"" S $P(DISPAR(0,DISUB),U,1)="" Q
 .. K DISPAR(0,DISUB) Q
 . S DIR(0)=".4011624,3.2",DIR("B")=$P($G(DISPAR(0,DISUB)),U,2) D ^DIR K DIR D:X="@"  G:$D(DIRUT) E2 S $P(DISPAR(0,DISUB),U,2)=Y
 .. I $P($G(DISPAR(0,DISUB)),U,1)]"" S $P(DISPAR(0,DISUB),U,2)="" Q
 .. K DISPAR(0,DISUB) Q
 . S DIR(0)=".4011624,4",DIR("B")=$G(DISPAR(0,DISUB,"OUT")) D ^DIR K DIR Q:$G(DTOUT)  Q:$G(DIROUT)  K DISPAR(0,DISUB,"OUT") I "^@"'[X,Y]"" S DISPAR(0,DISUB,"OUT")=Y
 . G E2
BYOK I $G(DIEDITBY) Q:DUZ(0)'["@"  N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 W !!,"  BY(0)="_BY(0)_"     L(0)="_L(0),!
 I L(0)>1,$O(FR(0,0))!$O(TO(0,0))!$O(DISPAR(0,0)) D
 . F X=1:1:(L(0)-1) W !,"  SUB: "_X D
 .. W ?10,"FR(0,"_X_"): ",$G(FR(0,X)),!,?10,"TO(0,"_X_"): ",$G(TO(0,X)),!
 .. W ?10,"DISPAR(0,"_X_") PIECE ONE: ",$P($G(DISPAR(0,X)),U,1),!
 .. W ?10,"DISPAR(0,"_X_") PIECE TWO: ",$P($G(DISPAR(0,X)),U,2),!
 .. W:$D(DISPAR(0,X,"OUT")) ?10,"DISPAR(0,"_X_",OUT): ",$G(DISPAR(0,X,"OUT")),!
 .. Q
 .Q
 S DIR(0)="Y",DIR("A")="  OK",DIR("B")="YES" D ^DIR K DIR G:$G(DIRUT) EXBY0 G:'Y EDBY
 D EN^DIP10 G:$G(BY(0))="" EDBY Q
EXBY0 W ! K BY(0),L(0),FR(0),TO(0),DISPAR(0),DPP(0) Q

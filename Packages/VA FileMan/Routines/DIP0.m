DIP0 ;SFISC/XAK-COMPUTED FIELD ON A SORT, EDITING A SORT TEMPLATE ;2015-01-01  2:08 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,999,1003,1037,1045,1050**
 ;
 S P=P_Q,DPP=$P(X,U,1)
C ;
 S DICOMP=N_$E("?",''L),DM=X,DQI="Y(",DA="DPP("_DJ_",""OVF"_N_""",",DICMX="D M^DIO2" G COLON:X?.E1":" D EN^DICOMP K DUOUT G X:'$D(X),X:Y["m"
 D XA,BB^DIP:Y["B" S:Y["D" R=R_"^^D" S Y=U_DPP,DPP(DJ,"CM")=X_" I D"_(N#100)_">0 S DISX("_DJ_")=X" G S^DIP
 ;
XA F %=0:0 S %=$O(X(%)) Q:%=""  S @(DA_"%)=X(%)")
 Q
 ;
 ;
COLON D ^DICOMPW K DUOUT
 I $D(X),$S($D(DIL(+DP)):DIL(+DP)=DL,1:1) S DPP(DJ,DL,+Y)=DP_U_(Y["m")_U_X,DIL(+DP)=DL,N=+Y,DL=+DP,DV=$J("",DJ*2-2)_$O(^DD(DL,0,"NM",0))_" FIELD" S:$D(DIPP(DIJ,+DP))#2 $P(DIPP(DIJ),U,3)=DIPP(DIJ,+DP) D XA,L G Y^DIP
X I $G(BY)]"" S:BY[";" R=BY,BY=$P(BY,";"),R=U_$P(R,BY,2,9) S (X,DPP)=DM_","_BY,BY="" G C ;TRY TACKING ON THE REST OF THE "BY", AFTER THE FIRST COMMA, BOTH TO 'X' AND TO 'DPP'
 I $G(DIQUIET) G Q^DIP
 G B^DIP
 ;
EDT ;
 S DIE="^DIBT(",DR=".01;3;6",DA=X,DIPP=DI,DIOVRD=1 D ^DIE S DI=DIPP,DE=$S(L=0!L:"SORT",1:L) K DR,DIE,DIPP,DIOVRD I '$D(DA)!($D(Y)) S (X,DJ)=+$G(DPP(0)) Q
 S %=$G(DPP(0,"IX")) I $P(%,U,2)]"",$P(%,U,4) D  I $G(DPP(0))']"" S (X,DJ)=0 Q
 . N X,I,Y,F,T,O,Q,DIEDITBY S DIEDITBY=1 K FR(0),TO(0),DISPAR(0),DIPP
 . S BY(0)="^"_$P(%,U,2),L(0)=$P(%,U,4)
 . F I=L(0):1 Q:'$D(DPP(I))  M DIPP(I)=DPP(I) K DPP(I)
 . F I=1:1:(L(0)-1) D  Q:'$G(L(0))
 .. S F=$P($G(DPP(I,"F")),U,2),T=$P($G(DPP(I,"T")),U,2) S:F]"" FR(0,I)=F S:T]"" TO(0,I)=T
 .. S O=$P($G(DPP(I)),U,4),Q="" S:O["!" Q=Q_"!" S:O["#" Q=Q_"#" S:$P($G(DPP(I)),U,5)]"" Q=Q_"^"_$P(DPP(I),U,5) S:Q]"" DISPAR(0,I)=Q
 .. I $G(DISPAR(0,I))]"",$G(DPP(I,"OUT"))]"" S DISPAR(0,I,"OUT")=DPP(I,"OUT")
 .. K DPP(I) Q
 . D BYOK^DIP100
 . I $G(DPP(0))]"" S X=DPP(0) F I=0:0 S I=$O(DIPP(I)) Q:'I  S X=X+1 M DPP(X)=DIPP(I)
 . K DIPP Q
 S DIPP="",DIJ=0 F DJ=$G(DPP(0)):0 S DJ=$O(DPP(DJ)) Q:'DJ  S DIJ=DIJ+1,%X="DPP(DJ,",%Y="DIPP(DIJ," D %XY^%RCR
 S DIJ=0 F DJ=$G(DPP(0)):0 S DJ=$O(DPP(DJ)) Q:DJ=""  D
 . S DIJ=DIJ+1 N X S X=$P(DPP(DJ),U,4),X=$TR(X,"B",""),X=$S(X[Q:$P(X,Q,($L(X,Q)-1)),1:X)
 . S $P(DIPP(DIJ),U,3)=X_$P(DPP(DJ),U,3)_$P(DPP(DJ),U,5)
 . S %=+DPP(DJ) D E1 S %X=0 D E2 K DPP(DJ)
 . Q
 S DJ=$G(DPP(0)),DIJ=0 F  S DIJ=+$O(DIPP(DIJ)) Q:'DIJ  S DJ=DJ+1 D DJ^DIP Q:$D(DTOUT)!($D(DIRUT))!('$D(DJ))  W:X="@" "  Deleted."
 K DIPP,DIJJ S:X'=U X=1 S:'$D(DXS) DXS=1 S DIEDT=1 Q
E1 ;
 F DIJJ=0:1 Q:'$D(^DD(%,0,"UP"))  S DIPP(DIJ,%)=$P(DIPP(DIJ),U,3),%=+^("UP"),$P(DIPP(DIJ),U,3)=$O(^("NM",0)),$P(DIPP(DIJ),U,1)=%
 Q
E2 S %X=$O(DPP(DJ,%X)) I %X'>0 K %X Q
 G E2:'$D(DPP(DJ,%X,100)) S %=%X D E1 S %=DPP(DJ,%X,100)
 I $P(%,U,3) S DIPP(DIJ,+%)=$P(DIPP(DIJ),U,3),$P(DIPP(DIJ),U,3)=$P(^DIC(+%,0),U)_":",$P(DIPP(DIJ),U)=+% G E2
 I %'["Y(1)" S %=$F(%,"OVF0") Q:'%  S %=+$E(DPP(DJ,%X,100),%+2,99),%=$P(DPP(DJ,%X,100),U)_U_DPP(DJ,"OVF0",%) Q:%'["Y(1)"
WHO S G=$TR($P($P($P(%,"Y(1)",2),")):^(",2),")"),""""),P=$P(%,"Y(1)",3),P=$P($P(P,"U,",2),")") I G]"",P]"" S P=+$O(^DD(%X,"GL",G,P,0))
 I P,$D(^DD(%X,P,0)) S:DIJJ DIPP(DIJ,+%)=DIPP(DIJ,%X),DIPP(DIJ,%X)=$P(^(0),U)_":" S:'DIJJ DIPP(DIJ,+%)=$P(DIPP(DIJ),U,3),$P(DIPP(DIJ),U,3)=$P(^(0),U)_":"
 G E2
 ;
 ;
 ;
L ;FROM DIP: READ SORT-BY VALUE
 I $D(BY)#2 K DIC S DIC="^DD(DL,",DIC(0)="Z",X=$P(BY,","),BY=$P(BY,",",2,99) I X'="@" K DV Q
 K DIR D
 . N X S DIR(0)="FOU",DIR("A")=DV
 . S X=$P($G(DIPP(DIJ)),U,3) I X]"" S DIR("B")=X
 . E  I DJ=1 N DICAN S DICAN=$$FIND^DIUCANON(.401,DL) I DICAN S (X,DIR("B"))="["_$P(DICAN,U,2)_"]" ;CANONIC SORT TEMPLATE
 . I X="" S X=$G(DV(1)) I X]"" S DIR(0)="FOAU",DIR("A")=DV_": "_X_"// "
 . S DIR(0)=DIR(0)_"^1:255",DIR("?")="^D DIC^DIP0"
 D ^DIR K DIR,DV,DIRUT,DIROUT S:$D(DTOUT) X="^"
 K:X?1"^"1.E DUOUT
 I X="@" K DPP(DJ) S DJ=DJ-1
 D SETDIC Q
 ;
SETDIC K DIC S DIC="^DD(DL,"
 S DIC("S")="S %=$P(^(0),U,2) I %'[""m"",$S('%:1,1:$P(^DD(+%,.01,0),U,2)'[""W""&$S($D(DIL(+%)):DIL(+%)=DL,1:1))"_$S($D(DICS):" "_DICS,1:"")
 S DIC("W")="W:$P(^(0),U,2) ""  multiple)""" I $T(DICW^DIALOGZ)]"" D DICW^DIALOGZ(DL)
 S DIC(0)="ZE"_$E("O",$D(DIPP)#10) Q
 ;
DIC D SETDIC,^DIC,DIP^DIQQ Q

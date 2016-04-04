DIP11 ;SFISC/XAK,TKW-GET SORT TEMPLATE ;23JULY2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**97,163,1004,1037,1038,1048,1049,150**
 ;
SCREENTM(Z,D2) ;Z=ZERO NODE OF SORT TEMPLATE;  D2 = THERE IS SORT-BY LOGIC
 I $P(Z,U,4)-DL Q 0 ;TEMPLATE MUST BE FOR THIS FILE
 I 'D2&'L D  Q $D(Z) ;IN SILENT MODE, DON'T PICK SEARCH OR INQUIRY TYPE IF THERE'S A SORT TYPE OF SAME NAME
 .N NAME,I S NAME=$P(Z,U) F I=0:0 S I=$O(^DIBT("B",NAME,I)) Q:'I  I I-Y,$P($G(^DIBT(I,0)),U,4)=DL,$D(^(2)) K Z Q
 I DUZ(0)="@" Q 1
 I D2 Q:'L 1 Q:$P(Z,U,3)="" 1 Q $TR($P(Z,U,3),DUZ(0))'=$P(Z,U,3) ;IF A SORT TEMPLATE, ACCESS CODES MUST MATCH
 I '$P(Z,U,5) Q 1
 I $P(Z,U,5)=DUZ Q 1 ;If a SEARCH or INQUIRY TEMPLATE, USER MUST MATCH
 Q 0
 ;
TEM ;
 G B^DIP:DJ-1 K DPP,DIC
 S X=$P($E(X,2,99),"]",1),DIC(0)="ZQS"_$E("E",'($D(BY)#2)!''L),DIC="^DIBT(",D="F"_DL
 S DIC("S")="I $$SCREENTM^DIP11(^(0),$D(^(2)))"
 I X?."?" S:X'?1"???" X="??" D IX^DIC S DJ=0 Q
 D ^DIC I Y<0 S DJ=0 Q  ;LOOK UP THE SORT TEMPLATE
EMPTY I '$D(^DIBT(+Y,2)),'$D(^(1)),'$D(^("BY0")) W:'$G(DIQUIET) !,$$EZBLD^DIALOG(1509) S DJ=0 Q  ;SORT TEMPLATE HAS NO VALUES
 S DPP(DJ)=DL_"^^'"_$P(Y,U,2)_"' "_$$EZBLD^DIALOG(7099)_"^@'"_P,(DIBT1,X)=+Y,DIBT2=$P(Y(0),U),D=DIC_X_"," K DIC ;*CCO/NI   SORT TEMPLATE 'NUMBER'
 I '$D(FLDS),$G(^DIBT(X,"DIPT"))]"" S FLDS="["_^("DIPT")_"]" I L D
 . ;N %,A S %(1)=^("DIPT") D BLD^DIALOG(8030,.%,"","A") W ! F %=0:0 S %=$O(A(%)) Q:'%  W A(%),!
 . S L=0 Q  ;??
 I $D(^DIBT(X,1)) S DIC=D_1_C,DPP(DJ,"SER")="998^998" D ENT^DIP10(DJ,DIBT1) I $D(^DIBT(X,1)) S Y=1 D
 .F DY=1:1 S Y=$O(^(Y,-1)) S:Y="" Y=-1 S:$O(^(Y)) Y=$O(^(Y)) I $D(^(Y))<9 S DPP(DJ,"IX")=DIC_DI_U_DY,DIBT=X Q
 .Q
ENDIPT I $G(^DIBT(X,"BY0"))="",'$D(^DIBT(X,2)) Q
 I $G(^DIBT(X,"BY0"))="",$G(^DIBT(X,2,0))="" S %Y="DPP(",%X=D_"2," D %XY^%RCR S DIBTOLD="" D CNVCM G T0
 S D=$G(^DIBT(X,"BY0")) I $P(D,U)]"",$P(D,U,2) D
 . N Y K DISPAR(0) S BY(0)="^"_$P(D,U),L(0)=$P(D,U,2)
 . F D=1:1:(L(0)-1) D
 .. S Y=$G(^DIBT(X,"BY0D",D,0))
 .. I '$D(FR(0,D))#2,$P(Y,U,2)]"" S FR(0,D)=$P(Y,U,2)
 .. I '$D(TO(0,D))#2,$P(Y,U,3)]"" S TO(0,D)=$P(Y,U,3)
 .. I $G(^DIBT(X,"BY0D",D,1))]"" S DISPAR(0,D)=^(1) S:$G(^DIBT(X,"BY0D",D,2))]"" DISPAR(0,D,"OUT")=^(2)
 .. Q
 . N X D EN^DIP10 Q
 ;S DJ=$O(DPP(999),-1)+1
 F D=0:0 S D=$O(^DIBT(X,2,D)) Q:'D  D  ;GO THRU THE SORT LEVELS OF THE STORED TEMPLATE
 .N A,B,C S DPP(DJ)=$G(^DIBT(X,2,D,0))
BRINGIN .S A="A" F  S A=$O(^DIBT(X,2,D,A)) Q:A=""  I A'="SER" S DPP(DJ,A)=^(A) I A["COMPUTED" M DPP(DJ,A)=^(A)
 .F B=1,2,3 F A=0:0 S A=$O(^DIBT(X,2,D,B,A)) Q:'A  S C=$G(^(A,0)) D
 ..I B=1 S:$P(C,U)=+C DPP(DJ,+C)=$P(C,U,2) Q
 ..I B=2 S:($P(C,U)=+C)&($P(C,U,2)=+$P(C,U,2)) DPP(DJ,+C,$P(C,U,2))=$P(C,U,3,7)_U_$G(^DIBT(X,2,D,2,A,"RCOD")) Q
 ..I $P(C,U,1)]"",$P(C,U,2)]"" S DPP(DJ,$P(C,U,1),$P(C,U,2))=$G(^DIBT(X,2,D,3,A,"OVF0"))
 ..Q
 .S DJ=DJ+1 Q
T0 Q:$D(DIBTRPT)
 I $D(DIAR) S DIARU=X ;I '$P(DIARB,U,2) S $P(DIARB,U,2)=DIARU
 F D=0:0 S D=$O(^DIBT(X,3,D)) Q:D=""  S DSC(D)=^(D)
 I 'L!($D(DPP(0))&(DUZ(0)'="@"))!$D(^DIBT(X,"CANONIC")) G T1
 S %=$P(^DIBT(X,0),U,6) ;CHECK WRITE ACCESS TO SORT TEMPLATE
 I %]"" F D=1:1:$L(%) I DUZ(0)[$E(%,D)!(DUZ(0)="@") S %="" Q
 I %="",X'<1 S %=$P(Y(0),U,1) D  G Q:$D(DIRUT) I %=1 K DIBTOLD G EDT^DIP0
 . N X,Y K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="WANT TO EDIT '"_%_"' TEMPLATE" D ^DIR K DIR
 . S %=Y Q
 ;DON'T WANT TO EDIT
T1 F DJ=$G(DPP(0))+1:1 Q:'$D(DPP(DJ))  D  I '$D(DJ)!($D(DTOUT))!($D(DIRUT)) G Q
 . N DL,DU,DV,X,Y,Z,DIFLD,DIFLDREG K DPP(DJ,"PTRIX") S DL=$P(DPP(DJ),U),Y=$P(DPP(DJ),U,2,3)
 . D DTYP^DIP1,STXT^DIP1(DJ,$G(DPP(DJ,"F")),$G(DPP(DJ,"T")),DITYP)
 .; Save off old "IX" node to preserve it if template is hand-edited.
 . I DJ=1 N DISAVIX,DIRECSRT S DISAVIX=$G(DPP(DJ,"IX")),DIRECSRT=0
 . K DPP(DJ,"IX")
 . I $P(DPP(DJ),U,4)'["-",'$D(DPP(DJ,"SRTTXT")),$P($G(DPP(DJ,"F")),U)'="?z",$P($G(DPP(DJ,"T")),U)'="@" D XR^DIP I DJ=1,DISAVIX]"",DISAVIX'=$G(DPP(DJ,"IX")) D
 .. N I,X,Y,Z S X=$P(DISAVIX,U,3),Z=$P(DISAVIX,U,2) I $E(Z,1,$L(X))'=X S DIRECSRT=1 G T12
 .. S Z=$E(Z,($L(X)+1),99),Z=$P(Z,"""",2) Q:Z=""  I '$D(^DD(S,0,"IX",Z)) D  Q:Z=""
 ... Q:S=405&(Z="ATT3")  S Z="" Q
T12 .. S DPP(DJ,"IX")=DISAVIX,DPP(DJ,"SER")="998^998"
 .. I DIRECSRT=1,$P(DPP(DJ),U,2)="",'($P($P(DPP(DJ),U,4),"""",2)),'$D(DPP(DJ,"CM")) S $P(DPP(DJ),U,2)=0
PROMPT . I $D(DPP(DJ,"ASK")) S DPP(DJ,"ASK")=1 I $G(DICNVDPP)'=1 D DIP11^DIP1 Q  ;GFT PATCH 97
 . I DJ=1,DISAVIX=1 Q
 . D OPT^DIP12 Q
 Q:$G(DICNVDPP)=1
 D DPQ^DIP1 S X="["_DIBT2 K DIARE,DIARS,DIARB Q
 ;
CNVCM ;Convert V20 DPP array to V21 DPP array (for prints queued in V20 to run in V21)
 N D,I,J,X,Y,Z,N
 F D=0:0 S D=$O(DPP(D)) Q:'D  S X=$G(DPP(D,"CM")) I X["S X(" D
 . S (I,Z)=0 F  S Y=$F(X,"S X(",Z) Q:'Y  S Z=Y,I=I+1
 . Q:'Z  S N=+$E(X,Z) Q:'N
 . I $L(X)+16>248 D  Q
 .. S Z="OVF",I=-1 F  S Z=$O(DPP(D,Z)) Q:$E(Z,1,3)'="OVF"  S I=$E(Z,4,99)
 .. S Z="OVF"_(I+1),Y=$P(X," S X=",1) S:Y]"" Y=Y_" "
 .. S DPP(D,"CM")=Y_"X DPP("_D_","""_Z_""",9.2) I $G(X("_N_"))]"""" S DISX("_N_")=X("_N_")"
 .. S Y=$P(X," S X=",2,99),DPP(D,Z,9.2)=$P("S X=",U,(Y]""))_Y Q
 . S DPP(D,"CM")=$P(X,"S X(",1,I)_"S DISX("_$P(X,"S X(",I+1,99)
 . Q
 Q
 ;
Q S:$D(DUOUT)!($D(DTOUT)) X="^" G Q^DIP
 ;DIALOG #8030  'Because...sort template...linked w/Print template...

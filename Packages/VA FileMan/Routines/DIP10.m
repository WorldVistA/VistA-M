DIP10 ;SFISC/TKW - PROCESS BY(0) INPUT VARIABLES ;12:59 PM  6 Aug 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2**
 ;
EN ;
 N I,J,K,X,Y,DIR K DPP(0),DPP(1) I $G(BY(0))="" D BLD^DIALOG(201,"BY(0)")
 I $G(BY(0))]"",$E($G(BY))="[" D BLD^DIALOG(201,"BY")
 I $E(BY(0))'="[" D  I Y=-1 D BLD^DIALOG(201,"BY(0)")
 . N %,X S X=BY(0),Y="" I X'["(" S:X[")"!(X[",") Y=-1 Q:Y=-1  S X=X_"("
 . S:$E(X)'=U X=U_X
 . S %=$E(X,$L(X)) S:%=")" $E(X,$L(X))=",",%="," I ",("'[% S X=X_","
 . S BY(0)=X Q
 I $E(BY(0))="[" D  I Y'<0 S BY(0)="^DIBT("_+Y_",1,",L(0)=1
 .N DIC,DIBTFILE,DJ,DCC,DI,DNP,L S DIBTFILE=S N S
 .S X=$P($E(BY(0),2,99),"]"),DIC="^DIBT(",DIC(0)="Q",DIC("S")="I '$P(^(0),U,8),$P(^(0),U,4)=DIBTFILE,$P(^(0),U,5)=DUZ!'$P(^(0),U,5),$O(^(1,0))"
 .D ^DIC
 .I Y<0 S I(1)=BY(0) D BLD^DIALOG(1500,.I)
 .Q
 I '$G(L(0))!($G(L(0))>8) D BLD^DIALOG(201,"L(0)")
 G:$D(DIERR) EX
 S DPP(0)=L(0)-1 K DISTXT
 S J=8004 I BY(0)?1"^DIBT("1.N1",1," S J=+$P(BY(0),"^DIBT(",2) D ENT(0,J) S J=8003
 I '$D(DISTXT) S I(1)=$S($E(BY(0),$L(BY(0)))=",":$E(BY(0),1,($L(BY(0))-1))_")",1:BY(0)) D BLD^DIALOG(J,.I,"","DIR") S DPP(0,"TXT")=DIR
DPP F I=1:1:L(0)-1 S DPP(I)=S_"^^SORT FIELD "_I_"^""@^^^^^^4",DPP(I,"SER")="999^999",(DPP(I,"GET"),DPP(I,"CM"))="S DISX("_I_")=DIOO"_(L(0)-I)
 S DPP(0,"IX")=$E(U,$E(BY(0))'=U)_BY(0)_DCC_U_$S($D(L(0)):L(0),1:1)
 F I=0:0 S I=$O(FR(0,I)) Q:'I  I FR(0,I)]"",$D(DPP(I)) S (Y,K)=FR(0,I) D FRV^DIP1 S DPP(I,"F")=Y_U_K S:I=1 DPP(0,"F")=Y_U_K
 F I=0:0 S I=$O(TO(0,I)) Q:'I  I TO(0,I)]"",$D(DPP(I)) S DPP(I,"T")=TO(0,I)_U_TO(0,I)
 F I=0:0 S I=$O(DISPAR(0,I)) Q:'I  I DISPAR(0,I)]"" D
 .S X="""",J=$P(DISPAR(0,I),U) F K="!","#","+","@" I J[K S X=X_K
 .I X'["@",$P(DISPAR(0,I),U,2)'[";""" S X=X_"@"
 .S $P(DPP(I),U,4)=X S $P(DPP(I),U,5)=$P(DISPAR(0,I),U,2)
 .I $G(DISPAR(0,I,"OUT"))]"" S DPP(I,"OUT")=DISPAR(0,I,"OUT")
 .Q
 I $D(FR)#2!($D(TO)#2) S J="",$P(J,",",L(0))="" S:$D(FR)#2 FR=J_FR S:$D(TO)#2 TO=J_TO G ENX
 S J=$O(FR(8),-1) I J F J=J:-1:0 I $D(FR(J))#2 S FR(J+DPP(0))=FR(J) K FR(J)
 S J=$O(TO(8),-1) I J F J=J:-1:0 I $D(TO(J))#2 S TO(J+DPP(0))=TO(J) K TO(J)
ENX S DJ=L(0) K L(0),FR(0),TO(0),DISPAR(0)
 Q
 ;
ENT(I,J) ;MOVE TEXT OF SEARCH AND GET CODE FROM SEARCH TEMPLATE TO DPP ARRAY
 ;I=Entry no.in DPP array, J=record number for search template
 Q:$G(I)=""  Q:'$G(J)  N DIR,%X,%Y
 D BLD^DIALOG(8003,$P($G(^DIBT(J,0)),U),"","DIR") D:$O(^DIBT(J,"O",0))  S DISTXT(99,0)=DIR
 . S %X="^DIBT("_J_",""O"",",%Y="DISTXT(" D %XY^%RCR
 . S DIR="("_DIR_")" Q
 S:I DPP(I,"GET")="S DISX("_I_")=D0"
 Q
 ;
EX K BY(0),L(0) I $G(DIQUIET) D CLEAN^DIEFU Q
 D MSG^DIALOG("W") Q
 ;
 ;DIALOG #201    'The input variable...is missing or invalid.'
 ;       #1500   'Search template...in BY(0) variable cannot be found...'
 ;       #8003   'Records from list on...search template.
 ;       #8004   'Sort using...'
 ;

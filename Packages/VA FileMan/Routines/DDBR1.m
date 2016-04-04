DDBR1 ;SFISC/DCL-VA FILEMAN BROWSER PROTOCOLS ;06:01 PM  31 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 Q
GOTO N X
GTR S X(1)=$G(X(1)),X(2)=$$EZBLD^DIALOG(1408)_" >" W $$WS(.X) D  G:X=""!(X=U) OUT ;**
 .D EN^DIR0($P(DDBSY,";",3)-1,$L($G(X(2)))+2,30,1,"",100,"","","KPW",.X)
 .K DIR0
 .Q
 I $E(X)="?" S X(1)="* "_$$EZBLD^DIALOG($S(DDBRHTF:1409,1:1409.1))_" *" G GTR ;**
 I X S X=X*DDBSRL G LINE
 S $E(X)=$TR($E(X),"bclst","BCLST")
 I X["S",$TR($P(X,"S",2)," ") S X=$TR($P(X,"S",2)," ")*DDBSRL G LINE
 I X["L",$TR($P(X,"L",2)," ") S X=$TR($P(X,"L",2)," ") G LINE
 I X["C",'DDBRHTF,$TR($P(X,"C",2)," ") S X=$TR($P(X,"C",2)," ") I X>0&(X<256) S DDBSF=X G COLENT^DDBR0
 I $E(X)="T" G TOP^DDBR0
 I $E(X)="B" G BOT^DDBR0
 G OUT
LINE S DDBL=$S(X'>DDBSRL:0,X>DDBTL:DDBTL,1:X) D PSR^DDBR0()
 Q
NOOF N N
 S N=1 I $D(DDBFNO) N D,X G FNO
 S X(1)="    * ["_$$EZBLD^DIALOG(1406)_"] *" ;**'NO PREVIOUS FIND STRING AVAILABLE'
 N Q S N=0 G BPR
FIND N D,Q,X
 N N
 S N=0
BPR S X(1)=$G(X(1)),X(2)=$$EZBLD^DIALOG(8126) W $$WS(.X) D  G:X="" OUT ;**
 .N Y
 .D EN^DIR0($P(DDBSY,";",3)-1,$L($G(X(2)))+2,30,1,$P($G(DDBFNO),U,3,255),100,"","","KPW",.X,.Y)
 .K DIR0
 .S:$P($G(Y),U)="U" X=X_"/U"
 .Q
 S Q=$TR($E(X,$L(X)-1,$L(X)),"u","U")
 S D=$S(Q="/U":-1,1:1)
 S:D=-1 X=$E(X,1,$L(X)-2)
 Q:X=""
 I $E(X)="?" S X(1)="    * [ "_$$EZBLD^DIALOG(1407)_" ] *" G BPR ;**
FNO N I,MATCHI,MATCHX
 I N S D=$P(DDBFNO,"^",2),X=$P(DDBFNO,"^",3,255)
 S X(1)="",X(2)="    * ["_$$EZBLD^DIALOG(1405,X)_"] *" W $$WS(.X) ;**'SEARCHING'
 D  S:I<0 I=0
 .I N&(D=1) S I=DDBL Q
 .I N S I=DDBL-(DDBSRL-1) Q
 .I D=1 S I=DDBL-DDBSRL Q
 .S I=DDBL+1
 .Q
 D
 .N XUC
 .S XUC=$$U(X)
 .I DDBDM D  Q
 ..I DDBZN D  Q
 ...F  S I=$O(^TMP("DDB",$J,I),D) Q:I'>0  I $$U($G(^(I,0)))[XUC S MATCHI=I,MATCHX=^(0) Q
 ...Q
 ..F  S I=$O(^TMP("DDB",$J,I),D) Q:I'>0  I $$U(^(I))[XUC S MATCHI=I,MATCHX=^(I) Q
 ..Q
 .I DDBZN D  Q
 ..F  S I=$O(@DDBSA@(I),D) Q:I'>0  I $$U($G(@DDBSA@(I,0)))[XUC S MATCHI=I,MATCHX=@DDBSA@(I,0) Q
 ..Q
 .F  S I=$O(@DDBSA@(I),D) Q:I'>0  I $$U(@DDBSA@(I))[XUC S MATCHI=I,MATCHX=@DDBSA@(I) Q
 .Q
 I $G(MATCHI) D  S DDBFNO=DDBL_"^"_D_"^"_X Q
 .S DDBSF=1,DDBST=IOM F  Q:$F(MATCHX,X)'>DDBST  D
 ..S DDBSF=$O(@DDBC@(DDBSF)) S:DDBSF="" DDBSF=$O(@DDBC@(""))
 ..S DDBST=DDBSF+(IOM-1)
 ..Q
 .I I+(DDBSRL)>DDBTL S I=DDBTL-(DDBSRL-1)
 .I DDBTL'>DDBSRL S I=1
 .S DDBL=I-1 D SDLRH(I,X),RCLSI^DDBR0
 .Q
NO S X(1)="",X(2)="    * ["_$$EZBLD^DIALOG($S(N:8006.11,1:8006.1))_" ] *" W $C(7),$$WS(.X) H 3  ;**'NO MATCH FOUND'
 D PSRH
 Q
OUT D PSR^DDBR0()
 Q
PSRH S DDBL=$S(DDBL'>DDBSRL:0,1:DDBL-DDBSRL)
 D SDLRH(DDBL+1,X)
 Q
SDL ;
SDLRH(L,HLS) N I,J,SFR,STO
 S DX=0,SFR=$P(DDBSY,";",2),STO=$P(DDBSY,";",3),J=L
 S DY=SFR X IOXY
 I DDBZN F I=SFR:1:STO D
 .W:I'=SFR !
 .W $P(DDGLCLR,DDGLDEL)
 .I J=L,$D(@DDBSA@(L)) W $$HL($$HTD^DDBR0(@DDBSA@(L,0),L),HLS,$P(DDGLVID,DDGLDEL,6),$P(DDGLVID,DDGLDEL,7)) S DDBL=DDBL+1,L=L+1
 .S J=J+1
 .Q
 I 'DDBZN F I=SFR:1:STO D
 .W:I'=SFR !
 .W $P(DDGLCLR,DDGLDEL)
 .I J=L,$D(@DDBSA@(L)) W $$HL($$HTD^DDBR0(@DDBSA@(L),L),HLS,$P(DDGLVID,DDGLDEL,6),$P(DDGLVID,DDGLDEL,7)) S DDBL=DDBL+1,L=L+1
 .S J=J+1
 .Q
 Q
HL(X,S,ON,RS,F) S X=$G(X),S=$G(S),F=$G(F)=1
 G:F CS
 N C,I,P,T,XU,SU,SL,TL,XL
 S XU=$$U(X),SU=$$U(S),SL=$L(S),C=$L(XU,SU)-1,T="",XL=0
 Q:'C X
 F I=1:1:C S P=$F(XU,SU,XL),T=T_$E(X,XL,P-SL-1)_ON_$E(X,P-SL,P-1)_RS,XL=P
 S T=T_$E(X,XL,255)
 Q T
U(X) Q $$UP^DILIBF(X)  ;**CCO/NI  UPPER-CASE
CS Q:$L(X,S)'>1 X
 N C,I,P,T
 S T="",C=$L(X,S)
 F I=1:1:C S P=$P(X,S,I),T=T_P_$S(I'=C:ON_S_RS,1:"")
 Q T
HELPS N DDBHELPS
 S DDBHELPS=$S(DDBFLG["A":83,1:71)+DDBSRL
HELP I $E(DDBSA,1,11)="^DI(.84,920" S DDBL=0 D SDLR^DDBR0(1),RLPIR^DDBR0 Q
 N DDBHA S DDBHA=$S(DDBFLG["A":9202,1:9201) Q:'$D(^DI(.84,DDBHA,2))  S DDBHA=$NA(^(2)) I $G(DUZ("LANG"))>1,$D(^(4,DUZ("LANG"),1)) S DDBHA=$NA(^(1)) ;**CCO/NI
 I $D(^TMP("DDBLST",$J,"J")) D
 .K ^TMP("DDBLST",$J,"JS")
 .M ^TMP("DDBLST",$J,"JS")=^TMP("DDBLST",$J,"J")
 .K ^TMP("DDBLST",$J,"J")
 .Q
 D BROWSE^DDBR(DDBHA,"PNH"_$S(DDBFLG["A":"A",1:""),"VA FileMan Help Document",$G(DDBHELPS),"",IOTM-1,IOBM+1)
 K ^TMP("DDBLST",$J,"J")
 I $D(^TMP("DDBLST",$J,"JS")) M ^TMP("DDBLST",$J,"J")=^TMP("DDBLST",$J,"JS") K ^TMP("DDBLST",$J,"JS")
 W @IOSTBM
 D PSR^DDBR0(1)
 Q
LC(L,C) Q:$G(L)'>0 ""
 S C=$G(C,"-")
 Q $TR($J("",L)," ",C)
WS(X) S DX=0,DY=$P(DDBSY,";",3)-3 X IOXY
 W $P(DDGLGRA,DDGLDEL)
 W $TR($J("",IOM)," ",$P(DDGLGRA,DDGLDEL,3))
 W $P(DDGLGRA,DDGLDEL,2)
 W !,$P(DDGLCLR,DDGLDEL),$G(X(1))
 W !,$P(DDGLCLR,DDGLDEL),$G(X(2))
 W !,$P(DDGLCLR,DDGLDEL),$G(X(3))
 S DY=$P(DDBSY,";",3),DX=$L($G(X(2)))+2 X IOXY
 Q ""

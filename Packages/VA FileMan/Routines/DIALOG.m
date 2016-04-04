DIALOG ;SFISC/TKW - BUILD FILEMAN DIALOGUE ;2014-12-19  12:39 PM
V ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 G GO
 ;
EN(DIANUM,DIPI) ;
GO N DIERR,DIMSG,DIHELP,DIT Q:'$D(^DI(.84,DIANUM,0))  S DIT=$P(^(0),U,2)
 K ^TMP($S(DIT=1:"DIERR",DIT=2:"DIMSG",1:"DIHELP"),$J)
 S IOM=$G(IOM,80)
 D BLD(DIANUM,.DIPI),MSG("W"_$E("EMH",DIT),,IOM,1)
 Q
 ;
BLD(D0,DIPI,DIPE,DIALOGO,DIFLAG) ;BUILD FILEMAN DIALOG
 ;1)DIALOG file IEN, 2)Internal params, 3)External params, 4)Output array name, 5)S=Suppress blank line between messages, F=Format output like ^TMP
 N DINAKED S DINAKED=$NA(^(0))
 I $G(^DI(.84,+$G(D0),0))="" G Q1
 N E,I,J,K,L,M,N,P,R,S,X,O,DILANG S DILANG=+$G(DUZ("LANG")),DIFLAG=$G(DIFLAG)
 I $G(DIPE)]"",$O(DIPE(""))="" S DIPE(1)=DIPE
 I '$O(^DI(.84,D0,4,DILANG,1,0))!('DILANG) S DILANG=1
 S P=$P(^DI(.84,+D0,0),U,3)["y",R=$P(^(0),U,2) S:'R R=1
 S O=$G(DIALOGO) S:O="" O="^TMP(",DIFLAG=DIFLAG_"F" D  S DIALOGO=O
 . S I=$E(O,$L(O)) I $E(O,1,4)="DIR(" S DIFLAG=$TR(DIFLAG,"F","")
 . I DIFLAG'["F" S O=$E(O,1,($L(O)-1))_$S(I="(":"",I=",":")",1:I) Q
 . S O=$P(O,")",1)_$S("(,"[I:"",O'["(":"(",1:",")_""""_$P("DIERR^DIMSG^DIHELP",U,R)_""""_$P(","""_$J_"""",U,O["^TMP(")_")" ;WORRIED THAT $J WOULD NOT BE NUMERIC
 . Q
 S N=$O(@DIALOGO@(":"),-1)
 S N=N+1,(I,J,M)=0 S:R>1!(DIFLAG'["F") J=N-1
 I R=1,DIFLAG["F" S O=$P(O,")",1)_","_N_",""TEXT"")"
 I DILANG>1 F  S I=$O(^DI(.84,D0,4,DILANG,1,I)) Q:'I  S M=M+1,K(M)=$G(^(I,0)) I P S L=0 D PARAM
 I DILANG'>1 F  S I=$O(^DI(.84,D0,2,I)) Q:'I  S M=M+1,K(M)=$G(^(I,0)) I P S L=0 D PARAM
 G:'M Q2 D
 . N X S X=M
 . I N>1,DIFLAG'["S" I DIFLAG'["F"!(R>1) S J=J+1,@O@(J)=" ",X=X+1
 . I DIALOGO'["DIR" S:R=1 DIERR=($P($G(DIERR),U)+1)_U_($P($G(DIERR),U,2)+X) S:R=2 DIMSG=$G(DIMSG)+X S:R=3 DIHELP=$G(DIHELP)+X
 . D BTXT Q
 I (DIALOGO["DIR")!(R'=1)!(DIFLAG'["F") G Q2
 S @DIALOGO@(N)=D0
 S I="",J=0 F  S I=$O(DIPE(I)) Q:I=""  I $G(DIPE(I))]"" S @DIALOGO@(N,"PARAM",I)=DIPE(I),J=J+1
 I J S @DIALOGO@(N,"PARAM",0)=J
 S @DIALOGO@("E",D0,N)=""
 ;
Q2 I $G(^DI(.84,D0,6))]"" X ^(6)
Q1 Q:DINAKED=""  I DINAKED["(" Q:$O(@(DINAKED))]""  Q
 I $D(@(DINAKED))
 Q
 ;
PARAM S S=$F(K(M),"|",L) G:'S QP S E=$F(K(M),"|",S) G:'E QP
 S X=$E(K(M),S,E-2) G:X="" PARAM
 S DIPI(X)=$S($G(DIPI(X))]"":DIPI(X),1:$G(DIPI)),L=S+$L(DIPI(X))-$L(X)
 I ($L(K(M))+$L(DIPI(X)))<245 S K(M)=$E(K(M),1,S-2)_DIPI(X)_$E(K(M),E,9999) G:K(M)]"" PARAM K K(M) S M=M-1 G QP
 I $L($E(K(M),1,S-2))+$L(DIPI(X))<245 S K(M+1)=$E(K(M),E,9999),K(M)=$E(K(M),1,S-2)_DIPI(X),M=M+1,L=0 G PARAM
 I $L(DIPI(X))+$L($E(K(M),E,9999))<245 S K(M+1)=DIPI(X)_$E(K(M),E,9999),K(M)=$E(K(M),1,S-2),M=M+1,L=0 G PARAM
 S K(M+1)=DIPI(X),K(M+2)=$E(K(M),E,9999),K(M)=$E(K(M),1,S-2),M=M+2,L=0
 G PARAM
QP Q
 ;
BTXT N M
 F M=0:0 S M=$O(K(M)) Q:'M  S J=J+1 D
 .I DIALOGO'["DIR" S @O@(J)=K(M) Q
 .I '$O(K(M)),'$O(^DI(.84,D0,2,I)) S @DIALOGO=K(M) Q
 .S @DIALOGO@(J)=K(M) Q
 Q
 ;
EZBLD(D0,DIPI) ;RETURN SINGLE LINE OF TEXT FROM DIALOG FILE.
 ;D0 = DIALOG file IEN, DIPI = Input Params
 N DINAKED S DINAKED=$NA(^(0)) I $G(^DI(.84,+$G(D0),0))="" D Q1 Q ""
 N DILANG S DILANG=+$G(DUZ("LANG"))
 N X I DILANG>1 S X=$O(^DI(.84,+D0,4,DILANG,1,0)) S:X X=$G(^(X,0))
 I $G(X)']"" S X=$O(^DI(.84,+D0,2,0)) S:X X=$G(^(X,0))
 I ($P(^DI(.84,+D0,0),"^",3)'["y"!($G(X)="")) S X=$G(X) G QEZ
 N K,S,L,M,I,E S M=1,L=0,K(M)=X
 I $G(DIPI)]"",$O(DIPI(""))="" S DIPI(1)=DIPI
 D PARAM S X=$G(K(1))
QEZ D  Q X
 . N X D Q2 Q
 ;
 ;
MSG(DIFLGS,DIOUT,DIMARGIN,DICOLUMN,DIINNAME) ;WRITE MESSAGES OR MOVE THEM TO SIMPLE ARRAY.
 ;1)Flags, 2)Output array name, 3)Margin width of text, 4)Starting column no., 5)Input array name.
 N Z,%,X,Y,I,J,K,N,DITYP,DIWIDTH,DITMP,DIIN,DINAKED S DINAKED=$NA(^(0))
 S:$G(DIFLGS)="" DIFLGS="W" D
 . S DITMP=0 I $G(DIINNAME)="" S DIINNAME="^TMP(",DITMP=1 Q
 . N % S %=DIINNAME I %'["(" S DIINNAME=DIINNAME_"(" Q
 . Q:$E(%,$L(%))=","
 . I $E(%,$L(%))=")" S DIINNAME=$P(%,")",1)_"," Q
 . S DIINNAME=%_"," Q
 S DITYP="",%=0 D
 . F Z="E","H","M" S %=%+1 I DIFLGS[Z,$D(@(DIINNAME_""""_$P("DIERR^DIHELP^DIMSG",U,%)_""""_$P(","""_$J_"""",U,(DITMP>0))_")")) S $P(DITYP,U,%)=$P("DIERR^DIHELP^DIMSG",U,%)
 . I DITYP="",$D(@(DIINNAME_"""DIERR"""_$P(","""_$J_"""",U,(DITMP>0))_")")) S DITYP="DIERR"
 . Q
 S DIWIDTH=$S($G(DIMARGIN):DIMARGIN,$G(IOM):(IOM-5),1:75),DICOLUMN=+$G(DICOLUMN)
 K:DIFLGS["A" DIOUT S (K,Z)=0
AWS S K=K+1 I K>3 G Q1
 G:$P(DITYP,U,K)="" AWS
 S DIIN=DIINNAME_""""_$P(DITYP,U,K)_"""" S:DITMP DIIN=DIIN_","""_$J_""""
 S (I,N)=0
 F  S N=$O(@(DIIN_")")@(N)) Q:'N  S:K>1 X=$G(@(DIIN_","_N_")")) D:K>1  I K=1 D:I&(DIFLGS'["B") LN S I=1,J=0 F  S J=$O(@(DIIN_")")@(N,"TEXT",J)) Q:'J  S X=$G(@(DIIN_","_N_",""TEXT"","_J_")")) D
 . I DIFLGS["A",'$G(DIMARGIN) S Z=Z+1,DIOUT(Z)=X
 . I DIFLGS'["W",'$G(DIMARGIN) Q
 . S Y=X D:X=""  F  Q:X=""  F %=$L(X," "):-1:1 S:%=1&($L($P(X," ",1,%))>DIWIDTH) X=$E(X,1,(DIWIDTH-1))_" "_$E(X,DIWIDTH,$L(X)),%=%+1 I $L($P(X," ",1,%))'>DIWIDTH S Y=$P(X," ",1,%) D  S X=$P(X," ",%+1,$L(X," ")) Q
 .. W:DIFLGS["W" !?DICOLUMN,Y S:DIFLGS["A"&$G(DIMARGIN) Z=Z+1,DIOUT(Z)=Y
 .. Q
 . Q
 F I=K:1:2 I $P(DITYP,U,I+1)]"" D LN Q
 I DIFLGS["A",DIFLGS["T" S DIOUT=Z
 I DIFLGS'["S" K @(DIIN_")"),@($P(DITYP,U,K))
 G AWS
 ;
LN W:DIFLGS["W" ! S:(DIFLGS["A")&Z Z=Z+1,DIOUT(Z)="" Q

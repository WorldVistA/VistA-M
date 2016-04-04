DDBRAHTE ;SFISC/DCL-BROWSER ANCHOR & HYPERTEXT JUMP EDIT ;NOV 04, 1996@13:51
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**145**
 ;
 Q
REDIT ; root edit for hypertext jump - CLOSED_ROOT
 Q
 ;prototype - phasing out
 Q:'$$CHKI
 N DDBSAN,DDBSANS,DDBSANX,DDBSANR,X
 S DDBSAN=$$NROOT^DDBRAP(DDBSA),DDBSANX=$P(DDBRHT,DDGLDEL,2)
 S X(1)="                       < Edit Hypertext Jump Closed_Root >"
 S DDBSANS=$G(@DDBSAN@("H",DDBSANX)),DDBSANR=$G(@DDBSAN@("H",DDBSANX,0))
 Q:DDBSAN=""!(DDBSANS="")
GTR S X(1)=$G(X(1)),X(2)=" "_$E(DDBSANX,1,30)_" >"
 W $$WS^DDBR1(.X)
 D EN^DIR0($P(DDBSY,";",3)-1,$L($G(X(2)))+2,44,1,DDBSANR,100,1,"","KPW",.X)
 K DIR0
 I $E(X)="?" S X(1)="* Enter closed_root jump for hypertext: "_$E(DDBSANX,1,35)_$S($L(DDBSANX)>35:"...",1:"")_" *" G GTR
 I DDBSANR'=X S @DDBSAN@("H",DDBSANX,0)=X
 G OUT
 ;
IEDIT ; interactive edit/switch
 Q:'$$CHKI
 Q
ANCH ; enter Anchor for jump
 Q
 ;prototype - phasing out
 Q:'$$CHKI
 N DDBSAN,DDBSANS,DDBSANX,DDBSANR,DDBSANCH,X
 S DDBSAN=$$NROOT^DDBRAP(DDBSA),DDBSANX=$P(DDBRHT,DDGLDEL,2)
 S X(1)="                       < Edit Anchor Jump >"
 S DDBSANS=$G(@DDBSAN@("H",DDBSANX)),DDBSANR=$G(@DDBSAN@("H",DDBSANX,0))
 S DDBSANCH=$P(DDBSANS,"^",4)
 Q:DDBSAN=""!(DDBSANS="")
AGTR S X(1)=$G(X(1)),X(2)=" "_$E(DDBSANX,1,30)_" >"
 W $$WS^DDBR1(.X)
 D EN^DIR0($P(DDBSY,";",3)-1,$L($G(X(2)))+2,44,1,DDBSANCH,100,1,"","KPW",.X)
 K DIR0
 I $E(X)="?" S X(1)="* Enter FILE#;IEN;FIELD;ANCHOR for: "_$E(DDBSANX,1,35)_$S($L(DDBSANX)>35:"...",1:"")_" *" G AGTR
 I DDBSANCH'=X S $P(@DDBSAN@("H",DDBSANX),"^",4)=X
 G OUT
 Q
 ;
TEDIT ; edit hypertext document title
 I 'DDBRHTF!($G(DUZ(0))'["@") Q
 N DDBSAN,DDBSANX,X
 S DDBSAN=$$NROOT^DDBRAP(DDBSA),DDBSANX=$G(@DDBSAN@("TITLE"))
 S X(1)="                       < Edit Hypertext Document Title >"
TGTR S X(1)=$G(X(1)),X(2)=" Title >"
 W $$WS^DDBR1(.X)
 D EN^DIR0($P(DDBSY,";",3)-1,$L($G(X(2)))+2,44,1,DDBSANX,100,1,"","KPW",.X)
 K DIR0
 I $E(X)="?" S X(1)="* Enter Document Name for Title *" G TGTR
 I X'="^" D  D RPS^DDBRGE Q
 .S @DDBSAN@("TITLE")=X
 .S DDBPMSG=X,DDBHDR=$$CTXT^DDBR(X,$J("",IOM+1),IOM)
 .Q
 G OUT
 ;
CHKI() ;return 1 if ok 0 not ok to continue also init DDBRHT if undefined
 S DDBRHT=$G(DDBRHT)
 Q:DDBRHT="" 0
 I 'DDBRHTF!($G(DUZ(0))'["@") Q 0
 I $P(DDBRHT,DDGLDEL,4)'=DDBSA Q 0
 I +DDBRHT>DDBL Q 0
 I +DDBRHT<($S(DDBL'>DDBSRL:0,1:DDBL-DDBSRL)+1) Q 0
 Q 1
 ;
OUT D PSR^DDBR0() Q
 ;
RA ;Rebuild Anchors
 I 'DDBRHTF!($G(DUZ(0))'["@") Q
 N X,DDBSAN
 S DDBSAN=$$NROOT^DDBRAP(DDBSA)
 S X(1)="",X(2)="                 < Rebuilding Anchor Index for HyperText Jumps >"
 W $$WS^DDBR1(.X)
 D WP^DDBRAP(DDBSA,"",$G(@DDBSAN@("TITLE"),DDBPMSG))
 R X:2
 G OUT

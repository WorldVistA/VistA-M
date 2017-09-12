LEX2011 ; ISL LEX*2.0*11 Env chk/Post Install         ; 05/25/1998
 ;;2.0;Lexicon Utility;**11**;Sep 23, 1996
 ;
ENV ; LEX*2.0*11 Environment Check
 S U="^" D:'$$UR ET("User not defined (DUZ)") D:'$$SY ET("Undefined IO variable(s)") G:$D(LEXE) EXIT D:$$VERSION^XPDUTL("LEX")'="2.0" ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0") G:$D(LEXE) ABRT
QUIT W !!,"  Environment is ok",! Q
EXIT D:$D(LEXE) ED S XPDQUIT=2 K LEXE Q
ABRT D:$D(LEXE) ED S XPDQUIT=1 K LEXE Q
 ;
POST ; LEX*2.0*11 Post-Install (send install message only)
 Q:+($G(DUZ))=0!('$D(^VA(200,+($G(DUZ)),0)))  D HOME^%ZIS N DIFROM,LEXBUILD S LEXBUILD="LEX*2.0*11" D SEND^LEXXST Q
 ;                       
UR(X) Q:'$L($G(DUZ(0))) 0 Q:+($G(DUZ))=0!('$D(^VA(200,+($G(DUZ)),0))) 0 Q 1
SY(X) Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0 Q 1
ET(X) N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI Q
ED N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  W !,LEXE(LEXI)
 W ! K LEXE Q

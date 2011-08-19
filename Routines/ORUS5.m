ORUS5 ; slc/KCM - Display List of Items ;1/3/91  10:01 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
MOVE K OR9 I $D(^XUTL("OR",$J,"ORV",P,0)),$D(^(0)) S X=^(0),ORCO=$S($P(X,"^"):$P(X,"^"),1:+$G(ORCO)),ORSEQL=$S($P(X,"^",4):$P(X,"^",4),1:""),ORENL=$P(X,"^",2),ORENLA=$P(X,"^",3) Q
 ;I ORMOR,$D(^XUTL("OR",$J,"ORV",P,0)),$D(^(0)) S ORCO=$S(^(0):^(0),1:ORCO) Q
 S OR9=0 I $D(ORUS("900")) F I=0:0 S I=$O(ORUS("900",I)) Q:I=""  S OR9=OR9+1
 S ORCO=IOSL-ORHL-3,ORNE=(ORCO*ORNC)-OR9-2
 S A="",(B,L,S)=0,O=$S(OREN:ORUS,1:OROD),C=ORUS,N=(ORUS(0)["N"),M=$D(ORUS("M")) S:ORMOR S=$S($D(ORSEQL):ORSEQL,1:ORCO),B=ORENL,A=$S($D(ORENLA):$S($L(ORENLA):$E(ORENLA,1,($L(ORENLA)-1))_$C($A($E(ORENLA,$L(ORENLA)))-1),1:""),1:"")
 I 'OREN F  Q:L'<ORNE  S A=$O(@(O_"A)")) Q:A=""  F  Q:L'<ORNE  S B=$O(@(O_"A,B)")) Q:B=""  I ^(B)'=1,$D(@(C_"B,0)")) D M1
 I OREN F  Q:L'<ORNE  S B=$O(@(O_"B)")) Q:B=""  I $D(@(O_"B,0)")) S ORDA=B X ORSC I $T,$D(@(O_"B,0)")) S L=L+1 X ORWR I $L(X) S ^XUTL("OR",$J,"ORV",P,L)=X S:N S=S+1,$P(^(L),"^",2)=S,^XUTL("OR",$J,"ORW",S)=B D:M MNE
 S ORMOR=0 S:($L(A)&('OREN))!($L(B)&OREN) ORMOR=1,ORENL=B,ORENLA=$S(OREN:"",1:A),ORSEQL=S
 F I=0:0 S I=$O(ORUS(900,I)) Q:I'>0  S L=L+1,^XUTL("OR",$J,"ORV",P,L)=ORUS(900,I) S:'$L($P(ORUS(900,I),"^",2)) $P(^(L),"^",2)=900+I I '$D(OR9(I)) S OR9(I)=^(L) D S91
 I ORUS(0)["Q" S L=L+1,^XUTL("OR",$J,"ORV",P,L)=$S($D(ORUS("O")):ORUS("O"),1:"OTHER "_ORFNM)_"^998",I=998,OR9(I)=^(L) D S91
 I ORMOR S L=L+1,^XUTL("OR",$J,"ORV",P,L)="MORE...^999",I=999,OR9(I)=^(L) D S91
 I L'>ORNE S ORCO=L\ORNC S:L#ORNC ORCO=ORCO+1
 S ^XUTL("OR",$J,"ORV",P,0)=ORCO_"^"_$S($D(ORENL):ORENL,1:"")_"^"_$S($D(ORENLA):ORENLA,1:"")_"^"_$S($D(ORSEQL):ORSEQL,1:"")
 Q
INIT K OROTHER ;^XUTL("OR",$J,"ORV"),^("ORW")
 S (ORBACK,ORFN,ORMOR,ORQUIT,P)=0,ORFNM="" I +ORUS S:$D(^DIC(+ORUS,0,"GL")) ORUS=^("GL")
 I $D(@(ORUS_"0)")) S ORFNM=$P(^(0),"^"),ORFN=+$P(^(0),"^",2)
 S ORPTR=0 I ORFN S X=$P(^DD(+ORFN,.01,0),"^",2) S:'$L(ORFNM) ORFNM=$P(^(0),"^") I X["V"!(X["P"),'$D(ORUS("W")) S ORPTR=1
 S:'$L(ORFNM) ORFNM="ITEM(s)"
 S ORCW=80 S:ORUS(0) ORCW=+ORUS(0) S ORNC=IOM\$S(IOM>79:ORCW,1:IOM),ORTB=IOM\ORNC
 S ORSC="I 1" S:$D(ORUS("S")) ORSC=ORUS("S")
 S ORWR="S X=$P(^(0),""^"")" S:$D(ORUS("W")) ORWR=ORUS("W")
 I ORPTR S ORWR="N Y S Y=$P(^(0),""^""),C=$P(^DD(ORFN,.01,0),""^"",2) D Y^DIQ S X=Y Q"
 I '$D(ORUS("L"))!('$D(ORUS("F"))&(ORUS(0)["A")) D EN^ORUS2
 S (OROD,ORLK)="^XUTL(""OR"",$J,""ORU""," S:ORUS(0)'["A" OROD=ORUS
 S OREN=0 I '$D(ORUS("F")),ORUS(0)'["A" S OREN=1
 S:$D(ORUS("F")) OROD=ORUS("F") S:$D(ORUS("L")) ORLK=ORUS("L")
 Q
M1 S ORDA=B X ORSC
 I $T,$D(@(C_"B,0)")) S L=L+1 X ORWR I $L(X) S ^XUTL("OR",$J,"ORV",P,L)=X S:N S=S+1,$P(^(L),"^",2)=S,^XUTL("OR",$J,"ORW",S)=B D:M MNE
 Q
MNE S X=ORUS("M") I X?.AN1";".N S Y=$P(X,";",2),X=$P(X,";") Q:'$D(@(ORUS_"B,X)"))  S X=$P(^(X),"^",Y) S:$L(X) $P(^XUTL("OR",$J,"ORV",P,L),"^",2)=X Q
 ;I X'?.AN1";".N,$L(ORUS("M")) X ORUS("M") S:$L(X) $P(^XUTL("OR",$J,"ORV",P,L),"^",2)=X Q
 Q
S91 S:$L($P(OR9(I),"^",1)) OR9("B",$P(OR9(I),"^",1),I)="" S:$L($P(OR9(I),"^",2)) OR9("B",$P(OR9(I),"^",2),I)=""
 Q

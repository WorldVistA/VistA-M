SDECFUNC ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
FNDPATRN(STR,PAT) ;PEP - Find pattern in string.  Return beginning position.
 ;
 ; E.g.: $$FNDPATRN^SDECFUNC("ABC8RX","1A1N") will return 3.
 ;
 I '$L($G(STR))!('$L($G(PAT))) Q 0
 I STR'?@(".E"_PAT_".E") Q 0
 NEW I,J
 S J=0
 F I=1:1:$L(STR) I $E(STR,I,$L(STR))?@(PAT_".E") S J=I Q
 Q J
 ;
GETPATRN(STR,PAT) ;PEP - Retrieve pattern from string.
 ;
 ; E.g.: $$GETPATRN^SDECFUNC("ABC8RX","1A1N") will return "C8".
 ;
 I '$L($G(STR))!('$L($G(PAT))) Q ""
 NEW I,S
 S I=$$FNDPATRN^SDECFUNC(STR,PAT)
 I 'I Q ""
 S S=$E(STR,I,$L(STR))
 F I=1:1 Q:(S="")!(S?@PAT)  S S=$E(S,1,$L(S)-1)
 Q S
 ;
INTSET(FILE,FIELD,EXTVAL) ;PEP - Get Intnl Field Value Given Extnl Field Value
 ; For a set of codes type field
 ;
 ; E.g.: $$INTSET^SDECFUNC(9000001,.21,"RETIRED") returns 5.
 ;
 I '$G(FILE)!('$G(FIELD)) Q ""
 I $G(EXTVAL)="" Q ""
 I '$D(^DD(FILE,FIELD)) Q ""
 S EXTVAL=":"_EXTVAL_";"
 I $P(^DD(FILE,FIELD,0),"^",3)'[EXTVAL Q ""
 NEW %,%A,%B
 S %=$P(^DD(FILE,FIELD,0),"^",3),%A=$P(%,EXTVAL),%B=$L(%A,";")
 Q $P(%A,";",%B)
 ;
EXTSET(FILE,FIELD,INTVAL) ;PEP - Get Extnl Field Value Given Intnl Field Value
 ; For a set of codes type field
 ;
 ; E.g.: $$EXTSET^SDECFUNC(9000001,.21,5) returns "RETIRED".
 ;
 I '$G(FILE)!('$G(FIELD)) Q ""
 I $G(INTVAL)="" Q ""
 I '$D(^DD(FILE,FIELD)) Q ""
 I $P(^DD(FILE,FIELD,0),"^",3)'[INTVAL Q ""
 NEW %,%A
 S %=$P(^DD(FILE,FIELD,0),"^",3),%A=$P(%,(INTVAL_":"),2)
 Q $P(%A,";")
 ;
DECFRAC(X) ;PEP - Convert Decimal to Fraction (X contains Decimal number).
 ;
 ; E.g.: $$DECFRAC^SDECFUNC(.25) returns "1/4".
 ;
 Q:'$D(X) ""
 Q:$E(X)'="." ""
 NEW D,N
 S N=+$P(X,".",2)
 Q:'N ""
 S $P(D,"0",$L(+X))="" S D="1"_D
 F  Q:(N#2)  S N=N/2,D=D/2
 F  Q:(N#5)  S N=N/5,D=D/5
 Q N_"/"_D
 ;
C(X,Y) ;PEP - Center X in field length Y/IOM/80.
 Q $J("",$S($D(Y):Y,$G(IOM):IOM,1:80)-$L(X)\2)_X
 ;
GDT(JDT) ;PEP - Return Gregorian Date, given Julian Date.
 Q:'$G(JDT) -1
 S:'$D(DT) DT=$$DT^XLFDT
 Q $$HTE^XLFDT($P($$FMTH^XLFDT($E(DT,1,3)_"0101"),",")+JDT-1)
 ;
JDT(XBDT) ;PEP - Return Julian Date, given FM date.
 Q:'$D(XBDT) -1
 Q:'(XBDT?7N) -1
 S:'$D(DT) DT=$$DT^XLFDT
 Q $$FMDIFF^XLFDT(XBDT,$E(DT,1,3)_"0101")+1
 ;
USR() ;PEP - Return name of current user for ^VA(200.
 Q $S($G(DUZ):$S($D(^VA(200,DUZ,0)):$P(^(0),U),1:"UNKNOWN"),1:"DUZ UNDEFINED OR 0")
 ;
LOC() ;PEP - Return location name from file 4 based on DUZ(2).
 Q $S($G(DUZ(2)):$S($D(^DIC(4,DUZ(2),0)):$P(^(0),U),1:"UNKNOWN"),1:"DUZ(2) UNDEFINED OR 0")
 ;
CV(X) ;PEP - Given a Namespace, return current version.
 Q $$VERSION^XPDUTL(X)  ;IHS/SET/GTH XB*3*9 10/29/2002
 Q:'$L($G(X)) -1
 S X=$O(^DIC(9.4,"C",X,0))
 Q:'X -1
 Q $G(^DIC(9.4,X,"VERSION"),-1)
 ;
 ;Begin New Code;IHS/SET/GTH XB*3*9 10/29/2002
FNAME(N) ;PEP - Given File number, return File Name.
 Q:'$L($G(N)) -1
 S N=$O(^DD(N,0,"NM",""))
 Q:'$L(N) -1
 Q N
 ;
FGLOB(N) ;PEP - Given File number, return File Global.
 Q:'$L($G(N)) -1
 Q $G(^DIC(N,0,"GL"),-1)
 ;
ZEROTH(A,B,C,D,E,F,G,H,I,J,K) ;PEP - Return dd 0th node.  A is file #, rest fields.
 I '$G(A) Q -1
 I '$G(B) Q -1
 F %=67:1:75 Q:'$G(@($C(%)))  S A=+$P(^DD(A,B,0),U,2),B=@($C(%))
 I 'A!('B) Q -1
 I '$D(^DD(A,B,0)) Q -1
 Q U_$P(^DD(A,B,0),U,2)
 ;End New Code;IHS/SET/GTH XB*3*9 10/29/2002
 ;

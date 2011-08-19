PRC0A ;WISC/PLT-General Questions Utility ; 24-Aug-1994 10:34 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;the following are for DIR call for data type D,E,F,L,N,P,S,Y,#
 ;A for DIR("A") - prompt text.
 ;B for DIR(0) without 1st characters - input modifiers^parameters^transform.
 ;  modifiers A: prompt not append, O:response optional
 ; set of codes    X: exact match, B: code listed horizontally
 ;                 M: mix case match without X
 ; free text    U: if '^' allowed in free text
 ;C for DIR("B") - default response
 ;.x(1...) for DIR("A") propmt array or value returned
 ;.y(1...) for DIR("?") array or value returned 
 ;
 ;date
 ;B is ^1=A, O or "", ^2=mini date:maximum date, ^3=mumps code
DT(X,Y,A,B,C) N DIR,D S DIR(0)="D"_B,DIR("A")=A S:$G(C)]"" DIR("B")=C
 S DIR("?")="Enter a date",D=$P(B,U,2,3)
 I $P(D,":")]"" S Y=$P(D,":") D DD^%DT S Y=$S($P(D,":",2)]"":" between ",1:" after ")_Y,DIR("?")=DIR("?")_Y
 I $P(D,":",2)]"" S Y=$P(B,":",2) D DD^%DT S Y=$S($P(D,":",1)="":" before ",1:" and ")_Y,DIR("?")=DIR("?")_Y
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;end of page
 ;B is ^1= A OR "", ^2="", ^3=""
EOP(X,Y,A,B,C) N DIR S DIR(0)="E"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 S DIR("?")="Enter 'return' to continue or '^' to exit."
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;free text
 ;B is ^1=A, O or U, ^2=minimum legth:maximum length, ^3=mumps code
FT(X,Y,A,B,C) N DIR S DIR(0)="F"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;list of range
 ;B is ^1=A, O or "", ^2=mini value:maxi value, ^3=mumps code
LR(X,Y,A,B,C) N DIR S DIR(0)="L"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;numeric
 ;B is ^1=A, O or "", ^2=mini value:maxi value:maxi decimals, ^3=mumps code
NUM(X,Y,A,B,C) N DIR S DIR(0)="N"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;pointer
 ;B is ^1=A, O or "", ^2=file #/subfile root:dic(0) data, ^3=mumps code
PTR(X,Y,A,B,C) N DIR S DIR(0)="P"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;set of codes
 ;B is ^1=A,O,X,B, or M, ^2=code:description;code:description;..., ^3=mumps code
SC(X,Y,A,B,C) N DIR S DIR(0)="S"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;yes/no
 ;B is ^1=A, O or "", ^2"", ^3=""
YN(X,Y,A,B,C) N DIR S DIR(0)="Y"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 S DIR("?")="Enter 'Y' for yes, 'N' for no."
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
 ;data field definition
 ;B is ^1=(sub)file number,field numberAO, ^2="", ^3=""
DD(X,Y,A,B,C) N DIR S DIR(0)=B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR
 QUIT
 ;
DIRA N A S A=0 F  S A=$O(X(A)) Q:A=""  S DIR("A",A)=X(A)
 K X
 QUIT
DIRQ N A F A=1:1 Q:'$D(Y(A))  S DIR("?",A)=Y(A)
 S DIR("?")=Y(A-1) K DIR("?",A-1)
 K Y
 QUIT
 ;
 ;.x user typed value, .y=-1 if invalid, yymmdd.hhmmss
 ;A=prompt text, B=^1:fault value (external form), ^2=[-]fm date
 ;C=string of AEFNPRST, any combination
 ;  A for ask, E for echo, F for future assum, N for pure num not allowed
 ;  P for past assum, R time required, S seconds required
 ;  T time is optional
 ;D= Y if year only, YM if year and month only, YMD if date[@time] only
YMDT(X,Y,A,B,C,D) ;reader for year/month/date/time
 N %DT,DTOUT
YMDT1 S %DT("A")=A,%DT("B")=$P(B,"^") S:$P(B,"^",2)]"" %DT(0)=$P(B,"^",2)
 S %DT=C S:$G(D)="YMD" %DT=%DT_"X"
 D ^%DT
 I Y'=-1,$G(D)="Y",Y#10000'=0 W "   Enter year only!" G YMDT1
 I Y'=-1,$G(D)="YM",Y#100'=0 W "   Enter month and year only!" G YMDT1
 QUIT

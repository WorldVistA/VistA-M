PRSU1A ;WOIFO/PLT-General Questions Utility ; 24-Aug-2005 10:34 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;the followoings are DIR calls for data type D,E,F,L,N,P,S,Y,#,#
 ; D-date, E-end of page, F-free-text, L-list or range, N-numeric
 ; P- pointer, S-set of codes, Y-yes/no, #,#- dd data dictionary
 ;A for DIR("A") - prompt text.
 ;B for DIR(0) 2nd character to end - input modifiers^[parameters]^[transform.]
 ; modifiers     A: prompt not appended, O: response optional
 ;               r: no replace-with for the defalut response
 ; set of codes  B: code listed horizontally, X: exact match
 ; free text     U: if '^' allowed in free text
 ; list or range C: compress y array, not y-array returned
 ;C for DIR("B") - default response
 ;.x(1...) for DIR("A") prompt array or value returned
 ;.y(1...) for DIR("?") array or value returned 
 ;
 ;date
 ;B is ^1=A,O or "", ^2=mini date:maximum date, ^3=mumps code
DT(X,Y,A,B,C) N DIR,D S DIR(0)="D"_B,DIR("A")=A S:$G(C)]"" DIR("B")=C
 S DIR("?")="Enter a date",D=$P(B,U,2,3)
 I $P(D,":")]"" S Y=$P(D,":") D DD^%DT S Y=$S($P(D,":",2)]"":" between ",1:" after ")_Y,DIR("?")=DIR("?")_Y
 I $P(D,":",2)]"" S Y=$P(B,":",2) D DD^%DT S Y=$S($P(D,":",1)="":" before ",1:" and ")_Y,DIR("?")=DIR("?")_Y
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;end of page
 ;B is ^1= A or "", ^2="", ^3=""
EOP(X,Y,A,B,C) N DIR S DIR(0)="E"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 S DIR("?")="Enter 'return' to continue or '^' to exit."
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;free text
 ;B is ^1=A,O,U, ^2=minimum legth:maximum length, ^3=mumps code
FT(X,Y,A,B,C) N DIR S DIR(0)="F"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;list of range
 ;B is ^1=A,O or "", ^2=mini value:maxi value, ^3=mumps code
LR(X,Y,A,B,C) N DIR S DIR(0)="L"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;numeric
 ;B is ^1=A,O or "", ^2=mini value:maxi value:maxi decimals, ^3=mumps code
NUM(X,Y,A,B,C) N DIR S DIR(0)="N"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;pointer
 ;B is ^1=A,O or "", ^2=file #/subfile root:dic(0) data, ^3=mumps code
PTR(X,Y,A,B,C) N DIR S DIR(0)="P"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;set of codes
 ;B is ^1=A,O,X,B, or M, ^2=code:description;code:description;..., ^3=mumps code
SC(X,Y,A,B,C) N DIR S DIR(0)="S"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;yes/no
 ;B is ^1=A,O or "", ^2="", ^3=""
YN(X,Y,A,B,C) N DIR S DIR(0)="Y"_B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 S DIR("?")="Enter 'Y' for yes, 'N' for no."
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
 QUIT
 ;
 ;data field definition
 ;B is ^1=(sub)file number,field numberAO, ^2="", ^3=""
DD(X,Y,A,B,C) N DIR S DIR(0)=B S:A]"" DIR("A")=A S:$G(C)]"" DIR("B")=C
 D DIRA:$D(X(1)),DIRQ:$D(Y(1)),^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S Y="^" K DTOUT,DUOUT,DIROUT
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
 ;.x user typed value
 ;.y=-1 if invalid, cyymmdd.hhmmss
 ;A=prompt text
 ;B=^1:default value (external form), ^2=[-]fm date, [before]after date
 ;C=string of AEFNPRST, any combination
 ;  A for ask, E for echo
 ;  F for future assumed, N for pure num not allowed
 ;  P for past assumed, R time required
 ;  S seconds required, T time is optional
 ;D= Y if year only, YM if year and month only, YMD if date[@time] only
YMDT(X,Y,A,B,C,D) ;reader for year/month/date/time
 N %DT,DTOUT
YMDT1 S %DT("A")=A,%DT("B")=$P(B,"^") S:$P(B,"^",2)]"" %DT(0)=$P(B,"^",2)
 S %DT=C S:$G(D)="YMD" %DT=%DT_"X"
 D ^%DT
 I Y'=-1,$G(D)="Y",Y#10000'=0 W "   Enter year only!" G YMDT1
 I Y'=-1,$G(D)="YM",Y#100'=0 W "   Enter month and year only!" G YMDT1
 QUIT

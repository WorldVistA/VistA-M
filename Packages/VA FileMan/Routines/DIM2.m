DIM2 ;SFISC/XAK,GFT,TOAD-FileMan: M Syntax Checker, Exprs ;20NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**169**
 ;
 ;12277;4186487;4104;
 ;
SUB ; "(": open paren situations (GG^DIM1)
 F %J=%I-1:-1 S %C1=$E(%,%J) Q:%C1'?1(1UN,1"%")
 S %C1=$E(%,%J+1,%I-1)
 I %C1]"",%C1'?1(1U,1"%").UN G ERR
 ;I %C1]"",%[("."_%C1) G ERR ;DID NOT ALLOW "W A(6)-$$X(.A)"
 S %(%N,0)=$S(%C1]""!($E(%,%J)="^"):"V^",$E(%,%J)="@":"@^",1:"0^")
 S %(%N,1)=0,%(%N,2)=0,%(%N,3)=0,%N=%N+1 G 1
 ;
UP ; ")": close paren situations (GG^DIM1)
 I %N=0 G ERR
 I "(,"[$E(%,%I-1),$P($G(%(%N-1,0)),"^")'["P" G ERR
 I $E(%,%I+1)]"","<>_[]:/\?'+-=!&#*),"""'[$E(%,%I+1) G ERR
 S %N=%N-1,%(%N,1)=%(%N,1)+1,%F=$P(%(%N,0),"^") I %F D  G ERR:%ERR
 . S %F=$P(%(%N,0),"^",2),%F1=%(%N,1)
 . I %F1<+%F S %ERR=1 Q  ; not enough commas for this function
 . I %F1>$P(%F,";",2) S %ERR=1 Q  ; too many commas for this function
 . I %(%N,2),'%(%N,3) S %ERR=1 ; we're in $S and haven't yet hit a :
 K %(%N+1)
 I '%F,%F'["V",%F'["@",%F'["P",%(%N,1)>1 G ERR
 G 1
 ;
AR ; ",": comma situations -- "P" below means "parameters" (GG^DIM1)
 I %N<1 G ERR
 I "(,"[$E(%,%I-1),$P($G(%(%N-1,0)),"^")'["P" G ERR
 I '%(%N-1,3),%(%N-1,2) G ERR
 I "@("[$E(%,1,2) G ERR
 S %(%N-1,1)=%(%N-1,1)+1,%(%N-1,3)=0 G 1
 ;
SEL ; ":": $SELECT delimiter (GG^DIM1)
 S %(%N-1,3)=%(%N-1,3)+1 G ERR:'%(%N-1,2)!(%(%N-1,3)>1),1
 ;
GLO ; "^": global reference (GG^DIM1)
 D %INC G ERR:$E(%,%I,999)'?1U.UN.P.E&("%("'[%C)
 G ERR:"=+-\/<>(,#!&*':@[]_"'[$E(%,%I-2)
 S %I=%I-1 G 1
 ;
PAT ; "?": pattern match (GG^DIM1)
 G ERR:%I=1,1:$E(%,%I+1)="@" D %INC,PATTERN G ERR:%ERR S %I=%I-1 G 1
 ;
PATTERN F  D PATATOM Q:%C'?1N&(%C'=".")!%ERR
 Q
PATATOM D REPCOUNT Q:%ERR
 I %C="""" D STRLIT,%INC:'%ERR Q
 I %C="(" D ALTRN8 Q
 D PATCODE
 Q
REPCOUNT ;
 I %C'?1N,%C'="." S %ERR=1 Q
 N FROM S FROM=+$E(%,%I,999) I %C?1N D INTLIT Q:%ERR
 I %C="." D %INC
 Q:%C'?1N  I +$E(%,%I,999)<FROM S %ERR=1 Q
 D INTLIT Q
INTLIT I %C'?1N S %ERR=1 Q
 F  D %INC Q:%C'?1N
 Q
STRLIT F  D %INC Q:%C=""  I %C="""" Q:$E(%,%I+1)'=""""  S %I=%I+1
 I %C="" S %ERR=1
 Q
PATCODE I "ACELNPU"'[%C!(%C="") S %ERR=1 Q
 F  D %INC Q:%C=""  Q:"ACELNPU"'[%C
 Q
ALTRN8 I %C'="(" S %ERR=1 Q
 D %INC,PATATOM Q:%ERR
 F  Q:","'[%C  D %INC,PATATOM Q:%ERR
 I %C'=")" S %ERR=1 Q
 D %INC
 Q
 ;
BINOP ; binary operator (GG^DIM1)
 S %Z1=""")%'",%Z2="""($+-^%@'." G OPCHK
 ;
MTHOP ; math or relational operator (GG^DIM1)
 S %Z1=""")%",%Z2="""($+-^%@'." G OPCHK
 ;
UNOP ; unary operator (GG^DIM1)
 S %Z1=""":<>+-'\/()%@#&!*=_][,"
 S %Z2="""($+-=&!^%.@'" I %C="'" S %Z2=%Z2_"<>?[]"
 G OPCHK
 ;
IND ; "@": indirection (GG^DIM1)
 I $E(%COM)="F" G ERR
 S %Z1="^?@(%+-=\/#*!&'_<>[]:,.",%Z2="""(+^-'$@%" G OPCHK
 ;
OPCHK ; ensure that the characters before and after the operator are OK
 S %L1=$E(%,%I-1),%L2=$E(%,%I+1) I %L1="'","[]&!<>="[%C S %L1=$E(%,%I-2)
 I %L1="","+-'@"'[%C G ERR ;              binary: require before
 I %L1'?1UN,%Z1'[%L1 G ERR ;              all: screen before
 F %F="*","]" I %C=%F,%L2=%F S %I=%I+1,%L2=$E(%,%I+1) Q
 I %L2="" G ERR ;                         all: require after
 I %L2'?1UN,%Z2'[%L2 G ERR ;              all: screen after
 I %C="'","!&[]?=<>"'[%L2,%L1?1(1")",1UN) G ERR ;GFT: unary "'" may precede an operator, can't follow a variable name
 G 1
 ;
1 ; common exit point for all of ^DIM2
 G GG^DIM1
 ;
DATA ; glvn arguments of $D,$G,$NA,$O, & $Q functions (FUNC^DIM1)
 D %INC G ERR:%C="",ERR:%C=")",DATA:"^@"[%C D VAR
 G ERR:"@(,)"'[%C!%ERR,GG1^DIM1
 ;
VAR ; variables encountered while parsing exprs (DATA, GG^DIM1)
 N %START S %START=%I-1 I $E(%,%START)="^" S %START=%START-1
 I %C="%" D %INC
 N OUT S OUT=0 F %J=%I:1 S %C=$E(%,%J) D  Q:OUT
 . I ",<>?/\[]+-=_()*&#!':"[%C S OUT=1 Q
 . I %C="@",$E(%,%J+1)="(",$E(%,%START)="@" S OUT=1 Q
 . I %C'?1UN S %ERR=1
 . I %C="^",$D(%(%N-1,"F")),%(%N-1,"F")["TEXT" S %ERR=0,OUT=1
 Q:%ERR
 I %C="@" S %I=%J Q
 S %F=$E(%,%I,%J-1)
 I %F="^",$E(%,%J)'="(" S %ERR=1
 I %F]"",%F'?1U.UN,$E(%,%I-1,%J-1)'?1"%".UN S %ERR=1
 S %I=%J Q
 ;
%INC S %I=%I+1,%C=$E(%,%I)
 Q
 ;
ERR S %ERR=1,%N=0
FINISH G ERR:%N'=0 K %C,%,%F,%F1,%I,%J,%L1,%L2,%N,%T,%Z1,%Z2,%FN,%FZ
Q Q

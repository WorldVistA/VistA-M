DIM1 ;SFISC/JFW,GFT,TOAD-FileMan: M Syntax Checker, Exprs ;13DEC2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6**
 ;
 Q:%ERR  N %A,%A1 S (%I,%N,%ERR,%(-1,2),%(-1,3))=0
 ;
GG ; expr, expratom, expritem, subscript, parameter (called everywhere)
 D %INC G:%C="" FINISH^DIM2
 G E:%C=";"!($A(%C)>95)!($A(%C)<33)
 G QUOTE:%C="""",FUNC:%C="$",SUB^DIM2:%C="(",UP^DIM2:%C=")"
 G AR^DIM2:%C=",",SEL^DIM2:%C=":",GLO^DIM2:%C="^"
EXP I %C="E",$E(%,%I-1)?1N D  G E:%ERR S %I=%I-1 G GG
 . S %L1=$E(%,%I+1)
 . I %L1'?1(1N,1"+",1"-") S %ERR=1 Q
 . N %OUT S %OUT=0 F %I=%I+2:1 D  Q:%ERR!%OUT
 . . S %C=$E(%,%I)
 . . I "<>=!&'[]+-*/\#_?,:)"[%C S %OUT=1 Q
 . . I %C'?1N S %ERR=1 Q
 I %C?1(1U,1"%") D VAR^DIM2
 G E:%ERR,GG:%C=""
 G PAT^DIM2:%C="?",BINOP^DIM2:"=[]<>&!"[%C,MTHOP^DIM2:"/\*#_"[%C
 G UNOP^DIM2:"'+-"[%C,IND^DIM2:%C="@"
PERIOD I %C="." D  G E:%ERR
 . I $P($G(%(%N-1,0)),"^")="P" D  Q
 . . N %C S %C=$E(%,%I+1) I %C?1N Q  ; decimal pass by value
 . . I %C'="@",%C'?1U,%C'="%" S %ERR=1 ; bad pass by reference
 . D %INC N %L1,%P S %L1=$E(%,%I-2),%P="':=+-\/<>[](,*&!_#"
 . I %L1?1N,%C?1N Q  ; 4.2
 . I %P[%L1,%C?1N Q  ; +.2
 . S %ERR=1 ; illegal period
 I %C?1N,$E(%,%I+1)]"" G E:$E(%,%I+1)'?1(1NP,1"E")
GG1 ;
 I %C]"","$(),:"""[%C S %I=%I-1
 G GG
 ;
QUOTE ; strlit (GG)
 F %J=0:0 D %INC Q:%C=""!(%C="""")
 G E:%C=""!("[]()><\/+-=&!_#*,;:'"""'[$E(%,%I+1)) D:$D(%(%N-1,"F")) FN:%(%N-1,"F")["FN" G E:%ERR,GG
 ;
FUNC ; intrinsics & extrinsics, mainly intrinsic functions (GG)
 D %INC G EXT:%C="$",E:%C'?1U,SPV:$E(%,%I,999)'?.U1"(".E,FUNC1:%C="Z"!($E(%,%I+1)="(")
 S %T=$E(%,%I,$F(%,"(",%I)-2)
 I %T="ST"!(%T="STACK") G E ; SAC
 F %F1="FNUMBER^2;3","TRANSLATE^2;3","NAME^1;2","QLENGTH^1;1","QSUBSCRIPT^2;2","REVERSE^1;1" G FUNC2:$E(%F1,1,2)=%T,FUNC2:$P(%F1,"^")=%T
FNC ;;,ASCII^1;2,CHAR^1;999,DATA^1;1,EXTRACT^1;3,FIND^2;3,GET^1;2,JUSTIFY^2;3,LENGTH^1;2,ORDER^1;2,PIECE^2;4,QUERY^1;1,RANDOM^1;1,SELECT^1;999,TEXT^1;1,VIEW^1;999,ZFUNC^1;999
 G E:$T(FNC)'[(","_%T_"^")
FUNC1 S %F1=$P($T(FNC),",",$F("ACDEFGJLOPQRSTVZ",%C)) G E:%F1=""
FUNC2 S %I=$F(%,"(",%I)-1,%(%N,0)="1^"_$P(%F1,"^",2),%(%N,1)=0,%(%N,2)=0,%(%N,3)=0,%(%N,"F")=%F1,%N=%N+1 S:$E(%F1)="S" %(%N-1,2)=1
 I ",DATA,NAME,ORDER,QUERY,GET,"[(","_$P(%F1,"^")_",") G DATA^DIM2
 I $E(%F1)="T",$E(%F1,2)'="R" D  I %ERR G ERR^DIM2
 . S %A=%I,%I=$F(%,")",%A)-1,%N=%N-1,%A=$P($E(%,%A,%I-1),"(",2,99)
 . I %A?1"+"1N.E S %A=$E(%A,2,999)
 . N %,%I,%N S %=%A D LABEL^DIM3(1)
 G GG
 ;
SPV ; intrinsic special variables (FUNC)
 I $E(%,%I+1)?1U S %I=%I+1,%C=%C_$E(%,%I) G SPV
 I ",D,EC,ES,ET,K,P,Q,ST,SY,TL,TR,"[(","_%C_",") G E ; SAC
 I "HIJSTXYZ"[%C&(%C?1U)!(%C?1"Z".U) G GG
 I "[],)><=_&#!'+-*\/?"'[$E(%,%I+1) G E
 I ",DEVICE,ECODE,ESTACK,ETRAP,KEY,PRINCIPAL,QUIT,STACK,SYSTEM,TLEVEL,TRESTART,"[(","_%C_",") G E ; SAC
 I ",HOROLOG,IO,JOB,STORAGE,TEST,"[(","_%C_",") G GG
E G ERR^DIM2
 ;
%INC S %I=%I+1,%C=$E(%,%I) Q
 ;
FN ; literal string argument 2 of $FNUMBER (QUOTE)
 Q:%(%N-1,1)'=1  F %FZ=%I-1:-1 S %FN=$E(%,%FZ) Q:%FN=""""
 S %FN=$TR($E(%,%FZ+1,%I-1),"pt","PT")
 F %FZ=1:1 Q:$E(%FN,%FZ)=""  I "+-,TP"'[$E(%FN,%FZ) S %ERR=1 Q
 Q:%ERR  I %FN["P" F %FZ=1:1 Q:$E(%FN,%FZ)=""  I "+-T"[$E(%FN,%FZ) S %ERR=1 Q
 Q
 ;
EXT ; extrinsic functions and variables (FUNC)
 D %INC
 F %I=%I+1:1 S %C1=$E(%,%I) Q:%C1?1PC&("^%"'[%C1)!(%C1="")  S %C=%C_%C1
 G:%C="" E G:%C?.E1"^" E G:%C["^^" E
 S %C1=$P(%C,"^",2) I %C1]"",%C1'?1U.15AN,%C1'?1"%".15AN G E
 S %C=$P(%C,"^") I %C]"",%C'?1U.7AN,%C'?1"%".7AN,%C'?1.8N G E
 I $E(%,%I)="(",$E(%,%I+1)'=")" S %(%N,0)="P^",(%(%N,1),%(%N,2),%(%N,3))=0,%N=%N+1 G GG
 S %I=%I+$S($E(%,%I,%I+1)="()":1,1:-1)
 G GG:"[],)><=_&#!'+-*/\?:"[$E(%,%I+1),E

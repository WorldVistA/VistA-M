DIM4 ;SFISC/JFW,GFT,TOAD-FileMan: M Syntax Checker, Commands ;5/6/97  09:10
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;12279;3292224;3060;
 ;
BK ; BREAK and QUIT (B^DIM and Q^DIM)
 I %ARG]"" S %=%ARG D ^DIM1 G ER:%ERR
 G GC^DIM
 ;
CL ; CLOSE (C^DIM)
 G ER:%ERR I %ARG]"" F %Z=0:0 D S S %=%A D ^DIM1 G:%ARG=""!%ERR GC^DIM
 G GC^DIM
 ;
IX ; IF and XECUTE (I^DIM and X^DIM)
 G GC^DIM:%ARG=""!%ERR D S S %L=":" D S1 I %C=%L S %=%A1 D ^DIM1 G ER:%A1=""!%ERR
 S %=%A D ^DIM1 G IX
 ;
ST ; SET and MERGE (S^DIM and M^DIM)
 G GC^DIM:%ARG=""!%ERR D S G ER:%ERR!(%A=""&(%C=","))
 I %A?1"@".E S %=%A D ^DIM1 G ST
 S %L="=" D S1 G ER:(%A="")!(%A1="") S %=%A1 G ER:%COM="M"&'$$GLVN(%) D ^DIM1 G ER:%ERR
 I %A?1"(".E1")" S %A=$E(%A,2,$L(%A)-1) G ER:%COM="M",STM
 D VV G ST
 ;
STM ; SET (x,y)=... (ST)
 G ST:%ERR!(%A=""),ER:%A?1",".E S %L="," D S1 G ER:%ERR!(%C=%L&(%A1=""))
 D VV S %A=%A1 G STM
 ;
RD ; READ (R^DIM)
 G GC^DIM:%ARG=""!%ERR D S G ER:%ERR!(%C=","&(%A=""))
 I "!#?"[$E(%A,1) S %I=0 D FRM G RD
 I %A?1"""".E G ER:$P(%A,"""",3)'="" S %=%A D ^DIM1 G RD
 I %A?1"*".E S %A=$E(%A,2,999)
 I $E(%A)="^","^TMP^XTMP^"'[$P(%A,"(") G ER
 F %L=":","#" D  G ER:%ERR
 . D S1 Q:%ERR
 . I %A="" S %ERR=1 Q
 . I %A1="",%C=%L S %ERR=1 Q
 . S %=%A1 D ^DIM1
 D VV G ER:%ERR,RD
 ;
WR ; WRITE (W^DIM)
 G GC^DIM:%ARG=""!%ERR D S G ER:%ERR!(%A=""&(%C=","))
 I "!#?/"[$E(%A) S %I=0 D FRM G WR
 S:%A?1"*".E %A=$E(%A,2,999) S %=%A D ^DIM1 G WR
 ;
FRM ; format (RD and WR)
 S %I=%I+1,%C=$E(%A,%I) Q:%C=""  G FRM:"!#"[%C
 S %=$E(%A,%I+1,999) I %]"",%C="?" D ^DIM1 Q
 I %C="/",%COM="W" S:%?1"?".E %="A"_$E(%,2,999) I %?1AN.E D ^DIM1 Q
 S %ERR=1 Q
 ;
S ; split at first comma: end of first argument (*)
 S (%A,%C)="" Q:%ERR  S (%ERR,%I)=0
INC D %INC D QT:%C="""",P:%C="(" Q:%ERR  G OUT:","[%C,INC
QT D %INC Q:%C=""""  G QT:%C]"" S %ERR=1 Q
P S %P=1 F %J=0:0 D %INC D QT:%C="""" S %P=%P+$S(%C="(":1,%C=")":-1,1:0) Q:'%P  I %C="" S %ERR=1 Q
 Q
OUT S %A=$E(%ARG,1,%I-1),%ARG=$E(%ARG,%I+1,999) Q
%INC S %I=%I+1,%C=$E(%ARG,%I) Q
 ;
S1 ; split at first instance of %L (*)
 S (%A1,%C)="" Q:%ERR  S (%ERR,%I)=0
INCR D %INC1 D QT1:%C="""",P1:%C="(" Q:%ERR  G OUT1:%L[%C,INCR
OUT1 S %A1=$E(%A,%I+1,999),%A=$E(%A,1,%I-1) Q
QT1 D %INC1 Q:%C=""""  G QT1:%C]"" S %ERR=1 Q
P1 S %P=1 F %J=0:0 D %INC1 D QT1:%C="""" S %P=%P+$S(%C="(":1,%C=")":-1,1:0) Q:'%P  I %C="" S %ERR=1 Q
 Q
%INC1 S %I=%I+1,%C=$E(%A,%I) Q
 ;
VV ; glvn or setleft (ST, STM, and RD)
 S %=%A Q:%ERR
 I %]"",$$GLVN(%)=0 D
 .I %COM'="S" S %ERR=1 Q
 .I %["(",(%?1"$P".E)!(%?1"$E".E) Q
 .I %="$X"!(%="$Y") Q
 .I %="$D"!(%="$DEVICE")!(%="$K")!(%="$KEY")!(%="$EC")!(%="$ECODE")!(%="$ET")!(%="$ETRAP") S %ERR=1 Q  ; SAC
 .S %ERR=1
 D ^DIM1:'%ERR Q
 ;
GLVN(%) ; glvn (not counting subscript syntax)
 I %?.1"^"1U.UN Q 1
 I %?.1"^"1U.UN1"("1.E1")" Q 1
 I %?.1"^"1"%".UN Q 1
 I %?.1"^"1"%".UN1"("1.E1")" Q 1
 I %?1"^("1.E1")" Q 1
 I %?1"^$"1.U1"("1.E1")" Q 1
 I %?1"@"1.E Q 1
 Q 0
 ;
ER G ER^DIM

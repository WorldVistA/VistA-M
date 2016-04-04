DIM3 ;SFISC/JFW,GFT,TOAD-FileMan: M Syntax Checker, Commands ;25MAR2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1038**
 ;
 ;
DG ; DO and GET (D^DIM and G^DIM)
 G GC^DIM:%ARG=""!%ERR D PARS G ER:%ERR
 S %L=":" D PARS1 G ER:%ERR I %C=%L G ER:%A1="" S %=%A1 D ^DIM1
 I %A["@^" S %=%A D ^DIM1 G DG
 I %A["(",$E(%A)'="@",$E($P(%A,"^",2))'="@" D  G ER:%ERR
 . I %COM'="D" S %ERR=1 Q
 . S %=%A
 . I %'?.E1"(".E1")" S %ERR=1 Q
 . S %C=$P(%,"("),%C1=$P(%C,"^",2,999),%I=$F(%,"(")-1
 . I %C=""!(%C?.E1"^") S %ERR=1 Q
 . I %C1]"",%C1'?1U.15AN,%C1'?1"%".15AN S %ERR=1 Q
 . S %C=$P(%C,"^") I %C]"",%C'?1U.15AN,%C'?1"%".15AN,%C'?1.15N S %ERR=1 Q
 . Q:$E(%,%I,%I+1)="()"
 . S (%(-1,2),%(-1,3))=0,%N=1,%(0,0)="P^",(%(0,1),%(0,2),%(0,3))=0
 . D GG^DIM1
 E  D LABEL(0)
 G DG
 ;
LABEL(OFFSET) ; labelref, entryref, and $TEXT argument (DG and TEXT^DIM1)
 S %L="^" D PARS1 Q:%ERR
 I %C=%L S:%A1=""!($E(%A1)="^") %ERR=1 S %=%A1 D VV,^DIM1 Q:%ERR
 S %=%A D VV:%'=+%&'OFFSET,^DIM1 Q
 ;
KL ; KILL, LOCK, and NEW (K^DIM and LK)
 D PARS G ER:%ERR
 I %A="",%C="," G ER
 I %A?1"^"1UP.UN,%COM'="L" G ER
 I %A?1"(".E1")" D  G KL
 . S %ARG("E")=$L(%ARG)
 . S %A=$E(%A,2,$L(%A)-1) S %ARG=%A_$S(%ARG]"":","_%ARG,1:"")
 S %=%A I %COM="L","+-"[$E(%A) S $E(%A)=""
 I %COM="N",'$$LNAME(%) G ER
 I %COM="K",$D(%ARG("E")),'$$LNAME(%) G ER
 I $D(%ARG("E")),$L(%ARG)'>%ARG("E") K %ARG("E")
 D VV,^DIM1 G GC^DIM:%ARG=""!%ERR
 G KL
 ;
LK ; LOCK (L^DIM)
 S %A=%ARG,%L=":" S:"+-"[$E(%A) %A=$E(%A,2,999) D PARS1
 I %C=%L G ER:%A1="" S %=%A1 D ^DIM1
 S %ARG=%A G GC^DIM:%A="",KL
 ;
HN ; HANG (H^DIM)
 S %=%ARG D ^DIM1 G GC^DIM
 ;
OP ; OPEN and USE (O^DIM and U^DIM)
 G GC^DIM:%ARG=""!%ERR D PARS G ER:%ERR!(%C=","&(%A=""))
 G US:%COM="U" S %L=":" D PARS1 S %A2=%A,%A=%A1 S:%C=%L&(%A="") %ERR=1 D PARS1 G ER:%ERR!(%C=%L&(%A1=""))
 F %L="%A1","%A2" S %=@%L D ^DIM1 G OP:%ERR
 G OP
US S %L=":" D PARS1 G ER:%C=%L&(%A1="") S %=%A D ^DIM1
 S %A=%A1 D PARS1 G ER:%C]"",OP
 ;
FR ; FOR (F^DIM)
 S %L="=",%A=%ARG D PARS1 G ER:%ERR!(%A1="")!(%A="") S %ARG=%A1
 S %=%A G ER:%A?1"^".E D VV,^DIM1 G ER:%ERR
FR1 G GC^DIM:%ARG=""!%ERR D PARS
 S %L=":" F %A=%A,%A1 D PARS1 G ER:%ERR!(%A=""&(%C=%L)) S %=%A D ^DIM1
 I %A1]"" S %=%A1 D ^DIM1
 G FR1
 ;
PARS S (%A,%C)="" Q:%ERR  S (%ERR,%I)=0
INC D %INC D QT:%C="""",PARAN:%C="(" Q:%ERR  G OUT:","[%C,INC
QT D %INC Q:%C=""""  G QT:%C]"" S %ERR=1 Q
PARAN S %P=1 F %J=0:0 D %INC D QT:%C="""" S %P=%P+$S(%C="(":1,%C=")":-1,1:0) Q:'%P  I %C="" S %ERR=1 Q
 Q
OUT S %A=$E(%ARG,1,%I-1),%ARG=$E(%ARG,%I+1,999) Q
%INC S %I=%I+1,%C=$E(%ARG,%I) Q
 ;
PARS1 S (%A1,%C)="" Q:%ERR  S (%ERR,%I)=0
INCR D %INC1 D QT1:%C="""",PARAN1:%C="(" Q:%ERR=1  G OUT1:%L[%C,INCR
OUT1 S %A1=$E(%A,%I+1,999),%A=$E(%A,1,%I-1) Q
QT1 D %INC1 Q:%C=""""  G QT1:%C]"" S %ERR=1 Q
PARAN1 S %P=1 F %J=0:0 D %INC1 D QT1:%C="""" S %P=%P+$S(%C="(":1,%C=")":-1,1:0) Q:'%P  I %C="" S %ERR=1 Q
 Q
%INC1 S %I=%I+1,%C=$E(%A,%I) Q
 ;
VV ; variable, label, or routine name (LABEL, KL, and FR)
 I '%ERR,%]"",%'["@",%'?1U.15UN,%'?1U.15UN1"(".E1")",%'?1"%".15UN1"(".E1")",%'?1"%".15UN,%'?1"^"1U.15UN1"(".E1")",%'?1"^%".15UN1"(".E1")",%'?1"^(".E1")",%'?1"^"1U.15UN S %ERR=1
 S:%["?@" %ERR=1 Q
 ;
LNAME(%) ; lname (KL)
 I %?1(1A,1"%").7UN Q 1
 I %?1"@".E Q 1
 Q 0
 ;
ER G ER^DIM

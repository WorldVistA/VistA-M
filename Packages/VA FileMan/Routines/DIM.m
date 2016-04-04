DIM ;SFISC/JFW,GFT,TOAD-FileMan: M Syntax Checker, Main ;22APR2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1003,1035**
 ;
 S %X=X,%END="",%ERR=0,%LAST="" G ER:X'?.ANP
 ;
GC ; get next command on line (*)
 G ER:%ERR,LAST:";"[$E(%X) F  Q:$E(%X)'=" "  S %X=$E(%X,2,999)
 G ER:"BCDEFGHIKLMNOQRSUWXZ"'[$E(%X)
 S %LAST=%X D SEP G ER:%ERR S %COM=$P(%ARG,":") ; command word
 I $L(%COM)>1 D  G ER:%ERR
 . I $T(COMMAND)'[(";"_%COM_";"),%COM'?1"Z"1.U S %ERR=1
 . E  S %COM=$E(%COM)
 S %=$P(%ARG,":",2,99),%COM(1)=% I %ARG[":",%="" G ER ; command postcond
 I %]"" D ^DIM1 G ER:%ERR
 D SEP G ER:%ERR I %ARG="","CDGMORSUWXZ"[%COM G ER ; argument list
 S %END=%ARG G @%COM
 ;
B G GC:%ARG=""&(%COM(1)=""),BK^DIM4
C G CL^DIM4
D G DG^DIM3
E G GC:%ARG=""&(%COM(1)=""),ER
F G ER:%COM(1)]""!(";"[$E(%X)),GC:%ARG="",FR^DIM3 ;GFT-DON'T END WITH 'F'
G G DG^DIM3
H G GC:%ARG=""&(%COM(1)="")&(%X]""),HN^DIM3:%ARG]"",ER Q
I G ER:%COM(1)]"",IX^DIM4
K G GC:%ARG=""&(%COM(1)="")&(%X]""),KL^DIM3:%ARG]"",ER
L G LK^DIM3
M G S
N G ER:%ARG=""&(%X=""),K
O G OP^DIM3
Q G ER:%ARG]"",GC:%ARG=""&(%COM(1)=""),BK^DIM4
R G RD^DIM4
S G ST^DIM4
U G OP^DIM3
W G WR^DIM4
X G IX^DIM4
Z G GC
 ;
SEP ; remove first " "-piece of %X into %ARG: parse commands (GC)
 F %I=1:1 S %C=$E(%X,%I) D:%C=""""  Q:" "[%C
 . N %OUT S %OUT=0 F  D  Q:%OUT!%ERR
 . . S %I=%I+1,%C=$E(%X,%I) I %C="" S %ERR=1 Q
 . . Q:%C'=""""  S %I=%I+1,%C=$E(%X,%I) Q:%C=""""  S %OUT=1
 S %ARG=$E(%X,1,%I-1),%I=%I+1,%X=$E(%X,%I,999)
 Q
 ;
COMMAND ;;BREAK;CLOSE;DO;ELSE;FOR;GOTO;HALT;HANG;IF;KILL;LOCK;MERGE;NEW;OPEN;QUIT;READ;SET;USE;WRITE;XECUTE;
 ;
LAST ; check to ensure no trailing "," or " " at end of command (GC)
 S %L=$L(%LAST),$E(%LAST,%L+1-$L(%X),%L)=""
 I $E(%END,$L(%END))="," G ER
 I $E(%X)="",$E(%LAST,%L)=" " G ER
 G END
 ;
ER K X
END K %,%A,%A1,%A2,%ARG,%C1,%C,%COM,%END,%ERR,%H,%I,%L,%LAST,%P,%X,%Z Q

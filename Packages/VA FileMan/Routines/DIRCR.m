DIRCR ;SFISC/GFT-DELETE THIS LINE AND SAVE AS '%RCR'*** ;13DEC2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**139,1044**
 ;
%RCR ;GFT/SF
 ;
 ;
STORLIST ;
 D INIT
O S %D=$O(%RCR(%D)) G CALL:%D=""
 I $D(@%D)#2 S @(%E_")="_%D) G O:$D(@%D)=1
 S %X=%D_"(" D %XY G O
 ;
CALL S %E=%RCR K %RCR,%X,%Y D @%E
 S %E="^UTILITY(""%RCR"",$J,"_^UTILITY("%RCR",$J)_",%D",^($J)=^($J)-1,%D=0,%X=%E_","
G S %D=$O(@(%E_")")) I %D="" K %D,%E,%X,%Y,^($J,^UTILITY("%RCR",$J)+1) Q
 I $D(^(%D))#2 S @%D=^(%D) G G:$D(^(%D))=1
 S %Y=%D_"(" D %XY G G
 ;
INIT I $D(^UTILITY("%RCR",$J))[0 S ^UTILITY("%RCR",$J)=0
 S ^($J)=^($J)+1,%D="%Z",%E="^UTILITY(""%RCR"",$J,"_^($J)_",%D",%Y=%E_","
 K ^($J,^($J))
 Q
 ;
 ;
 ;
 ;
XY(%X,%Y) ;
%XY ;NOIS: UNY-0504-10264
 N %A,%B,%C
 S %A=%X I $P(%X,"(",2)]"",$E(%X,$L(%X))'="," S %A=%A_",",%C=1
 S %A=$$NA(%A),%B=$$NA(%Y)
 I $D(%C) S %C=$QS(%A,$QL(%A)),%A=$NA(@%A,$QL(%A)-1) D  G RE
 .N A,B S B=$NA(@%B@(%C)),A=$NA(@%A@(%C)) N %A,%B,%C S %A=A,%B=B D M ;a bit of recursion
M I $D(@%A)[0 M @%B=@%A Q
 S %C=""
RE F  S %C=$O(@%A@(%C)) Q:%C=""  D
 .I $D(@%A@(%C))=1 S @%B@(%C)=@%A@(%C) Q
 .M @%B@(%C)=@%A@(%C)
 Q
 ;
NA(%X) ;
 N L S L=$L(%X)
 I $E(%X,L)="," S %X=$E(%X,1,L-1)_")"
 E  S %X=$E(%X,1,L-1)
 Q $NA(@%X)
 ;
 ;
OS ;
 S $P(^%ZOSF("OS"),"^",2)=DITZS
 K DITZS S ZTREQ="@"
 Q

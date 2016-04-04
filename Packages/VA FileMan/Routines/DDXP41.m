DDXP41 ;SFISC/DPC-EXPORT DATA (CONT) ;1/8/93  09:18
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
SORTVAL ;
 N DDXPNG,CHK
 S DDXPNG=0
 F CHK="#","!","+","@" D
 . I $E(X)=CHK S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot use the "_CHK_" sort qualifier when exporting data.",!
 . Q
 F CHK=";C",";S" D
 . I X[CHK S DDXPNG=1 W !!,$C(7),"SORRY.  Using "_CHK_" will have no effect when exporting data.",!
 . Q
 I X[";""" S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot replace a caption with a literal when exporting data.",!
 K:DDXPNG X
 Q

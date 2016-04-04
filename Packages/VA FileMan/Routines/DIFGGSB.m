DIFGGSB ;SFISC/XAK,EDE(OHPRD)-FILEGRAM SPECIAL BLOCK ;
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;EDE/OHPRD/IHS changed BEGEN/END line to match BNF
 ;
START ; (CALLED RECURSIVELY)
 K DIFGSB(DILL)
 D BEGIN
 S DITAB=DITAB+2
 D BODY^DIFGGSB1
 S DITAB=DITAB-2
 D END,EOJ
 Q
 ;
BEGIN ; BEGIN LINE
 S V="BEGIN:"_DIFG(DILL,"FNAME")_"^"_$S(DIFG("PARM")["N":DIFG(DILL,"FILE"),1:"")
 I $D(Z),Z'="" S V=V_Z,Z=""
 D INCSET^DIFGGU
 Q
 ;
 ;
END ; END LINE
 S V="END:"_DIFG(DILL,"FNAME")_"^"_$S(DIFG("PARM")["N":DIFG(DILL,"FILE"),1:"")
 D INCSET^DIFGGU
 Q
 ;
EOJ ;
 K DIFGSB(DILL)
 K %,C,D0,J,S,V,X,Y,Z
 Q

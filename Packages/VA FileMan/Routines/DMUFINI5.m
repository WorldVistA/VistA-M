DMUFINI5 ;VEN/SMH-FILEMAN UNIT TEST INIT ; 10-JAN-2013 ; 1/27/13 3:48pm
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 K ^UTILITY("DIF",$J) S DIFRDIFI=1 F I=1:1:4 S ^UTILITY("DIF",$J,DIFRDIFI)=$T(IXF+I),DIFRDIFI=DIFRDIFI+1
 Q
IXF ;;FILEMAN EXTENSIONS FILES^DMUF
 ;;1009.801;BROKEN FILE;^DMU(1009.801,;0;y;y;;n;;;y;o;n
 ;;
 ;;1009.802;SHADOW STATE;^DMU(1009.802,;0;y;y;;n;;;y;o;n
 ;;

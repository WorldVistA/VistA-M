DIAXERR ;SFISC/DCM-EXTRACT MAPPING UTILITIES ;5/1/96  16:49
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ERR(A) ;
 Q:'$D(A)  N DIAXMSG
 S DIPG=+$G(DIPG),DIERR=($G(DIERR)+1)_U_($P($G(DIERR),U)+1)
 S DIAXMSG=$S(+A:$P($T(@(+A)),";",3),1:A)
 I DIPG S ^TMP("DIERR",$J,+DIERR)="",^(+DIERR,"TEXT",1)=DIAXMSG Q
 E  D EN^DDIOL(DIAXMSG)
 Q
5 ;;Destination file does not exist
6 ;;Mapping information does not exist
7 ;;Extract field does not exist
8 ;;Field in destination file does not exist

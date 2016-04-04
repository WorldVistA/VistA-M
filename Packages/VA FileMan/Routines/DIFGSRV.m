DIFGSRV ;SFISC/RWF-SERVER INTERFACE TO FILEGRAMS ;
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
HIST ;Add a message to the FileGram History file so it can be processed.
 S DIXM=0,U="^" X XMREC ;get first line
 I $P(XMRG,U)'="$DAT" S DIXM=DIXM+1,XQSTXT(DIXM)="First line of message doesn't start with '$DAT'"
 S DIFG=$P(XMRG,U,3)
 I DIFG<2 S DIXM=DIXM+1,XQSTXT(DIXM)="Can't update a VA FileMan file."
 I "^2^3^19^"[(U_DIFG_U) S DIXM=DIXM+1,XQSTXT(DIXM)="Update to a protected file (#"_DIFG_")."
 Q:DIXM
 S DIFG("FE")=+$P(XQSUB,"#",2),DIFG("TEMPLATE")="",DIFG("DUZ")=XMFROM
 D LOG^DIFGG
 Q

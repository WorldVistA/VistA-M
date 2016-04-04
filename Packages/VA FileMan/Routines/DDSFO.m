DDSFO ;SFISC/MKO-FORM ONLY FIELDS ;1:52 PM  19 Jun 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
DIR ;Setup input variables to DIR
 N I,J
 S DIR(0)=$P(DDSO(20),U)_$P(DDSO(20),U,2,3)
 S:DIR(0)?1"DD".E DIR(0)=$P(DIR(0),U,2,999)
 S:$P(DIR(0),U)'["O" $P(DIR(0),U)=$P(DIR(0),U)_"O"
 I $P(DIR(0),U)["P",$P($P(DIR(0),U,2),":",2)'["Z" D
 . S I=$P(DIR(0),U,2) Q:$P(I,":",2)["Z"
 . S $P(I,":",2)=$P(I,":",2)_"Z"
 . S $P(DIR(0),U,2)=I
 S:$G(^DIST(.404,DDSBK,40,DDO,22))'?."^" $P(DIR(0),U,3)=^(22)
 I $D(^DIST(.404,DDSBK,40,DDO,21)) D
 . S (I,J)=0
 . F  S I=$O(^DIST(.404,DDSBK,40,DDO,21,I)) Q:I=""  I $D(^(I,0))#2 S J=J+1,DIR("?",J)=^(0)
 . I J>0 S DIR("?")=DIR("?",J) K DIR("?",J)
 X:$G(^DIST(.404,DDSBK,40,DDO,24))'?."^" ^(24)
 Q

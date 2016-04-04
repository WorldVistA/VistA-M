DDSZ3 ;SFISC/MKO-FORM COMPILER ;02:49 PM  30 Dec 1993
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ASUB(DDSPG,DDSFRM) ;
 ;Set @DDSREFS@("ASUB",pg,bk,ddo)=subpage for parent field
 N MF,MB,MP
 S MF=$P(^DIST(.403,+DDSFRM,40,DDSPG,1),U,2) Q:MF=""
 S MP=$P(MF,",",3),MB=$P(MF,",",2),MF=$P(MF,",")
 ;
 S MF=$$GETFLD^DDSLIB(MF,MB,MP,DDSFRM)
 I $G(DIERR) K DIERR,^TMP("DIERR",$J) Q
 S @DDSREFS@("ASUB",$P(MF,",",3),$P(MF,",",2),$P(MF,","))=DDSPG
 Q
 ;
PGRP(FRM,G) ;Find page groups
 ;In:  FRM = Form number
 ;Out: G   = Array of page groups
 ;
 N B,I,NP,P,PP,PG
 S G=0
 S P=0 F  S P=$O(^DIST(.403,FRM,40,P)) Q:'P  D
 . Q:'$D(^DIST(.403,FRM,40,P,0))  S NP=$P(^(0),U,4),PP=$P(^(0),U,5)
 . F PG="NP","PP" I @PG D
 .. S @PG=$O(^DIST(.403,FRM,40,"B",@PG,"")) Q:'@PG
 .. S:$D(^DIST(.403,FRM,40,@PG,0))[0 @PG=""
 . S:NP=P NP=0 S:PP=NP!(PP=P) PP=0
 . S I=0 F  S I=$O(G(I)) Q:'I  Q:U_G(I)_U[(U_P_U)
 . I 'I S G=G+1,G(G)=P_$S(NP:U_NP,1:"")_$S(PP:U_PP,1:"") Q
 . F PG="NP","PP" I @PG,U_G(I)_U'[(U_@PG_U) S G(I)=G(I)_U_@PG
 Q

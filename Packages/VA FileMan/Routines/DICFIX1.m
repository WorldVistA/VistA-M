DICFIX1 ;SEA/TOAD,SF/TKW-FileMan: Finder, Search Compound Indexes (cont.) ;15MAY2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1040,1041**
 ;
 ;
NXTNAM(DIVAL,DIPART,DINDEX,DISKIP,DIDONE) ;
 ; limited comma piece lookup, skip nonmatching names in index
 N DIUTF8 D
 .N X,Y S Y=$C(126),X=$G(^DD("OS",^DD("OS"),"HIGHESTCHAR")) X:X]"" X S DIUTF8=Y
 I $P(DIVAL,",")=DIPART S DIVAL=DIPART_","_DIUTF8,DISKIP=1 Q  ;UTH/SMH
 N DIPREC,DIPOSTC,DIPPOSTC
 S DIPREC=$P(DIVAL,","),DIPOSTC=$P(DIVAL,",",2)
 S DIPPOSTC=DINDEX(DISUB,DITRXNO,"c")
 I $$PREFIX(DIPOSTC,DIPPOSTC) Q
 I $$PREFIX(DIPPOSTC,DIPOSTC) Q
 D SKIP(.DISKIP,.DIVAL,DIPREC,DIPOSTC,DIPART,DIPPOSTC,.DINDEX)
 Q
 ;
PREFIX(DISTRING,DIPREFIX) ;
 Q $E(DISTRING,1,$L(DIPREFIX))=DIPREFIX
 ;
SKIP(DISKIP,DIVAL,DIPREC,DIPOSTC,DIPART,DIPPOSTC,DINDEX) ;
 ; Skip forward within index based on limited comma piecing
 I DIPPOSTC]DIPOSTC D  Q
 . ; Current first name before starting first name, skip to starting first name
 . S DIVAL=DIPREC_","_DIPPOSTC
 . I '$D(@DINDEX(DISUB,"ROOT")@(DIVAL)) S DISKIP=1
 ; Else, skip the rest of the first names within current last name.
 S DIVAL=DIPREC_","_DIUTF8,DISKIP=1 Q  ;UTH/SMH
 ;
 ;

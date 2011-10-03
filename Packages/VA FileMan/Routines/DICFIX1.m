DICFIX1 ;SEA/TOAD,SF/TKW-FileMan: Finder, Search Compound Indexes (cont.) ;2/20/98  09:53
 ;;22.0;VA FileMan;;Mar 30, 1999;
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NXTNAM(DIVAL,DIPART,DINDEX,DISKIP,DIDONE) ;
 ; limited comma piece lookup, skip nonmatching names in index
 I $P(DIVAL,",")=DIPART S DIVAL=DIPART_",~",DISKIP=1 Q
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
 . Q
 ; Else, skip the rest of the first names within current last name.
 S DIVAL=DIPREC_",~",DISKIP=1 Q
 ;
 ;

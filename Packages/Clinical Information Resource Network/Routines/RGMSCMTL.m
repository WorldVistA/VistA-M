RGMSCMTL ;CAIRO/DKM - Multi-term lookup support ;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Parse term into component words (KWIC)
PARSE2(RGTRM,RGRTN,RGMIN) ;
 Q $$PARSE2^RGUTMTL(.RGTRM,.RGRTN,.RGMIN)
 ; Parse term into component words
PARSE(RGTRM,RGRTN,RGMIN) ;
 Q $$PARSE^RGUTMTL(.RGTRM,.RGRTN,.RGMIN)
 ; Create/delete an MTL cross reference for term
XREF(RGRT,RGTRM,RGDA,RGDEL) ;
 D XREF^RGUTMTL(.RGRT,.RGTRM,.RGDA,.RGDEL)
 Q
 ; Lookup a term in an MTL index
LKP(RGRT,RGTRM,RGRTN,RGABR) ;
 Q $$LKP^RGUTMTL(.RGRT,.RGTRM,.RGRTN,.RGABR)

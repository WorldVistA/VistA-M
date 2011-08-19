ORWUH ; SLC/KCM - Help Utilities
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
POPUP(LST,CTRL) ; Get instructions for a given control
 ; ERROR
 N TMP,I,ILST
 D GETWP^XPAR(.TMP,"PKG","ORWUH WHATSTHIS",CTRL,.ERR)
 S ILST=1,LST(1)=$G(TMP)
 S I=0 F  S I=$O(TMP(I)) Q:'I  S ILST=ILST+1,LST(ILST)=TMP(I,0)
 I ERR ; Generate an error of some sort
 Q

XWBFM ;SFISC/VYD - Broker FileMan connectivity ;08/14/95  16:31
 ;;1.1;RPC BROKER;;Mar 28, 1997
FIELDLST(RESULT,FNUM) ;retrieve a list of top-level fields of passed file
 ;and return it in RESLUT
 ;**** Note: requires FileMan v 21 with NEW DD RETRIEVER VER 1.0 patch
 N %
 D FILE^DID(FNUM,"T","FIELDS","^TMP($J)","JUNK")
 S %="" F  S %=$O(^TMP($J,"FIELDS",%)) Q:%=""  D
 . S RESULT(%)=$P(^(%),U)_"   ["_$P(^(%),U,2)_"]"
 K ^TMP($J)
 Q
 ;
FILELIST(RESULT,START) ;retrieve a list and return it in RESLUT
 N %
 D LIST^DIC(1,"","","P","","",START)
 S %=0 F  S %=$O(^TMP("DILIST",$J,%)) Q:%=""  D
 . S RESULT(%)=$P(^(%,0),U)_"   ["_$P(^(0),U,2)_"]"
 K ^TMP("DILIST",$J)  ;clean up
 Q
 ;
APILIST(RESULT,START) ;retrieve a list and return it in RESLUT
 N %
 D LIST^DIC(8994,"",".02;.03","P","","",START)
 S %=0 F  S %=$O(^TMP("DILIST",$J,%)) Q:%=""  D
 . S RESULT(%)=$P(^(%,0),U)_"   ["_$P(^(0),U,3,4)_"]"
 K ^TMP("DILIST",$J)  ;clean up
 Q
 ;
FILECHK(RESULT,FNAME) ;checks if the FNAME file exists.  If found, return IEN
 S RESULT=$$FIND1^DIC(1,"","O",FNAME)
 Q

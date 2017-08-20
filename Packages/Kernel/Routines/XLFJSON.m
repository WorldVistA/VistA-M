XLFJSON ;SLC/KCM/TJB - Decode/Encode JSON ;26 Oct 2016
 ;;8.0;KERNEL;**680**;Jul 10, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Note:  Since the routines use closed array references, XUROOT and XUERR
 ;        are used to reduce risk of naming conflicts on the closed array.
 ;
DECODE(XUJSON,XUROOT,XUERR)  ; Set JSON object into closed array ref XUROOT
 ; Examples: D DECODE^XLFJSON("MYJSON","LOCALVAR","LOCALERR")
 ;           D DECODE^XLFJSON("^MYJSON(1)","^GLO(99)","^TMP($J)")
 ;
 ; XUJSON: Required; string/array containing serialized JSON object
 ; XUROOT: Required; closed array reference for M representation of object
 ;  XUERR: Optional; closed array reference contains error messages, defaults to ^TMP("XLFJERR",$J)
 ;
 ;   XUIDX: points to next character in JSON string to process
 ; XUSTACK: manages stack of subscripts
 ;  XUPROP: true if next string is property name, otherwise treat as value
 ;
 G DIRECT^XLFJSOND
 ;
ENCODE(XUROOT,XUJSON,XUERR) ; XUROOT (M structure) --> XUJSON (array of strings)
 ; Examples:  D ENCODE^XLFJSON("^GLO(99,2)","^TMP($J)")
 ;            D ENCODE^XLFJSON("LOCALVAR","MYJSON","LOCALERR")
 ;
 ; XUROOT: Required; closed array reference for M representation of object
 ; XUJSON: Required; destination variable for the string array formatted as JSON
 ;  XUERR: Optional; closed array reference contains error messages, defaults to ^TMP("XLFJERR",$J)
 ;
 G DIRECT^XLFJSONE
 ;
 ;
ESC(X) ; Escape string for JSON
 ; X: Required; String to be escaped
 Q $$ESC^XLFJSONE(X)
 ;
UES(X) ; Unescape JSON string
 ; X: Required; String to be unescaped
 Q $$UES^XLFJSOND(X)
 ;
ERRX(ID,VAL) ; Set the appropriate error message
 ; switch (ID) -- XERRX ends statement
 N ERRMSG
 ;
 ; Decode Error Messages
 ;
 I ID="STL{" S ERRMSG="Stack too large for new object." G XERRX
 I ID="SUF}" S ERRMSG="Stack Underflow - extra } found" G XERRX
 I ID="STL[" S ERRMSG="Stack too large for new array." G XERRX
 I ID="SUF]" S ERRMSG="Stack Underflow - extra ] found." G XERRX
 I ID="OBM" S ERRMSG="Array mismatch - expected ] got }." G XERRX
 I ID="ARM" S ERRMSG="Object mismatch - expected } got ]." G XERRX
 I ID="MPN" S ERRMSG="Missing property name." G XERRX
 I ID="EXT" S ERRMSG="Expected true, got "_VAL G XERRX
 I ID="EXF" S ERRMSG="Expected false, got "_VAL G XERRX
 I ID="EXN" S ERRMSG="Expected null, got "_VAL G XERRX
 I ID="TKN" S ERRMSG="Unable to identify type of token, value was "_VAL G XERRX
 I ID="SCT" S ERRMSG="Stack mismatch - exit stack level was  "_VAL G XERRX
 I ID="EIQ" S ERRMSG="Close quote not found before end of input." G XERRX
 I ID="EIU" S ERRMSG="Unexpected end of input while unescaping." G XERRX
 I ID="RSB" S ERRMSG="Reverse search for \ past beginning of input." G XERRX
 I ID="ORN" S ERRMSG="Overrun while scanning name." G XERRX
 I ID="OR#" S ERRMSG="Overrun while scanning number." G XERRX
 I ID="ORB" S ERRMSG="Overrun while scanning boolean." G XERRX
 I ID="ESC" S ERRMSG="Escaped character not recognized"_VAL G XERRX
 I ID="NOV" S ERRMSG="Expected value, got "_VAL G XERRX
 ;
 ; Encode Error Messages
 ;
 I ID="SOB" S ERRMSG="Unable to serialize node as object, value was "_VAL G XERRX
 I ID="SAR" S ERRMSG="Unable to serialize node as array, value was "_VAL G XERRX
 S ERRMSG="Unspecified error "_ID_" "_$G(VAL)
XERRX ; end switch
 S @XUERR@(0)=$G(@XUERR@(0))+1
 S @XUERR@(@XUERR@(0))=ERRMSG
 S XUERRORS=XUERRORS+1
 Q

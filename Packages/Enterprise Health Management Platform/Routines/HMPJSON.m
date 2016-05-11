HMPJSON ;SLC/KCM,ASMR/RRB - Decode/Encode JSON;9/25/2015 10:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Note:  Since the routines use closed array references, VVROOT and VVERR
 ;        are used to reduce risk of naming conflicts on the closed array.
 ;
DECODE(VVJSON,VVROOT,VVERR)  ; Set JSON object into closed array ref VVROOT
 ; Examples: D DECODE^HMPJSON("MYJSON","LOCALVAR","LOCALERR")
 ;           D DECODE^HMPJSON("^MYJSON(1)","^GLO(99)","^TMP($J)")
 ;
 ; VVJSON: string/array containing serialized JSON object
 ; VVROOT: closed array reference for M representation of object
 ;  VVERR: contains error messages, defaults to ^TMP("HMPJERR",$J)
 ;
 ;   VVIDX: points to next character in JSON string to process
 ; VVSTACK: manages stack of subscripts
 ;  VHMPOP: true if next string is property name, otherwise treat as value
 ;
 G DIRECT^HMPJSOND
 ;
ENCODE(VVROOT,VVJSON,VVERR) ; VVROOT (M structure) --> VVJSON (array of strings)
 ; Examples:  D ENCODE^HMPJSON("^GLO(99,2)","^TMP($J)")
 ;            D ENCODE^HMPJSON("LOCALVAR","MYJSON","LOCALERR")
 ;
 ; VVROOT: closed array reference for M representation of object
 ; VVJSON: destination variable for the string array formatted as JSON
 ;  VVERR: contains error messages, defaults to ^TMP("HMPJERR",$J)
 ;
 G DIRECT^HMPJSONE
 ;
 ;
ESC(X) ; Escape string for JSON
 Q $$ESC^HMPJSONE(X)
 ;
UES(X) ; Unescape JSON string
 Q $$UES^HMPJSOND(X)
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
 ;
 ; Encode Error Messages
 ;
 I ID="SOB" S ERRMSG="Unable to serialize node as object, value was "_VAL G XERRX
 I ID="SAR" S ERRMSG="Unable to serialize node as array, value was "_VAL G XERRX
 S ERRMSG="Unspecified error "_ID_" "_$G(VAL)
XERRX ; end switch
 S @VVERR@(0)=$G(@VVERR@(0))+1
 S @VVERR@(@VVERR@(0))=ERRMSG
 S VVERRORS=VVERRORS+1
 Q

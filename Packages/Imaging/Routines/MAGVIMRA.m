MAGVIMRA ;WOIFO/MAT,DWM,DAC - VISA Importer RA Utilities ; Dec 31, 2019@07:47:15
 ;;3.0;IMAGING;**138,164,252**;Mar 19, 2002;Build 5
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 Q
 ;+++++ Wrap calls to ALERT^RARTE7. IA #6006 (Private).
 ;
 ;  Called by XMCOMPLT^MAGVIM05 after exam status advanced to COMPLETE.
 ;
ALERT(RADFN,RADTI,RACNI,RAFIRST) ;
 N RAA1,RAA2,RANY1,RANY2,RARPT
 S RANY1=0
 S RANY2=$$ANYDX^RARTE7(.RAA2)
 S RARPT=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)
 D ALERT^RARTE7
 K RAAB
 Q
 ;--- Increment counter.
C() S C=C+1
 Q C
 ;+++++ Return STANDARD REPORTS file (#74.1) data w/ XML tags.
 ;
 ;   RPC: MAGV GET RAD STD RPTS
 ;
 ; Input
 ;
 ;  OUT        Array holding the results to return.
 ;
 ; Output
 ;
 ;  Array of XML tagged STANDARD REPORTS file (#74.1) data.
 ;
GETRADSR(OUT) ;
 N FILE S FILE=74.1
 N C S C=0
 ;--- Output standard XML header. IA #4153 (Supported).
 S OUT(C)=$$XMLHDR^MXMLUTL()
 N TAG0 S TAG0="ArrayOfStandardReport"
 S OUT($$C())=$$XMTAG(TAG0,0) D
 . ;
 . ;--- Read of ^RA(74.1,IEN, is IA #6004 (Private).
 . N TAG1 S TAG1="StandardReport"
 . N IEN
 . S IEN=0 F  S IEN=$O(^RA(FILE,IEN)) Q:IEN]"A"  D RADSR(TAG1,IEN)
 . Q
 S OUT($$C())=$$XMTAG(TAG0,1)
 Q
 ;+++++ Return DIAGNOSTIC CODE file (#78.3) data w/ XML tags.
 ;
 ;   RPC: MAGV GET RAD DX CODES
 ;
 ; Input
 ;
 ;  OUT        Array holding the results to return.
 ;
 ; Output
 ;
 ;  Array of XML tagged DIAGNOSTIC CODES file (#78.3) data.
 ;
GETRADDX(OUT) ; P252 DAC - Modified to exclude inactive RAD DX codes
 N FILE S FILE=78.3
 N C S C=0
 ;--- IA #3561 (Supported)
 S OUT(C)=$$XMLHDR^MXMLUTL()
 N TAG0 S TAG0="ArrayOfDiagnosticCode"
 S OUT($$C())=$$XMTAG(TAG0,0) D
 . ;
 . ;--- Read of ^RA(78.1,IEN, is IA #6005 (Private).
 . N TAG1 S TAG1="DiagnosticCode"
 . N IEN
 . S IEN=0 F  S IEN=$O(^RA(FILE,IEN)) Q:IEN]"A"  D
 .. Q:$$GET1^DIQ(FILE,IEN,5,"I")="Y"  ; exclude inactive codes <<
 .. D RADDX(TAG1,IEN)
 .. Q
 . Q
 S OUT($$C())=$$XMTAG(TAG0,1)
 Q
 ;+++++ Return IMAGING LOCATIONS file (#79.1) data w/ XML tags.
 ;
 ;   RPC: MAGV GET RAD DX CODES
 ;
 ; Input
 ;
 ;  OUT        Array holding the results to return.
 ;
 ; Output
 ;
 ;  Array of XML tagged IMAGING LOCATIONS file (#79.1) data.
 ;
 ;--- Drive output assembly for one IMAGING LOCATIONS file (#78.3) record.
GETRADLC(OUT) ;
 N FILE S FILE=79.1
 N C S C=0
 ;--- IA #3561 (Supported)
 S OUT(C)=$$XMLHDR^MXMLUTL()
 N TAG0 S TAG0="ArrayOfImagingLocation"
 S OUT($$C())=$$XMTAG(TAG0,0) D
 . ;
 . ;--- Read of ^RA(78.3,IEN, is IA #6007 (Private).
 . N TAG1 S TAG1="ImagingLocation"
 . N IEN,INACTIVE
 . S IEN=0 F  S IEN=$O(^RA(FILE,IEN)) Q:IEN]"A"  D
 .. S INACTIVE=$$GET1^DIQ(FILE,IEN,19,"I")  ;; p164 Check the location is active
 .. I (INACTIVE="")!(INACTIVE>$$DT^XLFDT) D RADLOC^MAGVIMRA(TAG1,IEN)
 .. Q
 . Q
 S OUT($$C())=$$XMTAG(TAG0,1)
 Q
 ;--- Drive output assembly for one DIAGNOSTIC CODES file (#78.3) record.
RADDX(TAG1,IEN) ;
 S OUT($$C())=$$XMTAG(TAG1,0) D
 . N STRING
 . S OUT($$C())=$$STRING("Id",IEN)
 . S STRING=$$GET1^DIQ(FILE,IEN,.01)
 . S OUT($$C())=$$STRING("Name",STRING)
 . S STRING=$$GET1^DIQ(FILE,IEN,2)
 . S OUT($$C())=$$STRING("Description",IEN)
 . Q
 S OUT($$C())=$$XMTAG(TAG1,1)
 Q
 ;--- Drive output assembly for one IMAGING LOCATIONS file (#79.1) record.
RADLOC(TAG1,IEN) ;
 S OUT($$C())=$$XMTAG(TAG1,0) D
 . N STRING
 . S OUT($$C())=$$STRING("Id",IEN)
 . S STRING=$$GET1^DIQ(FILE,IEN,.01)
 . S OUT($$C())=$$STRING("Name",STRING)
 . S STRING=$$GET1^DIQ(FILE,IEN,21)
 . S OUT($$C())=$$STRING("CreditMethod",STRING)
 . Q
 S OUT($$C())=$$XMTAG(TAG1,1)
 Q
 ;--- Drive output assembly for one STANDARD REPORT file (#78.1) record.
RADSR(TAG1,IEN) ;
 S OUT($$C())=$$XMTAG(TAG1,0) D
 . S OUT($$C())=$$STRING("Id",IEN)
 . S STRING=$$GET1^DIQ(FILE,IEN,.01)
 . S OUT($$C())=$$STRING("ReportName",STRING)
 . ;
 . ;--- Handle word-processing fields.
 . D WPTXT("ReportText",FILE,200,IEN)
 . D WPTXT("Impression",FILE,300,IEN)
 . Q
 S OUT($$C())=$$XMTAG(TAG1,1)
 Q
 ;--- Tag an input string.
STRING(TAG,STRING) ;
 N ITEM
 S ITEM=$$XMTAG(TAG,0)
 ;--- Translate embedded reserved XML symbols. IA #4153 (Supported).
 S ITEM=ITEM_$$SYMENC^MXMLUTL(STRING)
 S ITEM=ITEM_$$XMTAG(TAG,1)
 Q ITEM
 ;
 ;--- Tag a word processing field.
WPTXT(TAG,FILE,FIELD,IEN) ;
 S OUT($$C())=$$XMTAG(TAG,0)
 ;
 ;--- Word Processing Field
 K TXTERR,TXTWP
 N ITEM
 S ITEM=$$GET1^DIQ(FILE,IEN,FIELD,,"TXTWP","TXTERR")
 ;
 ;--- Translate embedded reserved XML symbols. IA #4153 (Supported).
 N NDX
 S NDX=0
 F  S NDX=$O(TXTWP(NDX)) Q:NDX=""  S OUT($$C())=$$SYMENC^MXMLUTL(TXTWP(NDX))
 S OUT($$C())=$$XMTAG(TAG,1)
 Q
 ;--- Enclose a tag.
XMTAG(TAG,END) ;
 S OUT="<"
 S:END OUT=OUT_"/"
 S OUT=OUT_TAG
 S OUT=OUT_">"
 Q OUT
 ;
 ; MAGVIMRA

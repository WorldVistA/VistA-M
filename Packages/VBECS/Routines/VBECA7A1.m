VBECA7A1 ;HOIFO/SAE - Workload API ; 9/30/04 5:49pm
 ;;2.0;VBECS;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; 
 QUIT
 ;
CHKERROR(VBECPRMS,VBRSLT,VBMT) ; check for error in results
 ;
 ; Input
 ;   VBECPRMS - array
 ;   VBRSLT   - name of ^TMP results global
 ;   VBMT     - name of message text global
 ; Output
 ;   VBMT     - message text global to build onto
 ;
 Q  ;RLM 07 08 10 Don't record errors.
 Q:$D(@VBMT@(" ERROR"))   ; an error has already been identified
 ;
 N VBX     ; temporary variable for holding text
 ;
 ; error where ^TMP results global is malformed where it looks like:
 ; ^TMP("VBECS_XML_RES",541084121,1) = ???<?xml version="1.0" ... etc.
 ; this error cannot be checked in STELE(not called in this situation)
 ;
 I $G(VBECPRMS("ERROR"))'=0 D  Q
 . S VBX=VBECPRMS("ERROR")_" returned by INITV~VBECRPCC"
 . S @VBMT@(" ERROR")="ERROR:  "_VBX
 I $D(@VBRSLT@("ERROR")) D  Q
 . S VBX=@VBRSLT@("ERROR")_" from PARSE~VBECRPC1 results global"
 . S @VBMT@(" ERROR")="ERROR:  "_VBX
 I $P($G(@VBRSLT@(1)),"<")?1."?" D  Q
 . S VBX="MALFORMED RESULTS GLOBAL from PARSE~VBECRPC1 results global"
 . S @VBMT@(" ERROR")="ERROR:  "_VBX
 Q
 ;
BLDERMSG(VBECPRMS,VBRSLT,VBMT) ;  build error message(s) into VBMT global
 ;
 Q  ;RLM 07 08 10 Don't record errors.
 ;
 N VBX       ; temporary variable for holding text
 N VBNM      ; indirect name of request/results array/global
 N VBNM2     ; copy of VBNM for different FOR loop
 N VBORIG    ; copy of VBNM with trailing parenthesis removed
 N VBDATA    ; data value from request/results node
 N VBLBL     ; label value comprised of $NA_VBDATA
 N VBSUB     ; subscript value for array node
 N VBOUT     ; full concatenated value of node to display
 N VBLCV     ; loop control variable for FOR loop
 N VBDONE    ; flag to signify 'done' with loop
 N VBBLANK   ; blank line of blank spaces
 N VBMAXDAT  ; maximum allowable length of array node data value
 N VBMAXLBL  ; maximum discovered length of array node label value
 N VBSPACES  ; calulated gap to format display to show data at column
 ;
 S VBX="Following are the request and results array(s)"
 I $D(@VBMT@("!INITIAL IEN"))#2=1 D
 . S VBX=VBX_" for IEN # "_$P(@VBMT@("!INITIAL IEN"),U,2)
 . S @VBMT@("#FOLLOWS MSG")=VBX
 S VBBLANK="                                                         "
 ;
 F VBNM="VBECPRMS",$NA(@VBRSLT) D
 . S VBNM2=VBNM,VBORIG=$P(VBNM,")")
 . S VBMAXLBL=1
 . F  S VBNM2=$Q(@VBNM2) Q:VBNM2=""  Q:$NA(@VBNM2)'[VBORIG  D
 . . S:VBORIG="VBECPRMS" VBLBL=$P($NA(@VBNM2),"(",2)
 . . S:VBORIG=$P($NA(@VBRSLT),")") VBLBL=$P($NA(@VBNM2),")")
 . . I VBORIG["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,")")
 . . I VBORIG'["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,"(",2)
 . . . S VBLBL=$P(VBLBL,$J)_$E(VBLBL,$F(VBLBL,$J)+1,$L(VBLBL))
 . . . S VBLBL=$TR(VBLBL,"""","'"),VBLBL="'"_$P(VBLBL,"XML_",2)
 . . S VBMAXLBL=$S($L(VBLBL)>VBMAXLBL:$L(VBLBL),1:VBMAXLBL)
 . S VBMAXLBL=$S(VBMAXLBL>30:30,1:VBMAXLBL+3)
 . S VBMAXDAT=80-VBMAXLBL-2
 . S VBORIG=$P(VBNM,")")
 . F  S VBNM=$Q(@VBNM) Q:VBNM=""  Q:$NA(@VBNM)'[VBORIG  D
 . . S VBLCV=0
 . . S VBSUB=$NA(@VBNM),VBSUB=$TR(VBSUB,"""","")
 . . S:VBORIG="VBECPRMS" VBLBL=$P($NA(@VBNM),"(",2)
 . . S:VBORIG=$P($NA(@VBRSLT),")") VBLBL=$P($NA(@VBNM),")")
 . . I VBORIG["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,")")
 . . I VBORIG'["VBECPRMS" D
 . . . S VBLBL=$P(VBLBL,"(",2)
 . . . S VBLBL=$P(VBLBL,$J)_$E(VBLBL,$F(VBLBL,$J)+1,$L(VBLBL))
 . . . S VBLBL=$TR(VBLBL,"""","'"),VBLBL="'"_$P(VBLBL,"XML_",2)
 . . S VBSPACES="",$P(VBSPACES," ",VBMAXLBL-$L(VBLBL))=""
 . . S VBSPACES=VBSPACES
 . . S VBDATA=$G(@VBNM)
 . . K VBDONE
 . . F VBLCV=0:1:25 D  Q:$D(VBDONE)
 . . . S VBSUB=$P(VBSUB,"||")
 . . . S VBSUB=VBSUB_"||"_VBLCV
 . . . S VBDATA(VBLCV)="  "_$E(VBDATA,1,VBMAXDAT)
 . . . S VBDATA=$E(VBDATA,VBMAXDAT+1,$L(VBDATA))
 . . . S:$L(VBDATA)'>0 VBDONE=1
 . . . I VBLCV<1 D  Q
 . . . . I $L(VBLBL)'>VBMAXLBL D  Q
 . . . . . S $P(VBSPACES," ",$L(VBLBL)-VBMAXLBL)=""
 . . . . . S VBLBL=VBLBL_VBSPACES
 . . . . . S VBOUT=VBLBL_VBDATA(VBLCV)
 . . . . . S @VBMT@(VBSUB)=VBOUT
 . . . . I $L(VBLBL)>VBMAXLBL D
 . . . . . S @VBMT@(VBSUB)=VBLBL
 . . . . . S VBSUB=VBSUB_"||"_VBLCV
 . . . . . S VBLBL=$E(VBBLANK,1,VBMAXLBL-1)
 . . . . . S VBOUT=VBLBL_VBDATA(VBLCV)
 . . . . . S VBSUB=$P(VBSUB,"||")
 . . . . . S VBLCV=VBLCV+1
 . . . . . S VBSUB=VBSUB_"||"_VBLCV
 . . . . . S @VBMT@(VBSUB)=VBOUT
 . . . I VBLCV>0 D
 . . . . S VBLBL=$E(VBBLANK,1,VBMAXLBL-1)
 . . . . S VBOUT=VBLBL_VBDATA(VBLCV)
 . . . . S @VBMT@(VBSUB)=VBOUT
 K VBDATA
 Q
 ;
STELE(ELE,ATR) ; Find attribute value
 ;
 ; Input
 ;   ELE - Element,         as defined in Document Type Descriptor
 ;   ATR - Attribute array, as defined in Document Type Descriptor
 ; Output
 ;   VBIEN    - Derived IEN of VBECS WORKLOAD CAPTURE (#6002.01) file
 ;   VBID     - TRANSACTION ID
 ;   VBIENERR - Error message from failure to $$FIND entry in file
 ;   VBMT     - Result array for mail text to be sent to mail group
 ;
 N VBIENI   ; initial IEN of this entry
 K VBIENERR
 N VBX      ; temporary variable for various uses
 N VBBEG    ; beginning character of text value in XML string
 N VBEND    ; ending character of text value in XML string
 N VBERMSG  ; error text message
 ;
 Q:$D(@VBMT@(" ERROR"))   ; an error has already been identified
 Q:$D(@VBRSLT@("ERROR"))  ; standard ^TMP "ERROR" - caught by CHKERROR
 ;
 I $L(ELE)'>0 D  Q
 . S VBX="ERROR: No ELEMENT received from parsing routine"
 . S @VBMT@(" ERROR")="ERROR:                "_VBX
 ;
 I ELE="WorkloadEvent" D
 . I '$D(ATR("successfullyUpdated")) D
 . . I $D(ATR("id")) D
 . . . S VBX=ATR("id")_U_ATR("id")
 . . . S @VBMT@("!TRANSACTION ID")="TRANSACTION ID:  "_VBX
 . . . S VBIEN=$$FIND1^DIC(6002.01,"","QX",ATR("id"),"","","VBIENERR")
 . . . I VBIEN?1.N,VBIEN>0 D
 . . . . S VBX=VBIEN_U_VBIEN
 . . . . S @VBMT@("!DERIVED IEN")="DERIVED IEN:  "_VBX
 . . . . S VBX="Successful FIND of VistA entry using VBECS txn ID"
 . . . . S @VBMT@("!SUCCESSFUL FIND")="SUCCESSFUL FIND:  "_VBX
 . . . I VBIEN=0!(VBIEN'?1.N.E)!$D(VBIENERR) D  Q
 . . . . S VBX="No VistA entry for Txn id "_ATR("id")_" was found"
 . . . . ;S @VBMT@(" ERROR")="ERROR:  "_VBX
 . . . I VBIEN=$P($G(@VBMT@("!INITIAL IEN")),U,2) D  Q
 . . . . S VBX="Successful match: initial lookup IEN and derived IEN"
 . . . . S @VBMT@("!IEN MATCH")="IENs match:  "_VBX
 . . . I VBIEN'=$P($G(@VBMT@("!INITIAL IEN")),U,2) D  Q
 . . . . S VBX="Mismatch between initial lookup IEN and derived IEN"
 . . . . ;S @VBMT@(" ERROR")="ERROR:  "_VBX
 . . I '$D(ATR("id")) D
 . . . S VBX="No Txn ID accompanied the successfullyUpdated attribute"
 . . . ;S @VBMT@(" ERROR")="ERROR:  "_VBX
 Q
 ;
ENELE(ELE) ; Ignore end of each element until end of WorkloadTransactions
 ;
 ; Input:
 ;   ELE  - element name from VBECS
 ;
 N VBMT      ; name of global containing mailman message text
 N VBTEXT    ; text from ErrorText element
 N VBTXNID   ; transaction id from @VBMT@("!TRANSACTION ID")
 N VBIEN     ; IEN of entry to update for failure edits
 N VBFDA     ; array for FILE^DIE
 N VBX       ; temporary variable for various uses
 N VBERRMSG  ; error message from FILE^DIE
 N VBLUERR   ; lookup error from $$FIND
 ;
 S VBMT=$NA(^TMP("VBECS_MAIL_TEXT",$J))
 ;
 Q:$D(@VBMT@(" ERROR"))  ; an error has already been identified
 ; Q:ELE'="WorkloadEvent"
 ;
 I '$D(@VBMT@("!VBECS ERRTXT")) D
 . I $D(@VBMT@("!DERIVED IEN")) D
 . . S DIK="^VBEC(6002.01,"
 . . S DA=$P(@VBMT@("!DERIVED IEN"),U,2)
 . . D ^DIK
 . . S VBX="VistA entry # "_DA_" was deleted."
 . . S @VBMT@("!VISTA UPDATE - ENTRY DELETED")=VBX
 . . K DA,DIC,DIK
 . I '$D(@VBMT@("!DERIVED IEN")) D
 . . S VBX="No VistA update attempted because no IEN was retrieved"
 . . S @VBMT@("!VISTA UPDATE - UPDATE NOT ATTEMPTED")=VBX
 ;
 I $D(@VBMT@("!VBECS ERRTXT")) D
 . I $D(@VBMT@("!DERIVED IEN")) D
 . . S VBIEN=$P(@VBMT@("!DERIVED IEN"),U,2)
 . . Q:VBIEN'?1.N
 . . S VBFDA(6002.01,VBIEN_",",5)="E"
 . . S VBFDA(6002.01,VBIEN_",",20)=$P(@VBMT@("!VBECS ERRTXT"),": ",2)
 . . D FILE^DIE("","VBFDA","VBERRMSG")
 . . I '$D(VBERRMSG) D
 . . . S VBX="Entry # "_VBIEN_" was updated"
 . . . S @VBMT@("!VISTA UPDATE - ENTRY UPDATED")=VBX
 . . I $D(VBERRMSG) D
 . . . S VBX=$G(VBERRMSG("DIERR",1,"TEXT",1))
 . . . ;S @VBMT@(" ERROR")="ERROR: "_VBX
 . . . S @VBMT@("!VISTA UPDATE - UPDATE FAILED")=VBX
 . I '$D(@VBMT@("!DERIVED IEN")) D
 . . S VBX="No VistA update for ERROR TEXT attempted (no IEN)"
 . . ;S @VBMT@(" ERROR")="ERROR: "_VBX
 . . S @VBMT@("!VISTA UPDATE NOT ATTEMPTED")=VBX
 Q
 ;
CHAR(TEXT) ;
 Q:$D(@VBMT@(" ERROR"))
 ;
 I XML["ErrorText" D
 . S @VBMT@("!VBECS ERRTXT")="VBECS ErrorText message: "_TEXT
 Q

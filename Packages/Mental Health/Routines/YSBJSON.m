YSBJSON ;SLC/DJE - Encode JSON ; Apr 01, 2021@16:33
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ; Dashboard version of JSON encoder
 ;
ENCODE(XUROOT,XUJSON,XUERR) ; XUROOT (M structure) --> XUJSON (array of strings)
 ;
 ; XUROOT: closed array reference for M representation of object
 ; XUJSON: destination variable for the string array formatted as JSON
 ;  XUERR: contains error messages, defaults to ^TMP("XLFJERR",$J)
 ;
 I '$L($G(XUROOT)) ; set error info
 I '$L($G(XUJSON)) ; set error info
 N XULINE,XUMAX,XUERRORS
 S XULINE=1,XUMAX=4000,XUERRORS=0  ; 96 more bytes of wiggle room
 S @XUJSON@(XULINE)=""
 D SEROBJ(XUROOT)
 Q
 ;
SEROBJ(XUROOT) ; Serialize into a JSON object
 N XUFIRST,XUSUB,XUNXT
 S @XUJSON@(XULINE)=@XUJSON@(XULINE)_"{"
 S XUFIRST=1
 S XUSUB="" F  S XUSUB=$O(@XUROOT@(XUSUB)) Q:XUSUB=""  D
 . S:'XUFIRST @XUJSON@(XULINE)=@XUJSON@(XULINE)_"," S XUFIRST=0
 . ; get the name part
 . D SERNAME(XUSUB)
 . ; if this is a value, serialize it
 . I $$ISVALUE(XUROOT,XUSUB) D SERVAL(XUROOT,XUSUB) Q
 . ; otherwise navigate to the next child object or array
 . I $D(@XUROOT@(XUSUB))=10 S XUNXT=$O(@XUROOT@(XUSUB,"")) D  Q
 . . I +XUNXT D SERARY($NA(@XUROOT@(XUSUB))) I 1
 . . E  D SEROBJ($NA(@XUROOT@(XUSUB)))
 . D ERRX("SOB",XUSUB)  ; should quit loop before here
 S @XUJSON@(XULINE)=@XUJSON@(XULINE)_"}"
 Q
SERARY(XUROOT) ; Serialize into a JSON array
 N XUFIRST,XUI,XUNXT
 S @XUJSON@(XULINE)=@XUJSON@(XULINE)_"["
 S XUFIRST=1
 S XUI=0 F  S XUI=$O(@XUROOT@(XUI)) Q:'XUI  D
 . S:'XUFIRST @XUJSON@(XULINE)=@XUJSON@(XULINE)_"," S XUFIRST=0
 . I $$ISVALUE(XUROOT,XUI) D SERVAL(XUROOT,XUI) Q  ; write value
 . I $D(@XUROOT@(XUI))=10 S XUNXT=$O(@XUROOT@(XUI,"")) D  Q
 . . I +XUNXT D SERARY($NA(@XUROOT@(XUI))) I 1
 . . E  D SEROBJ($NA(@XUROOT@(XUI)))
 . D ERRX("SAR",XUI)  ; should quit loop before here
 S @XUJSON@(XULINE)=@XUJSON@(XULINE)_"]"
 Q
SERNAME(XUSUB) ; Serialize the object name into JSON string
 I $E(XUSUB)="""" S XUSUB=$E(XUSUB,2,$L(XUSUB)) ; quote indicates numeric label
 I ($L(XUSUB)+$L(@XUJSON@(XULINE)))>XUMAX D
 .S XULINE=XULINE+1,@XUJSON@(XULINE)=""
 S @XUJSON@(XULINE)=@XUJSON@(XULINE)_""""_XUSUB_""""_":"
 Q
SERVAL(XUROOT,XUSUB) ; Serialize X into appropriate JSON representation
 N XUX,XUI,XUDONE
 ; if the node is already in JSON format, just add it
 I $D(@XUROOT@(XUSUB,":")) D  QUIT  ; <-- jump out here if preformatted
 . S XUX=$G(@XUROOT@(XUSUB,":")) D:$L(XUX) CONCAT
 . S XUI=0 F  S XUI=$O(@XUROOT@(XUSUB,":",XUI)) Q:'XUI  S XUX=@XUROOT@(XUSUB,":",XUI) D CONCAT
 ;
 S XUX=$G(@XUROOT@(XUSUB)),XUDONE=0
 ; handle the numeric, boolean, and null types
 I $D(@XUROOT@(XUSUB,"\n")) S:$L(@XUROOT@(XUSUB,"\n")) XUX=@XUROOT@(XUSUB,"\n") D CONCAT QUIT  ; when +X'=X
 I '$D(@XUROOT@(XUSUB,"\s")),$L(XUX) D  QUIT:XUDONE
 . I XUX']]$C(1) S XUX=$$JNUM(XUX) D CONCAT S XUDONE=1 QUIT
 . I XUX="true"!(XUX="false")!(XUX="null") D CONCAT S XUDONE=1 QUIT
 ; otherwise treat it as a string type
 S XUX=""""_$$ESC(XUX)_"""" D CONCAT    ; put in quotes
 Q
CONCAT ; come here to concatenate to JSON string
 I ($L(XUX)+$L(@XUJSON@(XULINE)))>XUMAX D
 .S XULINE=XULINE+1,@XUJSON@(XULINE)=""
 S @XUJSON@(XULINE)=@XUJSON@(XULINE)_XUX
 Q
ISVALUE(XUROOT,XUSUB) ; Return true if this is a value node
 I $D(@XUROOT@(XUSUB))#2 Q 1
 N XUX S XUX=$O(@XUROOT@(XUSUB,""))
 Q:XUX="\" 1  ; word processing continuation node
 Q:XUX=":" 1  ; pre-formatted JSON node
 Q 0
 ;
NUMERIC(X) ; Return true if the numeric
 I $L(X)>18 Q 0        ; string (too long for numeric)
 I X=0 Q 1             ; numeric (value is zero)
 I +X=0 Q 0            ; string
 I $E(X,1)="." Q 0     ; not a JSON number (although numeric in M)
 I $E(X,1,2)="-." Q 0  ; not a JSON number
 I +X=X Q 1            ; numeric
 I X?1"0."1.n Q 1      ; positive fraction
 I X?1"-0."1.N Q 1     ; negative fraction
 S X=$TR(X,"e","E")
 I X?.1"-"1.N.1".".N1"E".1"+"1.N Q 1  ; {-}99{.99}E{+}99
 I X?.1"-"1.N.1".".N1"E-"1.N Q 1      ; {-}99{.99}E-99
 Q 0
 ;
JNUM(N) ; Return JSON representation of a number
 I N'<1 Q N
 I N'>-1 Q N
 I N>0 Q "0"_N
 I N<0 Q "-0"_$P(N,"-",2,9)
 Q N
 ;
UCODE(C) ; Return \u00nn representation of decimal character value
 N H S H="0000"_$$CNV^XLFUTL(C,16)
 Q "\u"_$E(H,$L(H)-3,$L(H))
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
ESC(X) ; Escape string for JSON
 N Y,I,PAIR,FROM,TO
 S Y=X
 F PAIR="\\","""""","//",$C(8,98),$C(12,102),$C(10,110),$C(13,114),$C(9,116) D
 . S FROM=$E(PAIR),TO=$E(PAIR,2)
 . S X=Y,Y=$P(X,FROM) F I=2:1:$L(X,FROM) S Y=Y_"\"_TO_$P(X,FROM,I)
 I Y?.E1.C.E S X=Y,Y="" F I=1:1:$L(X) S FROM=$A(X,I) D
 . ; skip NUL character, otherwise encode ctrl-char
 . I FROM<32 Q:FROM=0  S Y=Y_$$UCODE(FROM) Q
 . I FROM>126,(FROM<160) S Y=Y_$$UCODE(FROM) Q
 . S Y=Y_$E(X,I)
 Q Y

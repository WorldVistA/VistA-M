XLFJSONE ;SLC/KCM/TJB - Encode JSON ;26 Oct 2016
 ;;8.0;KERNEL;**680**;Jul 10, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ENCODE(XUROOT,XUJSON,XUERR) ; XUROOT (M structure) --> XUJSON (array of strings)
 ;
DIRECT ; TAG for use by ENCODE^XLFJSON
 ;
 ; Examples:  D ENCODE^XLFJSON("^GLO(99,2)","^TMP($J)")
 ;            D ENCODE^XLFJSON("LOCALVAR","MYJSON","LOCALERR")
 ;
 ; XUROOT: closed array reference for M representation of object
 ; XUJSON: destination variable for the string array formatted as JSON
 ;  XUERR: contains error messages, defaults to ^TMP("XLFJERR",$J)
 ;
 S XUERR=$G(XUERR,"^TMP(""XLFJERR"",$J)")
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
 I ($L(XUSUB)+$L(@XUJSON@(XULINE)))>XUMAX S XULINE=XULINE+1,@XUJSON@(XULINE)=""
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
 S XUX=""""_$$ESC(XUX) ; open quote
 D CONCAT
 I $D(@XUROOT@(XUSUB,"\")) D  ; handle continuation nodes
 . S XUI=0 F  S XUI=$O(@XUROOT@(XUSUB,"\",XUI)) Q:'XUI   D
 . . S XUX=$$ESC(@XUROOT@(XUSUB,"\",XUI))
 . . D CONCAT
 S XUX="""" D CONCAT    ; close quote
 Q
CONCAT ; come here to concatenate to JSON string
 I ($L(XUX)+$L(@XUJSON@(XULINE)))>XUMAX S XULINE=XULINE+1,@XUJSON@(XULINE)=""
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
 D ERRX^XLFJSON(ID,$G(VAL))
 Q

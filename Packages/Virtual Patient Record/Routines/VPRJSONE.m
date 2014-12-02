VPRJSONE ;SLC/KCM -- Encode JSON
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;
ENCODE(VVROOT,VVJSON,VVERR) ; VVROOT (M structure) --> VVJSON (array of strings)
 ;
DIRECT ; TAG for use by ENCODE^VPRJSON
 ;
 ; Examples:  D ENCODE^VPRJSON("^GLO(99,2)","^TMP($J)")
 ;            D ENCODE^VPRJSON("LOCALVAR","MYJSON","LOCALERR")
 ;
 ; VVROOT: closed array reference for M representation of object
 ; VVJSON: destination variable for the string array formatted as JSON
 ;  VVERR: contains error messages, defaults to ^TMP("VPRJERR",$J)
 ;
 S VVERR=$G(VVERR,"^TMP(""VPRJERR"",$J)")
 I '$L($G(VVROOT)) ; set error info
 I '$L($G(VVJSON)) ; set error info
 N VVLINE,VVMAX,VVERRORS
 S VVLINE=1,VVMAX=4000,VVERRORS=0  ; 96 more bytes of wiggle room
 S @VVJSON@(VVLINE)=""
 D SEROBJ(VVROOT)
 Q
 ;
SEROBJ(VVROOT) ; Serialize into a JSON object
 N VVFIRST,VVSUB,VVNXT
 S @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_"{"
 S VVFIRST=1
 S VVSUB="" F  S VVSUB=$O(@VVROOT@(VVSUB)) Q:VVSUB=""  D
 . S:'VVFIRST @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_"," S VVFIRST=0
 . ; get the name part
 . D SERNAME(VVSUB)
 . ; if this is a value, serialize it
 . I $$ISVALUE(VVROOT,VVSUB) D SERVAL(VVROOT,VVSUB) Q
 . ; otherwise navigate to the next child object or array
 . I $D(@VVROOT@(VVSUB))=10 S VVNXT=$O(@VVROOT@(VVSUB,"")) D  Q
 . . I +VVNXT D SERARY($NA(@VVROOT@(VVSUB))) I 1
 . . E  D SEROBJ($NA(@VVROOT@(VVSUB)))
 . D ERRX("SOB",VVSUB)  ; should quit loop before here
 S @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_"}"
 Q
SERARY(VVROOT) ; Serialize into a JSON array
 N VVFIRST,VVI,VVNXT
 S @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_"["
 S VVFIRST=1
 S VVI=0 F  S VVI=$O(@VVROOT@(VVI)) Q:'VVI  D
 . S:'VVFIRST @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_"," S VVFIRST=0
 . I $$ISVALUE(VVROOT,VVI) D SERVAL(VVROOT,VVI) Q  ; write value
 . I $D(@VVROOT@(VVI))=10 S VVNXT=$O(@VVROOT@(VVI,"")) D  Q
 . . I +VVNXT D SERARY($NA(@VVROOT@(VVI))) I 1
 . . E  D SEROBJ($NA(@VVROOT@(VVI)))
 . D ERRX("SAR",VVI)  ; should quit loop before here
 S @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_"]"
 Q
SERNAME(VVSUB) ; Serialize the object name into JSON string
 I ($L(VVSUB)+$L(@VVJSON@(VVLINE)))>VVMAX S VVLINE=VVLINE+1,@VVJSON@(VVLINE)=""
 S @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_""""_VVSUB_""""_":"
 Q
SERVAL(VVROOT,VVSUB) ; Serialize X into appropriate JSON representation
 N VVX,VVI
 ; if the node is already in JSON format, just add it
 I $D(@VVROOT@(VVSUB,":")) D  QUIT  ; <-- jump out here if preformatted
 . S VVX=$G(@VVROOT@(VVSUB,":")) D:$L(VVX) CONCAT
 . S VVI=0 F  S VVI=$O(@VVROOT@(VVSUB,":",VVI)) Q:'VVI  S VVX=@VVROOT@(VVSUB,":",VVI) D CONCAT
 ;
 S VVX=$G(@VVROOT@(VVSUB))
 ; handle the numeric, boolean, and null types
 I '$D(@VVROOT@(VVSUB,"\s")),$$NUMERIC(VVX) D CONCAT QUIT
 I (VVX="true")!(VVX="false")!(VVX="null") D CONCAT QUIT
 ;I $E(vX)=$C(186) S vX=$E(vX,2,$L(vX)) ; remove the "string-forcing" char
 ; otherwise treat it as a string type
 S VVX=""""_$$ESC(VVX) ; open quote
 D CONCAT
 I $D(@VVROOT@(VVSUB,"\")) D  ; handle continuation nodes
 . S VVI=0 F  S VVI=$O(@VVROOT@(VVSUB,"\",VVI)) Q:'VVI   D
 . . S VVX=$$ESC(@VVROOT@(VVSUB,"\",VVI))
 . . D CONCAT
 S VVX="""" D CONCAT    ; close quote
 Q
CONCAT ; come here to concatenate to JSON string
 I ($L(VVX)+$L(@VVJSON@(VVLINE)))>VVMAX S VVLINE=VVLINE+1,@VVJSON@(VVLINE)=""
 S @VVJSON@(VVLINE)=@VVJSON@(VVLINE)_VVX
 Q
ISVALUE(VVROOT,VVSUB) ; Return true if this is a value node
 I $D(@VVROOT@(VVSUB))#2 Q 1
 N VVX S VVX=$O(@VVROOT@(VVSUB,""))
 Q:VVX="\" 1
 Q:VVX=":" 1
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
UCODE(C) ; Return \u00nn representation of decimal character value
 N H S H="0000"_$$CNV^XLFUTL(C,16)
 Q "\u"_$E(H,$L(H)-3,$L(H))
 ;
ERRX(ID,VAL) ; Set the appropriate error message
 D ERRX^VPRJSON(ID,$G(VAL))
 Q

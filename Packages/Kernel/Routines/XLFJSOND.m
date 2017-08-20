XLFJSOND ;SLC/KCM/TJB - Decode JSON ;26 Oct 2016
 ;;8.0;KERNEL;**680**;Jul 10, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
DECODE(XUJSON,XUROOT,XUERR) ; Set JSON object into closed array ref XUROOT
 ;
DIRECT ; TAG for use by DECODE^XLFJSON
 ;
 ; Examples: D DECODE^XLFJSON("MYJSON","LOCALVAR","LOCALERR")
 ;           D DECODE^XLFJSON("^MYJSON(1)","^GLO(99)","^TMP($J)")
 ;
 ; XUJSON: string/array containing serialized JSON object
 ; XUROOT: closed array reference for M representation of object
 ;  XUERR: contains error messages, defaults to ^TMP("XLFJERR",$J)
 ;
 ;   XUIDX: points to next character in JSON string to process
 ; XUSTACK: manages stack of subscripts
 ;  XUPROP: true if next string is property name, otherwise treat as value
 ;
 N XUMAX S XUMAX=4000 ; limit document lines to 4000 characters
 S XUERR=$G(XUERR,"^TMP(""XLFJERR"",$J)")
 ; If a simple string is passed in, move it to an temp array (XUINPUT)
 ; so that the processing is consistently on an array.
 I $D(@XUJSON)=1 N XUINPUT S XUINPUT(1)=@XUJSON,XUJSON="XUINPUT"
 S XUROOT=$NA(@XUROOT@("Z")),XUROOT=$E(XUROOT,1,$L(XUROOT)-4) ; make open array ref
 N XULINE,XUIDX,XUSTACK,XUPROP,XUVAL,XUTYPE,XUERRORS
 S XULINE=$O(@XUJSON@("")),XUIDX=1,XUSTACK=0,XUPROP=0,XUVAL=1,XUERRORS=0
 F  S XUTYPE=$$NXTKN() Q:XUTYPE=""  D  I XUERRORS Q
 . I XUVAL S XUVAL=0 I ("}],:"[XUTYPE) D ERRX("NOV",XUTYPE) Q  ; value was expected
 . I XUTYPE="{" S XUSTACK=XUSTACK+1,XUSTACK(XUSTACK)="",XUPROP=1 D:XUSTACK>64 ERRX("STL{") Q
 . I XUTYPE="}" D  QUIT
 . . I +XUSTACK(XUSTACK)=XUSTACK(XUSTACK),XUSTACK(XUSTACK) D ERRX("OBM") ; Numeric and true only
 . . S XUSTACK=XUSTACK-1 D:XUSTACK<0 ERRX("SUF}")
 . I XUTYPE="[" S XUSTACK=XUSTACK+1,XUSTACK(XUSTACK)=1 D:XUSTACK>64 ERRX("STL[") Q
 . I XUTYPE="]" D:'XUSTACK(XUSTACK) ERRX("ARM") S XUSTACK=XUSTACK-1 D:XUSTACK<0 ERRX("SUF]") Q
 . I XUTYPE="," D  Q
 . . I +XUSTACK(XUSTACK)=XUSTACK(XUSTACK),XUSTACK(XUSTACK) S XUSTACK(XUSTACK)=XUSTACK(XUSTACK)+1  ; VEN/SMH - next in array 
 . . E  S XUPROP=1                                   ; or next property name
 . I XUTYPE=":" S XUPROP=0,XUVAL=1 D:'$L($G(XUSTACK(XUSTACK))) ERRX("MPN") Q
 . I XUTYPE="""" D  Q
 . . I XUPROP S XUSTACK(XUSTACK)=$$NAMPARS() I 1
 . . E  D ADDSTR
 . S XUTYPE=$TR(XUTYPE,"TFN","tfn")
 . I XUTYPE="t" D SETBOOL("t") Q
 . I XUTYPE="f" D SETBOOL("f") Q
 . I XUTYPE="n" D SETBOOL("n") Q
 . I "0123456789+-.eE"[XUTYPE D SETNUM(XUTYPE) Q  ;S @$$CURNODE()=$$NUMPARS(XUTYPE) Q
 . D ERRX("TKN",XUTYPE)
 I XUSTACK'=0 D ERRX("SCT",XUSTACK)
 Q
NXTKN() ; Move the pointers to the beginning of the next token
 N XUDONE,XUEOF,XUTOKEN
 S XUDONE=0,XUEOF=0 F  D  Q:XUDONE!XUEOF  ; eat spaces & new lines until next visible char
 . I XUIDX>$L(@XUJSON@(XULINE)) S XULINE=$O(@XUJSON@(XULINE)),XUIDX=1 I 'XULINE S XUEOF=1 Q
 . I $A(@XUJSON@(XULINE),XUIDX)>32 S XUDONE=1 Q
 . S XUIDX=XUIDX+1
 Q:XUEOF ""  ; we're at the end of input
 S XUTOKEN=$E(@XUJSON@(XULINE),XUIDX),XUIDX=XUIDX+1
 Q XUTOKEN
 ;
ADDSTR ; Add string value to current node, escaping text along the way
 ; Expects XULINE,XUIDX to reference that starting point of the index
 ; TODO: add a mechanism to specify names that should not be escaped
 ;       just store as ":")= and ":",n)=
 ;
 ; Happy path -- we find the end quote in the same line
 N XUEND,XUX
 S XUEND=$F(@XUJSON@(XULINE),"""",XUIDX)
 I XUEND,($E(@XUJSON@(XULINE),XUEND-2)'="\") D SETSTR  QUIT  ;normal
 I XUEND,$$ISCLOSEQ(XULINE) D SETSTR QUIT  ;close quote preceded by escaped \
 ;
 ; Less happy path -- first quote wasn't close quote
 N XUDONE,XUTLINE
 S XUDONE=0,XUTLINE=XULINE ; XUTLINE for temporary increment of XULINE
 F  D  Q:XUDONE  Q:XUERRORS
 . ;if no quote on current line advance line, scan again
 . I 'XUEND S XUTLINE=XUTLINE+1,XUEND=1 I '$D(@XUJSON@(XUTLINE)) D ERRX("EIQ") Q
 . S XUEND=$F(@XUJSON@(XUTLINE),"""",XUEND)
 . Q:'XUEND  ; continue on to next line if no quote found on this one
 . I (XUEND>2),($E(@XUJSON@(XUTLINE),XUEND-2)'="\") S XUDONE=1 Q  ; found quote position
 . S XUDONE=$$ISCLOSEQ(XUTLINE) ; see if this is an escaped quote or closing quote
 Q:XUERRORS
 ; unescape from XUIDX to XUEND, using \-extension nodes as necessary
 D UESEXT
 ; now we need to move XULINE and XUIDX to next parsing point
 S XULINE=XUTLINE,XUIDX=XUEND
 Q
SETSTR ; Set simple string value from within same line
 ; expects XUJSON, XULINE, XUINX, XUEND
 N XUX
 S XUX=$E(@XUJSON@(XULINE),XUIDX,XUEND-2),XUIDX=XUEND
 S @$$CURNODE()=$$UES(XUX)
 ; "\s" node indicates value is really a string in case value 
 ;      collates as numeric or equals boolean keywords
 I XUX']]$C(1) S @$$CURNODE()@("\s")=""
 I XUX="true"!(XUX="false")!(XUX="null") S @$$CURNODE()@("\s")=""
 I XUIDX>$L(@XUJSON@(XULINE)) S XULINE=XULINE+1,XUIDX=1
 Q
UESEXT ; unescape from XULINE,XUIDX to XUTLINE,XUEND & extend (\) if necessary
 ; expects XULINE,XUIDX,XUTLINE,XUEND
 N XUI,XUY,XUSTART,XUSTOP,XUDONE,XUBUF,XUNODE,XUMORE,XUTO
 S XUNODE=$$CURNODE(),XUBUF="",XUMORE=0,XUSTOP=XUEND-2
 S XUI=XUIDX,XUY=XULINE,XUDONE=0
 F  D  Q:XUDONE  Q:XUERRORS
 . S XUSTART=XUI,XUI=$F(@XUJSON@(XUY),"\",XUI)
 . ; if we are on the last line, don't extract past XUSTOP
 . I (XUY=XUTLINE) S XUTO=$S('XUI:XUSTOP,XUI>XUSTOP:XUSTOP,1:XUI-2) I 1
 . E  S XUTO=$S('XUI:99999,1:XUI-2)
 . D ADDBUF($E(@XUJSON@(XUY),XUSTART,XUTO))
 . I (XUY'<XUTLINE),(('XUI)!(XUI>XUSTOP)) S XUDONE=1 QUIT  ; now past close quote
 . I 'XUI S XUY=XUY+1,XUI=1 QUIT  ; nothing escaped, go to next line
 . I XUI>$L(@XUJSON@(XUY)) S XUY=XUY+1,XUI=1 I '$D(@XUJSON@(XUY)) D ERRX("EIU")
 . N XUTGT S XUTGT=$E(@XUJSON@(XUY),XUI)
 . I XUTGT="u" D  I 1
 . . N XUTGTC S XUTGTC=$E(@XUJSON@(XUY),XUI+1,XUI+4),XUI=XUI+4
 . . I $L(XUTGTC)<4 S XUY=XUY+1,XUI=4-$L(XUTGTC),XUTGTC=XUTGTC_$E(@XUJSON@(XUY),1,XUI)
 . . D ADDBUF($C($$DEC^XLFUTL(XUTGTC,16)))
 . E  D ADDBUF($$REALCHAR(XUTGT))
 . S XUI=XUI+1
 . I (XUY'<XUTLINE),(XUI>XUSTOP) S XUDONE=1 ; XUI incremented past stop
 Q:XUERRORS
 D SAVEBUF
 Q
ADDBUF(XUX) ; add buffer of characters to destination
 ; expects XUBUF,XUMAX,XUNODE,XUMORE to be defined
 ; used directly by ADDSTR
 I $L(XUX)+$L(XUBUF)>XUMAX D SAVEBUF
 S XUBUF=XUBUF_XUX
 Q
SAVEBUF ; write out buffer to destination
 ; expects XUBUF,XUMAX,XUNODE,XUMORE to be defined
 ; used directly by ADDSTR,ADDBUF
 I XUMORE S @XUNODE@("\",XUMORE)=XUBUF
 I 'XUMORE S @XUNODE=XUBUF I $L(XUBUF)<19,+$E(XUBUF,1,18) S @XUNODE@("\s")=""
 S XUMORE=XUMORE+1,XUBUF=""
 Q
ISCLOSEQ(XUBLINE) ; return true if this is a closing, rather than escaped, quote
 ; expects
 ;   XUJSON: lines of the JSON encoded string
 ;    XUIDX: points to 1st character of the segment
 ;   XULINE: points to the line in which the segment starts
 ;    XUEND: points to 1st character after the " (may be past the end of the line)
 ; used directly by ADDSTR
 N XUBS,XUBIDX,XUBDONE
 S XUBS=0,XUBIDX=XUEND-2,XUBDONE=0 ; XUBIDX starts at 1st character before quote
 ; count the backslashes preceding the quote (odd number means the quote was escaped)
 F  D  Q:XUBDONE!XUERRORS
 . I XUBIDX<1 D  Q  ; when XUBIDX<1 go back a line
 . . S XUBLINE=XUBLINE-1 I XUBLINE<XULINE D ERRX("RSB") Q
 . . S XUBIDX=$L(@XUJSON@(XUBLINE))
 . I $E(@XUJSON@(XUBLINE),XUBIDX)'="\" S XUBDONE=1 Q
 . S XUBS=XUBS+1,XUBIDX=XUBIDX-1
 Q XUBS#2=0  ; XUBS is even if this is a close quote
 ;
NAMPARS() ; Return parsed name, advancing index past the close quote
 ; -- This assumes no embedded quotes are in the name itself --
 N XUEND,XUDONE,XUNAME
 S XUDONE=0,XUNAME=""
 F  D  Q:XUDONE  Q:XUERRORS
 . S XUEND=$F(@XUJSON@(XULINE),"""",XUIDX)
 . I XUEND S XUNAME=XUNAME_$E(@XUJSON@(XULINE),XUIDX,XUEND-2),XUIDX=XUEND,XUDONE=1
 . I 'XUEND S XUNAME=XUNAME_$E(@XUJSON@(XULINE),XUIDX,$L(@XUJSON@(XULINE)))
 . I 'XUEND!(XUEND>$L(@XUJSON@(XULINE))) S XULINE=XULINE+1,XUIDX=1 I '$D(@XUJSON@(XULINE)) D ERRX("ORN")
 ; prepend quote if label collates as numeric -- assumes no quotes in label
 I XUNAME']]$C(1) S XUNAME=""""""_XUNAME
 Q XUNAME
 ;
SETNUM(XUDIGIT) ; Set numeric along with any necessary modifier
 N XUX
 S XUX=$$NUMPARS(XUDIGIT)
 S @$$CURNODE()=+XUX
 ; if numeric is exponent, "0.nnn" or "-0.nnn" store original string
 I +XUX'=XUX S @$$CURNODE()@("\n")=XUX
 Q
NUMPARS(XUDIGIT) ; Return parsed number, advancing index past end of number
 ; XUIDX intially references the second digit
 N XUDONE,XUNUM
 S XUDONE=0,XUNUM=XUDIGIT
 F  D  Q:XUDONE  Q:XUERRORS
 . I '("0123456789+-.eE"[$E(@XUJSON@(XULINE),XUIDX)) S XUDONE=1 Q
 . S XUNUM=XUNUM_$E(@XUJSON@(XULINE),XUIDX)
 . S XUIDX=XUIDX+1 I XUIDX>$L(@XUJSON@(XULINE)) S XULINE=XULINE+1,XUIDX=1 I '$D(@XUJSON@(XULINE)) D ERRX("OR#")
 Q XUNUM
 ;
SETBOOL(XULTR) ; Parse and set boolean value, advancing index past end of value
 N XUDONE,XUBOOL,XUX
 S XUDONE=0,XUBOOL=XULTR
 F  D  Q:XUDONE  Q:XUERRORS
 . S XUX=$TR($E(@XUJSON@(XULINE),XUIDX),"TRUEFALSN","truefalsn")
 . I '("truefalsn"[XUX) S XUDONE=1 Q
 . S XUBOOL=XUBOOL_XUX
 . S XUIDX=XUIDX+1 I XUIDX>$L(@XUJSON@(XULINE)) S XULINE=XULINE+1,XUIDX=1 I '$D(@XUJSON@(XULINE)) D ERRX("ORB")
 I XULTR="t",(XUBOOL'="true") D ERRX("EXT",XUTYPE)
 I XULTR="f",(XUBOOL'="false") D ERRX("EXF",XUTYPE)
 I XULTR="n",(XUBOOL'="null") D ERRX("EXN",XUTYPE)
 S @$$CURNODE()=XUBOOL
 Q
 ;
OSETBOOL(XUX) ; set a value and increment XUIDX
 S @$$CURNODE()=XUX
 S XUIDX=XUIDX+$L(XUX)-1
 N XUDIFF S XUDIFF=XUIDX-$L(@XUJSON@(XULINE))  ; in case XUIDX moves to next line
 I XUDIFF>0 S XULINE=XULINE+1,XUIDX=XUDIFF I '$D(@XUJSON@(XULINE)) D ERRX("ORB")
 Q
CURNODE() ; Return a global/local variable name based on XUSTACK
 ; Expects XUSTACK to be defined already
 N XUI,XUSUBS
 S XUSUBS=""
 F XUI=1:1:XUSTACK S:XUI>1 XUSUBS=XUSUBS_"," D
 . I XUSTACK(XUI)=+XUSTACK(XUI) S XUSUBS=XUSUBS_XUSTACK(XUI) ; VEN/SMH Fix psudo array bug.
 . E  S XUSUBS=XUSUBS_""""_XUSTACK(XUI)_""""
 Q XUROOT_XUSUBS_")"
 ;
UES(X) ; Unescape JSON string
 ; copy segments from START to POS-2 (right before \)
 ; translate target character (which is at $F position)
 N POS,Y,START
 S POS=0,Y=""
 F  S START=POS+1 D  Q:START>$L(X)
 . S POS=$F(X,"\",START) ; find next position
 . I 'POS S Y=Y_$E(X,START,$L(X)),POS=$L(X) Q
 . ; otherwise handle escaped char
 . N TGT
 . S TGT=$E(X,POS),Y=Y_$E(X,START,POS-2)
 . I TGT="u" S Y=Y_$C($$DEC^XLFUTL($E(X,POS+1,POS+4),16)),POS=POS+4 Q
 . S Y=Y_$$REALCHAR(TGT)
 Q Y
 ;
REALCHAR(C) ; Return actual character from escaped
 I C="""" Q """"
 I C="/" Q "/"
 I C="\" Q "\"
 I C="b" Q $C(8)
 I C="f" Q $C(12)
 I C="n" Q $C(10)
 I C="r" Q $C(13)
 I C="t" Q $C(9)
 I C="u" ;case covered above in $$DEC^XLFUTL calls
 ;otherwise
 I $L($G(XUERR)) D ERRX("ESC",C)
 Q C
 ;
ERRX(ID,VAL) ; Set the appropriate error message
 D ERRX^XLFJSON(ID,$G(VAL))
 Q

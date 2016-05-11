HMPJSOND ;SLC/KCM,ASMR/RRB - Decode JSON;9/25/2015 10:16
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
DECODE(VVJSON,VVROOT,VVERR) ; Set JSON object into closed array ref VVROOT
 ;
DIRECT ; TAG for use by DECODE^HMPJSON
 ;
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
 N VVMAX S VVMAX=4000 ; limit document lines to 4000 characters
 S VVERR=$G(VVERR,"^TMP(""HMPJERR"",$J)")
 ; If a simple string is passed in, move it to an temp array (VVINPUT)
 ; so that the processing is consistently on an array.
 I $D(@VVJSON)=1 N VVINPUT S VVINPUT(1)=@VVJSON,VVJSON="VVINPUT"
 S VVROOT=$NA(@VVROOT@("Z")),VVROOT=$E(VVROOT,1,$L(VVROOT)-4) ; make open array ref
 N VVLINE,VVIDX,VVSTACK,VHMPOP,VVTYPE,VVERRORS
 S VVLINE=$O(@VVJSON@("")),VVIDX=1,VVSTACK=0,VHMPOP=0,VVERRORS=0
 F  S VVTYPE=$$NXTKN() Q:VVTYPE=""  D  I VVERRORS Q
 . I VVTYPE="{" S VVSTACK=VVSTACK+1,VVSTACK(VVSTACK)="",VHMPOP=1 D:VVSTACK>64 ERRX("STL{") Q
 . I VVTYPE="}" D  QUIT
 . . I +VVSTACK(VVSTACK)=VVSTACK(VVSTACK),VVSTACK(VVSTACK) D ERRX("OBM") ; Numeric and true only
 . . S VVSTACK=VVSTACK-1 D:VVSTACK<0 ERRX("SUF}")
 . I VVTYPE="[" S VVSTACK=VVSTACK+1,VVSTACK(VVSTACK)=1 D:VVSTACK>64 ERRX("STL[") Q
 . I VVTYPE="]" D:'VVSTACK(VVSTACK) ERRX("ARM") S VVSTACK=VVSTACK-1 D:VVSTACK<0 ERRX("SUF]") Q
 . I VVTYPE="," D  Q
 . . I +VVSTACK(VVSTACK)=VVSTACK(VVSTACK),VVSTACK(VVSTACK) S VVSTACK(VVSTACK)=VVSTACK(VVSTACK)+1  ; VEN/SMH - next in array 
 . . E  S VHMPOP=1                                   ; or next property name
 . I VVTYPE=":" S VHMPOP=0 D:'$L($G(VVSTACK(VVSTACK))) ERRX("MPN") Q
 . I VVTYPE="""" D  Q
 . . I VHMPOP S VVSTACK(VVSTACK)=$$NAMPARS() I 1
 . . E  D ADDSTR
 . S VVTYPE=$TR(VVTYPE,"TFN","tfn")
 . I VVTYPE="t" D SETBOOL("t") Q
 . I VVTYPE="f" D SETBOOL("f") Q
 . I VVTYPE="n" D SETBOOL("n") Q
 . I "0123456789+-.eE"[VVTYPE D SETNUM(VVTYPE) Q  ;S @$$CURNODE()=$$NUMPARS(VVTYPE) Q
 . D ERRX("TKN",VVTYPE)
 I VVSTACK'=0 D ERRX("SCT",VVSTACK)
 Q
NXTKN() ; Move the pointers to the beginning of the next token
 N VVDONE,VVEOF,VVTOKEN
 S VVDONE=0,VVEOF=0 F  D  Q:VVDONE!VVEOF  ; eat spaces & new lines until next visible char
 . I VVIDX>$L(@VVJSON@(VVLINE)) S VVLINE=$O(@VVJSON@(VVLINE)),VVIDX=1 I 'VVLINE S VVEOF=1 Q
 . I $A(@VVJSON@(VVLINE),VVIDX)>32 S VVDONE=1 Q
 . S VVIDX=VVIDX+1
 Q:VVEOF ""  ; we're at the end of input
 S VVTOKEN=$E(@VVJSON@(VVLINE),VVIDX),VVIDX=VVIDX+1
 Q VVTOKEN
 ;
ADDSTR ; Add string value to current node, escaping text along the way
 ; Expects VVLINE,VVIDX to reference that starting point of the index
 ; TODO: add a mechanism to specify names that should not be escaped
 ;       just store as ":")= and ":",n)=
 ;
 ; Happy path -- we find the end quote in the same line
 N VVEND,VVX
 S VVEND=$F(@VVJSON@(VVLINE),"""",VVIDX)
 I VVEND,($E(@VVJSON@(VVLINE),VVEND-2)'="\") D SETSTR  QUIT  ;normal
 I VVEND,$$ISCLOSEQ(VVLINE) D SETSTR QUIT  ;close quote preceded by escaped \
 ;
 ; Less happy path -- first quote wasn't close quote
 N VVDONE,VVTLINE
 S VVDONE=0,VVTLINE=VVLINE ; VVTLINE for temporary increment of VVLINE
 F  D  Q:VVDONE  Q:VVERRORS
 . ;if no quote on current line advance line, scan again
 . I 'VVEND S VVTLINE=VVTLINE+1,VVEND=1 I '$D(@VVJSON@(VVTLINE)) D ERRX("EIQ") Q
 . S VVEND=$F(@VVJSON@(VVTLINE),"""",VVEND)
 . Q:'VVEND  ; continue on to next line if no quote found on this one
 . I (VVEND>2),($E(@VVJSON@(VVTLINE),VVEND-2)'="\") S VVDONE=1 Q  ; found quote position
 . S VVDONE=$$ISCLOSEQ(VVTLINE) ; see if this is an escaped quote or closing quote
 Q:VVERRORS
 ; unescape from VVIDX to VVEND, using \-extension nodes as necessary
 D UESEXT
 ; now we need to move VVLINE and VVIDX to next parsing point
 S VVLINE=VVTLINE,VVIDX=VVEND
 Q
SETSTR ; Set simple string value from within same line
 ; expects VVJSON, VVLINE, VVINX, VVEND
 N VVX
 S VVX=$E(@VVJSON@(VVLINE),VVIDX,VVEND-2),VVIDX=VVEND
 S @$$CURNODE()=$$UES(VVX)
 ; "\s" node indicates value is really a string in case value 
 ;      collates as numeric or equals boolean keywords
 I VVX']]$C(1) S @$$CURNODE()@("\s")=""
 I VVX="true"!(VVX="false")!(VVX="null") S @$$CURNODE()@("\s")=""
 I VVIDX>$L(@VVJSON@(VVLINE)) S VVLINE=VVLINE+1,VVIDX=1
 Q
UESEXT ; unescape from VVLINE,VVIDX to VVTLINE,VVEND & extend (\) if necessary
 ; expects VVLINE,VVIDX,VVTLINE,VVEND
 N VVI,VVY,VVSTART,VVSTOP,VVDONE,VVBUF,VVNODE,VVMORE,VVTO
 S VVNODE=$$CURNODE(),VVBUF="",VVMORE=0,VVSTOP=VVEND-2
 S VVI=VVIDX,VVY=VVLINE,VVDONE=0
 F  D  Q:VVDONE  Q:VVERRORS
 . S VVSTART=VVI,VVI=$F(@VVJSON@(VVY),"\",VVI)
 . ; if we are on the last line, don't extract past VVSTOP
 . I (VVY=VVTLINE) S VVTO=$S('VVI:VVSTOP,VVI>VVSTOP:VVSTOP,1:VVI-2) I 1
 . E  S VVTO=$S('VVI:99999,1:VVI-2)
 . D ADDBUF($E(@VVJSON@(VVY),VVSTART,VVTO))
 . I (VVY'<VVTLINE),(('VVI)!(VVI>VVSTOP)) S VVDONE=1 QUIT  ; now past close quote
 . I 'VVI S VVY=VVY+1,VVI=1 QUIT  ; nothing escaped, go to next line
 . I VVI>$L(@VVJSON@(VVY)) S VVY=VVY+1,VVI=1 I '$D(@VVJSON@(VVY)) D ERRX("EIU")
 . N VVTGT S VVTGT=$E(@VVJSON@(VVY),VVI)
 . I VVTGT="u" D  I 1
 . . N VVTGTC S VVTGTC=$E(@VVJSON@(VVY),VVI+1,VVI+4),VVI=VVI+4
 . . I $L(VVTGTC)<4 S VVY=VVY+1,VVI=4-$L(VVTGTC),VVTGTC=VVTGTC_$E(@VVJSON@(VVY),1,VVI)
 . . D ADDBUF($C($$DEC^XLFUTL(VVTGTC,16)))
 . E  D ADDBUF($$REALCHAR(VVTGT))
 . S VVI=VVI+1
 . I (VVY'<VVTLINE),(VVI>VVSTOP) S VVDONE=1 ; VVI incremented past stop
 Q:VVERRORS
 D SAVEBUF
 Q
ADDBUF(VVX) ; add buffer of characters to destination
 ; expects VVBUF,VVMAX,VVNODE,VVMORE to be defined
 ; used directly by ADDSTR
 I $L(VVX)+$L(VVBUF)>VVMAX D SAVEBUF
 S VVBUF=VVBUF_VVX
 Q
SAVEBUF ; write out buffer to destination
 ; expects VVBUF,VVMAX,VVNODE,VVMORE to be defined
 ; used directly by ADDSTR,ADDBUF
 I VVMORE S @VVNODE@("\",VVMORE)=VVBUF
 I 'VVMORE S @VVNODE=VVBUF I $L(VVBUF)<19,+$E(VVBUF,1,18) S @VVNODE@("\s")=""
 S VVMORE=VVMORE+1,VVBUF=""
 Q
ISCLOSEQ(VVBLINE) ; return true if this is a closing, rather than escaped, quote
 ; expects
 ;   VVJSON: lines of the JSON encoded string
 ;    VVIDX: points to 1st character of the segment
 ;   VVLINE: points to the line in which the segment starts
 ;    VVEND: points to 1st character after the " (may be past the end of the line)
 ; used directly by ADDSTR
 N VVBS,VVBIDX,VVBDONE
 S VVBS=0,VVBIDX=VVEND-2,VVBDONE=0 ; VVBIDX starts at 1st character before quote
 ; count the backslashes preceding the quote (odd number means the quote was escaped)
 F  D  Q:VVBDONE!VVERRORS
 . I VVBIDX<1 D  Q  ; when VVBIDX<1 go back a line
 . . S VVBLINE=VVBLINE-1 I VVBLINE<VVLINE D ERRX("RSB") Q
 . . S VVBIDX=$L(@VVJSON@(VVBLINE))
 . I $E(@VVJSON@(VVBLINE),VVBIDX)'="\" S VVBDONE=1 Q
 . S VVBS=VVBS+1,VVBIDX=VVBIDX-1
 Q VVBS#2=0  ; VVBS is even if this is a close quote
 ;
NAMPARS() ; Return parsed name, advancing index past the close quote
 ; -- This assumes no embedded quotes are in the name itself --
 N VVEND,VVDONE,VVNAME
 S VVDONE=0,VVNAME=""
 F  D  Q:VVDONE  Q:VVERRORS
 . S VVEND=$F(@VVJSON@(VVLINE),"""",VVIDX)
 . I VVEND S VVNAME=VVNAME_$E(@VVJSON@(VVLINE),VVIDX,VVEND-2),VVIDX=VVEND,VVDONE=1
 . I 'VVEND S VVNAME=VVNAME_$E(@VVJSON@(VVLINE),VVIDX,$L(@VVJSON@(VVLINE)))
 . I 'VVEND!(VVEND>$L(@VVJSON@(VVLINE))) S VVLINE=VVLINE+1,VVIDX=1 I '$D(@VVJSON@(VVLINE)) D ERRX("ORN")
 ; prepend quote if label collates as numeric -- assumes no quotes in label
 I VVNAME']]$C(1) S VVNAME=""""""_VVNAME
 Q VVNAME
 ;
SETNUM(VVDIGIT) ; Set numeric along with any necessary modifier
 N VVX
 S VVX=$$NUMPARS(VVDIGIT)
 S @$$CURNODE()=+VVX
 ; if numeric is exponent, "0.nnn" or "-0.nnn" store original string
 I +VVX'=VVX S @$$CURNODE()@("\n")=VVX
 Q
NUMPARS(VVDIGIT) ; Return parsed number, advancing index past end of number
 ; VVIDX initially references the second digit
 N VVDONE,VVNUM
 S VVDONE=0,VVNUM=VVDIGIT
 F  D  Q:VVDONE  Q:VVERRORS
 . I '("0123456789+-.eE"[$E(@VVJSON@(VVLINE),VVIDX)) S VVDONE=1 Q
 . S VVNUM=VVNUM_$E(@VVJSON@(VVLINE),VVIDX)
 . S VVIDX=VVIDX+1 I VVIDX>$L(@VVJSON@(VVLINE)) S VVLINE=VVLINE+1,VVIDX=1 I '$D(@VVJSON@(VVLINE)) D ERRX("OR#")
 Q VVNUM
 ;
SETBOOL(VVLTR) ; Parse and set boolean value, advancing index past end of value
 N VVDONE,VVBOOL,VVX
 S VVDONE=0,VVBOOL=VVLTR
 F  D  Q:VVDONE  Q:VVERRORS
 . S VVX=$TR($E(@VVJSON@(VVLINE),VVIDX),"TRUEFALSN","truefalsn")
 . I '("truefalsn"[VVX) S VVDONE=1 Q
 . S VVBOOL=VVBOOL_VVX
 . S VVIDX=VVIDX+1 I VVIDX>$L(@VVJSON@(VVLINE)) S VVLINE=VVLINE+1,VVIDX=1 I '$D(@VVJSON@(VVLINE)) D ERRX("ORB")
 I VVLTR="t",(VVBOOL'="true") D ERRX("EXT",VVTYPE)
 I VVLTR="f",(VVBOOL'="false") D ERRX("EXF",VVTYPE)
 I VVLTR="n",(VVBOOL'="null") D ERRX("EXN",VVTYPE)
 S @$$CURNODE()=VVBOOL
 Q
 ;
OSETBOOL(VVX) ; set a value and increment VVIDX
 S @$$CURNODE()=VVX
 S VVIDX=VVIDX+$L(VVX)-1
 N VVDIFF S VVDIFF=VVIDX-$L(@VVJSON@(VVLINE))  ; in case VVIDX moves to next line
 I VVDIFF>0 S VVLINE=VVLINE+1,VVIDX=VVDIFF I '$D(@VVJSON@(VVLINE)) D ERRX("ORB")
 Q
CURNODE() ; Return a global/local variable name based on VVSTACK
 ; Expects VVSTACK to be defined already
 N VVI,VVSUBS
 S VVSUBS=""
 F VVI=1:1:VVSTACK S:VVI>1 VVSUBS=VVSUBS_"," D
 . I VVSTACK(VVI)=+VVSTACK(VVI) S VVSUBS=VVSUBS_VVSTACK(VVI) ; VEN/SMH Fix pseudo array bug.
 . E  S VVSUBS=VVSUBS_""""_VVSTACK(VVI)_""""
 Q VVROOT_VVSUBS_")"
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
 I $L($G(VVERR)) D ERRX("ESC",C)
 Q C
 ;
ERRX(ID,VAL) ; Set the appropriate error message
 D ERRX^HMPJSON(ID,$G(VAL))
 Q

XTHC10A ;HCIOFO/SG - HTTP 1.0 CLIENT (TOOLS) ;12/07/09  16:05
 ;;7.3;TOOLKIT;**123**;Apr 25, 1995;Build 4
 ;
 Q
 ;
 ;+++++ APPENDS RECEIVED PIECE OF DATA TO THE DESTINATION BUFFER
 ;
 ; BUF           Received data
 ;
 ; [NEWLINE]     Start a new line after appending the data
 ;
 ; The XT8BUF, XT8DST, XT8IS, XT8MBL, XT8PTR, and XT8SL
 ; variables must be properly initialized before calling this
 ; procedure (see the $$RECEIVE^XTHC10A for details).
 ;
APPEND(BUF,NEWLINE) ;
 N BASE,L
 S L=$L(BUF)  S:$A(BUF,L)=13 L=L-1
 ;--- Append the data
 I L'<XT8SL  D
 . S XT8BUF=XT8BUF_$E(BUF,1,XT8SL),L=L-XT8SL
 . S BASE=1
 . F  D  Q:L'>0
 . . I 'XT8IS  S @XT8DST@(XT8PTR)=XT8BUF
 . . E  S @XT8DST@(XT8PTR,XT8IS)=XT8BUF
 . . S BASE=BASE+XT8SL,XT8IS=XT8IS+1,XT8SL=XT8MBL
 . . S XT8BUF=$E(BUF,BASE,BASE+XT8SL-1),L=L-XT8SL
 . S XT8SL=-L
 E  S XT8BUF=XT8BUF_$E(BUF,1,L),XT8SL=XT8SL-L
 ;--- Flush the buffer and start a new line
 I $G(NEWLINE)  D  S XT8BUF="",XT8IS=0,XT8PTR=XT8PTR+1,XT8SL=XT8MBL
 . I 'XT8IS  S @XT8DST@(XT8PTR)=XT8BUF  Q
 . S @XT8DST@(XT8PTR,XT8IS)=XT8BUF
 Q
 ;
 ;+++++ CALCULATES NUMBER OF BYTES IN THE MESSAGE BODY
 ;
 ; XT8DATA       Closed root of a variable containing body
 ;               of the message
 ;
 ; NLS           Length of the line terminator(s)
 ;
DATASIZE(XT8DATA,NLS) ;
 N I,J,SIZE
 S SIZE=0,I=""
 F  S I=$O(@XT8DATA@(I))  Q:I=""  D  S SIZE=SIZE+NLS
 . S SIZE=SIZE+$L($G(@XT8DATA@(I)))
 . S J=""
 . F  S J=$O(@XT8DATA@(I,J))  Q:J=""  D
 . . S SIZE=SIZE+$L($G(@XT8DATA@(I,J)))
 Q $S(SIZE>0:SIZE-NLS,1:0)
 ;
 ;+++++ PROCESSES THE HTTP HEADER
 ;
 ; .XT8H         Reference to a local array containing
 ;               the raw header data
 ;
 ; .XT8HDR       Reference to a local variable where the parsed
 ;               header will be returned
 ;
 ; Return values:
 ;           <0  Error Descriptor (see the $$ERROR^XTERROR)
 ;           >0  HTTP Status Code^Description
 ;
HEADER(XT8H,XT8HDR) ;
 N BUF,I,NAME,TAB,TMP
 S XT8HDR=$$NORMSTAT($G(XT8H(1))),TAB=$C(9)
 F I=2:1  S BUF=$TR($G(XT8H(I)),TAB," ")  Q:BUF=""  D
 . ;--- Continuation of the previous header line
 . I $E(BUF,1)=" "  D:$G(NAME)'=""  Q
 . . S TMP=$$TRIM^XLFSTR(BUF)
 . . S:TMP'="" XT8HDR(NAME)=XT8HDR(NAME)_" "_TMP
 . ;--- New header line
 . S NAME=$$UP^XLFSTR($$TRIM^XLFSTR($P(BUF,":")))
 . S:NAME'="" XT8HDR(NAME)=$$TRIM^XLFSTR($P(BUF,":",2,999))
 Q $P(XT8HDR," ",2)_U_$P(XT8HDR," ",3,999)
 ;
 ;+++++ NORMALIZES THE HTTP STATUS LINE
NORMSTAT(STATUS) ;
 N I,J1,J2,TMP
 ;--- Remove leading and trailing spaces
 S STATUS=$$TRIM^XLFSTR(STATUS)
 ;--- Replace groups of consecutive spaces with single spaces
 S J2=1
 F I=1,2  D  Q:'J1
 . S J1=$F(STATUS," ",J2)  Q:'J1
 . F J2=J1:1  Q:$E(STATUS,J2)'=" "
 . S $E(STATUS,J1,J2-1)=""
 ;--- Return normalized status line
 Q STATUS
 ;
 ;+++++ RECEIVES AN HTTP RESPONSE
 ;
 ; TIMEOUT       Timeout value (in seconds) for TCP/IP input.
 ;
 ; [XT8DATA]     Closed root of the variable where the message
 ;               body is returned. See the $$GETURL^XTHC10
 ;               for details.
 ;
 ; [.XT8HDR]     Reference to a local variable where the parsed
 ;               headers will be returned. See the $$GETURL^XTHC10
 ;               for details.
 ;
RECEIVE(TIMEOUT,XT8DATA,XT8HDR) ;
 ;
 ; XT8BUF        Work buffer where the current line is being built
 ;
 ; XT8DST        Closed root of the current destination buffer used
 ;               by the APPEND^XTHC10A
 ;
 ; XT8H          Temporary buffer for the raw HTTP header
 ;
 ; XT8IS         Subscript of the current continuation sub-node in
 ;               the destination buffer (if 0 then the current main
 ;               node is used)
 ;
 ; XT8MBL        Maximum buffer length
 ;
 ; XT8PTR        Subscript of the current node in the dest. buffer
 ;
 ; XT8SL         Number of available bytes in the current (sub)node
 ;
 N $ESTACK,$ETRAP,BLCHS,BUF,EXIT,I1,I2,MBL,RTO,STATUS,TMP,X,XT8BUF,XT8DST,XT8H,XT8IS,XT8MBL,XT8PTR,XT8SL
 S BLCHS=$C(9,10,12,13)_" ",XT8MBL=245
 K:$G(XT8DATA)'="" @XT8DATA  K XT8HDR
 S XT8BUF="",XT8IS=0,XT8PTR=1,XT8SL=XT8MBL
 ;
 ;=== Setup the error processing
 ;S X="RCVERR^XTHC10A",@^%ZOSF("TRAP"),$ETRAP=""
 S $ET="D RCVERR^XTHC10A"
 ;
 ;=== Receive the header (until the first empty line)
 U IO
 S XT8DST="XT8H",(EXIT,RTO)=0
 ;F  R BUF#XT8MBL:TIMEOUT  S RTO='$T  D  Q:EXIT!RTO
 F  R BUF#XT8MBL:TIMEOUT  S RTO='$T  D  Q:EXIT!RTO
 . S I1=1
 . F  S I2=$F(BUF,$C(10),I1)  Q:'I2  D  Q:EXIT
 . . S TMP=$E(BUF,I1,I2-2)  D APPEND(TMP,1)  S I1=I2
 . . S:$TR(TMP,BLCHS)="" EXIT=1
 . D:'EXIT APPEND($E(BUF,I1,XT8MBL))
 ;--- A header must end with an empty line.
 ;--- Otherwise, there was a timeout.
 Q:'EXIT $$ERROR^XTHC10(-7)
 ;--- Remove ending of the header from the buffer. The buffer
 ;--- can contain beginning of the message body.
 S:I1>1 $E(BUF,1,I1-1)=""
 ;--- Process the header
 S STATUS=$$HEADER(.XT8H,.XT8HDR)
 ;
 ;=== Receive the message body
 D:$G(XT8DATA)'=""
 . N CNTLEN,RDLEN
 . S RDLEN=XT8MBL
 . ;--- Check for Content-Length header
 . I $D(XT8HDR("CONTENT-LENGTH"))  D  Q:CNTLEN'>0
 . . S CNTLEN=+XT8HDR("CONTENT-LENGTH")
 . . S:CNTLEN<XT8MBL RDLEN=CNTLEN
 . E  S CNTLEN=-1
 . ;--- Read the content
 . S XT8DST=XT8DATA,RTO=0
 . F  D  Q:'CNTLEN!RTO  R BUF#RDLEN:TIMEOUT  S RTO='$T
 . . D:CNTLEN>0
 . . . S CNTLEN=CNTLEN-$L(BUF)  S:CNTLEN<0 CNTLEN=0
 . . . S:CNTLEN<RDLEN RDLEN=CNTLEN
 . . S I1=1
 . . F  S I2=$F(BUF,$C(10),I1)  Q:'I2  D
 . . . D APPEND($E(BUF,I1,I2-2),1)  S I1=I2
 . . D APPEND($E(BUF,I1,XT8MBL))
 ;
 ;=== Flush the buffers and process the header (only if necessary)
RCVERR U IO(0)
 D APPEND("",1)
 S:$G(STATUS)="" STATUS=$$HEADER(.XT8H,.XT8HDR)
 I $L($EC) S $ECODE="" S $ETRAP="D UNW^%ZTER Q:$QUIT STATUS Q  " S $ECODE=",U1,"
 Q STATUS
 ;
 ;
 ;+++++ SENDS THE HTTP REQUEST
 ;
 ; URI           Request URI
 ;
 ; [XT8DATA]     Closed root of a variable containing body of the
 ;               request message. If this parameter is defined, not
 ;               empty, and the referenced variable is defined then
 ;               the POST request is generated. Otherwise, the GET
 ;               request is sent.
 ;
 ; [.XT8HDR]     Reference to a local variable containing header
 ;               values
 ;
 ; Return values:
 ;           <0  Error Code^Description
 ;        "GET"  Ok
 ;       "POST"  Ok
 ;
REQUEST(URI,XT8DATA,XT8HDR) ;
 N CRLF,DFLTHDR,I,J,STATUS
 S CRLF=$C(13,10)
 ;
 ;=== Check for default header(s)
 S DFLTHDR("CONTENT-LENGTH")=""
 S DFLTHDR("CONTENT-TYPE")=""
 S DFLTHDR("USER-AGENT")=""
 S I=""
 F  S I=$O(XT8HDR(I))  Q:I=""  K DFLTHDR($$UP^XLFSTR(I))
 S:$D(DFLTHDR("USER-AGENT")) XT8HDR("User-Agent")="VistA/1.0"
 ;
 ;=== Send the request
 U IO
 I $G(XT8DATA)'="",$D(@XT8DATA)>1  S STATUS="POST"  D
 . S:$D(DFLTHDR("CONTENT-TYPE")) XT8HDR("Content-Type")="text/html"
 . D:$D(DFLTHDR("CONTENT-LENGTH"))
 . . S XT8HDR("Content-Length")=$$DATASIZE(XT8DATA,$L(CRLF))
 . W "POST "_URI_" HTTP/1.0",CRLF,!
 . ;--- Header
 . S I=""
 . F  S I=$O(XT8HDR(I))  Q:I=""  W I_": "_XT8HDR(I),CRLF,!
 . ;--- Body
 . S I=""
 . F  S I=$O(@XT8DATA@(I))  Q:I=""  D
 . . W CRLF,$G(@XT8DATA@(I)),!
 . . S J=""
 . . F  S J=$O(@XT8DATA@(I,J))  Q:J=""  W $G(@XT8DATA@(I,J)),!
 E  S STATUS="GET"  D
 . W "GET "_URI_" HTTP/1.0",CRLF,!
 . S I=""
 . F  S I=$O(XT8HDR(I))  Q:I=""  W I_": "_XT8HDR(I),CRLF,!
 . W CRLF,!
 ;U $P
 Q STATUS

ONCX10A ;HCIOFO/SG - HTTP 1.0 CLIENT (TOOLS) ; 8/11/04 8:26am
 ;;2.11;ONCOLOGY;**40,41**;Mar 07, 1995
 ;
 Q
 ;
 ;***** APPENDS RECEIVED PIECE OF DATA TO THE DESTINATION BUFFER
 ;
 ; BUF           Received data
 ;
 ; [NEWLINE]     Start a new line after appending the data
 ;
 ; The ONC8BUF, ONC8DST, ONC8IS, ONC8MBL, ONC8PTR, and ONC8SL
 ; variables must be properly initialized before calling this
 ; procedure (see the $$RECEIVE^ONCX10A for details).
 ;
APPEND(BUF,NEWLINE) ;
 N BASE,L
 S L=$L(BUF)  S:$A(BUF,L)=13 L=L-1
 ;--- Append the data
 I L'<ONC8SL  D
 . S ONC8BUF=ONC8BUF_$E(BUF,1,ONC8SL),L=L-ONC8SL
 . S BASE=1
 . F  D  Q:L'>0
 . . I 'ONC8IS  S @ONC8DST@(ONC8PTR)=ONC8BUF
 . . E  S @ONC8DST@(ONC8PTR,ONC8IS)=ONC8BUF
 . . S BASE=BASE+ONC8SL,ONC8IS=ONC8IS+1,ONC8SL=ONC8MBL
 . . S ONC8BUF=$E(BUF,BASE,BASE+ONC8SL-1),L=L-ONC8SL
 . S ONC8SL=-L
 E  S ONC8BUF=ONC8BUF_$E(BUF,1,L),ONC8SL=ONC8SL-L
 ;--- Flush the buffer and start a new line
 I $G(NEWLINE)  D  S ONC8BUF="",ONC8IS=0,ONC8PTR=ONC8PTR+1,ONC8SL=ONC8MBL
 . I 'ONC8IS  S @ONC8DST@(ONC8PTR)=ONC8BUF  Q
 . S @ONC8DST@(ONC8PTR,ONC8IS)=ONC8BUF
 Q
 ;
 ;***** CALCULATES NUMBER OF BYTES IN THE MESSAGE BODY
 ;
 ; ONC8DATA      Closed root of a variable containing body
 ;               of the message
 ;
 ; NLS           Length of the line terminator(s)
 ;
DATASIZE(ONC8DATA,NLS) ;
 N SIZE
 S SIZE=0
 F  S I=$O(@ONC8DATA@(I))  Q:I=""  D  S SIZE=SIZE+NLS
 . S SIZE=SIZE+$L($G(@ONC8DATA@(I)))
 . S J=""
 . F  S J=$O(@ONC8DATA@(I,J))  Q:J=""  D
 . . S SIZE=SIZE+$L($G(@ONC8DATA@(I,J)))
 Q $S(SIZE>0:SIZE-NLS,1:0)
 ;
 ;***** PROCESSES THE HTTP HEADER
 ;
 ; .ONC8H        Reference to a local array containing
 ;               the raw header data
 ;
 ; .ONC8HDR      Reference to a local variable where the parsed
 ;               header will be returned
 ;
 ; Return values:
 ;       <0  Error Descriptor
 ;       >0  HTTP Status Code^Description
 ;
HEADER(ONC8H,ONC8HDR) ;
 N BUF,I,NAME,TAB,TMP
 S ONC8HDR=$$NORMSTAT($G(ONC8H(1))),TAB=$C(9)
 F I=2:1  S BUF=$TR($G(ONC8H(I)),TAB," ")  Q:BUF=""  D
 . ;--- Continuation of the previous header line
 . I $E(BUF,1)=" "  D:$G(NAME)'=""  Q
 . . S TMP=$$TRIM^XLFSTR(BUF)
 . . S:TMP'="" ONC8HDR(NAME)=ONC8HDR(NAME)_" "_TMP
 . ;--- New header line
 . S NAME=$$UP^XLFSTR($$TRIM^XLFSTR($P(BUF,":")))
 . S:NAME'="" ONC8HDR(NAME)=$$TRIM^XLFSTR($P(BUF,":",2,999))
 Q $P(ONC8HDR," ",2)_U_$P(ONC8HDR," ",3,999)
 ;
 ;***** NORMALIZES THE HTTP STATUS LINE
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
 ;***** RECEIVES AN HTTP RESPONSE
 ;
 ; TIMEOUT       Timeout value (in seconds) for TCPIP input.
 ;
 ; [ONC8DATA]    Closed root of the variable where the message
 ;               body is returned. See the $$GETURL^ONCX10
 ;               for details.
 ;
 ; [.ONC8HDR]    Reference to a local variable where the parsed
 ;               headers will be returned. See the $$GETURL^ONCX10
 ;               for details.
 ;
RECEIVE(TIMEOUT,ONC8DATA,ONC8HDR) ;
 ; ONC8BUF       Work buffer where the current line is being built
 ; ONC8DST       Closed root of the current destination buffer used
 ;               by the APPEND^ONCX10A
 ; ONC8H         Temporary buffer for the raw HTTP header
 ; ONC8IS        Subscript of the current continuation sub-node in
 ;               the destination buffer (if 0 then the current main
 ;               node is used)
 ; ONC8MBL       Maximum buffer length
 ; ONC8PTR       Subscript of the current node in the dest. buffer
 ; ONC8SL        Number of available bytes in the current (sub)node
 ;
 N $ESTACK,$ETRAP,BLCHS,BUF,EXIT,I1,I2,MBL,ONC8BUF,ONC8DST,ONC8H,ONC8IS,ONC8MBL,ONC8PTR,ONC8SL,RTO,STATUS,TMP,X
 S BLCHS=$C(9,10,12,13)_" ",ONC8MBL=245
 K:$G(ONC8DATA)'="" @ONC8DATA  K ONC8HDR
 S ONC8BUF="",ONC8IS=0,ONC8PTR=1,ONC8SL=ONC8MBL
 ;--- Setup the error processing
 S X="RCVERR^ONCX10A",@^%ZOSF("TRAP"),$ETRAP=""
 ;--- Receive the header (until the first empty line)
 U IO
 S ONC8DST="ONC8H",(EXIT,RTO)=0
 F  R BUF#ONC8MBL:TIMEOUT  S RTO='$T  D  Q:EXIT!RTO
 . S I1=1
 . F  S I2=$F(BUF,$C(10),I1)  Q:'I2  D  Q:EXIT
 . . S TMP=$E(BUF,I1,I2-2)  D APPEND(TMP,1)  S I1=I2
 . . S:$TR(TMP,BLCHS)="" EXIT=1
 . D:'EXIT APPEND($E(BUF,I1,ONC8MBL))
 ;--- A header must end with an empty line.
 ;--- Otherwise, there was a timeout.
 Q:'EXIT $$ERROR^ONCXERR(-7)
 ;--- Remove ending of the header from the buffer. The buffer
 ;--- can contain beginning of the message body.
 S:I1>1 $E(BUF,1,I1-1)=""
 ;--- Process the header
 S STATUS=$$HEADER(.ONC8H,.ONC8HDR)
 ;--- Receive the message body
 D:$G(ONC8DATA)'=""
 . N CNTLEN,RDLEN
 . S RDLEN=ONC8MBL
 . ;--- Check for Content-Length header
 . I $D(ONC8HDR("CONTENT-LENGTH"))  D  Q:CNTLEN'>0
 . . S CNTLEN=+ONC8HDR("CONTENT-LENGTH")
 . . S:CNTLEN<ONC8MBL RDLEN=CNTLEN
 . E  S CNTLEN=-1
 . ;--- Read the content
 . S ONC8DST=ONC8DATA,RTO=0
 . F  D  Q:'CNTLEN!RTO  R BUF#RDLEN:TIMEOUT  S RTO='$T
 . . D:CNTLEN>0
 . . . S CNTLEN=CNTLEN-$L(BUF)  S:CNTLEN<0 CNTLEN=0
 . . . S:CNTLEN<RDLEN RDLEN=CNTLEN
 . . S I1=1
 . . F  S I2=$F(BUF,$C(10),I1)  Q:'I2  D
 . . . D APPEND($E(BUF,I1,I2-2),1)  S I1=I2
 . . D APPEND($E(BUF,I1,ONC8MBL))
 ;--- Flush the buffers and process the header (only if necessary)
RCVERR U $P
 D APPEND("",1)
 S:$G(STATUS)="" STATUS=$$HEADER(.ONC8H,.ONC8HDR)
 Q STATUS
 ;
 ;***** SENDS THE HTTP REQUEST
 ;
 ; URI           Request URI
 ;
 ; [ONC8DATA]    Closed root of a variable containing body of the
 ;               request message. If this parameter is defined, not
 ;               empty, and the referenced variable is defined then
 ;               the POST request is generated. Otherwise, the GET
 ;               request is sent.
 ;
 ; [.ONC8HDR]    Reference to a local variable containing header
 ;               values
 ;
 ; Return values:
 ;       <0  Error Code^Description
 ;    "GET"  Ok
 ;   "POST"  Ok
 ;
REQUEST(URI,ONC8DATA,ONC8HDR) ;
 N CRLF,DFLTHDR,I,J,STATUS
 S CRLF=$C(13,10)
 ;--- Check for default header(s)
 S DFLTHDR("CONTENT-LENGTH")=""
 S DFLTHDR("CONTENT-TYPE")=""
 S DFLTHDR("USER-AGENT")=""
 S I=""
 F  S I=$O(ONC8HDR(I))  Q:I=""  K DFLTHDR($$UP^XLFSTR(I))
 S:$D(DFLTHDR("USER-AGENT")) ONC8HDR("User-Agent")="VistA/1.0"
 ;--- Send the request
 U IO
 I $G(ONC8DATA)'="",$D(@ONC8DATA)>1  S STATUS="POST"  D
 . S:$D(DFLTHDR("CONTENT-TYPE")) ONC8HDR("Content-Type")="text/html"
 . D:$D(DFLTHDR("CONTENT-LENGTH"))
 . . S ONC8HDR("Content-Length")=$$DATASIZE(ONC8DATA,$L(CRLF))
 . W "POST "_URI_" HTTP/1.0",CRLF,!
 . ;--- Header
 . S I=""
 . F  S I=$O(ONC8HDR(I))  Q:I=""  W I_": "_ONC8HDR(I),CRLF,!
 . ;--- Body
 . S I=""
 . F  S I=$O(@ONC8DATA@(I))  Q:I=""  D
 . . W CRLF,$G(@ONC8DATA@(I)),!
 . . S J=""
 . . F  S J=$O(@ONC8DATA@(I,J))  Q:J=""  W $G(@ONC8DATA@(I,J)),!
 E  S STATUS="GET"  D
 . W "GET "_URI_" HTTP/1.0",CRLF,!
 . S I=""
 . F  S I=$O(ONC8HDR(I))  Q:I=""  W I_": "_ONC8HDR(I),CRLF,!
 . W CRLF,!
 U $P
 Q STATUS

XTHC10 ;HCIOFO/SG - HTTP 1.1 CLIENT ; 12/5/18 8:45pm
 ;;7.3;TOOLKIT;**123,566,10002**;Apr 25, 1995;Build 1
 ; *10002 Changes: TLS Support by Sam Habiel (c) 2018
 ; passim changes
 ;
 Q
 ;##### GETS THE DATA FROM THE PROVIDED URL USING HTTP 1.1
 ;
 ; URL           URL (http://host:port/path)
 ;
 ; [XT8FLG]      (Optional) Timeout and flags to control processing.
 ;               If a value of this parameter starts with a number
 ;               then this number is used as a value of the timeout
 ;               (in seconds). Otherwise, the default value of 5
 ;               seconds is used.
 ;
 ; [XT8RDAT]     (Optional) Closed root of the variable where the message
 ;               body is returned. Data is stored in consecutive
 ;               nodes (numbers starting from 1). If a line is
 ;               longer than 245 characters, only 245 characters
 ;               are stored in the corresponding node. After that,
 ;               overflow sub-nodes are created. For example:
 ;
 ;                 @XT8DATA@(1)="<html>"
 ;                 @XT8DATA@(2)="<head><title>VistA</title></head>"
 ;                 @XT8DATA@(3)="<body>"
 ;                 @XT8DATA@(4)="<p>"
 ;                 @XT8DATA@(5)="Beginning of a very long line"
 ;                 @XT8DATA@(5,1)="Continuation #1 of the long line"
 ;                 @XT8DATA@(5,2)="Continuation #2 of the long line"
 ;                 @XT8DATA@(5,...)=...
 ;                 @XT8DATA@(6)="</p>"
 ;                 ...
 ;
 ; [.XT8RHDR]    (Optional) Reference to a local variable where the parsed
 ;               headers are returned. Header names are converted to
 ;               upper case and the values are left "as is". The root
 ;               node contains the status line. For example:
 ;
 ;                 XT8HDR="HTTP/1.1 200 OK"
 ;                 XT8HDR("ACCEPT-RANGES")="bytes"
 ;                 XT8HDR("CONNECTION")="close"
 ;                 XT8HDR("CONTENT-LENGTH")="16402"
 ;                 XT8HDR("CONTENT-TYPE")="text/html; charset=UTF-8"
 ;                 XT8HDR("DATE")="Thu, 25 Jun 2015 14:43:01 GMT"
 ;                 XT8HDR("ETAG")="a93a2-4012-5180156550680"
 ;                 XT8HDR("LAST-MODIFIED")="Mon, 08 Jun 2015 13:08:26 GMT"
 ;                 XT8HDR("SERVER")="Apache/2.2.15 (CentOS)"
 ;
 ; [XT8SDAT]     (Optional) Reference to a local variable containing the
 ;               request message body. Data should be formatted as in
 ;               variable XT8RDAT above.
 ;
 ; [.XT8SHDR]    (Optional) Reference to a local variable containing header
 ;               values, which will be added to the request.
 ;                 XT8SHDR("CONTENT-TYPE")="text/html"
 ;
 ; [XT8METH]     (Optional) Flag to indicate the request method.
 ;                    "GET"     - Default if XT8SDAT contains no data
 ;                    "POST"    - Default if XT8SDAT contains data
 ;                    "HEAD"
 ;                    "PUT"
 ;                    "OPTIONS"
 ;                    "DELETE"
 ;                    "TRACE"
 ;
 ; Return values:
 ;
 ;           <0  Error Descriptor
 ;           >0  HTTP Status Code^Description
 ;
 ;    Common HTTP status codes returned:
 ;          200  OK
 ;          301  Moved Permanently
 ;          400  Bad Request
 ;          401  Unauthorized
 ;          402  Payment Required
 ;          403  Forbidden
 ;          404  Not Found
 ;          405  Method Not Allowd
 ;          406  Not Acceptable
 ;          407  Proxy Authentication Required
 ;          408  Request Time-out
 ;          500  Internal Server Error
 ;          501  Not Implemented
 ;          502  Bad Gateway
 ;          503  Service Unavailable
 ;          504  Gateway Time-out
 ;          505  HTTP Version not supported
 ;
 ; See: www.ietf.org/rfc/rfc2616.txt (HTTP/1.1)
 ;      www.ieft.org/rfc/rfc2617.txt (HTTP Authentication)
 ;
INIT(AUTOCLOSE) ;
 ; Supply Autoclose if you want the code to automatically close the connection
 K ^TMP("XTHC10",$J)
 I ^%ZOSF("OS")["GT.M" D &libcurl.init
 I ^%ZOSF("OS")["OpenM" S XT8REQUEST=##class(%Net.HttpRequest).%New()
 S ^TMP("XTHC10",$J)=AUTOCLOSE
 QUIT
 ;
CLEANUP ;
 I ^%ZOSF("OS")["GT.M" D &libcurl.cleanup
 I ^%ZOSF("OS")["OpenM" K XT8REQUEST
 K ^TMP("XTHC10",$J)
 QUIT
 ;
GETURL(URL,XT8FLG,XT8RDAT,XT8RHDR,XT8SDAT,XT8SHDR,XT8METH) ;IA# 5553
 ;ZEXCEPT: %Net,%New,ContentType,HttpRequest,Https,Location,OpenTimeout,Port,Server,SSLCheckServerIdentity,SSLConfiguration,class   ; Cache ObjectScript methods and properties
 ;ZEXCEPT: Data,Get,GetHeader,GetNextHeader,Head,HttpResponse,Post,Put,ReadLine,ReasonPhrase,Send,SocketTimeout,StatusCode,StatusLine    ; Cache ObjectScript methods and properties
 ;ZEXCEPT: XT8REQUEST
 N EOL,ERR,ESTATUS,HOST,I,J,K,NEWLINE,PATH,PORT,RESPONSE,STATUS,X,Y
 S XT8FLG=$G(XT8FLG)  S:XT8FLG'?1.N.E XT8FLG="5"_XT8FLG
 ;
 ;Check IO
 I '$D(IO(0)) D HOME^%ZIS
 S STATUS=0
 ;
 I '$D(^TMP("XTHC10",$J)) D INIT(1)
 I ^%ZOSF("OS")["GT.M" G GTM
 ;
CACHE ;
 S I=$$PARSEURL^XTHCURL(URL,.HOST,.PORT,.PATH)  Q:I<0 I
 I $G(PORT)>0 S XT8REQUEST.Port=PORT ;Set port here, reset to 443 if https
 I $$UP^XLFSTR($E(URL,1,8))["HTTPS://" D
 . S XT8REQUEST.Https=1
 . S XT8REQUEST.SSLCheckServerIdentity=0
 . S XT8REQUEST.SSLConfiguration="encrypt_only"
 . I $G(PORT)=80 S XT8REQUEST.Port=443 ;If default http port, reset to default https
 S XT8REQUEST.Server=HOST
 I $G(PATH)'="" S XT8REQUEST.Location=PATH
 S XT8REQUEST.ContentType="text/html"
 S XT8REQUEST.OpenTimeout=+XT8FLG
 S XT8REQUEST.SocketTimeout=0
 ;Set custom headers
 D XT8REQUEST.SetHeader("User-Agent","VistA/2.0")
 S I=""
 F  S I=$O(XT8SHDR(I))  Q:I=""  D XT8REQUEST.SetHeader(I,XT8SHDR(I))
 ; "GET"
 I $G(XT8METH)="GET" D
 . S ESTATUS=XT8REQUEST.Get()
 ; "POST"
 I $G(XT8METH)="POST" D
 . S I=""
 . F  S I=$O(@XT8SDAT@(I))  Q:I=""  D  ;load an entire page, not just key/value pairs
 . . S NEWLINE=$G(@XT8SDAT@(I))
 . . S J=""
 . . F  S J=$O(@XT8SDAT@(I,J))  Q:J=""  S NEWLINE=NEWLINE_$G(@XT8SDAT@(I,J))
 . . D XT8REQUEST.EntityBody.WriteLine(NEWLINE)
 . S ESTATUS=XT8REQUEST.Post()
 ; "HEAD"
 I $G(XT8METH)="HEAD" D
 . S ESTATUS=XT8REQUEST.Head()
 ; "PUT"
 I $G(XT8METH)="PUT" D
 . S I=""
 . F  S I=$O(@XT8SDAT@(I))  Q:I=""  D  ;load an entire page, not just key/value pairs
 . . S NEWLINE=$G(@XT8SDAT@(I))
 . . S J=""
 . . F  S J=$O(@XT8SDAT@(I,J))  Q:J=""  S NEWLINE=NEWLINE_$G(@XT8SDAT@(I,J))
 . . D XT8REQUEST.EntityBody.WriteLine(NEWLINE)
 . S ESTATUS=XT8REQUEST.Put()
 ; "OPTIONS" "DELETE" "TRACE"
 I $D(XT8METH) D
 . F  S I=$O(@XT8SDAT@(I))  Q:I=""  D  ;load an entire page, not just key/value pairs
 . . S NEWLINE=$G(@XT8SDAT@(I))
 . . S J=""
 . . F  S J=$O(@XT8SDAT@(I,J))  Q:J=""  S NEWLINE=NEWLINE_$G(@XT8SDAT@(I,J))
 . . D XT8REQUEST.EntityBody.WriteLine(NEWLINE)
 . S ESTATUS=XT8REQUEST.Send($G(XT8METH))
 ;Defaults if XT8METH is not defined
 ;If XT8SDAT has data, then do POST method, otherwise GET
 I $D(XT8SDAT)>0 D
 . S I=""
 . F  S I=$O(@XT8SDAT@(I))  Q:I=""  D  ;load an entire page, not just key/value pairs
 . . S NEWLINE=$G(@XT8SDAT@(I))
 . . S J=""
 . . F  S J=$O(@XT8SDAT@(I,J))  Q:J=""  S NEWLINE=NEWLINE_$G(@XT8SDAT@(I,J))
 . . D XT8REQUEST.EntityBody.WriteLine(NEWLINE)
 . S ESTATUS=XT8REQUEST.Post()
 E  D
 . S ESTATUS=XT8REQUEST.Get()
 I 'ESTATUS D $system.Status.DecomposeStatus(ESTATUS,.ERR) Q "-1^"_ERR(1)  ;Q if errors
 ;
 S RESPONSE=XT8REQUEST.HttpResponse ;Sets the %Net.HttpResponse object
 S STATUS=RESPONSE.StatusCode_"^"_RESPONSE.ReasonPhrase
 ;--- Header - Enter header into XT8RHDR
 S XT8RHDR=RESPONSE.StatusLine
 S I=""
 F  D  Q:I=""
 . S I=RESPONSE.GetNextHeader(I) Q:I=""  ;Name of header
 . S XT8RHDR(I)=RESPONSE.GetHeader(I)    ;Value of header I
 ;--- Data - Read stream one line at a time and enter into XT8RDAT
 F J=1:1 D  Q:(RESPONSE.Data.AtEnd)!(+STATUS=-1)  ;quit if at end of data stream or error
 . S ESTATUS="" ;Status object
 . S X=RESPONSE.Data.ReadLine(,.ESTATUS,.EOL)
 . I 'ESTATUS D
 . . D $system.Status.DecomposeStatus(ESTATUS,.ERR) S STATUS="-1^"_ERR(1)  ;Q if errors
 . E  I $D(XT8RDAT)>0 D
 . . S @XT8RDAT@(J)=$E(X,1,245)  ;first 245 chars into parent node (J)
 . . I $L(X)>245 D               ;append remaining chars into child nodes (J,K), 245 chars at a time
 . . . F K=1:1:($L(X)\245) D
 . . . S Y=$E(X,(K*245)+1,(K*245)+245) Q:Y=""
 . . . S @XT8RDAT@(J,K)=Y
 ;
 I ^TMP("XTHC10",$J) D CLEANUP
 Q STATUS
 ;
GTM ;
 ; ZEXCEPT: STATUS,XT8RDAT,XT8RHDR,XT8SDAT,XT8SHDR,I,J,K,Y
 ; URL = Self explanatory
 ; XT8FLG = Timeout
 ; XT8RDAT = Return Data
 ; XT8RHDR = Return Headers
 ; XT8SDAT = Input Message
 ; XT8SHDR = Input Headers
 ; XT8METH = Method
 ;
 ; Process Payload
 N XT8PAYLOAD S XT8PAYLOAD=""
 I $D(XT8SDAT)>0 D
 . S I=""
 . F  S I=$O(@XT8SDAT@(I))  Q:I=""  D
 . . S XT8PAYLOAD=XT8PAYLOAD_$G(@XT8SDAT@(I))
 . . S J=""
 . . F  S J=$O(@XT8SDAT@(I,J))  Q:J=""  S XT8PAYLOAD=XT8PAYLOAD_$G(@XT8SDAT@(I,J))
 ;
 ; Input Headers
 S I=""
 F  S I=$O(XT8SHDR(I))  Q:I=""  d &libcurl.addHeader(I_": "_XT8SHDR(I))
 ;
 ; Make Call
 N OUTPUT,HEADERS
 K STATUS
 d &libcurl.do(.STATUS,.OUTPUT,$G(XT8METH),URL,XT8PAYLOAD,"application/json",+$G(XT8FLG,5),.HEADERS)
 ;
 ; Unwrap headers
 N CRLF S CRLF=$C(13,10)
 N I F I=1:1:$L(HEADERS,CRLF) S XT8RHDR(I)=$P(HEADERS,CRLF,I) I XT8RHDR(I)="" K XT8RHDR(I)
 ;
 ; Unwrap Output
 F I=1:1:$L(OUTPUT,$C(10)) D             ; Unwrap by LF
 . N X S X=$P(OUTPUT,$C(10),I)           ; Make it easy to manipulate
 . I $E(X,$L(X))=$C(13) S $E(X,$L(X))="" ; Remove CR if there
 . S @XT8RDAT@(I)=$E(X,1,245)            ; Extract 1-245
 . I $L(X)>245 D                         ; Get chars after 245
 .. F K=1:1:($L(X)\245) D
 .. S Y=$E(X,(K*245)+1,(K*245)+245) Q:Y=""
 .. S @XT8RDAT@(I,K)=Y
 ;
 ; Last bits: cleanup and return
 I ^TMP("XTHC10",$J) D CLEANUP
 Q STATUS

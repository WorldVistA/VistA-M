XTHC10 ;HCIOFO/SG - HTTP 1.0 CLIENT ;11/03/09  16:00
 ;;7.3;TOOLKIT;**123**;Apr 25, 1995;Build 4
 ;
 Q
 ;
 ;##### GETS THE DATA FROM THE PROVIDED URL USING HTTP 1.0
 ;
 ; URL           URL (http://host:port/path)
 ;
 ; [XT8FLG]      Timeout and flags to control processing.
 ;               If a value of  this parameter starts from a number
 ;               then this number is used as a value of the timeout
 ;               (in seconds). Otherwise, the default value of 5
 ;               seconds is used.
 ;
 ; [XT8RDAT]     Closed root of the variable where the message
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
 ; [.XT8RHDR]    Reference to a local variable where the parsed
 ;               headers are returned. Header names are converted to
 ;               upper case; the values are left "as is". The root
 ;               node contains the status line. For example:
 ;
 ;                 XT8HDR="HTTP/1.0 200 OK"
 ;                 XT8HDR("CACHE-CONTROL")="private"
 ;                 XT8HDR("CONNECTION")="Keep-Alive"
 ;                 XT8HDR("CONTENT-LENGTH")="2690"
 ;                 XT8HDR("CONTENT-TYPE")="text/html"
 ;                 XT8HDR("DATE")="Fri, 26 Sep 2003 16:04:10 GMT"
 ;                 XT8HDR("SERVER")="GWS/2.1"
 ;
 ; [XT8SDAT]     Closed root of a variable containing body of the
 ;               request message. Data should be formatted as
 ;               described earlier (see the XT8RDAT parameter).
 ;
 ;               NOTE: If this parameter is defined, not empty, and
 ;                     the referenced array contains data then the
 ;                     POST request is generated. Otherwise, the GET
 ;                     request is sent.
 ;
 ; [.XT8SHDR]    Reference to a local variable containing header
 ;               values, which will be added to the request.
 ;
 ; [REDIR]       This IS NOT a published parameter. It is used
 ;               internally to limit number of redirections.
 ;
 ; Return values:
 ;
 ;           <0  Error Descriptor (see the $$ERROR^XTERROR)
 ;           >0  HTTP Status Code^Description
 ;
 ;    Most common HTTP status codes:
 ;
 ;          200  Ok
 ;
 ;          301  Moved Permanently (The application should either
 ;               automatically update the URL with the new one from
 ;               the Location response header or instruct the user
 ;               how to do this).
 ;
 ;          302  Moved Temporarily (The application should continue
 ;               using the original URL).
 ;
 ;               NOTE: You will not see this code for GET requests.
 ;                     They are redirected automatically.
 ;
 ;          303  See Other (The resource has moved to another URL
 ;               given by the Location response header, and should
 ;               be automatically retrieved by the client using the
 ;               GET method. This is often used by a CGI script to
 ;               redirect the client to an existing file).
 ;
 ;               NOTE: You will not see this status code because it
 ;                     is handled automatically inside the function.
 ;
 ;          400  Bad Request
 ;
 ;          404  Not Found
 ;
 ;          500  Server Error (An unexpected server error. The most
 ;               common cause is a server-side script that has bad
 ;               syntax, fails, or otherwise can't run correctly).
 ;
 ; See the http://www.faqs.org/rfcs/rfc1945.html for more details.
 ;
GETURL(URL,XT8FLG,XT8RDAT,XT8RHDR,XT8SDAT,XT8SHDR,REDIR) ;
 N HOST,I,IP,IPADDR,PATH,PORT,RQS,STATUS,X
 S XT8FLG=$G(XT8FLG)  S:XT8FLG'?1.N.E XT8FLG="5"_XT8FLG
 ;
 ;Check IO
 I '$D(IO(0)) D HOME^%ZIS
 ;=== Parse the URL
 S I=$$PARSEURL^XTHCURL(URL,.HOST,.PORT,.PATH)  Q:I<0 I
 ;
 ;=== Check the host name/address
 I HOST'?1.3N3(1"."1.3N)  D  Q:IPADDR="" $$ERROR(2,HOST)
 . ;--- Resolve the host name into the IP address(es)
 . S IPADDR=$$ADDRESS^XLFNSLK(HOST)  Q:IPADDR=""
 . ;--- Check for the Host header value
 . S I=""
 . F  S I=$O(XT8SHDR(I))  Q:(I="")!($$UP^XLFSTR(I)="HOST")
 . S:I="" XT8SHDR("Host")=HOST
 E  S IPADDR=HOST
 ;
 ;=== Connect to the host
 F I=1:1  S IP=$P(IPADDR,",",I)  Q:IP=""  D  Q:'$G(POP)
 . D CALL^%ZISTCP(IP,PORT,+XT8FLG)
 Q:$G(POP) $$ERROR(3,IPADDR)
 ;
 ;=== Perform the transaction
 D
 . N $ESTACK,$ETRAP
 . ;--- Setup the error processing
 . ;D SETDEFEH^XTERROR("STATUS")
 . S $ET="D ETRAP^XTHC10"
 . ;--- Send the request and get the response
 . S RQS=$$REQUEST^XTHC10A(PATH,$G(XT8SDAT),.XT8SHDR)
 . I RQS<0  S STATUS=RQS  Q
 . S STATUS=$$RECEIVE^XTHC10A(+XT8FLG,$G(XT8RDAT),.XT8RHDR)
 ;
 ;=== Close the socket
 D CLOSE^%ZISTCP
 ;
 ;=== Redirect if requested by the server
 S I=+STATUS
 I (I\100)=3  D:$S(I=303:1,I=301:0,1:RQS="GET")
 . I $G(REDIR)>5  S STATUS=$$ERROR(5)  Q
 . S URL=$G(XT8RHDR("LOCATION"))
 . ;I URL=""  S STATUS=$$ERROR^XTERROR(-150000.024)  Q
 . I URL=""  S STATUS=$$ERROR(4)  Q
 . I RQS="POST"  N XT8SDAT  ; Force the GET request
 . S STATUS=$$GETURL(URL,XT8FLG,$G(XT8RDAT),.XT8RHDR,$G(XT8SDAT),.XT8SHDR,$G(REDIR)+1)
 ;
 ;=== Return the status
 ;I +STATUS=-150000.004  S X=$$LASTERR^XTERROR1()  S:X STATUS=X
 I +STATUS=-6 S STATUS=STATUS("ERROR")
 Q STATUS
 ;
ETRAP ;Catch a runtime error
 N EC
 S STATUS("ERROR")=$$EC^%ZOSV D ^%ZTER
 S STATUS=-6
 I $L($EC) S $ECODE="" S $ETRAP="D UNW^%ZTER Q:$QUIT STATUS Q  " S $ECODE=",U1,"
 Q
 ;
ERROR(ENUM,PARAM) ;Expand error
 N MSG
 S MSG=$P($T(@ENUM),";;",2) S:MSG["|" MSG=$P(MSG,"|")_$G(PARAM)_$P(MSG,"|",2)
 Q MSG
 ;
1 ;;-1^Missing host name.
2 ;;-1^Cannot resolve the host name: |.
3 ;;-1^Cannot connect to host.
4 ;;-1^Missing redirection URL.
5 ;;-1^Too many redirections.
6 ;;-6^Run Time Error.
7 ;;-1^Time Out.

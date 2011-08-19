ONCX10 ;HCIOFO/SG - HTTP 1.0 CLIENT ; 6/20/06 9:29am
 ;;2.11;ONCOLOGY;**40,41,46**;Mar 07, 1995;Build 39
 ;
 Q
 ;
 ;***** GETS THE DATA FROM THE PROVIDED URL USING HTTP 1.0
 ;
 ; URL           URL (http://host:port/path)
 ;
 ; [ONC8FLG]     Timeout and flags to control processing
 ;                 If a value of  this parameter starts from a number 
 ;                 then this number is used as a value of the timeout 
 ;                 (in seconds). Otherwise, the default value of 3
 ;                 seconds is used.
 ;
 ; [ONC8RDAT]    Closed root of the variable where the message
 ;               body is returned. Data is stored in consecutive
 ;               nodes (numbers starting from 1). If a line is
 ;               longer than 245 characters, only 245 characters
 ;               are stored in the corresponding node. After that,
 ;               overflow sub-nodes are created. For example:
 ;
 ;                 @ONC8DATA@(1)="<html>"
 ;                 @ONC8DATA@(2)="<head><title>VistA</title></head>"
 ;                 @ONC8DATA@(3)="<body>"
 ;                 @ONC8DATA@(4)="<p>"
 ;                 @ONC8DATA@(5)="Beginning of a very long line"
 ;                 @ONC8DATA@(5,1)="Continuation #1 of the long line"
 ;                 @ONC8DATA@(5,2)="Continuation #2 of the long line"
 ;                 @ONC8DATA@(5,...)=...
 ;                 @ONC8DATA@(6)="</p>"
 ;                 ...
 ;
 ; [.ONC8RHDR]   Reference to a local variable where the parsed
 ;               headers are returned. Header names are converted to
 ;               upper case; the values are left "as is". The root
 ;               node contains the status line. For example:
 ;
 ;                 ONC8HDR="HTTP/1.0 200 OK"
 ;                 ONC8HDR("CACHE-CONTROL")="private"
 ;                 ONC8HDR("CONNECTION")="Keep-Alive"
 ;                 ONC8HDR("CONTENT-LENGTH")="2690"
 ;                 ONC8HDR("CONTENT-TYPE")="text/html"
 ;                 ONC8HDR("DATE")="Fri, 26 Sep 2003 16:04:10 GMT"
 ;                 ONC8HDR("SERVER")="GWS/2.1"
 ;
 ; [ONC8SDAT]    Closed root of a variable containing body of the
 ;               request message. Data should be formatted as
 ;               described earlier (see the ONC8RDAT parameter).
 ;
 ;         NOTE: If this parameter is defined, not empty, and the
 ;               referenced array contains data then the POST request
 ;               is generated. Otherwise, the GET request is sent.
 ;
 ; [.ONC8SHDR]   Reference to a local variable containing header
 ;               values, which will be added to the request.
 ;
 ; [REDIR]       This IS NOT a published parameter. It is used
 ;               internally to limit number of redirections.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor
 ;           (see the $$ERROR^ONCXERR for descriptor structure
 ;            and the MSGLIST^ONCXERR for list of error)
 ;
 ;       >0  HTTP Status Code^Description
 ;
 ;    Most common HTTP status codes:
 ;
 ;      200  Ok
 ;
 ;      301  Moved Permanently (The application should either
 ;           automatically update the URL with the new one from
 ;           the Location response header or instruct the user
 ;           how to do this).
 ;
 ;      302  Moved Temporarily (The application should continue
 ;           using the original URL).
 ;
 ;           NOTE: You will not see this code for GET requests.
 ;                 They are redirected automatically.
 ;
 ;      303  See Other (The resource has moved to another URL
 ;           given by the Location response header, and should
 ;           be automatically retrieved by the client using the
 ;           GET method. This is often used by a CGI script to
 ;           redirect the client to an existing file).
 ;
 ;           NOTE: You will not see this status code because it
 ;                 is handled automatically inside the function.
 ;
 ;      400  Bad Request
 ;
 ;      404  Not Found
 ;
 ;      500  Server Error (An unexpected server error. The most
 ;           common cause is a server-side script that has bad
 ;           syntax, fails, or otherwise can't run correctly).
 ;
 ; See the http://www.faqs.org/rfcs/rfc1945.html for more details.
 ;
GETURL(URL,ONC8FLG,ONC8RDAT,ONC8RHDR,ONC8SDAT,ONC8SHDR,REDIR) ;
 N $ESTACK,$ETRAP,HOST,I,IP,IPADDR,PATH,PORT,RQS,STATUS,X
 S ONC8FLG=$G(ONC8FLG)  S:ONC8FLG'?1.N.E ONC8FLG="3"_ONC8FLG
 S I=$$PARSE^ONCXURL(URL,.HOST,.PORT,.PATH)  Q:I<0 I
 ;--- Check the host name/address
 I HOST'?1.3N3(1"."1.3N)  D  Q:IPADDR="" $$ERROR^ONCXERR(-2,,HOST)
 . ;--- Resolve the host name into IP address(es)
 . S IPADDR=$$ADDRESS^XLFNSLK(HOST)  Q:IPADDR=""
 . ;--- Check for the Host header value
 . S I=""
 . F  S I=$O(ONC8SHDR(I))  Q:(I="")!($$UP^XLFSTR(I)="HOST")
 . S:I="" ONC8SHDR("Host")=HOST
 E  S IPADDR=HOST
 ;--- Connect to the host
 F I=1:1  S IP=$P(IPADDR,",",I)  Q:IP=""  D  Q:'$G(POP)
 . D CALL^%ZISTCP(IP,PORT,+ONC8FLG)
 Q:$G(POP) $$ERROR^ONCXERR(-3,,IPADDR)
 ;--- Perform the transaction
 K STATUS  D  S:'$D(STATUS) STATUS=$$ERROR^ONCXERR(-6)
 . ;--- Setup the error processing
 . S X="ERRTRAP^ONCX10",@^%ZOSF("TRAP"),$ETRAP=""
 . ;--- Send the request and get the response
 . S RQS=$$REQUEST^ONCX10A(PATH,$G(ONC8SDAT),.ONC8SHDR)
 . I RQS<0  S STATUS=RQS  Q
 . S STATUS=$$RECEIVE^ONCX10A(+ONC8FLG,$G(ONC8RDAT),.ONC8RHDR)
 ;--- Close the socket
 D CLOSE^%ZISTCP
 ;--- Redirect if requested by the server
 S I=+STATUS
 I (I\100)=3  D:$S(I=303:1,I=301:0,1:RQS="GET")
 . I $G(REDIR)>5  S STATUS=$$ERROR^ONCXERR(-5)  Q
 . S URL=$G(ONC8RHDR("LOCATION"))
 . I URL=""  S STATUS=$$ERROR^ONCXERR(-4)  Q
 . I RQS="POST"  N ONC8SDAT  ; Force the GET request
 . S STATUS=$$GETURL(URL,ONC8FLG,$G(ONC8RDAT),.ONC8RHDR,$G(ONC8SDAT),.ONC8SHDR,$G(REDIR)+1)
 ;--- Return the status
 Q STATUS
 ;
ERRTRAP D @^%ZOSF("ERRTN")  Q

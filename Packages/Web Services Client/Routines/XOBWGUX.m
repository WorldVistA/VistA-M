XOBWGUX ; VEN/SMH - Web Services Client using cURL ;2018-04-02  3:52 PM
 ;;1.0;HwscWebServiceClient;**10001**;September 13, 2010;Build 39
 ;
 ; (c) Sam Habiel 2016,2018
 ; Licensed under Apache 2
 ;
%(RETURN,METHOD,URL,PAYLOAD,MIME,TO,HEADERS,OPTIONS) ; General call for any type
 ;
 ; ZEXCEPT: DEBUG
 ; DEBUG=1 in the Symbol Table zwrites the returned data and headers
 ;
 ; Output: $$ (Optional) The Status code of cURL when it exits
 ;         .RETURN. Code does not support output into a global.
 ;         .RETURN subscripts DO NOT START WITH 1. Use $O to go through it. E.g.
 ;         .RETURN(11)="<!DOCTYPE html>"
 ;         .RETURN(12)="<html>"
 ;         .RETURN(13)="<head>"
 ;         .RETURN(14)="<title>Welcome to nginx!</title>"
 ;
 ;         .HEADERS Headers for response
 ;
 ; Input:
 ; -- METHOD: "GET", "POST", "PUT", "OPTIONS" or anything thing else dest supports
 ; -- URL: The URL in a format curl understands. Just like any URL you give Firefox
 ; -- .PAYLOAD: The data you need to send the server in a "POST" or "PUT" operation
 ; -- MIME: If sending a payload, and the dest cares what type it is, you can
 ;          say here what type it is. E.g. "application/json"
 ; -- TO: Timeout. Default timeout is 30 seconds
 ; -- .OPTIONS: Any additional options you want to pass to cURL. At this point,
 ;              only the following are supported:
 ;     OPTIONS("cert")     = Client Certificate Path
 ;     OPTIONS("key")      = Client Certificate Key
 ;     OPTIONS("password") = Client Certificate Password
 ;     Not all of them are necessary if you are using a client cert; you may
 ;     have a cert with the key appended, or you may have a cert without a
 ;     password.
 ;
 ;     OPTIONS("header",1) = "header: value" OR "header-with-no-value;"
 ;     OPTIONS("header",2) = "second header: value" etc
 ;     OPTIONS("header",:)
 ;     e.g. OPTIONS("header",1)="DNT: 1" ; Do not Track
 ;
 ;     OPTIONS("form")="filename={filename-on-destination};type={mime-type-of-form}"
 ;
 ; See the tests at the bottom of this routine for examples.
 ;
 ; In general, a quick test is the following:
 ; W $$%^%WC(.RTN,"GET","https://www.google.com")
 ;
 ; DEBUG; Test error trapping.
 ; N X S X=1/0
 ; DEBUG
 ;
 ; Kill return variables
 KILL RETURN,HEADERS
 ;
 S TO=$G(TO) ; Timeout
 I +TO=0 S TO=30 ; Default timeout
 ;
 ; Write payload to File in shared memory
 ; ZEXCEPT: NEWVERSION
 I $D(PAYLOAD) N F D
 . S F="/dev/shm/"_$R(987987234)_$J_".DAT"
 . O F:(NEWVERSION) U F
 . I $D(PAYLOAD)#2 W PAYLOAD,!
 . N I F I=0:0 S I=$O(PAYLOAD(I)) Q:'I  W PAYLOAD(I),!
 . C F
 ;
 N CMD S CMD="curl -K -" ; Read options from stdin; GT.M cannot handle a command longer than 255 characters.
 ;
 ; DEBUG ; See if we can get an error if curl isn't found on the Operating System.
 ;N CMD S CMD="curly -si -XPOST --connect-timeout "_TO_" -m "_TO_" -k "_URL_" --header 'Content-Type:"_MIME_"'"_" --data-binary @"_F
 ; DEBUG
 ;
 ; DEBUG
 ; W !,CMD
 ; DEBUG
 ;
 ; VEN/SMH Okay. This the code is hard to understand. See comments.
 ;
 ; Execute and read back
 N D S D="cURLDevice"
 ; ZEXCEPT: shell,command,EOF,PARSE
 O D:(shell="/bin/sh":command=CMD:PARSE)::"PIPE" U D
 ;
 ; Write what to do for curl -K -
 ; TODO: not bullet proof. Some characters may need to be escaped.
 N Q S Q=""""
 W "url = ",Q_URL_Q,!
 W "request = ",METHOD,!
 W "connect-timeout = ",TO,!
 W "max-time = ",TO,!
 W "silent",!
 W "include",!
 ; W "location",! ; This follows the URL around with redirects, but could be a security risk.
 ;                ; And you don't want to waste precious time bouncing getting to the right URL
 ;                ; GET IT RIGHT THE FIRST TIME!
 ; W "insecure",! ; This disables certificate security checking. BAD!
 I $G(MIME)]"" W "header = "_Q_"Content-Type: "_MIME_Q,!
 I $D(PAYLOAD),'$D(OPTIONS("form")) W "data-binary = "_Q_"@"_F_Q,!
 I $D(OPTIONS) D
 . I $D(OPTIONS("password")),$D(OPTIONS("cert")) S OPTIONS("cert")=OPTIONS("cert")_":"_OPTIONS("password")
 . I $D(OPTIONS("cert")) W "cert = "_Q_OPTIONS("cert")_Q,!
 . I $D(OPTIONS("key")) W "key = "_Q_OPTIONS("key")_Q,!
 . N I F I=0:0 S I=$O(OPTIONS("header",I)) Q:'I  W "header = "_Q_OPTIONS("header",I)_Q,!
 . I $D(OPTIONS("form")),$D(PAYLOAD) W "form = "_Q_"file=@"_F_";"_OPTIONS("form")_Q,!
 W /EOF
 ;
 ; Flag to indicate whether a line we are getting a header or not. We are getting headers first, so it's true.
 ; A la State machine.
 N ISHEADER S ISHEADER=1
 N hasContinue S hasContinue=0
 N I F I=1:1 R RETURN(I)#4000:1 Q:$ZEOF  D   ; Read each line up to 4000 characters
 . S RETURN(I)=$$TRIM(RETURN(I),,$C(13)) ; Strip CRs (we are on Unix)
 . I RETURN(I)="",$G(HEADERS("STATUS")) S ISHEADER=0,hasContinue=0  ; If we get a blank line, and we don't have a status yet (e.g. if we got a 100 which we kill off), we are no longer at the headers
 . I ISHEADER D  QUIT                    ; If we are at the headers, read them & remove them from RETURN array.
 . . ; First Line is like HTTP/1.1 200 OK
 . . I RETURN(I)'[":" S HEADERS("PROTOCOL")=$P(RETURN(I)," "),HEADERS("STATUS")=$P(RETURN(I)," ",2) K RETURN(I)
 . . ; Next lines are key: value pairs.
 . . E  S HEADERS($P(RETURN(I),":"))=$$TRIM($P(RETURN(I),":",2,99)) K RETURN(I)
 . . i hasContinue,$G(HEADERS("Content-Length"))=0 K HEADERS("Content-Length") QUIT  ; This is a special line only for some web servers
 . . I HEADERS("STATUS")=100 K HEADERS("PROTOCOL"),HEADERS("STATUS") set hasContinue=1 QUIT  ; We don't want the continue
 . K:RETURN(I)="" RETURN(I) ; remove empty line
 K:RETURN(I)="" RETURN(I)  ; remove empty line (last line when $ZEOF gets hit)
 C D
 ;
 N ZCLOSE S ZCLOSE=$ZCLOSE ; Status of command when it ended.
 ;
 ; Delete the file a la %ZISH
 ; ZEXCEPT: DELETE
 I $D(PAYLOAD) O F C F:(DELETE)
 ;
 ; Comment the zwrites out to see the return vales from the function
 I $G(DEBUG) D
 . ZWRITE HEADERS
 . ZWRITE RETURN
 ;
 QUIT:$QUIT ZCLOSE QUIT
 ;
 ;
 ; Code below stolen from Kernel. Thanks Wally.
TRIM(%X,%F,%V) ;Trim spaces\char from front(left)/back(right) of string
 N %R,%L
 S %F=$$UP($G(%F,"LR")),%L=1,%R=$L(%X),%V=$G(%V," ")
 ;I %F["R" F %R=$L(%X):-1:1 Q:$E(%X,%R)'=%V  ;take out BT
 I %F["R" F %R=$L(%X):-1:0 Q:$E(%X,%R)'=%V  ;598
 ;I %F["L" F %L=1:1:$L(%X) Q:$E(%X,%L)'=%V  ;take out BT
 I %F["L" F %L=1:1:$L(%X)+1 Q:$E(%X,%L)'=%V  ;598
 I (%L>%R)!(%X=%V) Q ""
 Q $E(%X,%L,%R)
 ;
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
TEST D EN^%ut($T(+0),3) quit  ; Unit Tests
TGETHTTP ; @TEST Test Get with HTTP
 N RTN,H,RET S RET=$$%(.RTN,"GET","http://httpbin.org/stream/20",,"application/text",5,.H)
 N CNT S CNT=0
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  S CNT=CNT+1
 D CHKTF^%ut(CNT=20,"20 lines are supposed to be returned")
 D CHKTF^%ut(H("STATUS")=200,"Status is supposed to be 200")
 D CHKTF^%ut(RET=0,"Return code is supposed to be zero")
 quit
 ;
TGETS ; @TEST Test Get with HTTPS
 N RTN,H,RET S RET=$$%(.RTN,"GET","https://httpbin.org/stream/20",,"application/text",5,.H)
 N CNT S CNT=0
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  S CNT=CNT+1
 D CHKTF^%ut(CNT=20,"20 lines are supposed to be returned")
 D CHKTF^%ut(H("STATUS")=200,"Status is supposed to be 200")
 D CHKTF^%ut(RET=0,"Return code is supposed to be zero")
 quit
 ;
TPUT ; @TEST Test Put
 N PAYLOAD,RTN,H,RET
 N R S R=$R(123423421234)
 S PAYLOAD(1)="KBANTEST ; VEN/SMH - Test routine for Sam ;"_R
 S PAYLOAD(2)=" QUIT"
 S RET=$$%(.RTN,"PUT","https://httpbin.org/put",.PAYLOAD,"application/text",5,.H)
 ;
 N OK S OK=0
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  I RTN(I)["data",RTN(I)[R S OK=1
 D CHKTF^%ut(RET=0,"Return code is supposed to be zero")
 D CHKTF^%ut(H("STATUS")=200,"Status is supposed to be 200")
 D CHKTF^%ut(OK,"Couldn't retried the putted string back")
 QUIT
 ;
TESTCRT ; Unit Test with Client Certificate
 N OPTIONS
 ;S OPTIONS("cert")="/home/sam/client.pem"
 ;S OPTIONS("key")="/home/sam/client.key"
 ;S OPTIONS("password")="xxxxxxxxxxx"
 S OPTIONS("cert")="/home/sam/client-nopass.pem"
 S OPTIONS("key")="/home/sam/client-nopass.key"
 N RTN N % S %=$$%(.RTN,"GET","https://green-sheet.smh101.com/",,,,,.OPTIONS)
 ZWRITE RTN
 I @$Q(RTN)'["DOCTYPE" W "FAIL FAIL FAIL",!
 W "Exit code: ",%,!
 QUIT
 ;
TESTH ; @TEST Unit Test with headers
 N OPTIONS
 S OPTIONS("header",1)="DNT: 1"
 N RTN N % S %=$$%(.RTN,"GET","https://httpbin.org/headers",,,,,.OPTIONS)
 N OK S OK=0
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  I $$UP(RTN(I))["DNT" S OK=1
 D CHKTF^%ut(%=0,"Return code is supposed to be zero")
 D CHKTF^%ut(OK,"Couldn't get the sent header back")
 QUIT
 ;
TESTF ; @TEST Unit Test with Form
 N XML,H
 S XML(1)="<xml>"
 S XML(2)="<Book>Book 1</Book>"
 S XML(3)="<Book>Book 2</Book>"
 S XML(4)="<Book>Book 3</Book>"
 S XML(5)="</xml>"
 N OK,OPTIONS
 S OPTIONS("form")="filename=test1234.xml;type=application/xml"
 N RTN N % S %=$$%(.RTN,"POST","http://httpbin.org/post",.XML,"",,.H,.OPTIONS)
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  I RTN(I)["multipart/form-data" S OK=1
 D CHKTF^%ut(%=0,"Return code is supposed to be zero")
 D CHKTF^%ut(OK,"Couldn't get the form back")
 QUIT

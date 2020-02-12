YTQRUTL ;SLC/KCM - RESTful API Utilities ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; VPRJSON               6411
 ; XLFSTR               10104
 ; XLFUTL                2622
 ; XWBLIB                2238
 ;
 ;
 ; ^TMP("YTQRERRS",$J)  place to list errors
 ;
 ; -- the HTTP request comes in the original RPC call
 ; HTTPREQ(1)="GET /path/goes/here?queryparam=avalue"
 ; HTTPREQ(2)="content-type=application/json"
 ; HTTPREQ(3)=""
 ; HTTPREQ(n)={json stuff...}
 ; 
 ; -- HTTPREQ is parsed into these variables
 ; YTQRREQT("method")="GET"
 ; YTQRREQT("path")="path/goes/here"
 ; YTQRREQT("query")="queryparam=avalue"
 ; YTQRARGS(name)=value          (names from path variables and query params)
 ; YTQRTREE(subscripts)=values   (M-tree from JSON passed as request body)
 ;
 ; -- these are how the REST methods are invoked in matched routine
 ;    GET:  getCall(.YTQRARGS,.YTQRRSLT)              returns .YTQRRSLT
 ;   POST:  locationURL=postCall(.YTQRARGS,.YTQRTREE) returns LOCATION header
 ; DELETE: delCall(.YTQRARGS)                         returns OK or error
 ;
 ; -- this array is built based on the return from the matched routine
 ;    for  GET:  convert .YTQRTREE results into JSON
 ;    for POST:  set Location header based on return value of function
 ; HTTPRSP(.1)="HTTP/1.1 200 OK"
 ; HTTPRSP(.2)="Date: ..."  (GMT date)
 ; HTTPRSP(.3)="Location: /path/to/resource"
 ; HTTPRSP(.4)="Content-Type: application/json"
 ; HTTPRSP(.5)="Content-Length: 42"
 ; HTTPRSP(.9)=""
 ; HTTPRSP(1..n)=JSON content
 ;
HANDLE(URLTAG,HTTPREQ,HTTPRSP) ; route REST request based on URL pattern
 ;   URLTAG: tag^routine that begins mapping of path patterns to routines
 ; .HTTPREQ: GET/PUT/POST/DELETE request in HTTP form
 ; .HTTPRSP: response to caller in HTTP form
 N YTQRREQT,YTQRERRS,YTQRARGS,YTQRTREE,YTQRRSLT,JSONBODY,CALL,LOCATION
 K ^TMP("YTQRERRS",$J),^TMP("YTQ-JSON",$J)
 D PARSHTTP(.HTTPREQ,.YTQRREQT,.JSONBODY) G:$G(YTQRERRS) RESPONSE
 I $D(JSONBODY) D PARSJSON(.JSONBODY,.YTQRTREE) G:$G(YTQRERRS) RESPONSE
 D MATCH(URLTAG,.CALL,.YTQRARGS) G:$G(YTQRERRS) RESPONSE
 D QSPLIT(.YTQRARGS)
 ; treat PUT and POST the same for now
 I "PUT,POST"[YTQRREQT("method") X "S LOCATION=$$"_CALL_"(.YTQRARGS,.YTQRTREE)" I 1
 I YTQRREQT("method")="GET" D @(CALL_"(.YTQRARGS,.YTQRRSLT)")
 I YTQRREQT("method")="DELETE" D @(CALL_"(.YTQRARGS)")
 D RESPONSE(.YTQRRSLT,.LOCATION)
 Q
PARSHTTP(HTTPREQ,YTQRREQT,JSONBODY) ; parse out header and body of HTTP HTTPREQ
 N I,J,X
 S YTQRREQT("method")=$P(HTTPREQ(1)," ")
 S YTQRREQT("path")=$P($P(HTTPREQ(1)," ",2),"?")
 S YTQRREQT("query")=$P($P(HTTPREQ(1)," ",2),"?",2,99)
 F I=2:1 Q:'$L($G(HTTPREQ(I)))  S X=HTTPREQ(I),YTQRREQT("header",$P(X,"="))=$P(X,"=",2,99)
 F J=1:1 S I=$O(HTTPREQ(I)) Q:'I  S JSONBODY(J)=HTTPREQ(I)
 I '$D(YTQRREQT("method")) D SETERROR(400,"Missing HTTP method")
 I '$D(YTQRREQT("path")) D SETERROR(400,"Missing URL path")
 Q 
PARSJSON(JSONBODY,YTQRTREE) ; parse JSON request into M tree structure
 N ERRORS
 D DECODE^VPRJSON("JSONBODY","YTQRTREE","ERRORS")
 I $D(ERRORS)>0 D SETERROR(400,$G(ERRORS(1)))
 Q
MATCH(TAG,CALL,ARGS) ; evaluate paths listed in TAG until match found (else 404)
 ; expects YTQRREQT to contain "path" and "method" nodes
 ;  TAG     contains the beginning tag where the paths are listed
 ; .ROUTINE contains TAG^ROUTINE, which will be called as TAG(.RESULTS,.ARGS)
 ; .ARGS    will contain an array of any resolved path arguments
 ;
 N I,J,X,PATH,PATHFND,RTN,PATTERN,SEGSOK,SEGPATH,SEGPTRN,ARGUMENT,TEST
 S PATH=YTQRREQT("path"),PATHFND=0
 S RTN=$P(TAG,"^",2),TAG=$P(TAG,"^") S:$L(RTN) RTN="^"_RTN
 I $E(PATH)'="/" S PATH="/"_PATH  ; ensure leading / for consistency
 F I=1:1 S X=$P($T(@(TAG_"+"_I_RTN)),";;",2,99) Q:'$L(X)  D  Q:PATHFND
 . K ARGS S PATTERN=$P(X," ",2)
 . I $P(X," ")'=YTQRREQT("method") Q               ; '=method -- continue
 . I $L(PATTERN,"/")'=$L(PATH,"/") Q             ; '=segCount -- continue
 . S SEGSOK=1 F J=1:1:$L(PATH,"/") D  Q:'SEGSOK  ; check each path segment
 . . S SEGPATH=$$URLDEC($P(PATH,"/",J),1)
 . . S SEGPTRN=$$URLDEC($P(PATTERN,"/",J),1)
 . . I $E(SEGPTRN)'=":" S SEGSOK=($$LOW^XLFSTR(SEGPTRN)=$$LOW^XLFSTR(SEGPATH)) Q
 . . ; extract the :argument with optional pattern test
 . . S SEGPTRN=$E(SEGPTRN,2,$L(SEGPTRN))               ; remove colon
 . . S ARGUMENT=$P(SEGPTRN,"?"),TEST=$P(SEGPTRN,"?",2) ; get arg and test
 . . I $L(TEST) S SEGSOK=(SEGPATH?@TEST) Q:'SEGSOK     ; test pattern match
 . . S ARGS(ARGUMENT)=SEGPATH                          ; ARGS(argName)=value
 . I SEGSOK S PATHFND=1,CALL=$P(X," ",3)
 I 'PATHFND D SETERROR(404,"No match to path found.")
 Q
QSPLIT(ARGS) ; parses and decodes query fragments into ARGS
 N I,X,NAME,VALUE
 F I=1:1:$L(YTQRREQT("query"),"&") D
 . S X=$$URLDEC($P(YTQRREQT("query"),"&",I))
 . S NAME=$P(X,"="),VALUE=$P(X,"=",2,999)
 . I $L(NAME) S ARGS($$LOW^XLFSTR(NAME))=VALUE
 Q
RESPONSE(YTQRRSLT,LOCATION) ; build HTTPRSP based results or error
 ; from HANDLE, expects YTQRERRS (only defined if there were errors)
 ; YTQRERRS: positive number if there are errors to return
 ; YTQRRSLT: return value of the GET call
 ; LOCATION: return path of the POST call
 K HTTPRSP
 I $G(YTQRERRS) D BLDERRS(.HTTPRSP) QUIT
 I $D(YTQRRSLT) D     ; call is returning data (i.e., was a GET)
 . I $E($G(YTQRRSLT),1,16)="^TMP(""YTQ-JSON""," D
 . . ; contents of ^TMP("YTQ-JSON",$J) already in JSON format
 . . S HTTPRSP=$NA(^TMP("YTQ-JSON",$J))
 . . D ADDHDR(HTTPRSP,$$GVSIZE(HTTPRSP))
 . . I '$$RTRNFMT^XWBLIB(4,1) D SETERROR(400,"Unable to return global array")
 . E  D
 . . ; contents of YTQRRSLT need to be converted from nodes to JSON
 . . D JSONRSP("YTQRRSLT",.HTTPRSP)
 . . D ADDHDR("HTTPRSP",$$LVSIZE(.HTTPRSP))
 E  D                 ; call is returning location only (i.e., was a POST)
 . I YTQRREQT("method")="DELETE" D ADDHDR("HTTPRSP",0) QUIT
 . I '$L($G(LOCATION)) D SETERROR(400,"Location missing after POST") QUIT
 . D ADDHDR("HTTPRSP",0,LOCATION)
 I $G(YTQRERRS) D BLDERRS(.HTTPRSP) ; rebuild return value if we have errors
 Q
JSONRSP(ROOT,HTTPRSP) ; encode response tree or error info as JSON
 N ERRORS
 K HTTPRSP
 D ENCODE^VPRJSON(ROOT,"HTTPRSP","ERRORS")
 I $D(ERRORS)>0 D SETERROR(400,"Unable to encode HTTPRSP: "_$G(ERRORS(1)))
 Q
ADDHDR(DEST,SIZE,LOCATION) ; add header values to response
 ; S HTTPRSP(.2)="Date: "_$$GMT
 I $L($G(LOCATION)) D
 . S @DEST@(.3)="Location: "_$$URLENC(LOCATION)
 I $G(SIZE)>0 D
 . S @DEST@(.4)="Content-Type: application/json"
 . S @DEST@(.5)="Content-Length: "_SIZE
 S @DEST@(.1)="HTTP/1.1 "_$S($G(YTQRERRS):$$ERRHDR,1:"200 OK")
 S @DEST@(.9)=""
 Q
BLDERRS(HTTPRSP) ; Build response with error information
 K HTTPRSP
 D JSONRSP($NA(^TMP("YTQRERRS",$J,1)),.HTTPRSP)
 D ADDHDR("HTTPRSP",$$LVSIZE(.HTTPRSP))
 Q
 ;
URLDEC(X,PATH) ; Decode a URL-encoded string
 ; Q $ZCONVERT(X,"I","URL")  ; uncomment for fastest performance on Cache
 ;
 N I,OUT,FRAG,ASC
 S:'$G(PATH) X=$TR(X,"+"," ") ; don't convert '+' in path fragment
 F I=1:1:$L(X,"%") D
 . I I=1 S OUT=$P(X,"%") Q
 . S FRAG=$P(X,"%",I),ASC=$E(FRAG,1,2),FRAG=$E(FRAG,3,$L(FRAG))
 . I $L(ASC) S OUT=OUT_$C($$BASE^XLFUTL(ASC,16,10)) ; hex to dec
 . S OUT=OUT_FRAG
 Q OUT
 ;
URLENC(X) ; Encode a string for use in a URL
 ; Q $ZCONVERT(X,"O","URL")  ; uncomment for fastest performance on Cache
 ; =, &, %, +, non-printable
 ; {, } added JC 7-24-2012
 N I,Y,Z,LAST
 S Y=$P(X,"%") F I=2:1:$L(X,"%") S Y=Y_"%25"_$P(X,"%",I)
 S X=Y,Y=$P(X,"&") F I=2:1:$L(X,"&") S Y=Y_"%26"_$P(X,"&",I)
 S X=Y,Y=$P(X,"=") F I=2:1:$L(X,"=") S Y=Y_"%3D"_$P(X,"=",I)
 S X=Y,Y=$P(X,"+") F I=2:1:$L(X,"+") S Y=Y_"%2B"_$P(X,"+",I)
 S X=Y,Y=$P(X,"{") F I=2:1:$L(X,"{") S Y=Y_"%7B"_$P(X,"{",I)
 S X=Y,Y=$P(X,"}") F I=2:1:$L(X,"}") S Y=Y_"%7D"_$P(X,"}",I)
 S Y=$TR(Y," ","+")
 S Z="",LAST=1
 F I=1:1:$L(Y) I $A(Y,I)<32 D
 . S CODE=$$BASE^XLFUTL($A(Y,I),10,16),CODE=$TR($J(CODE,2)," ","0")
 . S Z=Z_$E(Y,LAST,I-1)_"%"_CODE,LAST=I+1
 S Z=Z_$E(Y,LAST,$L(Y))
 Q Z
 ;
LVSIZE(V) ; return the size of a local variable
 Q:'$D(V) 0
 N SIZE,I
 S SIZE=0
 I $D(V)#2 S SIZE=$L(V)
 I $D(V)>1 S I="" F  S I=$O(V(I)) Q:'I  S SIZE=SIZE+$L(V(I))
 Q SIZE
 ;
GVSIZE(ROOT) ; return the size of a global variable (assumes WP format)
 Q:'$D(ROOT) 0 Q:'$L(ROOT) 0
 N SIZE,I
 S SIZE=0
 I $D(@ROOT)#2 S SIZE=$L(@ROOT)
 I $D(@ROOT)>1 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  S SIZE=SIZE+$L(@ROOT@(I,0))
 Q SIZE
 ;
SETERROR(CODE,MSG) ; set up error object
 S ^TMP("YTQRERRS",$J,0)=$G(^(0))+1
 S ^TMP("YTQRERRS",$J,1,"apiVersion")="1.0"
 S ^TMP("YTQRERRS",$J,1,"error","code")=CODE
 S ^TMP("YTQRERRS",$J,1,"error","message")=$$HTTPMSG(CODE)
 S ^TMP("YTQRERRS",$J,1,"error","request")=$G(YTQRREQT("method"))_" "_$G(YTQRREQT("path"))_" "_$G(YTQRREQT("query"))
 S ^TMP("YTQRERRS",$J,1,"error","errors",^TMP("YTQRERRS",$J,0),"message")=MSG
 S YTQRERRS=1 ; Global indicator of errors
 Q
HTTPMSG(CODE) ; return message for error code
 I CODE=200 Q "OK"
 I CODE=201 Q "CREATED"
 I CODE=400 Q "BAD REQUEST"
 I CODE=404 Q "NOT FOUND"
 I CODE=500 Q "INTERNAL SERVER ERROR"
 Q "UNKNOWN"
 ;
ERRTXT() ; return error message for non-HTTP RPC calls
 N I,X
 S X=""
 S I=0 F  S I=$O(^TMP("YTQRERRS",$J,1,"error","errors",I)) Q:'I  D
 . S X=X_$S($L(X):$C(13,10),1:"")
 . S X=X_^TMP("YTQRERRS",$J,1,"error","errors",I,"message")
 Q X
 ;
ERRHDR() ; return error header
 N X
 S X=$G(^TMP("YTQRERRS",$J,1,"error","code"))
 S X=X_" "_$G(^TMP("YTQRERRS",$J,1,"error","message"))
 I X'?3N1" "1.E S X="500 INTERNAL SERVER ERROR"
 Q X
 ;
TR2WP(SRC,DEST,DELIM) ; Convert tree representation to FM WP
 ;  SRC: glvn of source array (JSON node with wp text)
 ; DEST: glvn of destination array (will add [line,0] nodes)
 ;DELIM: string that represents line break -- defaults to $C(13,10)
 N I,J,X,LN
 S LN=0,X=$G(@SRC),DELIM=$G(DELIM,$C(13,10))
 F J=1:1:$L(X,DELIM) S LN=LN+1,@DEST@(LN,0)=$P(X,$C(13,10),J)
 S I=0 F  S I=$O(@SRC@("\",I)) Q:'I  D
 . S X=@SRC@("\",I)
 . F J=1:1:$L(X,DELIM) D
 . . I J=1 S @DEST@(LN,0)=@DEST@(LN,0)_$P(X,DELIM,1) I 1
 . . E  S LN=LN+1,@DEST@(LN,0)=$P(X,DELIM,J)
 Q

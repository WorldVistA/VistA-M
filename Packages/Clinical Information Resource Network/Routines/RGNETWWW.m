RGNETWWW ;RI/CBMI/DKM - HTTP support ;11-Feb-2017 01:53;DKM
 ;;1.0;NETWORK SERVICES;;14-March-2014;Build 46
 ;=================================================================
 ; This is the TCP I/O handler entry point
NETSERV(DUMMY) ;
 D WRITEALL($$PROCESS("$$TCPSTRM(.LN)"))
 S RGQUIT=RGMODE'=3
 Q
 ; Entry point where request is in an array.
 ;  SRCARY = Array reference.  Note that the array contents will be destroyed.
 ;  Returns the global reference where the response is stored.
ENTRYARY(SRCARY) ;
 Q $$PROCESS("$$ARYSTRM(.LN,""SRCARY"")")
 ; Entry point for processing a request.  By using a stream,
 ; we can process requests from sources other than a TCP
 ; stream.
 ;   SOURCE = Extrinsic that will act as an input stream for reading the request.
PROCESS(SOURCE) ;
 N RGNETREQ,RGNETRSP
 D INIT,PROCX,ENDRSP,CLEANUP
 Q:$Q RGNETRSP
 Q
PROCX N HANDLER,EP,AUTH,ACE,X,$ET,$ES
 S $ET="D ETRAP^RGNETWWW"
 S X=$$PARSEREQ(SOURCE,.RGNETREQ)
 I X D SETSTAT(X) Q
 S HANDLER=$$URL2EP(RGNETREQ("METHOD"),RGNETREQ("PATH"))
 I 'HANDLER D SETSTAT(404,"No Endpoint") Q
 S EP=$G(^RGNET(996.52,HANDLER,10)),AUTH=$P(^(0),U,3),ACE=$G(^(20,"ACE"))
 I '$L(EP) D SETSTAT(404,"No Handler") Q
 Q:'$$AUTH(AUTH,$L(AUTH)&'$G(DUZ))
 I $L(ACE),'$$ACEEVAL(ACE) D SETSTAT(403) Q
 D @EP
 Q
 ; Trap an expected error, returning it as a 500 status code.
ETRAP D SETSTAT(500,$P($EC,",",2)),^%ZTER,UNWIND^%ZTER
 Q
 ; Writes the contents of the buffer to the TCP socket.
 ;  BUFFER = Array reference containing buffered output.
WRITEALL(BUFFER) ;
 N LP1,LP2
 S LP1=""
 F  S LP1=$O(@BUFFER@(LP1)) Q:'$L(LP1)  D
 .D:$D(@BUFFER@(LP1))#2 TCPWRITE^RGNETTCP(@BUFFER@(LP1))
 .S LP2=""
 .F  S LP2=$O(@BUFFER@(LP1,LP2)) Q:'$L(LP2)  D
 ..D TCPWRITE^RGNETTCP(@BUFFER@(LP1,LP2))
 Q
 ; Extrinsic to act as a TCP input stream
 ;  .LN = Single line returned from input stream.
TCPSTRM(LN) ;
 N L,TMO
 S TMO=$S('$D(LN):10,1:0)
 S LN=$$TCPREADT^RGNETTCP($C(13,10),TMO),L=$L(LN)
 I L,$E(LN,L-1,L)=$C(13,10) S LN=$E(LN,1,L-2)
 Q L
 ; Extrinsic to act as an array stream source
 ;  .LN = Single line returned from input stream.
 ;  ARYREF = Contains arrary reference.  Note: input array will be killed.
ARYSTRM(LN,ARYREF) ;
 N X,L
 S X=$Q(@ARYREF),L=$QL(ARYREF)
 Q:'$L(X) 0
 Q:$NA(@X,L)'=ARYREF 0
 S LN=@X
 K @X
 Q 1
 ; Parse the HTTP request
 ;  STREAM  = Input stream (an extrinsic for returning successive lines)
 ; .RGNETREQ = Array to receive the parsed results
 ; Parsed components are stored under the following nodes:
 ;  HDR    = Headers
 ;  METHOD = Method
 ;  PARAMS = Query parameters
 ;  PATH   = Request path
 ;  HOST   = Request URL (less protocol)
PARSEREQ(STREAM,RGNETREQ) ;
 N METHOD,PATH,HEADERS,NEXT,LP,LN,CNT,QRY,X
 S CNT=0,NEXT="X="_STREAM
 F  S @NEXT Q:'X  D
 .I '$D(METHOD) S METHOD=LN Q
 .I 'CNT S CNT='$L(LN) Q:CNT
 .I 'CNT D PARSEHDR(LN) Q
 .S RGNETREQ("BODY",CNT)=LN,CNT=CNT+1
 I '$D(METHOD) Q 400
 S PATH=$P(METHOD," ",2),METHOD=$P(METHOD," ")
 I '$L(METHOD) Q 405
 I PATH["?" D
 .S QRY=$P(PATH,"?",2,9999),PATH=$P(PATH,"?")
 .D PARSEQS(QRY)
 S:$E(PATH)="/" PATH=$E(PATH,2,9999)
 S:$E(PATH,$L(PATH))="/" PATH=$E(PATH,1,$L(PATH)-1)
 S PATH=$$UNESCURL(PATH)
 S RGNETREQ("METHOD")=METHOD
 S RGNETREQ("PATH")=PATH
 S RGNETREQ("HOST")=$G(RGNETREQ("HDR","host"))_"/"_$P(PATH,"/")
 Q 0
 ; Parse query string into array named in PREF.
 ;  QS = Query string
 ;  PREF = Array reference to receive data.  Defaults to RGNETREQ("PARAMS").
PARSEQS(QS,PREF) ;
 N X,Y,Z,N,V,M
 S PREF=$G(PREF,$NA(RGNETREQ("PARAMS")))
 F X=1:1:$L(QS,"&") D
 .S Y=$P(QS,"&",X),N=$$UNESCURL($P(Y,"=")),V=$$UNESCURL($P(Y,"=",2,9999)),M=""
 .I $L(N) D
 ..S Z=$L(N,":")
 ..I Z>1 D
 ...S Y=$P(N,":",Z)
 ...S M=$S(Y="missing":"m",Y="exact":"e",Y="text":"t",1:"")
 ...S:$L(M) N=$P(N,":",1,Z-1)
 ..S Y=1+$O(@PREF@(N,""),-1)
 ..F Z=1:1:$L(V,",") D
 ...S @PREF@(N,Y,Z)=$P(V,",",Z)
 ...S @PREF@(N,Y,Z,"OPR")=M
 Q
 ; Parse body as query string values
PARSEBD(PARAMS) ;
 N X
 F X=0:0 S X=$O(RGNETREQ("BODY",X)) Q:'X  D PARSEQS(RGNETREQ("BODY",X),"PARAMS")
 Q
 ; Parse http header into array named in HREF.
PARSEHDR(VALUE,HREF) ;
 N N,V
 S HREF=$G(HREF,$NA(RGNETREQ("HDR")))
 S N=$$LOW^XLFSTR($P(VALUE,":")),V=$$TRIM^XLFSTR($P(VALUE,":",2,999))
 S:$L(N) @HREF@(N)=V
 Q
 ; Replace escaped characters in URL
UNESCURL(X) ;
 I X["%"!(X["+") D
 .N P,C,H
 .F P=1:1 S C=$E(X,P) Q:'$L(C)  D
 ..I C="+" S $E(X,P)=" "
 ..E  I C="%" S H=$E(X,P+1,P+2),$E(X,P,P+2)=$C($$DEC^XLFUTL(H,16))
 Q X
 ; Escape reserved characters
ESCAPE(VALUE) ;
 N LP
 F LP="&;amp","<;lt",">;gt",$C(9)_";nbsp","|TAB|;nbsp" D
 .S VALUE=$$SUBST^RGUT(VALUE,$P(LP,";"),"&"_$P(LP,";",2)_";")
 Q VALUE
 ; Returns true if the status code represents an error
 ;  STATUS = If not specified, the current status code is checked.
ISERROR(STATUS) ;
 S:'$D(STATUS) STATUS=+$G(RGNETRSP("STATUS"))
 Q STATUS'<400
 ; Sets http status code
 ;  STATUS = HTTP status code
 ;  INFO  = Informational text for display (by default uses the status text)
 ;  RESET = If true, clear the output buffer.  If not specified, the output
 ;          buffer is cleared only if the status code represents an error.
SETSTAT(STATUS,INFO,RESET) ;
 N TEXT
 S TEXT=$P(^RGNET(996.521,STATUS,0),U,2),RGNETRSP("STATUS")=""
 D:$G(RESET,$$ISERROR(STATUS)) RESET,ADD("<h1>"_$G(INFO,TEXT)_"</h1>")
 S RGNETRSP("STATUS")=STATUS_" "_TEXT
 Q
 ; Sets the content type
SETCTYPE(CTYPE) ;
 S RGNETRSP("CTYPE")=CTYPE
 Q
 ; Finishes a response by adding the necessary headers
ENDRSP D ADDHDR("HTTP/1.1 "_$G(RGNETRSP("STATUS"),"200 OK"),-999)
 D ADDHDR("Date: "_$$WWWDATE,-998)
 D:$D(RGNETRSP("CTYPE"))#2 ADDHDR("Content-Type: "_RGNETRSP("CTYPE")_"; charset=utf-8",-998)
 D ADDHDR("Content-Length: "_+$G(RGNETRSP("LEN")),-998)
 D ADDHDR("",0)
 Q
 ; Add to response buffer
ADD(X) N Y
 S:'$$ISERROR Y=$O(@RGNETRSP@(""),-1)+1,@RGNETRSP@(Y)=X,RGNETRSP("LEN")=RGNETRSP("LEN")+$L(X),RGNETRSP("LAST")=Y
 Q
 ; Add array to output buffer
 ; RT  = Array root
 ; EOL = End of line character(s)
ADDARY(RT,EOL) ;
 N LP
 S EOL=$G(EOL),LP=0
 F  S LP=$O(@RT@(LP)) Q:'LP  D
 .D ADD($G(@RT@(LP))_$G(@RT@(LP,0))_EOL)
 Q
 ; Add HTTP response header to output buffer
 ;  HDR = Properly formatted header
 ;  SB  = Affects the position of the header in the output.  Typically, not specified.
ADDHDR(HDR,SB) ;
 N NXT
 S SB=+$G(SB,-1)
 S:SB>0 SB=-SB
 S NXT=$O(@RGNETRSP@(SB,""),-1)+1,@RGNETRSP@(SB,NXT)=HDR_$C(13,10)
 Q
 ; Replace buffer contents at specified index, adjusting content length accordingly.
REPLACE(IDX,X) ;
 N Y
 S Y=$L(X)-$L(@RGNETRSP@(IDX)),@RGNETRSP@(IDX)=X,RGNETRSP("LEN")=RGNETRSP("LEN")+Y
 Q
 ; Returns the specified query parameter
 ; PN = Parameter name
 ; P1 = Parameter series - for duplicate parameters, specifies which among them (defaults to 1)
 ; P2 = Parameter value  - for multivalued parameters, specifies which value (defaults to 1)
GETPARAM(PN,P1,P2) ;
 Q $G(RGNETREQ("PARAMS",PN,$G(P1,1),$G(P2,1)))
 ; Initialize environment
INIT S:'($D(RGNETRSP)#2) RGNETRSP=$$TMPGBL
 D RESET
 Q
 ; Reset the output buffer
RESET K @RGNETRSP
 S (RGNETRSP("LAST"),RGNETRSP("LEN"))=0
 Q
 ; Returns the host url (e.g., www.xyz.net)
HOST(PATH,DFLT) ;
 N URL
 S URL=$G(PATH)
 S:$E(URL)="*" URL=$G(DFLT)_$E(URL,2,9999)
 Q $$CONCAT(RGNETREQ("HOST"),URL)
 ; Returns host URL including the transport protocol (e.g., http://www.xyz.net)
HOSTURL(PATH) ;
 Q $G(RGNETREQ("HDR","x-forwarded-proto"),"http")_"://"_$$HOST(.PATH)
 ; Prepend local system root to path
LOCALSYS(PATH) ;
 Q $$CONCAT("http://"_$$LOW^XLFSTR($$KSP^XUPARAM("WHERE")),.PATH)
 ; Return UUID for this system
SYSUUID() ;
 S:'$L($G(^RGNET("SYS"))) ^("SYS")=$$UUID^RGUT
 Q ^("SYS")
 ; Concatenate path to url.
CONCAT(URL,PATH) ;
 Q:'$D(PATH) URL
 F  Q:$E(URL,$L(URL))'="/"  S $E(URL,$L(URL))=""
 F  Q:$E(PATH)'="/"  S $E(PATH)=""
 Q $S($L(PATH):URL_"/"_PATH,1:URL)
 ; Date (format per RFC 1123)
WWWDATE(DT) ;
 N TZ,H,M,SN
 S:'$G(DT) DT=$$NOW^XLFDT
 S TZ=$$TZ^XLFDT,H=+$E(TZ,2,3),M=+$E(TZ,4,5),SN=$S(TZ<0:1,1:-1)
 S DT=$$FMADD^XLFDT(DT,0,H*SN,M*SN,0)
 Q $$FMTDATE^RGUTDATF(DT,"EEE, dd MMM YYYY HH:mm:ss 'GMT'")
 ; Returns true if request came from a browser
ISBROWSR() ;
 Q $G(RGNETREQ("HDR","user-agent"))["Mozilla"
 ; Attempt authentication if credentials available
 ; If REQUIRED is true, authentication must succeed.
 ; Returns true if successful
AUTH(TYPE,REQUIRED) ;
 N TP,CRED
 S TP=$G(RGNETREQ("HDR","authorization")),CRED=$P(TP," ",2),TP=$$UP^XLFSTR($P(TP," "))
 I '$L(TP),'REQUIRED Q 1
 K RGNETREQ("HDR","authorization"),DUZ
 S DUZ=0
 I '$$AUTH1 D  Q 0
 .D SETSTAT(403,"Logins Disabled")
 I '$$AUTH2 D  Q 0
 .D SETSTAT(401)
 .S:'$L(TYPE) TYPE="BASIC^BEARER"
 .F TP=1:1:$L(TYPE,U) D ADDHDR("WWW-Authenticate: "_$P(TYPE,U,TP))
 I '$$AUTH3 D  Q 0
 .D SETSTAT(403,"Credentials Expired")
 S DUZ(2)=+$$CHKDIV^XUS1
 S:'DUZ(2) DUZ(2)=$P(^XTV(8989.3,1,"XUS"),U,17)
 Q 1
AUTH1() N X,Y
 D XUVOL^XUS,XOPT^XUS
 Q '$$INHIBIT^XUSRB
AUTH2() S:TYPE="ANY" TYPE=""
 I $L(TYPE),TP'=TYPE Q 0
 I TP="BASIC" D
 .S CRED=$$DECODE^RGUTUU(CRED),CRED=$P(CRED,":")_";"_$P(CRED,":",2,9999)
 .S DUZ=$$CHECKAV^XUSRB(CRED),TYPE=TP
 E  I TP="BEARER" D
 .S DUZ=$$ISVALID^RGNETOAT(CRED),TYPE=TP
 Q DUZ
AUTH3() N XUSER
 Q '$$VCHG^XUS1
 ; Convert to pattern (Used for URL matching)
TOPTRN(NM) ;
 N P,C,X,L
 S (L,P)=""
 F X=1:1:$L(NM) D
 .S C=$E(NM,X)
 .I C="*" D TOPTRN2(".E") Q
 .I C="#" D TOPTRN2("1.N") Q
 .S L=L_C
 D:$L(P) TOPTRN2("")
 Q P
TOPTRN2(X) ;
 S:$L(L) P=P_"1"""_L_"""",L=""
 S P=P_X
 Q
 ; Compiles an access constraint expression
 ;  ACE    = An access constraint expression
 ;  SILENT = If true, suppress error output
ACECOMP(ACE,SILENT) ;
 Q:";"[$E(ACE) ""
 N POS,EXP,TKN,RES,ERR,C
 S (EXP,TKN)="",(ST,PRN)=0,SILENT=$G(SILENT)!$G(DIQUIET)
 F POS=1:1:$L(ACE)+1 D  Q:$D(ERR)
 .S C=$E(ACE,POS)
 .I C="\" S POS=POS+1,TKN=TKN_$E(ACE,POS)
 .E  I "()&!'"[C S EXP=EXP_$$ACECOMP2(TKN,.ERR)_C,TKN=""
 .E  S TKN=TKN_C
 I '$D(ERR) D
 .S RES=$$ENTRY^RGUTSTX("I "_EXP)
 .S:RES ERR=$P(RES,U,3)_" @ "_$P(RES,U,2)
 I $D(ERR) D
 .W:'SILENT ERR,!
 .S ACE=";"_ACE,EXP=""
 Q EXP
 ; Process a name token
 ;  TKN = A name token of the form <type>.<name> where <type> is one of
 ;         K = security key, O = option, P = parameter
 ;  ERR = Set to error text if an error occurs.
ACECOMP2(TKN,ERR) ;
 Q:'$L(TKN) ""
 N TP,NM,FN,RT
 S TP=$P(TKN,"."),NM=$P(TKN,".",2,999)
 S:'$L(NM) NM="?"
 S FN=$S(TP="K":"HASKEY^DIC(19.1)",TP="O":"HASOPT^DIC(19)",TP="P":"HASPRM^XTV(8989.51)",1:"")
 I '$L(FN) S ERR="Unrecognized token: "_TKN Q ""
 S RT=U_$P(FN,U,2),FN=$P(FN,U)
 I '$D(@RT@("B",NM)) S ERR=$P(@RT@(0),U)_" "_NM_" not found." Q ""
 Q "$$"_FN_"("""_NM_""")"
 ; Evaluates a compiled access constraint expression
 ;  EXP = compiled expression
 ; Returns true if access is granted
ACEEVAL(EXP) ;
 I $G(DUZ),@EXP
 Q $T
 ; Returns true if the user possesses the specified security key.
HASKEY(VL) ;
 Q $D(^XUSEC(VL,DUZ))
 ; Returns true if the user has access to the specified option.
HASOPT(VL) ;
 Q $$ACCESS^XQCHK(DUZ,VL)>0
 ; Returns true if the user has a setting of true for the specified
 ; parameter.
HASPRM(VL) ;
 Q ''$$GET^XPAR("USR^PKG^SYS",VL,,"Q")
 ; Looks up endpoint for URL
 ; Returns IEN of endpoint
URL2EP(METHOD,URL) ;
 N IEN
 S:'$L(URL) URL="/"
 S IEN=$$URL2EPX(METHOD,URL)
 S:'IEN IEN=$$URL2EPX(METHOD,URL,$E(URL))
 S:'IEN IEN=$$URL2EPX(METHOD,URL,"#")
 S:'IEN IEN=$$URL2EPX(METHOD,URL,"*")
 Q IEN
URL2EPX(METHOD,URL,URLX) ;
 N RT,FND,PTRN,IEN,URL2
 S:$E(URL,$L(URL))'="/" URL2=URL_"/"
 I '$D(URLX) D
 .S FND=$O(^RGNET(996.52,"C",METHOD,URL,0))
 .I 'FND,$D(URL2) S FND=$O(^RGNET(996.52,"C",METHOD,URL2,0))
 E  D
 .S RT=URLX,FND=0
 .F  S URLX=$O(^RGNET(996.52,"C",METHOD,URLX)) Q:$E(URLX)'=RT  D  Q:FND
 ..F IEN=0:0 S IEN=$O(^RGNET(996.52,"C",METHOD,URLX,IEN)) Q:'IEN  S PTRN=^(IEN) D:$L(PTRN)  Q:FND
 ...S:URL?@PTRN FND=IEN
 ...I 'FND,$D(URL2),URL2?@PTRN S FND=IEN
 Q FND
 ; Returns the weighted value if content type matches an accepted type,
 ; or 0 if no match.
ISCTYPE(MTYPE,ACCPT) ;
 N AT,LP,MT,R,X,Q
 S ACCPT=$TR(ACCPT," "),MTYPE=$TR(MTYPE," ")
 F LP=1:1:$L(ACCPT,",") D
 .S X=$P(ACCPT,",",LP),Q=$P(X,";",2),X=$P(X,";")
 .S Q=$S($E(Q,1,2)="q=":+$E(Q,3,99),1:1)
 .S:$L(X) AT(Q,X)=""
 Q:'$D(AT) 1
 S Q=""
 F  S Q=$O(AT(Q),-1) Q:'Q  D  Q:$D(R)
 .S AT=""
 .F  S AT=$O(AT(Q,AT)) Q:'$L(AT)  D  Q:$D(R)
 ..I AT="*/*" S R=Q Q
 ..F LP=1:1:$L(MTYPE,",") D  Q:$D(R)
 ...S MT=$P(MTYPE,",",LP)
 ...I AT=MT S R=Q Q
 ...I AT["/*",$P(AT,"/")=$P(MT,"/") S R=Q Q
 ...I AT["*/",$P(AT,"/",2)=$P(MT,"/",2) S R=Q Q
 Q $S($D(R):R,1:0)
 ; Return unique temp global reference
 ; If X is specified, returns the temp global at that index.
 ; Otherwise, returns the next available global reference.
TMPGBL(X) ;
 Q:$G(X) $NA(^TMP("RGNETWWW",$J,X))
 F  S X=$G(^TMP("RGNETWWW",$J))+1,^($J)=X,X=$NA(^($J,X)) Q:'$D(@X)
 Q X
 ; Cleanup temp globals on completion
CLEANUP N LP,TMP,EXC
 S TMP=$NA(^TMP("RGNETWWW",$J))
 I TMP'=$NA(@RGNETRSP,2) K @TMP Q
 S (@TMP,EXC)=$QS(RGNETRSP,3)
 F LP=0:0 S LP=$O(@TMP@(LP)) Q:'LP  K:LP'=EXC @TMP@(LP)
 Q
 ; Returns description
GREETING D ADDARY($NA(^RGNET(996.52,HANDLER,99)))
 Q

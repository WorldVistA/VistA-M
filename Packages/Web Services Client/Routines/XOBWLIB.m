XOBWLIB ;ALB/MJK - HWSC :: Utilities Library ;Oct 15, 2018@08:43
 ;;1.0;HwscWebServiceClient;**10001**;September 13, 2010;Build 39
 ; Original Source Code authored by the Departement of Veteran's Affairs
 ; *10001 changes (throughout) by OSEHRA/Sam Habiel 2018
 ;
 QUIT
 ;
 ;----------------------------- Public APIs ----------------------------
 ;
 ;. . . . . . . . . . . . Web Service Proxy APIs . . . . . . . . . . . .
 ;
GETFAC(XOBWSN) ; -- get web service proxy factory
 ;  Input:
 ;    XOBWSN    -   web service name  
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 QUIT ##class(xobw.WebServiceProxyFactory).%New(XOBWSN)
 ;
GETPROXY(XOBWSN,XOBSRVR) ; -- get web service proxy
 ;  Input:
 ;    XOBWSN    -   web service name
 ;    XOBSRVR   -   web server name
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 QUIT ##class(xobw.WebServiceProxyFactory).getWebServiceProxy(XOBWSN,XOBSRVR)
 ;
GENPORT(XOBY) ; -- generate http port class from WSDL during install
 QUIT $$GENPORT^XOBWD(.XOBY)
 ;
REGSOAP(XOBWSN,XOBCXT,XOBCLASS,XOBWSDL,XOBCAURL) ; -- register SOAP service
 ;  Input:
 ;    XOBWSN    -   SOAP web service name
 ;    XOBCXT    -   web service context root  
 ;    XOBCLASS  -   full class name, including package
 ;    XOBWSDL   -   file path containing WSDL document [optional]
 ;    XOBCAURL  -   'check availability' url portion to follow context root [optional]
 DO REGISTER^XOBWD(XOBWSN,1,XOBCXT,XOBCLASS,.XOBWSDL,.XOBCAURL)
 QUIT
 ;
ATTACHDR(XOBPROXY) ; -- add VistaInfoHeader to proxy object
 ; Input: 
 ;   XOBPROXY   -   web service proxy object
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 DO ATTACHDR^XOBWLIB1(.XOBPROXY)
 QUIT
 ;
UNREG(XOBWSN) ; unregister/delete REST *or* SOAP web service
 ; Input:
 ;   XOBWSN     -   web service name
 DO UNREG^XOBWD(XOBWSN)
 QUIT
 ;
 ;. . . . . . . . . . . . REST Service Request APIs . . . . . . . . . . . .
 ;
GETRESTF(XOBWSN) ; -- get REST service request factory
 ;  Input:
 ;    XOBWSN    -   web service name 
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 QUIT ##class(xobw.RestRequestFactory).%New(XOBWSN)
 ;
GETREST(XOBWSN,XOBSRVR) ; -- get REST service request
 ;  Input:
 ;    XOBWSN    -   web service name
 ;    XOBSRVR   -   web server name 
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 QUIT ##class(xobw.RestRequestFactory).getRestRequest(XOBWSN,XOBSRVR)
 ;
REGREST(XOBWSN,XOBCXT,XOBCAURL) ; -- register REST service
 ;  Input:
 ;    XOBWSN    -   REST web service name
 ;    XOBCXT    -   web service context root  
 ;    XOBCAURL  -   'check availability' url portion to follow context root [optional]
 DO REGISTER^XOBWD(XOBWSN,2,XOBCXT,"","",.XOBCAURL)
 QUIT
 ;
GET(XOBREST,XOBRSCE,XOBERR,XOBFERR) ; -- do HTTP GET method and force M/Cache error if problem encountered
 ;                                       Executes STATCHK and HTTPCHK calls.
 ; input:
 ;     XOBREST = instance of xobw.RestRequest class
 ;     XOBRSCE = resource for HTTP GET method
 ;     XOBERR  = where to store HWSC error object if problem encountered
 ;     XOBFERR = if error object created, force M/Cache error [1], otherwise return to caller [0]
 ;               [optional ; default = 1]
 IF ^%ZOSF("OS")["GT.M" S $EC=",U-USE-GETGTM,"
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 NEW XOBOK
 SET XOBOK=$$STATCHK(XOBREST.Get(XOBRSCE),.XOBERR,$GET(XOBFERR,1))
 IF XOBOK SET XOBOK=$$HTTPCHK(XOBREST,.XOBERR,$GET(XOBFERR,1))
 QUIT XOBOK
 ;
POST(XOBREST,XOBRSCE,XOBERR,XOBFERR) ; -- do HTTP POST method and force M/Cache error if problem encountered
 ;                                        Executes STATCHK and HTTPCHK calls.
 ; input:
 ;     XOBREST = instance of xobw.RestRequest class
 ;     XOBRSCE = resource for HTTP GET method
 ;     XOBERR  = where to store HWSC error object if problem encountered
 ;     XOBFERR = if error object created, force M/Cache error [1], otherwise return to caller [0]
 ;               [optional ; default = 1]
 IF ^%ZOSF("OS")["GT.M" S $EC=",U-USE-POSTGTM,"
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 NEW XOBOK
 SET XOBOK=$$STATCHK(XOBREST.Post(XOBRSCE),.XOBERR,$GET(XOBFERR,1))
 IF XOBOK SET XOBOK=$$HTTPCHK(XOBREST,.XOBERR,$GET(XOBFERR,1))
 QUIT XOBOK
 ;
POSTGTM(RETURN,HEADERS,SERVER,SERVICE,PATH,MIME,PAYLOAD)  ; PEP -- POST on GT.M *10001*
 IF ^%ZOSF("OS")["OpenM" S $EC=",U-USE-POST,"
 ; GT.M implementation of POST done by VEN/SMH
 ;
 ; Web Service Post
 ; Input:
 ;     .RETURN  - Returned data (by ref)
 ;     .HEADERS - Returned headers (by ref)
 ;     SERVER  - Server Name in file 18.12 (e.g. PEPS)
 ;     SERVICE - Service Name in file 18.02 (e.g. ORDER_CHECKS)
 ;     PATH    - URL to append (optional)
 ;     MIME    - Mime type to send (optional)
 ;     .PAYLOAD - What to send (1,2,3 subscripts etc) (required)
 ; 
 ; Output:
 ;     RETURN and HEADERS
 ;
 Q:$Q $$ALLGTM(.RETURN,.HEADERS,SERVER,SERVICE,$g(PATH),$g(MIME),.PAYLOAD,"POST")
 D ALLGTM(.RETURN,.HEADERS,SERVER,SERVICE,$g(PATH),$g(MIME),.PAYLOAD,"POST")
 QUIT
 ;     
GETGTM(RETURN,HEADERS,SERVER,SERVICE,PATH,MIME)  ; PEP -- POST on GT.M *10001*
 IF ^%ZOSF("OS")["OpenM" S $EC=",U-USE-GET,"
 Q:$Q $$ALLGTM(.RETURN,.HEADERS,SERVER,SERVICE,$g(PATH),$g(MIME),,"GET")
 D ALLGTM(.RETURN,.HEADERS,SERVER,SERVICE,$g(PATH),$g(MIME),,"GET")
 QUIT
 ;
ALLGTM(RETURN,HEADERS,SERVER,SERVICE,PATH,MIME,PAYLOAD,METHOD,AV) ; [Private] Implementation of GET and POST
 ; Input:
 ;     RETURN  - Returned data (by ref)
 ;     HEADERS - Returned headers (by ref)
 ;     SERVER  - Server Name in file 18.12 (e.g. PEPS) (or IEN)
 ;     SERVICE - Service Name in file 18.02 (e.g. ORDER_CHECKS) (or -
 ;               for availability check)
 ;     PATH    - URL to append (optional)
 ;     MIME    - Mime type to send (optional)
 ;     PAYLOAD - What to send (required for POST)
 ;     METHOD  - HTTP METHOD (required)
 ;     AV      - Check Availability Only (boolean, optional)
 ; 
 ; Output:
 ;     RETURN and HEADERS
 ;
 ; Mimicks GETREST^XOBWLIB Cache Classes --->>>
 ;
 ; Get Server IEN
 N SERVERIEN
 I +SERVER=SERVER S SERVERIEN=SERVER
 E  S SERVERIEN=+$ORDER(^XOB(18.12,"B",SERVER,0)) ; per getWebServerId
 I 'SERVERIEN S %XOBWERR=186005_U_SERVER,$EC=",UXOBW-NO-SERVER," ;##class(xobw.error.DialogError).forceError(186005_"^"_webServerName)
 ;
 ; Get Service IEN
 N SERVICEIEN
 I +SERVICE=SERVICE S SERVICEIEN=SERVICE
 E  S SERVICEIEN=+$order(^XOB(18.02,"B",SERVICE,0)) ; per getWebServiceId(webServiceName)
 I 'SERVICEIEN S %XOBWERR=186006_U_SERVICE,$EC=",UXOBW-NO-SERVICE," ; #class(xobw.error.DialogError).forceError(186006_"^"_webServiceName)
 ;
 ; Service Type must be REST
 I $P(^XOB(18.02,SERVICEIEN,0),U,2)'=2 S %XOBWERR=186007,$EC=",UXOBW-NOT-REST," ; forceError(186007)
 ;
 ; Is Web Server disabled?
 N Z S Z=^XOB(18.12,SERVERIEN,0) ; Zero node
 I '$P(Z,U,6) S %XOBWERR=186002_U_$P(Z,U),$EC=",UXOBW-SERVER-DISABLED,"  ; ##class(xobw.error.DialogError).forceError(186002_"^"_webServer.name)
 ;
 ; Is web service authorized? per getAuthorizedWebServiceId
 N SUBSERVICEIEN S SUBSERVICEIEN=$O(^XOB(18.12,SERVERIEN,100,"B",SERVICEIEN,""))
 I 'SUBSERVICEIEN S %XOBWERR=186003_U_$P(^XOB(18.02,SERVICEIEN,0),U)_U_$P(Z,U),$EC=",UXOBW-SERVICE-NOTSUBSCRIBED," ;forceError(186003_"^"_..webServiceMetadata.name_"^"_webServer.name)
 ;
 ; Is the service disabled at the service level?
 N SN S SN=^XOB(18.12,SERVERIEN,100,SUBSERVICEIEN,0) ; SN = service node
 I '$P(SN,U,6) S %XOBWERR=186004_U_$P(^XOB(18.02,SERVICEIEN,0),U)_U_$P(Z,U),$EC=",UXOBW-SERVICE-DISABLED," ; forceError(186004_"^"_..webServiceMetadata.name_"^"_webServer.name)
 ;
 ; Get Username and password if present
 ; Note: Code below different than Cache logic. Will only get un/pw if
 ; it's Yes. Cache code gets it if Yes or empty.
 N UN,PW
 I $G(^XOB(18.12,SERVERIEN,1)) D
 . S UN=$G(^XOB(18.12,SERVERIEN,200))
 . S PW=$$DECRYP^XOBWPWD($G(^XOB(18.12,SERVERIEN,300)))
 ;
 N FQDN S FQDN=$P(Z,U,4) ; IP or Domain name
 N PORT S PORT=$P(Z,U,3) ; Http Port
 N TO S TO=$P(Z,U,7) ; HTTP Timeout
 ;
 N ISTLS S ISTLS=$P($G(^XOB(18.12,SERVERIEN,3)),U) ; Is SSL/TLS on?
 I ISTLS S PORT=$P($G(^XOB(18.12,SERVERIEN,3)),U,3) ; replace port
 N TLSCERT S TLSCERT=$P($G(^XOB(18.12,SERVERIEN,3)),U,2)
 ;
 ; This is for the no-op Cache just connect to TLS config. Void that!!!
 I TLSCERT="encrypt_only" S TLSCERT=""
 ;
 N OPTIONS
 ;     OPTIONS("cert")     = Client Certificate Path
 ;     OPTIONS("key")      = Client Certificate Key
 ;     OPTIONS("password") = Client Certificate Password
 I TLSCERT]"" D
 . N FULLPATH S FULLPATH=TLSCERT
 . N PATH,FILE D SPLIT^%ZISH(FULLPATH,.PATH,.FILE)
 . S PATH=$$DEFDIR^%ZISH(PATH) ; This will fail if it doesn't exist
 . N NOEXT S NOEXT=$P(FILE,".",1,$L(FILE,".")-1)
 . N KEY S KEY=NOEXT_".key"
 . S OPTIONS("cert")=PATH_FILE
 . S OPTIONS("key")=PATH_KEY
 . N PW S PW=$$DECRYP^XOBWPWD($G(^XOB(18.12,SERVERIEN,300)))
 . I PW]"" S OPTIONS("password")=PW
 ;
 ; NB: How avialability works here is different from the Cache implementation
 ;     AV is a separate path; Cache implementation appends it to context which I think is wrong!
 N CONTEXT S CONTEXT=$G(^XOB(18.02,SERVICEIEN,200)) ; context is just the path on the server.
 I $G(AV),$G(^XOB(18.02,SERVICEIEN,201))]"" S CONTEXT=$G(^XOB(18.02,SERVICEIEN,201)) ; availability resource
 ;
 ; Create URL
 N URL S URL="http"_$S(ISTLS:"s",1:"")_"://" ; http/https://
 I $G(UN)]"" S URL=URL_UN_":"_PW_"@"         ; https://sam:boo@
 S URL=URL_FQDN_":"_PORT                     ; https://sam:boo@rxnav.nlm.nih.gov
 I $E(CONTEXT)="/" S URL=URL_CONTEXT         ;
 E  S URL=URL_"/"_CONTEXT                    ; https://sam:boo@rxnav.nlm.nih.gov/REST/interaction/list.json
 I $G(PATH)]"" S URL=URL_PATH                ; https://sam:boo@rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=207106+152923+656659
 ;
 ; Action
 ; %ZCLOSE is the Return Code from the CURL command. Success is zero.
 N %ZCLOSE S %ZCLOSE=$$%^XOBWGUX(.RETURN,METHOD,URL,.PAYLOAD,$get(MIME),TO,.HEADERS,.OPTIONS)
 ;
 ; Error from curl. Give that back to the user.
 IF %ZCLOSE S $EC=",U-CURL-"_%ZCLOSE_","
 ;
 ; Check status code to be 200.
 ; NB: I don't like this. We did get a response, so should we error?
 ; Cache code does that now.
 I '$$HTTPOK(HEADERS("STATUS")) S %XOBWERR=HEADERS("STATUS"),$EC=",UXOBWHTTP,"
 QUIT:$QUIT HEADERS("STATUS")
 QUIT
 ;
HTTPCHK(XOBREST,XOBERR,XOBFERR) ; -- check HTTP response status code
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 ; input:
 ;     XOBREST = instance of xobw.RestRequest class
 ;     XOBERR  = where to store HWSC error object if problem encountered
 ;     XOBFERR = if error object created, force M/Cache error [1], otherwise return to caller [0]
 ;               [optional ; default = 1]
 NEW XOBOK
 SET XOBOK=$$HTTPOK(XOBREST.HttpResponse.StatusCode)
 IF 'XOBOK DO
 . ; -- create http error from %Net.HttpResponse object
 . SET XOBERR=$$EOHTTP(XOBREST.HttpResponse)
 . ; -- force error if requested to by caller
 . IF $GET(XOBFERR,1) SET $ECODE=",UXOBWHTTP,"
 QUIT XOBOK
 ;
HTTPOK(XOBSCODE) ; -- is HTTP response status code an 'OK' code
 ; -- Future: Should we add more 200 series codes to the check?
 QUIT $GET(XOBSCODE)=200
 ;
 ;. . . . . . . . . . . Error Processing Helper API . . . . . . . . . . .
 ;
EOFAC(XOBPROXY) ; --  Error Object FACtory
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 ;      > finds and parses errors in partition
 ;      > builds and returns error object for easier processing
 ;
 ;  input: XOBPROXY = SOAP proxy object reference [optional]
 ; output:   XOBERR = error object
 ;
 QUIT $$EOFAC^XOBWLIB1(.XOBPROXY)
 ;
EOSTAT(XOBSO) ; -- create object error from status error object
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 NEW $ETRAP
 SET $ETRAP="D ^%ZTER HALT"
 QUIT ##class(xobw.error.ObjectError).%New(XOBSO)
 ;
EOHTTP(XOBHRO) ; -- create object error from %Net.HttpResponse object
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 NEW $ETRAP
 SET $ETRAP="D ^%ZTER HALT"
 QUIT ##class(xobw.error.HttpError).%New(XOBHRO)
 ;
ERRDISP(XOBEO) ; -- do simple error display
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 IF $GET(XOBEO)]"",XOBEO.%IsA("xobw.error.AbstractError") DO
 . DO XOBEO.display()
 QUIT
 ;
ERR2ARR(XOBEO,XOBERR) ; -- decompose error for traditional M processing
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 IF $GET(XOBEO)]"",XOBEO.%IsA("xobw.error.AbstractError") DO
 . DO XOBEO.decompose(.XOBERR)
 QUIT
 ;
ZTER(XOBEO) ; -- build error object array and call error trap
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 NEW $ETRAP,XOBEOARR
 SET $ETRAP="D ^%ZTER HALT"
 IF $GET(XOBEO)]"" DO ERR2ARR(.XOBEO,.XOBEOARR)
 DO ^%ZTER
 QUIT
 ;
STATCHK(XOBSO,XOBERR,XOBFERR) ; -- check Cache Status Object
 IF ^%ZOSF("OS")'["OpenM" S $EC=",U-UNIMPLEMENTED,"
 ; input:
 ;     XOBSO   = Cache status object
 ;     XOBERR  = where to store HWSC error object if problem encountered
 ;     XOBFERR = if error object created, force M/Cache error [1], otherwise return to caller [0]
 ;               [optional ; default = 1]
 NEW XOBOK
 SET XOBOK=$system.Status.IsOK(XOBSO)
 IF 'XOBOK DO
 . ; -- create object error from status error object
 . SET XOBERR=$$EOSTAT(XOBSO)
 . ; -- force error if requested to by caller
 . IF $GET(XOBFERR,1) SET $ECODE=",UXOBWSTATUS,"
 QUIT XOBOK
 ;
 ;. . . . . . . . . . . . . . Server Lookup APIs . . . . . . . . . .
SKEYADD(XOBWKEY,XOBWDESC,XOBERR) ; add or edit a server key name/desc (no prompting)
 ; input parameters:
 ;  XOBWKEY: name for key
 ;  XOBWDESC: (optional) brief description
 ;  XOBERR: (optional) textual error description as array node(s) starting
 ;                     at XOBERR(1) / passed by reference
 ; returns: 
 ;  >0: success (value = IEN of new or existing entry)
 ;  0: failure (did not add/edit key)
 Q $$SKEYADD^XOBWLIB1(.XOBWKEY,.XOBWDESC,.XOBERR)
 ;
SNAME4KY(XOBWKEY,XOBWSNM,XOBERR) ; get server name based on key
 ; input parameters: 
 ;  XOBWKEY: name of key to lookup
 ;  XOBWSNM: where web server name is returned / passed by reference
 ;   XOBERR: (optional) where any error is returned / passed by reference
 ;                     format: <error #>^<error text>
 ;            errors possible:
 ;                    186008^description (key does not exist)
 ;                    186009^description (server association missing)
 ; returns:
 ;   1 - successful lookup
 ;   0 - unsuccessful lookup
 ;  
 Q $$SNAME4KY^XOBWLIB1(.XOBWKEY,.XOBWSNM,.XOBERR)
 ;
 ;. . . . . . . . . . . . . . Developer Testing APIs . . . . . . . . .
 ;
SELSRV() ; -- interactive display and selection of an server
 ;  Input: None
 ; Output:
 ;         Function Value - server name
 ; -- display servers
 DO DISPSRVS
 ; -- select server
 QUIT $$GETSRV()
 ;
GETSRV() ; -- PUBLIC API: return interactive-user-selected server name
 ;            User selects a server entry in the WEB SERVER file (#18.12)
 ;  Input:
 ;    None
 ; Output:
 ;    Function Value - server name (#.01 field of file 18.12)
 ; 
 QUIT $$GETSRV^XOBWLIB1()
 ;
DISPSRVS ; -- display servers
 ;  Input:
 ;    None
 ; Output:
 ;    Screen formatted display of app servers and associated fields from file 18.12
 ;
 DO DISPSRVS^XOBWLIB1
 QUIT
 ;

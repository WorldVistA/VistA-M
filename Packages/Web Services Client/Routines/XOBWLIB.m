XOBWLIB ;ALB/MJK - HWSC :: Utilities Library ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
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
 QUIT ##class(xobw.WebServiceProxyFactory).%New(XOBWSN)
 ;
GETPROXY(XOBWSN,XOBSRVR) ; -- get web service proxy
 ;  Input:
 ;    XOBWSN    -   web service name
 ;    XOBSRVR   -   web server name
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
 QUIT ##class(xobw.RestRequestFactory).%New(XOBWSN)
 ;
GETREST(XOBWSN,XOBSRVR) ; -- get REST service request
 ;  Input:
 ;    XOBWSN    -   web service name
 ;    XOBSRVR   -   web server name 
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
 NEW XOBOK
 SET XOBOK=$$STATCHK(XOBREST.Post(XOBRSCE),.XOBERR,$GET(XOBFERR,1))
 IF XOBOK SET XOBOK=$$HTTPCHK(XOBREST,.XOBERR,$GET(XOBFERR,1))
 QUIT XOBOK
 ;
HTTPCHK(XOBREST,XOBERR,XOBFERR) ; -- check HTTP response status code
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
 ;      > finds and parses errors in partition
 ;      > builds and returns error object for easier processing
 ;
 ;  input: XOBPROXY = SOAP proxy object reference [optional]
 ; output:   XOBERR = error object
 ;
 QUIT $$EOFAC^XOBWLIB1(.XOBPROXY)
 ;
EOSTAT(XOBSO) ; -- create object error from status error object
 NEW $ETRAP
 SET $ETRAP="D ^%ZTER HALT"
 QUIT ##class(xobw.error.ObjectError).%New(XOBSO)
 ;
EOHTTP(XOBHRO) ; -- create object error from %Net.HttpResponse object
 NEW $ETRAP
 SET $ETRAP="D ^%ZTER HALT"
 QUIT ##class(xobw.error.HttpError).%New(XOBHRO)
 ;
ERRDISP(XOBEO) ; -- do simple error display
 IF $GET(XOBEO)]"",XOBEO.%IsA("xobw.error.AbstractError") DO
 . DO XOBEO.display()
 QUIT
 ;
ERR2ARR(XOBEO,XOBERR) ; -- decompose error for traditional M processing
 IF $GET(XOBEO)]"",XOBEO.%IsA("xobw.error.AbstractError") DO
 . DO XOBEO.decompose(.XOBERR)
 QUIT
 ;
ZTER(XOBEO) ; -- build error object array and call error trap
 NEW $ETRAP,XOBEOARR
 SET $ETRAP="D ^%ZTER HALT"
 IF $GET(XOBEO)]"" DO ERR2ARR(.XOBEO,.XOBEOARR)
 DO ^%ZTER
 QUIT
 ;
STATCHK(XOBSO,XOBERR,XOBFERR) ; -- check Cache Status Object
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

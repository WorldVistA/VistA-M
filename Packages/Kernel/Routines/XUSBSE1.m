XUSBSE1 ;ISF/JLI,ISD/HGW - MODIFICATIONS FOR BSE ;01/25/17  7:52
 ;;8.0;KERNEL;**404,439,523,595,522,638,659,630**;Jul 10, 1995;Build 13
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
SETVISIT(RES) ; RPC. XUS SET VISITOR - ICR #5501
 ;Returns a BSE TOKEN
 N TOKEN,O,X
 S X=$$ACTIVE^XUSER(DUZ) I $P(X,U)<1 S RES=X Q  ;User must be active
 S TOKEN=$$HANDLE^XUSRB4("XUSBSE",1)
 S ^XTMP(TOKEN,1)=$$ENCRYP^XUSRB1($$GET^XUESSO1(DUZ))
 S ^XTMP(TOKEN,3)=+$H ;Set expiration day
 L -^XTMP(TOKEN) ;Lock set in $$HANDLE^XUSRB4
 S RES=TOKEN
 Q
 ;
GETVISIT(RES,TOKEN) ; RPC. XUS GET VISITOR - ICR #5532
 ;Returns demographics for user indicated by TOKEN
 ;  or "-1^error message" if user is not permitted to visit
 ;   input  - TOKEN - token value returned by remote site
 ;   output - RES - passed by reference, contains user demographics on return
 N O,X
 S RES="",O=0
 I TOKEN="" S X=$$LOGERR("BSE NULL TOKEN") Q  ;Shouldn't come in with a null token
 L +^XTMP(TOKEN):10 I '$T Q  ; If ^XTMP is purged, token context will be lost
 I ($G(^XTMP(TOKEN,3))-$H) K ^XTMP(TOKEN) Q  ;Check expiration time, and if it has passed
 S RES=$G(^XTMP(TOKEN,1)) S:$L(RES) RES=$$DECRYP^XUSRB1(RES)
 L -^XTMP(TOKEN) ;Lock set in $$HANDLE^XUSRB4
 S:'$L(RES) X=$$LOGERR("BSE GET USER ID") ;p595
 Q
 ;
MDWS(XWBUSRNM) ; Intrinsic. Old CAPRI code, currently used by MDWS: Disable with system parameter XU522.
 ; Return 1 if a valid user, else 0.
 ;**********************************************************************************************************************
 ;***** This interface is deprecated as of patch XU*8.0*522 and will be permanently disabled with patch XU*8.0*617 *****
 ;**********************************************************************************************************************
 ; ZEXCEPT: DTIME - Kernel exemption
 N XVAL,XOPTION,XVAL522,XAPP
 S XVAL522=$$GET^XPAR("SYS","XU522",1,"Q")  ; p522 system parameter XU522 controls MDWS login disabling, logging
 D:(XVAL522="E"!(XVAL522="L")) APPERROR^%ZTER("MDWS LOGIN ATTEMPT")  ; p522 record MDWS login attempt if XU522 = E or L
 Q:(XVAL522'="L")&(XVAL522'="N") 0  ; p522 fully activate BSE unless parameter XU522 = N or L
 S DUZ("LOA")=1,DUZ("AUTHENTICATION")="NONE"
 S XAPP=+$$FIND1^DIC(8994.5,,"B","MEDICAL DOMAIN WEB SERVICES") I XAPP<1 S XAPP=""
 S DUZ("REMAPP")=XAPP_"^MEDICAL DOMAIN WEB SERVICES" ;p630
 S XVAL=$$PUT^XUESSO1($P(XWBUSRNM,U,3,99)) ; Sign in as Visitor
 I XVAL D
 . S XOPTION=$$FIND1^DIC(19,"","X","DVBA CAPRI GUI")
 . D SETCNTXT(XOPTION)
 . S DTIME=$$DTIME^XUP(DUZ)
 . S DUZ(0)=""
 . I $$USERTYPE^XUSAP(DUZ,"APPLICATION PROXY") H $R(5)
 Q $S(XVAL>0:1,1:0)
 ;
CHKUSER(INPUTSTR) ; Extrinsic. Determines if a BSE sign-on is valid - called from XUSRB
 ;   INPUTSTR - input - String of characters from client
 ;   return value - 1 if a valid user and application, else 0
 ; ZEXCEPT: DTIME - Kernel exemption
 N X,XUCODE,XUENTRY,XUSTR,XUTOKEN
 ;I +INPUTSTR=-31,INPUTSTR["DVBA_" Q 0  ; permanently shut down MDWS visitor interface
 I +INPUTSTR=-31,INPUTSTR["DVBA_" Q $$MDWS(INPUTSTR)
 I +INPUTSTR'=-35 S X=$$LOGERR("BSE LOGIN ERROR") Q 0  ; not a BSE login
 S INPUTSTR=$P(INPUTSTR,U,2,99)
 K ^TMP("XUSBSE1",$J)
 S XUCODE=$$DECRYP^XUSRB1(INPUTSTR)
 S XUENTRY=$$GETCNTXT^XUESSO2($P(XUCODE,U))
 I XUENTRY'>0 S X=$$LOGERR("BSE LOGIN ERROR - REMAPP") Q 0  ; invalid remote application
 S DUZ("LOA")=2,DUZ("AUTHENTICATION")="BSETOKEN"
 S DUZ("REMAPP")=XUENTRY_U_$$GET1^DIQ(8994.5,XUENTRY_",",.01)
 S XUTOKEN=$P(XUCODE,U,2)
 S XUSTR=$P(XUCODE,U,3,4)
 S XUENTRY=$$BSEUSER(XUENTRY,XUTOKEN,XUSTR)
 S DTIME=$$DTIME^XUP(DUZ)
 I XUENTRY'>0 S X=$$LOGERR("BSE LOGIN ERROR - USER") Q 0  ; invalid user
 Q XUENTRY
 ;
BSEUSER(ENTRY,TOKEN,STR) ; Intrinsic. Returns internal entry number for authenticated user
 ;   ENTRY - input - internal entry number in REMOTE APPLICATION file
 ;   TOKEN - input - token from authenticating site
 ;   STR   - input - remainder of input string (station #^TCP/IP port for station-based authentication)
 ;   returns - IEN for authenticated user, or 0 if not authenticated
 ; ZEXCEPT: XWBSEC - Kernel exemption, contains error message returned to GUI application
 N X,XUIEN,XUCONTXT,XUDEMOG,XCNT,XVAL,ARRAY,XUCACHE,XUCONTXT
 S XUIEN=0,XUDEMOG="",XUCONTXT=0
 ; Check for cached user authentication (p638)
 I $D(^XTMP("XUSBSE1",TOKEN)) D
 . S XUCACHE=$G(^XTMP("XUSBSE1",TOKEN)) ; Retrieve cached values
 . I $P($P(XUCACHE,U,1),".",1)<$$DT^XLFDT() K ^XTMP("XUSBSE1",TOKEN) Q  ; Do not use if expired (not from today)
 . I $P(XUCACHE,U,1)=$$HADD^XLFDT($$NOW^XLFDT(),0,0,0,600) K ^XTMP("XUSBSE1",TOKEN) Q  ; Do not use if expired (older than 600s)
 . S XUDEMOG=$P(XUCACHE,U,3,99) ; Get demographics of authenticated user
 . I '$$PUT^XUESSO1(XUDEMOG) Q  ; Set VISITOR entry, quit if failed
 . S XUIEN=$G(DUZ)
 . S XUCONTXT=$P(XUCACHE,U,2),^XUTL("XQ",$J,"DUZ(BSE)")=XUCONTXT ; Set Context Option
 . S:(XUIEN>0) ^XTMP("XUSBSE1",TOKEN)=$$NOW^XLFDT()_"^"_$G(XUCONTXT)_"^"_XUDEMOG ; Reset cache to keep authentication alive
 I (XUIEN>0)&(XUCONTXT>0) Q XUIEN  ; p638 Use cached authentication
 ;
 S XCNT=0 F  S XCNT=$O(^XWB(8994.5,ENTRY,1,XCNT)) Q:XCNT'>0  S XVAL=^(XCNT,0) D  Q:XUDEMOG'=""
 . ; CODE TO HANDLE CONNECTION TYPE AND CONNECTIONS
 . I $P(XVAL,U)="S" S XUDEMOG=$$HOME(TOKEN,XVAL,STR) Q  ; Station-number authentication
 . I $P(XVAL,U)="R" S XUDEMOG=$$XWB($P(XVAL,U,3),$P(XVAL,U,2),TOKEN) Q  ; RPC-Broker authentication
 . I $P(XVAL,U)="H" S XUDEMOG=$$POST1^XUSBSE2(.ARRAY,$P(XVAL,U,3),$P(XVAL,U,2),$P(XVAL,U,4),"xVAL="_TOKEN) Q  ; HTTP authentication
 . I $P(XVAL,U)="M" S XUDEMOG=$$M2M($P(XVAL,U,3),$P(XVAL,U,2),TOKEN) D CLOSE^XWBM2MC() Q  ; M2M-Broker authentication
 . Q
 ; if invalid set XWBSEC so an error is reported in the GUI application
 I +XUDEMOG=-1 S XWBSEC="BSE ERROR - "_$P(XUDEMOG,"^",2)
 I $L(XUDEMOG,"^")>2 D
 . S XUCONTXT=$P($G(^XWB(8994.5,ENTRY,0)),U,2)
 . S XUIEN=$$SETUP(XUDEMOG,XUCONTXT)
 S:(XUIEN>0) ^XTMP("XUSBSE1",TOKEN)=$$NOW^XLFDT()_"^"_$G(XUCONTXT)_"^"_XUDEMOG ; p638 Cache user authentication
 Q $S(XUIEN'>0:0,1:XUIEN)
 ;
XWB(SERVER,PORT,TOKEN) ; Special Broker service
 N DEMOSTR,IO,XWBTDEV,XWBRBUF
 Q $$CALLBSE^XWBTCPM2(SERVER,PORT,TOKEN)
 ;
M2M(SERVER,PORT,TOKEN) ; M2M Broker
 N DEMOGSTR,XWBCRLFL,RETRNVAL,XUSBSARR
 S DEMOGSTR=""
 N XWBSTAT,XWBPARMS,XWBTDEV,XWBNULL
 S XWBPARMS("ADDRESS")=SERVER,XWBPARMS("PORT")=PORT
 S XWBPARMS("RETRIES")=3 ;Retries 3 times to open
 ;
 I '$$OPEN^XWBRL(.XWBPARMS) Q "NO OPEN"
 S XWBPARMS("URI")="XUS GET VISITOR"
 D CLEARP^XWBM2MEZ
 D SETPARAM^XWBM2MEZ(1,"STRING",TOKEN)
 S XWBPARMS("URI")="XUS GET VISITOR"
 S XWBPARMS("RESULTS")=$NA(^TMP("XUSBSE1",$J))
 S XWBCRLFL=0
 D REQUEST^XWBRPCC(.XWBPARMS)
 I XWBCRLFL S RETRNVAL="XWBCRLFL IS TRUE" G M2MEXIT
 ;
 I '$$EXECUTE^XWBVLC(.XWBPARMS) S RETRNVAL="FAILURE ON EXECUTE" G M2MEXIT ;Run RPC and place raw XML results in ^TMP("XWBM2MVLC"
 D PARSE^XWBRPC(.XWBPARMS,"XUSBSARR") ;Parse out raw XML and place results in ^TMP("XWBM2MRPC"
 S RETRNVAL=$G(XUSBSARR(1))
M2MEXIT ;
 D CLOSE^XWBM2MEZ
 Q RETRNVAL
 ;
HOME(TOKEN,RAD,BSE) ; Call home station for token.
 ;   input TOKEN  - token to identify user to authenticating server
 ;   input RAD    - Zero node of application data from REMOTE APPLICATION file (#8994.5)
 ;   input BSE    - Station #^TCP/IP port
 ; returns        - string of demographic characteristics or "-1^error message"
 N X,XUESSO,PORT,STN,IP,STNIEN,STNPRNT
 D:$G(XWBDEBUG) LOG^XWBDLOG("ENTERED HOME BSE: "_BSE) ; DEBUG
 Q:$P(RAD,U,2)'=-1 "" ;Not setup right
 ;Set Station #, port from passed in data
 S STN=$P(BSE,U),PORT=$P(BSE,U,2),XUESSO=""
 ; Check if STN is a valid station number in the INSTITUTION file (security check)
 S STNIEN=$$LKUP^XUAF4(STN) I STNIEN=0 S XUESSO="-1^"_STN_" WAS NOT FOUND IN FILE 4" Q XUESSO
 ; Check if STN is an active facility (security check)
 I '$$ACTIVE^XUAF4(STNIEN) S XUESSO="-1^"_STN_" IS NOT AN ACTIVE VA FACILITY" Q XUESSO
 S IP=""
 ; Look for a valid cached DNS address (less than 1800 seconds old)
 S STNPRNT=$P($$PRNT^XUAF4(STN),U,2) S:'+$G(STNPRNT) STNPRNT=STN ; Convert subdivision to parent station
 S XUCACHE=$G(^XTMP("XUSBSE1",STNPRNT))
 I '$L(IP) S IP=$$IPFLOC(STNPRNT) ; Get the IP address from  HL LOGICAL LINK file (#870)
 I '$L(IP) S IP=$$SITESVC(STNPRNT) ; Get the IP address from VASITESERVICE
 I '$L(IP) S XUESSO="-1^ADDRESS FOR STN "_STN_" NOT FOUND"
 D:$G(XWBDEBUG) LOG^XWBDLOG("HOME BSE IP: "_IP_" PORT:"_PORT)
 I $L(IP) S XUESSO=$$CALLBSE^XWBTCPM2(IP,PORT,TOKEN,STN)
 D:$G(XWBDEBUG) LOG^XWBDLOG("LEAVING HOME XUESSO: "_XUESSO)
 I XUESSO="Didn't open connection." S XUESSO="-1^COULD NOT CONNECT TO STN "_STN_" USING PORT "_PORT
 I XUESSO="No Response" S XUESSO="-1^BSE TOKEN EXPIRED"
 Q XUESSO
 ;
IPFLOC(STN) ;Get the address from the station number from HL LOGICAL LINK file (#870)
 ;   input    STN - station number
 ;   returns      - IP address or null
 N XUSBSE,I,RET,ADD,IP,STNPRNT
 S STNPRNT=$P($$PRNT^XUAF4(STN),U,2) S:'+$G(STNPRNT) STNPRNT=STN ; Convert subdivision to parent station
 ; Look for station number in HL LOGICAL LINK file (#870)
 D FIND^DIC(870,,".03;.08","X",STNPRNT,,"C",,,"XUSBSE") ; ICR# 5449 "C" index lookup
 Q:+$G(XUSBSE("DILIST",0))=0 ""
 S I=0,ADD="",IP=""
 F  S I=$O(XUSBSE("DILIST","ID",I)) Q:'I  D  Q:IP
 . ;HL LOGICAL LINK file (#870) DNS DOMAIN field (#.08)
 . S ADD=XUSBSE("DILIST","ID",I,.08) I $L(ADD) D  Q:IP'=""
 . . I $$VALIDATE^XLFIPV(ADD) S IP=ADD Q  ;ICR #5844
 . . S IP=$$ADDRESS^XLFNSLK(ADD) S:IP="" IP=$$ADDRESS^XLFNSLK(ADD,"A") ; Make 2 attempts to get IP, force IPv4 on second attempt
 . . Q
 . ;HL LOGICAL LINK file (#870) MAILMAIN DOMAIN field (#.03)
 . S ADD=XUSBSE("DILIST","ID",I,.03) I $L(ADD) D  Q:IP'=""
 . . I $$VALIDATE^XLFIPV(ADD) S IP=ADD Q  ;ICR #5844
 . . S IP=$$ADDRESS^XLFNSLK("VISTA."_ADD) S:IP="" IP=$$ADDRESS^XLFNSLK("VISTA."_ADD,"A") ; Make 2 attempts to get IP, force IPv4 on second attempt
 . . Q
 I $L(IP) S ^XTMP("XUSBSE1",STNPRNT)=IP_"^"_$H ; Cache the IP address
 Q IP
 ;
SITESVC(STN) ;Get IP from the stn# from VISTASITESERVICE
 ;   input   STN - station number
 ;   returns     - IP address or null
 N DNSADD,IP,STNPRNT
 S IP=""
 S STNPRNT=$P($$PRNT^XUAF4(STN),U,2) S:'+$G(STNPRNT) STNPRNT=STN ; Convert subdivision to parent station
 S DNSADD=$$WEBADDRS(STNPRNT)
 I $L(DNSADD) S IP=$$ADDRESS^XLFNSLK(DNSADD) S:IP="" IP=$$ADDRESS^XLFNSLK(DNSADD,"A") ; Make 2 attempts to get IP, force IPv4 on second attempt
 I $L(IP) S ^XTMP("XUSBSE1",STNPRNT)=IP_"^"_$H ; Cache the IP address
 Q IP
 ;
WEBADDRS(STNNUM) ;
 N IP,URL,XUSBSE,RESULTS,I,X,POP
 D FIND^DIC(2005.2,,"1","MO","VISTASITESERVICE",,,,,"XUSBSE")
 S URL=$G(XUSBSE("DILIST","ID",1,1))
 D EN1^XUSBSE2(URL_"/getSite?siteID="_STNNUM,.RESULTS)
 S X="" F I=1:1 Q:'$D(RESULTS(I))  I RESULTS(I)["hostname>" S X=$P($P(RESULTS(I),"<hostname>",2),"</hostname>") Q
 Q X
 ;
SETUP(XUDEMOG,XUCONTXT) ; Setup user as visitor, add context option
 ;   input XUDEMOG  - string of demographic characteristics
 ;   input XUCONTXT - context option to be given to user
 ; return value = internal entry number for user, or 0
 I '$$PUT^XUESSO1(XUDEMOG) Q 0
 I $G(DUZ)'>0 Q 0
 D SETCNTXT(XUCONTXT)
 Q DUZ
 ;
SETCNTXT(XOPT) ;
 N OPT,XUCONTXT,X
 S XUCONTXT="`"_XOPT
 I $$FIND1^DIC(19,"","X",XUCONTXT)'>0 S X=$$LOGERR("BSE LOGIN ERROR - CONTEXT") Q  ;Context option not in option file
 I $G(DUZ("LOA"))=1 H $R(5)
 ;Have to use $D because of screen in 200.03 keeps FIND1^DIC from working.
 I '$D(^VA(200,DUZ,203,"B",XOPT)) D
 . ; Have to give the user a delegated option
 . N XARR S XARR(200.19,"+1,"_DUZ_",",.01)=XUCONTXT
 . D UPDATE^DIE("E","XARR")
 . ; And now she can give himself the context option
 . K XARR S XARR(200.03,"+1,"_DUZ_",",.01)=XUCONTXT
 . D UPDATE^DIE("E","XARR") ; Give context option as a secondary menu item
 . S ^XUTL("XQ",$J,"DUZ(BSE)")=XUCONTXT
 . ; But now we have to remove the delegated option
 . S OPT=$$FIND1^DIC(200.19,","_DUZ_",","X",XUCONTXT)
 . I OPT>0 D
 . . K XARR S XARR(200.19,(OPT_","_DUZ_","),.01)="@"
 . . D FILE^DIE("E","XARR")
 . . Q
 . Q
 Q
 ;
STNTEST ; tests station#-to-IP conversion (IPFLOC,WEBADDRS) used by HOME station#-based callback
 N XUSLSTI,XUSLSTV,XUSSTN,XUSIP1,XUSIP2,XUSBSE
 W !,"Broker Security Enhancement (BSE) Station Number-to-IP conversion test (for BSE"
 W !,"callbacks to home system). Note: It is not necessarily wrong if results differ"
 W !,"or are blank. 2 methods' results are listed: HL LOGICAL LINK/VISTASITESERVICE"
 ;
 D FIND^DIC(2005.2,,"1","MO","VISTASITESERVICE",,,,,"XUSBSE")
 W !!," local VISTASITESERVICE server:",!," ",$G(XUSBSE("DILIST","ID",1,1)),"",!
 K ^TMP($J,"XUSBSE1")
 DO LIST^DIC(4,,"@;.01;11;99;101","IP",,,,"D",,,$NA(^TMP($J,"XUSBSE1")))
 S XUSLSTI=0 F  S XUSLSTI=$O(^TMP($J,"XUSBSE1","DILIST",XUSLSTI)) Q:'+XUSLSTI  D
 . S XUSLSTV=^TMP($J,"XUSBSE1","DILIST",XUSLSTI,0)
 . Q:+$P(XUSLSTV,U,5)
 . S XUSSTN=$P(XUSLSTV,U,4) Q:'$$TF^XUAF4(XUSSTN)
 . S XUSIP1=$$IPFLOC(XUSSTN),XUSIP2=$$SITESVC(XUSSTN)
 . I $L(XUSIP1)!$L(XUSIP2) D
 . . W !,XUSSTN,?8,"(",$P(XUSLSTV,U,2),"): " W $S($L(XUSIP1):XUSIP1,1:"blank"),"/",$S($L(XUSIP2):XUSIP2,1:"blank")
 . . I $L(XUSIP1),$L(XUSIP2),(XUSIP1'=XUSIP2) W " ***DIFFERENT***"
 K ^TMP($J,"XUSBSE1")
 Q
LOGERR(XUSETXT) ; log an error in error trap for failed login attempts ; p595
 ; XUSETXT is the error subject line $ZE
 ; The function returns 0 if the error was screened, and 1 if an error was trapped
 N XUSAPP
 ; ZEXCEPT: XWBSEC,XUDEMOG - Kernel global variables
 S XUSAPP=$P($G(DUZ("REMAPP")),U,2)
 I $P($G(XUDEMOG),U,2)="BSE TOKEN EXPIRED" Q 0  ; screen out "TOKEN EXPIRED" errors
 I $G(XWBSEC)="BSE ERROR - BSE TOKEN EXPIRED" Q 0  ; screen out "TOKEN EXPIRED" errors
 I XUSAPP'="" S XUSETXT=XUSETXT_" ("_XUSAPP_")"
 D APPERROR^%ZTER($E(XUSETXT,1,32))
 Q 1
BSETOKEN(RET,XPHRASE) ; RPC. XUS BSE TOKEN - IA #6695
 ;Returns a string that can be passed as the XUBUSRNM parameter to the
 ;XUS SIGNON SETUP rpc to authenticate a user on a remote system. The input
 ;is an application identifier (pass phrase) that, when hashed,
 ;matches the stored hash of an authorized application in the REMOTE
 ;APPLICATION file (#8994.5) APPLICATIONCODE field (#.03)
 ; - Input - Application pass phrase
 N XAPP,XPORT,XSTA,XSTATION,XSTRING,XTOKEN
 S XAPP=$G(XPHRASE)
 I XAPP="" S RET="-1^NOT AUTHENTICATED" Q  ;Application must be authenticated
 S XAPP=$$GETCNTXT^XUESSO2(XPHRASE)
 I +XAPP=-1 S RET="-1^NOT AUTHENTICATED" Q  ;Application must be authenticated
 S XAPP=XPHRASE
 D SETVISIT(.XTOKEN)
 I +$G(XTOKEN)=-1 S RET="-1^NOT AUTHENTICATED" Q  ;User must be authenticated
 I $G(DUZ(2))="" S RET="-1^HOME STATION NOT IDENTIFIED" Q  ;User must be authenticated on valid home station
 S XSTA=$$NS^XUAF4(DUZ(2))
 S XSTATION=$P(XSTA,U,2)
 I XSTA="" S RET="-1^HOME STATION NOT IDENTIFIED" Q  ;User must be authenticated on valid home station
 S XPORT=$G(^XTMP("XUSBSE1","RPCBrokerPort"))
 I XPORT="" D
 . ; Do a VistA Exchange Site Service lookup for current station (once daily)
 . N IP,URL,XUSBSE,RESULTS,I,X,POP
 . D FIND^DIC(2005.2,,"1","MO","VISTASITESERVICE",,,,,"XUSBSE")
 . S URL=$G(XUSBSE("DILIST","ID",1,1))
 . D EN1^XUSBSE2(URL_"/getSite?siteID="_XSTATION,.RESULTS)
 . S X="" F I=1:1 Q:'$D(RESULTS(I))  I RESULTS(I)["port>" S X=$P($P(RESULTS(I),"<port>",2),"</port>") Q
 . S XPORT=X
 . I XPORT'="" S ^XTMP("XUSBSE1","RPCBrokerPort")=X
 I XPORT="" S RET="-1^RPC BROKER PORT NOT AVAILABLE" Q  ;Could not obtain port from VistA Exchange Site Service lookup
 S XSTRING=XAPP_"^"_XTOKEN_"^"_XSTATION_"^"_XPORT
 S RET="-35^"_$$ENCRYP^XUSRB1(XSTRING)
 Q
 ;

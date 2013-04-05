XUSBSE1 ;JLI/OAK-OIFO - MODIFICATIONS FOR BSE ;06/01/12  10:13
 ;;8.0;KERNEL;**404,439,523,595,522**;Jul 10, 1995;Build 10
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; SETVISIT - returns a BSE token
SETVISIT(RES) ; .RPC
 N TOKEN,O
 S TOKEN=$$HANDLE^XUSRB4("XUSBSE",1)
 S ^XTMP(TOKEN,1)=$$ENCRYP^XUSRB1($$GET^XUESSO1(DUZ))
 S ^XTMP(TOKEN,3)=+$H ;Set expiration day
 L -^XTMP(TOKEN) ;Lock set in $$HANDLE
 S RES=TOKEN
 Q
 ;
 ; GETVISIT - returns demographics for user indicated by TOKEN
 ;   output - RES - passed by reference, contains global location on return
 ;   input  - TOKEN - token value returned by remote site
GETVISIT(RES,TOKEN) ; .RPC
 N O,X
 S RES="",O=0
 ; shouldn't come in with a null token ; JLI 091218
 I TOKEN="" S X=$$LOGERR("BSE NULL TOKEN") Q  ; JLI 091218, p595 changed to function call
 ;Check expiration time, and if it has passed.
 L +^XTMP(TOKEN):10 I '$T Q  ; If ^XTMP is purged, token context will be lost
 I ($G(^XTMP(TOKEN,3))-$H) K ^XTMP(TOKEN)
 S RES=$G(^XTMP(TOKEN,1)) S:$L(RES) RES=$$DECRYP^XUSRB1(RES)
 L -^XTMP(TOKEN)
 S:'$L(RES) X=$$LOGERR("BSE LOGIN ERROR") ;p595
 Q
 ;
OLDCAPRI(XWBUSRNM) ;The old CAPRI code, disable with system parameter XU522.
 ; Return 1 if a valid user, else 0.
 ; ZEXCEPT: XTMUNIT,ZZUTPVAL - Variables set for unit testing
 N XVAL,XOPTION,XVAL522
 I '$D(XTMUNIT) D
 .S XVAL522=$$GET^XPAR("SYS","XU522",1,"Q")  ;p522 system parameter XU522 controls CAPRI login disabling, logging
 E  D
 .S XVAL522=ZZUTPVAL
 D:(XVAL522="E"!(XVAL522="L")) APPERROR^%ZTER("OLDCAPRI LOGIN ATTEMPT")  ;p522 record CAPRI login attempt if XU522 = E or L
 Q:(XVAL522'="L")&(XVAL522'="N") 0  ;p522 fully activate BSE unless param XU522 = N or L
 ;
 S XVAL=$$PUT^XUESSO1($P(XWBUSRNM,U,3,99)) ; Sign in as Visitor
 I XVAL D
 . S XOPTION=$$FIND1^DIC(19,"","X","DVBA CAPRI GUI")
 . D SETCNTXT(XOPTION) S DTIME=$$DTIME^XUP(DUZ),DUZ("REMAPP")="^Old CAPRI"
 Q $S(XVAL>0:1,1:0)
 ;
 ; CHKUSER - determines if a BSE sign-on is valid
 ;   INPUTSTR - input - String of characters from client
 ;   return value - 1 if a valid user, else 0
 ; called from XUSRB
CHKUSER(INPUTSTR) ;
 N X,XUCODE,XUENTRY,XUSTR,XUTOKEN
 ; ZEXCEPT: XUREMAPP - global variable naming the REMOTE APPLICATION in use
 ; ZEXCEPT: DTIME - Kernel exemption
 I +INPUTSTR=-31,INPUTSTR["DVBA_" Q $$OLDCAPRI(INPUTSTR)
 I +INPUTSTR'=-35 S X=$$LOGERR("BSE LOGIN ERROR") Q 0  ;p595
 S INPUTSTR=$P(INPUTSTR,U,2,99)
 K ^TMP("XUSBSE1",$J)
 S XUCODE=$$DECRYP^XUSRB1(INPUTSTR) ;TMP
 S XUCODE=$$EN^XUSHSH($P(XUCODE,U))
 S XUENTRY=$$FIND1^DIC(8994.5,"","X",XUCODE,"ACODE") D:XUENTRY>0
 . S DUZ("REMAPP")=XUENTRY_U_$$GET1^DIQ(8994.5,XUENTRY_",",.01)
 . S XUTOKEN=$P($$DECRYP^XUSRB1(INPUTSTR),U,2)
 . S XUSTR=$P($$DECRYP^XUSRB1(INPUTSTR),U,3,4)
 . S XUENTRY=$$BSEUSER(XUENTRY,XUTOKEN,XUSTR)
 . Q
 S DTIME=$$DTIME^XUP(DUZ) ;p523
 S:(XUENTRY'>0) X=$$LOGERR("BSE LOGIN ERROR") ;p595
 Q $S(XUENTRY'>0:0,1:XUENTRY)
 ;
 ; BSEUSER - returns internal entry number for authenicated user or 0
 ;   ENTRY - input - internal entry number in REMOTE APPLICATION file
 ;   TOKEN - input - token from authenticaing site
 ;   STR   - input - remainder of input string (2 pieces)
BSEUSER(ENTRY,TOKEN,STR) ;
 N X,XUIEN,XUCONTXT,XUDEMOG,XCNT,XVAL,ARRAY
 ; ZEXCEPT: XWBSEC - Kernel exemption
 S XUIEN=0,XUDEMOG=""
 S XCNT=0 F  S XCNT=$O(^XWB(8994.5,ENTRY,1,XCNT)) Q:XCNT'>0  S XVAL=^(XCNT,0) D  Q:XUDEMOG'=""
 . ; CODE TO HANDLE CONNECTION TYPE AND CONNECTIONS
 . I $P(XVAL,U)="M" S XUDEMOG=$$M2M($P(XVAL,U,3),$P(XVAL,U,2),TOKEN) D CLOSE^XWBM2MC() Q
 . I $P(XVAL,U)="R" S XUDEMOG=$$XWB($P(XVAL,U,3),$P(XVAL,U,2),TOKEN) Q
 . I $P(XVAL,U)="H" S XUDEMOG=$$POST1^XUSBSE2(.ARRAY,$P(XVAL,U,3),$P(XVAL,U,2),$P(XVAL,U,4),"xVAL="_TOKEN) Q
 . I $P(XVAL,U)="S" S XUDEMOG=$$HOME(TOKEN,XVAL,STR) Q  ;p522 station-based authentication, STR contains station number and port
 . Q
 ; if invalid set XWBSEC so an error is reported in the GUI application
 I +XUDEMOG=-1 S XWBSEC="BSE ERROR - "_$P(XUDEMOG,"^",2)
 I $L(XUDEMOG,"^")>2 D
 . S XUCONTXT=$P($G(^XWB(8994.5,ENTRY,0)),U,2)
 . S XUIEN=$$SETUP(XUDEMOG,XUCONTXT)
 S:(XUIEN'>0) X=$$LOGERR("BSE LOGIN ERROR") ;p595
 Q $S(XUIEN'>0:0,1:XUIEN)
 ;
XWB(SERVER,PORT,TOKEN) ;Special Broker service
 N DEMOSTR,IO,XWBTDEV,XWBRBUF
 Q $$CALLBSE^XWBTCPM2(SERVER,PORT,TOKEN)
 ;
M2M(SERVER,PORT,TOKEN) ;
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
 I XWBCRLFL S RETRNVAL="XWBCRLFL IS TRUE" G M2MEXIT ; S @M2MLOC="XWBCRLFL IS TRUE" Q  ; Q 0
 ;
 I '$$EXECUTE^XWBVLC(.XWBPARMS) S RETRNVAL="FAILURE ON EXECUTE" G M2MEXIT ; S @M2MLOC="failure on execute" Q  ;Run RPC and place raw XML results in ^TMP("XWBM2MVLC"
 D PARSE^XWBRPC(.XWBPARMS,"XUSBSARR") ;Parse out raw XML and place results in ^TMP("XWBM2MRPC"
 S RETRNVAL=$G(XUSBSARR(1))
M2MEXIT ;
 D CLOSE^XWBM2MEZ
 Q RETRNVAL
 ;
 ; HOME - return value = string of demographic characteristics
 ;   input SERVER - server address
 ;   input PORT   - port number for connection
 ;   input TOKEN  - token to identify user to authenticating server
 ;   input BSE    - Parts 3 and 4 of string passed in.
 ;   input RAD    - Data from Remote application file.
HOME(TOKEN,RAD,BSE) ;Call home for token.
 N X,XUESSO,PORT,STN,IP
 D:$G(XWBDEBUG) LOG^XWBDLOG("ENTERED HOME BSE: "_BSE) ; JLI 091007 DEBUG
 Q:$P(RAD,U,2)'=-1 "" ;Not setup right
 ;Set Station #, port from passed in data
 S STN=$P(BSE,U),PORT=$P(BSE,U,2),XUESSO=""
 S IP=$$IPFLOC(STN) S:'$L(IP) IP=$$SITESVC(STN) I '$L(IP) S XUESSO="-1^ADDRESS FOR STN "_STN_" NOT FOUND" S X=$$LOGERR("BSE LOGIN ERROR") ;p595
 D:$G(XWBDEBUG) LOG^XWBDLOG("HOME BSE IP: "_IP_" PORT:"_PORT)
 I $L(IP) S XUESSO=$$CALLBSE^XWBTCPM2(IP,PORT,TOKEN,STN)
 D:$G(XWBDEBUG) LOG^XWBDLOG("LEAVING HOME XUESSO: "_XUESSO)
 I XUESSO="Didn't open connection." S XUESSO="-1^COULD NOT CONNECT TO STN "_STN_" USING PORT "_PORT
 I XUESSO="No Response" S XUESSO="-1^BSE TOKEN EXPIRED"
 Q XUESSO
 ;
IPFLOC(L) ;Get the addess from the station number/HL LOGICAL LINK file
 N XUSBSE,I,RET,ADD,IP,STNPRNT
 ; next line added to handle IP input directly
 D:$G(XWBDEBUG) LOG^XWBDLOG("L IN IPFLOC: "_L)
 I L?1.3N1"."1.3N1"."1.3N1"."1.3N Q L ; JLI 091007
 S STNPRNT=$P($$PRNT^XUAF4(L),U,2) S:'+STNPRNT STNPRNT=L ;p595 try conv subdiv to parent stn
 D FIND^DIC(870,,".03;.08","X",STNPRNT,,"C",,,"XUSBSE") ;p595 IA# 5449 "C" index lookup
 Q:+$G(XUSBSE("DILIST",0))=0 ""
 S I=0,ADD="",IP=""
 F  S I=$O(XUSBSE("DILIST","ID",I)) Q:'I  D  Q:IP
 . ;New DNS field
 . S ADD=XUSBSE("DILIST","ID",I,.08) I $L(ADD) D  Q:IP'=""
 . . I ADD?1.3N1"."1.3N1"."1.3N1"."1.3N S IP=ADD Q
 . . S IP=$$ADDRESS^XLFNSLK(ADD)
 . . Q
 . ;Mail Domain
 . S ADD=XUSBSE("DILIST","ID",I,.03) I $L(ADD) D  Q:IP'=""
 . . I ADD?1.3N1"."1.3N1"."1.3N1"."1.3N S IP=ADD Q
 . . S IP=$$ADDRESS^XLFNSLK("VISTA."_ADD) S:IP="" IP=$$ADDRESS^XLFNSLK(ADD)
 . . Q
 Q IP
 ;
SITESVC(STNNUM) ;p595 Get IP from the stn# from VISTASITESERVICE
 N IP,STNPRNT
 S STNPRNT=$P($$PRNT^XUAF4(STNNUM),U,2) S:'+STNPRNT STNPRNT=STNNUM ;p595 try conv subdiv to parent stn
 S IP=$$WEBADDRS(STNPRNT) I IP'?1.3N1"."1.3N1"."1.3N1"."1.3N S IP=$$ADDRESS^XLFNSLK(IP) ;p595
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
 ; SETUP - setup user as visitor, add context option
 ; return value = internal entry number for user, or 0
 ;   input XUDEMOG  - string of demographic characteristics
 ;   input XUCONTXT - context option to be given to user
SETUP(XUDEMOG,XUCONTXT) ;
 I '$$PUT^XUESSO1(XUDEMOG) Q 0
 I $G(DUZ)'>0 Q 0
 D SETCNTXT(XUCONTXT)
 Q DUZ
 ;
SETCNTXT(XOPT) ;
 N OPT,XUCONTXT,X
 S XUCONTXT="`"_XOPT
 I $$FIND1^DIC(19,"","X",XUCONTXT)'>0 S X=$$LOGERR("BSE LOGIN ERROR") Q  ; context option not in option file
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
 W !,"callbacks to home system). Note: it's not necessarily wrong if results differ"
 W !,"or are blank. 2 methods' results are listed: HL LOGICAL LINK/VISTASITESERVICE"
 ;
 D FIND^DIC(2005.2,,"1","MO","VISTASITESERVICE",,,,,"XUSBSE")
 W !!," local VISTASITESERVICE server:",!," ",$G(XUSBSE("DILIST","ID",1,1)),"",!
 ;
 K ^TMP($J,"XUSBSE1")
 DO LIST^DIC(4,,"@;.01;11;99;101","IP",,,,"D",,,$NA(^TMP($J,"XUSBSE1")))
 S XUSLSTI=0 F  S XUSLSTI=$O(^TMP($J,"XUSBSE1","DILIST",XUSLSTI)) Q:'+XUSLSTI  D
 . S XUSLSTV=^TMP($J,"XUSBSE1","DILIST",XUSLSTI,0)
 . Q:+$P(XUSLSTV,U,5)
 . S XUSSTN=$P(XUSLSTV,U,4) Q:'$$TF^XUAF4(XUSSTN)
 . S XUSIP1=$$IPFLOC(XUSSTN),XUSIP2=$$SITESVC(XUSSTN)
 . W !,XUSSTN,?8,"(",$P(XUSLSTV,U,2),"): " I $L(XUSIP1)!$L(XUSIP2) W $S($L(XUSIP1):XUSIP1,1:"blank"),"/",$S($L(XUSIP2):XUSIP2,1:"blank") I $L(XUSIP1),$L(XUSIP2),(XUSIP1'=XUSIP2) W " ***DIFFERENT***"
 K ^TMP($J,"XUSBSE1")
 Q
LOGERR(XUSETXT) ; log an error in error trap for failed login attempts ; p595
 ; XUSETXT is the error subject line $ZE
 ; The function returns 0 if the error was screened, and 1 if an error was trapped
 N XUSAPP
 ; ZEXCEPT: XWBSEC - Kernel exemption
 ; ZEXCEPT: XUDEMOG - Kernel exemption
 S XUSAPP=$P($G(DUZ("REMAPP")),U,2)
 I $P($G(XUDEMOG),U,2)="BSE TOKEN EXPIRED" Q 0  ; screen out "TOKEN EXPIRED" errors
 I $G(XWBSEC)="BSE ERROR - BSE TOKEN EXPIRED" Q 0  ; screen out "TOKEN EXPIRED" errors
 I XUSAPP'="" S XUSETXT=XUSETXT_" ("_XUSAPP_")"
 D APPERROR^%ZTER($E(XUSETXT,1,32))
 Q 1

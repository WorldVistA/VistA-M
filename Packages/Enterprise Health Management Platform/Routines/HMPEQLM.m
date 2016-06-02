HMPEQLM ;SLC/MJK,ASMR/RRB - Event Queue Manager;30-JUN-2014
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; -- main entry point for HMPM EVT QUE MGR
 N HMPSRV,HMPCSTRM,HMPDOM,HMPFIL,HMPWAIT,HMPDFN,HMPLIM
 ;
 D DFLTS
 ;
 S HMPSRV=$$GETSRV($G(HMPSRV))
 Q:$G(HMPSRV)<1
 ;
 S:$G(HMPDOM)="" HMPDOM="ALL"
 S:$G(HMPFIL)="" HMPFIL="A"
 D EN^VALM("HMPM EVT QUE MGR")
 Q
 ;
HDR ; -- header code
 N X,SRV0,SRVNM,LASTUP,REPEAT,FILLER  K VALMHDR
 S $P(FILLER," ",80)=" "
 S SRV0=$G(^HMP(800000,+$G(HMPSRV),0))
 S SRVNM=$P(SRV0,"^"),LASTUP=$P(SRV0,"^",2),REPEAT=$P(SRV0,"^",4)
 S X="       Server: "_SRVNM_$E(FILLER,1,30-$L(SRVNM))_"Last Update: "_LASTUP
 S:REPEAT X=X_" x"_REPEAT
 S VALMHDR(1)=X
 S X=$E(FILLER,1,44)_"End of Queue: "
 S X=X_$S(HMPCSTRM]"":$P(HMPCSTRM,"~",3)_"-"_$G(^XTMP(HMPCSTRM,"last")),1:"n/a")
 S VALMHDR(2)=X
 S VALMHDR(3)="  Last Stream: "_HMPCSTRM
 S X="Event Filters: "
 S X=X_"State="_$S(HMPFIL="A":"All",HMPFIL="W":"Waiting",1:"Processed")
 S X=X_"   Domain="_HMPDOM_$S(HMPDOM="ALL"!(HMPDOM["sync"):"",1:$S($G(^XTMP("HMP-off",HMPDOM)):" (stopped)",1:" (active)"))
 S X=X_"   Max="_HMPLIM
 S X=X_$S($G(HMPDFN):"   Patient="_HMPDFN,1:"")
 S VALMHDR(4)=X
 Q
 ;
INIT ; -- init variables and list array
 S:'$G(HMPLIM) HMPLIM=$$LIMIT
 D BUILD
 D HDR
 D MSG
 Q
 ;
BUILD ; -- build list
 N SEQ,SEQNODE,X,PARAMS,HMPEVTS,HMPCNT
 S HMPEVTS=$NA(^TMP("HMPM EVT QUE MGR",$J))
 K @HMPEVTS
 ;
 S PARAMS("server")=HMPSRV
 S PARAMS("domain")=HMPDOM
 S PARAMS("filter")=HMPFIL
 S PARAMS("dfn")=$G(HMPDFN)
 S PARAMS("max")=HMPLIM
 ;
 D EVTS^HMPEQ(HMPEVTS,.PARAMS)
 S HMPCSTRM=$G(@HMPEVTS@("stream"),"**** No Stream Found ****")
 ;
 S HMPWAIT=0
 D KILL
 S (VALMCNT,HMPCNT)=0
 S HMPI=0 F  S HMPI=$O(@HMPEVTS@("events",HMPI)) Q:'HMPI  D
 . S SEQNODE=$G(@HMPEVTS@("events",HMPI,"node"))
 . S SEQ=$G(@HMPEVTS@("events",HMPI,"sequence"))
 . S HMPCNT=HMPCNT+1
 . S X=""
 . S X=$$SETFLD^VALM1($J(HMPCNT,3),X,"ID")
 . I '$P(SEQNODE,"^",6) S HMPWAIT=1,X=$$SETFLD^VALM1("*",X,"STATE")
 . S X=$$SETFLD^VALM1($J(SEQ,5),X,"SEQ")
 . S X=$$SETFLD^VALM1(SEQNODE,X,"NODE")
 . D SET(X,SEQNODE)
 ;
 I VALMCNT=0 D NOROWS^HMPEQ("No events to display for specified criteria")
 K VALMBG
 S VALMBG=1
 K @HMPEVTS
 Q
 ;
SET(X,IDX) ; -- set the ListMan array and indexes
 K VALMCNT
 S VALMCNT=VALMCNT+1
 S @VALMAR@(VALMCNT,0)=X
 S @VALMAR@("IDX",VALMCNT,HMPCNT)=IDX
 S @VALMAR@("ENTRY",HMPCNT)=IDX
 Q
 ;
KILL ; -- kill off build data
 K @VALMAR
 ; clean up video control data
 D KILL^VALM10()
 Q
 ;
MSG ; -- set default message
 K VALMSG
 S VALMSG=$S(HMPWAIT:"   * waiting to be processed",1:"")
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ; -- save user criteria fro 7 days
 Q:'$G(DUZ)
 N NODE,X
 S NODE="HMPM EVT QUE MGR"
 K ^DISV(DUZ,NODE)
 F X="HMPSRV","HMPDOM","HMPFIL","HMPDFN","HMPLIM" I $G(@X)]"" S ^DISV(DUZ,NODE,X)=@X
 Q
 ;
DFLTS ; -- get user defaults
 Q:'$G(DUZ)
 N NODE,X
 S NODE="HMPM EVT QUE MGR"
 Q:'$D(^DISV(DUZ,NODE))
 S X=0 F  S X=$O(^DISV(DUZ,NODE,X)) Q:X=""  S @X=^(X)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
REFRESH ; -- refresh display
 ; protocol: HMPM EVT QUE REFRESH
 D WAIT^DICD
 D BUILD
 D HDR
 D MSG
 S VALMBCK="R"
 Q
 ;
CS ; -- change server
 ; protocol: HMPM EVT QUE CHANGE SERVER
 D FULL^VALM1
 N SRV
 S SRV=$$GETSRV^HMPDJFSM()
 I +SRV>0 S HMPSRV=+SRV
 D REFRESH
 Q
 ;
CD ; -- change domain
 ; protocol: HMPM EVT QUE CHANGE DOMAIN
 N DIR,Y,X,DOMAINS,I,LIST,Y
 D FULL^VALM1
 D EVNTYPS^HMPDJFSM(.LIST)
 S I=0 F  S I=$O(LIST(I)) Q:'I  S Y(LIST(I))=""
 F X="syncNoop","syncDomain","syncError","syncStart","syncDone" S Y(X)=""
 S X="",I=0
 F  S X=$O(Y(X)) Q:X=""  S I=I+1 S DOMAINS(I)=X
 S DOMAINS(999)="ALL"
 S X="S^"
 S I=0 F  S I=$O(DOMAINS(I)) Q:I=""  S X=X_I_":"_$G(DOMAINS(I))_";"
 S DIR(0)=X
 S DIR("A")="Select Domain"
 S DIR("B")="ALL"
 D ^DIR
 I +Y>0 S HMPDOM=$G(DOMAINS(+Y))
 D REFRESH
 Q
 ;
LIMIT() ; -- get freshness events display limit
 ; -- set high testing in order to see many event types 
 Q $S($$PROD^XUPROD():10,1:200)
 ;
FILTER ; -- allows user to filter list
 ; protocol: HMPM EVT QUE FILTER
 N DIR,Y,X
 D FULL^VALM1
 S X="S^"
 S X=X_"A:All events;"
 S X=X_"P:Processed events;"
 S X=X_"W:Waiting to be processed events"
 S DIR(0)=X
 S DIR("A")="Select Event State"
 S DIR("B")="All events"
 D ^DIR
 I Y="P" S HMPFIL=Y
 I Y="W" S HMPFIL=Y
 I Y="A" S HMPFIL=Y
 D REFRESH
 Q
 ;
SELPT ; select patient
 ; protocol" HMPM EVT QUE SELECT PATIENT
 D FULL^VALM1
 N Y,DIC
 S DIC="^DPT("
 S DIC(0)="AEMQ"
 D ^DIC
 S HMPDFN=$S(+Y>0:+Y,1:"")
 D REFRESH
 Q
 ;
CM ; change max
 ; protocol: HMPM EVT QUE CHANGE MAX LISTED
 D FULL^VALM1
 N DIR
 S DIR(0)="N^10:1000:0"
 S DIR("B")=$$LIMIT
 S DIR("A")="Set Limit: "
 D ^DIR
 I +Y>0 S HMPLIM=+Y
 D REFRESH
 Q
 ;
DETAIL ; -- detailed display
 ; protocol: HMPM EVT QUE DISPLAY DETAILS
 N HMPI,VALMY,HMPDASH,POST,DOMAIN,HMPREF,HMPDATA
 S $P(HMPDASH,"=",80)=""
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"OS")
 S HMPI=+$O(VALMY(""))
 I HMPI>0 D
 . S HMPREF="HMPDATA"
 . S POST=$G(@VALMAR@("ENTRY",HMPI))
 . W !!,HMPDASH
 . W !!,"Posted Event Data: ",POST
 . I $P(POST,"^",5) D
 . . K HMPDATA
 . . S HMPDATA(1,"label")="Added To Stream"
 . . S HMPDATA(1,"value")=$$GETIME($P(HMPCSTRM,"~",3),$P(POST,"^",5))
 . . D RENDER
 . ;
 . I $P(POST,"^",6) D
 . . K HMPDATA
 . . S HMPDATA(1,"label")="Processed Time"
 . . S HMPDATA(1,"value")=$$GETIME($P(HMPCSTRM,"~",3),$P(POST,"^",6))
 . . I $P(POST,"^",6)<$P(POST,"^",5) D
 . . . S HMPDATA(2,"label")=""
 . . . S HMPDATA(2,"value")="       - time before 'add' time means processed on a different date"
 . . D RENDER
 . ;
 . ; -- domain info parsing and display
 . S DOMAIN=$P(POST,"^",2)
 . ;
 . I +POST D PAT(HMPREF,+POST),RENDER
 . I 'POST,DOMAIN="patient"!(DOMAIN="pt-select") D PAT(HMPREF,+$P(POST,"^",3)),RENDER
 . ;
 . I DOMAIN="med"!(DOMAIN="order") D MED(HMPREF,+$P(POST,"^",3)),RENDER
 . I DOMAIN="consult" D CONSULT(HMPREF,+$P(POST,"^",3)),RENDER
 . ; -- TODO: Need to understand HL7-type messages parsed in XQOR^HMPEVNT
 . ;I DOMAIN="document" D TIU(+$P(POST,"^",3))
 . ;I DOMAIN="lab" D LAB()
 . ;I DOMAIN="image" D IMAGE()
 . ;
 . I DOMAIN="visit" D
 . . N IEN
 . . S IEN=$P(POST,"^",3)
 . . I $E(IEN)="H" D ADM(HMPREF,+$E(IEN,2,999)),RENDER Q
 . . D VISIT(HMPREF,+IEN),RENDER
 . ;
 . I DOMAIN="appointment" D APPT(HMPREF,$P(POST,"^",3)),RENDER
 . ;
 . I DOMAIN="user" D USER(HMPREF,+$P(POST,"^",3)),RENDER
 . ;
 . I DOMAIN="roster" D ROSTER(HMPREF,+$P(POST,"^",3)),RENDER
 . ;
 . ; -- HMP PATIENT OBJECT (#800000.1) domains
 . I DOMAIN="auxiliary" D AUX(HMPREF,+$P(POST,"^",3)),RENDER
 . I DOMAIN="diagnosis" D DIAG(HMPREF,+$P(POST,"^",3)),RENDER
 . I DOMAIN="roadtrip" D ROAD(HMPREF,+$P(POST,"^",3)),RENDER
 . I DOMAIN="task" D TASK(HMPREF,+$P(POST,"^",3)),RENDER
 . ;
 . W !!,HMPDASH
 . D PAUSE^VALM1
 ;
 K VALMBCK
 S VALMBCK="R"
 Q
 ;
GETIME(DATE,SECS) ; -- get time
 N X
 S X=$$FMTH^XLFDT(DATE),$P(X,",",2)=SECS
 Q $P($$HTE^XLFDT(X,"S"),"@",2)
 ;
PAT(HMPZ,DFN) ; -- get patient info
 N VA,HMPY,VAROOT
 S VAROOT="HMPY"
 D DEM^VADPT
 K @HMPZ
 S @HMPZ@(1,"label")="Patient Short ID"
 S @HMPZ@(1,"value")=$G(VA("BID"))
 Q
 ;
MED(HMPZ,ORDER) ; -- display order info
 N IEN,ORDABLE,CNT
 K @HMPZ
 S (CNT,IEN)=0
 F  S IEN=$O(^OR(100,+$G(ORDER),.1,IEN)) Q:'IEN  S ORDABLE=+$G(^(IEN,0)) D
 . S CNT=CNT+1
 . S @HMPZ@(CNT,"label")="Orderable"
 . S @HMPZ@(CNT,"value")=$P($G(^ORD(101.43,ORDABLE,0)),"^")
 Q
 ;
TIU(HMPZ,IEN) ; -- get TIU document type
 K @HMPZ
 S @HMPZ@(1,"label")="Document Type"
 S @HMPZ@(1,"value")=$$GET1^DIQ(8925.1,+$$GET1^DIQ(8925,IEN_",",.01)_",",.01)
 Q
 ;
USER(HMPZ,IEN) ; -- get user name
 K @HMPZ
 S @HMPZ@(1,"label")="User"
 S @HMPZ@(1,"value")=$$GET1^DIQ(200,IEN_",",.01)
 Q
 ;
ROSTER(HMPZ,IEN) ; -- get roster name
 K @HMPZ
 S @HMPZ@(1,"label")="Roster"
 S @HMPZ@(1,"value")=$$GET1^DIQ(800001.2,IEN_",",.01)
 Q
 ;
 ; -- TODO: is this real or just a dev anomaly
AUX(HMPZ,IEN) ; -- get auxiliary uid
 K @HMPZ
 S @HMPZ@(1,"label")="Auxiliary UID"
 S @HMPZ@(1,"value")=$$GET1^DIQ(800000.1,IEN_",",.01)
 Q
 ;
 ; -- TODO: is this real or just a dev anomaly
DIAG(HMPZ,IEN) ; -- get diagnosis uid
 K @HMPZ
 S @HMPZ@(1,"label")="Diagnosis UID"
 S @HMPZ@(1,"value")=$$GET1^DIQ(800000.1,IEN_",",.01)
 Q
 ;
 ; -- TODO: is this real or just a dev anomaly
ROAD(HMPZ,IEN) ; -- get roadtrip uid
 K @HMPZ
 S @HMPZ@(1,"label")="Road Trip UID"
 S @HMPZ@(1,"value")=$$GET1^DIQ(800000.1,IEN_",",.01)
 Q
 ;
TASK(HMPZ,IEN) ; -- get task uid
 K @HMPZ
 S @HMPZ@(1,"label")="Task UID"
 S @HMPZ@(1,"value")=$$GET1^DIQ(800000.1,IEN_",",.01)
 Q
 ;
CONSULT(HMPZ,IEN) ; -- get consult date
 K @HMPZ
 S @HMPZ@(1,"label")="Consult Date/Time"
 S @HMPZ@(1,"value")=$$GET1^DIQ(123,IEN_",",.01)
 Q
 ;
VISIT(HMPZ,IEN) ; -- get visit date/time
 K @HMPZ
 S @HMPZ@(1,"label")="Visit date/time"
 S @HMPZ@(1,"value")=$$GET1^DIQ(9000010,IEN_",",.01)
 Q
 ;
ADM(HMPZ,IEN) ; -- get admission date/time
 K @HMPZ
 S @HMPZ@(1,"label")="Admission date/time"
 S @HMPZ@(1,"value")=$$GET1^DIQ(405,IEN_",",.01)
 Q
 ;
APPT(HMPZ,MAP) ; -- get appointment data/time and clinic
 N IENS
 S IENS=+$P(MAP,";",3)_","_+$P(MAP,";",2)_","
 K @HMPZ
 S @HMPZ@(1,"label")="Appointment date/time"
 S @HMPZ@(1,"value")=$$GET1^DIQ(2.98,IENS,.001)
 S @HMPZ@(2,"label")="Clinic"
 S @HMPZ@(2,"value")=$$GET1^DIQ(2.98,IENS,.01)
 Q
 ;
RENDER ; -- write info
 N I
 S I=0 F  S I=$O(HMPDATA(I)) Q:'I  W !,"  o  ",$G(HMPDATA(I,"label")),": ",$G(HMPDATA(I,"value"))
 Q
 ;
SHOWHMPN ; -- show HMP global nodes
 ; protocol: HMPM EVT QUE SHOW TEMP GLOBALS
 D FULL^VALM1
 D EN^HMPEQLM2($G(HMPSRV))
 D REFRESH
 Q
 ;
FSHRPT ; -- show overall freshness report
 ; protocol: HMPM EVT QUE FRESHNESS REPORT
 D FULL^VALM1
 D EN^HMPEQLM1($G(HMPSRV))
 D REFRESH
 Q
 ;
EMERSTOP ; -- stop freshness
 ; protocol: HMPM EVT QUE EMERGENCY STOP (not distributed)
 D FULL^VALM1
 ;D EMERSTOP^HMPDJFSM
 D REFRESH
 Q
 ;
RSTRTFR ; -- re-start freshness
 ; protocol: HMPM EVT QUE RESTART FRESHNESS (not distributed)
 D FULL^VALM1
 ;D RSTRTFR^HMPDJFSM
 D REFRESH
 Q
 ;
GETSRV(DFLT) ; Return the IEN for the server to monitor
 N DIC,Y
 S DIC="^HMP(800000,",DIC(0)="AEMQ",DIC("A")="Select HMP server instance: "
 I $G(DFLT) S DIC("B")=$P($G(^HMP(800000,$G(DFLT),0)),"^")
 D ^DIC
 Q +Y
 ;

XTMLOG ;JLI/FO-OAK - LOG4M M LOGGING UTILITY ;2017-07-25  10:37 AM
 ;;2.4;LOG4M;;Jul 25, 2017;Build 3
 ; 
 ; Main Author: Joel Ivey, Ph.D. from 2007-2012
 ; Various Changes throughout by Sam Habiel, Pharm.D. 2012-2017
 ; Includes some public domain code written by Kevin Muldrum
 ;
 ; Routine provides logging capability similar in various
 ; respects to Log4J.
 ;
 ; TODO (sam): I added SAVEARR b/c I didn't realize the DEBUG and INFO
 ;             can expand out arrays. It needs to be deprecated. HOWEVER,
 ;             DEBUG and INFO don't work with sockets. So that needs to be fixed
 ;             first!
 ; TODO (sam): I removed Joel's ability for the socket to become a server,
 ;             rather than a client. I couldn't ever get it to work. I should
 ;             try harder next time and support both Server and Client models.
 ;
 D:$t(^%ut)]"" EN^%ut("XTMLT1",3)
 Q
 ;
INITFILE(DIRREF,FILEREF,NAME) ; jli .SR -- Configuration is read a file (DIRREF is the directory, and FILEREF is the filename)
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 N HOSTGLOB
 S HOSTGLOB=$NA(^TMP("XTMLOG1",$J)) K @HOSTGLOB S @HOSTGLOB@(0)=""
 I '$$FTG^%ZISH(DIRREF,FILEREF,$NA(@HOSTGLOB@(1)),3) Q:$Q 0 Q
 N % S %=$$INITIAL(HOSTGLOB,$G(NAME,"XTMLOG"),XTLOGLIN)
 Q:$Q % Q
 ;
FILEINIT(NAMEFLD) ; jli .SR -- called as extrinsic function
 ; NAMEFLD - input - Name of entry in LOG4M CONFIG file (#8992.7 )
 ;                   to be used for setting up logging
 ; returns - 0 if initiating logging failed
 ;           1 if initiating logging was successful
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 N XTMLIEN,XTMLACTV,XTMLRES,XTMLERR,XTMLARR,XVAL
 ; ZEXCEPT: XTLOGINP - KILLED IN ENDLOG
 S XTMLIEN=$O(^XTV(8992.7,"B",NAMEFLD,0)) I XTMLIEN'>0 Q:$Q 0 Q
 ; get data from the LOG4M CONFIG file
 D GETS^DIQ(8992.7,XTMLIEN_",",".02:.06;3.01:3.03","I","XTMLRES","XTMLERR")
 S XTMLARR=$NA(XTMLRES(8992.7,XTMLIEN_","))
 ; quit if logging set to NO or it is not there
 I ($G(@XTMLARR@(.02,"I"))="N")!($G(@XTMLARR@(.02,"I"))="") Q 0
 ; Following change made to make different fields for print or mail at request of DBA for files
 ;S XVAL=@XTMLARR@(.07,"I") I (XVAL="M")!(XVAL="P") S XTLOGINP(NAMEFLD,"OUTTYPE")=XVAL,XTLOGINP(NAMEFLD,"OUTSPECS")=@XTMLARR@(.08,"I") ;121228
 S XVAL=@XTMLARR@(3.01,"I") I (XVAL="M")!(XVAL="P") S XTLOGINP(NAMEFLD,"OUTTYPE")=XVAL S:XVAL="M" XTLOGINP(NAMEFLD,"OUTSPECS")=@XTMLARR@(3.02,"I") S:XVAL="P" XTLOGINP(NAMEFLD,"OUTSPECS")=@XTMLARR@(3.03,"I") ; 121228
 I @XTMLARR@(.02,"I")="E" Q $$INITEASY($G(@XTMLARR@(.03,"I")),$G(@XTMLARR@(.04,"I")),NAMEFLD,XTLOGLIN,$G(@XTMLARR@(.05,"I")),$G(@XTMLARR@(.06,"I")))
 N % S %=$$INITIAL($NA(@XTMLARR@(1)),NAMEFLD,XTLOGLIN)
 Q:$Q % Q
 ;
INITGLOB(HOSTGLOB,NAME,XTLOGLIN) ; Configuration data is read under a global root - HOSTGLOB is a closed global root
 I '$D(XTLOGLIN) S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 N % S %=$$INITIAL(HOSTGLOB,$G(NAME,"XTMLOG"),XTLOGLIN)
 Q:$Q % Q
 ;
INITNONE(NAME) ; No configuration data to read - use defaults - console and global logging
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 N % S %=$$INITIAL("",$G(NAME,"XTMLOG"),"",XTLOGLIN)
 Q:$Q % Q
 ;
INITEASY(CONFIG,LEVEL,NAME,XTLOGLIN,XTMLROUS,XTMLUSRS) ;
 ; for INITEASY indicate the type of appenders desired as a series of ';'-pieces with names or first
 ; letters to identify the appender type [C(onsole), (G)lobal, and S(ocket)].
 ;    Global and Socket may have additional specifications separated by a Comma after the name
 ;    indicator
 ;       Global  -- Top Subscript under XTMP, if not specified "XTMLOG" is the default
 ;       Socket  -- Port number for output of the logging data, if not specified 8025 is the default
 ;
 ;    use of D INITEASY^XTMLOG("C;G,LOGDATA;S,127.0.0.1:9450","WARN") would have logging sent to
 ;            the console,
 ;            stored under ^XTMP("LOGDATA",  for a week, and
 ;            sent out on a socket at port 9450 on the current system in real time
 ;            for calls with priority or level at WARN or above.
 ;
 ;  XTMLROUS - An optional string containing a comma-separated list of routine names or namespaces,
 ;            namespaces are indicated by an asterick following the namespace characters.
 ;
 I '$D(XTLOGLIN) N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S CONFIG="*"_CONFIG I $G(LEVEL)'="" S CONFIG=CONFIG_";,"_LEVEL
 N % S %=$$INITIAL(CONFIG,$G(NAME,"XTMLOG"),XTLOGLIN,$G(XTMLROUS),$G(XTMLUSRS))
 Q:$Q % Q
 ;
INITIAL(HOSTGLOB,NAME,XTLOGLIN,XTMLROUS,XTMLUSRS) ;
 N XX,TESTLIST,I,X,XTCMLCNT,XTMLROU,XTMLCNT,XTMLRCNT
 N XTLOGSET
 ; ZEXCEPT: XTLOGINP - KILLED IN ENDLOG
 I $G(XTMLUSRS)'="",(","_XTMLUSRS_",")'[(","_DUZ_",") Q 0 ; DON'T LOG FOR THIS USER
 I $G(XTLOGLIN)="" S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S NAME=$G(NAME,"XTMLOG"),XTMLROUS=$G(XTMLROUS)
 I $G(HOSTGLOB)'="",$E(HOSTGLOB)'="*" D PARSE(NAME,HOSTGLOB,.XTLOGINP) I '$D(XTLOGINP) Q 0
 S TESTLIST="FATAL^ERROR^WARN^INFO^DEBUG",XTLOGSET=""
 I $E(HOSTGLOB)="*" D EASYSET($E(HOSTGLOB,2,99),NAME,.XTLOGINP)
 D DEFAULTS(NAME,.XTLOGINP) ; set defaults if values not present
 F I=1:1:5 S X=$P(TESTLIST,U,I) S XTLOGSET=XTLOGSET_","_I I X=XTLOGINP(NAME,"PRIORITY") Q
 S XTLOGINP(NAME,"LOGSET")=XTLOGSET_",",XTLOGINP(NAME,"COUNT")=0
 S XTMLRCNT=0 F I=1:1 S XTMLROU=$P($G(XTMLROUS),",",I) Q:XTMLROU=""  S XTMLRCNT=XTMLRCNT+1,XTLOGINP(NAME,"ROUS",XTMLRCNT)=XTMLROU,XTLOGINP(NAME,"ROUS")=XTMLRCNT
 Q 1
 ;
CHKRLST(LOCATION,ROUNAME) ; function - indicates whether ROUNAME is among selected routines for logging
 I $O(@LOCATION@("ROUS",0))'>0 Q 1
 N I,VAL,XTMLRNAM
 S VAL=0 F I=0:0 S I=$O(@LOCATION@("ROUS",I)) Q:I'>0  D  Q:VAL
 . I @LOCATION@("ROUS",I)["*" S XTMLRNAM=$P(@LOCATION@("ROUS",I),"*") I $E(ROUNAME,1,$L(XTMLRNAM))=XTMLRNAM S VAL=1
 . I @LOCATION@("ROUS",I)'["*",@LOCATION@("ROUS",I)=ROUNAME S VAL=1
 . Q
 Q VAL
 ;
STOPLOG(XTLOGNAM,OUTTYPE,OUTSPECS) ; JUST ANOTHER NAME FOR ENDLOG
 D ENDLOG($G(XTLOGNAM),$G(OUTTYPE),$G(OUTSPECS))
 Q
 ;
ENDLOG(XTLOGNAM,OUTTYPE,OUTSPECS) ; OUTTYPE, AND OUTSPECS ARE OPTIONAL - REMOVES LOGNAM FROM LOGGING
 ; ZEXCEPT: XTLOGINP,XTMTCPIO - KILLED HERE, SET ELSEWHERE
 S XTLOGNAM=$G(XTLOGNAM,"XTMLOG")
 I $G(OUTTYPE)="M"!($G(XTLOGINP(XTLOGNAM,"OUTTYPE"))="M") D SENDMAIL(XTLOGNAM,$S($G(OUTSPECS)'="":OUTSPECS,$G(XTLOGINP(XTLOGNAM,"OUTSPECS"))'="":XTLOGINP(XTLOGNAM,"OUTSPECS"),1:""))
 I $G(OUTTYPE)="P"!($G(XTLOGINP(XTLOGNAM,"OUTTYPE"))="P") D PRINTIT(XTLOGNAM,$S($G(OUTSPECS)'="":OUTSPECS,$G(XTLOGINP(XTLOGNAM,"OUTSPECS"))'="":XTLOGINP(XTLOGNAM,"OUTSPECS"),1:""))
 I $D(XTLOGINP(XTLOGNAM,"PORT")) D CLOSE^%ZISTCP
 K XTLOGINP(XTLOGNAM)
 K XTMTCPIO ; This variable's presence indicates that we have a current connexion.
 Q
 ;
EASYSET(CONFIG,NAME,XTLOGINP) ;
 N X
 F  Q:CONFIG=""  S X=$P(CONFIG,";"),CONFIG=$P(CONFIG,";",2,99) D
 . I $E(X)="C" D SETCONSO("C",NAME,.XTLOGINP)
 . I $E(X)="G" D SETGLOB("G",$P(X,",",2),NAME,.XTLOGINP)
 . I $E(X)="S" D SETSOCK("S",$P(X,",",2),NAME,.XTLOGINP)
 . I $E(X)="," D SETLEVEL($P(X,",",2),NAME,.XTLOGINP)
 . Q
 Q
 ;
DEFAULTS(NAME,XTLOGINP) ; XTLOGINP is passed by reference
 I '$D(XTLOGINP(NAME,"PRIORITY")) S XTLOGINP(NAME,"PRIORITY")="DEBUG" ; default priority is DEBUG
 I '$D(XTLOGINP(NAME,"APPENDER")) D SETCONSO("A",NAME,.XTLOGINP) ; default is CONSOLEAPPENDER
 Q
 ;
SETCONSO(ID,NAME,XTLOGINP) ;
 N NODE
 S NODE=$NA(XTLOGINP(NAME,"APPENDER",ID))
 S @NODE@("TYPE")="CONSOLEAPPENDER",@NODE@("LAYOUT")="PATTERNLAYOUT"
 S @NODE@("LAYOUT.CONVERSIONPATTERN")="%d %-5p %L %F - %m%n"
 Q
 ;
SETGLOB(ID,SUBSCRIP,NAME,XTLOGINP) ;
 N NODE,INFO
 S NODE=$NA(XTLOGINP(NAME,"APPENDER",ID))
 S @NODE@("TYPE")="GLOBAL",@NODE@("LAYOUT")="PATTERNLAYOUT"
 S @NODE@("LAYOUT.CONVERSIONPATTERN")="%d %-5p %L %F - %m%n"
 S SUBSCRIP=$S($G(SUBSCRIP)="":"XTMLOG",1:SUBSCRIP)
 S:'$D(INFO("$H")) INFO("$H")=$H
 ;N XTMLOGDT,FORMAT S FORMAT="{yyMMdd.HHmmss",XTMLOGDT=$$GETDATE^XTMLOG1(.INFO,.FORMAT)
 N XTMLOGDT S XTMLOGDT=$$NOW^XLFDT()
 S @NODE@("CLOSEDROOT")=$NA(^XTMP(SUBSCRIP,DUZ,XTMLOGDT,$J)) ; use current $H as constant and $J
 S ^XTMP(SUBSCRIP,0)=$$FMADD^XLFDT(DT,7)_U_DT ; Mark it to be saved for a week
 Q
 ;
SETSOCK(ID,PORT,NAME,XTLOGINP) ;
 ; ZEXCEPT: XTMTCPIO Set here, killed in ENDLOG
 N NODE
 S NODE=$NA(XTLOGINP(NAME,"APPENDER",ID))
 S @NODE@("TYPE")="SOCKETAPPENDER",@NODE@("LAYOUT")="PATTERNLAYOUT"
 S @NODE@("LAYOUT.CONVERSIONPATTERN")="%d %-5p %L %F - %m%n"
 ; S PORT=$S($G(PORT)="":8025,1:PORT)
 S @NODE@("PORT")=PORT
 ; D START^XTMLOSKT(PORT) ; Start socket running if it isn't already
 N HOST S HOST=$P(PORT,":")
 N REALPORT S REALPORT=$P(PORT,":",2)
 D
 . I $D(XTMTCPIO) QUIT
 . N IO ; protect our precious IO
 . N POP
 . D CALL^%ZISTCP(HOST,REALPORT,0)
 . I 'POP S XTMTCPIO=IO
 ; IO gets restored back. XTMTCPIO is now the TCP device
 I $D(XTMTCPIO) D
 . N $ES,$ET S $ET="D CLOSE^%ZISTCP S $EC="""""
 . I +$SY=47 U XTMTCPIO        ; GT.M
 . I +$SY=0 U XTMTCPIO:(::"S") ; Cache
 . W "Connected",$C(13,10),!
 . D CRFLUSH^XTMLOG1
 QUIT
 ;
SETLEVEL(LEVEL,NAME,XTLOGINP) ;
 N X
 S X=$$UP^XLFSTR($E(LEVEL)),X=$S(X="D":5,X="I":4,X="W":3,X="E":2,X="F":1,1:5)
 S XTLOGINP(NAME,"PRIORITY")=$P("FATAL^ERROR^WARN^INFO^DEBUG",U,X)
 Q
 ;
PARSE(NAME,GLOBREF,RESULTS) ; parse configuration file - RESULTS is passed by reference
 N XTMROOT,FILTYPE,INDEX,XLINE
 N APPENDER,APPENDID,APPENDTY,I,REST
 S FILTYPE="PROPERTIES"
 S INDEX="" F  S INDEX=$O(@GLOBREF@(INDEX)) Q:INDEX=""  S XLINE=$G(@GLOBREF@(INDEX)) S:XLINE="" XLINE=$G(@GLOBREF@(INDEX,0)) I XLINE'="" S:XLINE["<?xml" FILTYPE="XML" Q
 ;
 I FILTYPE="XML" D ENTRY^XTMLOPAR(NAME,GLOBREF,.RESULTS) Q  ; Handle xml separately
 ;
 S INDEX="" F  S INDEX=$O(@GLOBREF@(INDEX)) Q:INDEX=""  S XLINE=$G(@GLOBREF@(INDEX)) S:XLINE="" XLINE=$G(@GLOBREF@(INDEX,0)) D
 . S XLINE=$P(XLINE,"#") Q:XLINE=""
 . ; have to get the rootlogger info first
 . I '$D(XTMROOT) Q:$$UP^XLFSTR(XLINE)'["ROOTLOGGER"  D  Q
 . . S XLINE=$P(XLINE,"=",2),XLINE=$TR(XLINE," ","")
 . . S RESULTS(NAME,"PRIORITY")=$$UP^XLFSTR($P(XLINE,",")),XTMROOT=""
 . . F  S XLINE=$P(XLINE,",",2,99) Q:XLINE=""  S RESULTS(NAME,"APPENDER",$$UP^XLFSTR($P(XLINE,",")))=""
 . . Q
 . S APPENDER=$P($$UP^XLFSTR(XLINE),"APPENDER.",2),REST=$P(XLINE,"=",2,99),APPENDER=$P(APPENDER,"=")
 . S APPENDID=$P(APPENDER,"."),APPENDTY=$P(APPENDER,".",2,99)
 . I APPENDTY="" S APPENDTY=$P(REST,".",$L(REST,".")) D
 . . N STR,STR1,STR2 S STR="CONSOLEAPPENDER^ROLLINGFILEAPPENDER",STR2="CONSOLE^ROLLFILE"
 . . F I=1:1 S STR1=$P(STR,U,I) Q:STR1=""  I $$UP^XLFSTR(APPENDTY)=STR1 S RESULTS(NAME,"APPENDER",APPENDID,"TYPE")=$E(STR1,1,8) Q
 . . I STR1="" S RESULTS(NAME,"APPENDER",APPENDID,"TYPE")="UNKNOWN"
 . . Q
 . I APPENDTY="LAYOUT" S RESULTS(NAME,"APPENDER",APPENDID,APPENDTY)=$$UP^XLFSTR($P(REST,".",$L(REST,".")))
 . E  S RESULTS(NAME,"APPENDER",APPENDID,APPENDTY)=REST
 . Q
 Q
 ;
ENABLED(NAME) ; .SR returns 1 if NAME is active -- USAGE $$ENABLED^XTMLOG1(NAME)
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 Q $S($D(XTLOGINP(NAME)):1,1:0)
 ;
DEBNABLD(NAME) ; .SR  returns 1 if DEBUG is enabled, otherwise zero
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 Q XTLOGINP(NAME,"LOGSET")[",5,"
 ;
INFNABLD(NAME) ;
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 Q XTLOGINP(NAME,"LOGSET")[",4,"
 ;
WARNABLD(NAME) ;
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 Q XTLOGINP(NAME,"LOGSET")[",3,"
 ;
ERRNABLD(NAME) ;
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 Q XTLOGINP(NAME,"LOGSET")[",2,"
 ;
FATNABLD(NAME) ;
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 Q XTLOGINP(NAME,"LOGSET")[",1,"
 ;
DEBUG(MESG,VARS,XTMLOARR) ; .SR
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 I '$D(XTLOGINP) Q
 N XTLOGINF
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S XTLOGINF("PRIORITY")="DEBUG"
 D LOG(MESG,5,XTLOGLIN,$G(VARS),$G(XTMLOARR))
 Q
 ;
INFO(MESG,VARS,XTMLOARR) ; .SR
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 I '$D(XTLOGINP) Q
 N XTLOGINF
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S XTLOGINF("PRIORITY")="INFO"
 D LOG(MESG,4,XTLOGLIN,$G(VARS),$G(XTMLOARR))
 Q
 ;
WARN(MESG,VARS,XTMLOARR) ; .SR
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 I '$D(XTLOGINP) Q
 N XTLOGINF
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S XTLOGINF("PRIORITY")="WARN"
 D LOG(MESG,3,XTLOGLIN,$G(VARS),$G(XTMLOARR))
 Q
 ;
ERROR(MESG,VARS,XTMLOARR) ; .SR
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 I '$D(XTLOGINP) Q
 N XTLOGINF
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S XTLOGINF("PRIORITY")="ERROR"
 D LOG(MESG,2,XTLOGLIN,$G(VARS),$G(XTMLOARR))
 Q
 ;
FATAL(MESG,VARS,XTMLOARR) ; .SR
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 I '$D(XTLOGINP) Q
 N XTLOGINF
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S XTLOGINF("PRIORITY")="FATAL"
 D LOG(MESG,1,XTLOGLIN,$G(VARS),$G(XTMLOARR))
 Q
 ;
 ; VEN/SMH - EP to save arrays...
SAVEARR(IN,OUT) ; .SR
 ; ZEXCEPT: XTLOGINP - CREATED IN INITIAL, KILLED IN ENDLOG
 I '$D(XTLOGINP) Q
 N XTLOGINF
 N XTLOGLIN S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 I XTLOGLIN["SAVE" S XTLOGLIN=$P($STACK($STACK-2,"PLACE")," ")
 S XTLOGINF("PRIORITY")="DEBUG"
 I $D(OUT) M @OUT=@IN QUIT
 D LOG(,5,XTLOGLIN,IN,,1)
 QUIT
 ;
 ;
LOG(MESG,SET,XTLOGLIN,VARS,XTMLOARR,SAVE) ; .SR  entry point for logging an item
 ; this will be ignored unless SETUP^XTMLOG has been called previously
 ; MESG - any text that should be recorded for the current location
 ;        (Required)
 ;
 ; SET - a set number if desired (if none is specified, it will always
 ;       be logged when logging is active) set numbers may be integer
 ;       values used to indicate a group of logging calls which are
 ;       similar and should be active at the same time.  Using SETS a
 ;       number of log points may be set up, but only those in an
 ;       active set, or with no set specified will be recorded.  Thus,
 ;       input data might be logged in set 1, values associated with a
 ;       process might be set 2, etc. Specific sets that are active are
 ;       specified through the SET parameter in the SETUP call.
 ; SAVE - If we want to save the array in a global or just print it out.
 ;
 I '$D(XTLOGINP) Q
 N APPENDID,APPNAME,APPTYPE,NAME,XTMECNT,XTMGLOB
 ; ZEXCEPT: XTLOGINF,XTLOGINP
 I $G(XTLOGLIN)="" S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 N XTMACTIV
 S NAME="" F  S NAME=$O(XTLOGINP(NAME)) Q:NAME=""  D
 . I $G(XTLOGINP(NAME,"LOGSET"))'="",$G(SET)'="",XTLOGINP(NAME,"LOGSET")'[(","_SET_",") Q  ; only process if set is in those specified or is not specified
 . I '$$CHKRLST($NA(XTLOGINP(NAME)),$P(XTLOGLIN,"^",2)) Q
 . S XTMACTIV(NAME)=""
 . Q
 I '$D(XTMACTIV) Q
 ;
 I $D(XTLOGINP) S NAME="" F  S NAME=$O(XTMACTIV(NAME)) Q:NAME=""  D
 . S XTLOGINP(NAME,"COUNT")=$G(XTLOGINP(NAME,"COUNT"))+1
 . S XTLOGINF("PRIORITY")=$S($D(SET):$P("FATAL^ERROR^WARN^INFO^DEBUG",U,SET),1:"    ")
 . S XTLOGINF("$H")=$H,XTLOGINF("LOCATION")=XTLOGLIN
 . S XTLOGINF("COUNT")=XTLOGINP(NAME,"COUNT")
 . I $G(SAVE) S XTLOGINF("SAVE")=1
 . S APPENDID=""
 . F  S APPENDID=$O(XTLOGINP(NAME,"APPENDER",APPENDID)) Q:APPENDID=""  D
 . . S APPNAME="APPENDER",APPTYPE=XTLOGINP(NAME,APPNAME,APPENDID,"TYPE")
 . . I $T(@($E(APPTYPE,1,8)_"^XTMLOG1"))'="" D @($E(APPTYPE,1,8)_"^XTMLOG1($NA(XTLOGINP(NAME,APPNAME,APPENDID)),.XTLOGINF,$G(MESG),$G(VARS),$G(XTMLOARR))") I 1
 . . E  I '$G(XTMECNT) S $ZE="APPENDER *"_APPTYPE_"* NOT SUPPORTED IN XTMLOG1" D ^%ZTER S XTMECNT=1 ; indicate that appender is not available
 . . Q
 . Q
 Q
 ;
SENDMAIL(XTMLOGID,RECIP) ; internal - used to generate an e-mail report.
 N XMY,XMSUB,XMTEXT,XTMMAIL,XTI
 I $G(RECIP)="" S XMY(DUZ)=""
 E  F XTI=1:1 Q:$P(RECIP,";",XTI)=""  S XMY($P(RECIP,";",XTI))=""
 S XTMMAIL=$NA(^TMP($J,"XTMLOG")) K @XTMMAIL
 S XMSUB="Logged Data: "_XTMLOGID,XMTEXT="^TMP($J,""XTMLOG"","
 I '$$SETGLOB1(XTMLOGID,XTMMAIL) Q  ; NO GLOBAL DATA TO SEND
 D ^XMD
 Q
 ;
PRINTIT(XTMLOGID,LOC) ; internal - LOC is printer specification in format for IOP
 N GLOBLOC,IOP,I
 S GLOBLOC=$NA(^TMP($J,"XTMLOG")) K @GLOBLOC
 I '$$SETGLOB1(XTMLOGID,GLOBLOC) Q  ; NO GLOBAL DATA TO SEND
 I $G(LOC)'="" S IOP=LOC D ^%ZIS U IO
 F I=0:0 S I=$O(@GLOBLOC@(I)) Q:I'>0  W !,^(I)
 I $G(LOC)'="" D ^%ZISC
 Q
 ;
SETGLOB1(XTMLOGID,GLOBLOC) ; internal - move current data into output format
 ; GLOBLOC is a closed global reference under which the output will be stored without zero nodes
 N ROOT,NCNT,X1,X2,X3,X4
 ; ZEXCEPT: XTLOGINP - CREATED ON INITIALIZATION, KILLED IN ENDLOG
 S ROOT=$G(XTLOGINP(XTMLOGID,"APPENDER","G","CLOSEDROOT"))
 I ROOT="" Q 0 ; NO GLOBAL REFERENCE - SO NO DATA
 S NCNT=0
 ; X1=CURRENT DATE/TIME X2=LOG SEQUENCE NUMBER X3=LINE^ROUTINE X4=COUNT IN CURRENT LOGGING
 S X1="" F  S X1=$O(@ROOT@(X1)) Q:X1=""  S X2="" F  S X2=$O(@ROOT@(X1,X2)) Q:X2=""  S X3="" F  S X3=$O(@ROOT@(X1,X2,X3)) Q:X3=""  S X4="" F  S X4=$O(@ROOT@(X1,X2,X3,X4)) Q:X4=""  S NCNT=NCNT+1,@GLOBLOC@(NCNT)=@ROOT@(X1,X2,X3,X4)
 Q NCNT>0
 ;
REALERR ; entry to log a real error
 N XTLOGLIN,NAME,XTLOGINF,MESG
 ; ZEXCEPT: XTLOGINP - CREATED ON INITIALIZATION, KILLED IN ENDLOG
 S XTLOGLIN=$P($STACK($STACK-1,"PLACE")," ")
 S MESG="Encountered Error: "_$ZE
 S XTLOGINF("PRIORITY")="FATAL"
 D LOG(MESG,1) S NAME="" F  S NAME=$O(XTLOGINP(NAME)) Q:NAME=""  D ENDLOG(NAME)
 S $ETRAP=""
 G ERR^ZU
 Q
 ; [Public Interactive Entry Points]
 ; View Global Logs
VIEW G VIEW^XTMLOG1
DISPLAY G DISPLAY^XTMLOG1
VIEWLOG G VIEWLOG^XTMLOG1
LOGVIEW G LOGVIEW^XTMLOG1
 ; Clear Global Logs
CLEAR G CLEAR^XTMLOG1

XOBVPOST ;; ld,mjk/alb - VistaLink Post-Init ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
EN ; -- add post-init code here
 NEW XOBCFG,XOBOS
 SET XOBOS=$$GETOS^XOBVTCP()
 SET XOBCFG=0
 ;
 ; -- add config if Cache NT
 IF XOBOS="OpenM-NT" SET XOBCFG=$$CFG()
 ;
 ; -- add params entry
 DO PARMS(XOBCFG)
 ;
 ; -- add STARTUP task if OpenM-NT and on Windows
 IF XOBOS="OpenM-NT",$$SYSOS^XOBVLIB(XOBOS)="NT" DO SCHEDOPT
 ;
 ; -- add XOBVTESTER,APPLICATION PROXY user if not present
 DO ADDPROXY("XOBVTESTER,APPLICATION PROXY")
 ;
 QUIT
 ;
 ;
CFG() ; -- add default config if not present
 NEW DIC,X,Y,XOBDA,XOBNEW
 ;
 ; -- DEFAULT configuration --
 SET DIC="^XOB(18.03,"
 SET DIC(0)="LX"
 SET X="DEFAULT"
 DO ^DIC
 ; -- quit if lookup failed
 IF Y=-1 GOTO CFGQ
 ;
 SET XOBDA=+Y
 SET XOBNEW=$PIECE(Y,U,3)
 ;
 ; -- add default port to multiple
 IF XOBNEW,'$$PORTS(XOBDA) GOTO CFGQ
 ;
CFGQ ;
 QUIT +$GET(XOBDA)
 ;
 ;
PORTS(XOBDA) ; -- add 8000 port
 NEW XOBOK,XOBNEW,DIC,DIE,DR,X,DA,Y
 ;
 ; -- set 0th of multiple is needed
 IF $DATA(^XOB(18.03,1,"PORTS",0))=0 SET ^XOB(18.03,1,"PORTS",0)="^18.031^^"
 ;
 SET DA(1)=XOBDA
 SET DIC="^XOB(18.03,"_XOBDA_",""PORTS"","
 SET DIC(0)="LX"
 SET X=8000
 DO ^DIC
 ;
 ; -- quit if lookup failed
 IF Y=-1 SET XOBOK=0 GOTO PORTSQ
 SET XOBNEW=$PIECE(Y,U,3)
 ;
 ; -- if multiple entry is new, set port to NOT startup when config is started
 ;    (site should change to startup explicitly)
 IF XOBNEW DO
 . SET DA(1)=XOBDA
 . SET DA=+Y
 . SET DR=".02////0"
 . SET DIE="^XOB(18.03,"_XOBDA_",""PORTS"","
 . DO ^DIE
 ;
 SET XOBOK=1
PORTSQ ;
 QUIT XOBOK
 ;
 ;
PARMS(XOBCFG) ; -- add parameter entry
 NEW DIC,X,Y,DIE,DA,DR,XOBBOX,XOBDA,XOBMULI,XOBNEW
 ;
 ; -- box-pair name, no ien
 SET XOBBOX=$PIECE($$GETENV^XOBVTCP(),U,4)
 ; 
 ; -- Top-Level Parameters --
 SET DIC="^XOB(18.01,",DIC(0)="LXZ",X=$$DOMAIN() DO ^DIC
 ;
 ; -- quit if lookup failed or if already exists
 IF Y=-1 GOTO PARMSQ
 ;
 SET XOBDA=+Y
 SET XOBNEW=0
 IF $PIECE(Y(0),U,2)="",$PIECE(Y(0),U,3)="" SET XOBNEW=1
 ;
 ; -- set basic parameters (HEARTBEAT RATE and LATENCY DELTA)
 IF XOBNEW DO
 . SET DA=XOBDA
 . SET DR=".02////180;.03////180"
 . SET DIE="^XOB(18.01,"
 . DO ^DIE
 ;
 ; -- Listeners Multiple --
 ;
 ; -- quit if no config passed in (ie. not Cache NT) 
 IF '$GET(XOBCFG) GOTO PARMSQ
 ;
 ; -- set oth of multiple is needed
 IF $DATA(^XOB(18.01,1,"CONFIG",0))=0 SET ^XOB(18.01,1,"CONFIG",0)="^18.012P^^"
 ;
 SET DA(1)=XOBDA
 SET DIC="^XOB(18.01,"_XOBDA_",""CONFIG"","
 SET DIC(0)="LX"
 SET X=XOBBOX
 DO ^DIC
 ;
 ; -- quit if lookup failed or if already exists
 IF Y=-1 GOTO PARMSQ
 ;
 SET XOBMULI=+Y
 SET XOBNEW=$PIECE(Y,U,3)
 ;
 ; -- set listener config default
 IF XOBNEW DO
 . SET DA(1)=XOBDA
 . SET DA=XOBMULI
 . SET DR=".02////"_XOBCFG
 . SET DIE="^XOB(18.01,"_XOBDA_",""CONFIG"","
 . DO ^DIE
 ;
PARMSQ ;
 QUIT
 ;
 ;
DOMAIN() ; -- get account's domain entry
 ;
 QUIT $$KSP^XUPARAM("WHERE")
 ;
 ;
SCHEDOPT ;-- Schedule XOBV LISTENER STARTUP option in TaskMan
 ;
 ;  This procedure will schedule the XOBV LISTENER STARTUP option
 ;  in the OPTION SCHEDULING file (#19.2).
 ;
 NEW XOBMSG,XOBOIEN,XOBSIEN
 ;
 ;-- XOBOIEN = IEN (OPTION file), XOBSIEN = IEN (OPTION SCHEDULING file)
 SET (XOBOIEN,XOBSIEN)=0
 ;
 DO BMES^XPDUTL(">>> Scheduling the XOBV LISTENER STARTUP option...")
 ;
 ;-- Check that option was added to OPTION file #19 during installation
 SET XOBOIEN=$$FIND1^DIC(19,"","BX","XOBV LISTENER STARTUP","","","")
 ;
 ;-- Error XOBMSG and quit if option was not added
 IF 'XOBOIEN DO  QUIT
 . SET XOBMSG(1)=""
 . SET XOBMSG(2)=">>> Error: Option XOBV LISTENER STARTUP was not created in the OPTION (#19)"
 . SET XOBMSG(3)="           file during the KIDS installation.  Please reinstall."
 . DO BMES^XPDUTL(.XOBMSG)
 ;
 ;-- Check if option was already scheduled
 SET XOBSIEN=$$CHKOPT(XOBOIEN)
 ;
 ;-- Display option and quit if option was previously added
 IF XOBSIEN DO  QUIT
 . DO BMES^XPDUTL(">>> The XOBV LISTENER STARTUP option has previously been scheduled:")
 . DO DSPLYOP(XOBSIEN)
 ;
 ;-- Schedule the option
 SET XOBSIEN=$$FILEOPT(XOBSIEN,XOBOIEN,,,,"S")
 IF XOBSIEN DO
 . DO BMES^XPDUTL(">>> The XOBV LISTENER STARTUP option has been scheduled as follows:")
 . DO DSPLYOP(XOBSIEN)
 ELSE  DO
 . SET XOBMSG(1)=">>> Error: There was an error scheduling the XOBV LISTENER STARTUP option."
 . SET XOBMSG(2)="           Please schedule this option using 'Schedule/Unschedule Options'"
 . SET XOBMSG(3)="           in the Taskman Management menu."
 . DO BMES^XPDUTL(.XOBMSG)
 QUIT
 ;
 ;
CHKOPT(IEN) ;-- Check if option is already scheduled
 ;
 ;  Input:
 ;    IEN     -  IEN of option in OPTION file (#19)
 ;
 ; Output:
 ;    XOBSIEN -  IEN of option in OPTION SCHEDULING file (#19.2) or zero if it does not exist
 ;
 NEW X,X1,X2,XOBARY,XOBI,XOBIEN2
 SET (X1,X2,XOBI,XOBIEN2)=0
 DO FIND^DIC(19.2,"","@;.01I;9I","","XOBV LISTENER STARTUP","*","B","","","XOBARY")
 SET X=+$PIECE($GET(XOBARY("DILIST",0)),"^")
 FOR  SET XOBI=$ORDER(XOBARY("DILIST","ID",X,XOBI)) QUIT:'XOBI  DO
 . IF XOBI=.01,$GET(XOBARY("DILIST","ID",X,XOBI))=IEN SET X1=1
 . IF XOBI=9,$GET(XOBARY("DILIST","ID",X,XOBI))["S" SET X2=1
 . IF X1,X2 SET XOBIEN2=+$GET(XOBARY("DILIST",2,X))
 QUIT XOBIEN2
 ;
 ;
DSPLYOP(IEN) ;-- Display fields from OPTION SCHEDULING file (#19.2)
 ;
 ;  Input:
 ;    IEN  -  IEN of record in file #19.2
 ;
 ; Output:
 ;    Display of fields in record
 ;
 QUIT:'$GET(IEN)
 NEW DA,DIC,DIQ
 SET DIC="^DIC(19.2,",DA=IEN,DIQ(0)="CAR"
 DO MES^XPDUTL("")
 DO EN^DIQ
 DO BMES^XPDUTL("")
 QUIT
 ;
 ;
FILEOPT(XOBIEN,XOBOPT,XOBQUE,XOBDEV,XOBRSCH,XOBSPARM)   ;-- Schedule the option
 ;
 ;-- File a new record in file #19.2 or edit existing
 ;
 ;  Input:
 ;    XOBIEN   -   IEN from record in file #19.2 if it exists
 ;    XOBOPT   -   IEN of option (file #19); (required)
 ;    XOBQUE   -   Queued to run at what time; (optional)
 ;    XOBDEV   -   Device for queued job output; (optional)
 ;    XOBRSCH  -   Rescheduling frequency; (optional)
 ;    XOBSPARM -   Special queuing; (optional)
 ;
 ; Output:
 ;    Function Value - Returns IEN of record on success, 0 on failure
 ;
 NEW XOBFDA,XOBFDAI,XOBERR,XOBIENS
 ;
 SET XOBIEN=+$GET(XOBIEN)
 ;
 ;-- If record doesn't already exist, create new
 IF XOBIEN SET XOBIENS=XOBIEN_","
 ELSE  SET XOBIENS="+1,"
 ;
 ;-- Set up array with field values
 SET XOBFDA(19.2,XOBIENS,.01)=$GET(XOBOPT)
 SET XOBFDA(19.2,XOBIENS,2)=$GET(XOBQUE)
 SET XOBFDA(19.2,XOBIENS,3)=$GET(XOBDEV)
 SET XOBFDA(19.2,XOBIENS,6)=$GET(XOBRSCH)
 SET XOBFDA(19.2,XOBIENS,9)=$GET(XOBSPARM)
 ;
 IF XOBIEN DO
 . DO FILE^DIE("","XOBFDA","XOBERR")
 . IF $DATA(XOBERR) SET XOBIEN=0
 ELSE  DO
 . DO UPDATE^DIE("","XOBFDA","XOBFDAI","XOBERR")
 . IF '$DATA(XOBERR) SET XOBIEN=$GET(XOBFDAI(1))
 ;
 QUIT $SELECT($GET(XOBIEN)>0:XOBIEN,1:0)
 ;
ADDPROXY(XOBANAME) ; add application proxy if not present
 ; depends on XU*8*361
 NEW XOBID,XOBMSG,XOBSUBER,XOBSUBTX,XOBLINE
 ;
 ; if already present don't add
 QUIT:(+$$APFIND^XUSAP(XOBANAME))>0
 ;
 SET XOBID=$$CREATE^XUSAP(XOBANAME,"","XOBV VISTALINK TESTER")
 IF (+XOBID)>0 DO
 . SET XOBMSG(1)=" Added new Kernel Application Proxy User '"_XOBANAME_"'."
 . SET XOBMSG(2)="  ::This application proxy user account is used in the VistALink sample web"
 . SET XOBMSG(3)="  ::application, to demonstrate usage of the VistaLinkAppProxyConnectionSpec"
 . SET XOBMSG(4)="  ::connection spec."
 . DO BMES^XPDUTL(.XOBMSG)
 IF (+XOBID)=0 DO
 . ; already checked if user present, should never get 0 back
 . SET XOBMSG(1)=">>> Error: Could not add VistALink Application Proxy User '"_XOBANAME_"' -- Already exists."
 . DO BMES^XPDUTL(.XOBMSG)
 IF (+XOBID)<0 DO
 . SET XOBMSG(1)=">>> Error: Could not add VistALink Application Proxy User '"_XOBANAME_"'."
 . SET XOBMSG(2)="    DIERR nodes: <start of error(s)>"
 . SET XOBLINE=3,XOBSUBER=0 FOR  SET XOBSUBER=$O(^TMP("DIERR",$J,XOBSUBER)) QUIT:(+XOBSUBER)'>0  DO
 . . SET XOBMSG(XOBLINE)="    "_^TMP("DIERR",$J,XOBSUBER),XOBLINE=XOBLINE+1
 . . SET XOBSUBTX=0 FOR  SET XOBSUBTX=$O(^TMP("DIERR",$J,XOBSUBER,"TEXT",XOBSUBTX)) QUIT:(+XOBSUBTX)'>0  DO
 . . . SET XOBMSG(XOBLINE)="    "_^TMP("DIERR",$J,XOBSUBER,"TEXT",XOBSUBTX),XOBLINE=XOBLINE+1
 . SET XOBMSG(XOBLINE+1)="    <end of error(s)>"
 . DO BMES^XPDUTL(.XOBMSG)
 . K ^TMP("DIERR",$J)
 ;
 QUIT

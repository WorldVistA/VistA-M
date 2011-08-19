XOBWENV ;ALB/MJK - HWSC :: Environmental Check ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
EN ;- entry point
 ; -- must be a supported M implementation
 DO VALIDM IF $GET(XPDABORT) GOTO ENQ
 ; -- passed load check
 IF '$GET(XPDENV),'$GET(XPDABORT) DO
 . WRITE !!?1,">>> Environment check completed for KIDS Load a Distribution option.",!
 ; -- passed install check
 IF $GET(XPDENV)=1,'$GET(XPDABORT) DO
 . WRITE !!?1,">>> Environment check completed for KIDS Install Package option.",!
ENQ QUIT
 ;
VALIDM ; -- check if HWSC supports M implementation and set KIDS flag if not
 IF $$PROD^XUPROD(0),'$$SSLOK() DO
 . WRITE !,"Note: Your current production M environment does not support SSL/TLS"
 . WRITE !,"      connectivity! SSL/TLS support is provided in Cache v5.2.3 and greater."
 . WRITE !,"      Also, SSL/TLS is not currently supported on VMS."
 . NEW DIR S DIR(0)="E" D ^DIR
 ;
 IF '$$OSOK() DO
 . SET XPDABORT=1
 . WRITE !?5,"This software can only be installed in a Cache v5.2.3 or greater environment!",!
 QUIT
 ;
OSOK() ; -- check environment for operating system, 5.2.3 or greater
 IF $PIECE($GET(^%ZOSF("OS")),"^")'["OpenM" QUIT 0
 NEW XOBVER,MAJOR,MINOR,SUBMINOR
 SET XOBVER=$$VERSION^%ZOSV()
 ; -- checks major version # against 5
 SET MAJOR=+$P(XOBVER,".")
 IF MAJOR<5 QUIT 0
 IF MAJOR>5 QUIT 1
 ; -- checks minor version # against 2
 SET MINOR=+$P(XOBVER,".",2)
 IF MINOR<2 QUIT 0
 IF MINOR>2 QUIT 1
 ; -- checks sub-minor version # against 3
 SET SUBMINOR=+$P(XOBVER,".",3)
 IF SUBMINOR<3 QUIT 0
 IF SUBMINOR>2 QUIT 1
 QUIT 0
 ;
SSLOK() ; -- check environment if SSL/TLS is supported (Cache 5.2.3 or greater, and *not* VMS)
 ; also called in [XOBW WEB SERVER SETUP] edit template
 IF $$SYSOS()="VMS" QUIT 0 ; prevent SSL use on VMS
 QUIT $$OSOK() ; 5.2.3 or greater
 ;
KIDSCHK(XOBDIR) ; -- check input from installer
 ; input: XOBDIR := directory where wsdl file is located (
 ;  Note: If applicable, XOBDIR should contain the os-specific final delimiter, like '/home/cache/'
 NEW XOBPATH
 IF '##class(%File).DirectoryExists(XOBDIR) DO  QUIT 0
 . WRITE !," o  Directory does not exist: "_XOBDIR
 SET XOBPATH=XOBDIR_$$SUPPORT()
 IF '##class(%File).Exists(XOBPATH) DO  QUIT 0
 . WRITE !," o  File to be imported does not exist: "_XOBPATH
 QUIT 1
 ;
SUPPORT() ; -- returns name of xml file containing support classes (wsdl handler, vista info header, etc.)
 QUIT "XOBW_1_0_B"_$$VERSION()_".XML"
 ;
VERSION() ; -- returns the version number for this build
 QUIT +$PIECE($PIECE($TEXT(XOBWENV+1),";",7),"Build ",2)
 ;
SYSOS() ; -- get system operating system
 ; returns VMS, UNIX, NT or UNK
 NEW XOBOS SET XOBOS=^%ZOSF("OS")
 QUIT $SELECT(XOBOS["OpenM":$$OS^%ZOSV(),XOBOS["DSM":"VMS",1:"UNK")

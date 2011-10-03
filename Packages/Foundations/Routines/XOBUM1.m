XOBUM1 ;; ld,mjk/alb - Foundations Manager ; 07/27/2002  13:00
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 ;
START(XOBPORT) ;-- Entry point to start a single VistALink Listener
 ;
 ;  This procedure will start the VistALink Listener on a specific port.  The port number is optional
 ;  and will be validated if passed to this procedure.  If the port is not passed, the user will be
 ;  prompted for a port number.
 ;
 ;   Input:
 ;     XOBPORT  - Port number for the Listener (optional)
 ;
 ;  Output:
 ;     None
 ;
 NEW XOBTASK,Y,XOBOK
 ;
 ;-- Reset I/O variables
 SET U="^" DO HOME^%ZIS
 ;
 DO
 . ;
 . ;-- Check operating system
 . IF '$$CHKOS() SET XOBOK=0 QUIT
 . ;
 . ;-- Validate/prompt for port
 . IF '$$VALID($GET(XOBPORT)) SET XOBPORT=$$GETPORT("start")
 . IF 'XOBPORT SET XOBOK=0 QUIT
 . ;
 . ;-- Wait msg to user
 . DO WAIT^DICD WRITE !
 . ;
 . ;-- Check if Listener is running on port
 . IF '$$LOCK^XOBVTCP(XOBPORT) DO  QUIT
 . . DO EN^DDIOL("VistALink Listener on port "_XOBPORT_" appears to be running already.")
 . . SET XOBOK=0
 . ;
 . ;-- Lock was successful; unlock and queue the listener to startup
 . DO UNLOCK^XOBVTCP(XOBPORT)
 . DO UPDATE^XOBVTCP(XOBPORT,1)
 . SET XOBOK=$$START^XOBVTCP(XOBPORT)
 . IF 'XOBOK DO
 . . DO UPDATE^XOBVTCP(XOBPORT,5)
 . . DO EN^DDIOL("Unable to start VistALink Listener on port "_XOBPORT_".")
 ;
 QUIT XOBOK
 ;
 ;
CHKOS() ;-- Check operating system
 ;
 ;  This function will determine which operating system is being used.
 ;
 ;   Input:
 ;     None
 ;
 ;  Output:
 ;     Function value - returns 1 on success, 0 on failure
 ;
 NEW OPERSYS,RESULT
 ;
 SET RESULT=0
 ;
 ;-- Get operating system
 SET OPERSYS=$$GETOS^XOBVTCP()
 ;
 DO
 . IF OPERSYS="OpenM-NT" DO  QUIT
 .. DO EN^DDIOL("Starting VistALink Listener...")
 .. SET RESULT=1
 . ;
 . IF OPERSYS["DSM" DO EN^DDIOL("Use the TCPIP utility in VMS to enable the VistALink Listener.") QUIT
 . ;
 . ;-- All other operating systems
 . DO EN^DDIOL("Starting the VistALink Listener is not yet supported for "_OPERSYS_".") QUIT
 . ;
 QUIT RESULT
 ;
 ;
VALID(XOBPORT) ;-- Validate port
 ;
 ;  This function will validate a port number passed in.
 ;  
 ;   Input:
 ;     XOBPORT  - Port number for the Listener (Optional)
 ;
 ;  Output:
 ;     Function value - returns 1 if valid, 0 otherwise
 ;
 NEW RESULT
 ;
 SET XOBPORT=+$GET(XOBPORT)
 SET RESULT=0
 ;
 ;-- Check if port is not defined or invalid
 DO  ; Drops out of block on failure
 . QUIT:XOBPORT=0
 . QUIT:(XOBPORT?.AP)
 . QUIT:XOBPORT<5000!(XOBPORT>65535)
 . SET RESULT=1
 QUIT RESULT
 ;
 ;
GETPORT(XOBST) ;-- Prompt user for port number
 ;
 ;  This function will prompt the user for a valid port number.
 ;  
 ;   Input:
 ;     XOBST - start = start Listener
 ;             stop  = stop Listener
 ;
 ;  Output:
 ;     Function value - returns port # or zero
 ;
 NEW DIR,DIRUT,PORT
 SET XOBST=$GET(XOBST)
 ;
 SET DIR(0)="NA^5000:65535"
 SET DIR("A")="Enter Port: "
 SET DIR("B")=8000  ; Default port is 8000
 SET DIR("?")="Choose a numeric port to "_XOBST_" the VistALink Listener on in the range of 5000-65535."
 DO ^DIR KILL DIR
 IF $DATA(DIRUT) DO
 . DO EN^DDIOL("Port not specified.  VistALink Listener not "_$SELECT(XOBST="start":"started",1:"stopped")_".")
 . SET PORT=0
 ELSE  SET PORT=+$GET(Y)
 ;
 QUIT PORT
 ;
 ;
BOX() ; -- start this BOX-VOl default configuration
 NEW XOBOX
 IF $$CHKOS^XOBUM1() DO
 . SET XOBOK=1
 . DO WAIT^DICD WRITE !
 . DO STARTCFG^XOBVTCP($$GETCFG^XOBVTCP())
 ELSE  DO
 . SET XOBOK=0
 QUIT XOBOK
 ;
 ;
STOP(LOGDA) ; -- stop a listener
 NEW Y,X,LOG0,XOBBOX,XOBPORT,XONCFG,XOBSTAT,XOBOK,XOBCFG
 SET XOBOK=0
 ;
 SET LOG0=$GET(^XOB(18.04,LOGDA,0))
 SET XOBBOX=$PIECE(LOG0,U)
 SET XOBPORT=$PIECE(LOG0,U,2)
 SET XOBSTAT=$PIECE(LOG0,U,3)
 SET XOBCFG=$PIECE(LOG0,U,6)
 ; 
 ; -- must be valid entry with a running status
 IF XOBPORT,XOBSTAT=2 DO
 . DO UPDLOG^XOBVTCP(LOGDA,XOBPORT,3,XOBCFG)
 . SET XOBOK=1
 ELSE  DO
 . SET XOBOK=0_U_"Listener is not running!"
 ;
 QUIT XOBOK
 ;
PARMS() ; -- maintain site parameters
 NEW DIC,X,Y,DR,DA,DIE,XOBOK
 SET XOBOK=0
 ;
 IF $GET(^XOB(18.01,1,0))["" DO
 . SET DA=1,DR="[XOBU SITE PARAMETERS]",DIE="^XOB(18.01," DO ^DIE
 . SET XOBOK=1
 ELSE  DO
 . SET XOBOK=0_U_"Error: Site parameter file not initialized."
 ;
 QUIT XOBOK
 ;
CFG() ; -- listener configuration edit
 NEW DIC,X,Y,DR,DA,DIE,XOBDONE,XOBOK
 SET XOBOK=0
 ;
 SET XOBDONE=0
 ;
 FOR   DO  QUIT:XOBDONE
 . WRITE !
 . SET DIC="^XOB(18.03,",DIC(0)="AEMLQ" DO ^DIC
 . IF Y<1 SET XOBDONE=1 QUIT
 . SET DA=+Y,DR="[XOBV LISTENER CONFIG EDIT]",DIE="^XOB(18.03," DO ^DIE
 SET XOBOK=1
 ;
 QUIT XOBOK
 ;
CP() ; -- add a connector proxy
 NEW XOBOK
 SET XOBOK=0
 DO CONT^XUSAP
 SET XOBOK=1
 QUIT XOBOK
 ;

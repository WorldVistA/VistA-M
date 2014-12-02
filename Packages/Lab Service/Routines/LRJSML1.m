LRJSML1 ;ALB/GTS - Lab Vista Hospital Location Initialization;02/24/2010 14:44:01
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
EN ; -- main entry point for LRJ SYS MAP HL List Template
 ;
 ; -- required interface routine variable
 NEW LRJSROU
 SET LRJSROU="LRJSML1"
 DO EN^VALM("LRJ SYS MAP HL")
 QUIT
 ;
HDR ; -- header code
 SET VALMHDR(1)="                  Lab Hospital Location Definition Extract"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^LRJSMLU()_"     Build: "_$$BLDNUM^LRJSMLU()
 QUIT
 ;
INIT ;* init variables and list array
 KILL ^TMP("LRJ SYS USER MANAGER - DATES",$JOB),^TMP("LRJ SYS USER MANAGER - INIT",$JOB)
 KILL ^TMP($J,"LRJ SYS","OUT")
 DO CREATRPT("^TMP($J,""LRJ SYS"")")
 DO CLEAR("^TMP($J,""LRJ SYS"")")
 SET ^TMP("LRJ SYS USER MANAGER - INIT",$JOB)=1
 QUIT
 ;
GETLINK() ; -- get logical link name
 ;;If enhance to send extracted data via via HL MFN, change LA7JMFN to correct link
 QUIT "LA7JMFN"
 ;
CLEAR(LRHLARY) ;* clean up entries
 DO REFRESH(LRHLARY)
 QUIT
 ;
REFRESH(LRHLARY) ;* refresh display
 DO BUILD(LRHLARY)
 D MSG^LRJSML
 SET VALMBCK="R"
 SET VALMBG=1
 QUIT
 ;
HELP ;* help code
 SET X="?" D DISP^XQORM1 W !!
 DO MSG^LRJSML
 DO HDR
 QUIT
 ;
EXIT ; -- exit code
 KILL ^TMP($J,"LRJ SYS"),^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 KILL ^TMP("LRJ SYS USER MANAGER - DATES",$JOB),^TMP("LRJ SYS USER MANAGER - INIT",$JOB)
 DO CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 QUIT
 ;
BUILD(LRHLARY) ; -- build display array
 ;
 ;INPUT
 ; LRHLARY - Array of raw data extract (Required)
 ;
 QUIT:'$D(LRHLARY)  ;QUIT if LRHLARY is not defined)
 ;
 NEW LRSTATUS,LRJERRCT,LRX
 DO KILL
 DO KILL^VALM10()
 SET VALMCNT=0
 SET LRX=" Hospital Locations currently defined in legacy VistA:"
 DO ADD^LRJSMLU(.VALMCNT,LRX)
 DO CNTRL^VALM10(VALMCNT,1,$LENGTH(LRX),IOUON,IOUOFF_IOINORM)
 ;
 DO LISTHL(LRHLARY)
 ;
 ;;D GETLINK^LRJSML1(.VALMCNT,$$GETLINK())  ;;If enhance to send HL MFN message, see if can check link here.
 QUIT
 ;
KILL ; -- kill off display data array
 KILL ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 QUIT
 ;
LISTHL(LRHLARY,X) ; -- place Hospital Locations in the display array
 ;Input:
 ;  LRHLARY - Array root for raw data of Extracted Locations
 ;  X - First line heading for display array (Defaults to Current Location heading)
 ;
 NEW NODE
 DO KILL
 DO KILL^VALM10()
 SET VALMCNT=0
 SET:$G(X)="" X=" Hospital Locations currently defined in legacy VistA:"
 DO ADD^LRJSMLU(.VALMCNT,X)
 DO CNTRL^VALM10(VALMCNT,2,$LENGTH(X)-1,IOUON,IOUOFF_IOINORM)
 D ADD^LRJSMLU(.VALMCNT," ")
 SET NODE=0
 FOR  SET NODE=$ORDER(@LRHLARY@(NODE)) QUIT:NODE=""  DO
 . S X=@LRHLARY@(NODE)
 . DO BREAK^LRJSML(.VALMCNT,X,NODE)
 QUIT
 ;
CREATRPT(LRHLARY) ;Create initial array of Hospital Location definition
 ; INPUT:
 ;       LRHLARY - Array root for initial HL extract
 N DIR
 ;
 D MSG^LRJSML ;Display last report dates
 D HDR
 ;
 ;Call Report API
 W !
 D EXTHL^LRJSML4(LRHLARY)
 ;
 Q
 ;
 ;;Action code for Hospital Location Mapping Manager actions
 ;
DISPEXT(LRHLARY) ;Display Raw HL changes extracted
 ;
 ;Called from Protocol: LRJ SYS MAP HL DISP EXT
 ;
 ; This API will change the ListMan display array to a raw extract format
 ;INPUT
 ; LRHLARY - Array of raw extract data.
 ; 
 NEW LRINIT,LRFROM,LRTO
 SET (LRFROM,LRTO)=""
 SET LRINIT=$$INITCK()
 ;
 IF LRINIT DO
 .DO HDR
 .KILL ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 .DO REFRESH(LRHLARY)
 ;
 IF 'LRINIT DO
 .DO HDR^LRJSML
 .DO SETRNG(.LRFROM,.LRTO)
 .KILL ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 .SET ^TMP("LRJ SYS USER MANAGER - DATES",$JOB)=LRFROM_"^"_LRTO
 .DO REFRESH^LRJSML(LRFROM,LRTO,LRHLARY) ;* refresh display
 QUIT
 ;
CREATMM(LRHLARY) ;Create a mail message array
 ;
 ;Called from Protocol: LRJ SYS MAP HL DISPLAY MESSAGE
 ;
 ; This API will change the ListMan display array to a Mail Message format
 ;INPUT
 ; LRHLARY - Array of raw extract data.
 ;
 IF '$D(LRHLARY) DO
 .W !!,"Extract not completed...",!
 .DO PAUSE^VALM1
 .DO HDR
 .DO REFRESH(LRHLARY)
 ;
 IF $D(LRHLARY) DO
 .NEW LRINIT
 .SET LRINIT=$$INITCK()
 .D MMHDR
 .IF $P($G(@LRHLARY@(1)),"^",1)'="   NO CHANGES FOUND!!" DO
 ..DO LISTHLMM^LRJSML8(LRHLARY)
 ..D MSG^LRJSML
 ..S VALMBCK="R"
 ..S VALMBG=1
 .D:$P($G(@LRHLARY@(1)),"^",1)="   NO CHANGES FOUND!!" DISPEXT(LRHLARY)
 ;
 QUIT
 ;
MMHDR ; -- header code for Mail Message display
 NEW LRINIT
 SET LRINIT=$$INITCK()
 SET:LRINIT VALMHDR(1)="              Lab Hospital Location Definition Extract Message"
 SET:'LRINIT VALMHDR(1)="                 Lab Hospital Location Change Extract Message"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^LRJSMLU()_"     Build: "_$$BLDNUM^LRJSMLU()
 QUIT
 ;
SETRNG(LRFROM,LRTO) ; Get current change Extract Date range
 DO GETDATE^LRJSML8(.LRFROM,.LRTO)
 IF (+LRFROM=0)!(+LRTO=0) DO
 .SET LRFROM=$P($G(^TMP("LRJ SYS USER MANAGER - DATES",$JOB)),"^")
 .SET LRTO=$P($G(^TMP("LRJ SYS USER MANAGER - DATES",$JOB)),"^",2)
 QUIT
 ;
INITCK() ;Return Initialization report indicator
 ;           1 : Init extract
 ;           0 : Not Init extract [Default]
 ;
 QUIT +$G(^TMP("LRJ SYS USER MANAGER - INIT",$JOB))

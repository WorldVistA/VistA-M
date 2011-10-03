XOBUENV ;; ld/alb - VistaLink Environment Check ; 11/15/2007  08:44
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 ;
EN ;- entry point
 ;
 ;- programmer variables check
 DO PROG IF $GET(XPDABORT) GOTO ENQ
 ;
 ;- operating system check
 DO OSCHK IF $GET(XPDABORT) GOTO ENQ
 ;
 ;- check for presence of obsolete SYSTEM file (#18)
 DO FILE18
 ;
 ;- load check
 S XPDENV=$G(XPDENV),XPDABORT=$G(XPDABORT)
 ;
 IF 'XPDENV,'XPDABORT WRITE !!?1,">>> VistALink environment check completed for KIDS Load a Distribution option.",!
 ;
 ;- install check
 I XPDENV=1 D
 . ;- check that listeners were stopped before package installation continues
 . S:$$STPLSTNR()<1 XPDABORT=2
 . I 'XPDABORT WRITE !!?1,">>> VistALink environment check completed for KIDS Install Package option.",!
 ;
 ;IF XPDENV=1,'XPDABORT WRITE !!?1,">>> VistALink environment check completed for KIDS Install Package option.",!
 ;
ENQ QUIT
 ;
PROG ;- check environment for programmer variables
 ;
 WRITE !?1,">>> Performing environment check...",!
 IF +$GET(DUZ)'>0!($GET(DUZ(0))'="@") DO
 . SET XPDABORT=1
 . WRITE !,"     Programmer environment variables have not been correctly defined.",!
 QUIT
 ;
OSCHK ;- check environment for operating system (DSM or OpenM)
 ;
 NEW XOBOS
 SET XOBOS=$PIECE($GET(^%ZOSF("OS")),"^")
 IF XOBOS'["DSM"&(XOBOS'["OpenM")&(XOBOS'["GT.M") DO
 . SET XPDABORT=1
 . DO PRNTXT("OSMSG")
 QUIT
 ;
STPLSTNR() ;- ask if all listeners are stopped prior to installing package
 ;
 NEW XOB0,XOBA,XOBARR,XOBB,XOBHLP,XOBHARR
 ;
 ;- set DIR variables
 SET XOB0="YAO"
 SET XOBA=" Have all VistALink listeners been stopped? "
 SET XOBB="NO"
 S XOBHLP=" transport globals."
 ;
 ;- set DIR("A",#) array
 D SETARRAY("DIRARR","XOBARR")
 ;
 ;- set DIR("?",#) array
 D SETARRAY("DIRHARR","XOBHARR")
 QUIT $$ANSWER(XOB0,XOBA,XOBB,.XOBARR,XOBHLP,.XOBHARR)
 ;
SETARRAY(LINETAG,XOBARRY) ;-
 Q:$G(LINETAG)=""!($G(XOBARRY))=""
 NEW I,LINE
 FOR I=1:1 SET LINE=$PIECE($TEXT(@LINETAG+I),";;",2) QUIT:LINE="$END"  S @XOBARRY@(I)=LINE
 QUIT
 ;
FILE18 ;- check for obsolete Kernel file #18 which is in VistALink's numberspace
 ;
 NEW I,LINE,XOBABORT,XOBASK
 ;
 ;- file #18 not found
 IF '$$FILECHK() GOTO FILE18Q
 ;
 ;- file found; display user msg
 DO PRNTXT("INTRO")
 ;
 ;- if load, ask if they want file deletion instructions
 IF 'XPDENV DO  GOTO FILE18Q
 . DO:$$ASKINSTR()>0 TOP,PRNTXT("INSTR1"),PAUSE,PRNTXT("INSTR2"),PAUSE
 ;
 ;- if install, ask if user wants to abort install
 ;- if yes, ask if they want file deletion instructions
 SET XOBABORT=$$ASKINSTL()
 IF XOBABORT DO  QUIT
 . IF XOBABORT=1 DO:$$ASKINSTR()>0 TOP,PRNTXT("INSTR1"),PAUSE,PRNTXT("INSTR2"),PAUSE
 . SET XPDABORT=2
 ;
 ;- if user wants to continue install, ask again to be sure
 IF XOBABORT=0 DO
 . SET XOBASK=$$REASK()
 . IF XOBASK<1 DO
 .. IF XOBASK=0 DO:$$ASKINSTR()>0 TOP,PRNTXT("INSTR1"),PAUSE,PRNTXT("INSTR2"),PAUSE
 .. SET XPDABORT=2
FILE18Q QUIT
 ;
ASKINSTL() ;- ask if user wants to abort install
 ;
 NEW XOB0,XOBA,XOBARR,XOBB
 SET XOB0="YAO"
 SET XOBA=" Do you want to abort the installation now? "
 SET XOBB="YES"
 SET XOBARR(1)="     NOTE:"
 SET XOBARR(2)="       If you choose to abort the installation, please do a global listing"
 SET XOBARR(3)="       of file ^DIC(18, and ^DD(18, after deleting the file to ensure that"
 SET XOBARR(4)="       the SYSTEM file (#18) is completely deleted from your system before"
 SET XOBARR(5)="       reinstalling the VistALink package.  If you need additional help"
 SET XOBARR(6)="       deleting the file, please contact National VistA Support (NVS)."
 SET XOBARR(7)=" "
 QUIT $$ANSWER(XOB0,XOBA,XOBB,.XOBARR)
 ;
REASK() ;- ask user again if they want to continue with install (pre-init will
 ;         delete file #18)
 ;
 NEW XOB0,XOBA,XOBARR,XOBB
 SET XOB0="YAO"
 SET XOBA=" Are you sure you want to continue? "
 SET XOBB="NO"
 SET XOBARR(1)=" "
 SET XOBARR(2)="     NOTE:"
 SET XOBARR(3)="       Continuing with the installation will delete the SYSTEM file (#18)"
 SET XOBARR(4)="       using the FileMan Data Dictionary Deletion call (EN^DIU2)."
 SET XOBARR(5)=" "
 QUIT $$ANSWER(XOB0,XOBA,XOBB,.XOBARR)
 ;
ASKINSTR() ;- ask if user wants file deletion instructions
 ;
 NEW XOB0,XOBA,XOBARR,XOBB
 SET XOB0="YAO"
 SET XOBA=" Would you like instructions on how to delete SYSTEM file (#18)? "
 SET XOBB="YES"
 SET XOBARR(1)=" "
 QUIT $$ANSWER(XOB0,XOBA,XOBB,.XOBARR)
 ;
ANSWER(XOB0,XOBA,XOBB,XOBARR,XOBHLP,XOBHARR) ;wrap FileMan DIR call
 ;
 ;  Input:
 ;    XOB0    - DIR(0) string
 ;    XOBA    - DIR("A") string
 ;    XOBB    - DIR("B") string
 ;    XOBARR  - DIR("A",#) string
 ;    XOBHLP  - DIR("?") string
 ;    XOBHARR - DIR("?",#) string
 ;
 ;  Output:
 ;   Function Value - Internal value returned from ^DIR (0 for No, 1 for
 ;                    YES) or -1 if user up-arrows or the read times out.
 ;
 NEW DIR,DIRUT,X,Y  ; ^DIR variables
 ;
 SET DIR(0)=XOB0
 SET DIR("A")=$GET(XOBA)
 IF $DATA(XOBARR)>1 MERGE DIR("A")=XOBARR
 IF $GET(XOBB)'="" SET DIR("B")=XOBB
 IF $G(XOBHLP)'="" S DIR("?")=XOBHLP
 I $D(XOBHARR)>1 M DIR("?")=XOBHARR
 DO ^DIR KILL DIR
 QUIT $SELECT($DATA(DIRUT):-1,1:$PIECE(Y,U))
 ;
FILECHK() ;- check for file 18
 ;
 NEW XOBA,XOBFIL
 SET XOBA=0
 DO FILE^DID(18,"","NAME","XOBFIL")
 IF $GET(XOBFIL("NAME"))="SYSTEM",($$VFILE^DILFD(18)) SET XOBA=1
 IF $DATA(^DIC(18))!$DATA(^DD(18)) SET XOBA=1
 QUIT XOBA
 ;
PRNTXT(TEXT) ;- display user text
 ;
 QUIT:$GET(TEXT)=""
 NEW I,LINE
 FOR I=1:1 SET LINE=$PIECE($TEXT(@TEXT+I),";;",2) QUIT:LINE="$END"  WRITE !,LINE
 QUIT
 ;
TOP ;- top of screen
 ;
 QUIT:$EXTRACT(IOST,1,2)'="C-"
 IF $Y>1 WRITE @IOF
 QUIT
 ;
PAUSE ;- enhance readability of text
 ;
 QUIT:$EXTRACT(IOST,1,2)'="C-"
 WRITE ! SET DIR(0)="E",DIR("A")="Press return to continue" DO ^DIR KILL DIR WRITE !
 QUIT
 ;
INTRO ;- display message to user explaining file #18
 ;; >>>>>>>>>> ATTENTION: File SYSTEM (#18) was found on your system. <<<<<<<<<<
 ;;     
 ;;     SYSTEM file #18 was the precursor to the KERNEL SYSTEMS PARAMETER
 ;;     file and is obsolete.  The SYSTEM file uses the same numberspace
 ;;     that VistALink is assigned and must be deleted before VistALink
 ;;     can be installed.  You may wish to manually backup and manually
 ;;     delete file #18.
 ;;     
 ;;     If you do not manually delete file #18 and it is still on your system
 ;;     during the installation phase, you will be prompted with a series of
 ;;     questions.  The questions will allow you to abort the installation or
 ;;     allow the installation to safely delete the SYSTEM file for you.
 ;;     
 ;;$END
 ;
INSTR1 ;- user instructions to delete file #18
 ;;
 ;;
 ;;     ********      How to delete the SYSTEM file (#18)     ********
 ;;
 ;;
 ;;     1)  From the programmer prompt, go to the FileMan main menu
 ;;
 ;;     2)  Choose option 6, UTILITY FUNCTIONS
 ;;
 ;;     3)  Choose option 6, EDIT FILE
 ;;
 ;;     4)  MODIFY WHAT FILE: // 18  SYSTEM
 ;;
 ;;     5)  Do you want to use the screen-mode version? YES// YES
 ;;         (recommend using screen-mode because you can exit out without
 ;;         saving your changes if necessary)
 ;;
 ;;     6)  At the FILE NAME: prompt (which should have the name SYSTEM
 ;;         in it), type @
 ;;$END
 ;
INSTR2 ;- user instructions to delete file #18 (continued)
 ;;
 ;;
 ;;     7)  It will then ask the following questions:
 ;;           DO YOU WANT JUST TO DELETE THE FILE CONTENTS,
 ;;                    & KEEP THE FILE DEFINITION? No// No   (No)
 ;;              IS IT OK TO DELETE THE '^DIC(18)' GLOBAL? Yes// Yes   (Yes)
 ;;                  SURE YOU WANT TO DELETE THE ENTIRE FILE? No// Yes  (Yes)
 ;;           Deleting the DATA DICTIONARY...
 ;;           Deleting the INPUT TEMPLATES....
 ;;           Deleting the PRINT TEMPLATES...
 ;;           Deleting the SORT TEMPLATES...
 ;;           Deleting the FORMS...
 ;;
 ;;     8)  The last step is a global listing to check that file #18 and its DD
 ;;         have been deleted.  Here's an example:
 ;;           cor> D ^%G
 ;;           Global ^DIC(18,
 ;;           DIC(18,
 ;;           Global ^DD(18,
 ;;           DD(18,
 ;;           Global ^
 ;;$END
 ;
OSMSG ;- message to user if operating system is not Cache or DSM
 ;;
 ;;     VistALink has been tested on Cache and DSM. It has not been tested
 ;;     or programmed to be compatible yet on other M implementations, 
 ;;     therefore installation will abort.
 ;;     
 ;;$END
 ;
DIRARR ;- DIR array text
 ;; 
 ;; All running VistALink listeners should be stopped before proceeding with
 ;; this installation. Enter ? for help on stopping VistALink listeners.
 ;; 
 ;;$END
 ;
DIRHARR ;-DIR help array text
 ;; If VistALink listeners were started using the Foundations Management menu
 ;; [XOBU SITE SETUP MENU], stop listeners using the STP Stop Listener action
 ;; within the menu.
 ;; 
 ;; If VistALink listeners were started using TCPIP Services within the VMS
 ;; operating system, use the TCPIP utility within VMS or contact your site
 ;; manager to stop the listeners.
 ;; 
 ;; Answering 'NO' to this question will abort the installation but leave the
 ;;$END
 ;

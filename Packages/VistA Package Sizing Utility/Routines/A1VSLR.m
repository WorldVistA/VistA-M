A1VSLR ;Albany FO/GTS - VistA Package Sizing Manager; 27-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
EN ; -- main entry point for A1VS VISTA SIZE RPT
 DO EN^VALM("A1VS PKG MGR VISTA SIZE RPT")
 QUIT
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="          VistA Package Size Analysis Manager - Package Statistics"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_A1VPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; -- init variables and list array
 NEW A1TMPLNN
 KILL ^TMP("A1VS PKG MGR RPT",$JOB)
 SET A1TMPLNN=0
 IF (+$G(FIRSTITM)>0),(+$G(LASTITM)>0) DO
 . SET A1TMPLNN=$$SELXTMP^A1VSLAPI(FIRSTITM,LASTITM,5)
 . IF A1TMPLNN>0 DO
 .. SET A1VPSPRM=$P(^TMP("A1VS PACKAGE MGR",$J,A1TMPLNN,0),A1TMPLNN-5_") ",2)
 .. IF A1VPSPRM]"" DO BUILD
 .. IF A1VPSPRM']"" DO
 ... SET A1VPSPRM="NOT SELECTED!"
 IF ((+$G(FIRSTITM)'>0)&(+$G(LASTITM)'>0))!(A1TMPLNN'>0) SET VALMQUIT="" ;SET A1VPSPRM="NOT SELECTED!"
 QUIT
 ;
BUILD ; - Build local and global display arrays
 SET VALMCNT=0
 DO INIT^A1VSRFL(.VALMCNT,A1VPSPRM)
 IF VALMCNT'>0 SET VALMQUIT=""
 QUIT
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 QUIT
 ;
EXIT ; -- exit code
 D KILL
 Q
 ;
EXPND ; -- expand code
 QUIT
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PKG MGR RPT",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
 ; ListMan Report Action APIs
TEXTFILE ; Write report to text file
 ; -- Protocol: A1VS PKG MGR RPT WRT ACTION
 ;
 DO FULL^VALM1
 ;
 NEW DIR,Y,X,FILENME,STORPATH
 SET (FILENME,STORPATH)=""
 SET DIR(0)="FAOr^2:60^"
 SET DIR("A")="Enter directory to write report file: "_$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET DIR("A",1)=" "
 SET DIR("B")=""
 SET DIR("?")="Enter '^' to abort Host File creation."
 SET DIR("?",1)="Enter a host directory where you have write priveleges"
 SET DIR("?",2)="  and at least 10K of space."
 SET DIR("?",3)=" "
 DO ^DIR
 ;
 IF '$D(DTOUT),'$D(DUOUT),'$D(DIROUT) DO
 . SET:X]"" STORPATH=X
 . SET:X']"" STORPATH=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 . NEW DIR,Y,X
 . SET DIR(0)="FAOr^3:30^"
 . SET DIR("A")="Enter the name of the Host File "
 . SET DIR("A",1)=" "
 . SET DIR("B")="VistAPkgSize_"_$P($$NOW^XLFDT,".",1)_$P($$NOW^XLFDT,".",2)_".txt"
 . SET DIR("?")="Enter '^' to abort Host File creation."
 . SET DIR("?",1)="The file will be written to "_STORPATH
 . DO ^DIR
 . IF '$D(DTOUT),'$D(DUOUT),'$D(DIROUT) DO
 .. SET FILENME=Y
 .. DO WRTTXTFL^A1VSLAPI(FILENME,STORPATH)
 ;
 SET VALMBCK="R"
 QUIT

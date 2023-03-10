XTVSLR ;Albany FO/GTS - VistA Package Sizing Manager; 27-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN ; -- main entry point for XTVS VISTA SIZE RPT
 DO EN^VALM("XTVS PKG MGR VISTA SIZE RPT")
 QUIT
 ;
HDR ; -- Main header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="          VistA Package Size Analysis Manager - Package Statistics"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_XTVPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 QUIT
 ;
HDRA ; -- Alternate header code
 SET VALMHDR(1)=""
 SET VALMHDR(2)="                       Total"
 SET VALMHDR(3)="Application             Rtn"
 SET VALMHDR(4)="(Namespace)  Routines  Size   Files  Fields  Options  Protocols  RPCs  Templates"
 QUIT
 ;
INIT ; -- init variables and list array
 NEW XTTMPLNN
 KILL ^TMP("XTVS PKG MGR RPT",$JOB)
 SET XTTMPLNN=0
 IF (+$G(FIRSTITM)>0),(+$G(LASTITM)>0) DO
 . SET XTTMPLNN=$$SELXTMP^XTVSLAPI(FIRSTITM,LASTITM,5)
 . IF XTTMPLNN>0 DO
 .. SET XTVPSPRM=$P(^TMP("XTVS PACKAGE MGR",$J,XTTMPLNN,0),XTTMPLNN-5_") ",2)
 .. IF XTVPSPRM]"" DO 
 ... NEW CHKLKER
 ... SET CHKLKER=$$REQLOCK^XTVSLAPI(XTVPSPRM)
 ... IF 'CHKLKER DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2)) DO BUILD
 ... IF CHKLKER W !!," <* LOCK request denied! Try again later. *>" DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2)) SET VALMQUIT=""
 .. IF XTVPSPRM']"" DO
 ... SET XTVPSPRM="NOT SELECTED!"
 IF ((+$G(FIRSTITM)'>0)&(+$G(LASTITM)'>0))!(XTTMPLNN'>0) SET VALMQUIT="" ;SET XTVPSPRM="NOT SELECTED!"
 DO MSG
 QUIT
 ;
BUILD ; - Build local and global display arrays
 NEW UNLKRSLT
 SET VALMCNT=0
 DO INIT^XTVSRFL(.VALMCNT,XTVPSPRM)
 SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI(XTVPSPRM)
 IF +UNLKRSLT DO JUSTPAWS^XTVSLAPI($P(UNLKRSLT,"^",2))
 IF VALMCNT'>0 SET VALMQUIT=""
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Package Statistics action help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LRTXT+TXTCT^XTVSHLP1),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 D MSG
 S VALMBCK="R"
 K XTX,Y,TXTCT,XTQVAR
 QUIT
 ;
EXIT ; -- exit code
 D KILL
 Q
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MGR RPT",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? for more actions and Help"
 QUIT
 ;
 ; ListMan Report Action APIs
TEXTFILE ; Write report to text file
 ; -- Protocol: XTVS PKG MGR RPT WRT ACTION
 ;
 DO FULL^VALM1
 ;
 NEW DIR,Y,X,FILENME,STORPATH
 SET (FILENME,STORPATH)=""
 SET DIR(0)="FAOr^2:60^"
 SET DIR("A")="Enter directory to write report file: "_$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET DIR("A",1)=" "
 SET DIR("B")=""
 SET DIR("?")="Enter '^' to abort Host File creation."
 SET DIR("?",1)="Enter a host directory where you have write privileges"
 SET DIR("?",2)="  and at least 10K of space."
 SET DIR("?",3)=" "
 DO ^DIR
 ;
 IF '$D(DTOUT),'$D(DUOUT),'$D(DIROUT) DO
 . SET:X]"" STORPATH=X
 . SET:X']"" STORPATH=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
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
 .. DO WRTTXTFL^XTVSLAPI(FILENME,STORPATH)
 ;
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
REMREQ ; Remote Report Protocol entry point
 ;  -- Protocol: XTVS PKG MGR RPT QUERY REMOTE ACTION
 ;
 DO REMRPTRQ(XTVPSPRM)
 QUIT
 ;
 ; ListMan Report Action APIs
REMRPTRQ(XTVPSPRM) ; Request remote report file
 ; Called from APIs invoked by Protocols:
 ;   XTVS PKG QUERY REMOTE VISTA SIZE ACTION
 ;   XTVS PKG MGR RPT QUERY REMOTE ACTION
 ;
 NEW LINEITEM,XTVSFQ,DIR,XMY,XTVSRPT,PRMDSPCT,XTVSPVAL,PKGNAME,XTVSRMCT
 ;
 SET LINEITEM=""
 SET PKGNAME=0
 KILL XMY
 ;
 D FULL^VALM1
 ;
 SET DIR("A",1)=""
 SET DIR("A",2)=" The response from a remote VistA can take some time."
 SET DIR("A",3)=""
 SET DIR("A")="Do you want to request a report from a remote VistA? "
 SET DIR("B")="YES"
 SET DIR("?",1)="Yes to query remote system using the displayed parameters."
 SET DIR("?",2)="No to abort request action."
 SET DIR("?")="Enter '^' to exit."
 SET DIR(0)="YA"
 DO ^DIR
 SET XTVSFQ=$GET(Y)
 IF ($DATA(DUOUT))!($DATA(DTOUT))!($DATA(DIROUT)) DO JUSTPAWS^XTVSLAPI("Size Report prompt not answered!")
 KILL DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ; If query remote system, select package to report
 IF XTVSFQ=1 DO
 . NEW CHKLKER,UNLKRSLT
 . SET CHKLKER=$$REQLOCK^XTVSLAPI(XTVPSPRM)
 . IF CHKLKER W !!," <* LOCK request denied! Try again later. *>" DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 . IF 'CHKLKER DO
 .. DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 .. W !!," ...Loading Parameters..."
 .. SET XTVSRMCT=4
 .. DO OPEN^%ZISH("XTMP",DEFDIR,XTVPSPRM,"R")
 .. U IO
 .. FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  IF LINEITEM]"" DO ADD2MSG(LINEITEM,.XTVSRMCT)
 .. DO CLOSE^%ZISH("XTMP")
 .. ;
 .. SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI(XTVPSPRM)
 .. IF ($P(UNLKRSLT,"^")'=1) W !!," <* UNLOCK ERROR. Check LOCK file Integrity. *>"
 .. DO JUSTPAWS^XTVSLAPI($P(UNLKRSLT,"^",2))
 .. ;
 .. SET PKGNAME=$$SELPKG^XTVSLPDC(0)
 .. SET LINEITEM=""
 ;
 ; If package selected, select VistA site (Domain)
 IF PKGNAME=0,XTVSFQ=1 DO JUSTPAWS^XTVSLAPI("VistA Package not selected!")
 IF PKGNAME'=0 DO
 . SET LINEITEM=^TMP("XTVS-PARAM-CAP",$J,PKGNAME)
 . KILL DIC,X,Y,DTOUT,DUOUT
 . SET DIC="^DIC(4.2,"
 . SET DIC(0)="AEQ"
 . SET DIC("A")="Domain server to query: "
 . SET DIC("S")="I $P(^(0),U,2)'=""C""" ;Screen "CLOSED" domains
 . DO ^DIC
 . IF '$DATA(DUOUT),'$DATA(DTOUT),(+Y>-1) SET XMY("S.XTVS PKG EXTRACT SERVER@"_$PIECE(Y,"^",2))="" ;Query address for size rpt
 . IF ($DATA(DUOUT))!($DATA(DTOUT))!(+Y=-1) DO JUSTPAWS^XTVSLAPI("VistA Domain not selected!")
 . KILL DIC,X,Y,DTOUT,DUOUT
 ;
 ; If site selected, send query message
 IF ($DATA(XMY)) DO
 . NEW XMTEXT,XMDUZ,XMSUB,XDATE,XMMG,XMZ,TMP
 . SET ^TMP("XTVS REQ MSG",$J,1)="REQUESTED BY: "_$$NETNAME^XMXUTIL(DUZ)
 . SET ^TMP("XTVS REQ MSG",$J,2)="Extract Indicator: 0" ; No Extract requested
 . SET ^TMP("XTVS REQ MSG",$J,3)="Report Indicator: 2" ; Request Single Package Size rpt
 . SET ^TMP("XTVS REQ MSG",$J,4)="Package Parameters: "_LINEITEM ; Package to report at remote site
 . SET XMDUZ=DUZ
 . SET XMSUB="XTVS: PACKAGE FILE EXTRACT & REPORT REQUEST"
 . SET XMTEXT="^TMP(""XTVS REQ MSG"","_$J_","
 . DO ^XMD
 . IF +$GET(XMZ)<1 DO
 .. DO JUSTPAWS^XTVSLAPI("Error sending query message: "_XMMG_"!")
 . IF +$GET(XMZ)>0 DO
 .. DO JUSTPAWS^XTVSLAPI("Query message sent!  Message # "_XMZ)
 ;
 KILL ^TMP("XTVS REQ MSG",$J),^TMP("XTVS-PARAM-CAP",$J)
 ;
 DO MSG
 SET VALMBCK="R"
 ;
 QUIT
 ;
ADD2MSG(LINEITEM,XTVSRMCT) ;Add a parameter to Request Message array & create ^TMP("XTVS-PARAM-CAP",$J)
 SET XTVSRMCT=XTVSRMCT+1
 SET ^TMP("XTVS REQ MSG",$J,XTVSRMCT)=LINEITEM ;Package to report at remote site
 DO SCAPARY^XTVSLP(LINEITEM) ;^TMP("XTVS-PARAM-CAP",$J) needed for $$SELPKG^XTVSLPDC(0)
 QUIT
 ;
SWAPHEAD ;Report of all packages, toggle action header and report header
 ; -- Protocol: XTVS PKG RPT SWAP HEADER
 NEW SWAPPD
 SET SWAPPD=0
 IF VALMHDR(1)="" KILL VALMHDR DO HDR SET SWAPPD=1
 IF 'SWAPPD,VALMHDR(1)'="" KILL VALMHDR DO HDRA
 SET VALMBCK="R"
 QUIT

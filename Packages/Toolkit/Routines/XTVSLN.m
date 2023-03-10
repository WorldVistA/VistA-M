XTVSLN ;Albany FO/GTS - VistA Package Sizing Manager; 30-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN ; -- main entry point for XTVS PKG MGR EXTRACT MNGR
 D EN^VALM("XTVS PKG MGR EXTRACT MNGR")
 Q
 ;
HDR ; -- header code
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Extract Manager"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 Q
 ;
INIT ; -- init variables and list array
 NEW DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET VALMCNT=0
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"  Extracted package ^XTMP global list")
 DO ADD^XTVSLAPI(.VALMCNT,"   XTMPSIZE.DAT default directory: "_$S($G(DEFDIR)]"":DEFDIR,1:"<no default defined>"),1,36,$S($L(DEFDIR)>0:$L(DEFDIR),1:20))
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"   Process ID        System                Date/Time")
 DO ADD^XTVSLAPI(.VALMCNT,"   ----------------------------------------------------")
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO FNDXTMP
 DO MSG
 Q
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Extract Manager List action help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LNTXT+TXTCT^XTVSHLP1),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 S VALMBCK="R"
 DO MSG
 K XTX,Y,TXTCT,XTQVAR
 QUIT
 ;
EXIT ; -- exit code
 D KILL
 Q
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? for more actions and Help"
 QUIT
 ;
REFRESH ; -- On Return from another Template or action, refresh XTVS PKG MGR EXTRACT MNGR List Template array
 NEW LNENUM,XTDOLRJ,DEFDIR,DEFDRTXT
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 DO KILL^XTVSLN ;Kill all processing & data arrays and video attributes & control arrays for XTVS PKG MGR EXTRACT MNGR template
 SET EMGRTARY="^TMP(""XTVS PKG MGR EXTRACT"","_$J_")"
 SET LNENUM=0
 SET DEFDRTXT="   XTMPSIZE.DAT default directory: "_$S($G(DEFDIR)]"":DEFDIR,1:"<no default defined>")
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM," ")
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM,"  Extracted package ^XTMP global list")
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM,DEFDRTXT)
 DO CNTRL^VALM10(LNENUM,36,$S($L(DEFDIR)>0:$L(DEFDIR),1:20),IOUON,IOUOFF)
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM," ")
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM,"   Process ID        System                Date/Time")
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM,"   ----------------------------------------------------")
 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM," ")
 ;
 SET XTDOLRJ=0
 FOR  SET XTDOLRJ=$O(^XTMP("XTSIZE",XTDOLRJ)) Q:+XTDOLRJ=0  DO 
 . NEW DATE,EXSYS
 . SET DATE=$P($P(^XTMP("XTSIZE",XTDOLRJ,0),"^",3),"-")
 . SET EXSYS=$P(^XTMP("XTSIZE",XTDOLRJ,0),"^",4)
 . SET DATE=$$FMTE^XLFDT(DATE,"1P")
 . DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM,$J(XTDOLRJ,13)_$J(EXSYS,15)_$J(DATE,27))
 IF LNENUM'>7 DO RTRNADD^XTVSLAPI(EMGRTARY,.LNENUM,"   No Extracts defined.")
 QUIT
 ;
KILL ; -- Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MGR EXTRACT",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
FNDXTMP ; List Package Extracts
 NEW XTDOLRJ
 SET XTDOLRJ=0
 FOR  SET XTDOLRJ=$O(^XTMP("XTSIZE",XTDOLRJ)) Q:+XTDOLRJ=0  DO 
 . NEW DATE,EXSYS
 . SET DATE=$P($P(^XTMP("XTSIZE",XTDOLRJ,0),"^",3),"-")
 . SET EXSYS=$P(^XTMP("XTSIZE",XTDOLRJ,0),"^",4)
 . SET DATE=$$FMTE^XLFDT(DATE,"1P")
 . DO ADD^XTVSLAPI(.VALMCNT,$J(XTDOLRJ,13)_$J(EXSYS,15)_$J(DATE,27))
 IF VALMCNT'>7 DO ADD^XTVSLAPI(.VALMCNT,"   No Extracts defined.")
 QUIT
 ;
SELDOLRJ() ; Select a Process ID
 ;OUTPUT:
 ;   RESULT : Selected PID
 ;          : 0 (failure)
 NEW RESULT,DIR,X,Y
 D FULL^VALM1
 SET DIR("A",1)=""
 SET DIR("A")="Enter the Extract Process ID ($JOB) number"
 SET DIR("?")="Enter a number from the list."
 SET DIR(0)="N::"
 DO ^DIR
 SET:'$D(DIRUT) RESULT=Y
 SET:$D(DIRUT) RESULT=0
 Q RESULT
 ;
CRTPMCLN ;Kill temporary globals created by 'XTVS PKG EXT CRT PARAM ACTION' Protocol
 KILL ^TMP("XTVS-FILERPT",$J),^TMP("XTSIZE",$J) ;,^TMP("XTSIZE","IDX",$J)
 QUIT
 ;
 ;PROTOCOL entry points
DE ; -- Delete Extracts
 ; -- Protocol: XTVS PKG EXTRACT DEL ACTION
 NEW PROCID
 SET PROCID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'PROCID DO JUSTPAWS^XTVSLAPI("No Process ID selected.")
 IF (PROCID),('$D(^XTMP("XTSIZE",PROCID))) DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_PROCID_") is NOT defined!")
 IF (PROCID),($D(^XTMP("XTSIZE",PROCID))) DO
 . NEW X,Y,DIR
 . SET DIR("A",1)=""
 . SET DIR("A")="Do you want to delete ^XTMP(""XTSIZE"","_PROCID_")"
 . SET DIR("B")="NO"
 . SET DIR(0)="Y::"
 . DO ^DIR
 . IF ('$D(DTOUT)),('$D(DUOUT)),(($G(Y)=1)) KILL ^XTMP("XTSIZE",PROCID) DO KILL,INIT
 . IF ($D(DTOUT))!($D(DUOUT))!(($G(Y)=0)) DO
 .. DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_PROCID_") NOT DELETED!")
 ;
 DO MSG
 KILL X,Y,DTOUT,DIRUT,DUOUT
 SET VALMBCK="R"
 QUIT
 ;
ED ; - Extract Display
 ; -- Protocol: XTVS PKG MGR EXT DISP ACTION
 ;
 NEW XPID,QCHK
 SET QCHK=0
 SET XPID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'XPID DO JUSTPAWS^XTVSLAPI("No Process ID selected.") SET QCHK=1
 IF (XPID),('$D(^XTMP("XTSIZE",XPID))) DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_XPID_") is NOT defined!") SET QCHK=1
 IF 'QCHK DO EN^XTVSLDE
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
PEXT ; -- Create Extract
 ; -- Protocol: XTVS PKG EXTRACT CREATE ACTION
 ;
 NEW EXTRSLT
 SET EXTRSLT=$$PKGEXT^XTVSLNA1()
 DO REFRESH
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
CRTPARM ; Display Package Parameter file from selected ^XTMP("XTSIZE") extract global
 ; -- Protocol: XTVS PKG EXT CRT PARAM ACTION
 ;
 NEW XPID,QCHK
 SET QCHK=0
 SET XPID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'XPID DO JUSTPAWS^XTVSLAPI("No Process ID selected.") SET QCHK=1
 IF (XPID),('$D(^XTMP("XTSIZE",XPID))) DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_XPID_") is NOT defined!") SET QCHK=1
 IF 'QCHK DO
 . DO XTMPORD^XTVSLNA1(XPID) ; Create ^TMP("XTSIZE"), Parameter file
 . ; Note Family Tree Index: ^TMP("XTSIZE","IDX",$J)
 . DO EN^XTVSCP(XPID) ;Display Corrections report
 . DO CRTPMCLN ; KILL ^TMP globals
 . DO REFRESH
 ;
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
EEXT ; Email ^XTMP("XTSIZE") extract global
 ; -- Protocol: XTVS PKG EXT EMAIL ACTION
 ;
 NEW XPID,QCHK
 SET QCHK=0
 WRITE !!," The message can take some time to be sent."
 SET XPID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'XPID DO JUSTPAWS^XTVSLAPI("No Process ID selected.") SET QCHK=1
 IF (XPID),('$D(^XTMP("XTSIZE",XPID))) DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_XPID_") is NOT defined!") SET QCHK=1
 IF 'QCHK DO
 . NEW XTINSTMM,XTTOMM,XMERR,XMZ,XTTYPE
 . KILL XMERR
 . SET XTINSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 . SET XTTYPE="S"
 . DO TOWHOM^XMXAPIU(DUZ,,XTTYPE,.XTINSTMM)
 . IF +$G(XMERR)'>0 DO
 .. NEW XMY,XMTEXT,XMDUZ,XMSUB,XDATE,XTLPCNT,XMMG,XMZ
 .. SET XTLPCNT=""
 .. FOR  SET XTLPCNT=$O(^TMP("XMY",$J,XTLPCNT)) QUIT:XTLPCNT=""  SET XMY(XTLPCNT)=""
 .. SET XMDUZ=DUZ
 .. SET XDATE=$P($P(^XTMP("XTSIZE",XPID,0),"^",3),"-")
 .. SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 .. SET XMSUB="PACKAGE FILE EXTRACT ("_$P(^XTMP("XTSIZE",XPID,0),"^",4)_" ; "_XDATE_" ; $JOB#: "_XPID_")"
 .. SET XMTEXT="^XTMP(""XTSIZE"","_XPID_","
 .. DO ENT^XMPG
 .. IF +XMZ>0 DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_XPID_") Emailed via PackMan.  [MSG #:"_XMZ_"]")
 .. IF +XMZ'>0  DO JUSTPAWS^XTVSLAPI("Error: ^XTMP(""XTSIZE"","_XPID_") not sent in Packman. ["_XMZ_"]")
 ;
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
QRYEXT ; Request Package File Extract from another VistA [E.G. Forum]
 ; -- Protocol: XTVS PKG EXT QUERY REMOTE ACTION
 ;
 NEW XTVSFQ,DIR,XMY,XTVSSZRP,XTVSRPT
 SET XTVSSZRP=0
 ;
 D FULL^VALM1
 ;
 SET DIR("A",1)=""
 SET DIR("A",2)=" The response from a remote VistA can take some time."
 SET DIR("A",3)=""
 SET DIR("A")="Do you want to query the Forum Package File? "
 SET DIR("B")="YES"
 SET DIR("?",1)="Yes to query Forum."
 SET DIR("?",2)="No to query another VistA."
 SET DIR("?")="Enter '^' to exit."
 SET DIR(0)="YA"
 DO ^DIR
 SET XTVSFQ=$GET(Y)
 IF ($DATA(DUOUT))!($DATA(DTOUT))!($DATA(DIROUT)) DO JUSTPAWS^XTVSLAPI("Forum query not indicated!")
 KILL DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ; Forum, prompt for a Size report from Forum; SET XTVSSIZE=1; and send to SERVER OPTION
 IF XTVSFQ=1 DO
 . SET XTVSSZRP=$$SIZRPTQY()
 . IF XTVSSZRP>-1 SET XMY("S.XTVS PKG EXTRACT SERVER@DOMAIN.EXT")="" ;Query FORUM for size rpt
 . IF XTVSSZRP=-1 DO JUSTPAWS^XTVSLAPI("Size Report prompt not answered!")
 ;
 ; Not Forum, Query VistA site (Domain)
 IF XTVSFQ=0 DO
 . KILL DIC,X,Y,DTOUT,DUOUT
 . SET DIC="^DIC(4.2,"
 . SET DIC(0)="AEQ"
 . SET DIC("A")="Domain server to query: "
 . SET DIC("S")="I $P(^(0),U,2)'=""C""" ;Screen "CLOSED" domains
 . DO ^DIC
 . IF ($DATA(DUOUT))!($DATA(DTOUT))!(+Y=-1) DO JUSTPAWS^XTVSLAPI("VistA Domain not selected!")
 . IF '$DATA(DUOUT),'$DATA(DTOUT),+Y>0 DO
 .. IF $PIECE(Y,"^",2)["FORUM" DO
 ... SET XTVSSZRP=$$SIZRPTQY() ;Query Size rpt
 .. IF XTVSSZRP>-1 SET XMY("S.XTVS PKG EXTRACT SERVER@"_$PIECE(Y,"^",2))="" ;Query address for size rpt
 .. IF XTVSSZRP=-1 DO JUSTPAWS^XTVSLAPI("Size Report prompt not answered!")
 . KILL DIC,X,Y,DTOUT,DUOUT
 ;
 IF ($DATA(XMY)) DO
 . NEW XMTEXT,XMDUZ,XMSUB,XDATE,XMMG,XMZ,TMP
 . SET TMP("XTVS REQ MSG",1)="REQUESTED BY: "_$$NETNAME^XMXUTIL(DUZ)
 . SET TMP("XTVS REQ MSG",2)="Extract Indicator: 1" ; Extract package file
 . IF XTVSSZRP=1 SET TMP("XTVS REQ MSG",3)="Report Indicator: 1" ; Request All Packages Size rpt
 . SET XMDUZ=DUZ
 . SET XMSUB="XTVS: PACKAGE FILE EXTRACT & REPORT REQUEST"
 . SET XMTEXT="TMP(""XTVS REQ MSG"","
 . DO ^XMD
 . IF +$GET(XMZ)<1 DO
 .. DO JUSTPAWS^XTVSLAPI("Error sending query message: "_XMMG_"!")
 . IF +$GET(XMZ)>0 DO
 .. DO JUSTPAWS^XTVSLAPI("Query message sent!  Message # "_XMZ)
 ;
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
MMADDOK(X,XMDUZ,XMMG,XTADD) ;Confirm user entered Domain address
 NEW Y,XMDF
 SET X="S.XTVS PKG EXTRACT SERVER@"_X
 SET XMDF=""
 DO INST^XMA21
 SET XTADD=$O(XMY(""))
 QUIT Y
 ;
SIZRPTQY() ; Prompt for Forum Size Rpt
 NEW DIR,X,Y,RESULT
 SET RESULT=-1
 SET DIR("A",1)=""
 SET DIR("A")="Do you want a VistA Package Size Report for all packages on Forum? "
 SET DIR("B")="NO"
 SET DIR("?",1)="Yes to receive a Package Size report on Forum."
 SET DIR("?",2)="No to just receive a Forum Package file extract."
 SET DIR("?")="Enter '^' to exit."
 SET DIR(0)="YA"
 DO ^DIR
 IF '$DATA(DTOUT),'$DATA(DUOUT) SET RESULT=Y
 QUIT RESULT

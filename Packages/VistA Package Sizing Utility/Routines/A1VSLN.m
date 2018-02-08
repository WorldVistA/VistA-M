A1VSLN ;Albany FO/GTS - VistA Package Sizing Manager; 30-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
EN ; -- main entry point for A1VS PKG MGR EXTRACT MNGR
 D EN^VALM("A1VS PKG MGR EXTRACT MNGR")
 Q
 ;
HDR ; -- header code
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Extract Manager"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 Q
 ;
INIT ; -- init variables and list array
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET VALMCNT=0
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"  Extracted package ^XTMP global list")
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"   Process ID        System                Date/Time")
 DO ADD^A1VSLAPI(.VALMCNT,"   ----------------------------------------------------")
 DO ADD^A1VSLAPI(.VALMCNT," ")
 ;;DO FNDXTMP("^TMP(""A1VS PKG MGR EXTRACT"","_$JOB_")")  ;; TO DO: GTS - Left for Array passing in parameter example; REMOVE CODE!
 DO FNDXTMP
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D KILL
 Q
 ;
EXPND ; -- expand code
 Q
 ;
REFRESH ; -- On Return from another Template or action, refresh A1VS PKG MGR EXTRACT MNGR List Template array
 NEW LNENUM,A1DOLRJ
 DO KILL^A1VSLN ;Kill all processing & data arrays and video attributes & control arrays for A1VS PKG MGR EXTRACT MNGR template
 SET EMGRTARY="^TMP(""A1VS PKG MGR EXTRACT"","_$J_")"
 SET LNENUM=0
 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM," ")
 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM,"  Extracted package ^XTMP global list")
 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM," ")
 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM,"   Process ID        System                Date/Time")
 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM,"   ----------------------------------------------------")
 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM," ")
 ;
 SET A1DOLRJ=0
 FOR  SET A1DOLRJ=$O(^XTMP("A1SIZE",A1DOLRJ)) Q:+A1DOLRJ=0  DO 
 . NEW DATE,EXSYS
 . SET DATE=$P(^XTMP("A1SIZE",A1DOLRJ,0),"^")
 . SET EXSYS=$P(^XTMP("A1SIZE",A1DOLRJ,0),"^",2)
 . SET DATE=$$FMTE^XLFDT(DATE,"1P")
 . DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM,$J(A1DOLRJ,13)_$J(EXSYS,15)_$J(DATE,27))
 IF LNENUM'>6 DO RTRNADD^A1VSLAPI(EMGRTARY,.LNENUM,"   No Extracts defined.")
 QUIT
 ;
KILL ; -- Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PKG MGR EXTRACT",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
FNDXTMP ; List Package Extracts
 NEW A1DOLRJ
 SET A1DOLRJ=0
 FOR  SET A1DOLRJ=$O(^XTMP("A1SIZE",A1DOLRJ)) Q:+A1DOLRJ=0  DO 
 . NEW DATE,EXSYS
 . SET DATE=$P(^XTMP("A1SIZE",A1DOLRJ,0),"^")
 . SET EXSYS=$P(^XTMP("A1SIZE",A1DOLRJ,0),"^",2)
 . SET DATE=$$FMTE^XLFDT(DATE,"1P")
 . DO ADD^A1VSLAPI(.VALMCNT,$J(A1DOLRJ,13)_$J(EXSYS,15)_$J(DATE,27))
 IF VALMCNT'>6 DO ADD^A1VSLAPI(.VALMCNT,"   No Extracts defined.")
 QUIT
 ;
SELDOLRJ() ; Select a Process ID
 ;OUTPUT:
 ;   RESULT : Selected PID
 ;          : -1 (failure)
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
CRTPMCLN ;Kill temporary globals created by 'A1VS PKG EXT CRT PARAM ACTION' Protocol
 KILL ^TMP("A1VS-FILERPT",$J),^TMP("A1SIZE",$J),^TMP("A1SIZE","IDX",$J)
 QUIT
 ;
 ;PROTOCOL entry points
DE ; -- Delete Extracts
 ; -- Protocol: A1VS PKG EXTRACT DEL ACTION
 NEW PROCID
 SET PROCID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'PROCID DO JUSTPAWS^A1VSLAPI("No Process ID selected.")
 IF (PROCID),('$D(^XTMP("A1SIZE",PROCID))) DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_PROCID_") is NOT defined!")
 IF (PROCID),($D(^XTMP("A1SIZE",PROCID))) DO
 . NEW X,Y,DIR
 . SET DIR("A",1)=""
 . SET DIR("A")="Do you want to delete ^XTMP(""A1SIZE"","_PROCID_")"
 . SET DIR("B")="NO"
 . SET DIR(0)="Y::"
 . DO ^DIR
 . IF ('$D(DTOUT)),('$D(DUOUT)),(($G(Y)=1)) KILL ^XTMP("A1SIZE",PROCID) DO KILL,INIT
 . IF ($D(DTOUT))!($D(DUOUT))!(($G(Y)=0)) DO
 .. DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_PROCID_") NOT DELETED!")
 ;
 KILL X,Y,DTOUT,DIRUT,DUOUT
 SET VALMBCK="R"
 QUIT
 ;
ED ; - Extract Display
 ; -- Protocol: A1VS PKG MGR EXT DISP ACTION
 ;
 NEW XPID,QCHK
 SET QCHK=0
 SET XPID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'XPID DO JUSTPAWS^A1VSLAPI("No Process ID selected.") SET QCHK=1
 IF (XPID),('$D(^XTMP("A1SIZE",XPID))) DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_XPID_") is NOT defined!") SET QCHK=1
 IF 'QCHK DO EN^A1VSLDE
 SET VALMBCK="R"
 QUIT
 ;
PEXT ; -- Create Extract
 ; -- Protocol: A1VS PKG EXTRACT CREATE ACTION
 ;
 NEW EXTRSLT
 SET EXTRSLT=$$PKGEXT^A1VSLNA1()
 DO REFRESH
 SET VALMBCK="R"
 QUIT
 ;
CRTPARM ; Display Package Parameter file from selected ^XTMP("A1SIZE") extract global
 ; -- Protocol: A1VS PKG EXT CRT PARAM ACTION
 ;
 NEW XPID,QCHK
 SET QCHK=0
 SET XPID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'XPID DO JUSTPAWS^A1VSLAPI("No Process ID selected.") SET QCHK=1
 IF (XPID),('$D(^XTMP("A1SIZE",XPID))) DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_XPID_") is NOT defined!") SET QCHK=1
 IF 'QCHK DO
 . DO XTMPORD^A1VSLNA1(XPID) ; Create ^TMP("A1SIZE"), Parameter file ; & ^TMP("A1SIZE","IDX"), Family Tree Index
 . KILL ^TMP("A1SIZE","IDX",$J) ; Cleanup Family Tree Index
 . DO EN^A1VSCP(XPID) ;Display Corrections report
 . DO CRTPMCLN ; KILL ^TMP globals
 . DO REFRESH
 ;
 SET VALMBCK="R"
 QUIT
 ;
EEXT ; Email ^XTMP("A1SIZE") extract global
 ; -- Protocol: A1VS PKG EXT EMAIL ACTION
 ;
 NEW XPID,QCHK
 SET QCHK=0
 SET XPID=$$SELDOLRJ() ;Prompt user to enter a Process ID
 ;
 IF 'XPID DO JUSTPAWS^A1VSLAPI("No Process ID selected.") SET QCHK=1
 IF (XPID),('$D(^XTMP("A1SIZE",XPID))) DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_XPID_") is NOT defined!") SET QCHK=1
 IF 'QCHK DO
 . NEW A1INSTMM,A1TOMM,XMERR,XMZ,A1TYPE
 . KILL XMERR
 . SET A1INSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 . SET A1TYPE="S"
 . DO TOWHOM^XMXAPIU(DUZ,,A1TYPE,.A1INSTMM)
 . IF +$G(XMERR)'>0 DO
 .. NEW XMY,XMTEXT,XMDUZ,XMSUB,XDATE,A1LPCNT
 .. SET A1LPCNT=""
 .. FOR  SET A1LPCNT=$O(^TMP("XMY",$J,A1LPCNT)) QUIT:A1LPCNT=""  SET XMY(A1LPCNT)=""
 .. SET XMDUZ=DUZ
 .. SET XDATE=$P(^XTMP("A1SIZE",XPID,0),"^")
 .. SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 .. SET XMSUB="PACKAGE FILE EXTRACT ("_$P(^XTMP("A1SIZE",XPID,0),"^",2)_" ; "_XDATE_" ; $JOB#: "_XPID_")"
 .. SET XMTEXT="^XTMP(""A1SIZE"","_XPID_","
 .. DO ENT^XMPG
 .. IF +XMZ>0 DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_XPID_") E-Mailed via PackMan.  [MSG #:"_XMZ_"]")
 .. IF +XMZ'>0  DO JUSTPAWS^A1VSLAPI("Error: ^XTMP(""A1SIZE"","_XPID_") not sent in Packman. ["_XMZ_"]")
 ;
 SET VALMBCK="R"
 QUIT

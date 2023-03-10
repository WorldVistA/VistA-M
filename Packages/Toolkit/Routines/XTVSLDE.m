XTVSLDE ;Albany FO/GTS - VistA Package Sizing Manager; 30-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN ; -- main entry point for XTVS PKG MGR EXT DISP ACTION
 D EN^VALM("XTVS PKG MGR EXT DISP")
 Q
 ;
HDR ; -- header code
 ;NOTE: XPID must be set by invoking action
 ;
 NEW XSYSTEM,XDATE,DIRHEAD,SPCPAD
 ;
 SET XDATE=$P($P(^XTMP("XTSIZE",XPID,0),"^",3),"-")
 SET XSYSTEM=$P(^XTMP("XTSIZE",XPID,0),"^",4)
 SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 SET:XDATE']"" XDATE="undefined"
 SET:XSYSTEM']"" XSYSTEM="undefined"
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Display Extract"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="System: "_XSYSTEM_"    PID:"_XPID_"     Date: "_XDATE
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; -- init variables and list array
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 NEW PKGSUB,FNSUB,PPFX,BFNM,EFNM,FILEMULT,ADDPFX,EXCPFX,FILRNG,PARENT
 SET VALMCNT=0
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"  Package data in ^XTMP extract")
 DO ADD^XTVSLAPI(.VALMCNT," ")
 SET PKGSUB=0
 FOR  SET PKGSUB=$O(^XTMP("XTSIZE",XPID,PKGSUB))  Q:PKGSUB=""  DO
 . SET (PPFX,BFNM,EFNM,ADDPFX,EXCPFX,FRNG,PARENT)=0
 . SET PPFX=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^")
 . SET BFNM=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^",2)
 . SET EFNM=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^",3)
 . SET FILEMULT=$$FEXT^XTVSLAPI("^XTMP(""XTSIZE"","_XPID_","""_PKGSUB_""")")
 . SET ADDPFX=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^",4)
 . SET EXCPFX=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^",5)
 . SET FILRNG=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^",6)
 . SET PARENT=$P(^XTMP("XTSIZE",XPID,PKGSUB),"^",7)
 . DO ADD^XTVSLAPI(.VALMCNT," ")
 . DO ADD^XTVSLAPI(.VALMCNT,PKGSUB,1,1,$L(PKGSUB))
 . DO ADD^XTVSLAPI(.VALMCNT,"Prefix: "_PPFX)
 . DO ADD^XTVSLAPI(.VALMCNT,"*Low File#: "_BFNM_"     *High File#: "_EFNM)
 . DO SPLITADD^XTVSLAPI(.VALMCNT,"File List: "_FILEMULT)
 . DO SPLITADD^XTVSLAPI(.VALMCNT,"Added Prefixes: "_ADDPFX)
 . DO SPLITADD^XTVSLAPI(.VALMCNT,"Excluded Prefixes: "_EXCPFX)
 . DO SPLITADD^XTVSLAPI(.VALMCNT,"File Ranges: "_FILRNG)
 . DO ADD^XTVSLAPI(.VALMCNT,"Parent Package: "_PARENT)
 DO MSG
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Display Extract help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !
 . WRITE !,"Delete Displayed Extract - This action prompts the user to confirm deletion"
 . WRITE !,"  of the ^XTMP global displayed in the list.  'No' displays a message and"
 . WRITE !,"  redisplays the extract global.  'Yes' deletes the global and returns to"
 . WRITE !,"  the Extract Manager screen.",!!
 D MSG
 Q
 ;
EXIT ; -- exit code
 DO KILL
 Q
 ;
KILL ;Clean up global arrays/variables and local variables
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MGR EXT DISP",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? for more actions and Help"
 QUIT
 ;
 ;PROTOCOL entry points
DEL ; -- Delete Extract
 ; -- Protocol: XTVS PKG EXT DISP DEL ACTION
 NEW X,Y,DIR
 SET DIR("A",1)=""
 SET DIR("A")="Do you want to delete ^XTMP(""XTSIZE"","_XPID_")"
 SET DIR("B")="NO"
 SET DIR(0)="Y::"
 DO ^DIR
 IF ('$D(DTOUT)),('$D(DUOUT)),(($G(Y)=1)) DO  QUIT
 . KILL ^XTMP("XTSIZE",XPID),X,Y,DTOUT,DIRUT,DUOUT
 . DO EXIT
 . DO REFRESH^XTVSLN
 . SET VALMBCK="Q"
 IF ($D(DTOUT))!($D(DUOUT))!(($G(Y)=0)) DO
 . DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_XPID_") NOT DELETED!")
 ;
 KILL X,Y,DTOUT,DIRUT,DUOUT
 DO MSG
 SET VALMBCK="R"
 QUIT

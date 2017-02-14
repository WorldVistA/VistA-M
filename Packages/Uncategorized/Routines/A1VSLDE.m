A1VSLDE ;Albany FO/GTS - VistA Package Sizing Manager; 30-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
EN ; -- main entry point for A1VS PKG MGR EXT DISP ACTION
 D EN^VALM("A1VS PKG MGR EXT DISP")
 Q
 ;
HDR ; -- header code
 ;NOTE: XPID must be set by invoking action
 ;
 NEW XSYSTEM,XDATE,DIRHEAD,SPCPAD
 ;
 SET XDATE=$P(^XTMP("A1SIZE",XPID,0),"^")
 SET XSYSTEM=$P(^XTMP("A1SIZE",XPID,0),"^",2)
 SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 SET:XDATE']"" XDATE="undefined"
 SET:XSYSTEM']"" XSYSTEM="undefined"
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Display Extract"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="System: "_XSYSTEM_"    PID:"_XPID_"     Date: "_XDATE
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; -- init variables and list array
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 NEW PKGSUB,FNSUB,PPFX,BFNM,EFNM,FILEMULT,ADDPFX,EXCPFX,FILRNG,PARENT
 SET VALMCNT=0
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"  Package data in ^XTMP extract")
 DO ADD^A1VSLAPI(.VALMCNT," ")
 SET PKGSUB=0
 FOR  SET PKGSUB=$O(^XTMP("A1SIZE",XPID,PKGSUB))  Q:PKGSUB=""  DO
 . SET (PPFX,BFNM,EFNM,ADDPFX,EXCPFX,FRNG,PARENT)=0
 . SET PPFX=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^")
 . SET BFNM=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^",2)
 . SET EFNM=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^",3)
 . SET FILEMULT=$$FEXT^A1VSLAPI("^XTMP(""A1SIZE"","_XPID_","""_PKGSUB_""")")
 . SET ADDPFX=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^",4)
 . SET EXCPFX=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^",5)
 . SET FILRNG=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^",6)
 . SET PARENT=$P(^XTMP("A1SIZE",XPID,PKGSUB),"^",7)
 . DO ADD^A1VSLAPI(.VALMCNT," ")
 . DO ADD^A1VSLAPI(.VALMCNT,PKGSUB,1,1,$L(PKGSUB))
 . DO ADD^A1VSLAPI(.VALMCNT,"Prefix: "_PPFX)
 . DO ADD^A1VSLAPI(.VALMCNT,"*Low File#: "_BFNM_"     *High File#: "_EFNM)
 . DO SPLITADD^A1VSLAPI(.VALMCNT,"File List: "_FILEMULT)
 . DO SPLITADD^A1VSLAPI(.VALMCNT,"Added Prefixes: "_ADDPFX)
 . DO SPLITADD^A1VSLAPI(.VALMCNT,"Excluded Prefixes: "_EXCPFX)
 . DO SPLITADD^A1VSLAPI(.VALMCNT,"File Ranges: "_FILRNG)
 . DO ADD^A1VSLAPI(.VALMCNT,"Parent Package: "_PARENT)
 QUIT
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 DO KILL
 Q
 ;
EXPND ; -- expand code
 Q
 ;
KILL ;Clean up global arrays/variables and local variables
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PKG MGR EXT DISP",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
 ;PROTOCOL entry points
DEL ; -- Delete Extract
 ; -- Protocol: A1VS PKG EXT DISP DEL ACTION
 NEW X,Y,DIR
 SET DIR("A",1)=""
 SET DIR("A")="Do you want to delete ^XTMP(""A1SIZE"","_XPID_")"
 SET DIR("B")="NO"
 SET DIR(0)="Y::"
 DO ^DIR
 IF ('$D(DTOUT)),('$D(DUOUT)),(($G(Y)=1)) DO  QUIT
 . KILL ^XTMP("A1SIZE",XPID),X,Y,DTOUT,DIRUT,DUOUT
 . DO EXIT
 . DO REFRESH^A1VSLN
 . SET VALMBCK="Q"
 IF ($D(DTOUT))!($D(DUOUT))!(($G(Y)=0)) DO
 . DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_XPID_") NOT DELETED!")
 ;
 KILL X,Y,DTOUT,DIRUT,DUOUT
 SET VALMBCK="R"
 QUIT

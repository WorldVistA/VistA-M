A1VSLE ;Albany FO/GTS - VistA Package Sizing Manager ; 24-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
EN ; -- main entry point for A1VS PKG MGR EDIT TOOLS
 D EN^VALM("A1VS PKG MGR EDIT TOOLS")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="              VistA Package Size Analysis Manager - Edit Tools"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="Parameter file default directory: "_$S($G(DEFDIR)]"":DEFDIR,1:"<no default defined>")
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 Q
 ;
INIT ; -- init variables and list array
 D BUILD
 Q
 ;
BUILD ; - Build local and global display arrays
 NEW DEFDIR,FILENME,HDLINE,RESULT,FILELIST,UNDRLINE,FILELP,LISTNUM
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET VALMCNT=0
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 IF DEFDIR']"" DO 
 . DO ADD^A1VSLAPI(.VALMCNT,"   XTMPSIZE.DAT default directory not specified.",4,48,)
 IF DEFDIR]"" DO
 . SET FILENME("XTMPSIZE*")=""
 . SET RESULT=$$LIST^%ZISH(DEFDIR,"FILENME","FILELIST")
 . DO ADD^A1VSLAPI(.VALMCNT," ")
 . SET HDLINE="   XTMPSIZE.DAT file list in "_DEFDIR_":"
 . SET $P(UNDRLINE,"-",$L(HDLINE)-3)=""
 . DO ADD^A1VSLAPI(.VALMCNT,HDLINE)
 . DO ADD^A1VSLAPI(.VALMCNT,"   "_UNDRLINE)
 . IF 'RESULT DO ADD^A1VSLAPI(.VALMCNT,"   No XTMPSIZE* files found in "_DEFDIR_".")
 . IF RESULT DO
 .. SET FILELP=""
 .. FOR  SET FILELP=$O(FILELIST(FILELP))  Q:FILELP=""  SET LISTNUM=VALMCNT-2 DO ADD^A1VSLAPI(.VALMCNT,"    "_LISTNUM_") "_FILELP)
 ;
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
 ;
REFRESH ; -- refresh display
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
MSG(TEXT) ; -- set default message
 ;SET VALMSG=TEXT
 QUIT
 ;
KILL ; -- Cleanup local and global arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PKG MAN EDIT",$JOB)
 QUIT

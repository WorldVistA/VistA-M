A1VSLM ;Albany FO/GTS - VistA Package Sizing Manager; 23-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
EN ; -- main entry point for A1VS PACKAGE MANAGER
 NEW FIRSTITM,LASTITM
 ;Definitions:
 ;  FIRSTITM - Line Item of first XTMPSIZE.DAT file in list
 ;  LASTITM  - Line Item of last XTMPSIZE.DAT file in list
 ;NOTE: These variables are used by A1VSLP & A1VSLR (A1VS PKG MGR PARAM DISPLAY ListMan & A1VS PKG MGR VISTA SIZE RPT Templates)
 ;
 D EN^VALM("A1VS PACKAGE MANAGER")
 QUIT
 ;
HDR ; -- header code
 SET VALMHDR(1)="                    VistA Package Size Analysis Manager"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 QUIT
 ;
INIT ; -- init variables and list array
 ;  DISPBAK  - List "BAK" files indicator [NOTE: Used by this List Template to turn on/off display of *.BAK files
 ;               [KILLed in EXIT]
 ;
 SET DISPBAK=+$$YNCHK^A1VSLAPI("Do you want to Display XTMPSIZE*.BAK (backup files)")
 ;
 DO BUILD
 QUIT
 ;
BUILD ; - Build local and global display arrays
 NEW DEFDIR,FILENME,HDLINE,RESULT,FILELIST,UNDRLINE,FILELP,LISTNUM
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 ;
 SET (FIRSTITM,LASTITM,VALMCNT)=0
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"   XTMPSIZE.DAT default directory: "_$S($G(DEFDIR)]"":DEFDIR,1:"<no default defined>"),1,36,$S($L(DEFDIR)>0:$L(DEFDIR),1:20))
 IF DEFDIR]"" DO
 . SET FILENME("XTMPSIZE*")=""
 . SET RESULT=$$LIST^%ZISH(DEFDIR,"FILENME","FILELIST")
 . DO ADD^A1VSLAPI(.VALMCNT," ")
 . SET HDLINE="   XTMPSIZE.DAT Package Parameter file list in "_DEFDIR_":"
 . SET $P(UNDRLINE,"-",$L(HDLINE)-3)=""
 . DO ADD^A1VSLAPI(.VALMCNT,HDLINE)
 . DO ADD^A1VSLAPI(.VALMCNT,"   "_UNDRLINE)
 . IF 'RESULT DO ADD^A1VSLAPI(.VALMCNT,"   No XTMPSIZE* files found in "_DEFDIR_".")
 . IF RESULT DO
 .. SET FILELP=""
 .. FOR  SET FILELP=$O(FILELIST(FILELP))  Q:FILELP=""  DO
 ... IF (+$G(DISPBAK)=1)!($P(FILELP,".",2)["DAT") DO
 .... SET LISTNUM=VALMCNT-4
 .... DO ADD^A1VSLAPI(.VALMCNT,"    "_LISTNUM_") "_FILELP)
 .... SET:FIRSTITM=0 FIRSTITM=VALMCNT
 .... SET LASTITM=VALMCNT
 ;
 QUIT
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 DO KILL
 KILL DISPBAK
 Q
 ;
EXPND ; -- expand code
 Q
 ;
KILL ; - Kill local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PACKAGE MGR",$JOB)
 QUIT
 ;
REFRESH ; -- refresh display
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
 ; APIs
MSG(TEXT) ; -- set default message
 ;SET VALMSG=TEXT
 QUIT
 ;
BLDNUM() ; -- returns the build number
 QUIT +$PIECE($PIECE($TEXT(A1VSLM+1),";",7),"Build ",2)
 ;
VERNUM() ; -- returns the version number for this build
 QUIT +$PIECE($TEXT(A1VSLM+1),";",3)
 ;
 ;PROTOCOL entry points
 ;
SP ; -- A1VS site parameters
 ; -- Protocol: A1VS SITE PARAMETERS
 DO FULL^VALM1
 DO TED^XPAREDIT("A1VS PKG MGT PARAMETERS","B")
 KILL VALMHDR
 DO REFRESH
 DO MSG
 QUIT
 ;
 ;
PE ; -- Package Manager Editor
 ; -- Protocol: A1VS PKG MGR MENU EDIT ACTION 
 DO EN^A1VSLE
 DO REFRESH
 DO MSG
 QUIT
 ;
PRMD ; -- Report Parameter file Display
 ; -- Protocol: A1VS PKG MGR PARAM DISPLAY ACTION
 DO EN^A1VSLP
 DO REFRESH
 DO MSG
 QUIT
 ;
VSR ; -- Generate a VistA Size Report
 ; -- Protocol: A1VS PKG MGR VISTA SIZE RPT
 DO EN^A1VSLR
 DO REFRESH
 DO MSG
 QUIT
 ;
EA ; -- Extract Manager
 ; -- Protocol: A1VS PKG MGR EXT MNGR ACTION
 DO EN^A1VSLN
 DO REFRESH
 DO MSG
 QUIT
 ;
DELPRM ; -- Delete a selected Parameter file
 ; -- Protocol: A1VS PKG MGR PARAM FILE DELETE ACTION
 ;
 NEW DEFDIR
 DO FULL^VALM1
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 IF (+$G(FIRSTITM)'>0)!($G(LASTITM)'>0) DO JUSTPAWS^A1VSLAPI(" No Package Parameter Files to delete in "_DEFDIR_".")
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO
 . NEW DELFILE,FILESEL,FILENME
 . SET DELFILE=0
 . SET FILESEL=$$SELXTMP^A1VSLAPI(FIRSTITM,LASTITM,5)
 . IF +FILESEL>0 DO
 .. SET FILENME=$P($G(^TMP("A1VS PACKAGE MGR",$J,FILESEL,0)),FILESEL-5_") ",2)
 .. SET DELFILE=+$$YNCHK^A1VSLAPI("Do you want to PERMANENTLY DELETE "_FILENME)
 .. IF DELFILE DO
 ... NEW DELFLE
 ... SET DELFLE(FILENME)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) K DELFLE(FILENME) ;Delete selected Parameter file
 ... IF 'DELRSLT DO JUSTPAWS^A1VSLAPI(FILENME_" parameter file deletion failed.  Check your privileges.")
 ... IF DELRSLT DO REFRESH
 ;
 SET VALMBCK="R"
 QUIT

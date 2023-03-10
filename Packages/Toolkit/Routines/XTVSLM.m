XTVSLM ;Albany FO/GTS - VistA Package Sizing Manager; 23-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN ; -- main entry point for XTVS PACKAGE MANAGER
 NEW FIRSTITM,LASTITM
 ;Definitions:
 ;  FIRSTITM - Line # of first XTMPSIZE.DAT file in list
 ;  LASTITM  - Line # of last XTMPSIZE.DAT file in list
 ;NOTE: These variables are used by XTVSLP & XTVSLR (XTVS PKG MGR PARAM DISPLAY ListMan & XTVS PKG MGR VISTA SIZE RPT Templates)
 ;
 D EN^VALM("XTVS PACKAGE MANAGER")
 QUIT
 ;
HDR ; -- header code
 SET VALMHDR(1)="                    VistA Package Size Analysis Manager"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 QUIT
 ;
INIT ; -- init variables and list array
 ;  DISPBAK  - List "BAK" files indicator [NOTE: Used by this List Template to turn on/off display of *.BAK files
 ;               [KILLed in EXIT]
 ;
 SET DISPBAK=$P($$YNCHK^XTVSLAPI("Do you want to Display XTMPSIZE*.BAK (backup files)"),"^",2)
 ;
 IF DISPBAK'=-1 DO BUILD
 IF DISPBAK=-1 SET VALMQUIT=""
 DO MSG
 QUIT
 ;
BUILD ; - Build local and global display arrays
 NEW DEFDIR,FILENME,HDLINE,RESULT,FILELIST,UNDRLINE,FILELP,LISTNUM
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 ;
 SET (FIRSTITM,LASTITM,VALMCNT)=0
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"   XTMPSIZE.DAT default directory: "_$S($G(DEFDIR)]"":DEFDIR,1:"<no default defined>"),1,36,$S($L(DEFDIR)>0:$L(DEFDIR),1:20))
 IF DEFDIR]"" DO
 . SET FILENME("XTMPSIZE*")=""
 . SET RESULT=$$LIST^%ZISH(DEFDIR,"FILENME","FILELIST")
 . DO ADD^XTVSLAPI(.VALMCNT," ")
 . SET HDLINE="   XTMPSIZE.DAT Package Parameter file list in "_DEFDIR_":"
 . SET $P(UNDRLINE,"-",$L(HDLINE)-3)=""
 . DO ADD^XTVSLAPI(.VALMCNT,HDLINE)
 . DO ADD^XTVSLAPI(.VALMCNT,"   "_UNDRLINE)
 . IF 'RESULT DO ADD^XTVSLAPI(.VALMCNT,"   No XTMPSIZE* files found in "_DEFDIR_".")
 . IF RESULT DO
 .. SET FILELP=""
 .. FOR  SET FILELP=$O(FILELIST(FILELP))  Q:FILELP=""  DO
 ... IF ($P(FILELP,".",2)'["LCK")&((+$G(DISPBAK)=1)!($P(FILELP,".",2)["DAT")) DO
 .... SET LISTNUM=VALMCNT-4
 .... DO ADD^XTVSLAPI(.VALMCNT,"    "_LISTNUM_") "_FILELP)
 .... SET:FIRSTITM=0 FIRSTITM=VALMCNT
 .... SET LASTITM=VALMCNT
 ;
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??",X'["???" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"VistA Package Size Analysis Manager help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LMTXT2+TXTCT^XTVSHLP2),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 IF $D(X),X["???" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"List specific actions:"
 . DO DISP^XQORM1 W !
 . WRITE !,"These actions provide a set of tools that support the process described here."
 . WRITE !,"VistA Package Size Reporting Process help...",!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LMTXT3+TXTCT^XTVSHLP2),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 S VALMBCK="R"
 D MSG
 K XTX,Y,TXTCT,XTQVAR
 Q
 ;
EXIT ; -- exit code
 DO KILL
 KILL DISPBAK
 Q
 ;
KILL ; - Kill local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PACKAGE MGR",$JOB)
 QUIT
 ;
REFRESH ; -- refresh display
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
 ; APIs
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? : more actions & Help, ??? : Process Help"
 QUIT
 ;
BLDNUM() ; -- returns the build number
 QUIT +$PIECE($PIECE($TEXT(XTVSLM+1),";",7),"Build ",2)
 ;
VERNUM() ; -- returns the version number for this build
 QUIT +$PIECE($TEXT(XTVSLM+1),";",3)
 ;
 ;PROTOCOL entry points
 ;
SP ; -- XTVS site parameters
 ; -- Protocol: XTVS SITE PARAMETERS
 DO FULL^VALM1
 DO TED^XPAREDIT("XTVS PKG MGT PARAMETERS","B")
 KILL VALMHDR
 DO REFRESH
 DO MSG
 QUIT
 ;
 ;
PRMD ; -- Report Parameter file Display
 ; -- Protocol: XTVS PKG MGR PARAM DISP/EDIT ACTION
 NEW DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 IF (+$G(FIRSTITM)'>0)!($G(LASTITM)'>0) DO JUSTPAWS^XTVSLAPI(" No Package Parameter Files in "_DEFDIR_" to display.")
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO EN^XTVSLP
 DO REFRESH
 DO MSG
 QUIT
 ;
VSR ; -- Generate a VistA Size Report
 ; -- Protocol: XTVS PKG MGR VISTA SIZE RPT
 NEW DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 IF (+$G(FIRSTITM)'>0)!($G(LASTITM)'>0) DO JUSTPAWS^XTVSLAPI(" No Package Parameter Files in "_DEFDIR_" to select.")
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO EN^XTVSLR
 DO REFRESH
 DO MSG
 QUIT
 ;
EA ; -- Extract Manager
 ; -- Protocol: XTVS PKG MGR EXT MNGR ACTION
 DO EN^XTVSLN
 DO REFRESH
 DO MSG
 QUIT
 ;
DELPRM ; -- Delete a selected Parameter file
 ; -- Protocol: XTVS PKG MGR PARAM FILE DELETE ACTION
 ;
 NEW DEFDIR
 DO FULL^VALM1
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 IF (+$G(FIRSTITM)'>0)!($G(LASTITM)'>0) DO JUSTPAWS^XTVSLAPI(" No Package Parameter Files to delete in "_DEFDIR_".")
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO
 . NEW DELFILE,FILESEL,FILENME,CHKLKER,UNLKRSLT,DELRSLT
 . SET DELFILE=0
 . SET FILESEL=$$SELXTMP^XTVSLAPI(FIRSTITM,LASTITM,5)
 . IF +FILESEL>0 DO
 .. SET FILENME=$P($G(^TMP("XTVS PACKAGE MGR",$J,FILESEL,0)),FILESEL-5_") ",2)
 .. SET CHKLKER=$$REQLOCK^XTVSLAPI(FILENME)
 .. IF 'CHKLKER DO   ;LOCKED
 ... SET DELFILE=+$$YNCHK^XTVSLAPI("Do you want to PERMANENTLY DELETE "_FILENME)
 ... IF DELFILE DO
 .... NEW DELFLE
 .... SET DELFLE(FILENME)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) K DELFLE(FILENME) ;Delete selected Parameter file
 .... IF 'DELRSLT DO JUSTPAWS^XTVSLAPI(FILENME_" parameter file deletion failed.  Check your privileges.")
 .... IF DELRSLT DO REFRESH
 ... SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI(FILENME)
 ... IF ($P(UNLKRSLT,"^")'=1) W !!," <* UNLOCK ERROR. Check LOCK file Integrity. *>" DO JUSTPAWS^XTVSLAPI($P(UNLKRSLT,"^",2))
 .. IF CHKLKER W !!," <* LOCK request denied! Try again later. *>" DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 ;
 D MSG
 IF VALMCNT#13=0 SET VALMBG=VALMCNT-12 ; When last file on screen deleted, display previous screen
 SET VALMBCK="R"
 QUIT
 ;
RMVLCK ; -- Package Parameter lock cleanup
 ; -- Protocol: XTVS PKG MGR PARAM UNLOCK ACTION
 ;
 NEW UNLKFNME,DELLOCK,DEFDIR,OPTUNLCK
 SET OPTUNLCK=1
 DO FULL^VALM1
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET UNLKFNME=$$PRMFLIST^XTVSLP("XTMPSIZE*.LCK"," There are no XTMPSIZE files LOCKED!") ;Select a File to unlock
 IF UNLKFNME[".LCK" DO
 . SET DELLOCK=+$$YNCHK^XTVSLAPI("Do you want to UNLOCK "_$P(UNLKFNME,".")_".DAT")
 . IF DELLOCK DO
 .. NEW UNLKRSLT
 .. SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI($P(UNLKFNME,".")_".DAT") ;Delete selected Parameter Lock file
 .. IF 'UNLKRSLT DO JUSTPAWS^XTVSLAPI($P(UNLKFNME,".")_".DAT"_" parameter file UNLOCK failed.  Check your privileges.")
 .. ;IF UNLKRSLT DO REFRESH
 DO REFRESH
 DO MSG
 QUIT
 ;
REMREQ ; Remote Report Protocol entry point
 ; -- Protocol: XTVS PKG QUERY REMOTE VISTA SIZE ACTION
 ;
 NEW DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 IF (+$G(FIRSTITM)'>0)!($G(LASTITM)'>0) DO JUSTPAWS^XTVSLAPI(" No Package Parameter Files in "_DEFDIR_" to select.")
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO
 . SET XTTMPLNN=$$SELXTMP^XTVSLAPI(FIRSTITM,LASTITM,5)
 . IF XTTMPLNN>0 DO
 .. SET XTVPSPRM=$P(^TMP("XTVS PACKAGE MGR",$J,XTTMPLNN,0),XTTMPLNN-5_") ",2)
 .. IF XTVPSPRM]"" DO REMRPTRQ^XTVSLR(XTVPSPRM)
 DO REFRESH
 DO MSG
 ;
 QUIT

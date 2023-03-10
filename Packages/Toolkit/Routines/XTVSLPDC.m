XTVSLPDC ;Albany FO/GTS - VistA Package Sizing Manager - Caption display; 12-JUL-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN ; -- main entry point for XTVS PKG MGR PARAM CAPTN DISP
 NEW CHNGMADE
 SET CHNGMADE=0
 KILL ^TMP("XTVS-PARAM-BI",$J)
 DO EN^VALM("XTVS PKG MGR PARAM CAPTN DISP")
 QUIT
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD,LASTSPKG
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Captioned List"
 SET VALMHDR(2)="                     Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_XTVPSPRM_$S(+$G(CHNGMADE)>0:"   {EDITED}",1:"")
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 DO MSG
 QUIT
 ;
INIT ; -- init variables and list array
 NEW DATAITEM,PRMLNLP,PKG,LASTSPKG,CAPDAT,LPNM,LNENUM,DEFDIR,FILENAME,LCKCHK
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO KILL
 . SET PKG=""
 . SET VALMCNT=0
 . FOR  SET PKG=$O(^TMP("XTVS-PARAM-CAP",$J,PKG)) Q:PKG=""  DO
 .. SET LNENUM=0
 .. SET CAPDAT=""
 .. DO ADD^XTVSLAPI(.VALMCNT," ")
 .. DO ADD^XTVSLAPI(.VALMCNT," ")
 .. FOR  SET LNENUM=$O(^TMP("XTVS-PARAM-CAP",$J,PKG,LNENUM)) Q:+LNENUM'>0  DO
 ... FOR  SET CAPDAT=$O(^TMP("XTVS-PARAM-CAP",$J,PKG,LNENUM,CAPDAT)) Q:CAPDAT=""  DO
 .... SET DATAITEM=^TMP("XTVS-PARAM-CAP",$J,PKG,LNENUM,CAPDAT)
 .... DO SPLITADD^XTVSLAPI(.VALMCNT,CAPDAT_":  "_DATAITEM)
 ;
 IF ($P(LCKCHK,"^")'=1) SET VALMQUIT="" DO EXIT^XTVSLPDC
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Captioned List action help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LPDCTXT+TXTCT^XTVSHLP1),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 DO HDR,INIT
 S VALMBCK="R"
 K XTX,Y,TXTCT,XTQVAR
 QUIT
 ;
EXIT ; -- exit code
 NEW SVEDT
 SET LCKCHK=$$CHKPID^XTVSLAPI($$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I"),XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . IF +$G(CHNGMADE)>0 DO
 .. DO FULL^VALM1
 .. WRITE !,"You have unsaved Package edits in this Parameter file!"
 .. SET SVEDT=+$$YNCHK^XTVSLAPI("Do you want to save the Parameter edits before exiting","YES")
 .. IF SVEDT DO PKGSAVE
 .. IF $G(CHNGMADE)>0 DO JUSTPAWS^XTVSLAPI(" Package edits NOT saved!")
 .. IF $G(CHNGMADE)'>0 DO JUSTPAWS^XTVSLAPI(" Package edits saved!")
 ;
 IF ($P(LCKCHK,"^")'=1) DO
 . DO FULL^VALM1
 . W !!," <* LOCK ERROR. LOCK required to proceed. Check LOCK file Integrity. *>"
 . DO JUSTPAWS^XTVSLAPI($P(LCKCHK,"^",2))
 ;
 KILL ^TMP("XTVS-PARAM-BI",$J)
 DO KILL
 Q
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? for more actions and Help"
 QUIT
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MGR PARAM CAP",$J)
 QUIT
 ;
SELPKG(ADPKG) ; Select Package to Edit from ^TMP("XTVS PKG MGR PARAM CAP",$J)
 ; INPUT:
 ;       ADPKG : 0 - Do not allow add new package [Default]
 ;             : 1 - Allow add new package
 ;
 NEW PKGNME,DIR,DIRUT,DTOUT,DUOUT,X,Y
 IF +$G(ADPKG)'=1 SET ADPKG=0  ;Default Add package to 'not allowed'
 SET PKGNME=0
 SET DIR("A")="Select Package: "
 SET DIR(0)="FAO^2:40^K:'(X'?1P.E) X"
 SET DIR("PRE")="DO CHKX^XTVSLPDC("_ADPKG_")"
 SET DIR("?")="^DO PKGHLP^XTVSLPDC"
 DO ^DIR
 IF $P(X,"^",1)="+1" SET LASTSPKG=X
 IF '$D(DIRUT) SET PKGNME=Y
 QUIT PKGNME
 ;
CHKX(XADD) ;Check for Package
 ; INPUT:
 ;       XADD : 0 - Do not allow add new package
 ;            : 1 - Allow add new package
 ;
 IF (X="^")!(X']"") QUIT  ;Quit if user entry to exit
 ;
 NEW SELARY,PKGLP,ITEMNUM,XVAL,DOADD
 SET DOADD=0
 IF $G(XADD)']"" SET XADD=0
 IF X=" ",$G(LASTSPKG)]"" SET X=LASTSPKG W X
 IF (X]""),('$D(^TMP("XTVS-PARAM-CAP",$J,X))) DO
 . IF 'XADD DO PKGLIST(.X,.LASTSPKG)
 . IF XADD,$E($G(X),1,1)'="?" DO
 .. IF $L($G(X))>3 DO
 ... SET DOADD=$$YNCHK^XTVSLAPI("ADD ENTRY")
 ... IF '(+DOADD),($P(DOADD,"^",2)'=-1) DO PKGLIST(.X,.LASTSPKG)
 ... IF '(+DOADD),($P(DOADD,"^",2)=-1) K X
 .. IF ($L($G(X))'>3),($G(X)'="") DO PKGLIST(.X,.LASTSPKG)
 .. IF +DOADD DO
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X)=X ;Create new entry in TMP global
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,1,"Package Name")=X
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,2,"Primary Prefix")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,3,"*Lowest File#")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,4,"*Highest File#")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,5,"Additional Prefixes")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,6,"Excepted Prefixes")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,7,"File Numbers")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,8,"File Ranges")=""
 ... SET ^TMP("XTVS-PARAM-CAP",$J,X,9,"Parent Package")=""
 . IF XADD,$E($G(X),1,1)="?" DO PKGLIST(.X,.LASTSPKG)
 ;
 QUIT
 ;
PKGLIST(X,LASTSPKG) ;List packages from user entry [to support 'XADD' mod in CHKX]
 SET ITEMNUM=0
 SET PKGLP=$G(X)
 FOR  SET PKGLP=$O(^TMP("XTVS-PARAM-CAP",$J,PKGLP))  Q:PKGLP=""  Q:($E(PKGLP,1,$L($G(X)))'=$G(X))  DO
 . SET ITEMNUM=ITEMNUM+1
 . SET SELARY(ITEMNUM)=PKGLP
 IF ITEMNUM>0 DO
 . SET XVAL=0
 . DO LISTOUT^XTVSLAPI(.SELARY) ;List Packages for selection
 . FOR  READ !,"Enter number for Selected Package: ",XVAL:DTIME  Q:'$T  Q:$E(XVAL,1)="^"  Q:XVAL=""  Q:((+XVAL>0)&(+XVAL<(ITEMNUM+1)))  DO
 .. IF XVAL["?" W !,"Select a package.  [Number 1 - "_ITEMNUM_"]"
 .. IF XVAL'?1.3"?" W !,"??"
 .. DO JUSTPAWS^XTVSLAPI(" Select from the listed packages. ['^' to exit]")
 .. DO LISTOUT^XTVSLAPI(.SELARY) ; Relist packages
 . ;
 IF '((+$G(XVAL)>0)&(+$G(XVAL)<(ITEMNUM+1))) KILL X ;If didn't enter existing package or select from a list, require re-entry of package
 IF (+$G(XVAL)>0)&(+$G(XVAL)<(ITEMNUM+1)) SET (LASTSPKG,X)=SELARY(XVAL) W "   ",X
 QUIT
 ;
PKGHLP(PRNT) ; Package selection help
 WRITE:+$G(PRNT) !,"Select a Package from list of packages. [Package Name is case sensitive.]",!
 WRITE:+$G(PRNT) !,"Parent Package indicates an association with a package that may include"
 WRITE:+$G(PRNT) !," component intersections causing duplicate counting of Routines, Options,"
 WRITE:+$G(PRNT) !," Protocols, Files, etc. by the VistA Package Size report.  For the VistA"
 WRITE:+$G(PRNT) !," Package Size Analysis Management tools, it is informational."
 WRITE:+$G(PRNT) !," However for VistA development management teams, it can mean more.",!
 IF +$$YNCHK^XTVSLAPI("Do you want a list of packages") DO 
 . NEW SELARY,ITEMNUM,PKGLP
 . SET ITEMNUM=0
 . SET PKGLP=""
 . FOR  SET PKGLP=$O(^TMP("XTVS-PARAM-CAP",$J,PKGLP))  Q:PKGLP=""  DO
 .. SET ITEMNUM=ITEMNUM+1
 .. SET SELARY(ITEMNUM)=PKGLP
 . DO LISTOUT^XTVSLAPI(.SELARY) ; Relist packages
 QUIT
 ;
EDITPRM ; Edit parameters for a package
 ; -- Protocol: XTVS PKG MGR EDIT PACKAGE PARM ACTION
 ;
 ;Logic notes:
 ; Select package name
 ; Edit package data in ^TMP("XTVS-PARAM-CAP") array
 ; Redisplay all 'Edited' packages to screen, set "Edit" [CHNGMADE] param to allow Write Edited pkgs action
 ;
 NEW PKGNME,EDITARY,CAPARY,EDPKG,DEFDIR,LCKCHK
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO FULL^VALM1
 . SET PKGNME=$$SELPKG(1)
 . IF PKGNME'=0 DO
 .. IF '$D(^TMP("XTVS-PARAM-BI",$J,PKGNME)) DO BEFORIMG^XTVSLPD1(PKGNME)
 .. SET CAPARY="^TMP(""XTVS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 .. DO EDPKGPRM^XTVSLPD1(PKGNME)
 .. SET EDPKG=$$EDCHK^XTVSLPD1(PKGNME)
 .. IF EDPKG SET @CAPARY=$$SETSTR^XTVSLPD1(CAPARY) ;Update header
 .. IF 'EDPKG KILL ^TMP("XTVS-PARAM-BI",$J,PKGNME)
 .. SET CHNGMADE=$E($D(^TMP("XTVS-PARAM-BI",$J)),1,1)
 ..;
 .. SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 .. SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 .. IF $P(LCKCHK,"^")=1 DO HDR,INIT
 .;
 . IF PKGNME=0 DO JUSTPAWS^XTVSLAPI(" Existing Package Not Selected.") DO MSG
 ;
 IF $P(LCKCHK,"^")=1 SET VALMBCK="R"
 IF $P(LCKCHK,"^")'=1 SET VALMQUIT=""
 QUIT
 ;
DELPMPKG ; Delete parameters from a package
 ; -- Protocol: XTVS PKG MGR DEL PACKAGE PARM ACTION
 ;
 NEW PKGNME,CAPARY,DELPKG,LCKCHK,DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO FULL^VALM1
 . SET PKGNME=$$SELPKG(0)
 . IF PKGNME'=0 DO
 .. SET CAPARY="^TMP(""XTVS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 .. WRITE !,"You have chosen to delete the "_PKGNME_" entry"
 .. WRITE !," from the "_XTVPSPRM_" Package Parameter file.",!
 .. WRITE !,"[If deleted, "_PKGNME_" will not be included"
 .. WRITE !,"  in any VistA Size Report derived from "_XTVPSPRM_"!]",!
 .. SET DELPKG=+$$YNCHK^XTVSLAPI("Are you SURE you want to delete the parameters for this package")
 .. IF 'DELPKG DO MSG
 .. IF DELPKG DO
 ... IF '$D(^TMP("XTVS-PARAM-BI",$J,PKGNME)) DO BEFORIMG^XTVSLPD1(PKGNME) ; Create BI when delete an existing, unedited package.
 ... KILL @CAPARY
 ... IF $D(^TMP("XTVS-PARAM-BI",$J,PKGNME,2,"Primary Prefix")),((^TMP("XTVS-PARAM-BI",$J,PKGNME,2,"Primary Prefix"))="") KILL ^TMP("XTVS-PARAM-BI",$J,PKGNME)
 ... SET CHNGMADE=$E($D(^TMP("XTVS-PARAM-BI",$J)),1,1)
 ... DO:$P($$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM),"^")=1 HDR,INIT
 .;
 . IF PKGNME=0 DO JUSTPAWS^XTVSLAPI(" Existing Package Not Selected.") DO MSG
 .;
 . SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 . SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 ;
 IF $P(LCKCHK,"^")=1 SET VALMBCK="R"
 IF $P(LCKCHK,"^")'=1 SET VALMBCK="Q" SET VALMQUIT=""
 QUIT
 ;
SAVPMPKG ; Save Package Parameters file
 ; -- Protocol: XTVS PKG MGR SAVE PACKAGE PARM ACTION
 ;
 NEW LCKCHK,DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO FULL^VALM1
 . IF +$G(CHNGMADE)'>0 DO JUSTPAWS^XTVSLAPI("File Content not edited.  No modifications to save!") DO MSG
 . IF +$G(CHNGMADE)>0 DO 
 .. DO PKGSAVE
 .. IF $G(CHNGMADE)'>0 DO HDR,INIT
 .. IF $G(CHNGMADE)>0 DO MSG
 . SET VALMBCK="R"
 ;
 IF $P(LCKCHK,"^")'=1 SET VALMQUIT=""
 QUIT
 ;
PKGSAVE ;Save Package Changes
 NEW NOWDT,INITIAL,PKGNME,WNFILE,WOFILE,FILENME,DEFDIR
 SET NOWDT=$$FMTE^XLFDT($$NOW^XLFDT,"2M")
 SET NOWDT=$TR(NOWDT,"/","-")
 SET NOWDT=$TR(NOWDT,"@","_")
 SET NOWDT=$TR(NOWDT,":","")
 SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 IF INITIAL']"" SET INITIAL="<unk>"
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 ;
 SET (WNFILE,WOFILE)=0
 SET WNFILE=+$$YNCHK^XTVSLAPI("Do you want to create a new package parameters file")
 SET:'WNFILE WOFILE=+$$YNCHK^XTVSLAPI("Do you want to OVERWRITE the existing package parameters file")
 IF (WNFILE)!(WOFILE) DO
 . NEW DELRSLT
 . IF WNFILE SET FILENME="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT" ;Output a New Parameter file
 . ;
 . SET DELRSLT=1 ; Initialize DELRSLT (delete Result) variable
 . IF WOFILE DO  ;Write Old File: FILENME remains the selected/displayed parameter file
 .. NEW DELFLE,OLDFNME,CHKLKER
 .. SET FILENME=XTVPSPRM
 .. IF FILENME[";" SET FILENME=$P(FILENME,";")
 .. SET OLDFNME=$P(FILENME,".")_".BAK"
 .. SET DELFLE(OLDFNME)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) K DELFLE(OLDFNME) ;Delete current Parameter file
 .. SET DELRSLT=$$MV^%ZISH(DEFDIR,XTVPSPRM,DEFDIR,OLDFNME) ;Save current file to "BAK" before overwriting
 .. IF DELRSLT SET DELFLE(XTVPSPRM)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) ;Delete current Parameter file
 .. SET FILENME=XTVPSPRM
 .. DO CRTFLE(DEFDIR,FILENME,WNFILE)
 . ;
 . ; If file name definitions and copies were completed successfully, create the Parameter file
 . IF DELRSLT DO
 .. IF WNFILE DO  ;Write New File
 ... SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI(XTVPSPRM)
 ... IF ($P(UNLKRSLT,"^")'=1) W !!," <* UNLOCK ERROR. Check LOCK file Integrity. *>"
 ... DO JUSTPAWS^XTVSLAPI($P(UNLKRSLT,"^",2))
 ... IF ($P(UNLKRSLT,"^")=1) DO CRTFLE(DEFDIR,FILENME,WNFILE)
 ;
 QUIT
 ;
CRTFLE(DEFDIR,FILENME,WNFILE) ; Update old file/Write New file
 NEW POPERR,CHKLKER
 SET POPERR=0
 DO OPEN^%ZISH("XTMP",DEFDIR,FILENME,"A")
 SET:POP POPERR=POP
 IF 'POPERR DO
 . U IO
 . SET PKGNME=""
 . FOR  SET PKGNME=$O(^TMP("XTVS-PARAM-CAP",$J,PKGNME)) QUIT:PKGNME']""  WRITE !,^TMP("XTVS-PARAM-CAP",$J,PKGNME)
 . D CLOSE^%ZISH("XTMP")
 . SET XTVPSPRM=FILENME
 . SET CHNGMADE=0
 . KILL ^TMP("XTVS-PARAM-BI",$J)
 . IF WNFILE DO
 .. SET CHKLKER=$$REQLOCK^XTVSLAPI(XTVPSPRM)
 .. DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 QUIT

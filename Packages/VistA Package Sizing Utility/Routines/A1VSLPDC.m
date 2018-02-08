A1VSLPDC ;Albany FO/GTS - VistA Package Sizing Manager - Caption display; 12-JUL-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
EN ; -- main entry point for A1VS PKG MGR PARAM CAPTN DISP
 NEW CHNGMADE
 SET CHNGMADE=0
 D EN^VALM("A1VS PKG MGR PARAM CAPTN DISP")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD,LASTSPKG
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Captioned List"
 SET VALMHDR(2)="                     Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_A1VPSPRM_$S(+$G(CHNGMADE)>0:"   {EDITED}",1:"")
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; -- init variables and list array
 NEW DATAITEM,PRMLNLP,PKG,LASTPKG,CAPDAT,LPNM,LNENUM
 DO KILL
 SET PKG=""
 SET VALMCNT=0
 FOR  SET PKG=$O(^TMP("A1VS-PARAM-CAP",$J,PKG)) Q:PKG=""  DO
 . SET LNENUM=0
 . SET CAPDAT=""
 . DO ADD^A1VSLAPI(.VALMCNT," ")
 . DO ADD^A1VSLAPI(.VALMCNT," ")
 . FOR  SET LNENUM=$O(^TMP("A1VS-PARAM-CAP",$J,PKG,LNENUM)) Q:+LNENUM'>0  DO
 .. FOR  SET CAPDAT=$O(^TMP("A1VS-PARAM-CAP",$J,PKG,LNENUM,CAPDAT)) Q:CAPDAT=""  DO
 ... SET DATAITEM=^TMP("A1VS-PARAM-CAP",$J,PKG,LNENUM,CAPDAT)
 ... DO SPLITADD^A1VSLAPI(.VALMCNT,CAPDAT_":  "_DATAITEM)
 QUIT
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("A1VS PKG MGR PARAM CAP",$J) ;,^TMP("A1VS-PARAM-EDIT",$J)
 QUIT
 ;
SELPKG(ADPKG) ; Select Package to Edit from ^TMP("A1VS PKG MGR PARAM CAP",$J)
 ; INPUT:
 ;       ADPKG : 0 - Do not allow add new package [Default]
 ;             : 1 - Allow add new package
 ;
 NEW PKGNME,DIR,DIRUT,DTOUT,DUOUT,X,Y
 IF +$G(ADPKG)'=1 SET ADPKG=0  ;Default Add package to 'not allowed"
 SET PKGNME=0
 SET DIR("A")="Select Package: "
 ;SET:ADPKG DIR(0)="FAO^4:40^K:'(X'?1P.E) X"
 ;SET:'ADPKG DIR(0)="FAO^2:40^K:'(X'?1P.E) X"
 SET DIR(0)="FAO^2:40^K:'(X'?1P.E) X"
 SET DIR("PRE")="DO CHKX^A1VSLPDC("_ADPKG_")"
 SET DIR("?")="^DO PKGHLP^A1VSLPDC"
 DO ^DIR
 IF $P(X,"^",1)="+1" SET LASTSPKG=X
 IF '$D(DIRUT) SET PKGNME=Y
 QUIT PKGNME
 ;
DATACHK(PKG) ; Check for existence of entered package in ^TMP("A1VS PKG MGR PARAM CAP",$J)
 NEW RESULT
 SET RESULT=0
 IF $D(^TMP("A1VS-PARAM-CAP",$J,PKG)) SET RESULT=1
 QUIT RESULT
 ;
EDPKGPRM(PKGNME) ; Edit Package Parameters
 NEW CHNGMADE,DATANUM,EDITARY,DATANAME,GETOUT,UPDATLST
 ;SET EDITARY="^TMP(""A1VS-PARAM-EDIT"","_$J_","""_PKGNME_""")"
 SET EDITARY="^TMP(""A1VS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 SET (CHNGMADE,DATANUM)=0
 FOR  SET DATANUM=$O(@EDITARY@(DATANUM)) QUIT:+DATANUM=0  QUIT:($D(DTOUT)!($D(DUOUT)))  DO
 . SET DATANAME=$O(@EDITARY@(DATANUM,""))
 . NEW DIR,X,Y
 . SET DIR("A")=DATANAME_": " ;Set DIR("A") default prompt
 . IF @EDITARY@(DATANUM,DATANAME)]"" SET DIR("B")=@EDITARY@(DATANUM,DATANAME) ;Set Prompt for DIR read
 . ;
 . ;Primary Prefix (2)
 . IF (DATANUM=2) DO
 .. SET DIR("?",1)=" Enter Package Prefix from 2 to 4 characters."
 .. SET DIR("?")="(1 upper case letter followed by 1 - 3 upper case letters or numbers.)"
 .. SET DIR(0)="FA^2:4^K:$L(X)>4!(X'?1U1.3NU) X"
 .. DO ^DIR
 .. IF ('$D(DTOUT)&('$D(DUOUT))) DO
 ... IF ($D(DIRUT)) DO UPDTNODE^A1VSLPD1(DIRUT,EDITARY,DATANUM,DATANAME,X,.CHNGMADE)
 ... IF '$D(DIRUT),(@EDITARY@(DATANUM,DATANAME)'=X) SET @EDITARY@(DATANUM,DATANAME)=Y SET CHNGMADE=1
 ... KILL DIRUT
 . ;
 . ;*Lowest File# (3) & *Highest File# (4)
 . IF ((DATANUM=3)!(DATANUM=4)) DO
 .. SET DIR("?",1)=" Enter File Number 0 - 999999999, decimals allowed."
 .. SET DIR(0)="NOA^0:999999999:6"
 .. DO ^DIR
 .. IF ('$D(DTOUT)&('$D(DUOUT))) DO
 ... IF ($D(DIRUT)) DO UPDTNODE^A1VSLPD1(DIRUT,EDITARY,DATANUM,DATANAME,X,.CHNGMADE)
 ... IF '$D(DIRUT),(@EDITARY@(DATANUM,DATANAME)'=X) SET @EDITARY@(DATANUM,DATANAME)=Y SET CHNGMADE=1
 ... KILL DIRUT
 . ;
 . ;Additional Prefixes (5) & Excepted Prefixes (6)
 . IF ((DATANUM=5)!(DATANUM=6)) DO
 .. NEW LISTDATA  ;,PPRMT
 .. SET GETOUT=0
 .. FOR  QUIT:GETOUT  DO  ;Edit Prefix List Loop
 ... SET LISTDATA=@EDITARY@(DATANUM,DATANAME)
 ... DO SPLITOUT^A1VSLPD1(DATANAME,LISTDATA) ;Display Listed data to screen for user
 ... SET PPRMT="Enter "_$S(DATANUM=5:"Additional",1:"Excepted")_" Prefix: "
 ... SET DIR("A")=PPRMT  ;RESET DIR("A") default prompt
 ... KILL DIR("B") ;No default, select from list
 ... SET DIR("?")=" Enter a new Prefix or one from list. [Note: Entry is case sensitive.]"
 ... SET DIR(0)="FAO^2:6^K:(X'?1U1.5NU) X"
 ... DO ^DIR
 ... IF (Y=-1)!(Y="")!(Y="@")!($D(DTOUT))!($D(DUOUT)) SET GETOUT=1
 ... SET UPDATLST=0
 ... IF 'GETOUT DO EDITPRFX^A1VSLPD1(Y,.LISTDATA,.UPDATLST)
 ... IF UPDATLST SET @EDITARY@(DATANUM,DATANAME)=LISTDATA SET CHNGMADE=1
 . ;
 . ; File Numbers (7)
 . IF (DATANUM=7) DO
 .. NEW LISTDATA
 .. SET GETOUT=0
 .. FOR  QUIT:GETOUT  DO  ;Edit Prefix List Loop
 ... SET LISTDATA=@EDITARY@(DATANUM,DATANAME)
 ... DO SPLITOUT^A1VSLPD1(DATANAME,LISTDATA) ;Display Listed data to screen for user
 ... SET DIR("A")="Enter File Number: " ;RESET DIR("A") default prompt
 ... KILL DIR("B") ;No default, select from list
 ... SET DIR("?",1)=" Enter a new File Number or one from list."
 ... SET DIR("?")="New file numbers only between 1.9999 and 99999999.999999"
 ... SET DIR(0)="NAO^1.9999:99999999.999999:6"
 ... DO ^DIR
 ... IF (Y=-1)!(Y="")!(Y="@")!($D(DTOUT))!($D(DUOUT)) SET GETOUT=1
 ... SET UPDATLST=0
 ... IF 'GETOUT DO EDITFNUM^A1VSLPD1(Y,.LISTDATA,.UPDATLST)
 ... IF UPDATLST SET @EDITARY@(DATANUM,DATANAME)=LISTDATA SET CHNGMADE=1
 . ;
 . ; File Ranges (8)
 . IF (DATANUM=8) DO
 .. NEW LISTDATA
 .. SET GETOUT=0
 .. FOR  QUIT:GETOUT  DO  ;Edit Prefix List Loop
 ... SET LISTDATA=@EDITARY@(DATANUM,DATANAME)
 ... DO SPLITOUT^A1VSLPD1(DATANAME,LISTDATA) ;Display Listed data to screen for user
 ... SET DIR("A")="Enter File Number Range: "  ;RESET DIR("A") default prompt
 ... KILL DIR("B") ;No default, select from list
 ... SET DIR("?",1)=" Enter a new File Number Range or one from the list."
 ... SET DIR("?")="New file number ranges only between 1.9999 and 99999999.999999"
 ... SET DIR(0)="FAO^3:31^K:$$BADRNG^A1VSLPD1(X) X"
 ... DO ^DIR
 ... IF (Y=-1)!(Y="")!(Y="@")!($D(DTOUT))!($D(DUOUT)) SET GETOUT=1
 ... SET UPDATLST=0
 ... IF 'GETOUT DO EDITFRNG^A1VSLPD1(Y,.LISTDATA,.UPDATLST)
 ... IF UPDATLST SET @EDITARY@(DATANUM,DATANAME)=LISTDATA SET CHNGMADE=1
 . ;
 . ;Parent Package (9)
 . IF (DATANUM=9) DO
 .. SET DIR("A",1)=" "
 .. SET DIR("PRE")="DO:X'=""@"" CHKX^A1VSLPDC(0)" ;Check X for existing package
 .. SET DIR("?")="^DO PKGHLP^A1VSLPDC"
 .. SET DIR(0)="FAOr^4:30^K:('(X'?1P.E)) X"
 .. DO ^DIR
 .. IF ('$D(DTOUT)&('$D(DUOUT))) DO
 ... IF ($D(DIRUT)) DO UPDTNODE^A1VSLPD1(DIRUT,EDITARY,DATANUM,DATANAME,X,.CHNGMADE)
 ... IF '$D(DIRUT),(@EDITARY@(DATANUM,DATANAME)'=X) SET @EDITARY@(DATANUM,DATANAME)=Y SET CHNGMADE=1
 . ;
 . KILL DIR,X,Y
 ;
 KILL DIR,DIRUT,DTOUT,DUOUT,X,Y
 QUIT CHNGMADE
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
 IF (X]""),('$D(^TMP("A1VS-PARAM-CAP",$J,X))) DO
 . IF 'XADD DO PKGLIST(.X,.LASTSPKG)
 . IF XADD,$E($G(X),1,1)'="?" DO
 .. IF $L($G(X))>3 DO
 ... SET DOADD=+$$YNCHK^A1VSLAPI("ADD ENTRY")
 ... IF 'DOADD DO PKGLIST(.X,.LASTSPKG)
 .. IF $L($G(X))'>3 DO PKGLIST(.X,.LASTSPKG)
 .. IF DOADD DO
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X)=X ;Create new entry in TMP global
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,1,"Package Name")=X
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,2,"Primary Prefix")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,3,"*Lowest File#")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,4,"*Highest File#")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,5,"Additional Prefixes")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,6,"Excepted Prefixes")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,7,"File Numbers")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,8,"File Ranges")=""
 ... SET ^TMP("A1VS-PARAM-CAP",$J,X,9,"Parent Package")=""
 . IF XADD,$E($G(X),1,1)="?" DO PKGLIST(.X,.LASTSPKG)
 ;
 QUIT
 ;
PKGLIST(X,LASTSPKG) ;List packages from user entry [to support 'XADD' mod in CHKX]
 SET ITEMNUM=0
 SET PKGLP=$G(X)
 FOR  SET PKGLP=$O(^TMP("A1VS-PARAM-CAP",$J,PKGLP))  Q:PKGLP=""  Q:($E(PKGLP,1,$L($G(X)))'=$G(X))  DO
 . SET ITEMNUM=ITEMNUM+1
 . SET SELARY(ITEMNUM)=PKGLP
 IF ITEMNUM>0 DO
 . SET XVAL=0
 . DO LISTOUT^A1VSLAPI(.SELARY) ;List Packages for selection
 . FOR  READ !,"Enter number for Selected Package: ",XVAL:DTIME  Q:'$T  Q:$E(XVAL,1)="^"  Q:XVAL=""  Q:((+XVAL>0)&(+XVAL<(ITEMNUM+1)))  DO
 .. IF XVAL["?" W !,"Select a package.  [Number 1 - "_ITEMNUM_"]"
 .. IF XVAL'?1.3"?" W !,"??"
 .. DO JUSTPAWS^A1VSLAPI(" Select from the listed packages. ['^' to exit]")
 .. DO LISTOUT^A1VSLAPI(.SELARY) ; Relist packages
 . ;
 IF '((+$G(XVAL)>0)&(+$G(XVAL)<(ITEMNUM+1))) KILL X ;If didn't enter existing package or select from a list, require re-entry of package
 IF (+$G(XVAL)>0)&(+$G(XVAL)<(ITEMNUM+1)) SET (LASTSPKG,X)=SELARY(XVAL) W "   ",X
 QUIT
 ;
PKGHLP ; Package selection help
 WRITE !," Select a Package from list of packages. [Package Name is case sensitive.]"
 IF +$$YNCHK^A1VSLAPI("Do you want a list of packages") DO 
 . NEW SELARY,ITEMNUM,PKGLP
 . SET ITEMNUM=0
 . SET PKGLP=""
 . FOR  SET PKGLP=$O(^TMP("A1VS-PARAM-CAP",$J,PKGLP))  Q:PKGLP=""  DO
 .. SET ITEMNUM=ITEMNUM+1
 .. SET SELARY(ITEMNUM)=PKGLP
 . DO LISTOUT^A1VSLAPI(.SELARY) ; Relist packages
 QUIT
 ;
EDITPRM ; Edit parameters for a package
 ; -- Protocol: A1VS PKG MGR EDIT PACKAGE PARM ACTION
 ;
 ;Logic notes:
 ; Select package name
 ; Create EDIT version of "A1VS-PARAM-CAP" array ["A1VS-PARAM-EDIT"]
 ; Execute DIR to prompt data in selected package
 ; Update ^TMP("A1VS-PARAM-CAP") array from "A1VS-PARAM-EDIT" array
 ; Redisplay all 'Edited' packages to screen, set "Edit" param to allow Write Edited pkgs action
 ; [Need an action to write "edited" packages]
 ;    [. Walk through ^TMP("A1VS-PARAM-CAP",$J,<package name>) nodes @ write to file named in "A1VPSPRM" variable]
 ;
 NEW PKGNME,EDITARY,CAPARY
 DO FULL^VALM1
 SET PKGNME=$$SELPKG(1)
 IF PKGNME'=0 DO
 . SET CAPARY="^TMP(""A1VS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 . SET CHNGMADE=$$EDPKGPRM(PKGNME)
 . IF CHNGMADE DO  ;MERGE @CAPARY=@EDITARY DO 
 .. SET @CAPARY=$$SETSTR^A1VSLPD1(CAPARY)
 .. DO HDR,INIT
 ;
 IF PKGNME=0 DO JUSTPAWS^A1VSLAPI(" Existing Package Not Selected.")
 ;
 SET VALMBCK="R"
 QUIT
 ;
DELPMPKG ; Delete parameters from a package
 ; -- Protocol: A1VS PKG MGR DEL PACKAGE PARM ACTION
 ;
 NEW PKGNME,CAPARY
 DO FULL^VALM1
 SET PKGNME=$$SELPKG(0)
 IF PKGNME'=0 DO
 . SET CAPARY="^TMP(""A1VS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 . WRITE !,"You have chosen to delete the "_PKGNME_" entry"
 . WRITE !," from the "_A1VPSPRM_" Package Parameter file.",!
 . WRITE !,"[If deleted, "_PKGNME_" will not be included"
 . WRITE !,"  in the VistA Size Report!]",!
 . SET CHNGMADE=+$$YNCHK^A1VSLAPI("Are you SURE you want to delete the parameters for this package")
 . IF CHNGMADE KILL @CAPARY DO HDR,INIT
 ;
 IF PKGNME=0 DO JUSTPAWS^A1VSLAPI(" Existing Package Not Selected.")
 ;
 SET VALMBCK="R"
 QUIT
 ;
SAVPMPKG ; Save Package Parameters file
 ; -- Protocol: A1VS PKG MGR SAVE PACKAGE PARM ACTION
 ;
 DO FULL^VALM1
 IF +$G(CHNGMADE)'>0 DO JUSTPAWS^A1VSLAPI("No Edits have been made.  Nothing new to save!")
 IF +$G(CHNGMADE)>0 DO
 . NEW POPERR,NOWDT,INITIAL,PKGNME,WNFILE,WOFILE,FILENME,DEFDIR
 . SET POPERR=0
 . SET NOWDT=$$FMTE^XLFDT($$NOW^XLFDT,"2M")
 . SET NOWDT=$TR(NOWDT,"/","-")
 . SET NOWDT=$TR(NOWDT,"@","_")
 . SET NOWDT=$TR(NOWDT,":","")
 . SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 . IF INITIAL']"" SET INITIAL="<unk>"
 . SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 . ;
 . SET (WNFILE,WOFILE)=0
 . SET WNFILE=+$$YNCHK^A1VSLAPI("Do you want to create a new package parameters file")
 . SET:'WNFILE WOFILE=+$$YNCHK^A1VSLAPI("Do you want to OVERWRITE the existing package parameters file")
 . IF (WNFILE)!(WOFILE) DO
 .. NEW DELRSLT
 .. IF WNFILE SET FILENME="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT" ;Output a New Parameter file
 .. ;
 .. SET DELRSLT=1 ; Initialize DELRSLT (delete Result) variable
 .. IF WOFILE DO  ;FILENME remains the selected/displayed parameter file
 ... NEW DELFLE,OLDFNME
 ... SET FILENME=A1VPSPRM
 ... IF FILENME[";" SET FILENME=$P(FILENME,";")
 ... SET OLDFNME=$P(FILENME,".")_".BAK"
 ... SET DELFLE(OLDFNME)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) K DELFLE(OLDFNME) ;Delete current Parameter file
 ... SET DELRSLT=$$MV^%ZISH(DEFDIR,A1VPSPRM,DEFDIR,OLDFNME) ;Save current file to "OLD" before overwriting
 ... IF DELRSLT SET DELFLE(A1VPSPRM)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) ;Delete current Parameter file
 ... SET FILENME=A1VPSPRM
 .. ;
 .. ; If file name definitions and copies were completed successfully, create the Parameter file
 .. IF DELRSLT DO
 ... DO OPEN^%ZISH("XTMP",DEFDIR,FILENME,"A")
 ... SET:POP POPERR=POP
 ... QUIT:POPERR
 ... U IO
 ... SET PKGNME=""
 ... FOR  SET PKGNME=$O(^TMP("A1VS-PARAM-CAP",$J,PKGNME)) QUIT:PKGNME']""  WRITE !,^TMP("A1VS-PARAM-CAP",$J,PKGNME)
 ... D CLOSE^%ZISH("XTMP")
 ... SET A1VPSPRM=FILENME
 ... SET CHNGMADE=0
 ... DO HDR,INIT
 ;
 SET VALMBCK="R"
 QUIT

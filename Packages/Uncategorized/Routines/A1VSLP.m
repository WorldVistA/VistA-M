A1VSLP ;Albany FO/GTS - VistA Package Sizing Manager; 7-JUL-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
EN ; -- main entry point for A1VS PKG MGR PARAM DISPLAY
 D EN^VALM("A1VS PKG MGR PARAM DISPLAY")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Parameter Display"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_A1VPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 QUIT
 ;
BUILD ; - Build local and global display arrays
 NEW DEFDIR,CAPNODE
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 DO OPEN^%ZISH("XTMP",DEFDIR,A1VPSPRM,"R")
 U IO
 SET (CAPNODE,VALMCNT)=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO 
 .. DO SCAPARY(LINEITEM,.CAPNODE) ;Creates ^TMP("A1VS-PARAM-CAP",$J) array
 .. DO SPLITADD^A1VSLAPI(.VALMCNT,LINEITEM,1)
 .. DO LOADTMP(LINEITEM) ;Store LineItem into ^TMP global & Index
 D CLOSE^%ZISH("XTMP")
 QUIT
 ;
INIT ; -- init variables and list array
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO
 . NEW A1TMPLNN
 . SET A1TMPLNN=$$SELXTMP^A1VSLAPI(FIRSTITM,LASTITM,5)
 . IF +A1TMPLNN>0 DO
 .. SET A1VPSPRM=$P($G(^TMP("A1VS PACKAGE MGR",$J,A1TMPLNN,0)),A1TMPLNN-5_") ",2)
 .. IF A1VPSPRM]"" DO BUILD
 .. IF A1VPSPRM']"" SET VALMQUIT=""
 . IF A1TMPLNN=-1 DO EXIT^A1VSLP S VALMQUIT=""
 QUIT
 ;
HELP ; -- help code
 SET X="?" D DISP^XQORM1
 ;SET VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 DO KILL
 Q
 ;
EXPND ; -- expand code
 Q
 ;
REFRESH ; -- refresh display
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
MSG(TEXT) ; -- set default message
 QUIT
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 DO CLNTMPGB
 KILL ^TMP("A1VS PKG MAN PARM DISP",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
 ;APIs ;TO DO: GTS - Further develop these APIs so LINEITEM is the most current/edited package parameter data
LOADTMP(LINEITEM) ;Store LineItem into ^TMP global
 ;Input : LINEITEM - A single Package lineitem from XTMPSIZE.DAT
 ;
 ;Output: ^TMP array in the following form:
 ;  ^TMP("{package name}","{primary prefix}")=LINEITEM [Package line from XTMPSIZE.DAT]
 ;  ^TMP("{package name}","{primary prefix}","ADDPFX","{added prefix}")=""
 ;  ^TMP("{package name}","{primary prefix}","BEGINFILE")=file number [Start file #]
 ;  ^TMP("{package name}","{primary prefix}","ENDFILE")=file number [Ending file #]
 ;  ^TMP("{package name}","{primary prefix}","FNUM",{file#})="" [File # from FILE NUMBER multiple]
 ;  ^TMP("{package name}","{primary prefix}","FLERNG","{file range 1}")="" [File # range from LOW-HIGH RANGE multiple]
 ;  ^TMP("{package name}","{primary prefix}","PARENT")=Package [PARENT PACKAGE field]
 ;  ^TMP("{package name}","{primary prefix}","REMPFX","{removed prefix}")=""
 ;
 ;IF +$G(CLEANONE)'>0 SET CLEANONE=0
 SET PKGNAME=$P(LINEITEM,"^")
 SET PKGPFX=$P(LINEITEM,"^",2)
 ;
 ;Load package components into ^TMP Global (loop)
 SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX)=LINEITEM ;Define Data node
 ;
 ;Define File Range array nodes
 SET FILELIST=$P(LINEITEM,"^",8)
 SET PCENUM=0
 IF FILELIST'="" DO
 . FOR  SET PCENUM=PCENUM+1 SET FLERNG=$P(FILELIST,"|",PCENUM) QUIT:FLERNG']""  DO
 .. SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"FLERNG",FLERNG)=""
 .. DO FILNDX(FLERNG,PKGNAME) ;Set ^TMP("A1VS-FRIDX",$J,<begin file #>,<end file #>,<package name>)=""
 IF FILELIST="" DO 
 . NEW BEG,END
 . SET BEG=$P(LINEITEM,"^",3)
 . SET END=$P(LINEITEM,"^",4)
 . IF BEG]"",END]"" DO FILNDX(BEG_"-"_END,PKGNAME) ;Set ^TMP("A1VS-FRIDX",$J,<begin file #>,<end file #>,<package name>)=""
 ;
 ;Define Start/End File number array nodes
 SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"BEGFILE")=$P(LINEITEM,"^",3)
 SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"ENDFILE")=$P(LINEITEM,"^",4)
 ;
 ;Define File Number array nodes
 SET FILELIST=$P(LINEITEM,"^",7)
 SET PCENUM=0
 FOR  SET PCENUM=PCENUM+1 SET FNUM=$P(FILELIST,"|",PCENUM) QUIT:FNUM']""  DO
 . SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"FNUM",FNUM)=""
 ;
 ;Define Additional & Excepted Prefix Array nodes
 SET APFXLST=$P(LINEITEM,"^",5)
 SET RPFXLST=$P(LINEITEM,"^",6)
 SET PCENUM=0
 FOR  SET PCENUM=PCENUM+1 SET APFX=($P(APFXLST,"|",PCENUM)) QUIT:APFX']""  DO
 . SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"ADDPFX",APFX)="" ;Additional Namespace
 . DO PFXIDX(APFX,PKGNAME,APFXLST_"^"_RPFXLST) ;Set ^TMP("A1VS-PFXIDX",$J,,<namespace prefix>,<package name>)=""
 DO:PKGPFX]"" PFXIDX(PKGPFX,PKGNAME,APFXLST_"^"_RPFXLST) ;Set ^TMP("A1VS-PFXIDX",$J,<namespace prefix>,<package name>)="" [Primary Prefix]
 ;
 SET PCENUM=0
 FOR  SET PCENUM=PCENUM+1 SET RPFX=($P(RPFXLST,"|",PCENUM)) QUIT:RPFX']""  DO
 . SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"REMPFX",RPFX)="" ;Excepted Namespace
 ;
 ;Define Parent array node
 SET ^TMP("A1VS-PKGEDIT",$J,PKGNAME,PKGPFX,"PARENT")=$P(LINEITEM,"^",9)
 ;
 QUIT
 ;
 ;
 ;"A1VS-FRIDX" USAGE NOTE: Extract file range subscript from "FLERNG" nodes one-by-one
 ; Retrieve Begin/End Range values from "FLERNG"
 ; @QSUBSCRIPT "FRIDX" nodes retrieving Begin File #
 ; if RNGEND < "FLERNG" node begin...QUIT check
 ; if RNGBEG > "FLERNG" node end...QUIT check
 ;
 ; If RNGBEG '< "FLERNG" begin node, check for package name
 ;  if not package name, create a File overlap error node indicating "FLERNG" package, overlapping files and RNG package
 ; If RNGEND '> "FLERNG" end node, check for package name
 ;  if not package name, create a File overlap error node indicating "FLERNG" package, overlapping files and RNG package
 ;
FILNDX(FLRNGE,PKGNAME) ; Set File Number Index [^TMP("A1VS-FRIDX",$J)]
 ;Input: FLRNGE  - File Range
 ;       PKGNAME - Package name
 ;
 ;Output : File Range Node [^TMP("A1VS-FRIDX",$J,<begin file #>,<end file #>,<package name>)=""]
 ;
 NEW BEGFNUM,ENDFNUM
 SET BEGFNUM=$P(FLRNGE,"-")
 SET ENDFNUM=$P(FLRNGE,"-",2)
 SET ^TMP("A1VS-FRIDX",$J,BEGFNUM,ENDFNUM,PKGNAME)=""
 QUIT
 ;
 ;
 ;"A1VS-PFXIDX" USAGE NOTE: Loop ^TMP("A1VS-PKGEDIT",$J,<pkg name>,<prefix>)
 ; Place <prefix> in a local prefix array
 ; Extract Primary Prefix (4th subscript) and added Prefixes from "ADDPFX" (6th subscript) one-by-one and pass to CHKPRX
 ; Loop ^TMP("A1VS-PFXIDX",$J,<prefix>,<package name>)
 ; If <package name> in Array subscript doesn't equal "package name"...
 ;   create a File overlap error node indicating "ADDPFX" package, overlapping prefix and "PFXIDX" package
 ;
PFXIDX(PKGPFX,PKGNAME,PFXLST) ;Set ^TMP("A1VS-PKGEDIT",$J,"PFXIDX",<namespace prefix>,<package name>)=""
 SET PFXLST=$G(PFXLST)
 SET ^TMP("A1VS-PFXIDX",$J,PKGPFX,PKGNAME)=PFXLST
 QUIT
 ;
SCAPARY(LINEITEM,CAPNODE) ; Set single line Array & caption display array for action processing
 NEW PARMDAT,PKG
 SET CAPNODE=CAPNODE+1
 ;SET ^TMP("A1VS-PARAM-LINE",$J,CAPNODE)=LINEITEM ; Set Parameter LineItem array
 ;
 ;Set Caption Display Array
 SET PKG=$P(LINEITEM,"^")
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG)=LINEITEM
 SET PARMDAT=$P(LINEITEM,"^")
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,1,"Package Name")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",2)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,2,"Primary Prefix")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",3)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,3,"*Lowest File#")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",4)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,4,"*Highest File#")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",5)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,5,"Additional Prefixes")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",6)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,6,"Excepted Prefixes")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",7)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,7,"File Numbers")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",8)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,8,"File Ranges")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",9)
 SET ^TMP("A1VS-PARAM-CAP",$J,PKG,9,"Parent Package")=PARMDAT
 QUIT
 ;
CLNTMPGB ;Kill temporary globals
 KILL ^TMP("A1VS-PKGEDIT",$J),^TMP("A1VS-ERROR",$J),^TMP("A1VS-FRIDX",$J),^TMP("A1VS-PFXIDX",$J)
 KILL ^TMP("A1VS-PARAM-CAP",$J) ;,^TMP("A1VS-PARAM-LINE",$J)
 QUIT
 ;
PRMFLIST() ;List parameter files for selection
 NEW DEFDIR,FILENME,FILELIST,LSTRSLT,SELARY,ITEMNUM
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET FILENME("XTMPSIZE*")=""
 SET LSTRSLT=$$LIST^%ZISH(DEFDIR,"FILENME","FILELIST")
 IF LSTRSLT DO
 .; Move XTMPSIZE files to SELARY
 .SET ITEMNUM=0
 .SET FILENME=""
 .FOR  SET FILENME=$O(FILELIST(FILENME)) Q:FILENME=""  SET ITEMNUM=ITEMNUM+1 SET SELARY(ITEMNUM)=FILENME
 .;
 .IF ITEMNUM>1 DO 
 .. DO LISTOUT^A1VSLAPI(.SELARY) ;List Parameter files for selection
 .. SET XVAL=+$$SELPKG(ITEMNUM,.SELARY)
 .. ;
 ..IF (+$G(XVAL)>0)&(+$G(XVAL)<(ITEMNUM+1)) SET FILENME=SELARY(XVAL) W "   ",FILENME
 ;
 IF ITEMNUM'>1 DO JUSTPAWS^A1VSLAPI(" There are no XTMPSIZE files for comparison!")
 QUIT FILENME
 ;
SELPKG(ITEMNUM,SELARY) ; Select Package to Edit from ^TMP("A1VS PKG MGR PARAM CAP",$J)
 ; INPUT: SELARY  - Array of packages
 ;        ITEMNUM - Number of items in SELARY
 ;
 ; OUTPUT: PKGNME - Name of selected package
 ;       
 NEW DIR,DIRUT,DTOUT,DUOUT,X,Y ;,PKGNME
 ;SET PKGNME=""
 SET DIR("A")="Select File: "
 SET DIR(0)="NAO^1:"_ITEMNUM_"^K:(X'?.N) X"
 ;SET DIR("PRE")="K:'$D(SELARY("_+$G(X)_")) X"
 SET DIR("?",1)=" Select item # for the desired parameter file from the list."
 SET DIR("?")="   [Enter'^' to exit]"
 SET DIR("??")="^DO LISTOUT^A1VSLAPI(.SELARY)"
 DO ^DIR
 ;IF $P(X,"^",1)="+1" SET LASTSPKG=X
 ;;IF '$D(DIRUT) SET PKGNME=SELARY(Y)
 QUIT Y
 ;
 ;
PARMMAP ; Map of Parameter data elements
 ; 
 ;Parameter List data map from Package file:
 ;------------------------------------------
 ; ^ pce 1 : Package Name
 ;              [Source: NAME (#.01)]
 ; ^ pce 2 : Primary Prefix
 ;              [Source: PREFIX (#1)]
 ; ^ pce 3 : *Lowest File #
 ;              [Source: *LOWEST FILE NUMBER (#10.6)]
 ; ^ pce 4 : *Highest File #
 ;              [Source: *HIGHEST FILE NUMBER (#11)]
 ; ^ pce 5 : Pipe character (|) delimited list of Additional Prefixes
 ;              [Source: ADDITIONAL PREFIXES multiple (#14)]
 ; ^ pce 6 : Pipe character (|) delimited list of Excepted Prefixes
 ;              [Source: EXCLUDED NAME SPACE multiple (#919)]
 ; ^ pce 7 : Pipe character (|) delimited list of File entries
 ;              [Source: FILE NUMBER multiple (#15001)]
 ; ^ pce 8 : Pipe character (|) delimited list of File Range entries 
 ;              [Source: LOW-HIGH RANGE multiple (#15001.1)]
 ; ^ pce 9 : Parent Package
 ;              [Source: PARENT PACKAGE field (#15003)]
 ; 
 ;$END
 ;
 ;PROTOCOL entry points
 ;
PKGERR ; -- Package Parameter Errors
 ; -- Protocol: A1VS PKG MGR PARAM ERR DISP ACTION 
 DO EN^A1VSLPER
 DO REFRESH
 DO MSG
 QUIT
 ;
PARAMRPT ; -- Package Parameter Caption list
 ; -- Protocol: A1VS PKG MGR PARAM DISP CAPTION ACTION
 DO EN^A1VSLPDC
 DO REFRESH
 DO MSG
 QUIT
 ;
PARAMAP ; -- Display Data Map for Parameter File
 ; -- Protocol: A1VS PKG MGR PARAM DATA MAP HELP ACTION
 NEW HLPTEXT,LNENUM
 DO FULL^VALM1
 FOR LNENUM=1:1 SET HLPTEXT=$P($TEXT(PARMMAP+LNENUM),";",2) Q:HLPTEXT="$END"  W !,HLPTEXT
 DO JUSTPAWS^A1VSLAPI
 ;
 DO REFRESH
 DO MSG
 QUIT
 ;
PARAMCMP ; -- Package Parameter Comparison report
 ; -- Protocol: A1VS PKG MGR PARAM COMPARE ACTION
 NEW CMPRFNME
 DO FULL^VALM1
 SET CMPRFNME=$$PRMFLIST^A1VSLP() ;Select a File to compare
 IF CMPRFNME["XTMPSIZE" DO
 . DO EN^A1VSLPC(CMPRFNME)
 IF CMPRFNME'["XTMPSIZE" DO JUSTPAWS^A1VSLAPI("Comparison XTMPSIZE.DAT file NOT selected!")
 DO REFRESH
 DO MSG
 QUIT

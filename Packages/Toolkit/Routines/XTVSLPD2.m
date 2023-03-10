XTVSLPD2 ;Albany FO/GTS - VistA Package Sizing Manager - Caption display APIs; 14-DEC-2018
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
 ;APIs 2
PRIMPFX(XTA,XTB,XTJUMPIN) ; Enter/Edit Primary Prefix
 IF $G(XTJUMPIN) NEW DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 NEW ADDPKG
 ;Package Added Indicator = 1 when Primary Primary Prefix XTVS-PARAM-CAP ^TMP global node is Null
 SET ADDPKG=((^TMP("XTVS-PARAM-CAP",$J,PKGNME,DATANUM,"Primary Prefix")=""))
 SET DIR("A")=XTA
 SET:XTB]"" DIR("B")=XTB
 SET DIR("?",1)="Enter Package Prefix from 2 to 4 characters."
 SET DIR("?",2)=" (1 upper case letter followed by 1 - 3 upper case letters or numbers.)"
 SET DIR("?",3)=" "
 SET DIR("?",4)="Prefixes are used to identify Routines, Options, Protocols, etc. for the"
 SET DIR("?")=" VistA Package Size report."
 SET DIR(0)="FA^2:4^K:$L(X)>4!(X'?1U1.3NU) X"
 DO ^DIR
 IF ('$D(DTOUT)&('$D(DUOUT))) DO
 . IF ($D(DIRUT)) DO UPDTNODE(DIRUT,EDITARY,DATANUM,DATANAME,X)
 . IF '$D(DIRUT),(@EDITARY@(DATANUM,DATANAME)'=X) SET @EDITARY@(DATANUM,DATANAME)=Y
 . KILL DIRUT
 IF ($D(DTOUT)!$D(DUOUT)!$D(DIROUT))&((ADDPKG)&(X="^")) DO
 . KILL ^TMP("XTVS-PARAM-CAP",$J,PKGNME)
 . DO HDR^XTVSLPDC,INIT^XTVSLPDC
 . SET DATANUM=999 ;Do not prompt other fields
 IF $D(DUOUT),(X["^"),($L(X)>1) DO
 . IF ADDPKG DO
 .. DO JUSTPAWS^XTVSLAPI(" Data Entry '^' JUMP not allowed before Primary Prefix is defined.")
 .. W !
 .. SET DATANUM=1
 .. KILL DUOUT
 . IF 'ADDPKG DO JUMP(X,DATANUM) SET DATANUM=DATANUM-1
 QUIT
 ;
HILOFLE(XTA,XTB,XTJUMPIN) ; Enter/Edit High or Low File Number
 IF $G(XTJUMPIN) NEW DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 SET DIR("A")=XTA
 SET:XTB]"" DIR("B")=XTB
 SET DIR("?",1)=" Enter File Number 0 - 999999999, decimals are allowed."
 SET DIR("?",2)=" "
 SET DIR("?",3)=" When File Ranges are undefined and *Lowest File# & *Highest File# are"
 SET DIR("?",4)="  defined, *Lowest File# - *Highest File# range is used to identify files"
 SET DIR("?")="  assigned to the package for the VistA Package Size report."
 SET DIR(0)="NOA^0:999999999:6"
 DO ^DIR
 IF ('$D(DTOUT)&('$D(DUOUT))) DO
 . IF ($D(DIRUT)) DO UPDTNODE(DIRUT,EDITARY,DATANUM,DATANAME,X)
 . IF '$D(DIRUT),(@EDITARY@(DATANUM,DATANAME)'=X) SET @EDITARY@(DATANUM,DATANAME)=Y
 . KILL DIRUT
 IF $D(DUOUT),(X["^") DO JUMP(X,DATANUM) SET DATANUM=DATANUM-1
 QUIT
 ;
EXADPFX(XTA,XTB,XTJUMPIN) ; Enter/Edit Excepted or Additional Prefixes
 NEW LISTDATA
 IF $G(XTJUMPIN) NEW DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 SET DIR("A")=XTA
 SET:XTB]"" DIR("B")=XTB
 SET GETOUT=0
 FOR  QUIT:GETOUT  DO  ;Edit Prefix List Loop
 . SET LISTDATA=@EDITARY@(DATANUM,DATANAME)
 . DO SPLITOUT(DATANAME,LISTDATA) ;Display Listed data to screen for user
 . SET PPRMT="Enter "_$S(DATANUM=5:"Additional",1:"Excepted")_" Prefix: "
 . SET DIR("A")=PPRMT  ;RESET DIR("A") default prompt
 . KILL DIR("B") ;No default, select from list
 . SET DIR("?",1)="Enter a new Prefix or one from list. [Note: Entry is case sensitive.]"
 . SET DIR("?",2)="Order of Prefixes listed is not significant."
 . SET DIR("?",3)=" "
 . SET DIR("?",4)="Additional and Excepted Prefixes are used to identify Routines, Options,"
 . SET DIR("?",5)=" Protocols, etc. for the VistA Package Size reporting tool.  Additional"
 . SET DIR("?",6)=" Prefixes include components [that begin with the prefix] in the tally"
 . SET DIR("?",7)=" totals for the component.  Excepted Prefixes are refinements to the"
 . SET DIR("?",8)=" Primary and Additional Prefixes to exclude subsets of component names"
 . SET DIR("?")=" [that begin with the Excepted Prefixes] from the tally totals."
 . SET DIR(0)="FAO^2:6^K:(X'?1U1.5NU) X"
 . DO ^DIR
 . IF (Y=-1)!(Y="")!(Y="@")!($D(DTOUT))!($D(DUOUT)) SET GETOUT=1
 . SET UPDATLST=0
 . IF 'GETOUT DO EDITPRFX(Y,.LISTDATA,.UPDATLST)
 . IF GETOUT,$D(DUOUT),(X["^") DO JUMP(X,DATANUM) SET DATANUM=DATANUM-1
 . IF UPDATLST SET @EDITARY@(DATANUM,DATANAME)=LISTDATA
 QUIT
 ;
EDITPRFX(DATELEMT,LISTDATA,UPDATLST) ; Update Prefix list
 NEW DIR,DIRUT,DTOUT,DUOUT,X,Y,EDTELEMT,PCE
 SET PCE=0
 IF (LISTDATA["|"_DATELEMT_"|")!($P(LISTDATA,"|")=DATELEMT) SET PCE=$$PCEPOS(LISTDATA,DATELEMT)
 SET DIR("A")=" Prefix: "
 SET DIR("B")=DATELEMT
 SET DIR("?")=" Enter/Edit a Prefix."
 SET DIR(0)="FAO^2:6^K:(X'?1U1.5NU) X"
 DO ^DIR
 IF '$D(DTOUT)&'$D(DUOUT)&'$D(DIROUT) DO LSTEDT(X,PCE,DATELEMT,.LISTDATA,.UPDATLST)
 QUIT
 ;
LSTEDT(EDTELEMT,PCE,DATELEMT,LISTDATA,UPDATLST) ;Edit List dialog
 IF (PCE>0),(EDTELEMT'="@") SET $P(LISTDATA,"|",PCE)=EDTELEMT SET UPDATLST=1 ;EDIT ENTRY
 IF (PCE>0),(EDTELEMT="@") DO
 . IF +$$YNCHK^XTVSLAPI("DELETE ENTRY") SET LISTDATA=$P(LISTDATA,DATELEMT_"|",1)_$P(LISTDATA,DATELEMT_"|",2) SET UPDATLST=1
 IF PCE'>0 DO
 . IF EDTELEMT="@" W !,"?? ...Element not in list, cannot delete!" SET EDTELEMT=DATELEMT
 . IF +$$YNCHK^XTVSLAPI("ADD ENTRY") SET LISTDATA=LISTDATA_EDTELEMT_"|" SET UPDATLST=1
 QUIT
 ;
FLENUM(XTA,XTB,XTJUMPIN) ; Enter/Edit File number
 NEW LISTDATA
 IF $G(XTJUMPIN) NEW DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 SET DIR("A")=XTA
 SET:XTB]"" DIR("B")=XTB
 SET GETOUT=0
 FOR  QUIT:GETOUT  DO  ;Edit Prefix List Loop
 . SET LISTDATA=@EDITARY@(DATANUM,DATANAME)
 . DO SPLITOUT(DATANAME,LISTDATA) ;Display Listed data to screen for user
 . SET DIR("A")="Enter File Number: " ;RESET DIR("A") default prompt
 . KILL DIR("B") ;No default, select from list
 . SET DIR("?",1)="Enter a new File Number or one from the list."
 . SET DIR("?",2)="New file numbers only between 1.9999 and 99999999.999999"
 . SET DIR("?",3)="Order of File Numbers listed is not significant."
 . SET DIR("?",4)=" "
 . SET DIR("?",5)="When File Ranges and *Lowest File# & *Highest File# are undefined and"
 . SET DIR("?",6)=" File Numbers exist, File Numbers are used to identify files assigned"
 . SET DIR("?")=" to the package for the VistA Package Size report."
 . SET DIR(0)="NAO^1.9999:99999999.999999:6"
 . DO ^DIR
 . IF (Y=-1)!(Y="")!(Y="@")!($D(DTOUT))!($D(DUOUT)) SET GETOUT=1
 . SET UPDATLST=0
 . IF 'GETOUT DO EDITFNUM(Y,.LISTDATA,.UPDATLST)
 . IF GETOUT,$D(DUOUT),(X["^") DO JUMP(X,DATANUM) SET DATANUM=DATANUM-1
 . IF UPDATLST SET @EDITARY@(DATANUM,DATANAME)=LISTDATA
 QUIT
 ;
EDITFNUM(DATELEMT,LISTDATA,UPDATLST) ; Update File list
 NEW DIR,DIRUT,DTOUT,DUOUT,EDTELEMT,PCE
 SET PCE=0
 IF (LISTDATA["|"_DATELEMT_"|")!($P(LISTDATA,"|")=DATELEMT) SET PCE=$$PCEPOS(LISTDATA,DATELEMT)
 SET DIR("A")=" File Number: "
 SET DIR("B")=DATELEMT
 SET DIR("?")=" Enter/Edit a File Number."
 SET DIR(0)="NAO^1.9999:99999999.999999:6"
 DO ^DIR
 IF '$D(DTOUT)&'$D(DUOUT)&'$D(DIROUT) DO LSTEDT(X,PCE,DATELEMT,.LISTDATA,.UPDATLST)
 QUIT
 ;
FLERNG(XTA,XTB,XTJUMPIN) ; Enter/Edit File Range
 NEW LISTDATA
 IF $G(XTJUMPIN) NEW DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 SET DIR("A")=XTA
 SET:XTB]"" DIR("B")=XTB
 SET GETOUT=0
 FOR  QUIT:GETOUT  DO  ;Edit Prefix List Loop
 . SET LISTDATA=@EDITARY@(DATANUM,DATANAME)
 . DO SPLITOUT(DATANAME,LISTDATA) ;Display Listed data to screen for user
 . SET DIR("A")="Enter File Number Range: "  ;RESET DIR("A") default prompt
 . KILL DIR("B") ;No default, select from list
 . SET DIR("?",1)="Enter a new File Number Range or one from the list."
 . SET DIR("?",2)="New file number ranges only between 1.9999 and 99999999.999999"
 . SET DIR("?",3)="Order of File Ranges listed is not significant."
 . SET DIR("?",4)="Example of a file range would be 500-501.9 with no spaces."
 . SET DIR("?",5)=" "
 . SET DIR("?",6)="If File Ranges are defined, they are used to identify files assigned to"
 . SET DIR("?",7)="  the package whether or not *Lowest File# & *Highest File# or File"
 . SET DIR("?")="  Numbers are defined."
 . SET DIR(0)="FAO^3:31^K:$$BADRNG^XTVSLPD1(X) X"
 . DO ^DIR
 . IF (Y=-1)!(Y="")!(Y="@")!($D(DTOUT))!($D(DUOUT)) SET GETOUT=1
 . SET UPDATLST=0
 . IF 'GETOUT DO EDITFRNG(Y,.LISTDATA,.UPDATLST)
 . IF GETOUT,$D(DUOUT),(X["^") DO JUMP(X,DATANUM) SET DATANUM=DATANUM-1
 . IF UPDATLST SET @EDITARY@(DATANUM,DATANAME)=LISTDATA
 QUIT
 ;
EDITFRNG(DATELEMT,LISTDATA,UPDATLST) ; Update File Range
 NEW DIR,DIRUT,DTOUT,DUOUT,EDTELEMT,PCE
 SET PCE=0
 IF (LISTDATA["|"_DATELEMT_"|")!($P(LISTDATA,"|")=DATELEMT) SET PCE=$$PCEPOS(LISTDATA,DATELEMT)
 SET DIR("A")=" File Number Range: "
 SET DIR("B")=DATELEMT
 SET DIR("?",1)=" Enter a new File Number Range or one from the list."
 SET DIR("?")="New file number ranges only between 1.9999 and 99999999.999999"
 SET DIR(0)="FAO^3:31^K:$$BADRNG^XTVSLPD1(X) X"
 DO ^DIR
 IF '$D(DTOUT)&'$D(DUOUT)&'$D(DIROUT) DO LSTEDT(X,PCE,DATELEMT,.LISTDATA,.UPDATLST)
 QUIT
 ;
PRNTPKG(XTA,XTB,XTJUMPIN) ; Enter/edit parent Package
 IF $G(XTJUMPIN) NEW DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 SET DIR("A")=XTA
 SET:XTB]"" DIR("B")=XTB
 SET DIR("A",1)=" "
 SET DIR("PRE")="DO:(X'=""@""&(X'[""^"")) CHKX^XTVSLPDC(0)" ;Check X for existing package
 SET DIR("?")="^DO PKGHLP^XTVSLPDC(1)"
 SET DIR(0)="FAOr^4:40^K:('(X'?1P.E)) X"
 DO ^DIR
 IF ('$D(DTOUT)&('$D(DUOUT))) DO
 . IF ($D(DIRUT)) DO UPDTNODE(DIRUT,EDITARY,DATANUM,DATANAME,X)
 . IF '$D(DIRUT),(@EDITARY@(DATANUM,DATANAME)'=X) SET @EDITARY@(DATANUM,DATANAME)=Y
 IF $D(DUOUT),(X["^") DO JUMP(X,DATANUM) SET DATANUM=DATANUM-1
 QUIT
 ;
JUMP(XVAL,XTOLDNUM) ; Jump to a data element during edit
 NEW DTELMT,CT,SUBRTN,XTDONE,DATANAME,DIR,DATANUM,XTFOUND
 SET (XTFOUND,XTDONE)=0
 IF (XVAL?1"^"0.1"*"1.A0.1" "1.A0.1"#"),(XVAL'="^") DO
 . SET XVAL=$$UP^XLFSTR($P(XVAL,"^",2))
 . IF (XTOLDNUM'=7),(XTOLDNUM'=8),($$CKMATCH(XVAL,"FILE ")) S DTELMT=$$FLESEL() DO:DTELMT]"" JUMPEXC SET XTDONE=1
 . FOR CT=2:1 SET DTELMT=$TEXT(DATANAME+CT) QUIT:$P(DTELMT," ;;",2)="QUIT"  QUIT:XTDONE  DO
 .. IF ($P($P(DTELMT," ;;",2),"^")[XVAL),($$CKMATCH(XVAL,$P($P(DTELMT," ;;",2),"^"))),($P($P(DTELMT," ;;",2),"^",2)'=XTOLDNUM) DO
 ... DO JUMPEXC
 ... SET XTDONE=1
 . IF 'XTFOUND W "   ??" KILL DUOUT,X
 . IF XTFOUND W !,"   Return to "_$P($P($TEXT(DATANAME+XTOLDNUM)," ;;",2),"^",1)_"..."
 QUIT
 ;
JUMPEXC ;Jump to selected field [from JUMP api]
 SET XTFOUND=1
 SET DATANUM=$P($P(DTELMT," ;;",2),"^",2)
 SET DATANAME=$O(@EDITARY@(DATANUM,""))
 SET DIR("A")=DATANAME_": " ;Set DIR("A") prompt
 SET DIR("B")=$G(@EDITARY@(DATANUM,DATANAME)) ;Set Prompt for DIR read
 DO @$P($P(DTELMT," ;;",2),"^",3)
 KILL DUOUT
 QUIT
 ;
CKMATCH(XTIN,XTDATNM) ; Check for sub-string match to data element name
 NEW RESULT
 SET RESULT=(XTIN=$E(XTDATNM,1,$L(XTIN)))
 QUIT RESULT
 ;
FLESEL() ; Select FILE data element for JUMP
 NEW RESULT,DIR,X,Y,DUOUT,DIROUT,DTOUT,DIRUT
 SET RESULT=""
 SET DIR("A")="    Data Element Number: "
 SET DIR("?")=" Enter number 1 or 2."
 SET DIR("A",1)=" "
 SET DIR("A",2)="    Select Data Element:"
 SET DIR("A",3)="      1) File Numbers"
 SET DIR("A",4)="      2) File Ranges"
 ;SET DIR("A",5)=" "
 SET DIR(0)="NA^1:2"
 DO ^DIR
 IF '$D(DIRUT) SET RESULT=$TEXT(DATANAME+(6+Y))
 QUIT RESULT
 ;
UPDTNODE(UPDIRUT,EDITARY,DATANUM,DATANAME,UPDX) ;Update ^TMP("XTVS-PARAM-CAP") array node with edits
 IF ('$D(UPDIRUT)) SET @EDITARY@(DATANUM,DATANAME)=UPDX
 IF $D(UPDIRUT) DO
 . IF (UPDX="@"),(@EDITARY@(DATANUM,DATANAME)'="") DO
 .. IF +$$YNCHK^XTVSLAPI("DELETE ENTRY") SET @EDITARY@(DATANUM,DATANAME)=""
 . IF (UPDX'="@"),(@EDITARY@(DATANUM,DATANAME)'=UPDX) SET @EDITARY@(DATANUM,DATANAME)=UPDX
 QUIT
 ;
SPLITOUT(DATANAME,LISTDATA) ; -- Split list data to separate lines as needed and output
 ; DATANAME  - Data element name
 ; LISTDATA  - Data element list
 ;
 NEW LINE,PCENUM,LISTPCE,NXSTPCE
 WRITE !!!,DATANAME_":"
 IF LISTDATA']"" W !,"{no data list}"
 IF LISTDATA]"" DO
 . IF $L(LISTDATA)'>79 W !,LISTDATA
 . IF $L(LISTDATA)>79 DO
 .. SET LINE=""
 .. SET NXSTPCE=1
 .. FOR PCENUM=1:1 SET LISTPCE=$P(LISTDATA,"|",PCENUM)  Q:LISTPCE=""  DO
 ... IF $L($P(LISTDATA,"|",NXSTPCE,PCENUM))>79 W !,$P(LISTDATA,"|",NXSTPCE,PCENUM-1) SET NXSTPCE=PCENUM
 .. W !,$P(LISTDATA,"|",NXSTPCE,999)
 WRITE !
 QUIT
 ;
PCEPOS(LISTDATA,DATELEMT) ; Return the piece position number of DATELEMT in LISTDATA
 NEW PCE,DELIMPOS,ITEM
 FOR PCE=1:1 SET ITEM=$P(LISTDATA,"|",PCE) Q:ITEM=DATELEMT  IF ITEM="" SET PCE=0 QUIT
 QUIT PCE
 ;
DATANAME ; Package Parameter data element names
 ;;PACKAGE NAME^1^PKGNME(DIR("A"),DIR("B"),1);;<place holder if Package name becomes editable>
 ;;PRIMARY PREFIX^2^PRIMPFX(DIR("A"),DIR("B"),1)
 ;;*LOWEST FILE#^3^HILOFLE(DIR("A"),DIR("B"),1)
 ;;*HIGHEST FILE#^4^HILOFLE(DIR("A"),DIR("B"),1)
 ;;ADDITIONAL PREFIXES^5^EXADPFX(DIR("A"),DIR("B"),1)
 ;;EXCEPTED PREFIXES^6^EXADPFX(DIR("A"),DIR("B"),1)
 ;;FILE NUMBERS^7^FLENUM(DIR("A"),DIR("B"),1)
 ;;FILE RANGES^8^FLERNG(DIR("A"),DIR("B"),1)
 ;;PARENT PACKAGE^9^PRNTPKG(DIR("A"),DIR("B"),1)
 ;;QUIT

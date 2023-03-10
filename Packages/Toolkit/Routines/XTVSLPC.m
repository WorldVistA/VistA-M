XTVSLPC ;Albany FO/GTS - VistA Package Sizing Manager; 17-NOV-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
EN(CMPRFNME) ; -- main entry point for XTVS PKG MGR PARAM COMPARE
 ; Input: CMPRFNME - File to compare Selected XTMPSIZE.DAT file
 ;
 IF CMPRFNME'["XTMPSIZE" DO  QUIT
 . DO JUSTPAWS^XTVSLAPI("Comparison XTMPSIZE.DAT file NOT selected!")
 ;
 D EN^VALM("XTVS PKG MGR PARAM COMPARE")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Parameter Compare"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Selected file [SEL]: "_XTVPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 SET DIRHEAD="Comparison file [CPR]: "_CMPRFNME
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(5)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; - Build Selected and Comparison XTMPSIZE parameter arrays
 NEW DEFDIR,NODENUM,NODECUR,CURNDNM,CPRNDNM,PKGRPTD,PKGDEL,DELSTATE
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 ;
 ;Build Selected XTMPSIZE parameter array
 DO OPEN^%ZISH("XTMP",DEFDIR,XTVPSPRM,"R")
 U IO
 SET NODENUM=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO
 .. SET NODENUM=NODENUM+1
 .. SET ^TMP("XTVS CUR PARAM",$JOB,NODENUM)=LINEITEM ;Creates ^TMP("XTVS CUR PARAM",$JOB) array
 D CLOSE^%ZISH("XTMP")
 ;
 ;Build comparison XTMPSIZE parameter array
 DO OPEN^%ZISH("XTMP2",DEFDIR,CMPRFNME,"R")
 U IO
 SET NODENUM=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO
 .. SET NODENUM=NODENUM+1
 .. SET ^TMP("XTVS CPR PARAM",$JOB,NODENUM)=LINEITEM ;Creates ^TMP("XTVS CPR PARAM",$JOB) array
 D CLOSE^%ZISH("XTMP2")
 ;
 ;Create ^TMP("XTVS PKG MAN PARM COMPARE",$JOB) comparison result array for ListMan display
 SET (PKGRPTD,VALMCNT)=0
 ;
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"CHANGED PACKAGES",1,1,16) ;Output Header for Changed Package list
 ;Loop through each "Selected" (latest) Package Lineitem
 SET CURNDNM=0
 FOR  SET CURNDNM=$O(^TMP("XTVS CUR PARAM",$JOB,CURNDNM)) QUIT:CURNDNM=""  SET NODECUR=^TMP("XTVS CUR PARAM",$JOB,CURNDNM) DO
 . SET DELSTATE=0
 . IF NODECUR=$G(^TMP("XTVS CPR PARAM",$JOB,CURNDNM)) DO DELPKG(CURNDNM,CURNDNM) SET DELSTATE=1 ;;Remove unedited package from CPR & CUR globals
 . IF (NODECUR'=$G(^TMP("XTVS CPR PARAM",$JOB,CURNDNM))),('DELSTATE) DO  ;;If Selected Package '= same node on Compare Package lineitem
 .. SET (PKGDEL,CPRNDNM)=0
 .. FOR  SET CPRNDNM=$O(^TMP("XTVS CPR PARAM",$JOB,CPRNDNM)) QUIT:CPRNDNM=""  QUIT:PKGDEL  DO COMPARE(CPRNDNM,NODECUR,.VALMCNT,.PKGDEL,.PKGRPTD)
 IF PKGRPTD=0 DO
 . DO ADD^XTVSLAPI(.VALMCNT," No edited packages!")
 ;
 DO ADDDELRP("CUR",.VALMCNT) ;Report packages added new to Selected package extract
 DO ADDDELRP("CPR",.VALMCNT) ;Report packages deleted from Selected package extract
 SET PKGRPTD=0
 D MSG
 ;
 QUIT
 ;
COMPARE(CPRNDNM,NODECUR,VALMCNT,PKGDEL,PKGRPTD) ; Compare Selected & Comparison parameter files, report diff's and cleanup ^TMP globals
 NEW NODECPR,CURPKG,CPRPKG,FNDCHG,CPRPCS,CURPCS
 SET CURPKG=$P(NODECUR,"^")
 SET NODECPR=^TMP("XTVS CPR PARAM",$JOB,CPRNDNM)
 SET CPRPKG=$P(NODECPR,"^")
 ;
 ; Set CPRPCS and CURPCS to compare Selected Parameter file to Comparison Parameter file
 ;  (pce 10 = * on CPR parameter files indicated circular Parent/Child relationship)
 SET CPRPCS=$L(NODECPR,"^")
 SET CURPCS=$L(NODECUR,"^")
 IF $P(NODECPR,"^",CPRPCS)="*" SET CPRPCS=CPRPCS-1
 IF $P(NODECUR,"^",CURPCS)="*" SET CURPCS=CURPCS-1
 ;
 IF ($P(NODECUR,"^",1,CURPCS)=$P(NODECPR,"^",1,CPRPCS)) DO DELPKG(CURNDNM,CPRNDNM) SET PKGDEL=1 ;Remove unedited Pkg from TMP globals, set PKGDEL to QUIT CPR loop
 IF ($P(NODECUR,"^",1,CURPCS)'=$P(NODECPR,"^",1,CPRPCS)),(CPRPKG=CURPKG) DO
 . SET FNDCHG=$$CHNGCHK(NODECUR,NODECPR,.VALMCNT) ;NOTE: FNDCHG not used
 . DO DELPKG(CURNDNM,CPRNDNM) ;Remove edited Pkg from globals
 . SET PKGRPTD=1 ;PKGRPTD prevents 'No edited packages' msg
 . SET PKGDEL=1 ; Quit CPR Node loop
 QUIT
 ;
CHNGCHK(NODECUR,NODECPR,VALMCNT) ; Check selected parameter file (SEL) against a comparison parameter file (CPR)
 NEW FNDCHNG,PKGHDRPT,PKGNAME
 NEW CURPPFX,CPRPPFX,CURHF,CPRHF,CURLF,CPRLF,CURADPFX,CPRADPFX,CUREXPFX,CPREXPFX,CURFL,CPRFL,CURFRL,CPRFRL,CURPP,CPRPP
 ;Variable doc key:
 ; CPR* is compare file data
 ; CUR* is current (Selected) file data
 ;   *PPFX  - Primary Prefix
 ;   *HF    - *Highest file number
 ;   *LF    - *Lowest file number
 ;   *ADPFX - Additional Prefixes
 ;   *EXPFX - Excluded Prefixes
 ;   *FL    - File List
 ;   *FRL   - File Range List
 ;   *PP    - Parent Package
 ;
 SET (FNDCHNG,PKGHDRPT)=0
 SET PKGNAME=$P(NODECUR,"^")
 SET STRVLMCT=VALMCNT
 ;
 ;Prefix
 SET CURPPFX=$P(NODECUR,"^",2)
 SET CPRPPFX=$P(NODECPR,"^",2)
 IF CURPPFX'=CPRPPFX DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO ADD^XTVSLAPI(.VALMCNT,"SEL Prefix: "_$S(CURPPFX]"":CURPPFX,1:"{none}")_"    CPR Prefix: "_$S(CPRPPFX]"":CPRPPFX,1:"{none}"))
 ;
 ;Low File
 SET CURLF=$P(NODECUR,"^",3)
 SET CPRLF=$P(NODECPR,"^",3)
 IF CURLF'=CPRLF DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO ADD^XTVSLAPI(.VALMCNT,"SEL Low File #: "_$S(CURLF]"":CURLF,1:"{none}")_"    CPR Low File #: "_$S(CPRLF]"":CPRLF,1:"{none}"))
 ;
 ;High File
 SET CURHF=$P(NODECUR,"^",4)
 SET CPRHF=$P(NODECPR,"^",4)
 IF CURHF'=CPRHF DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO ADD^XTVSLAPI(.VALMCNT,"SEL High File #: "_$S(CURHF]"":CURHF,1:"{none}")_"    CPR High File #: "_$S(CPRHF]"":CPRHF,1:"{none}"))
 ;
 ;Additional Prefixes
 SET CURADPFX=$P(NODECUR,"^",5)
 SET CPRADPFX=$P(NODECPR,"^",5)
 IF CURADPFX'=CPRADPFX DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO LISTDIF("Additional Prefixes",CURADPFX,CPRADPFX,.VALMCNT)
 ;
 ;Excluded Prefixes
 SET CUREXPFX=$P(NODECUR,"^",6)
 SET CPREXPFX=$P(NODECPR,"^",6)
 IF CUREXPFX'=CPREXPFX DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO LISTDIF("Excepted Prefixes",CUREXPFX,CPREXPFX,.VALMCNT)
 ;
 ;File List
 SET CURFL=$P(NODECUR,"^",7)
 SET CPRFL=$P(NODECPR,"^",7)
 IF CURFL'=CPRFL DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO LISTDIF("Files",CURFL,CPRFL,.VALMCNT)
 ;
 ;File Range List
 SET CURFRL=$P(NODECUR,"^",8)
 SET CPRFRL=$P(NODECPR,"^",8)
 IF CURFRL'=CPRFRL DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO LISTDIF("File Ranges",CURFRL,CPRFRL,.VALMCNT)
 ;
 ;Parent
 SET CURPP=$P(NODECUR,"^",9)
 SET CPRPP=$P(NODECPR,"^",9)
 IF CURPP'=CPRPP DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO ADD^XTVSLAPI(.VALMCNT,"Parent")
 .DO ADD^XTVSLAPI(.VALMCNT,"  SEL: "_$S(CURPP]"":CURPP,1:"{none}"))
 .DO ADD^XTVSLAPI(.VALMCNT,"  CPR: "_$S(CPRPP]"":CPRPP,1:"{none}"))
 ;
 IF VALMCNT'=STRVLMCT SET FNDCHNG=1
 QUIT FNDCHNG
 ;
ADDDELRP(EXTRCT,VALMCNT) ;Report packages Added/Deleted to/from Selected extract
 NEW HDRTXT,NODENM,NODEVAL,DATAELMT,PKGFND
 ;
 SET HDRTXT=$S(EXTRCT="CUR":"ADDED",1:"DELETED")_" PACKAGES:"
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,HDRTXT,1,1,$L(HDRTXT))
 ;
 SET PKGFND=0
 SET NODENM=""
 FOR  SET NODENM=$O(^TMP("XTVS "_EXTRCT_" PARAM",$JOB,NODENM)) QUIT:NODENM=""  SET NODEVAL=^TMP("XTVS "_EXTRCT_" PARAM",$JOB,NODENM) DO
 . SET PKGFND=1
 . DO HDROUT($P(NODEVAL,"^",1),.PKGHDRPT,.VALMCNT) ;Output package name
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",2)
 . DO ADD^XTVSLAPI(.VALMCNT,"Prefix: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",3)
 . DO ADD^XTVSLAPI(.VALMCNT,"Low File #: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",4)
 . DO ADD^XTVSLAPI(.VALMCNT,"High File #: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^XTVSLAPI(.VALMCNT,"Additional Prefixes: ")
 . SET DATAELMT=$P(NODEVAL,"^",5)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^XTVSLAPI(.VALMCNT,"Excepted Prefixes: ")
 . SET DATAELMT=$P(NODEVAL,"^",6)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^XTVSLAPI(.VALMCNT,"File List: ")
 . SET DATAELMT=$P(NODEVAL,"^",7)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^XTVSLAPI(.VALMCNT,"File Range list: ")
 . SET DATAELMT=$P(NODEVAL,"^",8)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",9)
 . DO ADD^XTVSLAPI(.VALMCNT,"Parent: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 ;
 DO:'PKGFND ADD^XTVSLAPI(.VALMCNT," No "_$S(EXTRCT="CUR":"added",EXTRCT="CPR":"deleted",1:"")_" packages!")
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LPCTXT+TXTCT^XTVSHLP1),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 .IF 'XTQVAR DO
 .. WRITE !,"List specific actions:",!
 .. DO DISP^XQORM1 W !
 .. WRITE !,"Email Comparison Report - This action prompts the user for Email addresses,"
 .. WRITE !,"  writes the comparison report to an Email message and sends the message to"
 .. WRITE !,"  the recipients.  This option can be used to send a Comparison Report to"
 .. WRITE !,"  Subject Matter Experts.",!!
 D MSG
 Q
 ;
EXIT ; -- exit code
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
 DO CLNTMPGB
 KILL ^TMP("XTVS PKG MAN PARM COMPARE",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
CLNTMPGB ;Kill temporary globals
 KILL ^TMP("XTVS CUR PARAM",$JOB),^TMP("XTVS CPR PARAM",$JOB)
 QUIT
 ;
HDROUT(PKGNAME,PKGHDRPT,VALMCNT) ; Output package header
 SET PKGHDRPT=1
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"Package: "_PKGNAME,1,10,$L(PKGNAME)) ;ADD^XTVSLAPI parameters: VALMCNT,MSG,LRBOLD,STRTBLD,ENDBLD
 QUIT
 ;
LISTDIF(ELMTNME,CURDAT,CPRDAT,VALMCNT) ; Output differences in parameter lists
 NEW PCENUM,DATAELMT,CHKELMT
 DO ADD^XTVSLAPI(.VALMCNT,"  "_ELMTNME)
 ;
 IF (CURDAT]""),(CPRDAT']"") DO 
 . DO EVENSPLT(.VALMCNT,"Added entire list in SEL file: ",1)
 . DO EVENSPLT(.VALMCNT,CURDAT)
 IF (CURDAT']""),(CPRDAT]"") DO
 . DO EVENSPLT(.VALMCNT,"Deleted entire list in SEL file: ",1)
 . DO EVENSPLT(.VALMCNT,CPRDAT)
 ;
 IF (CURDAT]""),(CPRDAT]"") DO  ;List changes as lineitems
 . DO EVENSPLT(.VALMCNT,"CPR Parameter List: "_$S(CPRDAT]"":CPRDAT,1:"{none}"),1)
 . ;
 . ;Check for deletions
 . FOR PCENUM=1:1 SET DATAELMT=$P(CPRDAT,"|",PCENUM)  Q:DATAELMT=""  DO
 .. SET CHKELMT=DATAELMT_"|"
 .. IF CURDAT'[CHKELMT DO EVENSPLT(.VALMCNT,DATAELMT_" ...deleted in SEL file")
 . IF PCENUM=1 DO ADD^XTVSLAPI(.VALMCNT,"      {none} ...deleted in SEL file")
 . ;
 . ;Check for additions
 . FOR PCENUM=1:1 SET DATAELMT=$P(CURDAT,"|",PCENUM)  Q:DATAELMT=""  DO
 .. SET CHKELMT=DATAELMT_"|"
 .. IF CPRDAT'[CHKELMT DO EVENSPLT(.VALMCNT,DATAELMT_" ...added in SEL file")
 . IF PCENUM=1 DO ADD^XTVSLAPI(.VALMCNT,"      {none} ...added in SEL file")
 . ;
 . DO EVENSPLT(.VALMCNT,"SEL Parameter List: "_$S(CURDAT]"":CURDAT,1:"{none}"),1)
 ;
 QUIT
 ;
EVENSPLT(VALMCNT,MSG,DTANODE) ; Add line to build display split on piece
 ; VALMCNT - Selected array node number
 ; MSG     - Message to add to ListMan Display
 ; DTANODE - Indicates raw data node or data element changed
 ;             1 : Raw data node
 ;             0 : data element changed
 ;
 NEW PCENUM,MSGPCE,LINEOUT,START
 SET DTANODE=+$G(DTANODE)
 SET LINEOUT=""
 SET START=1
 ;
 FOR PCENUM=1:1 SET MSGPCE=$P(MSG,"|",PCENUM) SET LINEOUT=LINEOUT_MSGPCE_$$DELIMEND(MSGPCE) QUIT:MSGPCE=""  DO
 . IF ($L(LINEOUT)>$S(DTANODE:75,1:73))!(LINEOUT["...") DO  ;$Select DTANODE determines if leading spaces are added to LINEOUT
 .. IF $L(LINEOUT)>$S(DTANODE:75,1:73) DO
 ... SET PCENUM=PCENUM-1
 ... SET LINEOUT=$P(MSG,"|",START,PCENUM)
 .. DO ADD^XTVSLAPI(.VALMCNT,"    "_$S('DTANODE:"  ",1:"")_LINEOUT)
 .. SET LINEOUT=""
 .. SET START=PCENUM+1
 DO:LINEOUT]"" ADD^XTVSLAPI(.VALMCNT,"    "_$S('DTANODE:"  ",1:"")_LINEOUT)
 ;
 QUIT
 ;
DELIMEND(MSGPCE) ; Return ending delimiter for LINEOUT in EVENSPLT^XTVSLPC
 NEW RESULT
 SET RESULT=$S((MSGPCE'["...")&(MSGPCE'="")&(MSGPCE'["{none}")&(MSGPCE'["file:"):"|",1:"")
 QUIT RESULT
 ;
DELPKG(CURNDNM,CPRNDNM) ; Delete Package from Selected and Compare parameter files
 KILL ^TMP("XTVS CUR PARAM",$JOB,CURNDNM),^TMP("XTVS CPR PARAM",$JOB,CPRNDNM)
 QUIT
 ;
 ;PROTOCOL entry points
 ;
MAILRPT ; Email ^TMP("XTVS PKG MGR PARAM ERROR DISP") comparison report
 ; -- Protocol: XTVS PKG MGR PARAM COMPR MAIL ACTION
 NEW XTINSTMM,XTTOMM,XMERR,XMZ,XTTYPE,SUBSCPT
 DO FULL^VALM1
 WRITE !!," The message can take some time to be sent.",!
 KILL XMERR
 SET XTINSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 SET XTTYPE="S"
 DO TOWHOM^XMXAPIU(DUZ,,XTTYPE,.XTINSTMM)
 IF +$G(XMERR)'>0 DO
 . NEW XMY,XMTEXT,XMDUZ,XMSUB,XTLPCNT
 . SET XTLPCNT=""
 . FOR  SET XTLPCNT=$O(^TMP("XMY",$J,XTLPCNT)) QUIT:XTLPCNT=""  SET XMY(XTLPCNT)=""
 . SET XMDUZ=DUZ
 . SET XMSUB=$P(VALMHDR(4),":",2)_" ("_$P(VALMHDR(1)," - ",2)_")"
 . SET ^TMP("XTVS PKG MAN CMPR MSG",$JOB,1)="Parameter Files comparison: "_$P(VALMHDR(4),":",2)_" [SEL] vs "_$P(VALMHDR(5),":",2)_" [CPR]"
 . SET SUBSCPT=0
 . FOR  SET SUBSCPT=$O(^TMP("XTVS PKG MAN PARM COMPARE",$JOB,SUBSCPT)) QUIT:+SUBSCPT=0  DO
 .. SET ^TMP("XTVS PKG MAN CMPR MSG",$JOB,SUBSCPT+1)=^TMP("XTVS PKG MAN PARM COMPARE",$JOB,SUBSCPT,0)
 . SET XMTEXT="^TMP(""XTVS PKG MAN CMPR MSG"","_$JOB_","
 . DO ^XMD
 . IF +XMZ>0 DO JUSTPAWS^XTVSLAPI($P(VALMHDR(1)," - ",2)_" Emailed.  [MSG #:"_XMZ_"]")
 . IF +XMZ'>0  DO JUSTPAWS^XTVSLAPI("Error: "_$P(VALMHDR(1)," - ",2)_" not Emailed! ["_XMZ_"]")
 . KILL ^TMP("XTVS PKG MAN CMPR MSG",$JOB)
 ;
 D MSG
 SET VALMBCK="R"
 QUIT

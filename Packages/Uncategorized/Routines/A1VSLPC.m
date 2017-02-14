A1VSLPC ;Albany FO/GTS - VistA Package Sizing Manager; 17-NOV-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
EN(CMPRFNME) ; -- main entry point for A1VS PKG MGR PARAM COMPARE
 ; Input: CMPRFNME - File to compare current XTMPSIZE.DAT file
 ;
 IF CMPRFNME'["XTMPSIZE" DO  QUIT
 . DO JUSTPAWS^A1VSLAPI("Comparison XTMPSIZE.DAT file NOT selected!")
 ;
 D EN^VALM("A1VS PKG MGR PARAM COMPARE")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Parameter Compare"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^A1VSLM()_"     Build: "_$$BLDNUM^A1VSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Current [New] file: "_A1VPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 SET DIRHEAD="Comparison [Old] file: "_CMPRFNME
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(5)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; - Build Current and Comparison XTMPSIZE parameter arrays
 NEW DEFDIR,NODENUM,NODECUR,CURNDNM,CPRNDNM,PKGRPTD,PKGDEL,DELSTATE
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET DEFDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I")
 ;
 ;Build current XTMPSIZE parameter array
 DO OPEN^%ZISH("XTMP",DEFDIR,A1VPSPRM,"R")
 U IO
 SET NODENUM=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO
 .. SET NODENUM=NODENUM+1
 .. SET ^TMP("A1VS CUR PARAM",$JOB,NODENUM)=LINEITEM ;Creates ^TMP("A1VS CUR PARAM",$JOB) array
 D CLOSE^%ZISH("XTMP")
 ;
 ;Build comparison XTMPSIZE parameter array
 DO OPEN^%ZISH("XTMP2",DEFDIR,CMPRFNME,"R")
 U IO
 SET NODENUM=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO
 .. SET NODENUM=NODENUM+1
 .. SET ^TMP("A1VS CPR PARAM",$JOB,NODENUM)=LINEITEM ;Creates ^TMP("A1VS CPR PARAM",$JOB) array
 D CLOSE^%ZISH("XTMP2")
 ;
 ;Create ^TMP("A1VS PKG MAN PARM COMPARE",$JOB) comparison result array for ListMan display
 SET (PKGRPTD,VALMCNT)=0
 ;
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"CHANGED PACKAGES",1,1,16) ;Output Header for Changed Package list
 ;Loop through each "Current" (latest) Package Lineitem
 SET CURNDNM=0
 FOR  SET CURNDNM=$O(^TMP("A1VS CUR PARAM",$JOB,CURNDNM)) QUIT:CURNDNM=""  SET NODECUR=^TMP("A1VS CUR PARAM",$JOB,CURNDNM) DO
 . SET DELSTATE=0
 . IF NODECUR=$G(^TMP("A1VS CPR PARAM",$JOB,CURNDNM)) DO DELPKG(CURNDNM,CURNDNM) SET DELSTATE=1 ;;Remove unedited package from CPR & CUR globals
 . IF (NODECUR'=$G(^TMP("A1VS CPR PARAM",$JOB,CURNDNM))),('DELSTATE) DO  ;;If Current Package '= same node on Compare Package lineitem
 .. SET (PKGDEL,CPRNDNM)=0
 .. FOR  SET CPRNDNM=$O(^TMP("A1VS CPR PARAM",$JOB,CPRNDNM)) QUIT:CPRNDNM=""  QUIT:PKGDEL  DO COMPARE(CPRNDNM,NODECUR,.VALMCNT,.PKGDEL,.PKGRPTD)
 IF PKGRPTD=0 DO
 . DO ADD^A1VSLAPI(.VALMCNT," No edited packages!")
 ;
 DO ADDDELRP("CUR",.VALMCNT) ;Report packages added new to Current package extract
 DO ADDDELRP("CPR",.VALMCNT) ;Report packages deleted from Current package extract
 SET PKGRPTD=0
 ;
 QUIT
 ;
COMPARE(CPRNDNM,NODECUR,VALMCNT,PKGDEL,PKGRPTD) ; Compare current & selected parameter files, report diff's and cleanup ^TMP globals
 NEW NODECPR,CURPKG,CPRPKG,FNDCHG,CPRPCS,CURPCS
 SET CURPKG=$P(NODECUR,"^")
 SET NODECPR=^TMP("A1VS CPR PARAM",$JOB,CPRNDNM)
 SET CPRPKG=$P(NODECPR,"^")
 ;
 ; Set CPRPCS and CURPCS to compare new Parameter file to Old Parameter file
 ;  (pce 10 = * on old parameter files indicated circular Parent/Child relationship)
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
CHNGCHK(NODECUR,NODECPR,VALMCNT) ; Check latest extract (CUR) against a comparison extract (CPR)
 NEW FNDCHNG,PKGHDRPT,PKGNAME
 NEW CURPPFX,CPRPPFX,CURHF,CPRHF,CURLF,CPRLF,CURADPFX,CPRADPFX,CUREXPFX,CPREXPFX,CURFL,CPRFL,CURFRL,CPRFRL,CURPP,CPRPP
 ;Variable doc key:
 ; CPR* is compare file data
 ; CUR* is current file data
 ;   *PPFX  - Primary Prefix
 ;   *HF    - *Highest file number
 ;   *LF    - *Lowest file number
 ;   *ADPFX - Additional Prefices
 ;   *EXPFX - Excluded Prefices
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
 .DO ADD^A1VSLAPI(.VALMCNT,"New Prefix: "_$S(CURPPFX]"":CURPPFX,1:"{none}")_"    Old Prefix: "_$S(CPRPPFX]"":CPRPPFX,1:"{none}"))
 ;
 ;Low File
 SET CURLF=$P(NODECUR,"^",3)
 SET CPRLF=$P(NODECPR,"^",3)
 IF CURLF'=CPRLF DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO ADD^A1VSLAPI(.VALMCNT,"New Low File #: "_$S(CURLF]"":CURLF,1:"{none}")_"    Old Low File #: "_$S(CPRLF]"":CPRLF,1:"{none}"))
 ;
 ;High File
 SET CURHF=$P(NODECUR,"^",4)
 SET CPRHF=$P(NODECPR,"^",4)
 IF CURHF'=CPRHF DO
 .DO:'PKGHDRPT HDROUT(PKGNAME,.PKGHDRPT,.VALMCNT)
 .DO ADD^A1VSLAPI(.VALMCNT,"New High File #: "_$S(CURHF]"":CURHF,1:"{none}")_"    Old High File #: "_$S(CPRHF]"":CPRHF,1:"{none}"))
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
 .DO ADD^A1VSLAPI(.VALMCNT,"Parent")
 .DO ADD^A1VSLAPI(.VALMCNT,"  New: "_$S(CURPP]"":CURPP,1:"{none}"))
 .DO ADD^A1VSLAPI(.VALMCNT,"  Old: "_$S(CPRPP]"":CPRPP,1:"{none}"))
 ;
 IF VALMCNT'=STRVLMCT SET FNDCHNG=1
 QUIT FNDCHNG
 ;
ADDDELRP(EXTRCT,VALMCNT) ;Report packages Added/Deleted to/from current extract
 NEW HDRTXT,NODENM,NODEVAL,DATAELMT,PKGFND
 ;
 SET HDRTXT=$S(EXTRCT="CUR":"ADDED",1:"DELETED")_" PACKAGES:"
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,HDRTXT,1,1,$L(HDRTXT))
 ;
 SET PKGFND=0
 SET NODENM=""
 FOR  SET NODENM=$O(^TMP("A1VS "_EXTRCT_" PARAM",$JOB,NODENM)) QUIT:NODENM=""  SET NODEVAL=^TMP("A1VS "_EXTRCT_" PARAM",$JOB,NODENM) DO
 . SET PKGFND=1
 . DO HDROUT($P(NODEVAL,"^",1),.PKGHDRPT,.VALMCNT) ;Output package name
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",2)
 . DO ADD^A1VSLAPI(.VALMCNT,"Prefix: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",3)
 . DO ADD^A1VSLAPI(.VALMCNT,"Low File #: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",4)
 . DO ADD^A1VSLAPI(.VALMCNT,"High File #: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^A1VSLAPI(.VALMCNT,"Additional Prefixes: ")
 . SET DATAELMT=$P(NODEVAL,"^",5)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^A1VSLAPI(.VALMCNT,"Excepted Prefixes: ")
 . SET DATAELMT=$P(NODEVAL,"^",6)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^A1VSLAPI(.VALMCNT,"File List: ")
 . SET DATAELMT=$P(NODEVAL,"^",7)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . DO ADD^A1VSLAPI(.VALMCNT,"File Range list: ")
 . SET DATAELMT=$P(NODEVAL,"^",8)
 . DO EVENSPLT(.VALMCNT,$S(DATAELMT]"":DATAELMT,1:"{none}"))
 . ;
 . SET DATAELMT=$P(NODEVAL,"^",9)
 . DO ADD^A1VSLAPI(.VALMCNT,"Parent: "_$S(DATAELMT]"":DATAELMT,1:"{none}"))
 ;
 DO:'PKGFND ADD^A1VSLAPI(.VALMCNT," No "_$S(EXTRCT="CUR":"added",EXTRCT="CPR":"deleted",1:"")_" packages!")
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
 DO INIT
 SET VALMBCK="R"
 QUIT
 ;
MSG(TEXT) ; -- set default message
 ;SET VALMSG=TEXT
 QUIT
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 DO CLNTMPGB
 KILL ^TMP("A1VS PKG MAN PARM COMPARE",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
CLNTMPGB ;Kill temporary globals
 KILL ^TMP("A1VS CUR PARAM",$JOB),^TMP("A1VS CPR PARAM",$JOB)
 QUIT
 ;
HDROUT(PKGNAME,PKGHDRPT,VALMCNT) ; Output package header
 SET PKGHDRPT=1
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"Package: "_PKGNAME,1,10,$L(PKGNAME)) ;ADD^A1VSLAPI parameters: VALMCNT,MSG,LRBOLD,STRTBLD,ENDBLD
 QUIT
 ;
LISTDIF(ELMTNME,CURDAT,CPRDAT,VALMCNT) ; Output differences in parameter lists
 NEW PCENUM,DATAELMT
 DO ADD^A1VSLAPI(.VALMCNT,"  "_ELMTNME)
 ;
 IF (CURDAT]""),(CPRDAT']"") DO 
 . DO EVENSPLT(.VALMCNT,"Added entire list in New file: ",1)
 . DO EVENSPLT(.VALMCNT,CURDAT)
 IF (CURDAT']""),(CPRDAT]"") DO
 . DO EVENSPLT(.VALMCNT,"Deleted entire list in New file: ",1)
 . DO EVENSPLT(.VALMCNT,CPRDAT)
 ;
 IF (CURDAT]""),(CPRDAT]"") DO  ;List changes as lineitems
 . DO EVENSPLT(.VALMCNT,"Old List: "_$S(CPRDAT]"":CPRDAT,1:"{none}"),1)
 . ;
 . ;Check for deletions
 . FOR PCENUM=1:1 SET DATAELMT=$P(CPRDAT,"|",PCENUM)  Q:DATAELMT=""  DO
 .. IF CURDAT'[DATAELMT_"|" DO EVENSPLT(.VALMCNT,DATAELMT_" ...deleted in New file")
 . IF PCENUM=1 DO ADD^A1VSLAPI(.VALMCNT,"      {none} ...deleted in New file")
 . ;
 . ;Check for additions
 . FOR PCENUM=1:1 SET DATAELMT=$P(CURDAT,"|",PCENUM)  Q:DATAELMT=""  DO
 .. IF CPRDAT'[DATAELMT_"|" DO EVENSPLT(.VALMCNT,DATAELMT_" ...added in New file")
 . IF PCENUM=1 DO ADD^A1VSLAPI(.VALMCNT,"      {none} ...added in New file")
 . ;
 . DO EVENSPLT(.VALMCNT,"New List: "_$s(CURDAT]"":CURDAT,1:"{none}"),1)
 ;
 QUIT
 ;
EVENSPLT(VALMCNT,MSG,DTANODE) ; Add line to build display split on piece
 ; VALMCNT - Current array node number
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
 .. DO ADD^A1VSLAPI(.VALMCNT,"    "_$S('DTANODE:"  ",1:"")_LINEOUT)
 .. SET LINEOUT=""
 .. SET START=PCENUM+1
 DO:LINEOUT]"" ADD^A1VSLAPI(.VALMCNT,"    "_$S('DTANODE:"  ",1:"")_LINEOUT)
 ;
 QUIT
 ;
DELIMEND(MSGPCE) ; Return ending delimiter for LINEOUT in EVENSPLT^A1VSLPC
 NEW RESULT
 SET RESULT=$S((MSGPCE'["...")&(MSGPCE'="")&(MSGPCE'["{none}")&(MSGPCE'["file:"):"|",1:"")
 QUIT RESULT
 ;
DELPKG(CURNDNM,CPRNDNM) ; Delete Package from Current and Compare parameter files
 KILL ^TMP("A1VS CUR PARAM",$JOB,CURNDNM),^TMP("A1VS CPR PARAM",$JOB,CPRNDNM)
 QUIT
 ;
 ;PROTOCOL entry points
 ;
MAILRPT ; Email ^TMP("A1VS PKG MGR PARAM ERROR DISP") comparison report
 ; -- Protocol: A1VS PKG MGR PARAM COMPR MAIL ACTION
 NEW A1INSTMM,A1TOMM,XMERR,XMZ,A1TYPE,SUBSCPT
 DO FULL^VALM1
 KILL XMERR
 SET A1INSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 SET A1TYPE="S"
 DO TOWHOM^XMXAPIU(DUZ,,A1TYPE,.A1INSTMM)
 IF +$G(XMERR)'>0 DO
 . NEW XMY,XMTEXT,XMDUZ,XMSUB,A1LPCNT
 . SET A1LPCNT=""
 . FOR  SET A1LPCNT=$O(^TMP("XMY",$J,A1LPCNT)) QUIT:A1LPCNT=""  SET XMY(A1LPCNT)=""
 . SET XMDUZ=DUZ
 . SET XMSUB=$P(VALMHDR(4),":",2)_" ("_$P(VALMHDR(1)," - ",2)_")"
 . ;SET XMTEXT="^TMP(""A1VS PKG MAN PARM COMPARE"","_$JOB_","
 . SET ^TMP("A1VS PKG MAN CMPR MSG",$JOB,1)="Parameter Files comparison: "_$P(VALMHDR(4),":",2)_" [New] vs "_$P(VALMHDR(5),":",2)_" [Old]"
 . SET SUBSCPT=0
 . FOR  SET SUBSCPT=$O(^TMP("A1VS PKG MAN PARM COMPARE",$JOB,SUBSCPT)) QUIT:+SUBSCPT=0  DO
 .. SET ^TMP("A1VS PKG MAN CMPR MSG",$JOB,SUBSCPT+1)=^TMP("A1VS PKG MAN PARM COMPARE",$JOB,SUBSCPT,0)
 . SET XMTEXT="^TMP(""A1VS PKG MAN CMPR MSG"","_$JOB_","
 . DO ^XMD
 . IF +XMZ>0 DO JUSTPAWS^A1VSLAPI($P(VALMHDR(1)," - ",2)_" E-Mailed.  [MSG #:"_XMZ_"]")
 . IF +XMZ'>0  DO JUSTPAWS^A1VSLAPI("Error: "_$P(VALMHDR(1)," - ",2)_" not E-Mailed! ["_XMZ_"]")
 . KILL ^TMP("A1VS PKG MAN CMPR MSG",$JOB)
 ;
 SET VALMBCK="R"
 QUIT

XTVSLNA1 ;BHAM/MAM/GTS - VistA Package Sizing Manager; 1-JUL-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
PKGEXT() ;Entry point - Package File extract (ACTION Protocol: XTVS PKG EXTRACT CREATE ACTION)
 ;
 ; STOPKILL: 0^0  $JOB sub-array for ^XTMP("XTSIZE") did not exist and was created
 ;           0^1  $JOB sub-array for ^XTMP("XTSIZE") existed and was recreated
 ;           1^1  $JOB sub-array for ^XTMP("XTSIZE") existed and was NOT recreated
 ;
 NEW STOPKILL,XTVSUNME,VPNAME,VPIEN
 SET XTVSUNME=$$NAME^XUSER(DUZ)
 SET STOPKILL="0^0"
 IF ($D(^XTMP("XTSIZE",$JOB))) DO  QUIT:STOPKILL "1^1"  ;;If STOPKILL, do NOT delete existing ^XTMP("XTSIZE",$J) global
 . NEW X,Y,DIR
 . SET DIR("A",1)=""
 . SET DIR("A",2)="^XTMP(""XTSIZE"","_$JOB_") already exists!"
 . SET DIR("A")="Do you want to delete ^XTMP(""XTSIZE"","_$JOB_") and recreate it"
 . SET DIR("B")="NO"
 . SET DIR(0)="Y::"
 . SET STOPKILL="0^1"
 . DO ^DIR
 . IF ($D(DTOUT))!($D(DUOUT))!(($G(Y)=0)) DO
 .. DO JUSTPAWS^XTVSLAPI("^XTMP(""XTSIZE"","_$JOB_") NOT DELETED!")
 .. SET STOPKILL="1^1"
 ;
 K ^XTMP("XTSIZE",$J)
 ;NOTE: First pce of 0 node sets ^XTMP purge date 90 days from 'Today'
 S ^XTMP("XTSIZE",$J,0)=$$FMADD^XLFDT($P($$NOW^XLFDT,"."),90)_"^"_$P($$NOW^XLFDT,".")_"^"_$$NOW^XLFDT_"-Kernel ToolKit Package File Extract by "_$S($G(XTVSUNME)]"":XTVSUNME,1:"{unknown user}")_"^"_^%ZOSF("PROD")
 ;
 S VPIEN=0 F  S VPIEN=$O(^DIC(9.4,VPIEN)) Q:'VPIEN  S VPNAME=$P($G(^DIC(9.4,VPIEN,0)),"^") IF VPNAME]"" DO
 . IF $P($G(^DIC(9.4,VPIEN,15002)),"^",3)'="X" DO 
 .. IF VPNAME["""" DO
 ... SET VPNAME=$REPLACE(VPNAME,"""","''")
 ... DO NOTCE^XTVSLAPI("Double Quotes changed to 2 single quotes in the "_VPNAME_" Package name.",$$NETNAME^XMXUTIL(DUZ),VPNAME)
 .. DO SETXTMP^XTVSLNA1 ;Extract Packages
 ;
 QUIT STOPKILL
 ;
SETXTMP ; set ^XTMP global with PACKAGE data
 ;
 ; Piece 1 = Namespace
 ; Piece 2 = Lower File Number Range
 ; Piece 3 = Highest File Number Range
 ; Piece 4 = Other Namepaces separated by "|"
 ; Piece 5 = Excepted Namepaces separated by "|"
 ; Piece 6 = Package File Ranges separated by "|"
 ; Piece 7 = Package Parent name
 ;
 NEW VPPARPKG,PARNTNME,VPN,VPLOW,VPHIGH,VPOTHER,VPNAT,VPRNGE,VPEXCPT
 NEW VP11,VPNUM,VPHNUM,VPIEN2,VPLNUM,VPFNUM
 ;Get Package CLASS and PARENT PACKAGE
 S VPNAT=$G(^DIC(9.4,VPIEN,7)),VPNAT=$P(VPNAT,"^",3),VPPARPKG=$P($GET(^DIC(9.4,VPIEN,15002)),"^",2),PARNTNME=""
 IF VPNAT'="I",VPNAT'="Ia",VPNAT='"Ib",VPNAT'="Ic" QUIT  ;Only extract Class I, Ia, Ib and Ic packages
 S VPN=$P($G(^DIC(9.4,VPIEN,0)),"^",2) IF VPN']"" QUIT  ; PREFIX, Required, Do not extract if missing PREFIX
 S (VPEXCPT,VPOTHER,VPRNGE)=""
 S VP11=$G(^DIC(9.4,VPIEN,11)),VPLOW=$P(VP11,"^"),VPHIGH=$P(VP11,"^",2) ;*LOWEST/*HIGHEST FILE NUMBERS
 ;Get ADDITIONAL PREFIXES
 IF $D(^DIC(9.4,VPIEN,14)) DO
 . SET VPIEN2=0 F  S VPIEN2=$O(^DIC(9.4,VPIEN,14,VPIEN2)) Q:'VPIEN2  S VPOTHER=VPOTHER_$G(^DIC(9.4,VPIEN,14,VPIEN2,0))_"|"
 ;Get EXCLUDED NAMESPACE
 IF $D(^DIC(9.4,VPIEN,"EX")) DO
 . SET VPIEN2=0 F  S VPIEN2=$O(^DIC(9.4,VPIEN,"EX",VPIEN2)) Q:'VPIEN2  S VPEXCPT=VPEXCPT_$G(^DIC(9.4,VPIEN,"EX",VPIEN2,0))_"|"
 ;
 ;Get File Number Ranges from multiple field 15001.1
 IF +$$FLDNUM^DILFD(9.4,"LOW-HIGH RANGE")=15001.1,$D(^DIC(9.4,VPIEN,15001)) DO
 .S VPRNGE=""
 .S VPIEN2=0
 .F  S VPIEN2=$O(^DIC(9.4,VPIEN,15001.1,VPIEN2)) Q:'VPIEN2  DO
 ..S VPLNUM=$P($G(^DIC(9.4,VPIEN,15001.1,VPIEN2,0)),"^")
 ..S VPHNUM=$P($G(^DIC(9.4,VPIEN,15001.1,VPIEN2,0)),"^",2)
 ..S VPRNGE=VPRNGE_VPLNUM_"-"_VPHNUM_"|"
 ;
 ;Get File Numbers from multiple field 15001
 IF +$$FLDNUM^DILFD(9.4,"FILE NUMBER")=15001,$D(^DIC(9.4,VPIEN,15001)) DO
 .S VPIEN2=0
 .FOR  S VPIEN2=$O(^DIC(9.4,VPIEN,15001,VPIEN2)) Q:'VPIEN2  DO
 ..S (VPFNUM,VPLNUM,VPHNUM)=""
 ..S VPFNUM=$G(^DIC(9.4,VPIEN,15001,VPIEN2,0))
 ..S:+VPFNUM>0 ^XTMP("XTSIZE",$J,VPNAME,VPFNUM)=""
 ;
 ;Get PARENT PACKAGE field (#15003) Parent name
 IF VPPARPKG]"" DO
 .SET PARNTNME=$P($G(^DIC(9.4,VPPARPKG,0)),"^")
 ;
 S ^XTMP("XTSIZE",$J,VPNAME)=VPN_"^"_VPLOW_"^"_VPHIGH_"^"_VPOTHER_"^"_VPEXCPT_"^"_VPRNGE_"^"_PARNTNME
 QUIT
 ;
XTMPORD(XDOLRJ,RPT,XTSZARY) ; Read ^XTMP("XTSIZE) array and create ^TMP globals for listing/reporting
 ; INPUT:
 ;   XDOLRJ - $JOB for selected Package File Extract
 ;   RPT - Information to include on correction report
 ;          0: No report
 ;          3: Report both no files and added ranges [Default]
 ;   XTSZARY - Create ^TMP("XTSIZE") global for XTVSSVR
 ;              0: Do not create global [Default]
 ;              1: Create global
 ;
 ;Parameter List data map to Package file (#9.4):
 ; pce 1 : Package Name [Source: NAME (#.01)]
 ; pce 2 : Primary Prefix [Source: PREFIX (#1)]
 ; pce 3 : *Lowest File # [Source: *LOWEST FILE NUMBER (#10.6)]
 ; pce 4 : *Highest File # [Source: *HIGHEST FILE NUMBER (#11)]
 ; pce 5 : Pipe character (|) delimited list of Additional Prefixes [Source: ADDITIONAL PREFIXES multiple (#14)]
 ; pce 6 : Pipe character (|) delimited list of Excepted Prefixes [Source: EXCLUDED NAME SPACE multiple (#919)]
 ; pce 7 : Pipe character (|) delimited list of File entries [Source: FILE NUMBER multiple (#15001)]
 ; pce 8 : Pipe character (|) delimited list of File Range entries [Primary Source: LOW-HIGH RANGE multiple (#15001.1)]
 ; pce 9 : Parent Package [1st Source: PARENT PACKAGE field (#15003)]
 ;
 KILL ^TMP("XTVS-FILERPT")
 IF '$GET(XTSZARY) SET XTSZARY=0 ;default
 ;
 NEW LPCNT,FAMTREE,SUBSCPT,DATARY,XTSZNUM
 ;
 DO FAMINDEX(XDOLRJ) ;Reorder ^XTMP("XTSIZE") into ^TMP("XTSIZE","IDX") to indicate family tree for a package
 NEW PKGVAL,CHILDPKG,LINEITEM,FILENUM,FIRSTNUM
 SET PKGVAL=0
 FOR  SET PKGVAL=$O(^XTMP("XTSIZE",XDOLRJ,PKGVAL)) Q:PKGVAL="authentication"  QUIT:PKGVAL=""  DO
 . SET LINEITEM=""
 . ;Check for Package Name = Prefix
 . SET LINEITEM=$S("ZU  |AUP |AUT |DRG |GMD |GMN |VDE |XIP "[PKGVAL:$P(PKGVAL," "),1:PKGVAL)_"^"_$P(^XTMP("XTSIZE",XDOLRJ,PKGVAL),"^",1,5)_"^^"_$P(^XTMP("XTSIZE",XDOLRJ,PKGVAL),"^",6,7) ;Also: AUT,AUP,DRG,GMD,GMN,VDE,XIP,VPFS
 . SET FILENUM=0
 . FOR  SET FILENUM=$O(^XTMP("XTSIZE",XDOLRJ,PKGVAL,FILENUM)) QUIT:FILENUM=""  Q:FILENUM'?.N  DO
 .. SET $P(LINEITEM,"^",7)=$P(LINEITEM,"^",7)_FILENUM_"|" ;ADD File List multiple to Pce 7
 . SET FAMTREE=$$LINEAGE(PKGVAL,$J)
 . KILL SUBS
 . FOR LPCNT=1:1 SET SUBSCPT=$P(FAMTREE,"^",LPCNT) QUIT:SUBSCPT=""  S SUBS(LPCNT)=SUBSCPT
 . SET DATARY=$P($NAME(^TMP("XTSIZE",$J)),")")
 . SET LPCNT=0
 . FOR  SET LPCNT=$O(SUBS(LPCNT)) QUIT:(LPCNT="")  DO
 .. SET SUBSCPT=SUBS(LPCNT)
 .. SET DATARY=DATARY_","_""_SUBSCPT
 . SET DATARY=DATARY_")"
 . ;
 . ;NOTE: RPT - 0: no report, 3: both no files and added ranges [future use 1: No Ranges in multiple, 2: Files added to Range]
 . IF $GET(RPT)="" SET RPT=3 ;;To report file changes
 . SET $P(LINEITEM,"^",8)=$$FLRNGCLN(LINEITEM,PKGVAL,RPT) ;CLEANUP File Range multiple in Pce 8
 . SET @DATARY=LINEITEM ;Set ^TMP("XTSIZE",$J) to LINEITEM
 . ;
 . IF XTSZARY DO  ;;Create for XTSSVR
 .. SET XTSZNUM=$GET(XTSZNUM)+1
 .. SET ^TMP("XTVS-FORUMPKG",$J,XTSZNUM)=LINEITEM
 . ;
 . ; If no FILE or RANGE Multiple Entries, report High/Low File number fields
 . IF RPT DO
 .. NEW LOW,HIGH,RPTRNG,LINERNG
 .. SET LINERNG=$P(LINEITEM,"^",8)
 .. IF $P(LINERNG,"|")="" DO  ;Only check High/Low fields when Range multiple undefined
 ... SET LOW=$P(LINEITEM,"^",3)
 ... SET HIGH=$P(LINEITEM,"^",4)
 ... SET RPTRNG=LOW_"-"_HIGH
 ... SET:RPTRNG="-" RPTRNG="No File Ranges or High/Low Fields"
 ... IF RPTRNG["-" DO
 .... SET:$P(RPTRNG,"-")="" $P(RPTRNG,"-",1)="<begin undefined>"
 .... SET:$P(RPTRNG,"-",2)="" $P(RPTRNG,"-",2)="<end undefined>"
 ... DO RPTFLADD(PKGVAL,"HL",RPTRNG)
 ;
 KILL SUBS,^TMP("XTSIZE","IDX",$JOB)
 ;
 QUIT
 ;
FAMINDEX(XDOLRJ) ; Create a package family tree ^TMP global=pkg^parentpkg^grndparentpkg^etc.
 NEW PARNTPKG
 NEW FAMTREE,PKGVAL
 SET PKGVAL=0
 FOR  SET PKGVAL=$O(^XTMP("XTSIZE",XDOLRJ,PKGVAL)) Q:PKGVAL="authentication"  Q:PKGVAL=""  DO
 . SET FAMTREE=""
 . IF '$D(^TMP("XTSIZE","IDX",$J,PKGVAL)) DO
 .. SET FAMTREE=$$ANCESTRY(PKGVAL,XDOLRJ)
 .. SET ^TMP("XTSIZE","IDX",$J,PKGVAL)=FAMTREE
 QUIT
 ;
ANCESTRY(PKGVAL,XDOLRJ) ; Return list of package-parent-grandparent-etc. relationships
 NEW FAMTREE,PARENT,LASTPRNT
 SET PARENT=PKGVAL
 SET FAMTREE=$S("ZU  |AUP |AUT |DRG |GMD |GMN |VDE |XIP "[PKGVAL:$P(PKGVAL," "),1:PKGVAL) ;Cleanup Namespace returned from Forum Package file (Also: VPFS)
 FOR  QUIT:PARENT=""  SET LASTPRNT=PARENT SET PARENT=$P($G(^XTMP("XTSIZE",XDOLRJ,PARENT)),"^",7) QUIT:PARENT=LASTPRNT  QUIT:((FAMTREE["^")&(FAMTREE[PARENT))  DO
 . IF PARENT'="" DO
 .. SET FAMTREE=FAMTREE_"^"_PARENT
 QUIT FAMTREE
 ;
LINEAGE(PKG,DOLRJ) ; Return a family tree subscript string
 NEW CHKLVL,SUBLVL,SUBSCPT,FAMTREE,SUB
 SET SUBSCPT=""
 IF $D(^TMP("XTSIZE","IDX",DOLRJ,PKG)) DO
 . SET SUBSCPT=^TMP("XTSIZE","IDX",DOLRJ,PKG)
 . FOR SUBLVL=1:1 SET SUB(SUBLVL)=$P(SUBSCPT,"^",SUBLVL)  IF SUB(SUBLVL)="" KILL SUB(SUBLVL) QUIT
 . SET (SUBSCPT,SUBLVL)=""
 . FOR  SET SUBLVL=$O(SUB(SUBLVL),-1) Q:SUBLVL=""  SET SUBSCPT=SUBSCPT_SUB(SUBLVL)_""""_"^"_""""
 . SET SUBSCPT=""""_$P(SUBSCPT,"^",1,$O(SUB(SUBLVL),-1))
 QUIT SUBSCPT
 ;
FLRNGCLN(LINEITEM,PKGVAL,RPT) ;Cleanup File Ranges received from Forum Package file
 ; INPUT : LINEITEM - Value of ^XTMP("XTSIZE") node
 ;         PKGVAL   - Package reporting from ^XTMP("XTSIZE") node
 ;         RPT      - >0 : Report Range additions
 ;                    0  : Do not report Range additions
 ;
 ; File range of LineItem (pce 8) will be "cleaned up" as follows:
 ;  Any "end of range" file number that does not have a decimal end will be changed to 9999/10000 (E.G. 7 becomes 7.9999)
 ;  Any File number in the FILE number on LineItem (Pce 7) that is not in a range will be added as a range (7 becomes 7-7.9999)
 ;
 NEW RANGE,BEGFLNM,ENDFLNM,ENDFNDC,FILERNG,RNGPCE,FILENUM,FILEPCE,FILENUM,PCENUM
 NEW ADDRNGE,FNUMLNG,LPCNT,START,END,FNNEWRNG,FILELIST
 ;
 ;Check for existence of File List
 IF $G(RPT)="" SET RPT=0
 SET FILELIST=$P(LINEITEM,"^",7)
 IF RPT,($P(FILELIST,"|",1)']"") DO RPTFLADD(PKGVAL,"NOLISTF","")
 ;
 ;Check End number of Ranges for an ending decimal place
 SET RANGE=$P(LINEITEM,"^",8)
 FOR RNGPCE=1:1 SET FLERNGE=$P(RANGE,"|",RNGPCE) Q:FLERNGE=""  DO
 . SET ENDFLNM=$P(FLERNGE,"-",2)
 . SET ENDFNDC=$P(ENDFLNM,".",2)
 . IF ENDFNDC="" DO
 .. SET BEGFLNM=$P($P(RANGE,"|",RNGPCE),"-")
 .. SET $P(ENDFLNM,".",2)="9999"
 .. SET $P(FLERNG,"-",2)=ENDFLNM
 .. SET $P(RANGE,"|",RNGPCE)=BEGFLNM_FLERNG
 .. IF RPT DO RPTFLADD(PKGVAL,"RNGUPDT",BEGFLNM_FLERNG)
 ;
 ;Check file numbers in FILE list to see if included in RANGE list'
 SET FILEPCE=$P(LINEITEM,"^",7)
 FOR PCENUM=1:1 SET FILENUM=$P(FILEPCE,"|",PCENUM) Q:FILENUM=""  DO
 . SET FNNEWRNG=1
 . FOR RNGPCE=1:1 SET FLERNGE=$P(RANGE,"|",RNGPCE) Q:FLERNGE=""  DO
 .. SET BEGFLNM=$P(FLERNGE,"-",1)
 .. SET BEGFLNM=$$SETRNG(BEGFLNM,"LOWER")
 .. SET ENDFLNM=$P(FLERNGE,"-",2)
 .. SET ENDFLNM=$$SETRNG(ENDFLNM,"UPPER")
 .. IF (+FILENUM>BEGFLNM),(+FILENUM<ENDFLNM) SET FNNEWRNG=0
 . IF FNNEWRNG DO
 .. SET FNUMLNG=$L($P(FILENUM,".",2))
 .. SET (START,END)=FILENUM
 .. IF FNUMLNG=0 SET END=END_"."
 .. IF FNUMLNG<4 FOR LPCNT=1:1:4-FNUMLNG SET END=END_"9"
 .. IF FNUMLNG>3 SET END=END_"9"
 .. IF RPT DO RPTFLADD(PKGVAL,"FILE",START_"-"_END)
 .. SET:RANGE'="" RANGE=RANGE_START_"-"_END_"|"
 .. SET:RANGE="" RANGE=START_"-"_END_"|"
 Q RANGE
 ;
SETRNG(FILENUM,PLACE) ; Either add to or subtract a fraction from the range number
 ; PLACE - UPPER: Add a fraction to number
 ;       - LOWER: Subract a fraction from number
 NEW RESULT,DECVAL,PLCS,DELTA,LPCNT
 SET DECVAL=$P(FILENUM,".",2)
 SET PLCS=$L(DECVAL)
 SET DELTA="0."
 FOR LPCNT=1:1:PLCS SET DELTA=DELTA_"0"
 SET DELTA=DELTA_"1"
 IF PLACE="LOWER" SET RESULT=FILENUM-DELTA
 IF PLACE="UPPER" SET RESULT=FILENUM+DELTA
 Q RESULT
 ;
RPTFLADD(PKGVAL,TYPE,RANGE) ; Write a node in ^TMP("XTVS-FILERPT") for each file added to ranges
 ; INPUT : PKGVAL   - Package reporting from ^XTMP("XTSIZE") node
 ;         TYPE     - FILE    : File Multiple
 ;                  - HL      : High/Low range fields
 ;                  - RNGUPDT : Range Multiple
 ;                  - NOLISTF : File List Multiple not defined
 ;
 ;         RANGE    - File Range
 ;
 ; OUTPUT: Report Node added to ^TMP("XTVS-FILERPT") array
 ;
 NEW RPTARYND,NODEVAL
 SET RPTARYND=$O(^TMP("XTVS-FILERPT",$J,PKGVAL,""),-1)
 IF RPTARYND="" SET ^TMP("XTVS-FILERPT",$J,PKGVAL,1)=PKGVAL_" Package entry file number notes:" SET RPTARYND=1
 SET RPTARYND=RPTARYND+1
 SET NODEVAL=""
 IF TYPE="FILE" SET NODEVAL="    "_RANGE_"  [File Multiple added to Range Multiple]"
 IF (TYPE="HL") DO
 . IF (RANGE'["No File Ranges or High/Low Fields") SET NODEVAL="    "_RANGE_"  [Range Multiple undefined, High/Low Field range only]"
 . IF (RANGE["No File Ranges or High/Low Fields") SET NODEVAL="    Ranges Undefined ["_RANGE_"]"
 IF TYPE="RNGUPDT" SET NODEVAL="    "_RANGE_"  [Decimal on Range End extended by nine(s)]"
 IF TYPE="NOLISTF" SET NODEVAL="    No File List  [No File Multiple Entries defined]"
 ;
 SET:NODEVAL]"" ^TMP("XTVS-FILERPT",$J,PKGVAL,RPTARYND)=NODEVAL
 QUIT

A1VSLNA1 ;BHAM/MAM/GTS - VistA Package Sizing Manager; 1-JUL-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
PKGEXT() ;Entry point - Package File extract (ACTION Protocol: A1VS PKG EXTRACT CREATE ACTION)
 ;
 ; STOPKILL: 0^0  $JOB sub-array for ^XTMP("A1SIZE") did not exist and was created
 ;           0^1  $JOB sub-array for ^XTMP("A1SIZE") existed and was recreated
 ;           1^1  $JOB sub-array for ^XTMP("A1SIZE") existed and was NOT recreated
 ;
 NEW STOPKILL
 SET STOPKILL="0^0"
 IF ($D(^XTMP("A1SIZE",$JOB))) DO  QUIT:STOPKILL "1^1"  ;;If STOPKILL, do NOT delete existing ^XTMP("A1SIZE",$J) global
 . NEW X,Y,DIR
 . SET DIR("A",1)=""
 . SET DIR("A",2)="^XTMP(""A1SIZE"","_$JOB_") already exists!"
 . SET DIR("A")="Do you want to delete ^XTMP(""A1SIZE"","_$JOB_") and recreate it"
 . SET DIR("B")="NO"
 . SET DIR(0)="Y::"
 . SET STOPKILL="0^1"
 . DO ^DIR
 . IF ($D(DTOUT))!($D(DUOUT))!(($G(Y)=0)) DO
 .. DO JUSTPAWS^A1VSLAPI("^XTMP(""A1SIZE"","_$JOB_") NOT DELETED!")
 .. SET STOPKILL="1^1"
 ;
 K ^XTMP("A1SIZE",$J) S ^XTMP("A1SIZE",$J,0)=$$NOW^XLFDT_"^"_^%ZOSF("PROD")
 ;
 S VPIEN=0 F  S VPIEN=$O(^DIC(9.4,VPIEN)) Q:'VPIEN  S VPNAME=$P(^DIC(9.4,VPIEN,0),"^") DO
 . IF $P($G(^DIC(9.4,VPIEN,15002)),"^",3)'="X" DO SETXTMP ;Screen CURRENT STATUS equals NO LONGER USED from extract
 ;
 K VPNAME,VPN,VPLOW,VPHIGH,VPOTHER,VPNAT,VPRNGE
 QUIT STOPKILL
 ;
SETXTMP ; set ^XTMP global with PACKAGE data
 ;
 ; Piece 1 = Namespace
 ; Piece 2 = Lower File Number Range
 ; Piece 3 = Highest File Number Range
 ; Piece 4 = Other Namepaces separated by "|"
 ;
 NEW VPPARPKG,PARNTNME
 ;Get Package CLASS and PARENT PACKAGE
 S VPNAT=$G(^DIC(9.4,VPIEN,7)),VPNAT=$P(VPNAT,"^",3),VPPARPKG=$P($GET(^DIC(9.4,VPIEN,15002)),"^",2),PARNTNME=""
 Q:VPNAT'="I"
 S VPN=$P(^DIC(9.4,VPIEN,0),"^",2) ; PREFIX
 S (VPEXCPT,VPOTHER,VPRNGE)=""
 S VP11=$G(^DIC(9.4,VPIEN,11)),VPLOW=$P(VP11,"^"),VPHIGH=$P(VP11,"^",2) ;*LOWEST/*HIGHEST FILE NUMBERS
 ;Get ADITIONAL PREFIXES
 IF $D(^DIC(9.4,VPIEN,14)) DO
 . SET VPIEN2=0 F  S VPIEN2=$O(^DIC(9.4,VPIEN,14,VPIEN2)) Q:'VPIEN2  S VPOTHER=VPOTHER_^DIC(9.4,VPIEN,14,VPIEN2,0)_"|"
 ;Get EXCLUDED NAMESPACE
 IF $D(^DIC(9.4,VPIEN,"EX")) DO
 . SET VPIEN2=0 F  S VPIEN2=$O(^DIC(9.4,VPIEN,"EX",VPIEN2)) Q:'VPIEN2  S VPEXCPT=VPEXCPT_^DIC(9.4,VPIEN,"EX",VPIEN2,0)_"|"
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
 ..S VPFNUM=^DIC(9.4,VPIEN,15001,VPIEN2,0)
 ..S:+VPFNUM>0 ^XTMP("A1SIZE",$J,VPNAME,VPFNUM)=""
 ;
 ;Get PARENT PACKAGE field (#15003) Parent name
 IF VPPARPKG]"" DO
 .SET PARNTNME=$P($G(^DIC(9.4,VPPARPKG,0)),"^")
 ;
 S ^XTMP("A1SIZE",$J,VPNAME)=VPN_"^"_VPLOW_"^"_VPHIGH_"^"_VPOTHER_"^"_VPEXCPT_"^"_VPRNGE_"^"_PARNTNME
 QUIT
 ;
XTMPORD(XDOLRJ) ; Read ^XTMP("A1SIZE) array and create ^TMP globals for listing/reporting
 ;Parameter List data map from Package file:
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
 KILL ^TMP("A1VS-FILERPT")
 NEW LPCNT,FAMTREE,SUBSCPT,DATARY,RPT
 ;
 DO FAMINDEX(XDOLRJ) ;Reorder ^XTMP("A1SIZE") into ^TMP("A1SIZE","IDX") to indicate family tree for a package
 NEW PKGVAL,CHILDPKG,LINEITEM,FILENUM,FIRSTNUM
 SET PKGVAL=0
 FOR  SET PKGVAL=$O(^XTMP("A1SIZE",XDOLRJ,PKGVAL)) Q:PKGVAL="authentication"  QUIT:PKGVAL=""  DO
 . SET LINEITEM=""
 . SET LINEITEM=$S("ZU  |AUP |AUT |DRG |GMD |GMN |VDE |XIP "[PKGVAL:$P(PKGVAL," "),1:PKGVAL)_"^"_$P(^XTMP("A1SIZE",XDOLRJ,PKGVAL),"^",1,5)_"^^"_$P(^XTMP("A1SIZE",XDOLRJ,PKGVAL),"^",6,7) ;Also: AUT,AUP,DRG,GMD,GMN,VDE,XIP,VPFS
 . SET FILENUM=0
 . FOR  SET FILENUM=$O(^XTMP("A1SIZE",XDOLRJ,PKGVAL,FILENUM)) QUIT:FILENUM=""  Q:FILENUM'?.N  DO
 .. SET $P(LINEITEM,"^",7)=$P(LINEITEM,"^",7)_FILENUM_"|" ;ADD File List multiple to Pce 7
 . SET FAMTREE=$$LINEAGE(PKGVAL,$J)
 . KILL SUBS
 . FOR LPCNT=1:1 SET SUBSCPT=$P(FAMTREE,"^",LPCNT) QUIT:SUBSCPT=""  S SUBS(LPCNT)=SUBSCPT
 . SET DATARY=$P($NAME(^TMP("A1SIZE",$J)),")")
 . SET LPCNT=0
 . FOR  SET LPCNT=$O(SUBS(LPCNT)) QUIT:(LPCNT="")  DO
 .. SET SUBSCPT=SUBS(LPCNT)
 .. SET DATARY=DATARY_","_""_SUBSCPT
 . SET DATARY=DATARY_")"
 . ;
 . ;NOTE: RPT - future use [0: no report, 1: No Ranges in multiple, 2: Files added to Range, 3: both no files and added ranges]
 . SET RPT=3 ;;To report file changes
 . SET $P(LINEITEM,"^",8)=$$FLRNGCLN(LINEITEM,PKGVAL,RPT) ;CLEANUP File Range multiple in Pce 8
 . SET @DATARY=LINEITEM ;Set ^TMP("A1SIZE",$J) to LINEITEM
 . ; If not FILE or RANGE Multiple Entries, report High/Low File number fields
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
 KILL SUBS
 ;
 QUIT
 ;
FAMINDEX(XDOLRJ) ; Create a package family tree ^TMP global=pkg^parentpkg^grndparentpkg^etc.
 NEW PARNTPKG
 NEW FAMTREE,PKGVAL
 SET PKGVAL=0
 FOR  SET PKGVAL=$O(^XTMP("A1SIZE",XDOLRJ,PKGVAL)) Q:PKGVAL="authentication"  Q:PKGVAL=""  DO
 . SET FAMTREE=""
 . IF '$D(^TMP("A1SIZE","IDX",$J,PKGVAL)) DO
 .. SET FAMTREE=$$ANCESTRY(PKGVAL,XDOLRJ)
 .. SET ^TMP("A1SIZE","IDX",$J,PKGVAL)=FAMTREE
 QUIT
 ;
ANCESTRY(PKGVAL,XDOLRJ) ; Return list of package-parent-grandparent-etc. relationships
 NEW FAMTREE,PARENT,LASTPRNT
 SET PARENT=PKGVAL
 SET FAMTREE=$S("ZU  |AUP |AUT |DRG |GMD |GMN |VDE |XIP "[PKGVAL:$P(PKGVAL," "),1:PKGVAL) ;Cleanup Namespace returned from Forum Package file (Also: VPFS)
 FOR  QUIT:PARENT=""  SET LASTPRNT=PARENT SET PARENT=$P($G(^XTMP("A1SIZE",XDOLRJ,PARENT)),"^",7) QUIT:PARENT=LASTPRNT  QUIT:((FAMTREE["^")&(FAMTREE[PARENT))  DO
 . IF PARENT'="" DO
 .. SET FAMTREE=FAMTREE_"^"_PARENT
 QUIT FAMTREE
 ;
LINEAGE(PKG,DOLRJ) ; Return a family tree subscript string
 NEW CHKLVL,SUBLVL,SUBSCPT,FAMTREE,SUB
 SET SUBSCPT=""
 IF $D(^TMP("A1SIZE","IDX",DOLRJ,PKG)) DO
 . SET SUBSCPT=^TMP("A1SIZE","IDX",DOLRJ,PKG)
 . FOR SUBLVL=1:1 SET SUB(SUBLVL)=$P(SUBSCPT,"^",SUBLVL)  IF SUB(SUBLVL)="" KILL SUB(SUBLVL) QUIT
 . SET (SUBSCPT,SUBLVL)=""
 . FOR  SET SUBLVL=$O(SUB(SUBLVL),-1) Q:SUBLVL=""  SET SUBSCPT=SUBSCPT_SUB(SUBLVL)_""""_"^"_""""
 . SET SUBSCPT=""""_$P(SUBSCPT,"^",1,$O(SUB(SUBLVL),-1))
 QUIT SUBSCPT
 ;
FLRNGCLN(LINEITEM,PKGVAL,RPT) ;Cleanup File Ranges received from Forum Package file
 ; INPUT : LINEITEM - Value of ^XTMP("A1SIZE") node
 ;         PKGVAL   - Package reporting from ^XTMP("A1SIZE") node
 ;         RPT      - 1 : Report Range additions
 ;                    0 : Do not report Range additions
 ;
 ; File range of LineItem (pce 8) will be "cleaned up" as follows:
 ;  Any "end of range" file number that does not have a decimal end will be changed to 9999/10000 (E.G. 7 becomes 7.9999)
 ;  Any File number in the FILE number on LineItem (Pce 7) that is not in the range will be added as a range (7 becomes 7-7.9999)
 ;
 NEW RANGE,BEGFLNM,ENDFLNM,ENDFNDC,FILERNG,RNGPCE,FILENUM,FILEPCE,FILENUM,PCENUM
 NEW ADDRNGE,FNUMLNG,LPCNT,START,END,FNNEWRNG,FILELIST
 ;
 ;Check End number of Ranges for an ending decimal place
 IF $G(RPT)="" SET RPT=0
 SET FILELIST=$P(LINEITEM,"^",7)
 IF RPT,($P(FILELIST,"|",1)']"") DO RPTFLADD(PKGVAL,"NOLISTF","")
 ;
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
RPTFLADD(PKGVAL,TYPE,RANGE) ; Write a node in ^TMP("A1VS-FILERPT) for each file added to ranges
 ; INPUT : PKGVAL   - Package reporting from ^XTMP("A1SIZE") node
 ;         TYPE     - FILE    : File Multiple
 ;                  - HL      : High/Low range fields
 ;                  - RNGUPDT : Range Multiple
 ;                  - NOLISTF : File List Multiple not defined
 ;
 ;         RANGE    - File Range
 ;
 ; OUTPUT: Report Node added to ^TMP("A1VS-FILERPT") array
 ;
 NEW RPTARYND,NODEVAL
 SET RPTARYND=$O(^TMP("A1VS-FILERPT",$J,PKGVAL,""),-1)
 IF RPTARYND="" SET ^TMP("A1VS-FILERPT",$J,PKGVAL,1)=PKGVAL_" Package entry file number notes:" SET RPTARYND=1
 SET RPTARYND=RPTARYND+1
 SET NODEVAL=""
 IF TYPE="FILE" SET NODEVAL="    "_RANGE_"  [File Multiple added to Range Multiple]"
 IF (TYPE="HL") DO
 . IF (RANGE'["No File Ranges or High/Low Fields") SET NODEVAL="    "_RANGE_"  [Range Multiple undefined, High/Low Field range only]"
 . IF (RANGE["No File Ranges or High/Low Fields") SET NODEVAL="    Ranges Undefined ["_RANGE_"]"
 IF TYPE="RNGUPDT" SET NODEVAL="    "_RANGE_"  [Decimal on Range End extended by nine(s)]"
 IF TYPE="NOLISTF" SET NODEVAL="    No File List  [No File Multiple Entries defined]"
 ;
 SET:NODEVAL]"" ^TMP("A1VS-FILERPT",$J,PKGVAL,RPTARYND)=NODEVAL
 QUIT

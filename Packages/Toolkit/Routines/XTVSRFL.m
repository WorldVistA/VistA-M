XTVSRFL ;Bham FO/CML3{Albany FO/GTS} - VistA Package Sizing Manager; 27-JUN-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;;
INIT(VALMCNT,XTVPSPRM) ;;VistA Size Report entry point
 ;;INPUT:
 ;   VALMCNT  - Current Node # on ListMan ^TMP("XTVS PKG MGR RPT",$JOB) global
 ;   XTVPSPRM - Package Parameter file to report against
 ;
 ;; data variables (local, for each package)
 ;; PKGIEN = Package IEN
 ;; PKGNAME = Package NAME (.01 - $P(^(0),"^",1))
 ;; PKGPFX = Package PREFIX / NAMESPACE (1 - $P(^(0),"^",2))
 ;;
 ;; RTOT = total ROUTINEs
 ;; TLCNT = total SIZE of all ROUTINES
 ;; FTOT = total FILEs
 ;; FLDTOT = total FIELDs of all FILES
 ;; OTOT = total OPTIONs (^DIC(19,)
 ;; PTOT = total PROTOCOLs (^ORD(101,)
 ;; RPTOT = total REMOTE PROCEDUREs (^XWB(8994,)
 ;; TPLTTOT = total Fileman Templates
 ;; 
 I $G(DUZ)="" W !!,"DUZ must be defined." Q
 ;
 N X,Y,EXTDIR,DISSORT
 ;
ALL ; Select All or Single report
 W !!,"VistA Package Sizing Report",!
 S EXTDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I") ;EXTDIR = Directory storing XTMPSIZE.DAT
 N DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to display Sizing Information for ALL VistA Packages? "
 S DIR("?",1)="A Size report for ALL VistA Packages requires the..."
 S DIR("?",2)="  "_XTVPSPRM
 S DIR("?",3)="  ...file to be stored in "_EXTDIR_"."
 S DIR("?",4)=""
 S DIR("?",5)="  "_XTVPSPRM
 S DIR("?",6)=" is sourced from Package file data in Forum or other VistA instance."
 S DIR("?",7)=" The report will count package components on local VistA based on the"
 S DIR("?",8)=" parameters defined in the Package Parameter file for the package."
 S DIR("?",9)=""
 S DIR("?")="Enter Yes to report All packages; No to report a Single package."
 D ^DIR I Y'=1,Y'=0 G KWIT
 IF Y'=1 GOTO ONEPKG
 ;
SORT ; Select Sort for All report
 N DIR S DIR("A")="Select VistA Size Report"
 S DIR(0)="S^1:SORT ON PKG NAMES;2:SORT ON # OF ROUTINES - HIGH TO LOW;"
 S DIR(0)=DIR(0)_"3:SORT ON PKG ROUTINES SIZE TOTAL - HIGH TO LOW;"
 S DIR(0)=DIR(0)_"4:SORT ON PKG NAME, CARET DELIMITED DATA;"
 S DIR(0)=DIR(0)_"5:SORT ON PKG NAME INCLUDE PARENT PKG, CARET DELIMITED DATA"
 S DIR("L")="  5. Delimited (^) Data with PARENT PKG, Sorted by PACKAGE NAME"
 S DIR("L",1)="Select which method to display the package size data: "
 S DIR("L",2)=""
 S DIR("L",3)="  1. Sorted on PACKAGE NAME"
 S DIR("L",4)="  2. Sorted on NUMBER of ROUTINES (Highest to Lowest)"
 S DIR("L",5)="  3. Sorted on TOTAL ROUTINE SIZE (Highest to Lowest)"
 S DIR("L",6)="  4. Delimited (^) Data, Sorted on PACKAGE NAME"
 D ^DIR G:'Y KWIT S DISSORT=+Y
 ;
 DO LOOP(DISSORT,.VALMCNT)
 QUIT
 ;
LOOP(DISSORT,VALMCNT) ; Loop through all entries in the Package parameters file
 NEW POPERR
 SET POPERR=0
 DO OPEN^%ZISH("XTMP",EXTDIR,XTVPSPRM,"R")
 SET:POP POPERR=POP
 QUIT:POPERR
 U IO
 SET LNNUM=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 .IF LINEITEM]"" DO
 ..S LNNUM=LNNUM+1
 ..SET ^TMP("XTVS-FORUMPKG",$J,LNNUM)=LINEITEM
 D CLOSE^%ZISH("XTMP")
 ;
 DO KIDSIDX^XTVSRFL1 ;Create Prefix-Package Indicies from KIDS
 ;
 ;Create Prefix Indicies
 DO TALLYRPT(DISSORT,0)
 ;
 ;Check existence of Packages
 DO PKGFLCK
 ;
DISALL ; Set report into display array
 ; display option 4 & 5 have no formatting, and are used for creating spreadsheets,
 ; for which the following heading lines are not needed
 I (DISSORT'=4)&(DISSORT'=5) D  ;
 . DO ADD^XTVSLAPI(.VALMCNT,"VistA Application Sizing Information                               Sort Type: "_DISSORT)
 . DO ADD^XTVSLAPI(.VALMCNT," ")
 . DO ADD^XTVSLAPI(.VALMCNT,"                       Total")
 . DO ADD^XTVSLAPI(.VALMCNT,"Application             Rtn")
 . DO ADD^XTVSLAPI(.VALMCNT,"(Namespace)  Routines  Size   Files  Fields  Options  Protocols  RPCs  Templates")
 . DO ADD^XTVSLAPI(.VALMCNT,"================================================================================")
 ;
DAD ; Add report lines to display array
 NEW S3
 I DISSORT=2!(DISSORT=3) DO
 . S S3=""
 . F  S S3=$O(^TMP("XTVS-VPS0",$J,S3),-1) S D3=S3 Q:S3=""  S D1="" F  S D1=$O(^TMP("XTVS-VPS0",$J,S3,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("XTVS-VPS0",$J,S3,D1,D2)) Q:D2=""  D PDAD(DISSORT,$G(^(D2)),D1,D2,D3,.VALMCNT)
 I DISSORT=1!(DISSORT=4)!(DISSORT=5) DO
 . SET D1=""
 . ;
 . IF DISSORT'=5 DO
 .. IF DISSORT=4 DO 
 ... DO ADD^XTVSLAPI(.VALMCNT,"{package name}^{prefix}^{#rtns}^{size of rtns}^{#files}^{#fields}^{#options}^{#protocols}^{#RPCs}^{#templates}")
 .. FOR  S D1=$O(^TMP("XTVS-VPS",$J,D1)) Q:D1=""  S D2="" DO
 ... F  S D2=$O(^TMP("XTVS-VPS",$J,D1,D2)) Q:D2=""  DO
 .... D PDAD(DISSORT,$G(^(D2)),D1,D2,"",.VALMCNT)
 . ;
 . IF DISSORT=5 DO
 .. DO ADD^XTVSLAPI(.VALMCNT,"{package name}^{prefix}^{#rtns}^{size of rtns}^{#files}^{#fields}^{#options}^{#protocols}^{#RPCs}^{#templates}^{parent pkg}")
 .. S TMPSUB=""
 .. F  S TMPSUB=$O(^TMP("XTVS-VPS",$J,TMPSUB)) Q:TMPSUB=""  S D1="" DO
 ... F  S D1=$O(^TMP("XTVS-VPS",$J,TMPSUB,D1)) Q:D1=""  S D2="" DO
 .... F  S D2=$O(^TMP("XTVS-VPS",$J,TMPSUB,D1,D2)) Q:D2=""  DO
 ..... D PDAD(DISSORT,$G(^(D2)),D1,D2,"",.VALMCNT)
 ;
 KILL ^TMP("XTVS-VPS",$J),^TMP("XTVS-PREFIX-IDX",$J),^TMP("XTVS-FORUM-PFXS",$J)
 KILL ^TMP("XTVS-VPS0",$J),^TMP("XTVS-KIDSPFX-IDX",$J),^TMP("XTVS-FORUM2TMP",$J)
 KILL ^TMP("XTVS-FORUMPKG",$J),^TMP("XTVS-IDX-PKG",$J)
 ;
KWIT ; QUIT Report
 QUIT
 ;
PDAD(DISSORT,DATA,D1,D2,D3,VALMCNT) ; print actual data (finally)
 N D4,D5,D6,D7,D8,D9,D10,DATANDE,SPCT
 I (DISSORT=1)!(DISSORT=4)!(DISSORT=5) DO
 . S D4=$P(DATA,"^",2),D5=$P(DATA,"^",3),D6=$P(DATA,"^",4),D7=$P(DATA,"^",5),D8=$P(DATA,"^",6),D9=$P(DATA,"^",7),D10=$P(DATA,"^",8),D3=+DATA
 ;
 ;Following code only executes when a caret (^) delimited report is selected
 I (DISSORT=4)!(DISSORT=5) DO  QUIT  ;;Quit reporting sort types 4 & 5
 . SET DATANDE=""
 . SET DATANDE=D1_"^"_D2_"^"_D3_"^"_D4_"^"_D5_"^"_D6_"^"_D7_"^"_D8_"^"_D9_"^"_D10_$S($P(DATA,"^",9)'="":"^"_$P(DATA,"^",9),1:"")_$S($P(DATA,"^",10)'="":"^"_$P(DATA,"^",10),1:"")
 . DO ADD^XTVSLAPI(.VALMCNT,DATANDE)
 ;
 ;Following code only executes when user readable report selected (sort types 1, 2, or 3)
 I DISSORT=2!(DISSORT=3) DO
 . S D5=$P(DATA,"^",2),D6=$P(DATA,"^",3),D7=$P(DATA,"^",4),D8=$P(DATA,"^",5),D9=$P(DATA,"^",6),D10=$P(DATA,"^",7)
 . S:DISSORT=2 D4=+DATA
 . S:DISSORT=3 D4=D3,D3=+DATA
 ;
 DO ADD^XTVSLAPI(.VALMCNT,D1)
 SET DATANDE=""
 SET DATANDE="("_D2_")"
 FOR SPCT=1:1:11-$L(DATANDE) SET DATANDE=DATANDE_" " ;Space out 2nd data element
 SET DATANDE=DATANDE_$J(D3,6)_"   "_$J(D4,9)_" "_$J(D5,4)_"  "_$J(D6,6)_"   "_$J(D7,6)_"    "_$J(D8,6)_" "_$J(D9,6)_"  "_$J(D10,6)
 DO ADD^XTVSLAPI(.VALMCNT,DATANDE)
 DO ADD^XTVSLAPI(.VALMCNT,"--------------------------------------------------------------------------------")
 QUIT
 ;
TALLYRPT(DISSORT,XTVSSILN,SELPKGNM) ; Compile component totals
 ; INPUT:
 ;   DISSORT -
 ;       1: Sorted on PACKAGE NAME [Default]
 ;       2: Sorted on NUMBER of ROUTINES (Highest to Lowest)
 ;       3: Sorted on TOTAL ROUTINE SIZE (Highest to Lowest)
 ;       4: Delimited (^) Data, Sorted on PACKAGE NAME
 ;       5: Delimited (^) Data with PARENT PKG, Sorted by PACKAGE NAME
 ;
 ;   XTVSSILN - Silent mode
 ;       0: Show HangChar
 ;       1: Silent [Default]
 ;
 ;   SELPKGNM - Selected package name
 ;               Define when called from ONEPKGSZ^XTVSSVR to only check & send message
 ;               when selected package is missing
 ;
 ;   Requires the following TMP globals are defined before execution:
 ;     ^TMP("XTVS-FORUMPKG",$J)
 ;     ^TMP("XTVS-KIDSPFX-IDX",$J)
 ;
 ;Create Prefix Indicies
 ;
 IF $GET(DISSORT)="" SET DISSORT=1
 IF $GET(XTVSSILN)'=0 SET XTVSSILN=1
 ;
 NEW D1,D2,D3,XTCHAR,TMPSUB,PCENUM,LINEITEM,PKGNAME,PKGPFX,LINECNT
 NEW PREFIX,PKGIEN,FFCTRSLT
 SET (D1,D2,D3)=0
 ;
 ; Create ^TMP("XTVS-IDX-PKG",$J) array for MULTX^XTVSRFL1
 SET TMPSUB=0
 FOR  SET TMPSUB=$O(^TMP("XTVS-FORUMPKG",$J,TMPSUB)) QUIT:TMPSUB=""  DO
 .SET LINEITEM=^TMP("XTVS-FORUMPKG",$J,TMPSUB)
 .SET PKGNAME=$P(LINEITEM,"^")
 .SET PKGPFX=$P(LINEITEM,"^",2)
 .SET ^TMP("XTVS-PREFIX-IDX",$J,PKGPFX,PKGNAME)="" ;Prefix,Pkg-Name
 .SET ^TMP("XTVS-FORUM-PFXS",$J,PKGPFX)="" ;Prefix
 .; Following ^TMP for PACKAGES in Param file: Prefix,Pkg-Name = 1 when KIDS Prefix, Null when not KIDS Prefix
 .IF '$D(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)) SET ^TMP("XTVS-IDX-PKG",$J,PKGPFX,PKGNAME)=""
 .IF $D(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)) SET ^TMP("XTVS-IDX-PKG",$J,PKGPFX,PKGNAME)=$S(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)=PKGNAME:1,1:"")
 .;
 .SET ADDPRFX=$P(LINEITEM,"^",5)
 .SET LPCNT=0
 .FOR PCENUM=1:1 SET PREFIX=$P(ADDPRFX,"|",PCENUM) Q:PREFIX=""  DO
 .. SET ^TMP("XTVS-FORUM-PFXS",$J,PREFIX)="" ;Prefix
 .. ; Following ^TMP for PACKAGES in Param file : Prefix,Pkg-Name = 1 when KIDS Prefix, Null when not KIDS Prefix
 .. SET ^TMP("XTVS-IDX-PKG",$J,PREFIX,PKGNAME)=$S($D(^TMP("XTVS-KIDSPFX-IDX",$J,PREFIX)):1,1:"")
 ; 
 ;Count components - ^TMP Global loop
 WRITE:'XTVSSILN !,"Compiling component totals for selected Package data file... "
 SET (TMPSUB,XTCHAR)=0
 FOR  SET TMPSUB=$O(^TMP("XTVS-FORUMPKG",$J,TMPSUB)) QUIT:TMPSUB=""  DO:'XTVSSILN HANGCHAR^XTVSLAPI(.XTCHAR) DO
 .SET PKGIEN=0
 .SET LINEITEM=^TMP("XTVS-FORUMPKG",$J,TMPSUB)
 .SET PKGNAME=$P(LINEITEM,"^")
 .;
 .IF PKGNAME["''" DO
 .. IF $D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))) SET PKGIEN=$O(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""),""))
 .. IF '$D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))),$D(^DIC(9.4,"B",PKGNAME)) SET PKGIEN=$O(^DIC(9.4,"B",PKGNAME,""))
 .IF PKGNAME'["''" SET PKGIEN=+$O(^DIC(9.4,"B",PKGNAME,""))
 .;
 .IF (PKGIEN=0),(PKGNAME=$G(SELPKGNM)) DO RMTPKGMG^XTVSLAPI("Package: "_PKGNAME_" ...not found!  Protocol count may be incorrect.",$S($G(XTVSSNDR)]"":XTVSSNDR,1:$$NETNAME^XMXUTIL(DUZ)),PKGNAME)
 .DO COMPNTCT(PKGNAME,PKGIEN,LINEITEM,DISSORT)
 ;
 I DISSORT=2 S D1="" F  S D1=$O(^TMP("XTVS-VPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("XTVS-VPS",$J,D1,D2)) Q:D2=""  S X=$G(^(D2)),^TMP("XTVS-VPS0",$J,+X,D1,D2)=$P(X,"^",2,8)
 I DISSORT=3 S D1="" F  S D1=$O(^TMP("XTVS-VPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("XTVS-VPS",$J,D1,D2)) Q:D2=""  S X=$G(^(D2)),^TMP("XTVS-VPS0",$J,+$P(X,"^",2),D1,D2)=+X_"^"_$P(X,"^",3,8)
 ;
 QUIT
 ;
COMPNTCT(PKGNAME,PKGIEN,LINEITEM,DISSORT) ;Count components for package
 ;Input:
 ;  PKGNAME  - Package Name
 ;  PKGIEN   - Package File IEN for Package
 ;  LINEITEM - Package Parameters from Parameter file
 ;  DISSORT  - Report Type (Sort) selected
 ;
 NEW APFXLST,RPFXLST,PCENUM,PKGPFX,LPA,APFX,RPFX,ADDPRFX,PRNTPKG
 NEW FTOT,OTOT,PTOT,RPTOT,RTOT,TLCNT,TPLTTOT,FLDTOT
 ;
 SET PKGPFX=$P(LINEITEM,"^",2)
 ;
 SET (FTOT,FLDTOT,OTOT,PTOT,RPTOT,RTOT,TLCNT,TPLTTOT)=0
 ;Count files & fields - entry in ^TMP global loop
 SET FFCTRSLT=$$COUNTFLS^XTVSRFL1(PKGPFX,$P(LINEITEM,"^",3),$P(LINEITEM,"^",4),$P(LINEITEM,"^",7),$P(LINEITEM,"^",8)) ; Files^Fields
 SET FTOT=$P(FFCTRSLT,"^") ;Extract File ctr
 SET FLDTOT=$P(FFCTRSLT,"^",2) ;Extract Field ctr
 ;
 ;Define Excepted & Additional Prefix Arrays
 KILL RDP,ADP
 SET RPFXLST=$P(LINEITEM,"^",6)
 SET (RDP,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET RPFX=($P(RPFXLST,"|",PCENUM)) QUIT:RPFX']""  DO
 . SET RDP=RDP+1,RDP(RDP)=RPFX ;RDP = Excepted Namespace
 ;
 SET APFXLST=$P(LINEITEM,"^",5)
 SET (ADP,PCENUM)=0
 ; NOTE: MULTX screens a Primary or KIDS Prefix for another package from inclusion as an added prefix to current package
 FOR  SET PCENUM=PCENUM+1 SET APFX=($P(APFXLST,"|",PCENUM)) QUIT:APFX=""  IF $$MULTX^XTVSRFL1(APFX,PKGNAME) SET ADP=ADP+1 SET ADP(ADP)=APFX ;ADP = Added Namespace
 ;
 SET RTOT=$$ROUTINE^XTVSRFL1(PKGPFX,.TLCNT,.RDP,.ADP) ;Count routines
 I ADP F LPA=1:1:ADP I ADP(LPA)'="" S RTOT=RTOT+$$ROUTINE^XTVSRFL1(ADP(LPA),.TLCNT,.RDP,.ADP) ;ADP(LPA) added prefixes called individually
 ;
 DO CNTR^XTVSRFL1("^DIC(19,",.OTOT,PKGPFX,.RDP,.ADP) ;Count Options
 I ADP F LPA=1:1:ADP I ADP(LPA)'="" D CNTR^XTVSRFL1("^DIC(19,",.OTOT,ADP(LPA),.RDP,.ADP)
 ;
 SET PTOT=$$PROTOCOL^XTVSRFL1(PKGPFX,PKGIEN,.RDP) ;Count Protocols
 I ADP F LPA=1:1:ADP I ADP(LPA)'=""  SET PTOT=PTOT+$$PROTOCOL^XTVSRFL1(ADP(LPA),PKGIEN,.RDP)
 ;
 DO CNTR^XTVSRFL1("^XWB(8994,",.RPTOT,PKGPFX,.RDP,.ADP) ;Count Remote Procedure Calls
 I ADP F LPA=1:1:ADP I ADP(LPA)'="" D CNTR^XTVSRFL1("^XWB(8994,",.RPTOT,ADP(LPA),.RDP,.ADP)
 ;
 ; Count Templates
 DO CNTR^XTVSRFL1("^DIPT(",.TPLTTOT,PKGPFX,.RDP,.ADP) ;Print Templates
 I ADP F LPA=1:1:ADP I ADP(LPA)'="" D CNTR^XTVSRFL1("^DIPT(",.TPLTTOT,ADP(LPA),.RDP,.ADP)
 ;
 DO CNTR^XTVSRFL1("^DIBT(",.TPLTTOT,PKGPFX,.RDP,.ADP) ;Sort Templates
 I ADP F LPA=1:1:ADP I ADP(LPA)'="" D CNTR^XTVSRFL1("^DIBT(",.TPLTTOT,ADP(LPA),.RDP,.ADP)
 ;
 DO CNTR^XTVSRFL1("^DIE(",.TPLTTOT,PKGPFX,.RDP,.ADP) ;Input Templates
 I ADP F LPA=1:1:ADP I ADP(LPA)'="" D CNTR^XTVSRFL1("^DIE(",.TPLTTOT,ADP(LPA),.RDP,.ADP)
 ;
 SET:DISSORT'=5 ^TMP("XTVS-VPS",$J,PKGNAME,PKGPFX)=RTOT_"^"_TLCNT_"^"_FTOT_"^"_FLDTOT_"^"_OTOT_"^"_PTOT_"^"_RPTOT_"^"_TPLTTOT
 IF DISSORT=5 DO
 .SET PRNTPKG=$P(LINEITEM,"^",9)
 .SET ^TMP("XTVS-VPS",$J,TMPSUB,PKGNAME,PKGPFX)=RTOT_"^"_TLCNT_"^"_FTOT_"^"_FLDTOT_"^"_OTOT_"^"_PTOT_"^"_RPTOT_"^"_TPLTTOT_$S(PRNTPKG'=""&PRNTPKG'=PKGNAME:"^"_PRNTPKG,1:"")_$S($P(LINEITEM,"^",10)'="":"^"_$P(LINEITEM,"^",10),1:"")
 ;
 KILL ADP,RDP
 ;
 QUIT
 ;
PKGFLCK ; Check for Package File entries matching Parameter names, send report message
 ;Requires the ^TMP("XTVS-FORUMPKG",$J) global
 ;
 NEW TMPSUB,PKGIEN,PKGNAME,MSGNDENM
 KILL ^TMP("XTVS-LOCAL-ERROR",$JOB)
 SET (MSGNDENM,TMPSUB)=0
 FOR  SET TMPSUB=$O(^TMP("XTVS-FORUMPKG",$J,TMPSUB)) QUIT:TMPSUB=""  DO
 . SET PKGIEN=0
 . SET PKGNAME=$P(^TMP("XTVS-FORUMPKG",$J,TMPSUB),"^")
 . ;
 . IF PKGNAME["''" DO
 .. IF $D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))) SET PKGIEN=$O(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""),""))
 .. IF '$D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))),$D(^DIC(9.4,"B",PKGNAME)) SET PKGIEN=$O(^DIC(9.4,"B",PKGNAME,""))
 . IF PKGNAME'["''" SET PKGIEN=+$O(^DIC(9.4,"B",PKGNAME,""))
 . ;
 . IF PKGIEN=0 DO 
 .. IF MSGNDENM=0 DO
 ... SET ^TMP("XTVS-LOCAL-ERROR",$JOB,1)="Package Size Report warning for "_^%ZOSF("PROD")_"."
 ... SET ^TMP("XTVS-LOCAL-ERROR",$JOB,2)="  The following package(s) are not found on this VistA."
 ... SET ^TMP("XTVS-LOCAL-ERROR",$JOB,3)="       (The number of protocols reported may be incorrect.)"
 .. SET MSGNDENM=$ORDER(^TMP("XTVS-LOCAL-ERROR",$JOB,""),-1)+1
 .. SET ^TMP("XTVS-LOCAL-ERROR",$JOB,MSGNDENM)="  - "_PKGNAME
 ;
 IF $D(^TMP("XTVS-LOCAL-ERROR",$JOB)) DO
 . NEW XMDUZ,XMY,XMTEXT,XMSUB
 . SET XMDUZ="VistA Package Size Analysis Manager"
 . SET XMY($$NETNAME^XMXUTIL(DUZ))=""
 . SET XMTEXT="^TMP(""XTVS-LOCAL-ERROR"","_$JOB_","
 . SET XMSUB="PACKAGE REPORT NOTICE ("_^%ZOSF("PROD")_") ; Report process warning."
 . DO ^XMD
 . IF +XMZ'>0 DO
 .. SET ERRTEXT="'Package Report Notcie' FAILED to return to "_$$NETNAME^XMXUTIL(DUZ)_"."
 .. DO APPERROR^%ZTER("WRERR^XTVSSVR : Package extract error")
 ;
 KILL ^TMP("XTVS-LOCAL-ERROR",$JOB)
 QUIT
 ;
ONEPKG ; Select a package to report
 NEW PKGNAME,LINEITEM
 KILL ^TMP("XTVS-PARAM-CAP",$J),^TMP("XTVS-PREFIX-IDX",$J),^TMP("XTVS-FORUM-PFXS",$J),^TMP("XTVS-IDX-PKG",$J)
 DO OPEN^%ZISH("XTMP",EXTDIR,XTVPSPRM,"R")
 U IO
 SET VALMCNT=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO SCAPARY^XTVSLP(LINEITEM) ;Creates ^TMP("XTVS-PARAM-CAP",$J) array
 DO CLOSE^%ZISH("XTMP")
 ;
 DO KIDSIDX^XTVSRFL1 ;Create Prefix-Package Indicies from KIDS [^TMP("XTVS-KIDSPFX-IDX")]
 ;
 SET PKGNAME=$$SELPKG^XTVSLPDC(0) ; Select the package to report
 ;
 IF PKGNAME=0 W !!,"VistA Package Not Selected!"
 IF PKGNAME'=0 DO
 . DO PARAMIDX^XTVSRFL1 ;Create Prefix Indicies
 . ;
 . DO ONERPT^XTVSRFL1(PKGNAME,.VALMCNT) ;Report stat's for a single package
 ;
 KILL ^TMP("XTVS-PREFIX-IDX",$J),^TMP("XTVS-FORUM-PFXS",$J),^TMP("XTVS-KIDSPFX-IDX",$J)
 KILL ^TMP("XTVS-PARAM-CAP",$J),^TMP("XTVS-IDX-PKG",$J)
 QUIT

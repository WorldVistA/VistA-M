A1VSRFL ;Bham FO/CML3{Albany FO/GTS} - VistA Package Sizing Manager; 27-JUN-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;;
INIT(VALMCNT,A1VPSPRM) ;;
 ;;INPUT:
 ;   VALMCNT  - Current Node # on ListMan ^TMP("A1VS PKG MGR RPT",$JOB) global
 ;   A1VPSPRM - Package Parameter file to report against
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
 ;; PRCTOT = total PROTOCOLs (^ORD(101,)
 ;; RPTOT = total REMOTE PROCEDUREs (^XWB(8994,)
 ;; TPLTTOT = total Fileman Templates
 ;; 
 I $G(DUZ)="" W !!,"DUZ must be defined." Q
 ;
 N X,Y,EXTDIR,DISSORT
 ;
ALL ;
 W !!,"VistA Package Sizing Report",!
 S EXTDIR=$$GET^XPAR("SYS","A1VS PACKAGE MGR DEFAULT DIR",1,"I") ;EXTDIR = Directory storing XTMPSIZE.DAT
 N DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to display Sizing Information for ALL VistA Packages? "
 S DIR("?",1)="A Size report for ALL VistA Packages requires the "_A1VPSPRM_"file"
 S DIR("?",2)=" to be stored in "_EXTDIR_"."
 S DIR("?",3)=A1VPSPRM_" is an extract of Package file data from Forum or other VistA."
 S DIR("?",4)=" Reporting a single package will count components on VistA based on"
 S DIR("?",5)=" the local VistA Package file parameters defined for the package."
 S DIR("?",6)=""
 S DIR("?")="Enter Yes to report All packages; No to report a Single package."
 D ^DIR I Y'=1,Y'=0 G KWIT
 IF Y'=1 GOTO ONEPKG
 ;
SORT ;
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
 DO LOOP(.VALMCNT)
 QUIT
 ;
LOOP(VALMCNT) ; Loop through all entries in the Package parameters file
 KILL ^TMP("ZZVPS",$J),^TMP("A1VS-FORUMPKG",$J),^TMP("A1VS-PREFIX-IDX",$J),^TMP("A1VS-FORUM-PFXS",$J)
 KILL ^TMP("ZZVPS0",$J),^TMP("A1VS-IDX-PKG",$J),^TMP("A1VS-KIDSPFX-IDX",$J)
 NEW D1,D2,D3,POPERR,LNNUM,A1CHAR,TMPSUB,APFXLST,RPFXLST,PCENUM,LINEITEM,PKGNAME,PKGPFX
 NEW APFX,RPFX,ADDPRFX,PREFIX,PRNTPKG,FTOT,OTOT,PTOT,RPTOT,RTOT,TLCNT,TPLTTOT,FLDTOT,PKGIEN
 SET (D1,D2,D3)=0
 SET POPERR=0
 DO OPEN^%ZISH("XTMP",EXTDIR,A1VPSPRM,"R")
 SET:POP POPERR=POP
 QUIT:POPERR
 U IO
 SET LNNUM=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 .IF LINEITEM]"" DO
 ..S LNNUM=LNNUM+1
 ..SET ^TMP("A1VS-FORUMPKG",$J,LNNUM)=LINEITEM
 D CLOSE^%ZISH("XTMP")
 ;
 DO KIDSIDX^A1VSRFL1() ;Create Prefix-Package Indicies from KIDS
 ;
 ;Create Prefix Indicies
 SET TMPSUB=0
 FOR  SET TMPSUB=$O(^TMP("A1VS-FORUMPKG",$J,TMPSUB)) QUIT:TMPSUB=""  DO
 .SET LINEITEM=^TMP("A1VS-FORUMPKG",$J,TMPSUB)
 .SET PKGNAME=$P(LINEITEM,"^")
 .SET PKGPFX=$P(LINEITEM,"^",2)
 .SET ^TMP("A1VS-PREFIX-IDX",$J,PKGNAME,PKGPFX)="" ;Pkg-Name,Prefix
 .SET ^TMP("A1VS-FORUM-PFXS",$J,PKGPFX)="" ;Prefix
 .SET ^TMP("A1VS-IDX-PKG",$J,$P(LINEITEM,"^",2),$P(LINEITEM,"^"))=$S($D(^TMP("A1VA-KIDSPFX-IDX",$J,$P(LINEITEM,"^",2))):1,1:"") ;Prefix,Pkg-Name ;GTS - TO DO: Determine if want this Index
 .;
 .SET ADDPRFX=$P(LINEITEM,"^",5)
 .SET LPCNT=0
 .FOR PCENUM=1:1 SET PREFIX=$P(ADDPRFX,"|",PCENUM) Q:PREFIX=""  DO
 .. SET ^TMP("A1VS-PREFIX-IDX",$J,$P(LINEITEM,"^"),PREFIX)="" ;Pkg-Name,Prefix
 .. SET ^TMP("A1VS-FORUM-PFXS",$J,PREFIX)="" ;Prefix
 .. SET ^TMP("A1VS-IDX-PKG",$J,PREFIX,$P(LINEITEM,"^"))="" ;Prefix,Pkg-Name (add Prefix) ;GTS - TO DO: Determine if want this Index
 ;
 ;Count components - ^TMP Global loop
 WRITE !,"Compiling component totals for selected Package data file... "
 SET (TMPSUB,A1CHAR)=0
 FOR  SET TMPSUB=$O(^TMP("A1VS-FORUMPKG",$J,TMPSUB)) QUIT:TMPSUB=""  DO HANGCHAR^A1VSLAPI(.A1CHAR) DO
 .SET LINEITEM=^TMP("A1VS-FORUMPKG",$J,TMPSUB)
 .SET PKGNAME=$P(LINEITEM,"^")
 .SET PKGIEN=$O(^DIC(9.4,"B",PKGNAME,""))
 .SET PKGPFX=$P(LINEITEM,"^",2)
 .SET (FTOT,OTOT,PTOT,RPTOT,RTOT,TLCNT,TPLTTOT)=0,FLDTOT="TBD"
 .;
 .;Count files - entry in ^TMP global loop
 .SET FTOT=$$COUNTFLS^A1VSRFL1(PKGPFX,$P(LINEITEM,"^",3),$P(LINEITEM,"^",4),$P(LINEITEM,"^",7),$P(LINEITEM,"^",8))
 .;
 .;Define Excepted & Additional Prefix Arrays
 .KILL RDP,ADP
 .SET RPFXLST=$P(LINEITEM,"^",6)
 .SET (RDP,PCENUM)=0
 .FOR  SET PCENUM=PCENUM+1 SET RPFX=($P(RPFXLST,"|",PCENUM)) QUIT:RPFX']""  DO
 .. SET RDP=RDP+1,RDP(RPFX)="" ;RDP = Excepted Namespace
 .;
 .SET APFXLST=$P(LINEITEM,"^",5)
 .SET (ADP,PCENUM)=0
 .;
 .; NOTE: MULTX will prevent a Primary Prefix for another package from being included as an added prefix to current package
 .FOR  SET PCENUM=PCENUM+1 SET APFX=($P(APFXLST,"|",PCENUM)) QUIT:APFX']""  S:$$MULTX^A1VSRFL1(APFX,PKGNAME) ADP=ADP+1,ADP(APFX)="" ;ADP = Added Namespace
 .;
 .SET RTOT=$$ROUTINE^A1VSRFL1(PKGPFX,.TLCNT,.RDP,.ADP)
 .;
 .SET OTOT=$$OPTION^A1VSRFL1(PKGPFX,PKGNAME,.RDP)
 .SET ADDPRFX=""
 .FOR  SET ADDPRFX=$O(ADP(ADDPRFX)) Q:ADDPRFX=""  SET OTOT=OTOT+$$OPTION^A1VSRFL1(ADDPRFX,PKGNAME,.RDP)
 .;
 .SET PTOT=$$PROTOCOL^A1VSRFL1(PKGPFX,PKGIEN,.RDP,.ADP)  ;;Should this loop on Prefix or is Package pointer ok?  ;;PKGIEN would not be set for FORUM packages not on local PKG file
 .DO CNTR^A1VSRFL1("^XWB(8994,",.RPTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Remote Procedure Calls
 .DO CNTR^A1VSRFL1("^DIPT(",.TPLTTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Print Templates
 .DO CNTR^A1VSRFL1("^DIBT(",.TPLTTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Sort Templates
 .DO CNTR^A1VSRFL1("^DIE(",.TPLTTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Input Templates
 .;
 .SET:DISSORT'=5 ^TMP("ZZVPS",$J,PKGNAME,PKGPFX)=RTOT_"^"_TLCNT_"^"_FTOT_"^^"_OTOT_"^"_PTOT_"^"_RPTOT_"^"_TPLTTOT
 .IF DISSORT=5 DO
 ..SET PRNTPKG=$P(LINEITEM,"^",9)
 ..SET ^TMP("ZZVPS",$J,TMPSUB,PKGNAME,PKGPFX)=RTOT_"^"_TLCNT_"^"_FTOT_"^^"_OTOT_"^"_PTOT_"^"_RPTOT_"^"_TPLTTOT_$S(PRNTPKG'=""&PRNTPKG'=PKGNAME:"^"_PRNTPKG,1:"")_$S($P(LINEITEM,"^",10)'="":"^"_$P(LINEITEM,"^",10),1:"")
 ;
 I DISSORT=2 S D1="" F  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  S X=$G(^(D2)),^TMP("ZZVPS0",$J,+X,D1,D2)=$P(X,"^",2,8)
 I DISSORT=3 S D1="" F  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  S X=$G(^(D2)),^TMP("ZZVPS0",$J,+$P(X,"^",2),D1,D2)=+X_"^"_$P(X,"^",3,8)
 ;
DISALL ;
 ; display option 4 & 5 have no formatting, and are used for creating spreadsheets,
 ; for which the following heading lines are not needed
 I (DISSORT'=4)&(DISSORT'=5) D  ;
 . DO ADD^A1VSLAPI(.VALMCNT,"VistA Application Sizing Information                               Sort Type: "_DISSORT)
 . DO ADD^A1VSLAPI(.VALMCNT," ")
 . DO ADD^A1VSLAPI(.VALMCNT,"                       Total")
 . DO ADD^A1VSLAPI(.VALMCNT,"Application             Rtn")
 . DO ADD^A1VSLAPI(.VALMCNT,"(Namespace)  Routines  Size   Files  Fields  Options  Protocols  RPCs  Templates")
 . DO ADD^A1VSLAPI(.VALMCNT,"================================================================================")
 ;
DAD ;
 NEW S3
 I DISSORT=2!(DISSORT=3) S S3="" F  S S3=$O(^TMP("ZZVPS0",$J,S3),-1) S D3=S3 Q:S3=""  S D1="" F  S D1=$O(^TMP("ZZVPS0",$J,S3,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS0",$J,S3,D1,D2)) Q:D2=""  D PDAD(DISSORT,$G(^(D2)),D1,D2,D3,.VALMCNT)
 I DISSORT=1!(DISSORT=4)!(DISSORT=5) DO
 . SET D1=""
 . ;
 . IF DISSORT'=5 DO
 .. IF DISSORT=4 DO 
 ... DO ADD^A1VSLAPI(.VALMCNT,"{package name}^{prefix}^{#rtns}^{size of rtns}^{#files}^{#fields}^{#options}^{#protocols}^{#RPCs}^{#templates}")
 .. FOR  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" DO
 ... F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  DO
 .... D PDAD(DISSORT,$G(^(D2)),D1,D2,"",.VALMCNT)
 . ;
 . IF DISSORT=5 DO
 .. DO ADD^A1VSLAPI(.VALMCNT,"{package name}^{prefix}^{#rtns}^{size of rtns}^{#files}^{#fields}^{#options}^{#protocols}^{#RPCs}^{#templates}^{parent pkg}")
 .. S TMPSUB=""
 .. F  S TMPSUB=$O(^TMP("ZZVPS",$J,TMPSUB)) Q:TMPSUB=""  S D1="" DO
 ... F  S D1=$O(^TMP("ZZVPS",$J,TMPSUB,D1)) Q:D1=""  S D2="" DO
 .... F  S D2=$O(^TMP("ZZVPS",$J,TMPSUB,D1,D2)) Q:D2=""  DO
 ..... D PDAD(DISSORT,$G(^(D2)),D1,D2,"",.VALMCNT)
 ;
 KILL ^TMP("ZZVPS",$J),^TMP("A1VS-FORUMPKG",$J),^TMP("A1VS-PREFIX-IDX",$J),^TMP("A1VS-FORUM-PFXS",$J)
 KILL ^TMP("ZZVPS0",$J),^TMP("A1VS-IDX-PKG",$J),^TMP("A1VS-KIDSPFX-IDX",$J),^TMP("A1VS-FORUM2TMP",$J)
 KILL ADP,RDP
 ;
KWIT ; QUIT Report
 QUIT
 ;
 ;Report APIs
 ; ^TMP("A1VS-IDX-PKG",$J,PREFIX,PKGNME)="" OR 1  ; 1 if Main Prefix for Package
 ;
PDAD(DISSORT,DATA,D1,D2,D3,VALMCNT) ; print actual data (finally)
 N D4,D5,D6,D7,D8,D9,D10,DATANDE,SPCT
 S D6="TBD"
 I (DISSORT=1)!(DISSORT=4)!(DISSORT=5) DO
 . ;N D3
 . S D4=$P(DATA,"^",2),D5=$P(DATA,"^",3),D7=$P(DATA,"^",5),D8=$P(DATA,"^",6),D9=$P(DATA,"^",7),D10=$P(DATA,"^",8),D3=+DATA
 ;
 ;Following code only executes when a caret (^) delimited report is selected
 I (DISSORT=4)!(DISSORT=5) DO  QUIT  ;;Quit reporting sort types 4 & 5
 . SET DATANDE=""
 . SET DATANDE=D1_"^"_D2_"^"_D3_"^"_D4_"^"_D5_"^"_D6_"^"_D7_"^"_D8_"^"_D9_"^"_D10_$S($P(DATA,"^",9)'="":"^"_$P(DATA,"^",9),1:"")_$S($P(DATA,"^",10)'="":"^"_$P(DATA,"^",10),1:"")
 . DO ADD^A1VSLAPI(.VALMCNT,DATANDE)
 ;
 ;Following code only executes when user readable report selected (sort types 1, 2, or 3)
 I DISSORT=2!(DISSORT=3) DO
 . S D5=$P(DATA,"^",2),D7=$P(DATA,"^",4),D8=$P(DATA,"^",5),D9=$P(DATA,"^",6),D10=$P(DATA,"^",7)
 . S:DISSORT=2 D4=+DATA
 . S:DISSORT=3 D4=D3,D3=+DATA
 ;
 DO ADD^A1VSLAPI(.VALMCNT,D1)
 SET DATANDE=""
 SET DATANDE="("_D2_")"
 FOR SPCT=1:1:11-$L(DATANDE) SET DATANDE=DATANDE_" " ;Space out 2nd data element
 SET DATANDE=DATANDE_$J(D3,6)_"   "_$J(D4,9)_" "_$J(D5,4)_"  "_$J(D6,6)_"   "_$J(D7,6)_"    "_$J(D8,6)_" "_$J(D9,6)_"  "_$J(D10,6)
 DO ADD^A1VSLAPI(.VALMCNT,DATANDE)
 DO ADD^A1VSLAPI(.VALMCNT,"--------------------------------------------------------------------------------")
 QUIT
 ;
ONEPKG ; Select a package to report
 NEW CAPNODE,PKGNAME
 KILL ^TMP("A1VS-PARAM-CAP",$J)
 DO OPEN^%ZISH("XTMP",EXTDIR,A1VPSPRM,"R")
 U IO
 SET (CAPNODE,VALMCNT)=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO SCAPARY^A1VSLP(LINEITEM,.CAPNODE) ;Creates ^TMP("A1VS-PARAM-CAP",$J) array
 D CLOSE^%ZISH("XTMP")
 ;
 SET PKGNAME=$$SELPKG^A1VSLPDC(0) ; Select the package to report
 DO ONERPT^A1VSRFL1(PKGNAME,.VALMCNT) ;Report stat's for a single package
 ;
 KILL ^TMP("A1VS-PARAM-CAP",$J)
 QUIT

ZZVPS ; Bham FO/CML3/gts - VistA Package Sizing; ; 02 Mar 2016  9:05 AM
 ;;
 ;;
INIT ;;
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
 ;; 
 I $G(DUZ)="" W !!,"DUZ must be defined." Q
 ;
 N X,Y
 ;
ALL ;
 W !!,"VistA Package Sizing Report",!
 N DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to print Sizing Information for ALL VistA Packages? "
 D ^DIR I Y'=1,Y'=0 G QUIT
 I Y'=1 G SELPKG
 ;;S VPSALL=Y ;TO DO: GTS - REMOVE if not needed
 ;
SORT ;
 N DIR S DIR("A")="Select Display Method"
 S DIR(0)="S^1:SORTED BY PKG NAMES;2:SORTED BY NUMBER OF ROUTINES - HIGH TO LOW;3:SORTED BY TOTAL SIZE OF PKG ROUTINES - HIGH TO LOW;4:SORTED BY PKG NAME, DATA DELIMITED (BY CARET), NO ADDED SPACING"
 S DIR("L")="  4. Delimited (^) Data, Sorted by PACKAGE NAME"
 S DIR("L",1)="Select which method to display the package data: "
 S DIR("L",2)=""
 S DIR("L",3)="  1. Sorted by PACKAGE NAME"
 S DIR("L",4)="  2. Sorted by NUMBER of ROUTINES (Highest to Lowest)"
 S DIR("L",5)="  3. Sorted by TOTAL ROUTINE SIZE (Highest to Lowest)"
 D ^DIR G:'Y QUIT S DISSORT=+Y
 ;
DEVICE ;
 K %ZIS,IO("Q"),IOP S %ZIS="MQ",%ZIS("B")=""
 NEW CRTHOST,FILENME,STORPATH
 SET (CRTHOST,FILENME,STORPATH)=""
 IF DISSORT=4 SET CRTHOST=$$CHKHOST()
 IF CRTHOST="YES" DO 
 . DO SELFILE(.FILENME,.STORPATH)
 . IF (FILENME="")!(STORPATH="") DO FILABORT(.CRTHOST,.FILENME,.STORPATH) SET CRTHOST="NO"
 . IF (FILENME]""),(STORPATH]"") DO LOOP
 ;
 IF ((DISSORT=4)&(CRTHOST="NO"))!(DISSORT'=4) DO
 . W !!,"It will take a considerable amount of time to run this report for ALL",!,"PACKAGES as you have requested.  Therefore it is highly recommended that",!,"you QUEUE this report.  The report can be queued to run NOW and queuing "
 . W "this",!,"report will free up your terminal, allowing you to continue working while",!,"this report runs."
 . W ! D ^%ZIS I POP D HOME^%ZIS W !,"NO DEVICE SELECTED." G QUIT
 . I $D(IO("Q")) D  G QUIT
 .. S ZTRTN="LOOP^ZZVPS",ZTDESC="VistA Application Sizing Display" ;Invoke Loop for report of All packages
 .. S ZTSAVE("*")="" D ^%ZTLOAD W !!,"Display ",$S($D(ZTSK)#2:"Queued.",1:"Aborted.")
 . I '$D(IO("Q")) DO LOOP^ZZVPS
 QUIT
 ;
LOOP ;
 K ^TMP("ZZVPS",$J),^TMP("ZZVPS0",$J)
 N D1,D2,D3,D4,D5,D6,D7,D8,D9,QA,S1,S2,CLASS
 S S1="",(D1,D2,D3,D4,D5,D6)=0
 F  S S1=$O(^DIC(9.4,"B",S1)) Q:S1=""  W:DISSORT'=4 "." S S2=0 F  S S2=$O(^DIC(9.4,"B",S1,S2)) Q:'S2  DO LPVAR(S2,.PKGNAME,.CLASS) IF PKGNAME]"",CLASS="I" D  ;
 .S PKGPFX=$P(PKGNAME,"^",2),PKGNAME=$P(PKGNAME,"^"),PKGIEN=S2
 .S (FTOT,OTOT,PTOT,PRCTOT,RPTOT,RTOT,TLCNT)=0,FLDTOT="TBD"
 .S QA=0 F  S QA=$O(^DIC(9.4,PKGIEN,4,QA)) Q:'QA  S FTOT=FTOT+1
 .S RTOT=$$ROUTINE(PKGPFX,.TLCNT)
 .S OTOT=$$OPTION(PKGPFX),PRCTOT=$$PROTOCOL(PKGPFX,PKGIEN)
 .S RPTOT=$$REMPROC(PKGPFX) K ADP S (ADP,QA)=0
 .F  S QA=$O(^DIC(9.4,PKGIEN,14,QA)) Q:'QA  S ADP=ADP+1,ADP(ADP)=$P($G(^(QA,0)),"^")
 .I ADP F QA=1:1:ADP I ADP(QA)]"" D  ;
 ..S RTOT=RTOT+$$ROUTINE(ADP(QA),.TLCNT)
 ..S OTOT=OTOT+$$OPTION(ADP(QA))  ;;,PRCTOT=PRCTOT+$$PROTOCOL(ADP(QA),PKGIEN) ;;TO DO: GTS - Remove after confirming new PROTOCOL api get's all "additional prefixes"
 ..S RPTOT=RPTOT+$$REMPROC(ADP(QA))
 .S D1=$G(^TMP("ZZVPS",$J,PKGNAME,PKGPFX)),D9=$P(D1,"^",7),D8=$P(D1,"^",6)
 .S D7=$P(D1,"^",5),D5=$P(D1,"^",3),D4=$P(D1,"^",2),D3=+D1
 .S ^TMP("ZZVPS",$J,PKGNAME,PKGPFX)=(D3+RTOT)_"^"_(D4+TLCNT)_"^"_(D5+FTOT)_"^^"_(D6+OTOT)_"^"_(D7+PTOT)_"^"_(D8+RPTOT)
 I DISSORT=2 S D1="" F  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  S X=$G(^(D2)),^TMP("ZZVPS0",$J,+X,D1,D2)=$P(X,"^",2,7)
 I DISSORT=3 S D1="" F  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  S X=$G(^(D2)),^TMP("ZZVPS0",$J,+$P(X,"^",2),D1,D2)=+X_"^"_$P(X,"^",3,7)
 ;; W "."
 ;
DISALL ;
 ; display option 4 has no formatting, and is used for creating
 ; spreadsheets, for which the following heading lines are not needed
 I DISSORT'=4 D  ;
 .W @IOF,"VistA Application Sizing Information"
 .W !!!!,"Application",?29,"Routines  Total  Files  Files  Fields Options Protocols RPCs"
 .W !?2,"(Namespace)",?38,"Routine",!?39,"Size",?60,DISSORT
 .W !,"================================================================================"
  ;; R !,"***: ",X ;
 ;
DAD ;
 I DISSORT=2!(DISSORT=3) S S3="" F  S S3=$O(^TMP("ZZVPS0",$J,S3),-1) S D3=S3 Q:S3=""  S D1="" F  S D1=$O(^TMP("ZZVPS0",$J,S3,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS0",$J,S3,D1,D2)) Q:D2=""  D PDAD(DISSORT,$G(^(D2)),D1,D2,D3)
 I DISSORT=1!(DISSORT=4) DO
 . NEW POPERR
 . SET (D1,POPERR)=""
 . ;
 . ;If write delimited report to a file
 . IF FILENME]"" DO  QUIT:POPERR
 .. DO OPEN^%ZISH("DELIMFL1",STORPATH,FILENME,"A")
 .. SET:POP POPERR=POP
 .. QUIT:POPERR
 .. U IO
 . ;
 . FOR  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" DO
 .. F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  DO
 ... D PDAD(DISSORT,$G(^(D2)),D1,D2,"")
 . IF FILENME]"" DO
 .. D CLOSE^%ZISH("DELIMFL1")
 ;
 ;If write delimited report to a file
 IF (DISSORT=4),($G(POPERR)) DO
 . W !!,"ERROR: "_FILENME_" file creation in "_STORPATH_" FAILED!!"
 . W !,"       >>Check path and filename.<<"
 K ^TMP("ZZVPS",$J),^TMP("ZZVPS0",$J)
 Q
 ;
PDAD(DISSORT,DATA,D1,D2,D3) ; print actual data (finally)
 N D4,D5,D6,D7,D8,D9,DATANDE S D6="TBD"
 I DISSORT=1!(DISSORT=4) N D3 S D4=$P(DATA,"^",2),D5=$P(DATA,"^",3),D7=$P(DATA,"^",5),D8=$P(DATA,"^",6),D9=$P(DATA,"^",7),D3=+DATA
 I DISSORT=4 DO  QUIT
 . SET DATANDE=""
 . SET DATANDE=D1_"^"_D2_"^"_D3_"^"_D4_"^"_D5_"^"_D6_"^"_D7_"^"_D8_"^"_D9
 . W !,DATANDE
 I DISSORT=2!(DISSORT=3) S D5=$P(DATA,"^",2),D7=$P(DATA,"^",4),D8=$P(DATA,"^",5),D9=$P(DATA,"^",6) S:DISSORT=2 D4=+DATA S:DISSORT=3 D4=D3,D3=+DATA
 ;
 ;If writing report to printer...
 W !,D1,?31,$J(D3,6)," ",$J(D4,9)," ",$J(D5,4)," ",$J(D6,6)," ",$J(D7,6)," ",$J(D8,6)," ",$J(D9,6)
 W !,"(",D2,")",!,"--------------------------------------------------------------------------------"
 QUIT
 ;
SELPKG ;
 S DIC=9.4,DIC(0)="AEMQ",DIC("S")="I $D(^(7)),$P(^(7),""^"",3)=""I"""
 W ! D ^DIC
 I Y>0 W !!!!,"...working..." D PRINT(Y)
 ;
QUIT ;
 Q
 ;
PRINT(Y) ;
 N ADP,PTOT,FTOT,RTOT,OTOT,PRCTOT,RPTOT,Q,PKGIEN,PKGNAME,PKGPFX
 S PKGNAME=$P(Y,"^",2),PKGIEN=+Y
 S PKGPFX=$P($G(^DIC(9.4,PKGIEN,0)),"^",2)
 I PKGPFX="" W !!,"PREFIX not found for package selected.  Unable to continue." Q
 ;
 S (ADP,Q)=0
 F  S Q=$O(^DIC(9.4,PKGIEN,14,Q)) Q:'Q  S ADP=ADP+1,ADP(ADP)=$P($G(^(Q,0)),"^")
 ;
 W !,"...counting...",!,"    ...files..."
 S (Q,FTOT)=0
 F  S Q=$O(^DIC(9.4,PKGIEN,4,Q)) Q:'Q  S FTOT=FTOT+1
 ;
 W !,"    ...routines..."
 S TLCNT=0,RTOT=$$ROUTINE(PKGPFX,.TLCNT)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S RTOT=RTOT+$$ROUTINE(ADP(Q),.TLCNT)
 ;
 W !,"    ...options..."
 S OTOT=$$OPTION(PKGPFX)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S OTOT=OTOT+$$OPTION(ADP(Q))
 ;
 S PRCTOT=$$PROTOCOL(PKGPFX,PKGIEN)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S PRCTOT=PRCTOT+$$PROTOCOL(ADP(Q),PKGIEN)
 ;
 W !,"    ...remote procedures..."
 S RPTOT=$$REMPROC(PKGPFX)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S RPTOT=RPTOT+$$REMPROC(ADP(Q))
 ;
 W !!!,"VistA Application Sizing Information"
 W !,"Run Date: " D NOW^%DTC S Y=X D DD^%DT W Y
 W !,"VistA Application: ",PKGNAME
 W !,"=========================================="
 W !,"Number of Routines:     ",RTOT
 W !,"Size of Routines:       ",TLCNT
 W !,"Number of Files:        ",FTOT
 W !,"Number of Fields:       TBD"
 W !,"Number of Options:      ",OTOT
 W !,"Number of Protocols:    ",PRCTOT
 W !,"Number of RPCs:         ",RPTOT
 W !!
 Q
 ;
ROUTINE(PKGPFX,TLCNT) ; Returns total of all characters in all routines, including line feeds on each line of each routine
 N CNT,Q,QL
 S Q=PKGPFX,QL=$L(Q),CNT=$D(^ROUTINE(PKGPFX))#2
 I CNT S TLCNT=TLCNT+$G(^ROUTINE(PKGPFX,0,"SIZE"))
 F  S Q=$O(^ROUTINE(Q)) Q:$E(Q,1,QL)'=PKGPFX  S CNT=CNT+1,TLCNT=TLCNT+$G(^(Q,0,"SIZE"))
 Q CNT
 ;
PROTOCOL(PKGPFX,PKGIEN) ;  ;;TO DO: GTS - REMOVE NOTE **UNIT TESTED**
 N CNT,Q,QL,PKEN,ORDIEN
 ;;S CNT=$D(^ORD(101,"B",PKGPFX))#2
 S CNT=0
 S Q="",QL=$L(PKGPFX)
 SET ORDIEN=0
 FOR  S ORDIEN=$O(^ORD(101,ORDIEN))  Q:+ORDIEN'>0  I ($P(^ORD(101,ORDIEN,0),"^",12)=PKGIEN) S CNT=CNT+1
 ;
 ;;TO DO: GTS - Remove following code before release.  It assumes that protocols must begin with the Prefix for the package.
 ;;F  S Q=$O(^ORD(101,"B",Q)) Q:$E(Q,1,QL)'=PKGPFX  DO
 ;;.SET ORDIEN=0
 ;;.FOR  S ORDIEN=$O(^ORD(101,"B",Q,ORDIEN))  Q:+ORDIEN'>0  Q:$P(^ORD(101,ORDIEN,0),"^",12)'=PKGIEN  W !,Q S CNT=CNT+1
 Q CNT
 ;
REMPROC(PKGPFX) ; ;;TO DO: GTS - HERE...NEED TO UNIT TEST
 N CNT,Q,QL
 S CNT=$D(^XWB(8994,"B",PKGPFX))#2
 S Q=PKGPFX,QL=$L(PKGPFX)
 F  S Q=$O(^XWB(8994,"B",Q)) Q:$E(Q,1,QL)'=PKGPFX  S CNT=CNT+1
 Q CNT
 ;
OPTION(PKGPFX) ; ;;TO DO: GTS - REMOVE NOTE **UNIT TESTED**
 N CNT,Q,QL
 S CNT=$D(^DIC(19,"B",PKGPFX))#2
 S Q=PKGPFX,QL=$L(Q)
 F  S Q=$O(^DIC(19,"B",Q)) Q:$E(Q,1,QL)'=PKGPFX  S CNT=CNT+1
 Q CNT
 ;
 ;GTS APIs
LPVAR(PKGIEN,PKGNAME,CLASS) ;Set Package Name and Class for loop
 ; Input:  PKGIEN  - Package file 9.4 IEN
 ;
 ; Output: PKGNAME - NAME field(#.01) from Package file (9.4) [Return via reference]
 ;         CLASS   - CLASS field (#11.3) from Package file [Return via reference]
 ;
 SET PKGNAME=$GET(^DIC(9.4,PKGIEN,0))
 SET CLASS=$P($GET(^DIC(9.4,PKGIEN,7)),"^",3)
 QUIT
 ;
CHKHOST() ;Function to prompt user - indicate host file need
 ;Return Y(0) as defined by ^DIR for a Y/N prompt
 ;
 NEW DIR,Y,X
 SET DIR(0)="Y^A^"
 SET DIR("A")="Do you want to create a '^' delimited Host File"
 SET DIR("A",1)=" "
 SET DIR("A",2)="You selected to report Delimted (^) Data, Sorted by PACKAGE NAME."
 SET DIR("B")="YES"
 SET DIR("?")="Enter 'YES' to create a Host File in addition to the report."
 DO ^DIR
 QUIT $G(Y(0))
 ;
SELFILE(FILENME,STORPATH) ; Select Filename and Directory location
 NEW DIR,Y,X
 SET (FILENME,STORPATH)=""
 SET DIR(0)="FAOr^3:30^"
 SET DIR("A")="Enter the name of the Host File: "
 SET DIR("A",1)=" "
 SET DIR("B")="VistAPkgSize_"_$P($$NOW^XLFDT,".",1)_$P($$NOW^XLFDT,".",2)
 SET DIR("?")="Enter '^' to abort Host File creation."
 SET DIR("?",1)="the file extension '.txt' will be added to your filename"
 DO ^DIR
 ;
 IF '$D(DTOUT),'$D(DUOUT),'$D(DIROUT) DO
 . SET FILENME=Y_".txt"
 . NEW DIR,Y,X
 . SET DIR(0)="FAOr^2:60^"
 . SET DIR("A")="Enter directory to write "_FILENME_": "_$$DEFDIR^%ZISH("")
 . SET DIR("A",1)=" "
 . SET DIR("B")=""
 . SET DIR("?")="Enter '^' to abort Host File creation."
 . DO ^DIR
 . IF '$D(DTOUT),'$D(DUOUT),'$D(DIROUT) DO
 .. SET:X]"" STORPATH=X
 .. SET:X']"" STORPATH=$$DEFDIR^%ZISH("")
 IF $D(DTOUT)!$D(DUOUT)!$D(DIROUT) SET (FILENME,STORPATH)=""
 QUIT
 ;
FILABORT(CRTHOST,FILENME,STORPATH) ;Host file selected but File name and path not entered
 ;Return NULL values for CRTHOST, FILENME, & STORPATH via reference
 ;
 NEW DIR,Y,X
 SET DIR(0)="E^A^"
 SET DIR("A")="Press Enter/Return to continue PRINTING report"
 SET DIR("A",1)=" "
 SET DIR("A",2)="  You selected to create a Host File but did not enter the file name and path."
 SET DIR("A",3)="                   <<Host File will NOT be created!>>"
 SET DIR("A",4)=" "
 DO ^DIR
 SET (CRTHOST,FILENME,STORPATH)=""
 QUIT
 ;;-GTS OLD CODE - Cleanup dead code after report works
 ;
ORIGDAD ; display all data
 I DISSORT=2!(DISSORT=3) S S3="" F  S S3=$O(^TMP("ZZVPS0",$J,S3),-1) S D3=S3 Q:S3=""  S D1="" F  S D1=$O(^TMP("ZZVPS0",$J,S3,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS0",$J,S3,D1,D2)) Q:D2=""  D PDAD(DISSORT,$G(^(D2)),D1,D2,D3)
 I DISSORT=1!(DISSORT=4) S D1="" F  S D1=$O(^TMP("ZZVPS",$J,D1)) Q:D1=""  S D2="" F  S D2=$O(^TMP("ZZVPS",$J,D1,D2)) Q:D2=""  D PDAD(DISSORT,$G(^(D2)),D1,D2)
 Q
 ;
GTSPDAD(DISSORT,DATA,D1,D2,D3,TMPIEN) ; print actual data (finally)
 N D4,D5,D6,D7,D8,D9,HOSTNDE S D6="TBD"
 I DISSORT=1!(DISSORT=4) N D3 S D4=$P(DATA,"^",2),D5=$P(DATA,"^",3),D7=$P(DATA,"^",5),D8=$P(DATA,"^",6),D9=$P(DATA,"^",7),D3=+DATA
 I DISSORT=4 DO  QUIT
 . SET HOSTNDE=""
 . SET HOSTNDE=D1_"^"_D2_"^"_D3_"^"_D4_"^"_D5_"^"_D6_"^"_D7_"^"_D8_"^"_D9
 . WRITE !,HOSTNDE
 . IF FILENME]"" SET ^TMP("ZZVPS",$J,"HOSTFILE",TMPIEN)=HOSTNDE
 . ;W !,D1,"^",D2,"^",D3,"^",D4,"^",D5,"^",D6,"^",D7,"^",D8,"^",D9 Q  ;;DO FILEWRT(
 I DISSORT=2!(DISSORT=3) S D5=$P(DATA,"^",2),D7=$P(DATA,"^",4),D8=$P(DATA,"^",5),D9=$P(DATA,"^",6) S:DISSORT=2 D4=+DATA S:DISSORT=3 D4=D3,D3=+DATA
 W !,D1,?31,$J(D3,6)," ",$J(D4,9)," ",$J(D5,4)," ",$J(D6,6)," ",$J(D7,6)," ",$J(D8,6)," ",$J(D9,6)
 W !,"(",D2,")",!,"--------------------------------------------------------------------------------"
 Q
 ;
TEST ;
 N D1,D2,D3,D4,D5,D6,D7,D8,D9,QA,S1,S2,CLASS
 S S1="",(D1,D2,D3,D4,D5,D6)=0
 F  S S1=$O(^DIC(9.4,"B",S1)) Q:S1=""  S S2=0 DO
 .F  S S2=$O(^DIC(9.4,"B",S1,S2)) Q:'S2  DO
 ..W !!,"S1=",S1,!,"S2=",S2 DO LPVAR(S2,.PKGNAME,.CLASS) IF PKGNAME]"",CLASS="I" W !,"PKGNAME=",PKGNAME,! ;
 Q

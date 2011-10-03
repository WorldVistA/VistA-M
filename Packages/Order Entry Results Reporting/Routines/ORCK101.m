ORCK101 ;SLC/JFR-OR 49 CHECK UTILITIES ;7/27/98
 ;;2.5;ORDER ENTRY/RESULTS REPORTING;**49**;Jan 08, 1993
TOP ; from patch options
 N ORTOP,%ZIS,IOP,TAG
 W !,"Select the printer to which the reports will be queued:",!
 S IOP="Q",%ZIS="N"
 D ^%ZIS
 I POP W !,"That device is not available or none selected" Q
 I '$D(IO("Q")) W !!,"The reports must be queued!",! G TOP
 S ORTOP=1 W !!,"Reports will be sent to ",ION
 F TAG="PKGFL","PROT","NMSP","XACTION" D
 . S ZTRTN=TAG_"^ORCK101",ZTDESC="OR*2.5*49 PROTOCOL CHECK"
 . S ZTDTH=$H,ZTSAVE("ORTOP")="",ZTIO=ION
 . D ^%ZTLOAD
 D HOME^%ZIS
 K ZTSK,ZTIO,ZTDTH,ZTDESC,ZTRTN,ZTSAVE
 Q
XACTION ;check extended actions for column width
 I $D(ZTQUEUED) S ZTREQ="@"
 N ORIEN,CTR,TMPGBL,CHECK
 S CHECK="Extended Action Order Set check",TMPGBL="ORXACT"
 S (CTR,ORIEN)=0
 F  S ORIEN=$O(^ORD(101,ORIEN)) Q:'ORIEN  I $P($G(^(ORIEN,0)),U,4)="X" D
 . Q:'+$G(^ORD(101,ORIEN,4))  S CTR=CTR+1
 . S ^TMP(TMPGBL,$J,CTR)=$P(^ORD(101,ORIEN,0),U)_" has the COLUMN WIDTH field defined"
 I '$D(ORTOP) D DEVICE Q  ;ok to call linetag
 D PRINT
 Q
PKGFL ;check file 9.4 for duplicates
 I $D(ZTQUEUED) S ZTREQ="@"
 N PKG,CHECK,I,N,P,NM,PREF,TMPGBL,CTR
 S CTR=0,CHECK="PACKAGE (#9.4) file check",TMPGBL="ORPKG"
 F I=1:1 S PKG=$P($T(LIST+I),";;",2) Q:PKG="QUIT"  D
 . S NM=$P(PKG,"^"),PREF=$P(PKG,"^",2)
 . S N=$O(^DIC(9.4,"B",NM,0)) D:'N  S N=$O(^DIC(9.4,"B",NM,N)) I N D
 .. S CTR=CTR+1
 .. S ^TMP(TMPGBL,$J,CTR)=NM_" has "_$S(N:"a duplicate",1:"no")_" name entry in the PACKAGE file"
 .. Q
 . S P=$O(^DIC(9.4,"C",PREF,0)) D:'P  S P=$O(^DIC(9.4,"C",PREF,P)) I P D
 .. S CTR=CTR+1
 .. S ^TMP(TMPGBL,$J,CTR)="There is "_$S(P:"a duplicate",1:"no")_" prefix entry of "_PREF_" in the PACKAGE file"
 .. Q
 . I $O(^DIC(9.4,"B",NM,0))'=$O(^DIC(9.4,"C",PREF,0)) D
 .. S CTR=CTR+1
 .. S ^TMP(TMPGBL,$J,CTR)="The name and prefix for "_NM_" are not part of the same entry"
 . Q
 I '$D(ORTOP) D DEVICE Q  ;ok to call from linetag
 D PRINT
 Q 
LIST ;list to check
 ;;LAB SERVICE^LR
 ;;INPATIENT MEDICATIONS^PSJ
 ;;OUTPATIENT PHARMACY^PSO
 ;;DIETETICS^FH
 ;;RADIOLOGY/NUCLEAR MEDICINE^RA
 ;;NURSING SERVICE^NUR
 ;;GEN. MED. REC. - VITALS^GMRV
 ;;ORDER ENTRY/RESULTS REPORTING^OR
 ;;QUIT
PROT ;LOOP 101 AND LOOK AT 10 FIELD FOR DUPS
 I $D(ZTQUEUED) S ZTREQ="@"
 N TMPGBL,CTR,PTR,CTR1,ORZIEN,ORZ10IEN
 S (CTR1,ORZIEN)=0,TMPGBL="ORDUPS"
 S CHECK="Duplicate Items in PROTOCOL file check"
 F  S ORZIEN=$O(^ORD(101,ORZIEN)) Q:'ORZIEN  D:$P(^(ORZIEN,0),"^",4)="D"
 . S ORZ10IEN=0
 . F  S ORZ10IEN=$O(^ORD(101,ORZIEN,10,"B",ORZ10IEN)) Q:'ORZ10IEN  D
 . . S (PTR,CTR)=0
 . . F  S PTR=$O(^ORD(101,ORZIEN,10,"B",ORZ10IEN,PTR)) Q:'PTR  D 
 . . . S CTR=CTR+1 I CTR>1 S CTR1=CTR1+1
 . . . I  S ^TMP(TMPGBL,$J,CTR1)=$P(^ORD(101,ORZIEN,0),U)
 . . Q
 . Q
 I '$D(ORTOP) D DEVICE Q  ;ok to call from linetag
 D PRINT
 Q
DLG ; FIND DUPS IN FILE 101.41
 N TMPGBL,CTR,PTR,CTR1,ORZIEN,ORZ10IEN
 S (CTR1,ORZIEN)=0,TMPGBL="ORDLGDUP"
 S CHECK="Duplicate Items in ORDER DIALOG file"
 F  S ORZIEN=$O(^ORD(101.41,ORZIEN)) Q:'ORZIEN  D:$P(^(ORZIEN,0),"^",4)="D"
 . S ORZ10IEN=0
 . F  S ORZ10IEN=$O(^ORD(101.41,ORZIEN,10,"D",ORZ10IEN)) Q:'ORZ10IEN  D
 . . S (PTR,CTR)=0
 . . F  S PTR=$O(^ORD(101.41,ORZIEN,10,"D",ORZ10IEN,PTR)) Q:'PTR  D 
 . . . S CTR=CTR+1 I CTR>1 S CTR1=CTR1+1
 . . . I  S ^TMP(TMPGBL,$J,CTR1)=$P(^ORD(101.41,ORZIEN,0),U)
 . . Q
 . Q 
 I '$D(ORTOP) D DEVICE Q  ;ok to call from linetag
 D PRINT
 Q
NMSP ;loop to find protocols with improper namespace
 I $D(ZTQUEUED) S ZTREQ="@"
 D DT^DICRW
 N CTR,CHECK,TMPGBL,ORZIEN,PKG,GMRC,DIC,X,Y,BADPK,ORZNM,ORZPKG
 S DIC=9.4,DIC(0)="XM",BADPK=0
 F X="FH","GMRC","GMRV","LR","PSJ","RA" Q:(BADPK)  D
 . D ^DIC I +Y<0 S BADPK=1 Q
 . S PKG(+Y)=X I X="GMRC" S GMRC=+Y
 I BADPK D
 . S ^TMP("ORPROT",$J,1)="The PACKAGE file should be checked for duplicate entries or PREFIXES."
 . S ^TMP("ORPROT",$J,2)="Unable to continue namespace check."
 . S ^TMP("ORPROT",$J,3)=" "
 . S ^TMP("ORPROT",$J,4)="This review should be repeated after the PACKAGE file is corrected." 
 S (CTR,ORZIEN)=0
 S TMPGBL="ORPROT",CHECK="Protocol namespace check"
 I 'BADPK F  S ORZIEN=$O(^ORD(101,ORZIEN)) Q:'ORZIEN  D
 . I "QXM"[$P(^ORD(101,ORZIEN,0),"^",4) Q  ; don't check menus / ord sets
 . S ORZPKG=$P(^ORD(101,ORZIEN,0),"^",12) Q:'ORZPKG  Q:'$D(PKG(ORZPKG))
 . I ORZPKG=GMRC Q:'$$OK(ORZIEN)  ;special names for consults
 . S ORZNM=$E($P(^ORD(101,ORZIEN,0),U),1,$S(ORZPKG=GMRC:5,1:$L(PKG(ORZPKG))))
 . I '$S(ORZPKG=GMRC:"GMRCTGMRCR"[ORZNM,1:ORZNM=PKG(ORZPKG)) D
 . . S CTR=CTR+1
 . . S ^TMP(TMPGBL,$J,CTR)=$P(^ORD(101,ORZIEN,0),U)
 . . Q
 . Q
 I '$D(ORTOP) D DEVICE Q  ;ok to call from linetag
 D PRINT
 Q
OK(PROT) ;only check ordering protocols
 I $P(^ORD(101,PROT,0),U,3)'="O" Q 0
 I $P(^ORD(101,PROT,0),U)["PLACE" Q 0
 I $P(^ORD(101,PROT,0),U)["URGENCY" Q 0
 I $P(^ORD(101,PROT,0),U)["GMRCO" Q 0
 Q 1
PRINT ;the results are in
 N CTR,DONE
 U IO
 I '$D(^TMP(TMPGBL,$J)) S ^TMP(TMPGBL,$J,1)="No problems with "_CHECK
 W:$E(IOST,1,2)="C-" @IOF
 D PAGE(0)
 S CTR=0 F  S CTR=$O(^TMP(TMPGBL,$J,CTR)) Q:'CTR!($D(DONE))  D
 . I $Y>(IOSL-5) D PAGE(1) Q:$G(DONE)
 . W !,^TMP(TMPGBL,$J,CTR)
 . Q
 D ^%ZISC K CTR,DONE,ORTOP
CLEAN   ;sweep up
 K ^TMP(TMPGBL,$J)
 K TMPGBL,CHECK
 Q
FIND ; FIND ITEMS IN 101 AND THEIR POSITION
 N DIC,ITEM,MEN,X,Y,ITPOS
 D DT^DICRW
 K DIC S DIC=101,DIC(0)="AEMNQ" D ^DIC
 I $D(DUOUT)!($D(DTOUT)) Q
 W !!,$P($G(^ORD(101,+Y,0)),"^")
 I '$D(^ORD(101,"AD",+Y)) W !,?3,"Not contained on any menus!" QUIT
 S ITEM=+Y
 S MEN=0 F  S MEN=$O(^ORD(101,"AD",ITEM,MEN)) Q:'MEN  D
 . W !,?5,"is part of ",$P($G(^ORD(101,MEN,0)),"^")
 . S ITPOS=$$FINDXUTL^ORCMEDT1(MEN,ITEM)
 . W ?50,"Column: ",$P(ITPOS,".",2),?65,"Row: ",$P(ITPOS,".")
 . Q
 Q
EST ; estimate global growth in ^OR and ^PSRX
 W !,"Select the printer to which the estimate will be sent:",!
 S IOP="Q",%ZIS="N"
 D ^%ZIS
 I POP W !,"That device is not available or none selected" Q
 I '$D(IO("Q")) D  G EST
 . W !!,"The estimate may take some time. It must be queued!",!
 S ZTRTN="QGROW^ORCK101",ZTDESC="Estimate of CPRS global growth"
 S ZTIO=ION,ZTDTH=$H D ^%ZTLOAD
 W !!,$S($G(ZTSK):("Task # "_ZTSK),1:"Unable to queue,try later!")
 D HOME^%ZIS
 K %ZIS,POP,ZTDESC,ZTIO,ZTRTN,ZTSK
 Q
QGROW ;task to do estimate
 S ZTREQ="@"
 S BKFILL=$$PSOBKFL
 S ORENT=$P(^OR(100,0),"^",4),RXENT=$P(^PSRX(0),"^",4)
 S ORBLK=(ORENT+BKFILL)*($S(^%ZOSF("OS")="DSM":.71,1:.35))
 S RXBLK=RXENT*($S(^%ZOSF("OS")="DSM":.67,1:.37))
 U IO
 W !,"Estimate of global growth from CPRS Installation",!
 F DASH=1:1:78 W "-"
 W !!,"Based on the number of entries currently in the ^PSRX and ^OR globals,"
 W !,"the following are estimates of post-installion requirements."
 W !,"The globals will continue to grow as implementation of CPRS proceeds"
 W !!,"The ^PSRX global will require approximately ",RXBLK," blocks."
 W !!,"Approximately ",BKFILL," prescriptions will be backfilled into the ORDER (#100) file."
 W !!,"The ^OR global will require approximately ",ORBLK," blocks."
 K BKFILL,DASH,ORBLK,ORENT,RXBLK,RXENT
 Q
PAGE(FEED) ; FEED ONE
 N DASH,DIR
 I FEED,$E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR I Y<1 S DONE=1 Q
 W:FEED @IOF
 W "OR*2.5*49 - ",CHECK
 W ! F DASH=1:1:78 W "-"
 Q
DEVICE ;
 S %ZIS="QM" D ^%ZIS I POP D CLEAN Q
 I $D(IO("Q")) D QUE,^%ZISC,CLEAN Q
 D PRINT
 Q
QUE ; send to TM
 S ZTSAVE("^TMP(TMPGBL,$J,")="",ZTSAVE("TMPGBL")="",ZTSAVE("CHECK")=""
 S ZTDTH=$H,ZTDESC="OR*2.5*49 Protocol examination"
 S ZTRTN="PRINT^ORCK101"
 S ZTIO=IO
 D ^%ZTLOAD
 K ZTSK,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH
 Q
PSOBKFL() ;estimate # of RX's to be backfilled into ^OR
 ; Thks to Ron R.
 N PDFN,PSD,PSIN,PSODATE,PSOTOT,X,X1,X2
 S X1=DT,X2=-121 D C^%DTC S PSODATE=X
 S PSOTOT=0
 F PDFN=0:0 S PDFN=$O(^PS(55,PDFN)) Q:'PDFN  D
 .F PSD=PSODATE:0 S PSD=$O(^PS(55,PDFN,"P","A",PSD)) Q:'PSD  F PSIN=0:0 S PSIN=$O(^PS(55,PDFN,"P","A",PSD,PSIN)) Q:'PSIN  I $D(^PSRX(PSIN,0)) D
 ..I $P($G(^PSRX(PSIN,0)),"^",15)=13!($P($G(^(0)),"^",15)=10)!('$P($G(^(0)),"^",2)) Q
 ..S PSOTOT=PSOTOT+1
 Q PSOTOT

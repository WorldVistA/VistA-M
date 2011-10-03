GMVDS1 ;HOIFO/YH,FT-CURRENT VITALS BY PATIENT OR LOCATION ;6/6/07
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #10039 - FILE 42 references     (supported)
 ; #10040 - FILE 44 references     (supported)
 ; #10061 - ^VADPT calls           (supported)
 ; #10090 - FILE 4 references      (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
EN1(RESULT,GMVDATA) ; [RPC entry point]
 ; GMV LATEST VITALS FOR PATIENT & GMV LATEST VITALS BY LOCATION
 ; DFN      - patient internal entry number
 ; GMVDEV   - device name
 ; GMVIEN   - device internal entry number
 ; GMVPDT   - date/time to print the report
 ; GMVWARD  - ward internal entry number
 ; GMVHLOC  - hospital location internal entry number
 ;
 N DFN,GMVDEV,GMVIEN,GMVPDT,GMVWARD,GMVHLOC
 S DFN=+$P(GMVDATA,U,1),GMVDEV=$P(GMVDATA,U,5),GMVIEN=+$P(GMVDATA,U,6),GMVPDT=$P(GMVDATA,U,7),GMVWARD=$P(GMVDATA,U,8),GMVHLOC=$P(GMVDATA,U,9)
 S ZTIO=GMVDEV ;device
 S ZTDTH=$S($G(GMVPDT)>0:GMVPDT,1:$$NOW^XLFDT()) ;date/time to print
 S ZTRTN="EN2^GMVDS1"
 S (ZTSAVE("DFN"),ZTSAVE("GMVWARD"),ZTSAVE("GMVHLOC"))=""
 I DFN>0 S ZTDESC="Latest Vitals Display for a Patient"
 I GMVWARD>0 S ZTDESC="Latest Vitals by Location"
 D ^%ZTLOAD
 S RESULT=$S($G(ZTSK)>0:"Report sent to device. Task #: "_ZTSK,1:"Unable to task the report.")
 K ZTSK,ZTIO,ZTDTH,ZTSAVE,ZTDESC,ZTRTN
 Q
EN2 ; Start the report output
 S:$D(ZTQUEUED) ZTREQ="@"
 S GMVEDB=$S(DFN>0:"P",1:"A") ;P is one patient, A is whole ward
 S GMVWARD(1)=$S(GMVWARD>0:$P($G(^DIC(42,GMVWARD,0)),U,1),1:"") ;ward name
 K ^TMP($J)
 I $G(GMVEDB)="P" D
 .D DEM^VADPT,INP^VADPT
 .S GMRRMBD=$S(VAIN(5)'="":VAIN(5),1:"  BLANK") ;roombed
 .S GMVNAME=$S(VADM(1)'="":VADM(1),1:"  BLANK") ;patient name
 .S GMVWARD=$P(VAIN(4),"^") ;ward ien
 .S GMVWARD(1)=$P(VAIN(4),"^",2) ;ward name
 .D KVAR^VADPT K VA ;kill VADPT variables
 .S ^TMP($J,GMRRMBD,GMVNAME,DFN)=""
 E  D WARD
AE ;
 S (GMROUT,GMVPAGE)=0
 S GMVDASH=$$REPEAT^XLFSTR("-",80) ;line of dashes
 D NOW^%DTC
 S Y=% X ^DD("DD") S GMRPDT=$P(Y,"@")_" ("_$P($P(Y,"@",2),":",1,2)_")"
 S GMRSTR="T;P;R;BP;WT;HT;CVP;CG;PO2;PN"
 S GLOC=1 ;<-might be dead code
 U IO
 D HDR
 I $O(^TMP($J,""))="" W !,"THERE IS NO DATA FOR THIS REPORT" D Q1 Q
 S GMRRMBD=""
 F  S GMRRMBD=$O(^TMP($J,GMRRMBD)) Q:GMRRMBD=""!GMROUT  S GMVNAME="" F  S GMVNAME=$O(^TMP($J,GMRRMBD,GMVNAME)) Q:GMVNAME=""!GMROUT  F DFN=0:0 S DFN=$O(^TMP($J,GMRRMBD,GMVNAME,DFN)) Q:DFN'>0  D PRT Q:GMROUT
Q1 ; Kill variables and quit
 K ^TMP($J),DFN,GMRADM,GMRDA,GMVDASH,GMVEDB,GMVNAME,GMRNM,GMROUT,GMRPDT,GMVPAGE,GMRRMBD,GMRPR,GMRVDT,GMRVTDA,GMVWARD,GMRX,GMRSITE,GMRSP,GMRVX,GMVHLOC,POP,GMRDT,%,%T,GDT
 K GSTRIN,GMRSTR,GMROUT,GMRVOERR,GMRVSTOP,GMRVSTRT,GLOC,GDATA
 D KVAR^VADPT
 D Q^GMVDS0
 D ^%ZISC
 Q
HDR ; Report Header
 W:$Y>0 @IOF
 S GMVPAGE=GMVPAGE+1
 I GMVEDB="A" W !,GMRPDT,?20,"VITALS REPORT FOR UNIT: "_GMVWARD(1) W:GMVHLOC>0 " - "_$$GET1^DIQ(4,+$$GET1^DIQ(44,+GMVHLOC,3,"I"),.01,"I")
 I GMVEDB="P" W !,GMRPDT,?28,"LATEST VITALS REPORT"
 W ?72,"PAGE ",GMVPAGE
 W !,GMVDASH,!
 Q
PRT ; Body of report
 D:IOSL<($Y+6)!($E(IOST)'="P") HDR Q:GMROUT
 D DEM^VADPT K GMRDT
 W !,$S(GMRRMBD'="  BLANK":$E(GMRRMBD,1,10),1:""),?12,$E(GMVNAME,1,20),?34,$E($P(VADM(2),U,2),8,11),!
 D EN1^GMVDS0,Q2
 Q
Q2 ; Kill variables
 K GMRLIN,GMRJ,GBP,GMR,GMRL,GMRDT,GMRDAT,GMRDATS,GMRI,GMRX,GMRY,GMRVX,GSITE,GQUAL
 Q
WARD ; Build TMP global for patients on ward
 ; set ^TMP($J,roombed,patient name,DFN)=""
 ; GMVWARD(1) is the NAME of FILE 42 entry
 ; GMVRMBD(n) is an array of room numbers on the ward (e.g, GMVRMBD(200))
 ; GMVEDB is a code for the type of sort
 ;        A = all patients on a ward
 ;        S = selected roombeds on a ward
 ;        P = an individual patient
 K ^TMP($J)
 S DFN=0
 F  S DFN=$O(^DPT("CN",GMVWARD(1),DFN)) Q:DFN=""  D
 .D DEM^VADPT,INP^VADPT
 .S GMVRMBD=$S(VAIN(5)'="":VAIN(5),1:"  BLANK") ;roombed
 .S GMVNAME=$S(VADM(1)'="":VADM(1),1:"  BLANK")  ;patient name
 .D KVAR^VADPT K VA
 .S:$S("Aa"[GMVEDB:1,$D(GMVROOM($P(GMVRMBD,"-"))):1,1:0) ^TMP($J,GMVRMBD,GMVNAME,DFN)=""
 .Q
 Q

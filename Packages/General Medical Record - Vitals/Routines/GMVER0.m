GMVER0 ;HOIFO/FT-VITALS ENTERED IN ERROR FOR A PATIENT ;10/25/02  10:26
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #10061 - ^VADPT calls        (supported)
 ; #10103 - ^XLFDT calls        (supported)
 ; #10104 - ^XLFSTR calls       (supported)
 ;
EN1(RESULT,GMVDATA) ; GMV ENTERED IN ERROR-PATIENT [RPC entry point]
 ; Queues a report to a printer
 ; GMVDATA=DFN^START DT^END DT^TYPE OF GRAPH^DEVICE^DEVICE IEN(#3.5)^
 ;         DATE/TIME TO PRINT REPORT
 ;
 N DFN,GMVBEG,GMVEND,GMVDEV,GMVIEN,GMVPDT
 S DFN=+$P(GMVDATA,"^",1),GMVBEG=$P(GMVDATA,"^",2),GMVEND=$P(GMVDATA,"^",3),GMVDEV=$P(GMVDATA,"^",5),GMVIEN=+$P(GMVDATA,"^",6),GMVPDT=$P(GMVDATA,"^",7)
 S ZTIO=GMVDEV ;device
 S ZTDTH=$S($G(GMVPDT)>0:GMVPDT,1:$$NOW^XLFDT()) ;date/time to print
 S (ZTSAVE("DFN"),ZTSAVE("GMVBEG"),ZTSAVE("GMVEND"))=""
 S ZTDESC="Entered in error vital/measurement report"
 S ZTRTN="START^GMVER0"
 D ^%ZTLOAD
 S RESULT=$S($G(ZTSK)>0:"Report sent to device. Task #: "_ZTSK,1:"Unable to task the report.")
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC
 Q
START ; Start the report output
 U IO
 S:$D(ZTQUEUED) ZTREQ="@"
 S GMVPAGE=0
 S GMVDASH=$$REPEAT^XLFSTR("-",80) ;line of dashes
 S GMVNOW=$$NOW^XLFDT() ;current date/time
 S GMVNOW=$$FMTE^XLFDT(GMVNOW)
 S GMVRANGE=$$FMTE^XLFDT(GMVBEG)_"-"_$$FMTE^XLFDT(GMVEND) ;date range in
 ; external format (for header)
 D DEM^VADPT ;get patient demographic data
 S GMVNAME=VADM(1) ;patient name
 S GMVSSN=$P(VADM(2),"^",2) ;patient ssn
 D EN1^GMVER1(.GMVARRAY,DFN,GMVBEG,GMVEND) ;get entered-in-error data
 D HEADER
 S GMVNONE=$G(^TMP($J,"ERRORS",0))
 I $L(GMVNONE)>0 W !,GMVNONE D KILL Q
 S GMVDATE=0
 F  S GMVDATE=$O(^TMP($J,"ERRORS",GMVDATE)) Q:'GMVDATE  D
 .S GMVITY=0
 .F  S GMVITY=$O(^TMP($J,"ERRORS",GMVDATE,GMVITY)) Q:'GMVITY  D
 ..S GMVDA=0
 ..F  S GMVDA=$O(^TMP($J,"ERRORS",GMVDATE,GMVITY,GMVDA)) Q:'GMVDA  D
 ...S GMVLOOP=0
 ...F  S GMVLOOP=$O(^TMP($J,"ERRORS",GMVDATE,GMVITY,GMVDA,GMVLOOP)) Q:'GMVLOOP  D
 ....S GMVNODE=^TMP($J,"ERRORS",GMVDATE,GMVITY,GMVDA,GMVLOOP)
 ....I $Y+6>IOSL D HEADER
 ....W !,GMVNODE
 ....I GMVLOOP=4 W !
 ....Q
 ...Q
 ..Q
 .Q
KILL ; Kill variables
 D KVAR^VADPT ;clean up VADPT variables
 K ^TMP($J,"ERRORS")
 K GMVDASH,GMVNAME,GMVNOW,GMVPAGE,GMVSSN,X,Y
 D ^%ZISC
 Q
HEADER ; Report header
 W:$Y>0 @IOF
 S GMVPAGE=GMVPAGE+1
 W !,GMVNOW,?22,"ENTERED IN ERROR VITAL/MEASUREMENT REPORT",?70,"PAGE: ",GMVPAGE
 W !?22,GMVRANGE
 W !?22,"Patient: ",GMVNAME,?$X+5,$E(GMVSSN,8,11)
 W !!,"Date Vit./Meas. taken",?58,"User who made error"
 W !,GMVDASH,!
 Q

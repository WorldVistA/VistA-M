SPNPRT09 ;HIRMFO/WAA- PRINT Application for Disp. ;10/25/96  11:30
 ;;2.0;Spinal Cord Dysfunction;**12**;01/02/1997
 ;;
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE,SPNDATE,SPNEDAT S SPNPAGE=1
 S SPNLEXIT=0
 W !!,"Report Filter: "
 S SPNA="   Enter START Date: "
 S SPNQ=" Enter the earliest date of Application for the print to START with."
 D QUEST^SPNPRT04("DA^:NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNDATE=Y
 S ZTSAVE("SPN*")=""
 S SPNA="   Enter END Date: "
 S SPNQ=" Enter the latest date of Application for the print to END with."
 D QUEST^SPNPRT04("DA^"_SPNDATE_":NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNEDAT=Y
 D DEVICE^SPNPRTMT("PRINT^SPNPRT09","Application for SCI/SCD Discharges",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine 
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNDATE
 Q
PRINT ; Print main Body
 U IO
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT,0) ; Ensure that the exit is set
 N SPNDFN,SPNX,SPNFAC
 S (SPNDFN,SPNLPRT,SPNFAC)=0
 S SPNQDAT=SPNDATE-.000001
 Q:SPNLEXIT
 F  S SPNQDAT=$O(^DPT("ADIS",SPNQDAT)) Q:(SPNQDAT<1)  Q:(SPNQDAT>SPNEDAT)  D  Q:SPNLEXIT
 . S SPNDFN=0
 . F  S SPNDFN=$O(^DPT("ADIS",SPNQDAT,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 .. Q:'$D(^SPNL(154,SPNDFN,0))  ; Patient is not in SCD Registry
 .. S ^TMP($J,"SPN",$$GET1^DIQ(2,SPNDFN,.01,"E"),SPNDFN)=""
 .. Q
 . Q
 I $D(^TMP($J,"SPN")) D  Q:SPNLEXIT  ; Indicates the report had data
 . N SPNSTATE,SPNDFN,SPNNAME,SPNCOU
 . S SPNCOU=0
 . S SPNNAME="" F  S SPNNAME=$O(^TMP($J,"SPN",SPNNAME)) Q:SPNNAME=""  D  Q:SPNLEXIT
 .. S SPNDFN=0 F  S SPNDFN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 ... D HEAD Q:SPNLEXIT
 ... D PATIENT(SPNDFN) Q:SPNLEXIT
 ... W !
 ... Q
 .. Q
 . I SPNCOU W !,?15,SPNCOU," Patients have been processed."
 . Q
 E  W !,"     ******* No Data for this report. *******"
 I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 K ^TMP($J,"SPN")
 Q
PATIENT(SPNDFN) ; Print Patient data
 Q:SPNLEXIT
 N DFN
 S DFN=SPNDFN
 D DEM^VADPT
 W !,$E(VADM(1),1,30)," (",$E(VADM(1),1),VA("BID"),")"
 D KVAR^VADPT
 K ^UTILITY("VARP",$J)
 S DFN=SPNDFN,VARP("F")=SPNDATE,VARP("T")=SPNEDAT
 D REG^VADPT
 N SPNODE,SPNNODE
 S SPNODE=0
 F  S SPNODE=$O(^UTILITY("VARP",$J,SPNODE)) Q:SPNODE<1  D  Q:SPNLEXIT
 .N SPNX,SPNY
 .S SPNX=$G(^UTILITY("VARP",$J,SPNODE,"I")) Q:SPNX=""
 .S SPNY=$G(^UTILITY("VARP",$J,SPNODE,"E")) Q:SPNY=""
 .I $X>40 D HEAD Q:SPNLEXIT  W !
 .W ?40,$$FMTE^XLFDT($P(SPNX,U),"2D"),?50,$E($P(SPNY,U,7),1,29)
 .I $P(SPNY,U,3)'="" W !,?33,"TYPE OF BENEFIT: ",$E($P(SPNY,U,3),1,29)
 .Q
 D KVAR^VADPT K ^UTILITY("VARP",$J)
 Q
HEAD ; Header Print
 I SPNPAGE'=1 Q:$Y<(IOSL-4)
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPAGE=1 W @IOF Q
 .I SPNPAGE'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1
 ..K Y
 ..Q
 .Q
 Q:SPNLEXIT
 I SPNPAGE'=1 W @IOF
 W !,$$FMTE^XLFDT($$NOW^XLFDT,1),?70,"Page: ",SPNPAGE
 W !!,?30,"Applications for Inpatient Care"
 W !,?32,"From: ",$$FMTE^XLFDT(SPNDATE,"2D")," to: ",$$FMTE^XLFDT(SPNEDAT,"2D")
 W !!,?40,"Date of"
 W !,"Patient",?40,"Dispos.",?50,"Disposition"
 W !,$$REPEAT^XLFSTR("-",79)
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q

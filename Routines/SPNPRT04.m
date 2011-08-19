SPNPRT04 ;HIRMFO/WAA- PRINT New SCD/SCI Registrant ;8/29/96  15:41
 ;;2.0;Spinal Cord Dysfunction;**12**;01/02/1997
 ;;
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE,SPNDATE S SPNPAGE=1
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 W !!,"Report Filter: "
 S SPNA="   Enter Original Registration START Date: "
 S SPNQ=" Enter the earliest date of original registration for the print to START with."
 D QUEST("DA^:NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNDATE=Y
 S ZTSAVE("SPN*")=""
 S SPNA="   Enter Original Registration END Date: "
 S SPNQ=" Enter the Last date of original registration for the print to END with."
 D QUEST("DA^"_SPNDATE_":NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNEDAT=Y
 D DEVICE^SPNPRTMT("PRINT^SPNPRT04","SCD New Patient Registrants",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
QUEST(SPNX,SPNA,SPNQ) ; Report Question
 N DIR
 S DIR(0)=SPNX
 S DIR("A")=SPNA
 S DIR("?")=SPNQ
 D ^DIR
 I $D(DIRUT) S SPNLEXIT=1 W !,"Print Aborted!" Q
 Q
EXIT ; Exit routine 
 K SPNLEXIT,SPNIO,SPNPAGE,SPNDATE
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNDATE
 Q
PRINT ; Print main Body
 U IO
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT,0) ; Ensure that the exit is set
 N SPNDFN,SPNX
 S (SPNDFN,SPNLPRT)=0
 Q:SPNLEXIT
 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:SPNDFN<1  D
 . Q:$G(^SPNL(154,SPNDFN,0))=""  ; No Zero node
 . I '$$EN2^SPNPRTMT(SPNDFN) Q  ; Patient fail the filters
 . S DFN=SPNDFN D DEM^VADPT
 . I $$GET^DDSVAL(154,SPNDFN,.02,"","I")<SPNDATE Q
 . I $$GET^DDSVAL(154,SPNDFN,.02,"","I")>SPNEDAT Q
 . S ^TMP($J,"SPN",VADM(1),SPNDFN)="" ; Sort the data
 . D KVAR^VADPT
 . Q
 I $D(^TMP($J,"SPN")) D  Q:SPNLEXIT  ; Indicates the report had data
 . N SPNSTATE,SPNDFN,SPNNAME,SPNCOU
 . S SPNCOU=0
 . S SPNNAME="" F  S SPNNAME=$O(^TMP($J,"SPN",SPNNAME)) Q:SPNNAME=""  D  Q:SPNLEXIT
 .. S SPNDFN=0 F  S SPNDFN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 ... D HEAD Q:SPNLEXIT
 ... D PATIENT(SPNDFN) Q:SPNLEXIT
 ... Q
 .. Q
 . W !,?15,SPNCOU," Patients have been processed."
 . Q
 E  W !,"     ******* No Data for this report. *******"
 I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 K ^TMP($J,"SPN")
 Q
PATIENT(SPNDFN) ; Print Patient data
 Q:SPNLEXIT
 N SPNETI,SPNZZ
 S DFN=SPNDFN,SPNETI=0
 D DEM^VADPT
 W !,$E(VADM(1),1,18),?20,VA("PID"),?33,$$FMTE^XLFDT($P(^SPNL(154,SPNDFN,0),"^",2),"5DZP")
 S SPNETI=$O(^SPNL(154,SPNDFN,"E",SPNETI))
 I SPNETI'<1 D ETI
 W ?65,$E($$GET^DDSVAL(154,SPNDFN,2.6,"","E"),1,15)
 ;S SPNZZ=1
 ;I SPNETI'<1 F  S SPNETI=$O(^SPNL(154,SPNDFN,"E",SPNETI)) Q:SPNETI<1  D  Q:SPNLEXIT
 ;.Q:SPNLEXIT
 ;.D ETI S SPNZZ=0
 ;.Q
 S SPNCOU=SPNCOU+1
 Q
ETI ;Print A patinet Etiology
 N SPNETO
 S SPNETO=$P($G(^SPNL(154,SPNDFN,"E",SPNETI,0)),U) Q:SPNETO=""
 W ?45,$E($$GET^DDSVAL(154.03,SPNETO,.01,"","E"),1,18)
 Q
HEAD ; Header Print
 I SPNPAGE>1 Q:$Y<(IOSL-4)
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
 W !,?18,"Listing of NEW SCD/SCI Patients Since ",$$FMTE^XLFDT(SPNDATE,1)
 W !,"Patient",?20,"SSN",?33,"Original",?45,"Etiology",?65,"VA SCI Status"
 W !,?33,"Regis Date"
 W !,$$REPEAT^XLFSTR("-",79)
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q

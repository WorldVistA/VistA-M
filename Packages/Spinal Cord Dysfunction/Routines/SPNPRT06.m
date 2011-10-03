SPNPRT06 ;HIRMFO/WAA- PRINT Follow-Up Rehab Not viewed ;8/29/96  15:41
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE,SPNDATE S SPNPAGE=1
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 W !!,"Report Filter: "
 S SPNA="   Enter Rehab Offered START Date: "
 S SPNQ=" Enter the earliest date the Rehab eval was offered for the print to START with."
 D QUEST^SPNPRT04("DA^:NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNDATE=Y
 S ZTSAVE("SPN*")=""
 S SPNA="   Enter Rehab Offered END Date: "
 S SPNQ=" Enter the Last date the Rehab eval for the print to END with."
 D QUEST^SPNPRT04("DA^"_SPNDATE_":NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNEDAT=Y
 D DEVICE^SPNPRTMT("PRINT^SPNPRT06","SCD Follow-up Rehab report",.ZTSAVE) Q:SPNLEXIT
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
 N SPNDFN,SPNX
 S (SPNDFN,SPNLPRT)=0
 Q:SPNLEXIT
 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:SPNDFN<1  D
 . Q:$G(^SPNL(154,SPNDFN,0))=""  ; No Zero node
 . I '$$EN2^SPNPRTMT(SPNDFN) Q  ; Patient fail the filters
 . I $G(^SPNL(154,SPNDFN,"REHAB",0))="" Q  ; No rehab for patient
 . N SPNDT
 . S SPNDT=SPNDATE-.000001
 . F  S SPNDT=$O(^SPNL(154,SPNDFN,"REHAB","B",SPNDT)) Q:SPNDT<1  D
 .. Q:SPNDT>SPNEDAT
 .. N SPNIEN
 .. S SPNIEN=0
 .. F  S SPNIEN=$O(^SPNL(154,SPNDFN,"REHAB","B",SPNDT,SPNIEN)) Q:SPNIEN<1  D
 ... Q:'$D(^SPNL(154,SPNDFN,"REHAB",SPNIEN,0))
 ... S ^TMP($J,"SPN",$$GET^DDSVAL(2,SPNDFN,.01,"","E"),SPNDFN)="" ; Sort the data
 ... Q
 ..Q
 .Q
 I $D(^TMP($J,"SPN")) D  Q:SPNLEXIT  ; Indicates the report had data
 . N SPNSTATE,SPNDFN,SPNNAME,SPNCOU,SPNDT,SPNIEN
 . S SPNCOU=0
 . S SPNNAME="" F  S SPNNAME=$O(^TMP($J,"SPN",SPNNAME)) Q:SPNNAME=""  D  Q:SPNLEXIT
 .. S SPNDFN=0 F  S SPNDFN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 ... D HEAD Q:SPNLEXIT
 ... D PATIENT(SPNDFN) Q:SPNLEXIT
 ... Q
 .. Q
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
 N SPNETI,SPNZZ,SPNIEN
 S DFN=SPNDFN,(SPNETI,SPNIEN)=0
 D DEM^VADPT
 W !,$E(VADM(1),1,24)
 S SPNIEN=$O(^SPNL(154,SPNDFN,"REHAB",SPNIEN)) ; Rehab Data
 I SPNIEN'<1 D REHAB
 ;W $$GET^DDSVAL(154,SPNDFN,.02,"","E")
 S SPNETI=$O(^SPNL(154,SPNDFN,"E",SPNETI)) ; Etiology data
 I SPNETI'<1 D ETI
 ;W ?65,$E($$GET^DDSVAL(2,.SPNDFN,57.4,"","E"),1,15)
 D NXTLN
 S SPNCOU=SPNCOU+1 W !
 Q
NXTLN ; This is to create the following lines
 N SPNZZ
 W !,VA("PID") S SPNZZ=0
NXTLP ; The main loop
 I SPNZZ'=0 W !
 I SPNIEN'<1 S SPNIEN=$O(^SPNL(154,SPNDFN,"REHAB",SPNIEN))
 I SPNIEN'<1  D REHAB
 I SPNETI'<1 S SPNETI=$O(^SPNL(154,SPNDFN,"E",SPNETI))
 I SPNETI'<1  D ETI
 I SPNETI<1,SPNIEN<1 Q
 S SPNZZ=1 G NXTLP
 Q
ETI ;Print A patinet Etiology
 N SPNETO
 S SPNETO=$P($G(^SPNL(154,SPNDFN,"E",SPNETI,0)),U) Q:SPNETO=""
 W ?58,$E($$GET^DDSVAL(154.03,SPNETO,.01,"","E"),1,20)
 Q
REHAB ;Print a patient's rehab information
 N SPNDATE
 Q:$G(^SPNL(154,SPNDFN,"REHAB",SPNIEN,0))=""
 S SPNDATE=$P(^SPNL(154,SPNDFN,"REHAB",SPNIEN,0),U) Q:SPNDATE=""  ;
 S SPNDAT2=$P(^SPNL(154,SPNDFN,"REHAB",SPNIEN,0),U,2)
 W ?26,$$FMTE^XLFDT(SPNDATE,"1D")
 I SPNDAT2'="" W ?43,$$FMTE^XLFDT(SPNDAT2,"1D")
 Q
HEAD ; Header Print
 Q:$Y<(IOSL-4)
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
 W !,?6,"Listing of Patient with Offered Rehab FROM: ",$$FMTE^XLFDT(SPNDATE,"2D")," TO: ",$$FMTE^XLFDT(SPNEDAT,"2D")
 W !!,?26,"Rehab",?43,"Rehab"
 W !,"Patient",?26,"Offered",?43,"Received",?58,"SCD Cause"
 W !,$$REPEAT^XLFSTR("-",79)
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q

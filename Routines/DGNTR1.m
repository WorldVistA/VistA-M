DGNTR1 ;ALB/RPM - N/T RADIUM PENDING VERIFICATION REPORT ; 10/4/01 11:05am
 ;;5.3;Registration;**397**;Aug 13, 1993
 ;
 ;This report lists all patients with an entry in the NTR HISTORY
 ;file (#28.11) that are pending verification.
 ;The report can be tasked using TaskMan and the EN^DGNTR1 entry point.
 ;The option allows manual generation of the report using a user selected
 ;output device.
 ;
 Q   ;No direct entry
 ;
EN ;Entry point
 I '$D(ZTQUEUED) D MAN Q
 ;
QEN ;Start point for TaskMan queuing
 D START
 Q
 ;
MAN ;Start point for manual report allows sort order and device selection
 N DGSORT
 S DGSORT=$$ASKSTAT^DGNTQ("Enter the sort type","NAME","SM^N:NAME;D:DATE")
 Q:DGSORT=0
 I $$DEVICE() D START
 Q
 ;
DEVICE() ;Allow user selection of output device
 ; Input: none
 ;
 ; Output: Function value    Interpretation
 ;               0           User decides to queue or not print report. 
 ;               1           Device selected to generate report NOW. 
 ;
 N OK,IOP,POP,%ZIS,DGX
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 I OK,$D(IO("Q")) D
 . N ZTRTN,ZTDESC,ZTSAVE,ZTSK
 . S ZTRTN="START^DGNTR1"
 . S ZTSAVE("DGSORT")=""
 . S ZTDESC="Current N/T Radium Treatment Pending Verification report."
 . F DGX=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 . W !,$S($D(ZTSK):"Request "_ZTSK_" Queued!",1:"Request Cancelled!"),!
 . D HOME^%ZIS
 . S OK=0
 Q OK
 ;
START ;
 D LOOP(DGSORT)
 D PRINT(DGSORT)
 D EXIT
 Q
 ;
LOOP(DGSORT) ;Locate all entries that are pending verification
 ;and build ^TMP("DGNT",$J, with data
 N DGIEN   ;NTR record IEN
 N DGSTAT  ;Screening Status
 K ^TMP("DGNT",$J)
 S DGIEN=0
 F DGSTAT=2,3 D
 . F  S DGIEN=$O(^DGNT(28.11,"AST",DGSTAT,1,DGIEN)) Q:'DGIEN  D
 . . D BLDTMP(DGIEN,DGSORT,DGSTAT)
 Q
 ;
BLDTMP(DGIEN,DGSORT,DGST) ;^TMP("DGNT",$J global builder
 ; Build TMP file based on sort selection
 ;
 ; Input:
 ;    DGIEN  - IEN to patient's NTR record
 ;    DGSORT - sort type ("N"ame or "D"ate)
 ;    DGST   - screening status (2-Pend Doc, 3-Pend DX)
 ;
 N DGX,DGNT,DFN
 N DGNAME,DGSSN,DGHNC,DGNTR,DGAVI,DGSUB,DGDATE,VADM
 N X,X1,X2,Y
 ;validate input parameters
 Q:'$G(DGIEN)
 Q:'$G(DGST)
 S DGSORT=$G(DGSORT)
 ;
 S DGX=$S(DGSORT="D":"DGDATE",1:"DGNAME")
 Q:'$$GETREC^DGNTAPI(DGIEN,"DGNT")
 S DFN=+$G(DGNT("DFN"))
 I DFN>0 D
 . Q:'+$G(DGNT("PRIM"))   ;if not NTR PRIMARY ENTRY, quit out
 . D ^VADPT
 . S DGNAME=VADM(1)
 . S DGSSN=$P(VADM(2),U,2)
 . S DGNTR=$P($G(DGNT("NTR")),"^")
 . S DGAVI=$P($G(DGNT("AVI")),"^")
 . S DGSUB=$P($G(DGNT("SUB")),"^")
 . S DGDATE=$G(DGNT("EDT"))
 . S ^TMP("DGNT",$J,DGST,@DGX,DGIEN)=DGNAME_U_DGSSN_U_DGNTR_U_DGAVI_U_DGSUB_U_DGDATE
 . S ^TMP("DGNT",$J,"TOT"_DGST)=$G(^TMP("DGNT",$J,"TOT"_DGST))+1
 . S ^TMP("DGNT",$J,"TOT")=$G(^TMP("DGNT",$J,"TOT"))+1
 Q
 ;
PRINT(DGSORT) ;
 U IO
 N DGST
 N DGX,DGIEN
 N DGFIRST,DGLINE
 N DGSITE,DGSTNUM,DGSTTN,DGSTN
 N DGQUIT,DGPAGE
 N DGDDT  ;current date/time for header display
 S DGSORT=$G(DGSORT)
 S DGSITE=$$SITE^VASITE
 S DGSTNUM=$P(DGSITE,U,3),DGSTN=$P(DGSITE,U,2)
 S DGSTTN=$$NAME^VASITE(DT)
 S DGSTN=$S($G(DGSTTN)]"":DGSTTN,1:$G(DGSTN))
 S DGQUIT=0
 S DGPAGE=0
 S DGX=$S(DGSORT="D":"DGDATE",1:"DGNAME")
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 D HEAD(DGDDT)
 I '$D(^TMP("DGNT",$J)) D  Q
 . W !!!?20,"**** No records to report. ****"
 S @DGX=""
 F DGST=2,3 D
 . F  S @DGX=$O(^TMP("DGNT",$J,DGST,@DGX)) Q:@DGX']""  D  Q:DGQUIT
 .. S DGIEN=""
 .. F  S DGIEN=$O(^TMP("DGNT",$J,DGST,@DGX,DGIEN)) Q:DGIEN=""  D  Q:DGQUIT
 ... D:$Y>(IOSL-4) HEAD(DGDDT)
 ... Q:DGQUIT
 ... S DGLINE=$G(^TMP("DGNT",$J,DGST,@DGX,DGIEN))
 ... W !,$P(DGLINE,U),?30,$P(DGLINE,U,2),?43,$P(DGLINE,U,3),?47,$P(DGLINE,U,4),?51,$P(DGLINE,U,5),?54,$$FMTE^XLFDT($P(DGLINE,U,6))
 . Q:DGQUIT
 . W !!?5,"Total Patients Pending "_$S(DGST=2:"Documentation",1:"Diagnosis")_" Verification: "_+$G(^TMP("DGNT",$J,"TOT"_DGST))
 . I DGST=2 D HEAD(DGDDT)
 ;
 ;Shutdown if stop task requested
 I DGQUIT W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
 ;
 W !!?5,"Total Patients Pending Verification: "_$G(^TMP("DGNT",$J,"TOT"))
 I $G(DGPAGE)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q
 ;
HEAD(DGDT) ;Print/Display page header
 ;
 ;  Input:
 ;    DGDT - current date/time for display
 ;  Output
 ;    none
 ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQUIT)=1 Q
 I $G(DGPAGE)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q:DGQUIT
 W @IOF
 S DGPAGE=$G(DGPAGE)+1
 W !,DGDT,?15,"N/T RADIUM TREATMENT PENDING VERIFICATION REPORT",?70,"Page: ",$G(DGPAGE)
 W !,"STATION: "_$G(DGSTN)
 W !!,"Patient Name",?30,"SSN",?42,"NT",?46,"Avi",?50,"Sub",?54,"Date/Time Entered"
 W !,"-----------------------",?30,"-----------",?42,"---",?46,"---",?50,"---",?54,"----------------------"
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP("DGNT",$J)
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q

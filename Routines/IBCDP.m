IBCDP ;ALB/ARH - AUTOMATED BILLER PRINT ; 12/01/04
 ;;2.0;INTEGRATED BILLING;**287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; OPTION ENTRY POINT:  Auto Biller Report - get parameters then run the report
 N X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT,IBSDR,IBDATES,IBSEV,IBSBC,IBPATS,IBQUIT K ^TMP($J,"IBCDP")
 W !!!,"Auto Biller Results Report"
 W !,"This report contains results of the activity from the Third Party Auto Biller."
 W !,"The Third Party Auto Biller processes Claims Tracking entries and may create a"
 W !,"bill.  This report will provide detail for all processed entries, including the"
 W !,"bill number if a bill was created or the reason a bill could not be created."
 ;
 ; select sort/select by Auto Biller Date or Event Date
 S DIR("?")="Sort the report by Event Date or by the Date(s) the Auto Biller Processed the Events."
 S DIR(0)="S^1:Event Date;2:Auto Biller Date",DIR("B")="Event Date",DIR("A")="Sort By"
 D ^DIR S IBSDR=+Y K DIR W ! I ('Y)!($D(DIRUT)) Q
 ;
 ; get date range
 S IBDATES=$S(IBSDR=1:"Event Date",1:"Auto Biller Date"),IBDATES=$$FMDATES^IBCU2(IBDATES) I IBDATES="" Q
 ;
 ; get types of events to include in report
 S DIR("?")="Select the Types of Events to include in the report."
 S DIR(0)="S^1:Inpatient Admissions;2:Outpatient Visits;3:Prescriptions;4:All",DIR("B")="All",DIR("A")="Include"
 D ^DIR S IBSEV=$S(+Y=4:"",1:+Y) K DIR I ('Y)!($D(DIRUT)) Q
 ;
 ; get types of auto biller results to include in report, either bill created or not
 S DIR("?")="Include Claims Tracking events the Auto Biller was able to create bills for or those events the Auto Biller could not create a bill for (with the reason) or both types of events."
 S DIR(0)="S^1:Bill Auto Created;2:No Bill Created;3:All",DIR("B")="All",DIR("A")="Include"
 D ^DIR S IBSBC=$S(+Y=3:"",1:+Y) K DIR I ('Y)!($D(DIRUT)) Q
 ;
 ; get range of patient names
 S DIR("?")="Select range of Patient Names to include in report." W !
 S DIR(0)="FO" S DIR("B")="FIRST",DIR("A")="START WITH PATIENT NAME"
 D ^DIR Q:$D(DIRUT)  K DIR S IBPATS=$E(Y,1,$L(Y)-1)_$C($A($E(Y,$L(Y)))-1)_"~" I Y="FIRST" S IBPATS=""
 ;
 S DIR("?")="Select range of Patient Names to include in report."
 S DIR(0)="FO^^I X'=""LAST"","""_IBPATS_"""]X K X",DIR("B")="LAST",DIR("A")="GO TO PATIENT NAME"
 D ^DIR Q:$D(DIRUT)  K DIR S:Y="LAST" Y="" S $P(IBPATS,U,2)=Y_"~"
 ;
 W !!,"Report requires 132 columns.",!
 S IBQUIT=0 D DEV I IBQUIT G EXIT
 ;
RPT ;find, save, and print Auto Biller Report - entry for tasked jobs
 ;
 I IBSDR=1 D SORT1
 I IBSDR=2 D SORT2
 ;
 D PRINT
 ;
EXIT ;clean up and quit
 K ^TMP($J,"IBCDP") Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
 ;
SORT1 ; sort by Event Date in Claims Tracking
 ; for each CT entry within the selected date range check/get it's auto biller entries, if they meet the criteria
 N IBBEG,IBEND,IBEVDT,IBCTFN,IBABFN Q:'$G(IBDATES)
 ;
 S IBBEG=+$P(IBDATES,U,1)-.01,IBEND=+$P(IBDATES,U,2)+.7
 ;
 S IBEVDT=IBBEG F  S IBEVDT=$O(^IBT(356,"D",IBEVDT)) Q:('IBEVDT)!(IBEVDT>IBEND)  D
 . S IBCTFN=0 F  S IBCTFN=$O(^IBT(356,"D",IBEVDT,IBCTFN)) Q:'IBCTFN  D
 .. ;
 .. S IBABFN=0 F  S IBABFN=$O(^IBA(362.1,"C",IBCTFN,IBABFN)) Q:'IBABFN  D
 ... ;
 ... D GETLN(IBABFN)
 Q
 ;
SORT2 ; sort by Entry Date in Auto Biller
 ; for each AB entry within the selected date range check/get the entry, if they meet the criteria
 N IBBEG,IBEND,IBABFN,IBETDT Q:'IBDATES
 ;
 S IBBEG=+$P(IBDATES,U,1)-.01,IBEND=+$P(IBDATES,U,2)+.7
 ;
 S IBABFN=0  F  S IBABFN=$O(^IBA(362.1,IBABFN)) Q:'IBABFN  D
 . S IBETDT=$P($G(^IBA(362.1,IBABFN,0)),U,5)
 . ;
 . I (IBETDT<IBBEG)!(IBETDT>IBEND) Q
 . ;
 . D GETLN(IBABFN)
 ;
 Q
 ;
 ;
GETLN(IBABFN) ; check and select auto biller entries that meet the criteria, Input: all select criteria
 ; Output:  ^TMP($J,"IBCDP",sort date,event type,patient name_event date/time, AB FN) = CT FN
 N IBAB0,IBCTFN,IBCT0,IBCTDT,IBCTTY,DFN,IBDFNN,IBABDT,IBDTBEG,IBDTEND,IBPTBEG,IBPTEND,IBSORT1,IBSORT3,IBX
 Q:'$G(IBSDR)  Q:'$G(IBDATES)  S IBSEV=$G(IBSEV),IBSBC=$G(IBSBC),IBPATS=$G(IBPATS)
 ;
 S IBAB0=$G(^IBA(362.1,+$G(IBABFN),0)) Q:IBAB0=""
 S IBCTFN=$P(IBAB0,U,2) Q:'IBCTFN  S IBCT0=$G(^IBT(356,IBCTFN,0)) Q:IBCT0=""
 ;
 S IBCTDT=$P(IBCT0,U,6),IBCTTY=$P(IBCT0,U,18)
 S DFN=$P(IBCT0,U,2) Q:'DFN  S IBDFNN=$P($G(^DPT(DFN,0)),U,1)
 S IBABDT=$P(IBAB0,U,5)
 ;
 S IBDTBEG=+$P(IBDATES,U,1)-.01,IBDTEND=+$P(IBDATES,U,2)+.7
 S IBPTBEG=$P(IBPATS,U,1),IBPTEND=$P(IBPATS,U,2)
 ;
 ;
 I IBSDR=1 I (IBCTDT<IBDTBEG)!(IBCTDT>IBDTEND) Q  ; check entry within CT event date
 I IBSDR=2 I (IBABDT<IBDTBEG)!(IBABDT>IBDTEND) Q  ; check entry within AB entry date
 ;
 I IBSEV=1 I IBCTTY'=1 Q  ; check types of events to include
 I IBSEV=2 I IBCTTY'=2 Q
 I IBSEV=3 I IBCTTY'=4 Q
 ;
 I +IBSBC S IBX=$$CHKBILL(IBCTFN) ; check if a bill is associated with the AB entry
 I IBSBC=1,'IBX Q
 I IBSBC=2,+IBX Q
 ;
 I IBPTBEG'="",IBDFNN']IBPTBEG Q  ; check patient name is within the range selected
 I IBPTEND'="",IBDFNN]IBPTEND Q
 ;
 ;
 S IBSORT1=$S(IBSDR=1:IBCTDT,1:IBABDT),IBSORT1=$E(IBSORT1,1,7) ; sort by CT event date or AB entry date
 S IBSORT3=IBDFNN_" ^"_IBCTDT ; sort by patient name and date/time
 ;
 S ^TMP($J,"IBCDP",+IBSORT1,+IBCTTY,IBSORT3,IBABFN)=IBCTFN
 Q
 ;
CHKBILL(IBCTFN) ; return first bill found if Claims Tracking event had a bill created for it
 N IBX,IBABFN,IBAB0 S IBX=0
 I +$G(IBCTFN) S IBABFN=0 F  S IBABFN=$O(^IBA(362.1,"C",IBCTFN,IBABFN)) Q:'IBABFN  D  Q:+IBX
 . S IBAB0=$G(^IBA(362.1,IBABFN,0)) S IBX=+$P(IBAB0,U,3)
 Q IBX
 ;
 ;
 ;
PRINT ;print the report from the temp sort file to the appropriate device
 N IBSCRPT,IBPGN,IBLN,IBQUIT,IBS1,IBS2,IBS3,IBABFN,IBAB0,IBCTFN,IBCT0,DFN,IBDFN0,IBBLFN,IBBL0,IBBLU,IBX
 N IBDFNN,IB1U4N,IBTYP,IBEVDT,IBBILL,IBBSTAT,IBBTF,IBBSF,IBBST,IBABC,IBHDR1,IBHDR2,IBHDR3,IBHDR4
 I '$D(ZTQUEUED) U IO
 S IBSCRPT="IBCDP",IBPGN=0,IBLN=99999,IBQUIT=0 D GETHDR Q:$$HDR
 ;
 S IBS1="" F  S IBS1=$O(^TMP($J,IBSCRPT,IBS1)) Q:IBS1=""  D  Q:IBQUIT
 . I +$G(IBSDR) W !,?20,$S(IBSDR=1:"Event Date: ",1:"Auto Bill Date: "),$$FMTE^XLFDT(IBS1),! S IBLN=IBLN+2
 . ;
 . S IBS2="" F  S IBS2=$O(^TMP($J,IBSCRPT,IBS1,IBS2)) Q:IBS2=""  D  Q:IBQUIT  W ! S IBLN=IBLN+1
 .. S IBS3="" F  S IBS3=$O(^TMP($J,IBSCRPT,IBS1,IBS2,IBS3)) Q:IBS3=""  D  Q:IBQUIT
 ... S IBABFN="" F  S IBABFN=$O(^TMP($J,IBSCRPT,IBS1,IBS2,IBS3,IBABFN)) Q:IBABFN=""  D  S IBQUIT=$$HDR Q:IBQUIT
 .... ;
 .... S IBAB0=$G(^IBA(362.1,IBABFN,0)) Q:IBAB0=""
 .... S IBCTFN=$P(IBAB0,U,2) Q:'IBCTFN  S IBCT0=$G(^IBT(356,IBCTFN,0)) Q:IBCT0=""
 .... S DFN=$P(IBCT0,U,2) Q:'DFN  S IBDFN0=$G(^DPT(DFN,0))
 .... S IBBLFN=$P(IBAB0,U,3),IBBL0="",IBBLU=""
 .... I +IBBLFN S IBBL0=$G(^DGCR(399,IBBLFN,0)),IBBLU=$G(^DGCR(399,IBBLFN,"U"))
 .... ;
 .... S IBDFNN=$P(IBDFN0,U,1)
 .... S IB1U4N=$E(IBDFN0,1)_$E($P(IBDFN0,U,9),6,9)
 .... S IBTYP=$P($G(^IBE(356.6,+$P(IBCT0,U,18),0)),U,1)
 .... S IBEVDT=$$FMTE^XLFDT($P(IBCT0,U,6)),IBEVDT=$TR(IBEVDT,"@"," ")
 .... S IBBILL=$P(IBBL0,U,1)
 .... S IBBSTAT=$$EXSET^IBEFUNC($P(IBBL0,U,13),399,.13)
 .... S IBBTF=$$EXSET^IBEFUNC($P(IBBL0,U,6),399,.06)
 .... S IBBSF=$$FMTE^XLFDT(IBBLU)
 .... S IBBST=$$FMTE^XLFDT($P(IBBLU,U,2))
 .... ;
 .... W !,$E(IBDFNN,1,20),?22,$E(IB1U4N,1,6),?30,$E(IBTYP,U,4),?37,$P(IBEVDT,":",1,2),?60,IBBILL,?70,$E(IBBSTAT,1,7),?82,$E(IBBTF,1,15),?102,IBBSF,?117,IBBST S IBLN=IBLN+1
 .... ;
 .... S IBABC=0 F  S IBABC=$O(^IBA(362.1,IBABFN,11,IBABC)) Q:'IBABC  D
 ..... S IBX=$G(^IBA(362.1,IBABFN,11,IBABC,0)) I IBX'="" W !,?37,IBX S IBLN=IBLN+1
 ;
 I 'IBQUIT D PAUSE
 Q
 ;
 ;
GETHDR ; set up header lines
 S IBHDR1="AUTOMATED BILLER ERRORS/COMMENTS FOR "_$$FMTE^XLFDT($G(IBDATES))_" - "_$$FMTE^XLFDT($P($G(IBDATES),U,2))
 S IBHDR1=IBHDR1_$J("",(IOM-$L(IBHDR1)-30))_$P($$HTE^XLFDT($H),":",1,2)_$J("",$L(IOM-8))_"Page "
 S IBHDR2="                              EVENT                         BILL                  TIMEFRAME OF        STATEMENT      STATEMENT"
 S IBHDR3="PATIENT                       TYPE   EPISODE DATE           NUMBER    STATUS      BILL                COVERS FROM    COVERS TO"
 S IBHDR4="",$P(IBHDR4,"-",IOM+1)=""
 Q
 ;
 ;
HDR() ;print the report header
 N IBQUIT,X,Y S IBQUIT=0
 S IBQUIT=$$STOP I +IBQUIT G HDRQ
 I IBLN<(IOSL-5) G HDRQ
 I IBPGN>0 D PAUSE I +IBQUIT G HDRQ
 S IBPGN=IBPGN+1,IBLN=5
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ;
 W !,IBHDR1,IBPGN,!,IBHDR2,!,IBHDR3,!,IBHDR4
HDRQ Q IBQUIT
 ;
 ;
PAUSE ;pause at end of screen if being displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
 ;
DEV ;get the device
 S IBQUIT=0 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="RPT^IBCDP",ZTDESC="Auto Biller Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") S IBQUIT=1
 Q
 ;
STOP() ; determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)

IBCERP3 ;ALB/TMP - EDI BATCHES WAITING MORE THAN 1 DAY REPORT ;30-SEP-96
 ;;2.0;INTEGRATED BILLING;**137,296,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
PENDING ; Report of batches not sent after the day the bills in it were extracted - report entry point
 ;
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBCLM
 I '$O(^IBA(364.1,"ASTAT","P",0)) W !!,"There are no batches that are Pending Austin Receipt.",! S DIR(0)="E" D ^DIR K DIR G EX
 ;
 ; Ask user if they want to include claim level detail
 S DIR(0)="Y",DIR("A")="Include Claims in each Batch",DIR("B")="Yes"
 W ! D ^DIR K DIR
 I $D(DIRUT) G EX
 S IBCLM=+Y
 ;
 D DEVICE
EX ;
 Q
 ;
DEVICE ; selection of device on which to print report
 NEW ZTRTN,ZTDESC,ZTSAVE,POP
 W !!,"This report is 80 characters wide."
 S ZTRTN="COMPILE^IBCERP3"
 S ZTDESC="REPORT OF BILL BATCHES WAITING AUSTIN RECEIPT AFTER 1 DAY"
 S ZTSAVE("IBCLM")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM")
DEVICEX ;
 Q
 ;
COMPILE ; Queued job entrypoint
 N IBBA,IB0,IB1,IEN,IBZ,IBIFN,IB399,CLM,BALDUE,IBSTAT,ARSTAT,IB
 ;
 K ^TMP($J,"IBSORT")
 S IBBA=0
 F  S IBBA=$O(^IBA(364.1,"ASTAT","P",IBBA)) Q:'IBBA  D
 . I $$BCHCHK^IBCEBUL(IBBA) Q    ; Batch check function
 . S IB0=$G(^IBA(364.1,IBBA,0)),IB1=$G(^(1))
 . S:$P(IB0,U,7)="" $P(IB0,U,7)="~"
 . S ^TMP($J,"IBSORT",$P(IB0,U,7),$P(IB0,U,1),IBBA)=$P(IB1,U,6)_U_$P(IB0,U,4)
 . ;
 . I 'IBCLM Q   ; include claim data flag
 . ;
 . ; gather the EDI claim data for this batch
 . S IEN=0 F  S IEN=$O(^IBA(364,"C",IBBA,IEN)) Q:'IEN  D
 .. S IBZ=$G(^IBA(364,IEN,0)),IBIFN=+IBZ,IB399=$G(^DGCR(399,IBIFN,0))
 .. S CLM=$P(IB399,U,1) S:CLM="" CLM="~"
 .. S BALDUE=$G(^DGCR(399,IBIFN,"U1")),BALDUE=$P(BALDUE,U,1)-$P(BALDUE,U,2)
 .. S IBSTAT=$$EXTERNAL^DILFD(399,.13,,$P(IB399,U,13))
 .. S ARSTAT=$$EXTERNAL^DILFD(430,8,,+$P($$BILL^RCJIBFN2(IBIFN),U,2))
 .. S IB=$P(IBZ,U,8)_U_BALDUE_U_$P(IBZ,U,3)_U_IBSTAT_U_ARSTAT
 .. S ^TMP($J,"IBSORT",$P(IB0,U,7),$P(IB0,U,1),IBBA,CLM,IEN)=IB
 .. Q
 . Q
 ;
 D PRINT                         ; print report
 D ^%ZISC                        ; close the device
 K ^TMP($J,"IBSORT")             ; clean up scratch global
 I $D(ZTQUEUED) S ZTREQ="@"      ; purge the task record
 ;
COMPX ;
 Q
 ;
PRINT ; print the report to the specified device
 ;
 NEW CRT,IBPAGE,IBSTOP,IBCT,IBTYP,IBBAT,IBBA,IBV,CLM,IEN,DIR,X,Y,Z
 I IOST["C-" S CRT=1
 E  S CRT=0
 ;
 S IBPAGE=0
 I '$D(^TMP($J,"IBSORT")) D HDR1 W !,?3,"No batches found Pending Austin Receipt for >1 day."
 S (IBSTOP,IBCT)=0
 ;
 S IBTYP=""
 F  S IBTYP=$O(^TMP($J,"IBSORT",IBTYP)) Q:IBTYP=""  D  Q:IBSTOP
 . D HDR1
 . S IBBAT=""
 . F  S IBBAT=$O(^TMP($J,"IBSORT",IBTYP,IBBAT)) Q:'IBBAT!(IBSTOP)  S IBBA=0 F  S IBBA=$O(^TMP($J,"IBSORT",IBTYP,IBBAT,IBBA)) Q:'IBBA!IBSTOP  S IBV=$G(^(IBBA)) D  Q:IBSTOP
 .. D:$Y>(IOSL-4) HDR1 Q:IBSTOP
 .. W !,?2,IBBAT,?16,$$FMTE^XLFDT($P(IBV,U,1),"5Z"),?42,$P(IBV,U,2)
 .. S IBCT=IBCT+1
 .. I 'IBCLM Q    ; no claim level detail
 .. I $O(^TMP($J,"IBSORT",IBTYP,IBBAT,IBBA,""))="" Q   ; no claim data
 .. ;
 .. D:$Y>(IOSL-4) HDR1 Q:IBSTOP
 .. W !!?5,"Claim",?14,"Seq",?22,"Bal Due",?32,"EDI Stat",?43,"IB Status",?57,"AR Status"
 .. S CLM="" F  S CLM=$O(^TMP($J,"IBSORT",IBTYP,IBBAT,IBBA,CLM)) Q:CLM=""!IBSTOP  S IEN=0 F  S IEN=$O(^TMP($J,"IBSORT",IBTYP,IBBAT,IBBA,CLM,IEN)) Q:'IEN!IBSTOP  D  Q:IBSTOP
 ... S IBV=$G(^TMP($J,"IBSORT",IBTYP,IBBAT,IBBA,CLM,IEN))
 ... D:$Y>(IOSL-4) HDR1 Q:IBSTOP
 ... W !,?5,CLM,?15,$P(IBV,U,1),?19,$J($FN($P(IBV,U,2),"",2),10),?35,$P(IBV,U,3),?43,$E($P(IBV,U,4),1,11),?57,$E($P(IBV,U,5),1,16)
 ... Q
 .. ;
 .. Q:IBSTOP
 .. D:$Y>(IOSL-4) HDR1 Q:IBSTOP
 .. W !
 .. Q
 . Q
 ;
 I IBSTOP G PRINTX
 D:$Y>(IOSL-4) HDR1 G:IBSTOP PRINTX
 W !!,"Total Number of Batches: ",IBCT
 D:$Y>(IOSL-4) HDR1 G:IBSTOP PRINTX
 W !!?5,"*** End of Report ***"
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
HDR1 ; Report header
 ;
 ; if screen output and page# already exists, do a page break
 I IBPAGE,CRT D  I IBSTOP G HDR1X
 . S DIR(0)="E" D ^DIR K DIR
 . I 'Y S IBSTOP=1
 . Q
 ;
 ; if screen output OR page# already exists, do a form feed
 I IBPAGE!CRT W @IOF
 ;
 S IBPAGE=IBPAGE+1
 ;
 W !,"EDI Batches Pending Austin Receipt After 1 Day",?70,"Page: ",IBPAGE
 W !,"Run Date: ",$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 W !!?2,"Batch #",?16,"Transmission Date",?42,"Mail Message #"
 S Z="",$P(Z,"-",79)="" W !?1,Z
 ;
 ; check for a TaskManager stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HDR1X
 . S (ZTSTOP,IBSTOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
HDR1X ;
 Q
 ;

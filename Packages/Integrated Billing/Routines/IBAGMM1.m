IBAGMM1 ;WOIFO/AAT-GMT MONTHLY TOTALS REPORT;30-JUL-02
 ;;2.0;INTEGRATED BILLING;**183**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 Q
 ;
 ; Prints report to the current device
 ;
 ; Input:
 ;   IBBDT - Beginning date
 ;   IBEDT - Ending date
 ; Output:
 ;   IBQUIT = 1, if user entered "^" (Devices starting with "C-" only)
REPORT ;
 N IBDT,IBDTE,IBDTH,IBCR,IBDA,IBAT,IBBG,IBTMP,IBZ,IBCL
 S IBQUIT=0
 S IBTMP=$NA(^TMP($J,"IBAGMM")) ; The node of TMP array
 K @IBTMP
 ;
 ; Scan charges, created in the date range IBBDT-31 .. IBEDT
 ; a charge cannot be for period longer than 30 days.
 ; Index - 
 ;
 ; Get the charges from file #350 to the temporary global
 ; IBDT here - Parent Event Date
 S IBDT=$$PLUS(IBBDT,-31) F  S IBDT=$O(^IB("D",IBDT)) Q:'IBDT  Q:$P(IBDT,".")>IBEDT  D
 . S IBCR=0 F  S IBCR=$O(^IB("D",IBDT,IBCR)) Q:'IBCR  D PROC(IBCR)
 ;
 D PRINT
 K @IBTMP ; Kill the temporary global node
 S:$D(ZTQUEUED) ZTREQ="@" ; for Taskman
 Q
 ;
PRINT ; Print report from the temp. global
 N IBLINE,IBPAG,IBTOT,IBTOTS,IBTOTI,IBD,IBTY,IBDA,IBY,IBCHG,IBSAV,IBSEQ,IBMON,X,X2,X3,Y,%
 D NOW^%DTC S IBDTH=$$FMTE^XLFDT($E(%,1,12))
 S IBLINE="",$P(IBLINE,"=",IOM+1)="",(IBPAG,IBTOT,IBTOTS,IBTOTI,IBQUIT,IBCHG)=0
 D HDR
 I '$D(@IBTMP@("M")) W !!,"No GMT charges found within the specified period" D PAUSE(1) Q
 ; - first, print detail lines
 F IBMON=$E(IBBDT,1,5):1:$E(IBEDT,1,5)  D  Q:IBQUIT
 . D CHKSTOP Q:IBQUIT
 . S IBY=$G(@IBTMP@("M",IBMON))
 . W !,$$MON($E(IBMON,4,5)),?10,1700+$E(IBMON,1,3)
 . ;W ?16,$J($P(IBY,U,1),4) ;Number of charges not required
 . W ?22,$J($P(IBY,U,2),3)
 . W ?31,$$FORMAT($P(IBY,U,3),12,2),?46,$$FORMAT($P(IBY,U,4),12,2)
 . I $P(IBY,U,5) W ?61,$$FORMAT($P(IBY,U,5),12,2)
 . S IBTOT=IBTOT+$P(IBY,U,3),IBTOTS=IBTOTS+$P(IBY,U,4),IBTOTI=IBTOTI+$P(IBY,U,5)
 Q:IBQUIT
 I (IBTOT!IBTOTI) D TOTALS
 D PAUSE(1)
 Q
 ;Number format
FORMAT(IBNUM,IBDIG,IBFRM) N X,X1,X2,X3
 S X=IBNUM,X2=$G(IBFRM,"2$"),X3=IBDIG
 D COMMA^%DTC
 Q X
 ;
CHKSTOP I $Y>(IOSL-5) D PAUSE(0) Q:IBQUIT  D HDR
 Q
 ;
 ;
HDR ; Print header.
 N IBI
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBH="GMT MONTHLY TOTALS REPORT"
 S IBPAG=IBPAG+1 W ?(70-$L(IBH)\2),IBH
 W !,"From ",$$DAT(IBBDT)," through ",$$DAT(IBEDT)
 W ?IOM-36,IBDTH,?IOM-9,"Page: ",IBPAG
 W !!," MONTH",?10,"YEAR",?16,"# GMT PATIENTS ",?32,"GMT BILLED",?48,"GMT DIFF",?65,"PENDING"
 W ! F IBI=1:1:80 W "-"
 Q
 ;
TOTALS N IBI,X
 W !,?30 F IBI=1:1:45 W "-"
 W !,?29,$$FORMAT(IBTOT,14),?44,$$FORMAT(IBTOTS,14),?59,$$FORMAT(IBTOTI,14)
 Q
 ;
STAT() ; Display bill number or status
 N IBSTAT S IBSTAT=$G(^IBE(350.21,+$P(IBZ,U,5),0))
 Q $S($P(IBSTAT,U,6):$$HLD(+$P(IBZ,U,5)),$P(IBZ,U,5)=99:"Converted",$P(IBZ,U,11)]"":$P($P(IBZ,U,11),"-",2),$P(IBSTAT,U,5):"Cancelled",1:"Pending")
 ;
HLD(STAT) ; Return an 'on hold' status string
 Q "Hold "_$S(STAT=20:"Rate",STAT=21:"Rev",1:"Ins")
 ;
PAUSE(IBEND) ;
 Q:$E(IOST,1,2)'["C-"
 N IBJ,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y
 W !! ;F IBJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E"
 I $G(IBEND) S DIR("A")="End of the report. Enter RETURN to continue or '^' to exit"
 D ^DIR K DIR I $G(DUOUT) S IBQUIT=1 W @IOF Q
 I $G(IBEND) W @IOF
 Q
 ;
DAT(IBDT) ; Convert FM date to (mm/dd/yy) format.
 Q $$FMTE^XLFDT(IBDT,"2MZ")
 ;
PLUS(IBDT,IBDAYS) N X,X1,X2
 S X1=IBDT,X2=IBDAYS
 D C^%DTC
 Q X
 ;
 ;Add the data to tmp global, if needed.
PROC(IBDA) N IBDTBT,IBMON,IBZ,IBY,IBDFN,IBSTA,IBCRG,IBSEQ,IBGMT
 S IBZ=$G(^IB(IBDA,0)) I 'IBZ Q
 S IBSTA=$P(IBZ,U,5) I IBSTA=9 Q  ; ERROR charges will not be considered
 S IBCRG=$P(IBZ,U,7) I 'IBCRG Q  ;Zero amount
 Q:$P(IBZ,U,8)["ADMISSION"
 S IBDTBT=$P(IBZ,U,15) S:IBDTBT="" IBDTBT=$P(IBZ,U,14)
 S IBDTBT=$P(IBDTBT,".")
 Q:IBDTBT<IBBDT  Q:IBDTBT>IBEDT  ;"BILLED TO" date must be within the date range
 ; Do not include cancelled charges with no bill No.
 I $P(IBZ,U,11)="",$P($G(^IBE(350.21,+$P(IBZ,U,5),0)),U,5) Q
 S IBGMT=$P(IBZ,U,21)
 S IBSEQ=$P($G(^IBE(350.1,+$P(IBZ,U,3),0)),U,5)
 I IBSEQ=2,'IBGMT,$P(IBZ,U,9) S IBGMT=$P($G(^IB(+$P(IBZ,U,9),0)),U,21) ; Maybe the parent charge is GMT RELATED?
 Q:'IBGMT  ; The charge is not GMT RELATED.
 I IBSEQ=2 S IBCRG=-IBCRG
 S IBMON=$E(IBDTBT,1,5) ;Month
 S IBDFN=$P(IBZ,U,2)
 S IBY=$G(@IBTMP@("M",IBMON)) ;Monthly statistics node
 S $P(IBY,U,1)=$P(IBY,U,1)+1 ; Charge Counter
 I '$D(@IBTMP@("P",IBDFN,IBMON)) S $P(IBY,U,2)=$P(IBY,U,2)+1,@IBTMP@("P",IBDFN,IBMON)="" ; Patient Counter
 I IBSTA'=1 S $P(IBY,U,3)=$P(IBY,U,3)+IBCRG ; GMT Charges Monthly Total
 I IBSTA'=1 S $P(IBY,U,4)=$P(IBY,U,4)+(IBCRG*4) ; GMT Charges Monthly Difference
 I IBSTA=1 S $P(IBY,U,5)=$P(IBY,U,5)+IBCRG ; GMT Incompleted Charges Monthly Total
 S @IBTMP@("M",IBMON)=IBY
 Q
MON(IBMON) I (IBMON<1)!(IBMON>12) Q ""
 Q $P("JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER"," ",IBMON)
 ;

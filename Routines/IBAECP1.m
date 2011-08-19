IBAECP1 ;WOIFO/AAT-LTC SINGLE PATIENT PROFILE ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**176**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 Q
 ;
 ; Prints report to the current device
 ;
 ; Input:
 ;   IBDFN - Patient IEN
 ;   IBCLK - LTC Copay Billing Clock IEN
 ;   IBDT1 - Beginning date
 ;   IBDT2 - Ending date
 ;   IBOFD - Option: print free (exempt) days list
 ;   IBOEV - Option: print LTC events
 ; Output:
 ;   IBQUIT = 1, if user entered "^" (Devices starting with "C-" only)
REPORT ;
 N IBDT,IBDTE,IBDTH,IBCR,IBDA,IBX,IBAT,IBTMP,IBZ,IBCL
 S IBQUIT=0
 S IBTMP=$NA(^TMP($J,"IBAECP")) ; The node of TMP array
 K @IBTMP
 ;
 ; Marking beginning and ending of each clock within the range.
 ; Not including selected LTC BILLING CLOCK
 S IBDT=0 F  D  Q:'IBDT  Q:IBDT>IBDT2
 . S IBDT=$O(^IBA(351.81,"AE",IBDFN,IBDT)) Q:'IBDT
 . S IBCL=0 F  D  Q:'IBCL
 .. S IBCL=$O(^IBA(351.81,"AE",IBDFN,IBDT,IBCL)) Q:'IBCL
 .. Q:IBCL=IBCLK  ; Don't include the selected clock to the report
 .. S IBZ=$G(^IBA(351.81,IBCL,0)) Q:IBZ=""
 .. I $P(IBZ,U,5)=3 Q  ; Status - FOR CANCELLED
 .. I IBDT'<IBDT1,IBDT'>IBDT2 S @IBTMP@(IBDT,"C")=IBCL ; Mark the beginning of the clock
 .. S IBDTE=$P(+$P(IBZ,U,4),".")
 .. I IBDTE,IBDTE'<IBDT1,IBDTE'>IBDT2 S @IBTMP@(IBDTE,"E")=IBCL ; Mark the ending of the clock
 ;
 ;
 ; Get the charges from file #350.
 S IBDT="" F  S IBDT=$O(^IB("AFDT",IBDFN,IBDT)) Q:'IBDT  D:-IBDT'>IBDT2
 . S IBCR=0 F  S IBCR=$O(^IB("AFDT",IBDFN,IBDT,IBCR)) Q:'IBCR  D
 .. S IBDA=0 F  S IBDA=$O(^IB("AF",IBCR,IBDA)) Q:'IBDA  D
 ...  Q:'$D(^IB(IBDA,0))  S IBX=^(0)
 ...  ;;; Q:$P(IBX,U,8)["ADMISSION" ; Not sure it is needed
 ...  I $P(IBX,U,15)<IBDT1 Q
 ...  I $P(IBX,U,14)>IBDT2 Q
 ...  S IBAT=$P(IBX,U,3) Q:'IBAT  ; Action type is really required
 ...  I $$ACTNM^IBOUTL(IBAT)'["LTC " Q  ; Not an LTC action type
 ...  S @IBTMP@(+$P(IBX,U,14),"I"_IBDA)=""
 ;
 D PRINT
 K @IBTMP ; Kill the global node
 K ^TMP($J,"180DAYS")
 K ^TMP($J,"IBMJINP")
 K ^TMP($J,"IBMJOUT")
 S:$D(ZTQUEUED) ZTREQ="@" ; for Taskman
 Q
 ;
PRINT ; Print report from the temp. global
 N IBLINE,IBPAG,IBTOT,IBTOTM,IBTOTP,IBPT,IBH,IBD,IBTY,IBDA,IBDZ,IBCHG,IBSEQ,X,X2,X3,Y,%,IBCURM,IBCURY,IBCIS
 D NOW^%DTC S IBDTH=$$FMTE^XLFDT($E(%,1,12))
 S IBLINE="",$P(IBLINE,"=",IOM+1)="",(IBPAG,IBTOT,IBTOTM,IBQUIT,IBCHG,IBTOTP)=0
 S IBPT=$$PT^IBEFUNC(IBDFN)
 S IBCIS=0
 S IBH="LTC Billing Profile for "_$P(IBPT,U)_"  "_$P(IBPT,U,2) D HDR
 ;;; D CLKINFO ; Print brief clock info
 I '$D(@IBTMP) W !!,"The patient has no LTC bills within the specified period" D PAUSE(1) Q
 S (IBCURM,IBCURY)=0 ; Current month and year
 ; - first, print detail lines
 S IBD="" F  S IBD=$O(@IBTMP@(IBD)) Q:'IBD  D  Q:IBQUIT
 . S IBTY="" F  S IBTY=$O(@IBTMP@(IBD,IBTY)) Q:IBTY=""  D  Q:IBQUIT
 ..  D CHKSTOP Q:IBQUIT
 ..  I (+$E(IBD,4,5)'=IBCURM)!(+$E(IBD,1,3)'=IBCURY) D MONTOTAL
 ..  I IBTY="C" W !,$$DAT(IBD),?18,"Start another LTC Copay Clock" Q
 ..  I IBTY="E" W !,$$DAT(IBD),?18,"Expire another LTC Copay Clock" Q
 ..  ; If the month has been changed
 ..  I +$E(IBD,4,5)'=IBCURM D PRMON(IBD) S IBTOTM=0 ; Monthly total
 ..  W !,$$DAT(IBD)
 ..  S IBDA=+$E(IBTY,2,99),IBDZ=$G(^IB(IBDA,0)),IBSEQ=0
 ..  I $P(IBDZ,U,14)'=$P(IBDZ,U,15) W ?12,$$DAT($P(IBDZ,U,15))
 ..  S IBSEQ=$P($G(^IBE(350.1,+$P(IBDZ,U,3),0)),U,5)
 ..  W ?24,$$ACTNM^IBOUTL(+$P(IBDZ,U,3))
 ..  W ?54,$$STAT()
 ..  S IBCHG=+$P(IBDZ,U,7)
 ..  I IBSEQ=2 S IBCHG=-IBCHG
 ..  I $P(IBDZ,U,11)="",$P($G(^IBE(350.21,+$P(IBDZ,U,5),0)),U,5) S IBCHG=0
 ..  S X=IBCHG,X2="2$",X3=10 D COMMA^%DTC W ?65,X
 ..  S IBTOT=IBTOT+IBCHG ; Total
 ..  S IBTOTM=IBTOTM+IBCHG ; Monthly total
 ..  I IBSEQ=2!($P(IBDZ,U,11)=""&($P($G(^IBE(350.21,+$P(IBDZ,U,5),0)),U,5))) W !?5,"Charge Removal Reason: ",$S($D(^IBE(350.3,+$P(IBDZ,U,10),0)):$P(^(0),U),1:"UNKNOWN")
 ..  S IBTOTP=1
 Q:IBQUIT
 D MONTOTAL
 D PAUSE(1)
 Q
CHKSTOP I $Y>(IOSL-5) D PAUSE(0) Q:IBQUIT  D HDR
 Q
 ;
 ;
 ; Print month header
PRMON(IBDT) ;
 S IBCURM=+$E(IBDT,4,5)
 S IBCURY=+$E(IBDT,1,3)
 W !,"LTC CHARGES FOR ",$$MONNAM(IBCURM)," ",IBCURY+1700
 ;
 Q
 ;
MONNAM(IBM) ;Name of the month by number
 Q $P("JANUARY;FEBRUARY;MARCH;APRIL;MAY;JUNE;JULY;AUGUST;SEPTEMBER;OCTOBER;NOVEMBER;DECEMBER",";",IBM)
 ;
 ; Totals for the month (and monthly cap)
MONTOTAL N X,X2,X3,IBDTM1,IBDTM2,IBCAP
 Q:'IBTOTP
 D CHKSTOP Q:IBQUIT
 W !?65,"---------"
 D CHKSTOP Q:IBQUIT
 K ^TMP($J,"180DAYS")
 K ^TMP($J,"IBMJINP")
 K ^TMP($J,"IBMJOUT")
 S IBDTM1=IBCURY_$S(IBCURM>10:IBCURM,1:"0"_IBCURM)_"01" ; First day of month
 S IBDTM2=$$LASTDT^IBAECU(IBDTM1) ; Last day of month
 I $$INPINFO^IBAECU2(IBDTM1,IBDTM2,IBDFN,"IBMJINP",1) ;"no inpatient stay"
 I $$OUTPINFO^IBAECU3(IBDTM1,IBDTM2,IBDFN,"IBMJOUT") ;"no outpatient visits"
 S IBCAP=$$CLCK180^IBAECM2(IBDFN,IBDTM1,IBDTM2,"IBMJINP")
 ;
 W !?5,"Monthly LTC Copay Cap: " S X=+IBCAP,X2="2$",X3=12 D COMMA^%DTC W ?25,X
 ; Indicate 1-180 of 180+ flag
 W " (",$S('$P(IBCAP,U,2):"1-180 days",1:"181+ days"),") "
 S X=IBTOTM,X2="2$",X3=12 D COMMA^%DTC W ?63,X
 I IBOEV D EVENTS
 S IBCURM=0 ; Set current month to unknown
 S IBTOTP=0
 W !
 Q
 ;
HDR ; Print header.
 N IBI
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1 W ?(80-$L(IBH)\2),IBH
 W !,"From ",$$DAT(IBDT1)," through ",$$DAT(IBDT2)
 W ?IOM-36,IBDTH,?IOM-9,"Page: ",IBPAG
 I 'IBCIS S IBCIS=1 D CLKINFO ; Print brief clock info
 W !,"BILL DATE   BILL TO     BILL TYPE",?55,"BILL #    TOT CHARGE"
 W ! F IBI=1:1:80 W "-"
 Q
 ;
STAT() ; Display bill number or status
 N IBSTAT S IBSTAT=$G(^IBE(350.21,+$P(IBDZ,U,5),0))
 Q $S($P(IBSTAT,U,6):$$HLD(+$P(IBDZ,U,5)),$P(IBDZ,U,5)=99:"Converted",$P(IBDZ,U,11)]"":$P($P(IBDZ,U,11),"-",2),$P(IBSTAT,U,5):"Cancelled",1:"Pending")
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
 ;For debugging only - find LTC-related records of the file #350
FNDLTC N IEN,IBX,IBN
 S IEN=0 F  S IEN=$O(^IB(IEN)) Q:'IEN  D
 .  Q:'$D(^IB(IEN,0))  S IBX=^(0)
 .  ;;; Q:$P(IBX,U,8)["ADMISSION" ; Not sure it is needed
 .  S IBN=$$ACTNM^IBOUTL(+$P(IBX,U,3))
 .  I IBN["LTC " W !,IEN,?10,IBN ; Not an LTC action type
 W !,"Ready"
 Q
 ;
CLKINFO ; Output short information about the clock
 N IBZ,IBDT1,IBDT2,IBV,IBC,IBI,IBA,IBN
 S IBZ=$G(^IBA(351.81,IBCLK,0)) I IBZ="" W !,"Corrupted record of LTC clock ",IBCLK Q 
 S IBDT1=$P(IBZ,U,3)
 S IBDT2=$P(IBZ,U,4)
 S IBC=0 ; Counter of free days
 ; Collect an array of free days:
 S IBI=0 F  S IBI=$O(^IBA(351.81,IBCLK,1,IBI)) Q:'IBI  I $P(^(IBI,0),U,2) S IBC=IBC+1,IBA(IBC)=$P(^(0),U,2)
 W !,IBLINE
 W !?2,"LTC Copay Clock Start Date: ",$$DAT(IBDT1)
 W ?50,"Clock Status: ",$$EXTERNAL^DILFD(351.81,.05,"",$P(IBZ,U,5))
 I IBDT2 W !?2,"LTC Copay Clock End Date: ",$S(IBDT2:$$DAT(IBDT2),1:"none")
 D:IBOFD
 . W !?2,"Days Not Subject To LTC Copay:" I 'IBC W " none" Q
 . S IBV=IBC\3 I IBC#3 S IBV=IBV+1
 . F IBI=1:1:IBV D
 ..  S IBN=IBI W !?5,$J(IBN,2),?10,$$FMTE^XLFDT(IBA(IBN))
 ..  S IBN=IBI+IBV I $G(IBA(IBN)) W ?30,$J(IBN,2),?35,$$FMTE^XLFDT(IBA(IBN))
 ..  S IBN=IBI+(2*IBV) I $G(IBA(IBN)) W ?55,$J(IBN,2),?60,$$FMTE^XLFDT(IBA(IBN))
 W !!
 Q
 ;
 ; Print LTC Events
 ; Input:
 ;  IBDFN - Patient DFN
 ;  IBDTM1,IBDTM2 - First/Last days of the month, FM format
 ;  ^TMP($J,"IBMJINP"),^TMP($J,"IBMJOUT") with prepared data
 ; Output:
 ;   Prints LTC Events report section 
EVENTS N IBA,IBMOV,IBNDX,IBDAY,IBSL,IBCR,IBZ,IBZCR,IBENC,IBCNT
 ; Collect data from ^TMP($J) array
 S IBNDX="IBMJINP" ; Inpatient part
 S IBMOV=0 F  S IBMOV=$O(^TMP($J,IBNDX,IBDFN,IBMOV)) Q:'IBMOV  D
 . F IBSL="SD","LD" D
 .. S IBCR=0 ; Current event begining day
 .. S IBDAY=0 F  S IBDAY=$O(^TMP($J,IBNDX,IBDFN,IBMOV,IBSL,IBDAY)) Q:'IBDAY  S IBZ=^(IBDAY) D:$P(IBZ,U)'="M"  ; No means-test events
 ... I 'IBCR S IBCR=IBDAY,IBA(IBCR)=$E(IBDAY,6,7)_U_$E(IBSL)_U_IBZ
 ... ; I IBZCR'="",IBZCR'=IBZ S
 ... Q:($O(^TMP($J,IBNDX,IBDFN,IBMOV,IBSL,IBDAY))-1)=IBDAY
 ... S $P(IBA(IBCR),U)=$E(IBDAY,6,7) ; Days only
 ... S IBCR=0,IBZCR=""
 ;
 S IBNDX="IBMJOUT" ; Outpatient part
 S IBDAY=0 F  S IBDAY=$O(^TMP($J,IBNDX,IBDFN,IBDAY)) Q:'IBDAY  D
 . S IBCNT=0
 . S IBENC=0 F IBENC=$O(^TMP($J,IBNDX,IBDFN,IBDAY,IBENC)) Q:'IBENC  S IBZ=^(IBENC) D:$P(IBZ,U)'="M"  ; No means-test events
 .. S IBA(IBDAY)="O"
 .. S IBCNT=IBCNT+1
 .. S IBA(IBDAY,IBCNT)=IBZ
 ;
 W !?5,"Monthly LTC Events:"
 S IBDAY=0 F  S IBDAY=$O(IBA(IBDAY)) Q:'IBDAY  D  Q:IBQUIT
 . I IBA(IBDAY)="O" D  Q  ; Outpatient events
 .. S IBCNT=0 F  S IBCNT=$O(IBA(IBDAY,IBCNT)) Q:'IBCNT  D  Q:IBQUIT
 ... D CHKSTOP Q:IBQUIT
 ... W !?7,$$DAT(IBDAY),?30,$$ACTNM^IBOUTL($P(IBA(IBDAY,IBCNT),U,4))
 . ; Inpatient events
 . S IBZ=IBA(IBDAY)
 . D CHKSTOP Q:IBQUIT
 . W !?7,$$DAT(IBDAY) I $P(IBZ,U)'=$E(IBDAY,6,7) W " - ",?18,$$DAT($E(IBDAY,1,5)_$P(IBZ,U))
 . I $P(IBZ,U,2)="L" W ?30,"ABSENT DAYS" Q
 . W ?30,$$ACTNM^IBOUTL(+$P(IBZ,U,6))
 Q

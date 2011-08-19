IBEMTF2 ;ALB/CPM - LIST NON-BILLABLE STOP CODES, DISPOSITIONS, AND CLINICS ; 05-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**55**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Option entry point - describe output.
 W !!?5,"This report may be used to generate a list of all clinic stop codes,"
 W !?5,"dispositions, and clinics where Means Test billing will be ignored.",!
 ;
 ; - grab effective date
 S %DT="AEX",%DT("A")="Please select the effective date for this list: ",%DT("B")=$$DAT2^IBOUTL(DT)
 D ^%DT K %DT G:Y<0 ENQ S IBDAT=Y
 ;
 ; - select a device
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBEMTF2",ZTDESC="LIST NON-BILLABLE STOPS/CLINICS/DISPOSITIONS",ZTSAVE("IBDAT")=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; Tasked entry point.
 ;
 ; - compile data
 D ENQ1 F IBI=352.2,352.3,352.4 S IBJ=0 F  S IBJ=$O(^IBE(IBI,"AIVDT",IBJ)) Q:'IBJ  I $$NBILL(IBI,IBJ,IBDAT) S ^TMP("IBEMTF2",$J,IBI,IBJ)=""
 ;
 ; - print results
 S (IBPAG,IBQ)=0 F IBI=352.2,352.3,352.4 D HDR,LST,PAUSE:'IBQ Q:IBQ
 ;
ENQ I '$D(ZTQUEUED) D ^%ZISC
 K IBDAT,IBI,IBJ,IBQ,IBT,IBPAG
ENQ1 K ^TMP("IBEMTF2",$J)
 Q
 ;
HDR ; Generate a report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1,IBT="LIST OF NON-BILLABLE "_$S(IBI=352.2:"DISPOSITIONS",IBI=352.3:"CLINIC STOP CODES",1:"CLINICS")_" FOR MEANS TEST BILLING"
 W $$DASH(),!?(80-$L(IBT)\2),IBT,!?33,"As Of: ",$$DAT1^IBOUTL(IBDAT)
 W !?64,"Page: ",IBPAG,!?60,"Run Date: ",$$DAT1^IBOUTL(DT)
 W !,$$DASH(),!!
 Q
 ;
LST ; List all selected entries.
 I '$D(^TMP("IBEMTF2",$J,IBI)) W "All ",$S(IBI=352.2:"dispositions",IBI=352.3:"clinic stop codes",1:"clinics")," are billable on this date." G LSTQ
 S IBJ=0 F  S IBJ=$O(^TMP("IBEMTF2",$J,IBI,IBJ)) Q:'IBJ  D  Q:IBQ
 .W:$X>40 ! I $Y>(IOSL-3) D PAUSE Q:IBQ  D HDR
 .W:$X>2 ?40 W $$VAL(IBI,IBJ)
LSTQ Q
 ;
NBILL(IBF,IBEN,IBD) ; Is the entry not billable as of the effective date?
 ;  Input:    IBF  --  Base file (#352.2, #352.3, #352.4)
 ;           IBEN  --  Internal entry number for entry
 ;            IBD  --  Effective date for non-billing
 N Y S Y=0
 I '$G(IBF)!'$G(IBEN)!'$G(IBD) G NBILLQ
 I $G(IBF)=352.2 S Y=$$NBDIS^IBEFUNC(IBEN,IBDAT) G NBILLQ
 I $G(IBF)=352.3 S Y=$$NBCSC^IBEFUNC(IBEN,IBDAT) G NBILLQ
 I $G(IBF)=352.4 S Y=$$NBCL^IBEFUNC(IBEN,IBDAT)
NBILLQ Q Y
 ;
VAL(IBF,IBEN) ; Return the entry name.
 ;  Input:    IBF  --  Base file (#352.2, #352.3, #352.4)
 ;           IBEN  --  Internal entry number for entry
 ;  Output:    Entry name (#.01 from respective file)
 N Y S Y="'ENTRY NAME UNKNOWN'"
 I '$G(IBF)!'$G(IBEN) G VALQ
 I $G(IBF)=352.2 S Y=$P($G(^DIC(37,IBEN,0)),"^") G VALQ
 I $G(IBF)=352.3 S Y=$P($G(^DIC(40.7,IBEN,0)),"^") G VALQ
 I $G(IBF)=352.4 S Y=$P($G(^SC(IBEN,0)),"^")
VALQ Q Y
 ;
DASH() ; Return a dashed line.
 Q $TR($J("",80)," ","=")
 ;
PAUSE ; Page break
 Q:$E(IOST,1,2)'="C-"
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q

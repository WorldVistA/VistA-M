IBOBL ;ALB/ARH - LIST ALL BILLS FOR AN EPISODE OF CARE ; 25-MAY-90
 ;;2.0;INTEGRATED BILLING;**80,106**;21-MAR-94
 ;
EN ;get parameters then run the report
 D HOME^%ZIS N IBASK,IBCANC,IBX W !!,"Episode of Care Bill List:",!,"--------------------------"
 W !,"Enter a Bill Number to get a list of all bills that match the selected bill's",!,"event date or any of it's outpatient visit dates."
 W !,"Enter a Patient Name and Episode Date to get a list of all bills for a patient",!,"that have either that date as the event date or as an outpatient visit date."
 W !,"This report also includes bills related as continuing episodes of care."
 ;
 S IBASK=$$PB^IBJTU2 Q:IBASK'>0  W !
 I +IBASK=1 S IBX=$$GETDT^IBCRU1("","Episode Date") Q:IBX'?7N  S IBASK=IBASK_U_IBX W !
 S IBADDCPT=$$CPT Q:IBADDCPT<0
 S IBCANC=$$CANC Q:IBCANC<0  W !
 ;
DEV ;get the device
 W !,"Report requires 132 columns."
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="RPT^IBOBL",ZTDESC="Episode of Care Bill List",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 ;
RPT ;find, save, and print the data that satisfies the search parameters
 ;entry point for tasked jobs
 ;
 K ^TMP($J,"IBOBL") I '$G(IBASK) G EXIT
 ;
 D FIND
 D PRINT
 ;
EXIT ;clean up and quit
 K ^TMP($J,"IBOBL"),IBASK,IBADDCPT,IBCANC,IBX Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
FIND ; compile list of all related bills
 N IBIFN,IB0,DFN,IBEPDT,IBX
 ;
 ; compile list of related bills based on event date and opt visit dates of selected bill
 I +IBASK=2 S IBIFN=+$P(IBASK,U,2),IB0=$G(^DGCR(399,IBIFN,0)) D
 . S DFN=$P(IB0,U,2),IBEPDT=$P(IB0,U,3) D FIND1(DFN,IBEPDT)
 . S IBX=0 F  S IBX=$O(^DGCR(399,+IBIFN,"OP",IBX)) Q:'IBX  D
 .. S IBEPDT=+$G(^DGCR(399,+IBIFN,"OP",IBX,0)) Q:'IBEPDT  D FIND1(DFN,IBEPDT)
 ;
 ; compile list of related bills based on selected patient and episode date
 I +IBASK=1 S DFN=$P(IBASK,U,2),IBEPDT=$P(IBASK,U,3) D FIND1(DFN,IBEPDT)
 ;
 D FIND2 ; compile list of bills based on Primary Bill link with bills already found
 Q
 ;
FIND1(DFN,IBEPDT) ; find all bills for a patient with a specific event date or opt visit date
 N IBX,IBIFN,IBDT S IBEPDT=IBEPDT\1
 ;
 ; find all bills for patient with episode date as outpatient visit date
 S IBDT=IBEPDT-.0001 F  S IBDT=$O(^DGCR(399,"AOPV",DFN,IBDT)) Q:((IBDT\1)'=IBEPDT)  D
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AOPV",DFN,IBDT,IBIFN)) Q:'IBIFN  D
 .. S IBX=$G(^DGCR(399,IBIFN,0)) I IBX="" Q
 .. S ^TMP($J,"IBOBL","BILL",IBIFN)=""
 .. I +$P(IBX,U,17) S ^TMP($J,"IBOBL","BILL",+$P(IBX,U,17))=""
 ;
 ; find all bills for patient with episode date as Event Date
 S IBDT=IBEPDT-.00001 F  S IBDT=$O(^DGCR(399,"D",IBDT)) Q:((IBDT\1)'=IBEPDT)  D
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"D",IBDT,IBIFN)) Q:'IBIFN  D
 .. S IBX=$G(^DGCR(399,IBIFN,0)) I $P(IBX,U,2)'=DFN Q
 .. S ^TMP($J,"IBOBL","BILL",IBIFN)=""
 .. I +$P(IBX,U,17) S ^TMP($J,"IBOBL","BILL",+$P(IBX,U,17))=""
 ;
 Q
 ;
FIND2 ; compile list of related bills based on Primary Bill of bills already found
 N IBBILL,IBIFN,IBX
 S IBBILL=0 F  S IBBILL=$O(^TMP($J,"IBOBL","BILL",IBBILL)) Q:'IBBILL  D
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AC",IBBILL,IBIFN)) Q:'IBIFN  D
 .. S IBX=$G(^DGCR(399,IBIFN,0)) I IBX="" Q
 .. S ^TMP($J,"IBOBL","BILL",IBIFN)=""
 Q
 ;
PRINT ;print the report from the temp sort file to the appropriate device
 N IBPGN,IBQUIT,IBLN,IBHDR1,IBHDR2,IBIFN
 S IBPGN=0,IBQUIT=0 D HDRLNS,HDR Q:IBQUIT
 ;
 S IBIFN=0 F  S IBIFN=$O(^TMP($J,"IBOBL","BILL",IBIFN)) Q:'IBIFN  D  Q:$$LNCHK(2)
 . I '$G(IBCANC),$P($G(^DGCR(399,+IBIFN,0)),U,13)=7 Q
 . D PRTLN(IBIFN,IBADDCPT)
 ;
 I 'IBQUIT D PAUSE
 Q
 ;
PRTLN(IBIFN,IBADDCPT) ; print one bill with all it's CPTs
 N IB0,IBU,IBM,IBMP,IBX,IBCPT S IBLN=IBLN+1
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBU=$G(^DGCR(399,IBIFN,"U"))
 S IBM=$G(^DGCR(399,IBIFN,"M")),IBMP=$G(^DGCR(399,IBIFN,"MP"))
 W !,$P(IB0,U,1),?12,$P($G(^DGCR(399.3,+$P(IB0,U,7),0)),U,4) S IBX=$P(IB0,U,5)
 W ?24,$S(IBX=1:"INPT",IBX=2:"INPT-H",IBX=3:"OPT",IBX=4:"OPT-H",1:"") S IBX=$P(IB0,U,27)
 W ?32,$S(IBX=1:"INST",IBX=2:"PROF",1:"")
 W ?39,$$DATE(+$P(IB0,U,3)),?49,$$DATE(+IBU),?59,$$DATE(+$P(IBU,U,2))
 W ?70,$P($$ARSTATA^IBJTU4(IBIFN),U,2) S IBX=$P(IB0,U,21)
 W ?75,$S(IBX="P":"PRIM",IBX="S":"SEC",IBX="T":"TER",IBX="A":"PAT",1:"") S IBX=$P(IB0,U,11)
 W ?82,$E($S(IBX="i":$P($G(^DIC(36,+IBMP,0)),U,1),IBX="o":$P($G(^DIC(4,+$P(IBM,U,11),0)),U,1),IBX="p":$P($G(^DPT(+$P(IB0,U,2),0)),U,1),1:""),1,23)
 W ?107,$J(+$P($$BILL^RCJIBFN2(IBIFN),U,1),10,2)
 ;
 I 'IBADDCPT W ! Q
 ;
 S IBX=0 F  S IBX=$O(^DGCR(399,IBIFN,"CP",IBX)) Q:'IBX  D
 . S IBCPT=$P($G(^DGCR(399,IBIFN,"CP",IBX,0)),U,1) I IBCPT["ICPT" S IBCPT(+IBCPT)=+$G(IBCPT(+IBCPT))+1
 ;
 S IBCPT="" F  S IBCPT=$O(IBCPT(IBCPT)) Q:'IBCPT  D  Q:$$LNCHK(1)
 . S IBX=+IBCPT(IBCPT) W ?120,$P($$CPT^ICPTCOD(+IBCPT),U,2),?127,$S(IBX'=1:"("_IBX_")",1:""),! S IBLN=IBLN+1
 ;
 Q
 ;
HDR ;print the report header
 N IBNOW,IBI
 S IBQUIT=$$STOP Q:IBQUIT  S IBPGN=IBPGN+1,IBLN=7
 S IBNOW=$$FMTE^XLFDT($$NOW^XLFDT),IBNOW=$P(IBNOW,"@",1)_"  "_$P($P(IBNOW,"@",2),":",1,2)
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ;
 W !,IBHDR1,?(IOM-30),IBNOW,?(IOM-8),"PAGE ",IBPGN,!,IBHDR2
 W !,"BILL #",?12,"RATE",?24,"CLASSIFICATION",?39,"EVENT",?49,"FROM",?59,"TO",?70,"AR",?75,"COB",?82,"PAYER",?112,"TOTAL",?120,"CPT'S",!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI
 W !
 Q
 ;
HDRLNS ; set up header lines
 N DFN,IBX S DFN=0
 S IBHDR1="EPISODE OF CARE BILL LIST FOR "
 I +IBASK=1 S IBHDR1=IBHDR1_$P($G(^DPT(+$P(IBASK,U,2),0)),U,1)_" ON "_$$DATE(+$P(IBASK,U,3)) S DFN=+$P(IBASK,U,2)
 I +IBASK=2 S IBX=$G(^DGCR(399,+$P(IBASK,U,2),0)),IBHDR1=IBHDR1_$P(IBX,U,1) S DFN=+$P(IBX,U,2)
 S IBX=$G(^DPT(DFN,0)) S IBHDR2=$P(IBX,U,1)_$J("",10)_$E(IBX)_$P($$PT^IBEFUNC(DFN),U,3)_$J("",10)_"DOB: "_$$DATE($P(IBX,U,3))
 Q
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
LNCHK(LNS) ; check if new page is needed
 I 'IBQUIT,IBLN>(IOSL-LNS) D PAUSE I 'IBQUIT D HDR
 Q IBQUIT
 ;
PAUSE ;pause at end of screen if beeing displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  N DIR,DUOUT,DTOUT,DIRUT
 S DIR(0)="E" D ^DIR K DIR
 I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
CPT() ; return true if include bills CPT procedures
 N IBX,DIR,DTOUT,DUOUT,DIRUT,X,Y S IBX=0
 S DIR("?")="Enter either 'Y' or 'N'.  Enter 'Y' if you want the CPT procedures for each bill included in the report."
 S DIR("A")="Include CPT Procedures",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR S:Y=1 IBX=1 I $D(DIRUT) S IBX=-1
 Q IBX
 ;
CANC() ; return true if include canceled bills
 N IBX,DIR,DTOUT,DUOUT,DIRUT,X,Y S IBX=0
 S DIR("?")="Enter either 'Y' or 'N'.  Enter 'Y' if you want cancelled bills included in the report."
 S DIR("A")="Include Cancelled Bills",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR S:Y=1 IBX=1 I $D(DIRUT) S IBX=-1
 Q IBX

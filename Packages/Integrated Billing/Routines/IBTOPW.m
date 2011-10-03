IBTOPW ;ALB/AAS - CLAIMS TRACKING PENDING REVIEWS REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Pending Reviews Report",!!!
 ;
SORT D SORT^IBTRPR0
 ;
REVS ; -- ask if hospital review, insurance reviews or both
 N DIR W !
 S DIR(0)="SOBA^H:HOSPITAL REVIEWS;I:INSURANCE REVIEWS;B:BOTH;"
 S DIR("A")="Print [H]ospital Reviews  [I]Insurance Reviews  [B]oth: "
 S DIR("B")="B"
 S DIR("?",1)="Select if you would like to print pending Hospital Reviews, Insurance"
 S DIR("?",2)="Reviews or both."
 S DIR("?",3)=" ",DIR("?")="The default is both.  This will print first the hospital reviews, then the insurance reviews."
 D ^DIR K DIR
 I "HIB"'[Y!($D(DIRUT)) G END
 S IBTRPRF=$S(Y="B":12,Y="I":2,1:1)
 ;
 S IBTWHO="A" I IBSORT="A" D WHOSE^IBTRPR0 G:$D(VALMQUIT) END
 S IBTPRT="B",VAUTD=1 I IBSORT="T" D TYPE^IBTRPR0 G:$D(VALMQUIT) END
 I IBSORT="T"!(IBSORT="W") W ! D PSDR^IBODIV G:Y<0 END
 ;
DATE ; -- select date
 W !! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 S IBTPBDT=IBBDT,IBTPEDT=IBEDT
 ;
DEV ; -- select device, run option
 W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTOPW",ZTSAVE("IB*")="",ZTSAVE("VAUTD")="",ZTSAVE("VAUTD(")="",ZTDESC="IB - Pending Reviews Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
 D DQ G END
 Q
 ;
END ; -- Clean up
 W !
 K ^TMP("IBSRT",$J),^TMP("IBSRT1",$J) W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,DUOUT,DIRUT,%ZIS,VA,VAERR,IBTRN,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG,IBTRPRF,IBTSORT,IBTOPW,IBTWHO,IBTPRT,IBDIV
 K ENTRY,FILE,IBDATE,IBJ,IBNEXT,IBREV,IBSTATUS,IBTPEDT,IBTPBDT,IBTRC,IBTRV,TYPE,IBASSIGN,IBCNT,IBDATA,IBFLAG,IBK,IBL,IBSORT,IBWARD,IBEDT,IBBDT,IBDV,VAUTD
 Q
 ;
DQ ; -- print one billing report from ct
 ; -- run the scheduled admissions list
 ;
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 ;
 ; -- put division in array by name
 I '$D(VAUTD) S VAUTD=1
 I VAUTD'=1 S I="" F  S I=$O(VAUTD(I)) Q:'I  S IBDIV(VAUTD(I))=I
 ;
 ; -- run the scheduled admissions list
 D ^IBTRKR2 ;W:'$D(ZTQUEUED) !!,"Building your work list..."
 U IO
 D BLD
 I IBCNT<1 D HDR W !!,"No Pending Reviews found."
 I $D(ZTQUEUED) G END
 Q
 ;
HDR ; -- Print header for billing report
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 W !!,"....task stoped at user request"
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Pending Reviews Report for Division ",$G(IBDV),?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"For Period ",$$FMTE^XLFDT(IBBDT)," to ",$$FMTE^XLFDT(IBEDT)
 W !,"Patient",?23,"Pt. ID",?30,"Ward",?42,"Review Type",?65,"Due Date",?75,"Status",?85,"Assigned to",?105,"Visit",?115,"Date"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
BLD ; -- build list
 ;  1.  build pending hospital reviews
 ;  2.  build pending insurance reviews
 ;
 K ^TMP("IBSRT",$J),^TMP("IBSRT1",$J)
 N IBI,IBJ
 S IBCNT=0,IBI="",IBTOPW=1
 I '$G(IBTRPRF) S IBTRPRF=12
 ;
 D STOP G BLDQ:IBQUIT D:IBTRPRF[1 1^IBTRPR01 S IBQUIT=0
 ;
 D STOP G BLDQ:IBQUIT D:IBTRPRF[2 2^IBTRPR01 S IBQUIT=0
 ;
 ; -- go through sorted list
 S IBDV="" F  S IBDV=$O(^TMP("IBSRT",$J,IBDV)) Q:IBDV=""!(IBQUIT)  D
 .I 'VAUTD,'$D(IBDIV(IBDV)) Q
 .D HDR
 .S TYPE="" F  S TYPE=$O(^TMP("IBSRT",$J,IBDV,TYPE)) Q:TYPE=""!(IBQUIT)  D
 ..S IBI="" F  S IBI=$O(^TMP("IBSRT",$J,IBDV,TYPE,IBI)) Q:IBI=""!(IBQUIT)  S IBJ="" F  S IBJ=$O(^TMP("IBSRT",$J,IBDV,TYPE,IBI,IBJ)) Q:IBJ=""!(IBQUIT)  D
 ...S IBK="" F  S IBK=$O(^TMP("IBSRT",$J,IBDV,TYPE,IBI,IBJ,IBK)) Q:IBK=""!(IBQUIT)  S IBL="" F  S IBL=$O(^TMP("IBSRT",$J,IBDV,TYPE,IBI,IBJ,IBK,IBL)) Q:IBL=""!(IBQUIT)  D ONE
 ;
BLDQ Q
 ;
ONE ; -- print one patients data
 I ($Y+5)>IOSL D HDR Q:IBQUIT
 S IBDATA=^TMP("IBSRT",$J,IBDV,TYPE,IBI,IBJ,IBK,IBL)
 S IBTRN=+IBDATA,ENTRY=$P(IBDATA,"^",2)
 S DFN=$P(IBDATA,"^",4)
 S IBSTATUS=$P(IBDATA,"^",6),IBREV=$P(IBDATA,"^",7)
 S IBASSIGN=$P(IBDATA,"^",9)
 S IBFLAG=$O(^TMP("IBSRT1",$J,DFN,"")),IBFLAG=$O(^TMP("IBSRT1",$J,DFN,IBFLAG)) I IBFLAG'="" S IBFLAG="+"
 S FILE=$P(IBDATA,"^",8)
 D PID^VADPT
 S IBCNT=IBCNT+1
 W !,IBFLAG,$E($P(^DPT(DFN,0),"^"),1,20),?23,VA("BID"),?30,$E($G(^DPT(DFN,.1)),1,11)
 W ?42,$E(TYPE,1,11),"-",$P($G(^IBE(356.11,+IBREV,0)),"^",3)
 W ?65,$$DAT1^IBOUTL($P(IBDATA,"^",3)),?75,IBSTATUS,?85,$E(IBASSIGN,1,18)
 W ?105,$P($G(^IBE(356.6,+$P(^IBT(356,+IBTRN,0),U,18),0)),U,2)
 W ?115,$$DAT1^IBOUTL($P(^IBT(356,+IBTRN,0),U,6),"2P")
 Q
 ;
STOP ; -- see if should stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 D HDR W !!,"....task stoped at user request"
 Q

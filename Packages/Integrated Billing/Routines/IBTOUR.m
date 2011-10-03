IBTOUR ;ALB/AAS - CLAIMS TRACKING UR/ACTIVITY REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**56**; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"UR Activity Report",!!
 ;
 N DIR
 S IBQUIT=0
 D SORT^IBTOLR G:IBQUIT END
 ;
SUM S DIR("?")="Answer YES if you only want to print a summary or answer NO if you want a detailed listing plus the summary."
 S DIR(0)="Y",DIR("A")="Print Summary Only",DIR("B")="YES" D ^DIR K DIR
 I $D(DIRUT) G END
 S IBSUM=Y
 ;
 I 'IBSUM W ! D HOW G:IBQUIT END
 ;
DATE ; -- select date
 W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 ;
DEV ; -- select device, run option
 I 'IBSUM W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTOUR",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - UR Activity Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
 U IO
 D DQ G END
 Q
 ;
END ; -- Clean up
 K ^TMP($J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,%ZIS,VA,IBTRN,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG,IBFOL,IBCNT,IBTRC,IBTRCD,IBSUM,IBDT,IBBDT,IBEDT,IBINS,IBCCODE,IBPCODE,DUOUT,DTOUT,DIRUT,IBC,MET,TYPE
 K IBFAC,IBSNM,IBHDRL,IBTRV,IBTRVD,IBHOW,DGPM,IBI,IBJ,IBSORT,IBAPL,IBCDT,IBP1,IBP2,IBP3,IBP4,IBADM,IBDAYS,IBDAYN,IBCLOSE,IBDA,IBDATA,IBH,IBDIF,IBPREV,IBSITE,IBSPEC,IBTNOD,IBBEG,X2
 D KVAR^VADPT
 Q
 ;
DQ ; -- print one billing report from ct
 K ^TMP($J)
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 S:$G(IBHOW)="" IBHOW="P"
 K IBCNT,^TMP($J)
 D BLD^IBTOUR1
 Q:$D(ZTSTOP)
 ;
PRINT ; -- print report
 I IBSORT'="H" S IBHDRL="Insurance" D
 .I 'IBSUM D INS^IBTOUR4 ; insurance listing
 .Q:$D(ZTSTOP)
 .D INS^IBTOUR3 ; insurance summary
 I IBSORT'="I" S IBHDRL="Hospital" D
 .Q:$D(ZTSTOP)
 .I 'IBSUM D HOSP^IBTOUR4 ;hosp rev. listing
 .Q:$D(ZTSTOP)
 .D HOSP^IBTOUR3 ; hosp. rev. summary
 I $D(ZTQUEUED) G END
 Q
 ;
HOW ; -- if not summary only ask how list is to be sorted
 N DIR
 S DIR(0)="SOBA^R:REVIEWER;S:SPECIALTY;P:PATIENT"
 S DIR("A")="Sort By [R]eviewer  [S]pecialty  [P]atient: "
 S DIR("B")="P"
 S DIR("?",1)="When printing the list of patients reviewed, how should this report be"
 S DIR("?",2)="sorted.  It can be sorted by Reviewer or by Specialty or by Patient.  "
 S DIR("?",3)="If sorted by Reviewer it will be sorted within reviewer by type of review."
 S DIR("?",4)=" ",DIR("?")="The default is Patient."
 D ^DIR K DIR
 S IBHOW=Y I "RSP"'[Y!($D(DIRUT)) S IBQUIT=1
 Q
 ;
HDR1 ; -- specialty report header
 I $E(IOST,1,2)="C-" W ! D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 W @IOF
 S IBPAG=IBPAG+1
 W !,"HOSPITAL REVIEW SPECIALTY SUMMARY REPORT",?IOM-32,IBHDT,"   Page ",IBPAG
 W !!,"For Hospital Reviews Dated ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !,?24,"Admissions",?40,"Admissions",?56,"Days",?71,"Days Not"
 W !,"Specialty",?24,"Met Criteria",?40,"Not Met Crit.",?56,"Met Criteria",?71,"Met Crit."
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
HSPEC ; -- Hospital Review specialty report
 D HDR1 Q:IBQUIT
 S (IBP1,IBP2,IBP3,IBP4)=0
 S IBSPEC="" F  S IBSPEC=$O(^TMP($J,"IBTOUR2",IBSPEC)) Q:IBSPEC=""  S IBDATA=^(IBSPEC) D
 .Q:IBDATA="0^0^0^0"
 .W !,$E(IBSPEC,1,20)
 .W ?23,$J($P(IBDATA,"^",1),8)
 .W ?40,$J($P(IBDATA,"^",2),8),?52,$J($P(IBDATA,"^",3),12)
 .W ?68,$J($P(IBDATA,"^",4),12)
 .S IBP1=IBP1+$P(IBDATA,"^",1),IBP2=IBP2+$P(IBDATA,"^",2),IBP3=IBP3+$P(IBDATA,"^",3),IBP4=IBP4+$P(IBDATA,"^",4)
 ;
 W !,$TR($J(" ",IOM)," ","-")
 W !,?23,$J(IBP1,8),?40,$J(IBP2,8)
 W ?52,$J(IBP3,12)
 W ?68,$J(IBP4,12)
 Q
 ;
IHDR ; -- specialty report header
 I $E(IOST,1,2)="C-" W ! D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 W @IOF
 S IBPAG=IBPAG+1
 W !,"INSURANCE REVIEW SPECIALTY SUMMARY REPORT",?IOM-32,IBHDT,"   Page ",IBPAG
 W !,"For Insurance Reviews Dated ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !!,?25,"Days",?42,"Days",?56,"Amount",?73,"Amount"
 W !,"Specialty",?25,"Approved",?42,"Denied",?56,"Approved",?73,"Denied"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
ISPEC ; -- Insurance Review specialty report
 D IHDR Q:IBQUIT
 S (IBP1,IBP2,IBP3,IBP4)=0
 S IBSPEC="" F  S IBSPEC=$O(^TMP($J,"IBTOUR1",IBSPEC)) Q:IBSPEC=""  S IBDATA=^(IBSPEC) D
 .Q:IBDATA="0^0^0^0"
 .W !,$E(IBSPEC,1,20)
 .W ?23,$J($P(IBDATA,"^",1),8)
 .W ?38,$J($P(IBDATA,"^",2),8)
 .S X=$P(IBDATA,"^",3),X2="0$" D COMMA^%DTC W ?50,X
 .S X=$P(IBDATA,"^",4),X2="0$" D COMMA^%DTC W ?67,X
 .S IBP1=IBP1+$P(IBDATA,"^",1),IBP2=IBP2+$P(IBDATA,"^",2),IBP3=IBP3+$P(IBDATA,"^",3),IBP4=IBP4+$P(IBDATA,"^",4)
 ;
 W !,$TR($J(" ",IOM)," ","-")
 W !,?23,$J(IBP1,8),?38,$J(IBP2,8)
 S X=IBP3,X2="0$" D COMMA^%DTC W ?50,X
 S X=IBP4,X2="0$" D COMMA^%DTC W ?67,X
 Q

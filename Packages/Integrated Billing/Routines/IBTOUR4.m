IBTOUR4 ;ALB/AAS - CLAIMS TRACKING UR ACTIVITY REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
INS ; -- print data
 ; -- ^tmp($j,"ibtour",primary sort,secondary sort,patient, ibtrc)=ibtrcd
 ;
 N IBCNT
 D HDR
 I $O(^TMP($J,"IBTOUR",""))="" W !!,"No Insurance Reviews Found in Date Range." G PRINTQ
 ;
 S IBH="" F  S IBH=$O(^TMP($J,"IBTOUR",IBH)) Q:IBH=""!(IBQUIT)  D
 .D SUBHDR^IBTOUR5
 .S IBI="" F  S IBI=$O(^TMP($J,"IBTOUR",IBH,IBI)) Q:IBI=""!(IBQUIT)  D
 ..D SSUBHDR^IBTOUR5
 ..S IBJ="" F  S IBJ=$O(^TMP($J,"IBTOUR",IBH,IBI,IBJ)) Q:IBJ=""!(IBQUIT)  D
 ...S IBTRC="" F  S IBTRC=$O(^TMP($J,"IBTOUR",IBH,IBI,IBJ,IBTRC)) Q:IBTRC=""!(IBQUIT)  S IBTRCD=^(IBTRC) D ONE
 ;
PRINTQ I 'IBQUIT,$E(IOST,1,2)="C-" D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1
 Q
 ;
ONE ; -- print one entry
 ; -- ^tmp($j,"ibtour",primary sort,secondary sort,ibtrc)=^IBT(IBTRC)
 ;
 S IBAPL=$$APPEAL^IBTODD1(IBTRC)
 ;
 I IOSL<($Y+4) D HDR Q:IBQUIT
 S DFN=+$P(IBTRCD,"^",5) D PID^VADPT
 S IBTRCD=$G(^IBT(356.2,+IBTRC,0))
L1 W !,$E($P(^DPT(DFN,0),"^"),1,22),?25,VA("PID")
 S IBCDT=$$CDT^IBTODD1($P(IBTRCD,"^",2))
 W ?38,$$DAT1^IBOUTL(+IBCDT\1) W:$P(IBCDT,"^",2) " to"
 W ?50,$P($G(^IBE(356.11,+$P(IBTRCD,"^",4),0)),"^",3) ;review type abbrev
 W ?64,$$DAT1^IBOUTL(+IBTRCD) ;review date
 W ?78,$E($$EXPAND^IBTRE(356.2,.08,$P(IBTRCD,"^",8)),1,20) ; ins co
 W ?100,$E($$EXPAND^IBTRE(356.2,.11,$P(IBTRCD,"^",11)),1,10) ;ins co action
 W ?112,$E($$EXPAND^IBTRE(356.2,1.04,$P($G(^IBT(356.2,+IBTRC,1)),"^",4)),1,19) ; last reviewer
 ;
L2 W !?38,$$DAT1^IBOUTL($P(IBCDT,"^",2)\1,"2P")
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"UR Insurance Review Activity Report",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"For Insurance Reviews Dated ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !!,?38,"Dates of",?64,"Review"
 W !,"Patient",?25,"Pt. ID",?38,"Care",?50,"Review Type",?64,"Date",?78,"Ins. Co.",?100," Action",?112,"Last Reviewer"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
HOSP ; -- print hospital report
 N IBCNT
 D HHDR
 I $O(^TMP($J,"IBTOUR3",""))="" W !!,"No Hospital Reviews Found in Date Range." G HOSPQ
 ;
 S IBH="" F  S IBH=$O(^TMP($J,"IBTOUR3",IBH)) Q:IBH=""!(IBQUIT)  D
 .D SUBHDR^IBTOUR5
 .S IBI="" F  S IBI=$O(^TMP($J,"IBTOUR3",IBH,IBI)) Q:IBI=""!(IBQUIT)  D
 ..D SSUBHDR^IBTOUR5
 ..S IBJ="" F  S IBJ=$O(^TMP($J,"IBTOUR3",IBH,IBI,IBJ)) Q:IBJ=""!(IBQUIT)  D
 ...S IBTRN="" F  S IBTRN=$O(^TMP($J,"IBTOUR3",IBH,IBI,IBJ,IBTRN)) Q:IBTRN=""!(IBQUIT)  S IBDATA=^(IBTRN) D HOSPONE
 ;
HOSPQ I 'IBQUIT,$E(IOST,1,2)="C-" D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1
 Q
 ;
HOSPONE ; -print one case line
 I IOSL<($Y+4) D HHDR Q:IBQUIT
 S IBTRND=$G(^IBT(356,+IBTRN,0))
 S DFN=+$P(IBTRND,"^",2) D PID^VADPT
HL1 W !,$E($P(^DPT(DFN,0),"^"),1,22),?25,VA("PID")
 S IBCDT=$$CDT^IBTODD1(IBTRN)
 W ?38,$$DAT1^IBOUTL(+IBCDT\1) W:$P(IBCDT,"^",2) " to"
 S TYPE="" I $P(IBTRND,"^",25) S TYPE="RANDOM"
 I $P(IBTRND,"^",26) S:$L(TYPE) TYPE=TYPE_"/" S TYPE=TYPE_$$EXPAND^IBTRE(356,.26,$P(IBTRND,"^",26))
 I $P(IBTRND,"^",27) S:$L(TYPE) TYPE=TYPE_"/LOCAL"
 W ?51,TYPE
 W ?70,$S($P(IBDATA,"^"):"YES",$P(IBDATA,"^")=0:"NO",1:"")
 W ?84,$J($P(IBDATA,"^",2),8)
 W ?98,$J($P(IBDATA,"^",3),8)
 ;
 W ?112,$E($$EXPAND^IBTRE(356,1.05,$P($G(^IBT(356,+IBTRN,1)),"^",5)),1,19) ; last reviewer
 ;
HL2 I $P(IBCDT,"^",2)'="" W !?38,$$DAT1^IBOUTL($P(IBCDT,"^",2)\1,"2P")
 W ! Q
 ;
HHDR ; -- hospital review header
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"UR Hospital Review Activity Report",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"For Hospital Reviews Dated ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !!,?38,"Dates of",?69,"Admission",?84,"Days Met",?98,"Days Not Met"
 W !,"Patient",?25,"Pt. ID",?38,"Care",?51,"Review Type",?69,"Met Criteria",?84,"Criteria",?98,"Criteria",?112,"Assigned Reviewer"
 W !,$TR($J(" ",IOM)," ","-")
 Q

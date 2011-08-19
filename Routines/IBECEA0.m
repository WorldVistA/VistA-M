IBECEA0 ;ALB/CPM - Cancel/Edit/Add... Build List ; 22-APR-93
 ;;2.0;INTEGRATED BILLING;**167**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ARRAY ; Build list for the List Manager.
 N C,IBATYP,IBAX,IBCHG,IBD,IBN,IBND,IBSTAT,Y
 S VALMBG=1,VALMCNT=0,VALMBCK="R"
 K @IBACMAR,@IBACMIDX,@VALMIDX,^TMP("IBACM",$J),^TMP("IBECEA",$J)
 D APDT,APTDT:$G(IBRX)
 S IBD="" F  S IBD=$O(^TMP("IBECEA",$J,IBD)) Q:'IBD  D
 .S IBN="" F  S IBN=$O(^TMP("IBECEA",$J,IBD,IBN)) Q:'IBN  D 
 ..S IBND=^IB(IBN,0) Q:$P(IBND,"^",7)=""
 ..S VALMCNT=VALMCNT+1,Y=$P(IBND,"^",5),C=$P(^DD(350,.05,0),"^",2) D Y^DIQ S IBSTAT=Y
 ..S IBATYP=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^") S:$E(IBATYP,1,2)="DG" IBATYP=$E(IBATYP,4,99)
 ..;  if ouptatient charge and clinic stop, show it
 ..I $E(IBATYP,1,3)="OPT",$P(IBND,"^",20) S IBATYP=$E(IBATYP_"                 ",1,17)_" "_$P($G(^IBE(352.5,+$P(IBND,"^",20),0)),"^")
 ..S IBCHG=$S(IBATYP["CANCEL":"(",1:" ")_"$"_$P(IBND,"^",7)_$S(IBATYP["CANCEL":")",1:"")
 ..S IBAX=$$SETSTR^VALM1(VALMCNT,"",+$P(VALMDDF("CHG#"),"^",2),+$P(VALMDDF("CHG#"),"^",3))
 ..S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL(IBD),IBAX,+$P(VALMDDF("FDATE"),"^",2),+$P(VALMDDF("FDATE"),"^",3))
 ..S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL($S($P(IBND,"^",8)["RX COPAY":IBD,1:$P(IBND,"^",15))),IBAX,+$P(VALMDDF("TDATE"),"^",2),+$P(VALMDDF("TDATE"),"^",3))
 ..S IBAX=$$SETSTR^VALM1(IBATYP,IBAX,+$P(VALMDDF("ENTRY"),"^",2),+$P(VALMDDF("ENTRY"),"^",3))
 ..S IBAX=$$SETSTR^VALM1($P($P(IBND,"^",11),"-",2),IBAX,+$P(VALMDDF("BILL#"),"^",2),+$P(VALMDDF("BILL#"),"^",3))
 ..S IBAX=$$SETSTR^VALM1(IBSTAT,IBAX,+$P(VALMDDF("STATUS"),"^",2),+$P(VALMDDF("STATUS"),"^",3))
 ..S IBAX=$$SETSTR^VALM1(IBCHG,IBAX,+$P(VALMDDF("CHARGE"),"^",2),+$P(VALMDDF("CHARGE"),"^",3))
 ..S @IBACMAR@(VALMCNT,0)=IBAX,@IBACMAR@("IDX",VALMCNT,VALMCNT)="",@VALMIDX@(VALMCNT)=VALMCNT
 ..S @IBACMIDX@(VALMCNT)=VALMCNT_"^"_DFN_"^"_IBATYP_"^"_IBN_"^"_IBCHG_"^"_IBSTAT
 I '$O(@IBACMAR@(0)) S @IBACMAR@(1,0)=" ",@IBACMAR@(2,0)="No charges meet criteria",VALMCNT=2,@VALMIDX@(1)=1,@VALMIDX@(2)=2
 Q
 ;
APDT ; Gather Means Test and CHAMPVA charges.
 N IBN,IBX,Y,Y1
 S Y="" F  S Y=$O(^IB("AFDT",DFN,Y)) Q:'Y  I -Y'>IBAEND S Y1=0 F  S Y1=$O(^IB("AFDT",DFN,Y,Y1)) Q:'Y1  D
 .S IBN=0 F  S IBN=$O(^IB("AF",Y1,IBN)) Q:'IBN  D
 ..Q:'$D(^IB(IBN,0))  S IBX=^(0)
 ..Q:$P(IBX,"^",8)["ADMISSION"
 ..I $P(IBX,"^",15)<IBABEG!($P(IBX,"^",14)>IBAEND) Q
 ..S ^TMP("IBECEA",$J,+$P(IBX,"^",14),IBN)=""
 ;
 S Y=0  F  S Y=$O(^IB("ACVA",DFN,Y)) Q:'Y  I Y'>IBAEND S Y1=0 F  S Y1=$O(^IB("ACVA",DFN,Y,Y1)) Q:'Y1  D
 .S IBN=0 F  S IBN=$O(^IB("AD",Y1,IBN)) Q:'IBN  D
 ..Q:'$D(^IB(IBN,0))  S IBX=^(0)
 ..I $P(IBX,"^",15)<IBABEG!($P(IBX,"^",14)>IBAEND) Q
 ..S ^TMP("IBECEA",$J,Y,IBN)=""
 Q
 ;
APTDT ; Gather Rx copay charges entered through Cancel/Edit/Add.
 N DATE,IBN
 S DATE=IBABEG F  S DATE=$O(^IB("APTDT",DFN,DATE)) Q:'DATE!(DATE>IBAEND)  S IBN="" F  S IBN=$O(^IB("APTDT",DFN,DATE,IBN)) Q:'IBN  I $P($G(^IB(IBN,0)),"^",8)["RX" S ^TMP("IBECEA",$J,DATE\1,IBN)=""
 Q

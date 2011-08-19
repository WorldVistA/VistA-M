IBECEA5 ;ALB/CPM - Cancel/Edit/Add... Update Events ; 05-MAY-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Update Events -- invoke the List Manager.
 N VALMIDX,VALMHDR
 D EN^VALM("IB EVENTS")
 Q
 ;
INIT ; List Manager (IB EVENTS) main entry point.
 N IBAX,IBD,IBN,IBND,IBSTAT,IBLAST,IBWARD
 S IBACME="^TMP(""IBACME"",$J)",IBACMEI="^TMP(""IBACMEI"",$J)",IBD=""
 S VALMIDX="^TMP(""IBACMLI"",$J)",VALMBG=1,VALMCNT=0,VALMBCK="R"
 K @IBACME,@IBACMEI,@VALMIDX
 F  S IBD=$O(^IB("AFDT",DFN,IBD)) Q:'IBD  D
 .S IBN=0 F  S IBN=$O(^IB("AFDT",DFN,IBD,IBN)) Q:'IBN  D
 ..S IBND=$G(^IB(IBN,0)) Q:$P(IBND,"^",8)'["ADMISSION"
 ..S IBSTAT=$S($P(IBND,"^",5)=1:"OPEN",1:"CLOSED"),IBLAST=$P(IBND,"^",18)
 ..S Y=+$P($P(IBND,"^",4),":",2),Y=+$P($G(^DGPM(Y,0)),"^",6),Y=$E($P($G(^DIC(42,Y,0)),"^"),1,20)
 ..S VALMCNT=VALMCNT+1,IBWARD=$S(Y]"":Y,1:"*** unknown ***")
 ..S IBAX=$$SETSTR^VALM1($P(IBND,"^",8),VALMCNT,+$P(VALMDDF("TYPE"),"^",2),+$P(VALMDDF("TYPE"),"^",3))
 ..S IBAX=$$SETSTR^VALM1(IBWARD,IBAX,+$P(VALMDDF("WARD"),"^",2),+$P(VALMDDF("WARD"),"^",3))
 ..S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL($P(IBND,"^",17)),IBAX,+$P(VALMDDF("EDATE"),"^",2),+$P(VALMDDF("EDATE"),"^",3))
 ..S IBAX=$$SETSTR^VALM1(IBSTAT,IBAX,+$P(VALMDDF("STATUS"),"^",2),+$P(VALMDDF("STATUS"),"^",3))
 ..S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL(IBLAST),IBAX,+$P(VALMDDF("LCALC"),"^",2),+$P(VALMDDF("LCALC"),"^",3))
 ..S @IBACME@(VALMCNT,0)=IBAX,@IBACME@("IDX",VALMCNT,VALMCNT)="",@VALMIDX@(VALMCNT)=VALMCNT
 ..S @IBACMEI@(VALMCNT)=IBSTAT_"^"_IBLAST_"^"_IBN_"^"_$P(IBND,"^",17)
 I '$O(@IBACME@(0)) S @IBACME@(1,0)=" ",@IBACME@(2,0)="  This patient has no inpatient event records stored in Billing.",VALMCNT=2,@VALMIDX@(1)=1,@VALMIDX@(2)=2
 Q
 ;
HDR ; Build screen header.
 S VALMHDR(1)=$$SETSTR^VALM1("Update Billable Events","Cancel/Edit/Add Charges",59,22)
 S VALMHDR(2)=$$SETSTR^VALM1("Date Charges",$E("Patient: "_$P(IBNAM,"^"),1,25)_" "_$E(IBNAM)_$P(IBNAM,"^",3),68,12)
 Q
 ;
EXIT ; List Manager (IB EVENTS) exit action.
 K:$D(IBACME) @IBACME K:$D(IBACMEI) IBACMEI
 K IBACME,IBACMEI
 D FULL^VALM1,CLEAN^VALM10
 ;D CLEAN^VALM10,CLEAR^VALM1
 Q

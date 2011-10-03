IBTRKR4 ;ALB/AAS - CLAIMS TRACKING - ADD/TRACK OUTPATIENT ENCOUNTERS ; 13-AUG-93
 ;;2.0;INTEGRATED BILLING;**91,142,292,312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- entry point for nightly background job
 N IBTSBDT,IBTSEDT
 S IBTSBDT=$$FMADD^XLFDT(DT,$S($E(DT,6,7)=10:-730,1:-20))-.1
 S IBTSEDT=$$FMADD^XLFDT(DT,-2)-.9
 D EN1
 Q
 ;
EN ; -- entry point to ask date range
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                     ;IB*2.0*312
 N IBBDT,IBEDT,IBTSBDT,IBTSEDT,IBTALK
 S IBTALK=1
 I '$P($G(^IBE(350.9,1,6)),"^",3) W !!,"I'm sorry, Tracking of Outpatient Encounters is currrently turned off." G ENQ
 W !!!,"Select the Date Range of Opt. Encounters to Add to Claims Tracking.",!
 D DATE^IBOUTL
 I IBBDT<1!(IBEDT<1) G ENQ
 S IBTSBDT=IBBDT,IBTSEDT=IBEDT
 ; Do NOT PROCESS on VistA if Start or End>=Switch Eff Dt    ;CCR-930
 ; -- check selected dates                                   ;IB*2.0*312
 I +IBSWINFO,((IBTSBDT+1)>$P(IBSWINFO,"^",2))!((IBTSEDT+1)>$P(IBSWINFO,"^",2)) D  G EN
   .W !!,"The Begin OR End Date CANNOT be on or after"
   .W !,"the PFSS Effective Date: ",$$FMTE^XLFDT($P(IBSWINFO,"^",2))
 ;
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; start date can't be before parameters
 I +IBTRKR,IBTSBDT<+IBTRKR S IBTSBDT=IBTRKR W !!,"Begin date is before Claims Tracking Start Date, changed to ",$$DAT1^IBOUTL(IBTSBDT)
 ; -- end date into future
 I IBTSEDT>$$FMADD^XLFDT(DT,-1) W !!,"I'll automatically change the end date to 1 day prior to the date queued to run."
 W !!!,"I'm going to automatically queue this off and send you a"
 W !,"mail message when complete.",!
 S ZTIO="",ZTRTN="EN1^IBTRKR4",ZTSAVE("IB*")="",ZTDESC="IB - Add Opt Encounters to Claims Tracking"
 D ^%ZTLOAD I $G(ZTSK) K ZTSK W !,"Request Queued"
ENQ K ZTSK,ZTIO,ZTSAVE,ZTDESC,ZTRTN
 D HOME^%ZIS
 Q
 ;
EN1 ; -- add outpatient encounters to claims tracking file
 N I,J,X,Y,IBTRKR,IBDT,DFN,IBOETA,IBCNT,IBCNT1,IBCNT2
 ;
 ; -- check parameters
 S IBTRKR=$G(^IBE(350.9,1,6))
 G:'$P(IBTRKR,"^",3) EN1Q ; quit if opt tracking off
 I +IBTRKR,IBTSBDT<+IBTRKR S IBTSBDT=IBTRKR ; start date can't be before parameters
 ;
 ; -- users can queue into future, make sure dates not after date run
 ;I IBTSEDT>DT S IBTSEDT=DT
 I IBTSEDT>$$FMADD^XLFDT(DT,-1) S IBMESS="(Selected end date of "_$$DAT1^IBOUTL(IBTSEDT)_" automatically changed to "_$$DAT1^IBOUTL($$FMADD^XLFDT(DT,-1))_".)",IBTSEDT=$$FMADD^XLFDT(DT,-1)
 ;
 S IBOETYP=$O(^IBE(356.6,"AC",2,0)) ;event type pointer for opt encounters
 ;
 ; -- cnt= total count, cnt1=count added nsc, cnt2=count of pending
 S (IBCNT,IBCNT1,IBCNT2)=0
 ;
 N IBVAL,IBCBK,IBFILTER
 S IBVAL("BDT")=IBTSBDT,IBVAL("EDT")=IBTSEDT+.9
 ; Only parent encounters, status is checked out, check out date exists,
 ;   not already in CT, not already an entry for the same encounter
 S IBFILTER=""
 ;S IBCBK="S IBCNT=IBCNT+1 I '$P(Y0,U,6),$P(Y0,U,12)=2,$P(Y0,U,7),'$O(^IBT(356,""AENC"",+$P(Y0,U,2),Y,0)),'$O(^IBT(356,""APTY"",+$P(Y0,U,2),IBOETYP,+Y0,0)) S IBDT=+Y0,IBOE=Y D OPCHK^IBTRKR41"
 S IBCBK="S IBCNT=IBCNT+1 I '$P(Y0,U,6),$P(Y0,U,12)=2,$P(Y0,U,7),'$O(^IBT(356,""AENC"",+$P(Y0,U,2),Y,0)),$S($D(^IBE(356.6,""ACODE"",2,IBOETYP)):1,1:'$O(^IBT(356,""APTY"",+$P(Y0,U,2),IBOETYP,+Y0,0))) S IBDT=+Y0,IBOE=Y D OPCHK^IBTRKR41"
 D SCAN^IBSDU("DATE/TIME",.IBVAL,IBFILTER,IBCBK,1) ;Scan,then close query
 ;
 I $G(IBTALK) D BULL^IBTRKR41
EN1Q I $D(ZTQUEUED) S ZTREQ="@"
 Q

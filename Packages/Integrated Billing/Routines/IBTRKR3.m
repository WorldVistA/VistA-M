IBTRKR3 ;ALB/AAS - CLAIMS TRACKING - ADD/TRACK RX FILLS ;13-AUG-93
 ;;2.0;INTEGRATED BILLING;**13,43,121,160,247,275,260,309,336,312,339,347,405,384,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% ; -- entry point for nightly background job
 N IBTSBDT,IBTSEDT
 S IBTSBDT=$$FMADD^XLFDT(DT,-14)-.1
 S IBTSEDT=$$FMADD^XLFDT(DT,-7)+.9
 D EN1
 Q
 ;
EN ; -- entry point to ask date range
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI() ;IB*2.0*312
 N IBBDT,IBEDT,IBTSBDT,IBTSEDT,IBTALK,IBMESS
 S IBTALK=1
 I '$P($G(^IBE(350.9,1,6)),"^",4) W !!,"I'm sorry, Tracking of Prescription Refills is currently turned off." G ENQ
 W !!!,"Select the Date Range of Rx Refills to Add to Claims Tracking.",!
 D DATE^IBOUTL
 I IBBDT<1!(IBEDT<1) G ENQ
 S IBTSBDT=IBBDT,IBTSEDT=IBEDT
 ;
 ; Do NOT PROCESS on VistA if Start or End>=Switch Eff Date ;IB*2.0*312
 I +IBSWINFO,((IBTSBDT+1)>$P(IBSWINFO,"^",2))!((IBTSEDT+1)>$P(IBSWINFO,"^",2)) D  G EN
 .W !!,"The Begin OR End Date CANNOT be on or after"
 .W !,"the PFSS Effective Date: ",$$FMTE^XLFDT($P(IBSWINFO,"^",2))
 ;
 ; -- check selected dates
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; start date can't be before parameters
 I +IBTRKR,IBTSBDT<+IBTRKR S IBTSBDT=IBTRKR W !!,"Begin date is before Claims Tracking Start Date, changed to ",$$DAT1^IBOUTL(IBTSBDT)
 ; -- end date into future
 I IBTSEDT>$$FMADD^XLFDT(DT,-3) W !!,"I'll automatically change the end date to 3 days prior to the date queued to run."
 ;
 W !!!,"I'm going to automatically queue this off and send you a"
 W !,"mail message when complete.",!
 S ZTIO="",ZTRTN="EN1^IBTRKR3",ZTSAVE("IB*")="",ZTDESC="IB - Add Rx Refills to Claims Tracking"
 D ^%ZTLOAD I $G(ZTSK) K ZTSK W !,"Request Queued"
ENQ K ZTSK,ZTIO,ZTSAVE,ZTDESC,ZTRTN
 D HOME^%ZIS
 Q
 ;
EN1 ; -- add rx refills to claims tracking file
 N I,J,X,Y,IBTRKR,IBDT,IBRXN,IBFILL,DFN,IBDATA,IBCNT,IBCNT1,IBCNT2,LIST1
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI() ;IB*2.0*312
 N IBICD,IBCOPAY
 ;
 ; -- check parameters
 S IBTRKR=$G(^IBE(350.9,1,6))
 G:'$P(IBTRKR,"^",4) EN1Q ; quit if rx tracking off
 I +IBTRKR,IBTSBDT<+IBTRKR S IBTSBDT=IBTRKR ; start date can't be before parameters
 ;
 ; -- users can queue into future, make sure dates not after date run
 I IBTSEDT>$$FMADD^XLFDT(DT,-3) S IBMESS="(Selected end date of "_$$DAT1^IBOUTL(IBTSEDT)_" automatically changed to "_$$DAT1^IBOUTL($$FMADD^XLFDT(DT,-3))_".)",IBTSEDT=$$FMADD^XLFDT(DT,-3)
 ;
 S IBRXTYP=$O(^IBE(356.6,"AC",4,0)) ; event type pointer for rx billing
 ;
 ; -- cnt= total count, cnt1=count added nsc, cnt2=count of pending
 S (IBCNT,IBCNT1,IBCNT2)=0
 S IBDT=IBTSBDT-.0001
 S LIST1="IBTRKAD"
 D REF^PSO52EX(IBDT,IBTSEDT,LIST1)
 S IBDT=0
 F  S IBDT=$O(^TMP($J,LIST1,"AD",IBDT)) Q:'IBDT!(IBDT>IBTSEDT)  D
 .S IBRXN=0
 .I +IBSWINFO,(IBDT+1)>$P(IBSWINFO,"^",2) Q
 .F  S IBRXN=$O(^TMP($J,LIST1,"AD",IBDT,IBRXN)) Q:'IBRXN  D
 ..S IBFILL=""
 ..F  S IBFILL=$O(^TMP($J,LIST1,"AD",IBDT,IBRXN,IBFILL)) Q:IBFILL=""  D RXCHK
 K ^TMP($J,LIST1)
 ;
 I $G(IBTALK) D BULL^IBTRKR31
EN1Q I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
RXCHK ; -- check and add rx
 N IBND,LIST,NODE
 S IBCNT=IBCNT+1
 ;I IBFILL<1 G RXCHKQ ; original fill
 I IBDT>(DT+.24) G RXCHKQ ; future fill
 I '$D(ZTQUEUED),($G(IBTALK)) W "."
 ;
 S DFN=$$FILE^IBRXUTL(IBRXN,2)
 S IBRXDATA=$$RXZERO^IBRXUTL(DFN,IBRXN),IBRXSTAT=$$FILE^IBRXUTL(IBRXN,100,"I")
 ;I IBDT=$P($O(^DPT(DFN,"S",(IBDT-.00001))),".") G RXCHKQ ;scheduled appointment on same day as fill date
 ;I $$BABCSC^IBEFUNC(DFN,$P(IBDT,".",1)) G RXCHKQ ; is billable clinic stop in encounter file for data (allows telephone stops on same day, but not others) (P121 - RC, can now bill Rx if on same day as opt visit)
 ;
 ; -- not already in claims tracking
 I $O(^IBT(356,"ARXFL",IBRXN,IBFILL,"")) G RXCHKQ ; already in claims tracking
 ;
 ; -- see if tracking only insured and pt is insured
 I $P(IBTRKR,"^",4)=1,'$$INSURED^IBCNS1(DFN,IBDT) G RXCHKQ ; patient not insure
 ;
 ; -- check rx status (not deleted)
 I IBRXSTAT=13 G RXCHKQ
 ;
 ; -- Don't PROCESS IF there is already a PFSS ACCT REF# -- ;IB*2.0*312
 I 'IBFILL,+$$FILE^IBRXUTL(IBRXN,125) G RXCHKQ
 I +IBFILL,+$$SUBFILE^IBRXUTL(IBRXN,IBFILL,52,21) G RXCHKQ
 ;
 ; -- original fill not released or returned to stock
 I 'IBFILL,'$$FILE^IBRXUTL(IBRXN,31) G RXCHKQ
 I 'IBFILL,$$FILE^IBRXUTL(IBRXN,32.1) G RXCHKQ
 ;
 ; -- refill not released or returned to stock
 I +IBFILL,'$$SUBFILE^IBRXUTL(IBRXN,IBFILL,52,17) G RXCHKQ
 I +IBFILL,$$SUBFILE^IBRXUTL(IBRXN,IBFILL,52,14) G RXCHKQ
 ;
 ; -- check drug (not investigational, supply, over the counter drug, or nutritional supplement
 S IBDRUG=$P(IBRXDATA,"^",6)
 D ZERO^IBRXUTL(IBDRUG)
 S IBDEA=$G(^TMP($J,"IBDRUG",+IBDRUG,3))
 K ^TMP($J,"IBDRUG")
 I IBDEA["I"!(IBDEA["S")!(IBDEA["9")!(IBDEA["N") G RXCHKQ ; investigational drug, supply, otc, or nutritional supplement
 ;
 ; -- see if insured for prescriptions
 I '$$PTCOV^IBCNSU3(DFN,IBDT,"PHARMACY",.IBANY) S IBRMARK=$S($G(IBANY):"NO PHARMACY COVERAGE",1:"NOT INSURED")
 ;
 ; -- check sc status and others
 ; -- new ICD node in PSO with CIDC, if it exists use this for determination
 S LIST="IBTRKRLST"
 S NODE="ICD"
 S IBICD=0,IBCOPAY=0
 D RX^PSO52API(DFN,LIST,IBRXN,,NODE,,)
 I +$G(^TMP($J,LIST,DFN,IBRXN,"ICD",0))>0 S IBICD=1 ;Setup ICD Flag
 I +$$IBND^IBRXUTL(DFN,IBRXN)>0 S IBCOPAY=1 ;Setup Copay Flag
 I $G(IBRMARK)="",IBICD D CL^SDCO21(DFN,IBDT,"",.IBARR) I $D(IBARR) D
 .S IBM=0
 .F  S IBM=$O(^TMP($J,LIST,DFN,IBRXN,"ICD",IBM)) Q:'IBM!($G(IBRMARK)'="")  D
 ..S IBZ=$$ICD^IBRXUTL1(DFN,IBRXN,IBM,LIST) F IBP=1:1:7 Q:$G(IBRMARK)'=""  I $D(IBARR(IBP)) D
 ... S IBRMARK=$S($P(IBZ,"^",IBP+1):$P($T(EXEMPT+IBP),";",3),$P(IBZ,"^",IBP+1)=0:"",1:"NEEDS SC DETERMINATION")
 ;
 ; -- no new ICD node in PSO, use old method of determining status
 I $G(IBRMARK)="",'IBICD D
 . D ELIG^VADPT
 . ;if the patient is covered by insurance for pharmacy ($G(IBRMARK)="")
 . ;AND if no copay in #350
 . ;then we need to determine the non billable reason and set IBRMARK
 . ;
 . ;IF VAEL(3) -- if this is a veteran with SC(service connection) status
 . I VAEL(3),'IBCOPAY D
 . . I $P(VAEL(3),"^",2)>49 S IBRMARK="NEEDS SC DETERMINATION"
 . . ;in case of POW and Unempl.vet we cannot decide if the 3rd party should be exempt
 . . N IBPOWUNV,IBAUTRET S IBAUTRET=$$AUTOINFO^DGMTCOU1(DFN),IBPOWUNV=$S($P(IBAUTRET,U,8):1,$P(IBAUTRET,U,9):1,1:0)
 . . I $P(VAEL(3),"^",2)<50 S IBRMARK=$S(IBPOWUNV:"NEEDS SC DETERMINATION",1:"SC TREATMENT")
 . . I $$RXST^IBARXEU(DFN,$P(IBRXDATA,U,13))>0 S IBRMARK="NEEDS SC DETERMINATION"
 . ;
 . ;IF +VAEL(3)=0 if the veteran doesn't have SC status, but
 . ;the veteran still may have CV status active
 . I $G(IBRMARK)="",+VAEL(3)=0,'IBCOPAY D
 . . I $$CVEDT^IBACV(DFN,IBDT) S IBRMARK="NEEDS SC DETERMINATION" ;SC-because IB staff usually is using this reason to search for cases that need to be reviewed. COMBAT VETERAN reason will be used after review if this was a case
 ;
 K ^TMP($J,LIST)
 ;
 ; ROI check
 N IBSCROI
 I $$SENS^IBNCPDR(IBDRUG) D
 . N IBINS,IBFLG,IBINSP
 . D ALL^IBCNS1(DFN,"IBINS",1,IBDT,1)
 . S IBINSP=$O(IBINS("S",1,99),-1) Q:IBINSP=""
 . S IBFLG=$$ROI^IBNCPDR4(DFN,$G(IBDRUG),+$G(IBINS(IBINSP,"0")),$G(IBDT))
 . I 'IBFLG,$G(IBRMARK)="" S IBRMARK="ROI NOT OBTAINED"      ; IB*2*550
 . I 'IBFLG S IBSCROI=3
 . I IBFLG S IBSCROI=2
 ;
 ; -- ok to add to tracking module
 D REFILL^IBTUTL1(DFN,IBRXTYP,IBDT,IBRXN,IBFILL,$G(IBRMARK),,$G(IBSCROI)) I '$D(ZTQUEUED),$G(IBTALK) W "+"
 ;
 I $G(IBRMARK)'="" S IBCNT2=IBCNT2+1
 I $G(IBRMARK)="" S IBCNT1=IBCNT1+1
 K IBANY,IBRMARK,VAEL,VA,IBDEA,IBDRUG,IBRXSTAT,IBRXDATA,DFN,X,Y
 K IBARR,IBM,IBZ,IBP
RXCHKQ Q
 ;
EXEMPT ; exemption reasons
 ;;AGENT ORANGE
 ;;IONIZING RADIATION
 ;;SC TREATMENT
 ;;SOUTHWEST ASIA
 ;;MILITARY SEXUAL TRAUMA
 ;;HEAD/NECK CANCER
 ;;COMBAT VETERAN
 ;;PROJECT 112/SHAD
 ;;

IBTRKR5 ;ALB/AAS - CLAIMS TRACKING - ADD/TRACK PROSTHETICS ;13-JAN-94
 ;;2.0;INTEGRATED BILLING;**13,260,312,339,389,474,498,568**;21-MAR-94;Build 40
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% ; -- entry point for nightly background job
 N IBTSBDT,IBTSEDT
 S IBTSBDT=$$FMADD^XLFDT(DT,$S($E(DT,6,7)=10:-730,1:-20))-.1  ;IB*2.0*568
 S IBTSEDT=$$FMADD^XLFDT(DT,-3)+.9
 D EN1
 Q
 ;
EN ; -- entry point to ask date range
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                   ;IB*2.0*312
 N IBBDT,IBEDT,IBTSBDT,IBTSEDT,IBTALK
 S IBTALK=1
 I '$P($G(^IBE(350.9,1,6)),"^",4) W !!,"I'm sorry, Tracking of Prosthetics is currently turned off." G ENQ
 W !!!,"Select the Date Range of Prosthetics to Add to Claims Tracking.",!
 D DATE^IBOUTL
 I IBBDT<1!(IBEDT<1) G ENQ
 S IBTSBDT=IBBDT,IBTSEDT=IBEDT
 ;
 ; -- check selected dates                                 ;IB*2.0*312
 ; Do NOT PROCESS on VistA if Start or End>=Switch Eff Dt  ;CCR-930
 I +IBSWINFO,((IBTSBDT+1)>$P(IBSWINFO,"^",2))!((IBTSEDT+1)>$P(IBSWINFO,"^",2)) D  G EN
  .W !!,"The Begin OR End Date CANNOT be on or after the PFSS Effective date"
  .W ": ",$$FMTE^XLFDT($P(IBSWINFO,"^",2))
 ;
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; start date can't be before parameters
 I +IBTRKR,IBTSBDT<+IBTRKR S IBTSBDT=IBTRKR W !!,"Begin date is before Claims Tracking Start Date, changed to ",$$DAT1^IBOUTL(IBTSBDT)
 ; -- end date into future
 I IBTSEDT>$$FMADD^XLFDT(DT,-3) W !!,"I'll automatically change the end date to 3 days prior to the date queued to run."
 ;
 W !!,"This should be queued to run after hours"
 W !!!,"I'm going to automatically queue this off and send you a"
 W !,"mail message when complete.",!
 S ZTIO="",ZTRTN="EN1^IBTRKR5",ZTSAVE("IB*")="",ZTDESC="IB - Add Prosthetics to Claims Tracking"
 D ^%ZTLOAD I $G(ZTSK) K ZTSK W !,"Request Queued"
ENQ K ZTSK,ZTIO,ZTSAVE,ZTDESC,ZTRTN
 D HOME^%ZIS
 Q
 ;
EN1 ; -- add prostethics to claims tracking file
 N I,J,X,Y,IBTRKR,IBDT,DFN,IBDATA,IBCNT,IBCNT1,IBCNT2,IBDTS,PROCOV
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                   ;IB*2.0*312
 ;
 ; -- check parameters
 S IBTRKR=$G(^IBE(350.9,1,6))
 G:'$P(IBTRKR,"^",5) EN1Q ; quit if prothetics tracking off
 I +IBTRKR,IBTSBDT<+IBTRKR S IBTSBDT=IBTRKR ; start date can't be before parameters
 ;
 ; -- users can queue into future, make sure dates not after date run
 I IBTSEDT>$$FMADD^XLFDT(DT,-3) S IBMESS="(Selected end date of "_$$DAT1^IBOUTL(IBTSEDT)_" automatically changed to "_$$DAT1^IBOUTL($$FMADD^XLFDT(DT,-3))_".)",IBTSEDT=$$FMADD^XLFDT(DT,-3)
 ;
 ;S IBPRTYP=$O(^IBE(356.6,"AC",3,0)) ; this is the event type pointer for prosthetics
 ;
 ; -- cnt= total count, cnt1=count added nsc, cnt2=count of pending
 S (IBCNT,IBCNT1,IBCNT2)=0
 S (IBDTS,IBDT)=IBTSBDT-.0001
 ;
 ; loop twice, once for shipmnet date (new search), and once for
 ; delivery date (old search) for backward compatibility.
 F  S IBDT=$O(^RMPR(660,"AF",IBDT)) Q:'IBDT!(IBDT>IBTSEDT)  D
    .; Do NOT PROCESS on VistA if IBDT>=Switch Eff Date    ;CCR-930
    .I +IBSWINFO,(IBDT+1)>$P(IBSWINFO,"^",2) Q             ;IB*2.0*312
    .S IBDA=0 F  S IBDA=$O(^RMPR(660,"AF",IBDT,IBDA)) Q:'IBDA  D PRCHK
 ;
 ; reset date and do old check
 S IBDT=IBDTS
 F  S IBDT=$O(^RMPR(660,"CT",IBDT)) Q:'IBDT!(IBDT>IBTSEDT)  D
    .; Do NOT PROCESS on VistA if IBDT>=Switch Eff Date    ;CCR-930
    .I +IBSWINFO,(IBDT+1)>$P(IBSWINFO,"^",2) Q             ;IB*2.0*312
    .S IBDA="" F  S IBDA=$O(^RMPR(660,"CT",IBDT,IBDA)) Q:'IBDA  D PRCHK
 ;
 I $G(IBTALK) D BULL ;^IBTRKR51
EN1Q I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
PRCHK ; -- check and add item
 N IBE,IBP,IBDX,IBRMARK,IBARR,IBT,IBINS
 S IBCNT=IBCNT+1,IBRMARK=""
 I '$D(ZTQUEUED),($G(IBTALK)) W "."
 ;
 S IBDATA=$G(^RMPR(660,+IBDA,0)) Q:IBDATA=""
 S DFN=$P(IBDATA,"^",2) Q:'DFN
 ; quit if non billable PSAS HCPCS code is found
 I $$IBPHP(IBDA) Q
 D CL^SDCO21(DFN,IBDT,"",.IBARR)
 ;
 ; -- checks copied from rmprbil v2.0 /feb 2, 1994
 Q:'$D(^RMPR(660,+IBDA,"AM"))
 Q:$P(^RMPR(660,+IBDA,0),U,9)=""!($P(^(0),U,12)="")!($P(^(0),U,14)="V")!($P(^(0),U,2)="")!($P(^(0),U,15)="*")
 ;Q:($P(^RMPR(660,+IBDA,"AM"),U,3)=2)!($P(^("AM"),U,3)=3)
 ;
 ;
 I $O(^IBT(356,"APRO",IBDA,0)) G PRCHKQ ; already in claims tracking
 ;
 ; -- see if tracking only insured and pt is insured
 I $P(IBTRKR,"^",5)=1,'$$INSURED^IBCNS1(DFN,IBDT) G PRCHKQ ; patient not insured
 ;
 ; -- if clasifications required, check exemptions
 ;IB*2.0*568
 N IBSC,SCP,SCR,SUB
 S SCR=0
 I '$D(IBARR) G CLQ
 F IBP=1:1:4 S IBDX(IBP)=$G(^RMPR(660,+IBDA,"BA"_IBP)) D
 .S SCR=0 F SCP=2:1:8 Q:SCR=1  I $P(IBDX(IBP),U,SCP)[1 S IBSC(IBP)=SCP,SCR=1
 I 'SCR S IBRMARK="NEEDS SC DETERMINATION" G CLQ ; no ICD node in RMPR, use old method of determining status
 S IBRMARK=""
 S IBE=0 F  S IBE=$O(IBARR(IBE)) Q:'IBE  D  Q:($L($G(IBRMARK)))
 .F IBP=1:1:4 Q:$L($G(IBRMARK))  D
 ..S (SUB,REC)="" I IBSC(IBP) S SUB="CL"_IBSC(IBP),REC=$T(@SUB)
 ..S IBRMARK=$S(REC'="":$P(REC,";",3),1:"NEEDS SC DETERMINATION")
 ;
 ;
CLQ ; -- ok to add to tracking module
 S PROCOV=0,SCR=+$G(SCR)
 S PROCOV=+$$PTCOV^IBCNSU3(DFN,IBDT,"PROSTHETICS")
 I 'PROCOV,IBRMARK="NEEDS SC DETERMINATION" S IBRMARK="NO PROSTHETIC COVERAGE"
 I 'PROCOV,IBRMARK="" S IBRMARK="NO PROSTHETIC COVERAGE"
 D PRO^IBTUTL1(DFN,IBDT,IBDA,$G(IBRMARK)) I '$D(ZTQUEUED),$G(IBTALK) W "+"
 I SCR=1 S IBCNT2=IBCNT2+1
 I SCR=0 S IBCNT1=IBCNT1+1
 K VAEL,VA,IBDATA,DFN,X,Y
PRCHKQ Q
 ;
IBPHP(IBDA) ; non billable PSAS HCPCS codes
 ; input-patient item in #660
 ; output-value if the code with the first 2 chars in the string is found
 N IBPSAS,IBPIN S IBPIN=""
 S IBPSAS=",BA,DI,DL,EC,EV,FE,HI,HN,HS,NR,RE,SB,SI,TH,TM,TR,VA,"
 ; return the pointer^description^the code (#661.1,.01)
 S IBPIN=$$PIN^IBATUTL(+IBDA)
 S IBPIN=$P(IBPIN,U,3)
 S IBPIN=$F(IBPSAS,","_$E(IBPIN,1,2)_",")
 Q IBPIN
 ;
BULL ; -- send bulletin
 ;
 S XMSUB="Prosthetic Items added to Claims Tracking Complete"
 S IBT(1)="The process to automatically add Prosthetic Items has successfully completed."
 S IBT(1.1)=""
 S IBT(2)="                      Start Date: "_$$DAT1^IBOUTL(IBTSBDT)
 S IBT(3)="                        End Date: "_$$DAT1^IBOUTL(IBTSEDT)
 I $D(IBMESS) S IBT(3.1)=IBMESS
 S IBT(4)=""
 S IBT(5)=" Total Prosthetics Items checked: "_$G(IBCNT)
 S IBT(6)="Total NSC Prosthetic Items Added: "_$G(IBCNT1)
 S IBT(7)=" Total SC Prosthetic Items Added: "_$G(IBCNT2)
 S IBT(8)=""
 S IBT(9)="*The items added as SC require determination and editing to be billed"
 D SEND^IBTRKR31
BULLQ Q
 ;
CLTXT ; classification text for reason not billable
CL2 ;;AGENT ORANGE
CL3 ;;IONIZING RADIATION
CL4 ;;SC TREATMENT
CL5 ;;SOUTHWEST ASIA
CL6 ;;MILITARY SEXUAL TRAUMA
CL7 ;;HEAD/NECK CANCER
CL8 ;;COMBAT VETERAN

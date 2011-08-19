IBOMTE ;ALB/CPM-ESTIMATE MEANS TEST CHARGES ;17-DEC-91
 ;;2.0;INTEGRATED BILLING;**153,183,202**;21-MAR-94
 ;
 S:'$D(DTIME) DTIME=300 D HOME^%ZIS
 ; Check the MAS Service pointer first.
START ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTE" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOMTE-1" D T0^%ZOSV ;start rt clock
 S IBY=1 D SERV^IBAUTL2 I IBY<1 D  G END
 . W !!,"Medical Administration Service is not defined in your IB Site Parameter File."
 . W !,"Please contact your System Manager, as this impacts on all aspects of",!,"Means Test billing.",!!
 ;
 ; Select patient to be admitted; check for previously billed charges.
 S DPTNOFZY=1 ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC K DIC G END:Y<1 S (DFN,IBDFN)=+Y
 K DPTNOFZY
 S IBGMT=$$ISGMTPT^IBAGMT(DFN,DT) ;GMT Copay Status
 I IBGMT>0 W !!,"The patient has Geographic Means Test Copayment Status.",!
 ;
 S IBADMDT=0 D EVFIND^IBAUTL3
 I IBEVDA D  G EDT
 . W !!,"Please note that this patient was admitted on ",$$DAT1^IBOUTL(IBEVDT)," and Means Test charges"
 . W !,"have been calculated through ",$$DAT1^IBOUTL(IBEVCAL),".",!
 . S X1=IBEVCAL,X2=1 D C^%DTC S IBBDT=X
 ;
 ; Get proposed Admission and Discharge dates.
BDT S %DT="AEPX",%DT("A")="Proposed ADMISSION Date: " D ^%DT K %DT G END:Y<0 S IBBDT=Y
 I IBBDT<DT W !!,"Past admissions cannot be accurately estimated.",! G BDT
EDT S %DT="EX" R !,"Proposed DISCHARGE Date: ",X:DTIME S:X=" " X=IBBDT
 G END:(X="")!(X["^") D ^%DT G EDT:Y<0 S IBEDT=Y
 I Y<IBBDT W *7," ??",!,"The DISCHARGE Date must follow the ADMISSION Date." G EDT:IBEVDA,BDT
 ;
 ; Select the anticipated Facility Treating Specialty, if the patient
 ; is not currently admitted, and check to see if a 'billable'
 ; bedsection is associated with it.
 I IBEVDA S VAIP("D")=IBEVCAL+.2359 D IN5^VADPT S Y=+VAIP(8) G BED
 ;
 S DIC="^DIC(45.7,",DIC(0)="AEQMN",DIC("A")="Anticipated Facility Treating Specialty: "
 D ^DIC K DIC G END:Y<1
BED S IBBS=$$SECT^IBAUTL5(+Y) I 'IBBS D  G END
 . W !!,"A 'billable' bedsection is not associated with this ",$S(IBEVDA:"Admission",1:"Treating Specialty"),"."
 . W !,"Means Test charges ",$S(IBEVDA:"are not being",1:"would not be")," billed for this admission.",!
 ;
 ; Select an output device.
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="^IBOMTE1",ZTDESC="MEANS TEST INPATIENT BILLING ESTIMATOR",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") D HOME^%ZIS,END W ! G START
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTE" D T1^%ZOSV ;stop rt clock
 D ^IBOMTE1 ; generate report
 D END W ! G START ; re-run report
 ;
END K %DT,DFN,IBADMDT,IBBS,IBDFN,IBBDT,IBEVDA,IBEVDT,IBEVCAL,IBEDT,IBSERV,IBY,VAIP,VAERR,X,X1,X2,X3,Y,ZTSK,IBRATE,IBGMT
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTE" D T1^%ZOSV ;stop rt clock
 Q

IBAMTC ;ALB/CPM-MEANS TEST NIGHTLY COMPILATION JOB ;09-OCT-91
V ;;2.0;INTEGRATED BILLING;**34,52,70,93,100,118,115,132,150,153,137,176,215,275,321,312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
INIT ; Entry point - initialize variables and parameters
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBAMTC-1" D T0^%ZOSV ;start rt clock
 ;
 D UPDT^IBARXEPS($$FMADD^XLFDT(DT,-30),DT,1)
 ;
 D NIGHTLY^IBTRKR ; claims tracking nightly update
 ;
 D ^IBCD ; automated biller
 ;
 D RELPR^IBAMTV3 ; auto-release patient charges on hold at least 60 days
 ;
 D EN^IBOHRL ; auto-release patient charges on hold longer than 90 days
 ;
 K IBDT D BJ^IBJDE  ; Automated DM extract monthly background job.
 ;
 ; - transfer pricing background job
 I '+$$SWSTAT^IBBAPI() D ^IBATEI1                           ;IB*2.0*312
 ;
 D NIGHT^IBARXMA ; transmit copay cap info
 ;
 D NOW^%DTC S IBAFY=$$FY^IBOUTL(X),DT=X,U="^"
 S (IBERRN,IBWHER,IBJOB,IBY,Y)=1,IBCNT=0 K ^TMP($J,"IBAMTC")
 D SITE^IBAUTL I Y<1 S IBY=Y D ERR G CLEAN
 D SERV^IBAUTL2 I IBY<1 D ERR G CLEAN
 ;
 ; Compile Means Test copay and per diem charges for all inpatients
 ; Check PFSS Switch                                        ;IB*2.0*312
 I '+$$SWSTAT^IBBAPI() S (IBWARD,DFN)="" F  S IBWARD=$O(^DPT("CN",IBWARD)) Q:IBWARD=""  F  S DFN=$O(^DPT("CN",IBWARD,DFN)) Q:'DFN  W !,DFN S IBA=^(DFN),IBY=1 D PROC
 ;
 ;send inpatients' CV (CombatVet) expiration e-mail alert
 D CVEXMAIL^IBACV(DT)
 ;
 ;check & start LTC Monthly Job LTC if necessary
 ; This code may need to be expanded, IF we don't          ;IB*2.0*312 
 ; implement on the 1st of the month, for a clean cut over ;IB*2.0*312
 I '+$$SWSTAT^IBBAPI() D NJ^IBAECN1                        ;IB*2.0*312
 ;
 D EN^IBCE ; Transmit electronic bills
 ; Clean up expired Means Test billing clocks
CLEAN S %H=+$H-1 D YMD^%DTC S IBDT=X,(IBN,DFN)=0,IBWHER=23
 F  S DFN=$O(^IBE(351,"ACT",DFN)) Q:'DFN  D
 . F  S IBN=$O(^IBE(351,"ACT",DFN,IBN)) Q:'IBN  D
 ..  S IBY=1,X1=IBDT,(X2,IBCLDT)=+$P($G(^IBE(351,+IBN,0)),"^",3) D ^%DTC
 ..  I X>364 S IBCLDA=IBN D CLOCKCL^IBAUTL3,ERR:IBY<1
 ;
 ; Close out incomplete events where the patient has been discharged,
 ; pass the related charges if they appear correct, and send a bulletin
 ; - also, send bulletins on old incomplete charges where there is no
 ; incomplete event
 D MAIN^IBAMTC2
 ;
 ;D ^IBAMTC1
 ;
 ; Send bulletin reporting job completion
 I '+$$SWSTAT^IBBAPI() D BULL^IBAMTC1                     ;IB*2.0*312
 ;
 ; -- purge alerts
 D PURGE^IBAERR3
 ;
 ; Monitor special inpatient billing cases
 D BGJ^IBAMTI
 ;
 ; Print Pharmacy Copay Exemption Income Test Reminder Letters
 D EN^IBARXEL
 ;
 ; Kill variables and quit.
 D KILL1
 ;
 I $D(ZTQUEUED),$G(ZTSK) D KILL^%ZTLOAD
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBAMTC" D T1^%ZOSV ;stop rt clock
 ;
 Q
 ;
 ;
PROC ; Process all currently admitted patients.
 ;
 D IFCVEXP^IBACV(DFN,DT,IBA) ;if CV has expired (see CVEXMAIL^IBACV)
 ;--
 ;1) checks effective date for LTC legislation.
 ;2) determine current treating specialty (TS) for the 
 ;"original" admission.
 ;if TS is LTC: 
 ;  - creates new LTC #350 parent event entry if necessary.
 ;NOTE: It doesn't stop MT billing for LTC. CALC^IBAUTL4 does it.
 I $$ISLTCADM^IBAECN1(DFN,IBA)
 ;--
 D ORIG  ; find "original" admission date
 Q:$$BILST^DGMTUB(DFN)<IBADMDT  ; pat. was last billable before admission
 Q:IBADMDT\1=DT  ; patient was admitted today - process tomorrow
 Q:+$$MVT^DGPMOBS(IBA)  ; admitted for Observation & Examination
 Q:$O(^IBE(351.2,"AC",IBA,0))  ; skip special inpatient admissions
 ;
 ; - if vet is SC, create a Special Inpatient Billing Case
 ;   in file #351.2 (use code 3 for SC, as it is changed to 4 in IBAMTI)
 D ELIG^VADPT I VAEL(3) D ADM^IBAMTI(DFN,IBA,3) Q
 ;
 ; - gather event information
 D EVFIND^IBAUTL3 I 'IBEVDA D BSEC Q:'IBBS  ; wasn't billable yesterday
 S X=IBADMDT D H^%DTC S IBBDT=%H D:'IBEVDA LAST^IBAUTL5
 I IBEVDA,IBEVCAL S X1=IBEVCAL,X2=1 D C^%DTC S IBBDT=%H
 S IBEDT=+$H-1
 ; - gather clock information
 S IBWHER=24 D CLOCK^IBAUTL3 I IBY<1 D ERR G PROCQ
 I IBCLDA S X=IBCLDT D H^%DTC S IBCLCT=IBBDT-%H
 ; - build charges for inpatient days
 D ^IBAUTL4 I IBY<1 D ERR G PROCQ
 ; - pass per diem if over 30 days old, or both per diem and the copay
 ; - if 4 days from patient's statement date; update event, clock
 S IBWHER=22
 I $G(IBCHPDA),$P($G(^IB(+IBCHPDA,0)),"^",6)>30!($$STD^IBAUTL5(DFN)) S IBNOS=IBCHPDA D FILER^IBAUTL5 I IBY<1 D ERR G PROCQ
 I $G(IBCHCDA),$$STD^IBAUTL5(DFN) S IBNOS=IBCHCDA D FILER^IBAUTL5 I IBY<1 D ERR G PROCQ
 I IBEVDA,$D(IBDT) S IBEVCLD=IBDT D EVUPD^IBAUTL3
 I IBCLDA D CLUPD^IBAUTL3
PROCQ D KILL Q
 ;
BSEC ; Determine patient's bedsection for the previous day.
 S X1=DT,X2=-1 D C^%DTC
 S VAIP("D")=X_.2359 D IN5^VADPT S IBBS=$$SECT^IBAUTL5(+VAIP(8)) Q
 ;
ERR ; Error processing.  Input:  IBY, IBWHER, IBCNT
 S IBDUZ=DUZ,IBCNT=IBCNT+1 D ^IBAERR1 K IBDUZ Q
 ;S ^TMP($J,"IBAMTC","E",IBERRN)=$P(IBY,"^",2)_"^"_$S($D(DFN):DFN,1:"")_"^"_IBWHER,IBERRN=IBERRN+1 Q
 ;
ORIG ; Find first admission date, considering ASIH movements
 ;  Input:  IBA    Output:  IBADMDT
 N X,Y,Z S Z=IBA
 F  S X=$G(^DGPM(Z,0)),Y=$P(X,"^",21) Q:Y=""  S Z=+$P($G(^DGPM(Y,0)),"^",14)
 S IBADMDT=+X Q
 ;
KILL1 ; Kill all IB variables.
 K VAERR,VAEL,VAIP,IBA,IBADMDT,IBAFY,IBATYP,IBBDT,IBBS,IBCHARG,IBCHG,IBCNT,IBCUR,IBDESC,IBDISDT,IBDT,IBDUZ,IBFAC,IBI,IBIL,IBJOB,IBLC,IBMAX
 K IBN,IBNOS,IBSAVBS,IBSEQNO,IBSERV,IBSITE,IBSL,IBTRAN,IBX,IBY,IBWHER,IBWARD,IBEDT,IBCHCTY,IBCHPDE,IBERRN,IBASIH,IBRTED
KILL ; Kill all IB variables needed to build charges.
 K IBCLCT,IBCLDA,IBCLDT,IBCLDAY,IBCLDOL,IBCHPDA,IBCHCDA,IBCHG,IBCHFR,IBCHTO,IBCHTOTL,IBBS,IBNH
 K IBEVDA,IBEVDT,IBEVCLD,IBEVCAL,IBEVNEW,IBEVOLD,IBMED,IBTOTL,IBDESC,IBIL,IBTRAN,IBATYP,IBDATE
 Q

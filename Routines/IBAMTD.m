IBAMTD ;ALB/CPM - MOVEMENT EVENT DRIVER INTERFACE ;21-OCT-91
V ;;2.0;INTEGRATED BILLING;**45,52,93,115,132,153,164,156,234,312,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 I $G(DGPMA)="",$G(DGPMP)="" Q
 ;
EN ; Process events from the Movement Event Driver.
 ;
 ;S XRTL=$ZU(0),XRTN="IBAMTD-1" D T0^%ZOSV ;start rt clock
 ;
 Q:+$$SWSTAT^IBBAPI()                                      ;IB*2.0*312
 ;
 ; -- add admissions to claims tracking
 D INP^IBTRKR
 ;
 ; -- update Transfer Pricing
 D ^IBATEI
 ;
 ; -- check for Long Term Care
 N IBALTC D EN^IBAECI Q:IBALTC
 ;
 ; - process billing for CHAMPVA patients
 I $$CVA^IBAUTL5(DFN) D PROC^IBACVA G END
 ;
 ; - unflag continuous patients
 S IBASIH=$$ASIH^IBAUTL5(DGPMA)
 I DGPMP="",($P(DGPMA,"^",2)=3!(IBASIH)),$O(^IBE(351.1,"B",DFN,0)),$D(^IBE(351.1,+$O(^(0)),0)),'$P(^(0),"^",2) D UNFLAG^IBAMTD1
 ;
 ; - update case record on discharge for special inpatient episodes
 S IBA=$P($S(DGPMA="":DGPMP,1:DGPMA),"^",14)
 I $O(^IBE(351.2,"AC",IBA,0)),DGPMP="",($P(DGPMA,"^",2)=3!(IBASIH)) D DIS^IBAMTI(IBA) G END
 ;
 ; - quit if patient was last Means Test copay patient before adm. date
 S IBLC=$$BILST^DGMTUB(DFN) G:'IBLC END I DGPMA="",$P(DGPMP,"^",2)=1,IBLC<$P(+DGPMP,".") G END
 D ORIG^IBAMTC I IBLC<$P(IBADMDT,".") G END
 ;
 ; - if editing or deleting a movement, send bulletin; delete
 ;   case record in #351.2 for deleted admissions
 I DGPMP]"" S IBJOB=3 D  G END
 .D ^IBAMTBU
 .I DGPMA="",$P(DGPMP,"^",2)=1,$O(^IBE(351.2,"AC",IBA,0)) S DA=$O(^(0)),DIK="^IBE(351.2," D ^DIK K DA,DIK
 ;
 ; - add a case record for admission of special (ao/ir/swa/mst/hnc/shad/cv) inpatients
 I $P(DGPMA,"^",2)=1 D  G END
 .N IBCLSF D CL^IBACV(DFN,IBADMDT,"",.IBCLSF)
 .S IBCLSF=$O(IBCLSF(0)) I IBCLSF,(IBCLSF<5) D ADM^IBAMTI(DFN,IBA,IBCLSF) Q
 .I $P($$GETSTAT^DGMSTAPI(DFN,IBADMDT),U,2)="Y" S IBCLSF=5,IBCLSF(5)="" D ADM^IBAMTI(DFN,IBA,IBCLSF) Q
 .I IBCLSF=6 D ADM^IBAMTI(DFN,IBA,IBCLSF) ; hnc
 .I IBCLSF=8 D ADM^IBAMTI(DFN,IBA,IBCLSF) ; shad
 .I IBCLSF=7 D ADM^IBAMTI(DFN,IBA,IBCLSF) ; CV has the lowest priority
 ;
 ; - if adding a retro-active transfer or spec. transfer, send bulletin
 I ($P(DGPMA,"^",2)=2!($P(DGPMA,"^",2)=6)),+DGPMA<DT S IBJOB=6 D ^IBAMTBU
 ;
 ; - process discharges and ASIH movements only
 I $P(DGPMA,"^",2)'=3,'IBASIH G END
 ;
 W:'$G(DGQUIET) !,"Billing Means Test charges...."
 S (IBY,Y)=1,IBEVOLD=0,IBJOB=2,IBWHER=1,IBDISDT=+DGPMA\1,IBAFY=$$FY^IBOUTL(DT)
 D SITE^IBAUTL I Y<1 S IBY=Y G END1
 D SERV^IBAUTL2 G:IBY<1 END1
 S IBWHER=24 D CLOCK^IBAUTL3 G:IBY<1 END1
 ;
 ; - Create an Outpat Copay for discharge with Observation Speciality
 I $$MVT^DGPMOBS(IBA) D OBS^IBECEAU5 G:IBY<1 END1 G END
 ;
 ; - handle the variations on the basis of the event record
 D EVFIND^IBAUTL3 ; sets IBEVDA to IEN of event record, or to 0 if none
 S IBWHER=25 D @$S(IBEVDA:"EVT",1:"NOEVT")
 ;
 ; - kill variables and close
END1 I IBY<1 S IBDUZ=DUZ D ^IBAERR1 K IBDUZ
 W:'$G(DGQUIET) "completed."
END D KILL1^IBAMTC
 ;
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBAMTD" D T1^%ZOSV ;stop rt clock
 ;
 Q
 ;
EVT ; Billable admission event on record.
 ; I +$$MVT^DGPMOBS(IBA) S IBDT=IBDISDT D OE^IBAMTBU1,CLOSE1 G EVTQ
 I IBEVCAL'<IBDISDT S IBY="-1^IB033" G EVTQ
 I IBEVCAL S X1=IBEVCAL,X2=1 D C^%DTC S IBBDT=%H I X=IBDISDT S IBDT=IBEVCAL D PASS^IBAUTL5,CLOSE1:IBY>0 G EVTQ
 I 'IBEVCAL S X=IBEVDT D H^%DTC S IBBDT=%H
 S X=IBDISDT D H^%DTC S IBEDT=%H-1
 I IBCLDA S %H=IBBDT D YMD^%DTC S IBDT=X D COUNT
 D ^IBAUTL4,CLOSE:IBY>0
EVTQ Q
 ;
NOEVT ; No billable event on record since admission date.
 ; I +$$MVT^DGPMOBS(IBA) W:'$G(DGQUIET) " patient not billed (adm. for O&E)... " G NOEVTQ ; admitted for Observation & Examination
 S (IBCUR,VAIP("D"))=+$G(^DGPM(IBA,0)) D IN5^VADPT S IBBS=$$SECT^IBAUTL5(+VAIP(8))
 I 'IBASIH,'IBBS G NOEVTQ ; not in billable bedsection
 I 'IBASIH,IBCUR\1=IBDISDT S IBDT=IBDISDT D:IBBS ^IBAMTD1 G NOEVTQ
 S X=IBADMDT\1 D H^%DTC S IBBDT=%H
 I IBASIH S VAIP("D")=IBADMDT,IBSAVBS=IBBS D IN5^VADPT S IBBS=$$SECT^IBAUTL5(+VAIP(8)) I 'IBBS S X=IBCUR D H^%DTC S IBBDT=%H I IBCUR\1=IBDISDT S IBDT=IBDISDT,IBBS=IBSAVBS D:IBBS ^IBAMTD1 G NOEVTQ
 D LAST^IBAUTL5
 S X=IBDISDT D H^%DTC S IBEDT=%H-1
 I IBCLDA S %H=IBBDT D YMD^%DTC S IBDT=X D COUNT
 D ^IBAUTL4,CLOSE:IBY>0
NOEVTQ Q
 ;
COUNT ; Find number of days on clock.    Input:  IBDT
 S X1=IBDT,X2=IBCLDT D ^%DTC S IBCLCT=X Q
 ;
CLOSE ; Close out charges, events; update clocks (at discharge: tag CLOSE1)
 I $G(IBCHPDA) S IBNOS=IBCHPDA D FILER^IBAUTL5 G:IBY<1 CLOSEQ
 I $G(IBCHCDA) S IBNOS=IBCHCDA D FILER^IBAUTL5 G:IBY<1 CLOSEQ
 I IBCLDA D CLUPD^IBAUTL3
CLOSE1 I IBEVDA,$D(IBDT) S IBEVCLD=IBDT D EVCLOSE^IBAUTL3
CLOSEQ Q

IBRSUTL ;ALB/ARH - ASCD INTERFACE UTILITIES ; 23-MAR-07
 ;;2.0;INTEGRATED BILLING;**369**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CT(IB0E) ; Return Claims Tracking record for Outpatient Encounter
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ; Output: IEN of Outpatient Encounters Claims Tracking record #356
 ;         or null if no CT entry found
 ;
 N IBTRN S IBTRN="" I +$G(IB0E) S IBTRN=$O(^IBT(356,"ASCE",+IB0E,0))
 Q IBTRN
 ;
RNBU(IB0E,CHNG) ; Update Claims Tracking record Reason Not Billable for an Outpatient Encounter
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ;         CHNG - 1 if Outpatient Encounter changed from NSC to SC
 ;                2 if Outpatient Encounter changed from SC to NSC
 ; Output: 1 - Reason Not Billable SC TREATMENT was added to Outpatient Encounters Claims Tracking Record
 ;             also adds CT Billable Finding of NSC TO SC and Last Reviewed By
 ;         2 - Reason Not Billable SC TREATMENT was deleted from Outpatient Encounters Claims Tracking Record
 ;             also adds CT Billable Finding of SC TO NSC and Last Reviewed By
 ;         0 - no change made
 ;
 N DA,DR,DIC,DIE,DD,DO,DLAYGO,IBTRN,IBUPD,IBRNBSC,IBCTRNB,X,Y S DLAYGO=356.03,IBUPD=0
 I +$G(IB0E) S IBTRN=+$$CT(IB0E) I +IBTRN S IBCTRNB=$P($G(^IBT(356,IBTRN,0)),U,19)
 S IBRNBSC=$O(^IBE(356.8,"B","SC TREATMENT",""))
 ;
 I +$G(CHNG)=1,+IBTRN,IBCTRNB="" D  S IBUPD=1 ; if CT has no RNB then add RNB of SC - NSC to SC
 . S DA=IBTRN,DIE="^IBT(356,",DR=".19////"_IBRNBSC_";2.02////"_DUZ D ^DIE K DIE,DIC,DA,DR,X,Y
 . S X=$O(^IBT(356.85,"B","NSC TO SC",0)) I +X S DIC(0)="L",DA(1)=IBTRN,DIC="^IBT(356,"_DA(1)_",3," D FILE^DICN
 ;
 I +$G(CHNG)=2,+IBTRN,IBCTRNB=IBRNBSC D  S IBUPD=2 ; if CT has SC RNB then delete RNB - SC to NSC
 . S DA=IBTRN,DIE="^IBT(356,",DR=".19////@;2.02////"_DUZ D ^DIE K DIE,DIC,DA,DR,X,Y
 . S X=$O(^IBT(356.85,"B","SC TO NSC",0)) I +X S DIC(0)="L",DA(1)=IBTRN,DIC="^IBT(356,"_DA(1)_",3," D FILE^DICN
 ;
 Q IBUPD
 ;
FPBILL(IB0E) ; Return First Party Bill data for Outpatient Encounter, last encounter transaction if not cancelled
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ; Output: First Party AR Bill Number (#350,.11) ^ AR Transaction Number (#350,.12) ^ Total Charge (#350,.07)
 ;         null if no active First Party Bill found for encounter
 ;
 N IB0E0,DFN,IBFROM,IBIFN,IBFP0,IBFND,IBDT,IBPAR,IBNDT,IBLAST S IBFROM="409.68:"_$G(IB0E) S IBFND=""
 S IB0E0=$$SCE^IBSDU(+$G(IB0E)),DFN=$P(IB0E0,U,2),IBDT=+IB0E0\1
 ;
 I +DFN S IBIFN=0 F  S IBIFN=$O(^IB("AFDT",DFN,-IBDT,IBIFN)) Q:'IBIFN  D
 . S IBFP0=$G(^IB(IBIFN,0)) I IBFROM'=$P(IBFP0,U,4) Q
 . S IBPAR=$P(IBFP0,U,9),IBNDT=$O(^IB("APDT",IBPAR,"")),IBLAST=$O(^IB("APDT",IBPAR,IBNDT,""),-1) Q:'IBLAST
 . S IBFP0=$G(^IB(IBLAST,0)) I $P($G(^IBE(350.1,+$P(IBFP0,U,3),0)),U,5)=2 S IBFND="" Q  ; action type cancelled
 . I +$P($G(^IBE(350.21,+$P(IBFP0,U,5),0)),U,5) S IBFND="" Q  ; status cancelled
 . S IBFND=$P(IBFP0,U,11)_U_$P(IBFP0,U,12)_U_$P(IBFP0,U,7)
 ;
 Q IBFND
 ;
TPBILL(IB0E) ; Return Third Party Bill numbers for Outpatient Encounter, only not cancelled
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ; Output: Third Party Bill Number (#399,.01) ^ Third Party Bill Number (#399,.01) ^ ...
 ;         or null if no Third Party Bill found for encounter
 ;
 N IB0E0,DFN,IBDT,IBOPV,IBIFN,IBTP0,IBCPT,IBFND S IBFND=""
 S IB0E0=$$SCE^IBSDU(+$G(IB0E)),DFN=$P(IB0E0,U,2),IBDT=+IB0E0\1
 ;
 I +DFN S IBOPV=IBDT-.1 F  S IBOPV=$O(^DGCR(399,"AOPV",DFN,IBOPV)) Q:'IBOPV!(IBOPV>(IBDT+.6))  D
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AOPV",DFN,IBOPV,IBIFN)) Q:'IBIFN  D
 .. S IBTP0=$G(^DGCR(399,IBIFN,0)) I $P(IBTP0,U,13)=7 Q
 .. ;
 .. S IBCPT=0 F  S IBCPT=$O(^DGCR(399,IBIFN,"CP",IBCPT)) Q:'IBCPT  I +$P($G(^DGCR(399,IBIFN,"CP",IBCPT,0)),U,20)=IB0E S IBFND=IBFND_$P(IBTP0,U,1)_U Q
 ;
 Q IBFND
 ;
FIRST(IB0E) ; Return true if Outpatient Encounter is Billable for First Party
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ; Output: 0 ^ non-billable reason
 ;         1 if encounter is First Party billable
 ; 
 N IB0E0,DFN,IBDT,IBFND S IB0E=+$G(IB0E),IBFND=1
 S IB0E0=$$SCE^IBSDU(+$G(IB0E)),DFN=$P(IB0E0,U,2),IBDT=+IB0E0\1 I 'DFN Q 0
 ;
 I '$$BIL^DGMTUB(DFN,+IBDT) S IBFND=0_U_"Patient not MT billable"
 I '$$APPTCT^IBEFUNC(IB0E0) S IBFND=0_U_"Appt Status, not billable"
 I $$NCTCL^IBEFUNC(IB0E0) S IBFND=0_U_"Non-count Clinic, not billable"
 I $$IGN^IBEFUNC(+$P(IB0E0,U,10),IBDT) S IBFND=0_U_"Appt Type not MT billable"
 I $$NBCL^IBEFUNC(+$P(IB0E0,U,4),IBDT) S IBFND=0_U_"Clinic not MT billable"
 I $$NBCSC^IBEFUNC(+$P(IB0E0,U,3),IBDT) S IBFND=0_U_"Stop code not MT billable"
 ;
 Q IBFND
 ;
THIRD(IB0E) ; Return true if Outpatient Encounter is Billable for Third Party
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ; Output: 0 ^ non-billable reason
 ;         1 if encounter is Third Party billable
 ;
 N IB0E0,DFN,IBDT,IBFND S IB0E=+$G(IB0E),IBFND=1
 S IB0E0=$$SCE^IBSDU(+$G(IB0E)),DFN=$P(IB0E0,U,2),IBDT=+IB0E0\1 I 'DFN Q 0
 ;
 I '$$APPTCT^IBEFUNC(IB0E0) S IBFND=0_U_"Appt Status, not billable"
 I $$NCTCL^IBEFUNC(IB0E0) S IBFND=0_U_"Non-count Clinic, not billable"
 I '$$RPT^IBEFUNC(+$P(IB0E0,U,10),IBDT) S IBFND=0_U_"Appt Type not TP billable"
 I $$NBCT^IBEFUNC(+$P(IB0E0,U,4),IBDT) S IBFND=0_U_"Clinic not TP billable"
 I $$NBST^IBEFUNC(+$P(IB0E0,U,3),IBDT) S IBFND=0_U_"Stop code not TP billable"
 ;
 Q IBFND
 ;
TPCHG(IB0E) ; Return Outpatient Encounters potential Third Party charges, based on encounters procedures
 ; Input:  IB0E - IEN of Outpatient Encounter #409.68
 ; Output: Total Institutional Amount ^ Total Professional Amount
 ;         0 if no encounter billable procedures with charges
 ;
 N IB0E0,DFN,IBDT,IBDV,IBRT,IBCPTS,IBZERR,IBFN,IBCPT,IBINST,IBPROF,IBFND S (IBINST,IBPROF)=0,IBFND=0
 S IB0E0=$$SCE^IBSDU(+$G(IB0E)),DFN=$P(IB0E0,U,2),IBDT=+IB0E0\1,IBDV=$P(IB0E0,U,11) I 'DFN Q 0
 S IBRT=$O(^DGCR(399.3,"B","REIMBURSABLE INS.")) I 'IBRT S IBRT=8
 I '$$THIRD(IB0E) Q 0
 ;
 D GETCPT^SDOE(IB0E,"IBCPTS","IBZERR")
 S IBFN=0 F  S IBFN=$O(IBCPTS(IBFN)) Q:'IBFN  D  S IBFND=IBINST_U_IBPROF
 . S IBCPT=$P(IBCPTS(IBFN),U,1)
 . ;
 . S IBINST=IBINST+$$BICOST^IBCRCI(IBRT,3,IBDT,"PROCEDURE",IBCPT,,IBDV,1,1)
 . S IBPROF=IBPROF+$$BICOST^IBCRCI(IBRT,3,IBDT,"PROCEDURE",IBCPT,,IBDV,1,2)
 ;
 Q IBFND

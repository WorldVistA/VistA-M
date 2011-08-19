IBAMTI ;ALB/CPM - SPECIAL INPATIENT BILLING CASES ; 11-AUG-93
 ;;2.0;INTEGRATED BILLING;**52,132,153,156,234,247,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ADM(DFN,IBPM,IBCL) ; Create a new case record upon admission
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;            IBPM  --  Pointer to the adm movement in file #405
 ;            IBCL  --  Patient class [1-ao|2-ir|3-sc|4-swa|5-mst|6-hnc|7-cv|8-shad]
 I '$G(DFN)!'$G(IBPM)!'$G(IBCL) G ADMQ
 N DA,DIC,DIE,DR,IBC,X,Y
 ;
 ; - need to swap the input of 3 (SC) to 4, and 4 (EC) to 3
 S IBCL=$S(IBCL=3:4,IBCL=4:3,IBCL=5:5,1:IBCL)
 ;
 K DD,DO S DIC="^IBE(351.2,",DIC(0)="",X=DFN D FILE^DICN S IBC=+Y
 S DR=".02////"_IBPM_";.03////"_IBCL_";.05////1;2.01////"_DUZ_";2.02///NOW;2.03////"_DUZ_";2.04///NOW"
 S DA=IBC,DIE=DIC D ^DIE
 D BULL(1,IBCL) ; send admission bulletin
ADMQ Q
 ;
DIS(IBPM) ; Update the case record upon discharge
 ;  Input:    IBPM  --  Pointer to the adm movement in file #405
 N DA,DIE,DR,IBC
 S IBC=$O(^IBE(351.2,"AC",+$G(IBPM),0)) I 'IBC G DISQ
 S DR=".05////2;.06////"_DT_";2.03////"_DUZ_";2.04///NOW"
 S DA=IBC,DIE="^IBE(351.2," D ^DIE
 D BULL(2,+$P($G(^IBE(351.2,IBC,0)),"^",3)) ; send discharge bulletin
DISQ Q
 ;
BGJ ; Perform nightly background monitoring of all case records.
 N IBC,IBCD,IBNUM
 S IBC=0 F  S IBC=$O(^IBE(351.2,IBC)) Q:'IBC  S IBCD=$G(^(IBC,0)) D
 .Q:$P(IBCD,"^",8)  ; case has been dispositioned
 .Q:$P(IBCD,"^",5)=1  ; patient still admitted
 .I '$P(IBCD,"^",6) S $P(^IBE(351.2,IBC,0),"^",6)=DT Q  ; no disch date
 .S IBNUM=$$FMDIFF^XLFDT(DT,$P(IBCD,"^",6))
 .Q:IBNUM<45  ; still time to disposition the case
 .D NOTICE(IBNUM,+IBCD,+$P(IBCD,"^",2),+$P(IBCD,"^",3)) ; send reminder to disposition
 Q
 ;
BULL(IBEV,IBCL) ; Send a bulletin at admission and discharge.
 ;  Input:    IBEV  --  Event [1:admission|2:discharge]
 ;            IBCL  --  Patient class [1-ao|2-ir|3-swa|4-sc|5-mst|6-hnc|7-cv|8-shad]
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - "_$$UCCL(IBCL)_$S($G(IBEV)=1:" ADM",1:" DISCH")
 S IBT(1)="The following Means Test copay "_$$LCCL(IBCL)_" patient was just "_$S($G(IBEV)=1:"admitted:",1:"discharged:")
 S IBT(2)=" " S IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)=$S($G(IBEV)=1:"Please note that a special inpatient case record has been created for",1:"Please note that you have 45 days to determine if this episode of care")
 S IBC=IBC+1,IBT(IBC)=$S($G(IBEV)=1:"this admission.",1:"should be billed.")
 ;---CV
 I IBCL=7,$G(IBEV)=2 D 
 . N Y,X,IBZ,IBFL,IBEXP,IBTODAY,IBDIS
 . S (Y,X,IBZ,IBFL,IBEXP,IBTODAY,IBDIS)=0
 . D NOW^%DTC S IBTODAY=%\1
 . S IBZ=$$CVEDT^IBACV(DFN,IBTODAY)
 . I +IBZ=1 Q  ;patient is still CV
 . S IBEXP=+$P(IBZ,"^",2)\1
 . S IBDIS=+$G(^DGPM(+$P($G(^DGPM(+$G(IBPM),0)),"^",17),0))\1
 . ; if CV expired during inpatient stay
 . I IBDIS>0,IBEXP'>IBDIS D
 . . S IBFL=1
 . . S Y=IBEXP D DD^%DT S IBEXP=Y
 . . S IBC=IBC+1,IBT(IBC)=""
 . . S IBC=IBC+1,IBT(IBC)="WARNING: Patient's CV status has expired on "_IBEXP_" during the"
 . . S IBC=IBC+1,IBT(IBC)="inpatient stay. Billing needs to be adjusted accordingly."
 . ; if discharge move was entered after actual discharge date
 . I IBFL=0 D
 . . S Y=IBEXP D DD^%DT S IBEXP=Y
 . . S IBC=IBC+1,IBT(IBC)=""
 . . S IBC=IBC+1,IBT(IBC)="WARNING: Patient CV status has expired on "_IBEXP_""
 ;---
 I IBEV=2 D
 .I '$$BIL^DGMTUB(DFN,DT) S IBC=IBC+1,IBT(IBC)=" ",IBC=IBC+1,IBT(IBC)="Note: This patient, who was MT copay at admission, is no longer MT billable."
 .I $$BFO^IBECEAU(DFN,+$G(^DGPM(IBPM,0))\1) S IBC=IBC+1,IBT(IBC)=" ",IBC=IBC+1,IBT(IBC)="Note: This patient was billed the outpatient copayment at admission."
 D SEND^IBACVA2
 Q
 ;
NOTICE(IBNUM,DFN,IBPM,IBCL) ; Notice to disposition billing case
 ;  Input:   IBNUM  --  Number of days since discharge
 ;             DFN  --  Pointer to the patient in file #2
 ;            IBPM  --  Pointer to the admission in file #405
 ;            IBCL  --  Patient class [1-ao|2-ir|3-swa|4-sc|5-mst|6-hnc|7-cv|8-shad]
 ;
 Q:IBNUM#15  ; send notice every 15 days only
 N IBC K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB="NOTICE TO DISPOSITION SPECIAL INPATIENT BILLING CASE"
 S IBT(1)="The case record for this Means Test copay "_$$LCCL(IBCL)_" patient"
 S IBT(2)="is now "_IBNUM_" days old and should be dispositioned:"
 S IBT(3)=" " S IBC=3
 S IBDUZ=DUZ D PAT^IBAERR1
 S Y=+$G(^DGPM(+$G(IBPM),0)) D DD^%DT
 S IBC=IBC+1,IBT(IBC)=" Adm Date: "_Y
 S Y=+$G(^DGPM(+$P($G(^DGPM(+$G(IBPM),0)),"^",17),0)) D DD^%DT
 S IBC=IBC+1,IBT(IBC)="Disc Date: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please determine if this episode of care should be billed, and use"
 S IBC=IBC+1,IBT(IBC)="the Cancel/Edit/Add Patient Charges option to add charges, or the"
 S IBC=IBC+1,IBT(IBC)="Disposition Special Inpatient Billing Cases option to enter the reason"
 S IBC=IBC+1,IBT(IBC)="for not billing."
 D SEND^IBACVA2
 Q
 ;
UCCL(X) ; Return the upper case classification description.
 ;  Input:       X  --  Patient class [1-ao|2-ir|3-swa|4-sc|5-mst|6-hnc|7-cv|8-shad]
 Q $S('$G(X):"SPECIAL",1:$$PATTYPE^IBACV(X))
 ;
LCCL(X) ; Return the lower case classification description.
 ;  Input:       X  --  Patient class [1-ao|2-ir|3-swa|4-sc|5-mst|6-hnc|7-cv|8-shad]
 Q $S('$G(X):"Special",1:$$PATTYPE^IBACV(X,"M"))
 ;

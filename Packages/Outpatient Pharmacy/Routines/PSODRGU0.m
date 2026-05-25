PSODRGU0 ;BIR/MFR - Drug Swaping Utility; 06/25/2023 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 1997;Build 145
 ;
SWAPDRUG(RXIEN,NEWDRUG) ; Swap the Dispense Drug in an Existing Prescription
 ; Input: RXIEN   - Rx that will have the New Dispense Drug - Pointer to PRESCRIPTION file (#52)
 ;        NEWDRUG - New Dispense Drug - Pointer to DRUG file (#50)
 N OLDDRUG,PATIENT,LOCK,ERXIEN,DR,DIE,DA,NEWVAL,RELERX,OLDCMPID,NEWCMPID,REMARKS,OLDRMRKS
 ;
 I '$D(^PSRX(+$G(RXIEN),0)) Q "0^Prescription not found"
 I '$D(^PSDRUG(+$G(NEWDRUG),0)) Q "0^Invalid dispense drug"
 ;
 S OLDDRUG=+$$GET1^DIQ(52,RXIEN,6,"I"),PATIENT=+$$GET1^DIQ(52,RXIEN,2,"I"),OLDRMRKS=$$GET1^DIQ(52,RXIEN,12)
 S OLDCMPID=$$GET1^DIQ(50,OLDDRUG,27),NEWCMPID=$$GET1^DIQ(50,NEWDRUG,27)
 I OLDDRUG=NEWDRUG Q "0^New dispense drug already in the prescription"
 I $$CSDRG^PSOERUT6(OLDDRUG) Q "0^Cannot swap dispense drug for CS prescriptions"
 I $$CSDRG^PSOERUT6(OLDDRUG) Q "0^Cannot swap to a CS dispense drug"
 I '$$ACTIVE^PSOERXA0(NEWDRUG) Q "0^New dispense drug is inactive"
 I '$$OUTPAT^PSOERXA0(NEWDRUG) Q "0^New dispense drug is not marked for outpatient use"
 ; TO-DO: Review this
 I $$GET1^DIQ(50,NEWDRUG,2)'=$$GET1^DIQ(50,OLDDRUG,2) Q "0^New dispense drug is from a different drug class"
 ;
 S LOCK=$$L^PSSLOCK(PATIENT,0) I '$G(LOCK) Q "0^"_$P(LOCK,"^",2)_" is editing orders for the patient on this prescription."
 ;
 ; Updating Rx with New Dispense Drug
 S REMARKS="CNV "_OLDCMPID_"->"_NEWCMPID_" "_$$FMTE^XLFDT(DT,"2Y")_$S(OLDRMRKS'="":","_OLDRMRKS,1:"")
 S REMARKS=$E(REMARKS,1,75) S DIE="^PSRX(",DA=RXIEN,DR="6////"_NEWDRUG_";12////"_REMARKS_";27////"_$$GETNDC^PSSNDCUT(NEWDRUG) D ^DIE
 ;
 ; Adding Entry in the Activity Log about the Swap
 D RXACT^PSOBPSU2(RXIEN,0,"Dispense Drug changed from "_$$GET1^DIQ(50,OLDDRUG,.01)_" ("_OLDCMPID_") to "_$$GET1^DIQ(50,NEWDRUG,.01)_" ("_NEWCMPID_")","E",DUZ)
 ;
 ; Updating the Dispense Drug in corresponding eRx's
 S ERXIEN=$$ERXIEN^PSOERXUT(RXIEN)
 I ERXIEN D
 . I $$GET1^DIQ(52.49,ERXIEN,3.2,"I")=OLDDRUG D
 . . K NEWVAL S NEWVAL(1)=$$GET1^DIQ(50,NEWDRUG,.01)_" (NDC#: "_$$GETNDC^PSSNDCUT(NEWDRUG)_")"_" - VISTA DRUG EDITED"
 . . D AUDLOG^PSOERXUT(ERXIEN,"DRUG",DUZ,.NEWVAL)
 . . K DIE S DIE="^PS(52.49,",DA=ERXIEN,DR="3.2////"_NEWDRUG D ^DIE
 . ; Updating Related eRx's (if any)
 . S RELERX=0 F  S RELERX=$O(^PS(52.49,ERXIEN,201,"B",RELERX)) Q:'RELERX  D
 . . I $$GET1^DIQ(52.49,RELERX,3.2,"I")=OLDDRUG D
 . . . K NEWVAL S NEWVAL(1)=$$GET1^DIQ(50,NEWDRUG,.01)_" (NDC#: "_$$GETNDC^PSSNDCUT(NEWDRUG)_")"_" - VISTA DRUG EDITED"
 . . . D AUDLOG^PSOERXUT(RELERX,"DRUG",DUZ,.NEWVAL)
 . . . K DIE S DIE="^PS(52,49",DA=RELERX,DR="3.2////"_NEWDRUG D ^DIE
 ;
 ; Updating CPRS
 D EN^PSOHLSN1(RXIEN,"XX","","Order edited")
 ;
 ; Unlocking Patient
 D UL^PSSLOCK(PATIENT)
 ;
 Q 1

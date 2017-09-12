IBY550PO ; ALB/LMH - Post-Install to separate the Plan File and Payer File ; 09/15/15
 ;;2.0;INTEGRATED BILLING;**550**;OCT 05, 2015;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF ePharmacy Compliance Phase 3 - IB*2.0*550 patch post install
 ;
 Q
 ;
POST ;
 ;
 D BMES^XPDUTL("  Starting post-install of IB*2.0*550...")
 D DELEPAY
 D DELEPHRM
 D DELENTRY
 D EX
 Q
 ;
EX ; Exit
 D BMES^XPDUTL("Done with post-install of IB*2.0*550.")
 Q
DELEPAY ; Delete the PAYER NAME data & field from the PLAN file #366.03
 D BMES^XPDUTL("Deleting the PAYER NAME field from the PLAN file #366.03")
 N IEN,DIK,DA,DR,DIE
 S DR=".03///@",DIE="^IBCNR(366.03,"
 S IEN=0
 F  S IEN=$O(^IBCNR(366.03,IEN)) Q:'IEN  D
 . S DA=IEN
 . D ^DIE
 K DA
 S DIK="^DD(366.03,",DA=.03,DA(1)=366.03 D ^DIK
 Q
 ;
DELEPHRM ; Delete "E-PHARM" entries from the Payer File #365.12
 D BMES^XPDUTL("Deleting the ""E-PHARM"" entries from the PAYER file #365.12")
 N IBIEN,IBAPP,AIEN,APIEN,DIK,DA
 S IBAPP="E-PHARM"
 S AIEN=$O(^IBE(365.13,"B",IBAPP,"")) Q:'AIEN       ; AIEN is the 365.13 ien for E-PHARM
 ;
 S IBIEN=0 F  S IBIEN=$O(^IBE(365.12,IBIEN)) Q:'IBIEN  D
 . S APIEN=0 F  S APIEN=$O(^IBE(365.12,IBIEN,1,APIEN)) Q:'APIEN  D
 .. I $P($G(^IBE(365.12,IBIEN,1,APIEN,0)),U,1)'=AIEN Q             ; make sure this one is for E-PHARM
 .. S DA(1)=IBIEN,DA=APIEN,DIK="^IBE(365.12,"_DA(1)_",1," D ^DIK   ; remove the E-PHARM payer application data
 .. Q
 . Q
 Q
 ;
DELENTRY ; Delete the E-PHARM entry from the PAYER APPLICATION File #365.13
 D BMES^XPDUTL("Deleting the ""E-PHARM"" entry from the PAYER APPLICATION file #365.13")
 N DIK,DA,IBAPP,APIEN
 S IBAPP="E-PHARM"
 S APIEN=$O(^IBE(365.13,"B",IBAPP,""))
 S DIK="^IBE(365.13,",DA=APIEN D ^DIK
 Q

IBY461PO ;ALB/DEM/JAS - IB*2*461 POST-INSTALL - ICD10 ;23-JAN-2012
 ;;2.0;INTEGRATED BILLING;**461**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 N IBA S IBA(2)="IB*2*461 IB-ICD10 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 ;
 D RIT,CONV,ADDERR,UPDERR
 ;
 S IBA(2)="IB*2*461 IB-ICD10 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA)
 Q
 ;
RIT ; Recompile File #399 Input Templates
 N IBMAX,IBIEN,IBRTN,DMAX,X,Y
 S IBMAX=$$ROUSIZE^DILF
 ;
 D MES^XPDUTL(">> Compiling Billing Screen 4 [IB SCREEN4] Input Template")
 S IBIEN=$O(^DIE("B","IB SCREEN4",0)) Q:'IBIEN
 S IBRTN=$P($G(^DIE(IBIEN,"ROUOLD")),U) Q:IBRTN=""
 S X=IBRTN,Y=IBIEN,DMAX=IBMAX
 D EN^DIEZ
 ;
 D MES^XPDUTL(">> Compiling Billing Screen 5 [IB SCREEN5] Input Template")
 S IBIEN=$O(^DIE("B","IB SCREEN5",0)) Q:'IBIEN
 S IBRTN=$P($G(^DIE(IBIEN,"ROUOLD")),U) Q:IBRTN=""
 S X=IBRTN,Y=IBIEN,DMAX=IBMAX
 D EN^DIEZ
 ;
 Q
CONV ; Add value to new DEFAULT RX REFILL DX ICD-10 field (#350.9, 7.05)
 ; set to 569361 - Z76.0 - Encounter for issue of repeat prescription
 N DIE,DIC,DA,DR,X
 ;
 I +$P($G(^IBE(350.9,1,7)),U,5) D MES^XPDUTL(">> DEFAULT RX REFILL DX ICD-10 Site Parameter (#350.9,7.05) has value, no change") Q
 ;
 S DIE="^IBE(350.9,",DA=1,DR="7.05////569361" D ^DIE K DIE,DIC,DA,DR
 D MES^XPDUTL(">> Set DEFAULT RX REFILL DX ICD-10 Site Parameter (#350.9, 7.05) to Z76.0")
 ;
 Q
 ;
UPDERR ; Update existing error code message for 350.8
 N IBCODE,IBMESN,IBIEN,DIE,DIC,DA,DR,X,Y
 ;
 S IBCODE="IB071",IBMESN="A claim must contain an ICD diagnosis."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D MES^XPDUTL(">> IB ERROR (#350.8) IB071 - Not Found, Error") Q
 ;
 S DIE="^IBE(350.8,",DA=IBIEN,DR=".02////"_IBMESN D ^DIE K DIE,DIC,DA,DR
 D MES^XPDUTL(">> Updated IB ERROR (#350.8) Code IB071")
 ;
 Q
 ;
ADDERR ; Add new error code records to 350.8
 N IBI,IBTXT,IBCODE,DIE,DIC,DR,DA,DD,DO,X,Y,DLAYGO S DLAYGO=350.8
 ;
 F IBI=1:1 S IBTXT=$P($T(TXTERR+IBI),";;",2,999) Q:IBTXT=""  D
 . S IBCODE=$P(IBTXT,U,1)
 . I $O(^IBE(350.8,"AC",IBCODE,0)) D MES^XPDUTL(">> IB ERROR (#350.8) Code "_IBCODE_" already exists, no change") Q
 . ;
 . S DIC="^IBE(350.8,",DIC("DR")=".02////"_$P(IBTXT,U,2)_";.03////"_IBCODE_";.04////1;.05////1"
 . S DIC(0)="L",X=IBCODE D FILE^DICN K DIC I Y<1 K X,Y Q
 . D MES^XPDUTL(">> Added IB ERROR (#350.8) Code "_IBCODE)
 ;
 Q
 ;
 ;
TXTERR ; New IB ERROR (#350.8) Codes:  Name=Error Code ^ Message
 ;;IB354^Statement Covers To date cannot span into ICD-10 effective period.
 ;;IB355^The Principal (first-entered) diagnosis cannot begin with a V, W, X or Y.
 ;;IB356^ICD Code Set Version does not correspond to Statement Covers To Date.
 ;;

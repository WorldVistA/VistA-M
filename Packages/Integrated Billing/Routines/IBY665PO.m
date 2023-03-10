IBY665PO ;EDE/JWS - POST-INSTALL FOR IB*2.0*665 ;01-APR-2021
 ;;2.0;INTEGRATED BILLING;**665**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA# 10141 - MES^XPDUTL
 ;
EN ;Entry Point
 N IBA
 S IBA(2)="IB*2*665 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D UPDERR
 S IBA(2)="IB*2*665 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
UPDERR ; Update existing error code message for 350.8
 N IBCODE,IBMESN,IBIEN,DIE,DIC,DA,DR,X,Y
 S IBCODE="IB383",IBMESN="Claim cannot contain more than 24 Occurrence Codes for EDI submission."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB384",IBMESN="If claim needs more than 24 Occurrence Codes, then select 'Force to Print'."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB385",IBMESN="Claim cannot contain more than 24 Occurrence Span Codes for EDI submission."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB386",IBMESN="If claim needs more than 24 Occurrence Span Codes, select 'Force to Print'."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB387",IBMESN="Inpt. Inst. claim cannot exceed 25 Procedure Codes for EDI submission."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB388",IBMESN="If claim needs more than 25 Procedure Codes, then select 'Force to Print'."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB389",IBMESN="Cannot enter more than 23 Value Codes for EDI Submission."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB390",IBMESN="If more than 23 Value Codes need to be entered, select 'Force to Print'."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB391",IBMESN="Claim cannot contain more than 24 Condition Codes for EDI Submission."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB392",IBMESN="If more than 24 Condition Codes are needed, select 'Force to Print'."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB393",IBMESN="17 other diagnosis codes are allowed on a printed UB04."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB394",IBMESN="24 other diagnosis codes are allowed on an electronic institutional claim."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB395",IBMESN="3 e-diagnosis codes are allowed on a printed UB04."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB396",IBMESN="12 e-diagnosis codes are allowed on an electronic institutional claim."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB397",IBMESN="12 diagnosis codes are allowed on a professional claim."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB398",IBMESN="4 diagnosis codes are allowed on a dental claim."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB399",IBMESN="Institutional claim cannot contain more than 999 Revenue Codes."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 Q
 ;
CREATE ;Create entry for IB error file in D350.8 if not there
 S DIC="^IBE(350.8,",DIC(0)="",X=IBCODE D FILE^DICN K DIC,X
 I Y=-1 D MES^XPDUTL(">> IB ERROR - Entry '"_IBCODE_"' was unable to be created <<") Q
 S IBIEN=+Y
 S DIE="^IBE(350.8,",DA=IBIEN,DR=".02////"_IBMESN_";.03////"_IBCODE_";.04////1;.05////1" D ^DIE K DIE,DIC,DA,DR
 Q
 ;

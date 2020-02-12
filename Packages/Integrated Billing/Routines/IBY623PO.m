IBY623PO ;EDE/WCJ - POST-INSTALL FOR IB*2.0*623 ;13-JUL-2018
 ;;2.0;INTEGRATED BILLING;**623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA# 10141 - MES^XPDUTL
 ; IA#4677 - $$CREATE^XUSAP
 ;
EN ;Entry Point
 N IBA
 S IBA(2)="IB*2*623 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D ADDPROXY
 D ADDRTYPS
 D UPDERR
 S IBA(2)="IB*2*623 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
ADDPROXY ;Add APPLICATION PROXY user to file 200.  Supported by IA#4677.
 N IEN200
 D MES^XPDUTL("Adding entry 'IBTAS,APPLICATION PROXY' to the New Person file (#200)")
 S IEN200=$$CREATE^XUSAP("IBTAS,APPLICATION PROXY","","IBTAS EBILLING RPCS")
 I +IEN200=0 D MES^XPDUTL("........'IBTAS,APPLICATION PROXY' already exists.")
 I +IEN200>0 D MES^XPDUTL("........'IBTAS,APPLICATION PROXY' added.")
 I IEN200<0 D MES^XPDUTL("........'ERROR: IBTAS,APPLICATION PROXY' NOT added.")
 Q
 ;
ADDRTYPS ;Add the Non-MCCF Rate Types that don't exist in the Non-MCCF Pay-To
 ;Providers Rate Table (File #350.928) - vd (US141).
 N FDA,IBRTYP,LOOP,NONMCCF,Y
 S NONMCCF="INTERAGENCY^CHAMPVA REIMB. INS.^CHAMPVA^TRICARE REIMB. INS.^TRICARE^INELIGIBLE^SHARING AGREEMENT^INELIGIBLE REIMB. INS."
 S NONMCCF=NONMCCF_"^DOD DISABILITY EVALUATION^DOD SPINAL CORD INJURY^DOD TRAUMATIC BRAIN INJURY^DOD BLIND REHABILITATION^TRICARE DENTAL^TRICARE PHARMACY"
 D MES^XPDUTL("Adding missing Rate Types to the Non-MCCF PTP Rate Type File")
 F LOOP=1:1 S IBRTYP=$P(NONMCCF,U,LOOP) Q:IBRTYP=""  D
 . S Y=$O(^DGCR(399.3,"B",IBRTYP,0))
 . I $D(^IBE(350.9,1,28,"B",+Y)) Q  ; Rate Type already exists in the Non-MCCF PTP Rate Type File - Don't Add.
 . ; create entry for Rate Type
 . K FDA
 . S FDA("350.928","+1,1,",.01)=+Y
 . D UPDATE^DIE("","FDA")
 . Q
 ;
UPDERR ; Update existing error code message for 350.8
 N IBCODE,IBMESN,IBIEN,DIE,DIC,DA,DR,X,Y
 S IBCODE="IB366",IBMESN="Insured's Date of Birth is not a valid date."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB367",IBMESN="Insurance subscriber Date of Birth is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB368",IBMESN="Patient's Date of Birth is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB369",IBMESN="Patient's Date of Death is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB370",IBMESN="Bill Statement Covers From Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB371",IBMESN="Bill Statement Covers To Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB372",IBMESN="Unable to Work From date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB373",IBMESN="Unable to Work To date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB374",IBMESN="Date of Initial Treatment is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB375",IBMESN="Last X-Ray Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB376",IBMESN="Date of Acute Manifestation is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB377",IBMESN="Disability Start Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB378",IBMESN="Disability End Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB379",IBMESN="Assumed Care Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB380",IBMESN="Relinquished Care Date is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB381",IBMESN="Property Casualty Date of 1st Contact is invalid."
 S IBIEN=$O(^IBE(350.8,"C",IBCODE,0)) I 'IBIEN D CREATE
 S IBCODE="IB382",IBMESN="Date Last Seen is invalid."
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

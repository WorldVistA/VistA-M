IBY506PO ;ALB/VD - IB*2*506 POST-INSTALL ;23-AUG-2000
 ;;2.0;INTEGRATED BILLING;**506**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;ICR - 10140
 ;
EN ;Post Install Routine primary entry point
 N IBY,Y,QUIT,ROUT
 S QUIT=0
 F IBY="BLD","SITEPARM","HOLDLP","NEWSTAT","ESCALATE","UPDATE" D  I QUIT Q
 . S ROUT=IBY_"^IBY506PO"
 . S Y=$$NEWCP^XPDUTL(IBY,ROUT)
 . I 'Y D BMES^XPDUTL("ERROR Creating "_IBY_" Checkpoint.") S QUIT=1 Q
 Q
 ;
BLD ; Update ^XUTL("XQORM" for menu protocols. ICR - 10140
 N IBX,IBY,X,Y
 D MES^XPDUTL("Rebuilding Protocol Menus.")
 F IBX="IBCNB LIST SCREEN MENU","IBCNB ENTRY SCREEN MENU" D
 .S DIC="^ORD(101,",DIC(0)="F",X=IBX D ^DIC K DIC S IBY=+Y
 .I IBY>0 S XQORM=IBY_";ORD(101," D XREF^XQORM
 K ORULT,XQORM
 Q
 ;
SITEPARM ; initialize site parameters
 ; set eIV site parameter # OF RETRIES to "1"
 ; set eIV site parameter RETRY FLAG to "0" (NO)
 ; set eIV site parameter FRESHNESS DAYS to "180"
 ; set eIV site parameter TIMEOUT DAYS to "5"
 ; set eIV site parameter HL7 RESPONSE PROCESSING to "I" (IMMEDIATE)
 D MES^XPDUTL("Reset/Initialize values of eIV site parameters")
 N DIE,DA,DR,X,Y
 S DIE=350.9,DA=1,DR="51.06///1;51.26///N;51.01///180;51.05///5;51.13///I"
 D ^DIE
 Q
 ;
HOLDLP ; loop through all TQ entries that have a status of HOLD and mark them as communication failure.
 D MES^XPDUTL("Search through all of the TRANSMISSION QUEUE entries for those having a status")
 D MES^XPDUTL("of HOLD and mark them as COMMUNICATION FAILURE.")
 N IEN,BUFF,CCODE
 S CCODE=$O(^IBE(365.15,"B","C1",""))
 ; file 365.1, IIV Transmission Queue
 S IEN=""
 F  S IEN=$O(^IBCN(365.1,"AC",4,IEN)) Q:IEN=""  D    ; node 4 is for only HOLD status.
 . S BUFF=$P($G(^IBCN(365.1,IEN,0)),U,5)
 . ;
 . ; set TQ record to 'communication failure'
 . D SST^IBCNEUT2(IEN,5)
 . ;
 . ; For msg in the Response file set the status to 'Comm Failure'
 . D RSTA^IBCNEUT7(IEN)
 . ;
 . ; Set Buffer symbol to 'C1' (Comm Failure)
 . I BUFF'="" D BUFF^IBCNEUT2(BUFF,CCODE)    ;set to "#" communication failure
 Q
 ;
NEWSTAT ; add a new code to the IIV STATUS TABLE (#365.15) for COMMUNICATION FAILURE
 D MES^XPDUTL("Add a new COMMUNICATION FAILURE code to the IIV STATUS TABLE")
 N IBACTN,IBDATA,IBDESC,IBERR,IBIEN
 I $D(^IBE(365.15,"B","C1")) D BMES^XPDUTL("*** NEW 'C1' CODE NOT ADDED TO IIV STATUS TABLE...ALREADY EXISTS ***") G NEWSTATX
 ;
 ;Set up WP Arrays
 S IBDESC("WP",1)="eIV was unable to electronically verify this insurance information"
 S IBDESC("WP",2)="due to a communication failure."
 ;
 S IBACTN("WP",1)="Action to take:  Contact the insurance company to manually verify"
 S IBACTN("WP",2)="this insurance information."
 ;
 ;Set up File Nodes
 S IBDATA(.01)="C1"
 S IBDATA(.02)=35
 S IBDATA(.03)=0
 S IBDATA(1)=$NA(IBDESC("WP"))
 S IBDATA(2)=$NA(IBACTN("WP"))
 S IBIEN=$$ADD^IBDFDBS(365.15,,.IBDATA,.IBERR)
 I IBERR D BMES^XPDUTL("*** ERROR ADDING 'C1' CODE TO THE IIV STATUS TABLE (#365.15) ***") G NEWSTATX
 D BMES^XPDUTL("   NEW 'C1' CODE SUCCESSFULLY ADDED TO IIV STATUS TABLE")
NEWSTATX ;
 Q
 ;
ESCALATE ;Add Escalate Code "$" to the IIV STATUS TABLE (#365.15)
 D MES^XPDUTL("Add a new ESCALATE code to the IIV STATUS TABLE")
 N IBACTN,IBDATA,IBDESC,IBERR,IBIEN
 I $D(^IBE(365.15,"B","E1")) D BMES^XPDUTL("*** NEW 'E1' CODE NOT ADDED TO IIV STATUS TABLE...ALREADY EXISTS ***") G ESCX
 ;
 ;Set up WP Arrays
 S IBDESC("WP",1)="Information received via electronic inquiry indicates patient has active"
 S IBDESC("WP",2)="insurance; however, another verifier did not have the authority to"
 S IBDESC("WP",3)="process this entry."
 ;
 S IBACTN("WP",1)="Action to take:  Review the details listed in the eIV Response Report"
 S IBACTN("WP",2)="before processing this buffer entry."
 ;
 ;Set up File Nodes
 S IBDATA(.01)="E1"
 S IBDATA(.02)=36
 S IBDATA(.03)=0
 S IBDATA(1)=$NA(IBDESC("WP"))
 S IBDATA(2)=$NA(IBACTN("WP"))
 S IBIEN=$$ADD^IBDFDBS(365.15,,.IBDATA,.IBERR)
 I IBERR D BMES^XPDUTL("*** ERROR ADDING 'E1' CODE TO THE IIV STATUS TABLE (#365.15) ***") G ESCX
 D BMES^XPDUTL("   NEW 'E1' CODE SUCCESSFULLY ADDED TO IIV STATUS TABLE")
ESCX ;
 Q
 ;
UPDATE ;Call option to update Insurance Type File
 ; Schedule through TaskMan to run at night?
 N MSG
 D MES^XPDUTL("Creating Task to update the Insurance Type File... ")
 U IO(0)
UPDATE1 S MSG=$$TASK^IBCNUPD($D(ZTQUEUED)) I MSG["Aborted" D  G UPDATE1
 . S MSG="You MUST schedule this task in order to continue." D MES^XPDUTL(MSG) H 3
 U IO
 D BMES^XPDUTL(MSG)
 Q

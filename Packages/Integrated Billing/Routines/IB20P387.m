IB20P387 ;DAY/RRA - DSS CLINIC STOP CODES IB*2.0*378 PRE-INIT ; 3/13/07 12:55pm
 ;;2.0;INTEGRATED BILLING;**387**;21-MAR-94;Build 3
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
EN ;
 N U
 S U="^"
 D START,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL("DSS Clinic Stop Codes, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("DSS Clinic Stop Codes, Post-Install Complete")
 Q
 ;
 ;
UPDATE ;update an old code
 N IB1,IBT,IBX,IBCODE,IBY
 D BMES^XPDUTL(" Updating Stop Code entries 695 and 696 in file 352.5")
 F IBX=1:1 S IBT=$P($T(OCODE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=+$P(IBT,U)
 . S IBY=3071001
 . S IB1=$O(^IBE(352.5,"AEFFDT",IBCODE,-IBY,0))
 . I 'IB1 D BMES^XPDUTL("No Stop Code Entry found for "_IBCODE_" with an efective date of 10/01/07") Q
 . S DIE="^IBE(352.5,",DA=IB1,DR=".05///1" D ^DIE K DA,DR,DIE
 . D BMES^XPDUTL("     "_IBCODE_" updated in file 352.5")
 Q
 ;
OCODE ;;code^billable type^description^override flag
 ;;695
 ;;696
 ;
 Q

RC45P405 ;EDE/LLB - POST-INSTALL FOR PRCA*4.5*401 ;01-JUL-2022
 ;;4.5;Accounts Receivable;**405**;Mar 20,1995;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SETPARAM ; set default value for AR SITE PARAMETER 342/2.01
 N DA,DIE,DR,X,Y
 D MES^XPDUTL("Setting AR PARAMETER file (#342) Comment 1 (field 2.01) to default value")
 S DA=1,DIE=342,DR="2.01///^S X=""To pay your statement online, go to www.pay.gov or call 1-888-827-4817."""
 D ^DIE
 D MES^XPDUTL("Done.")
 Q

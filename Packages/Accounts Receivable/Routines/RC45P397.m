RC45P397 ;EDE/LLB - POST-INSTALL FOR PRCA*4.5*397 ;29-FEB-2022
 ;;4.5;Accounts Receivable;**397**;Mar 20,1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SETPARAM ; set default value for IB site parameter 350.9/71.01
 N DA,DIE,DR,X,Y
 D MES^XPDUTL("Setting default statement size limit AR SITE PARAMETER file...")
 S DA=1,DIE=342,DR="101///^S X=646" D ^DIE
 D MES^XPDUTL("Done.")
 K DA,DIE,DR,X,Y
 Q

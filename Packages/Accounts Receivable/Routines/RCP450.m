RCP450 ;TAS/CJE - ePayment Lockbox Post-Installation Processing ;4 Oct 2018 10:29:18
 ;;4.5;Accounts Receivable;**450**;Oct 4, 2018;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 D AUTO1
 D ADDF
 Q
AUTO1 ; Populate default values for 1st party auto-decrease
 ;
 K ^RC(342,1,14) ; Remove list. Criteria are now hard coded all I/P, O/P and Rx except cancels
 Q
ADDF ; Populate defaults for first party decrease on manual post
 N FDA
 D BMES^XPDUTL("Populate default value for 1st party auto-decrease (#342)")
 S FDA(342,"1,",.17)=0
 D FILE^DIE("","FDA")
 Q

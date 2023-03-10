RCP349 ;AITC/CJE - ePayment Lockbox Post-Installation Processing ;22 Jan 2019 14:32:31
 ;;4.5;Accounts Receivable;**349**;Oct 4, 2018;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA 7086 - REMOTE MEMEBER and DESCRIPTION fields of MAIL GROUP FILE (#3.8)
 ;
 Q
 ;
POST ;
 ;
 D TRICARE ; Populate defaults for Tricare Auto-Post/Decrease
 ;
 Q
 ;
TRICARE ; Populate defaults for Tricare Auto-Post/Decrease
 N FDA
 D BMES^XPDUTL("Populate defaults for Tricare Auto-Post/Decrease (#344.61)")
 S FDA(344.61,"1,",1.05)=0 ; Auto-post TRICARE default to NO
 S FDA(344.61,"1,",1.06)=0 ; Auto-decrease TRICARE default to NO
 S FDA(344.61,"1,",1.09)=0 ; Auto-decrease TRICARE (NO PAY) default to NO
 ;
 S FDA(344.61,"1,",1.07)=5000 ; Auto-decrease TRICARE Amount
 S FDA(344.61,"1,",1.08)=5 ; Auto-decrease TRICARE days to wait
 S FDA(344.61,"1,",1.1)=5 ; Auto-decrease TRICARE (NO PAY) days to wait
 D FILE^DIE("","FDA")
 Q
 ;

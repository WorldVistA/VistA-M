PRCAP392 ;EDE/YMG - PRCA*4.5*392 POST INSTALL; 03/30/22
 ;;4.5;Accounts Receivable;**392**;Mar 20, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*392")
 ; Update bill profile display in file 430.2
 D UPDSTYPE
 ;
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*392")
 Q
 ;
UPDSTYPE ; Update bill profile display (field 430.2/1.04) in file 430.2
 N ARCIEN,FDA
 D BMES^XPDUTL(" >>  Updating bill profile display settings for Tricare in file 430.2...")
 F ARCIEN=75:1:78 S FDA(430.2,ARCIEN_",",1.04)=2 D FILE^DIE("","FDA") K FDA  ; set to outpatient display
 S FDA(430.2,"80,",1.04)=5 D FILE^DIE("","FDA")  ; set to CC RX display
 D MES^XPDUTL("Done.")
 Q

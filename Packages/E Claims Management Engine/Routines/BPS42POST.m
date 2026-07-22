BPS42POST ;AITC/PD - Post-install for BPS*1.0*42 ;08/07/2025
 ;;1.0;E CLAIMS MGMT ENGINE;**42**;JUN 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; BPS*1*42 patch post install
 ;
 Q
 ;
EN ; Entry Point for post-install
 ;
 D MES^XPDUTL("  Starting post-install for BPS*1*42")
 ;
 ; Initialize ePharmacy Billing Parameters to NO
 D EBP
 ;
EX ; exit point
 D BMES^XPDUTL("  Finished post-install of BPS*1*42")
 Q
 ;
EBP ; Set parameters to NO and entries for audit history
 ;
 N FLDNO
 ;
 D BMES^XPDUTL("    Initialize ePharmacy Billing Parameters")
 ;
 F FLDNO=1.01,1.02,1.03 D SET(FLDNO)
 ;
 Q
 ;
SET(FLDNO) ;
 ;
 N CAT,DA,DIE,DR
 ;
 ; If the specific parameter is already defined, quit.  This prevents
 ; the values from being overwritten if the patch is loaded into the
 ; environment more than one time.  The initializing of the new 
 ; parameters is only needed one time - the first time the patch
 ; gets loaded.
 I $$GET1^DIQ(9002313.99,1,FLDNO)'="" Q
 ;
 I FLDNO=1.01 S CAT="8E"
 I FLDNO=1.02 S CAT="8G"
 I FLDNO=1.03 S CAT="IN"
 ;
 S DIE=9002313.99
 S DR=FLDNO_"///NO;3000///NOW"
 S DA=1
 S DR(2,9002313.9901)="1///"_CAT
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_2_"///.5"
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_3_"///YES"
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_4_"///NO"
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_5_"///Set to ""No"" upon software installation."
 D ^DIE
 H 1
 ;
 Q

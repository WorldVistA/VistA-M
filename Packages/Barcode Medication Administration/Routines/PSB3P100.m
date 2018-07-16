PSB3P100 ;AITC/CR - Post installation for Patch 100 ; 9/14/17 1:34pm
 ;;3.0;BAR CODE MED ADMIN;**100**;Mar 2004;Build 17
 ;
 ; This routine is used with the New-Style cross reference
 ; 'DIVAS' in file #53.68 to re-index the entire file so that multi-division
 ; sites can run the report 'Missing Dose Followup' by division
POST ; prepare entries for 'Missing Dose Followup' sorted by Status and Division
 D BMES^XPDUTL(">>> Post-Init: Re-indexing of file #53.68 in progress...")
 N DIK
 S DIK="^PSB(53.68,"
 S DIK(1)=".04^DIVAS"  ; only need one field for the combined cross ref
 D ENALL^DIK
 D BMES^XPDUTL(">>> Post-Init completed!")
 Q

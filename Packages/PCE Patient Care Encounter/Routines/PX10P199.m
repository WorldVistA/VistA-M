PX10P199 ;HP/RBD - ENVIRONMENT CHECK WITH PRE-INIT CODE ;17 Oct 2013  2:53 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199**;Aug 12, 1996;Build 51
 ; 
ENV ; environment check
 ; No special environment check at this time.
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("VPOVDSC","VPOVDSC^PX10P199")
 S %=$$NEWCP^XPDUTL("TREATDS","TREATDS^PX10P199")
 S %=$$NEWCP^XPDUTL("DXMNUTX","DXMNUTX^PX10P199")
 S %=$$NEWCP^XPDUTL("ICDNARX","ICDNARX^PX10P199")
 Q
 ;
VPOVDSC ; change Description of V POV to make ICD9 reference generic
 D BMES^XPDUTL("Modifying V POV Description to make ICD9 reference more generic.")
 S ^DIC(9000010.07,"%D",24,0)="appropriate ICD diagnosis code. Physician entered narrative which modifies"
 D DONE
 Q
 ;
TREATDS ; change 'ICD-9-CM' to 'ICD-CM' in TREATMENT file Description
 D BMES^XPDUTL("Updating 'ICD-9-CM' to 'ICD-CM' in TREATMENT file Description.")
 S ^DIC(9999999.17,"%D",2,0)="of treatments that are not covered in the ICD-CM Procedures or the CPT"
 S ^DIC(9999999.17,"%D",8,0)="the lack of a coded CPT or ICD-CM."
 D OVER
 Q
 ;
DXMNUTX ; change text of DX submenu from Diagnosis (ICD 9) to Diagnosis (ICD)
 D BMES^XPDUTL("Modifying DX submenu text to 'Diagnosis (ICD)' under PXCE ADD/EDIT MENU")
 N DXMNIEN,MENUTXT,ORDA,PXA
 S DXMNIEN=+$$FIND1^DIC(101,"","X","PXCE POV ADD","B")
 I 'DXMNIEN D BMES^XPDUTL("Sub Menu PXCE POV ADD not found.  Aborting modification...") Q
 S MENUTXT=$$GET1^DIQ(101,DXMNIEN,1)
 I MENUTXT="Diagnosis (ICD)" D  Q
 . D BMES^XPDUTL("Sub Menu PXCE POV ADD already has correct wording.  Aborting modification...")
 S ORDA(101,DXMNIEN_",",1)="Diagnosis (ICD)"
 D FILE^DIE("","ORDA","ORDERRM")
 S PXA(1,0)="This action allows you to add/edit an ICD coded diagnosis"
 S PXA(2,0)="for a patient encounter."
 D WP^DIE(101,DXMNIEN_",",3.5,"","PXA")
 D COMPLETE
 Q
 ;
ICDNARX ; Delete ICD NARRATIVE field in prep for new version
 D BMES^XPDUTL("Deleting old ICD NARRATIVE field.")
 N DA,DIK
 S DIK="^DD(9000010.07,",DA=.019,DA(1)=9000010.07
 D ^DIK
 D END
 Q
 ;
DONE ; display message that V POV description update is done
 D BMES^XPDUTL("V POV Description updated.")
 Q
 ;
OVER ; display message that TREATMENT description update is done
 D BMES^XPDUTL("TREATMENT Description updated.")
 Q
 ;
COMPLETE ; display message that step has completed
 D BMES^XPDUTL("Step to change DX submenu option verbiage to 'Diagnosis (ICD)' complete.")
 Q
 ;
END ; display message that pre-init has completed successfully
 D BMES^XPDUTL("Pre-init complete")
 Q
 ;

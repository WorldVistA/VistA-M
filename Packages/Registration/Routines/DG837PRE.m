DG837PRE ;BIR/PTD-PATCH DG*5.3*837 PRE-INSTALLATION ROUTINE ;12/7/2011
 ;;5.3;Registration;**837**;Aug 13, 1993;Build 5
 ;
EN ;MVI_791 (ptd) Delete the DD definition for the IN-PERSON PROOFED
 ;(#.08) field in the TREATING FACILITY LIST (#391.91) file.
 ;KIDS will bring in DDs for the new ROI SIGNED INDICATOR (#.08) field.
 ;If DG*5.3*837 already installed, don't need to do this again
 I $$PATCH^XPDUTL("DG*5.3*837") Q
 ;
 D BMES^XPDUTL(">>> Deleting the DDs for the IN-PERSON PROOFED (#.08) field")
 D MES^XPDUTL("    in the TREATING FACILITY LIST (#391.91) file.")
 ;
 S DIK="^DD(391.91,",DA=.08,DA(1)=391.91
 D ^DIK
 K DA,DIK
 ;
 D BMES^XPDUTL("    Pre-install routine completed successfully.")
 Q
 ;

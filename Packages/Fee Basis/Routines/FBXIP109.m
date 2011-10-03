FBXIP109 ;ALB/RC-PATCH INSTALL ROUTINE ; 12/29/08 1:54pm
 ;;3.5;FEE BASIS;**109**;JAN 30, 1995;Build 10
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="EN" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP109")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
EN ; Begin Post-Install
 D CF ;Add Conv factors
 D POV ;Update Place of Visit
 Q
CF ; add conversion factors for calendar year 2009 RBRVS fee schedule
 ; File 162.99 is being updated in the post install because the Fee
 ; Basis software examines this file to determine the latest available
 ; fee schedule. By doing this at the end of the patch installation,
 ; users can continue to use the payment options during the install.
 D BMES^XPDUTL("  Filing conversion factor for RBRVS 2009 fee schedule.")
 N DD,DO,DA,DIE,DR,X,Y
 S DA(1)=0 F  S DA(1)=$O(^FB(162.99,DA(1))) Q:'DA(1)  D
 . S DA=$O(^FB(162.99,DA(1),"CY","B",2009,0))
 . I DA'>0 D  Q:DA'>0
 . . S DIC="^FB(162.99,"_DA(1)_",""CY"",",DIC(0)="L",DIC("P")="162.991A",DLAYGO=162.991
 . . S X=2009
 . . K DD,DO D FILE^DICN
 . . K DIC,DLAYGO
 . . S DA=+Y
 . ;
 . S DIE="^FB(162.99,"_DA(1)_",""CY"","
 . S DR=".02///"_$S(DA(1)=1:20.9150,1:36.0666)
 . D ^DIE
 Q
POV ;Update Place of Visit
 ;
 ;Add 67,68,69,56
 D BMES^XPDUTL("Updating Place of Visit entries in the FEE BASIS PURPOSE OF VISIT file (#161.82)")
 N FBCNT,X,NEWENTRY,NEWCODE,NEWPOV,POVCHECK
 F FBCNT=1:1  S NEWENTRY=$P($T(NEWTABLE+FBCNT),";;",2) Q:NEWENTRY="EXIT"  D
 .S NEWPOV=$P(NEWENTRY,"^",1),NEWCODE=$P(NEWENTRY,"^",2)
 .S POVCHECK=$O(^FBAA(161.82,"C",NEWCODE,"")) D
 ..I POVCHECK D BMES^XPDUTL("Code: "_NEWCODE_" already exists, please verify this entry in the FEE BASIS PURPOSE OF VISIT file (#161.82).") Q
 ..N DIC,DA,DR,DLAYGO,DINUM
 ..S DIC="^FBAA(161.82,",DIC(0)="L",DLAYGO=161.82
 ..S X=NEWPOV,DIC("DR")="3///^S X=NEWCODE",DINUM=NEWCODE
 ..K DD,D0 D FILE^DICN K DIC,DA,DLAYGO
 ;Inactivate POV 20
 N DA,DIE,DR
 S DA=$O(^FBAA(161.82,"B","CLASS IIr DENTAL TREATMENT",""))
 S DIE="^FBAA(161.82,",DR="4///01/01/09"
 D
 .I DA D ^DIE Q
 .D BMES^XPDUTL("Purpose of Visit 20, ""CLASS IIr DENTAL TREATMENT"", does not exist.")
 Q
NEWTABLE ;New POVs
 ;;Dialysis^56
 ;;Outpatient Maternity Care Services^67
 ;;Bowel and Bladder care: Agency^68
 ;;Bowel and Bladder care: Family caregiver^69
 ;;EXIT
 ;FBXIP109

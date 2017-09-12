FBXIP159 ;ALB/BJR-PATCH INSTALL ROUTINE ; 10/06/2015 12:59pm
 ;;3.5;FEE BASIS;**159**;JAN 30, 1995;Build 8
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="EN" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP159")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
EN ; Begin Post-Install
 D CF ;Add Conv factors
 Q
CF ; add conversion factors for calendar year 2015 RBRVS fee schedule
 ; File 162.99 is being updated in the post install because the Fee
 ; Basis software examines this file to determine the latest available
 ; fee schedule. By doing this at the end of the patch installation,
 ; users can continue to use the payment options during the install.
 D BMES^XPDUTL("  Filing conversion factor for RBRVS 2015 fee schedule.")
 N DD,DO,DA,DIE,DR,X,Y
 S DA(1)=0 F  S DA(1)=$O(^FB(162.99,DA(1))) Q:'DA(1)  D
 . S DA=$O(^FB(162.99,DA(1),"CY","B",2015,0))
 . I DA'>0 D  Q:DA'>0
 . . S DIC="^FB(162.99,"_DA(1)_",""CY"",",DIC(0)="L",DIC("P")="162.991A",DLAYGO=162.991
 . . S X=2015
 . . K DD,DO D FILE^DICN
 . . K DIC,DLAYGO
 . . S DA=+Y
 . ;
 . S DIE="^FB(162.99,"_DA(1)_",""CY"","
 . S DR=".02///"_$S(DA(1)=1:22.6093,1:35.9335)
 . D ^DIE
 Q
 ;FBXIP159

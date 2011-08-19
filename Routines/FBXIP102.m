FBXIP102 ;WCIOFO/TCK-PATCH INSTALL ROUTINE ; 1/19/07
 ;;3.5;FEE BASIS;**102**;JAN 30, 1995;Build 24
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="CF" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP102")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
CF ; add conversion factors for calendar year 2007 RBRVS fee schedule
 ; File 162.99 is being updated in the post install because the Fee
 ; Basis software examines this file to determine the latest available
 ; fee schedule. By doing this at the end of the patch installation,
 ; users can continue to use the payment options during the install.
 D BMES^XPDUTL("  Filing conversion factor for RBRVS 2007 fee schedule.")
 N DD,DO,DA,DIE,DR,X,Y
 S DA(1)=0 F  S DA(1)=$O(^FB(162.99,DA(1))) Q:'DA(1)  D
 . S DA=$O(^FB(162.99,DA(1),"CY","B",2007,0))
 . I DA'>0 D  Q:DA'>0
 . . S DIC="^FB(162.99,"_DA(1)_",""CY"",",DIC(0)="L",DIC("P")="162.991A",DLAYGO=162.991
 . . S X=2007
 . . K DD,DO D FILE^DICN
 . . K DIC,DLAYGO
 . . S DA=+Y
 . ;
 . S DIE="^FB(162.99,"_DA(1)_",""CY"","
 . S DR=".02///"_$S(DA(1)=1:"",1:37.8975)
 . D ^DIE
 Q
 ;
 ;FBXIP102

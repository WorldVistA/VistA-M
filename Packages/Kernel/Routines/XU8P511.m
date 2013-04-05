XU8P511 ;ISF/RD - Patch XU*8*511 Post-init ;10/15/2008
 ;;8.0;KERNEL;**511**;Jul 10, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; kill "C" & "C2" x-ref in Package file and re-index
 N DIC,DIK,DA
 S DIK="^DIC(9.4,",DIK(1)=1
 K ^DIC(9.4,"C"),^("C2")
 ;re-index the PREFIX field, #1
 D ENALL^DIK
 ;re-index the ADDITIONAL PREFIX field, #14
 K DA,DIK
 S DIK="^DIC(9.4,DA(1),14,",DIK(1)=".01^C2",DA(1)=0
 F  S DA(1)=$O(^DIC(9.4,DA(1))) Q:'DA(1)  D ENALL^DIK
 Q

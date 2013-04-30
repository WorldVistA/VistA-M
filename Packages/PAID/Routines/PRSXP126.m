PRSXP126 ;WOIFO/KJS PAID v4.0 Post-Initialization Routine ;12-9-2011
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine contains the post-initialization code for PAID
 ; package v4.0. Patch 126
 ;
 Q
 ;
POST ;
 ;Reindex POC TIME AEP INDEX
 N DIK,DA
 S DIK="^PRSN(451,DA(1),""E"","
 S DIK(1)="1^AEP"
 S DA(1)=0
 F  S DA(1)=$O(^PRSN(451,DA(1))) Q:DA(1)'?1.N  D
 .D ENALL^DIK
 ;
 ;Reindex POC TIME ALN INDEX
 N DIK,DA
 S DIK="^PRSN(451,DA(4),""E"",DA(3),""D"",DA(2),""V"",DA(1),""T"","
 S DIK(1)="4^ALN"
 S DA(4)=0
 F  S DA(4)=$O(^PRSN(451,DA(4))) Q:DA(4)'?1.N  D
 .S DA(3)=0
 .F  S DA(3)=$O(^PRSN(451,DA(4),"E",DA(3))) Q:DA(3)'?1.N  D
 ..S DA(2)=0
 ..F  S DA(2)=$O(^PRSN(451,DA(4),"E",DA(3),"D",DA(2))) Q:DA(2)'?1.N  D
 ...S DA(1)=0
 ...F  S DA(1)=$O(^PRSN(451,DA(4),"E",DA(3),"D",DA(2),"V",DA(1))) Q:DA(1)'?1.N  D
 ....D ENALL^DIK
 ;
 N DA
 S DA=0
 F  S DA=$O(^PRSN(451.7,DA)) Q:'DA  D
 . N PRSFDA,IEN,PRSIEN,REC
 . S REC=^PRSN(451.7,DA,0),PRSIEN=$P(REC,U,6),TL=$P(^PRSPC(PRSIEN,0),U,8)
 . S PRSFDA(451.7,DA_",",15)=TL ; T&L
 . D UPDATE^DIE("","PRSFDA","IEN"),MSG^DIALOG()
 Q

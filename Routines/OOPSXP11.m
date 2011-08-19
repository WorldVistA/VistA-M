OOPSXP11 ;WIOFO/LLH-INIT ROUTINE FOR PATCH 11 ;3/5/2001 
 ;;1.0;ASISTS;**11**;Jun 01, 1998
 ;
PRE ;
 N MSG,SAF,PMSG
 S MSG(1)=" "
 S MSG(2)="The SAFETY DEVICE USED Field (#43) in the ASISTS ACCIDENT REPORTING "
 S MSG(3)="File (#2260) has been changed. Unknown has been removed as a "
 S MSG(4)="valid code for this field. All records with Unknown will be "
 S MSG(5)="changed to 'N'o."
 ;
 I $$PATCH^XPDUTL("OOPS*1.0*11") D  Q
 . D BMES^XPDUTL("  Skipping pre install since patch was previously installed.")
 D BMES^XPDUTL("Data Conversion in Progress...") H 1
 D MES^XPDUTL(.MSG) H 2
 ;
LOOP ; Loop thru 2260 and change as described above.
 N IEN,DR,DA,DIE,SAF
 S IEN=0,DIE="^OOPS(2260,"
 F  S IEN=$O(^OOPS(2260,IEN)) Q:IEN'>0  D
 . S SAF=$P($G(^OOPS(2260,IEN,"2162D")),U,8)
 . I $G(SAF)="U" S $P(^OOPS(2260,IEN,"2162D"),U,8)="N" D
 .. D MES^XPDUTL("Safety Device changed from Unknown to No for this case "_$$GET1^DIQ(2260,IEN,.01,"E"))
 ; also need to change the type for Suture Needlestick in ^OOPS(2261.7
 K DA,DIE,DR
 S DIE="^OOPS(2261.7,"
 S DA=7,DR="2///^S X=""S""" D ^DIE
 S DA=12,DR="2///^S X=""S""" D ^DIE
 S DA=19,DR="2///^S X=""N""" D ^DIE
 Q

DGQEPST1 ;ALB/JFP- VIC POST INIT UTILITIES; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
APPUPD ;Updates HL7 Application parameter file (#771) with site #
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N FACNUM,DA,DIR,DIE,MSGTXT
 D BMES^XPDUTL(">>> Updates entry DGQE VIC EVENTS in HL APPLICATION file (#771)")
 ;-- Check for application
 I '$D(^HL(771,"B","DGQE VIC EVENTS")) D  Q
 .S MSGTXT(1)="    ** Entries for 'DGQE VIC EVENTS' in the HL APPLICATION"
 .S MSGTXT(2)="       file (#771) can not be created"
 .S MSGTXT(3)="    ** Entries must be manually entered"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 S DA="",DA=+$O(^HL(771,"B","DGQE VIC EVENTS",DA))
 S FACNUM=+$P($$SITE^VASITE(),"^",3)
 S DIE="^HL(771,"
 S DR="3///"_FACNUM
 D ^DIE
 S MSGTXT(1)=" "
 S MSGTXT(2)="     DGQE VIC EVENTS updated with site number"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
UPDLL ;Updates logical link with device,  HL LOWER LEVEL PROTOCOL PARAMETERS
 ;file (#869.2)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N FACNUM,DA,DIR,DIE,MSGTXT,FIND
 D BMES^XPDUTL(">>> Updates entry 'VIC-LINK' in HL LOWER LEVEL PROTOCOL PARAMETER")
 D MES^XPDUTL("    file (#869.2) with device 'VIC CARD'")
 ;-- Check for device
 S FIND=$$FIND1^DIC(3.5,"","X","VIC CARD")
 I FIND=0 D  Q
 .S MSGTXT(1)="    ** Entry for 'VIC CARD' in DEVICE file does not exist"
 .S MSGTXT(2)=""
 .S MSGTXT(3)="    ** The 'VIC CARD' device needs to exist before it can"
 .S MSGTXT(4)="       be updated to the logical link.  These entries"
 .S MSGTXT(5)="       will need to be built manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ;-- Check for Locial Link
 S DA=$$FIND1^DIC(869.2,"","X","VIC-LINK")
 I DA=0 D  Q
 .S MSGTXT(1)="    ** Entry for 'VIC-LINK' in the HL LOWER LEVEL PARAMETER"
 .S MSGTXT(2)="       file (#869.2) is not found"
 .S MSGTXT(3)="    ** Entries must be manually entered and updated with"
 .S MSGTXT(4)="       'VIC CARD' device"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 S DIE="^HLCS(869.2,"
 S DR="200.01///VIC CARD"
 D ^DIE
 S MSGTXT(1)=" "
 S MSGTXT(2)="    Logical link 'VIC-LINK' updated with device 'VIC CARD'"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
UPDBULL ;Updates BULLETIN file (#3.6) with mail group VIC
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N FACNUM,DA,DIR,DIE,MSGTXT
 D BMES^XPDUTL(">>> Updates entry 'DGQE PHOTO CAPTURE' bulletin with VIC mail group")
 ;-- Check for mail group
 S X=$$FIND1^DIC(3.8,"","X","VIC")
 I X=0 D  Q
 .S MSGTXT(1)="    ** Entry for 'VIC' in MAIL GROUP file does not exist"
 .S MSGTXT(2)=""
 .S MSGTXT(3)="    ** The 'VIC' mail group needs to exist before it can"
 .S MSGTXT(4)="       be updated to the bulletin file.  These entries"
 .S MSGTXT(5)="       will need to be built manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ;-- Check for bulletin
 S DA(1)=$$FIND1^DIC(3.6,"","X","DGQE PHOTO CAPTURE")
 I DA(1)=0 D  Q
 .S MSGTXT(1)="    ** Entry for 'DGQE PHOTO CAPTURE' in the bulletin"
 .S MSGTXT(2)="       file (#3.6) is not found"
 .S MSGTXT(3)="    ** The entry must be manually entered and updated"
 .S MSGTXT(4)="       'VIC' mail group"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 S DIC="^XMB(3.6,"_DA(1)_",2,"
 S DIC("P")=$P(^DD(3.6,4,0),"^",2)
 S DIC(0)="L"
 K DO,DD
 I X,'$$FIND1^DIC(3.62,","_DA(1)_",","Q",X) D FILE^DICN K DO,DD
 S MSGTXT(1)=" "
 S MSGTXT(2)="    VIC mail group associated DGQE PHOTO CAPTURE bulletin"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
MAILMEM ; -- A message to adds mail group members to VIC mail group
 ;INPUT  :  None
 ;OUTPUT :  None
 ;Note   : - This is a KID complient check point
 ;
 ; -- Declare variables
 N DA,DIR,DIE,MSGTXT
 D BMES^XPDUTL(">>> Updates VIC mail group with one member")
 ;-- Check for mail group
 S DA(1)=$$FIND1^DIC(3.8,"","X","VIC")
 I DA(1)=0 D  Q
 .S MSGTXT(1)="    ** Entry for 'VIC' mail group can not be found"
 .S MSGTXT(2)="    ** The VIC mail group and members will need to be"
 .S MSGTXT(3)="       entered manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ;-- Check for member
 I '$D(XPDQUES("POS1","B")) D  Q
 .S MSGTXT(1)="    ** No member added to VIC mail group."
 .S MSGTXT(2)="    ** Members will need to be entered manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 S DIC="^XMB(3.8,"_DA(1)_",1,"
 S DIC("P")=$P(^DD(3.8,2,0),"^",2)
 S DIC(0)="L"
 S X=$P($G(XPDQUES("POS1","B")),"^",1) K DO,DD
 I X,'$$FIND1^DIC(3.81,","_DA(1)_",","Q",X) D FILE^DICN K DO,DD
 ;
 S MSGTXT(1)=" "
 S MSGTXT(2)="     VIC mail group updated with new member"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 ;
 D BMES^XPDUTL(">>> Additional members should be added to the VIC Mail Group...")
 S MSGTXT(1)="     The members in this group would be those people"
 S MSGTXT(2)="     responsible for taking care of problems associated"
 S MSGTXT(3)="     with the VIC interface"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
CHKVER ; Check for version 2.2 in HL7 VERSION file (#771.5)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N X,Y,DIC,MSGTXT,DIE,DR,DA
 D BMES^XPDUTL(">>> Checks for version 2.2 in HL7 VERSION file (#771.5)")
 ;-- Check for version 2.2
 I $D(^HL(771.5,"B",2.2)) D  Q
 .S MSGTXT(1)=" "
 .S MSGTXT(2)="    ** Version 2.2 exist in the HL7 version file (#771.5)"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ; -- DIC to add entry
 S DIC(0)="LX"
 S DIC="^HL(771.5,"
 S X=2.2
 D ^DIC
 I Y=-1 D  Q
 .S MSGTXT(1)="    ** Entry for version 2.2 in the HL7 version file "
 .S MSGTXT(2)="       (#771.5) can not be created"
 .S MSGTXT(3)="    ** Entry must be manually entered"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ; -- Entry created, update remaining field
 S DA=$P(Y,"^",1)
 S DIE="^HL(771.5,"
 S DR="2///HEALTH LEVEL SEVEN"
 D ^DIE
 S MSGTXT(1)=" "
 S MSGTXT(2)="     Version 2.2 added to file #771.5"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
CHKA08 ;Checks for version 2.2 in entry A08 of file HL7 EVENT TYPE CODE file
 ;(#779.001)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N DA,DIR,DIE,MSGTXT
 D BMES^XPDUTL(">>> Check for version 2.2 in entry A08 in file #779.001")
 ;-- Check for A08 entry
 I '$D(^HL(779.001,"B","A08")) D  Q
 .S MSGTXT(1)="    ** Entry for 'A08' in HL7 EVENT TYPE CODE file does "
 .S MSGTXT(2)="       not exist"
 .S MSGTXT(3)=""
 .S MSGTXT(4)="    ** The 'A08' event type will need to exist before it"
 .S MSGTXT(5)="       can be updated with version 2.2.  The A08 entry"
 .S MSGTXT(6)="       will need to be built manually and updated"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ;Check for version 2.2 in A08 entry
 ; -- get pointer from 771.5 for version 2.2
 S DA="",DA=$O(^HL(771.5,"B","2.2",DA))
 ; -- get ien for A08
 S DA(1)="",DA(1)=$O(^HL(779.001,"B","A08",DA(1)))
 ; -- check for AO8 entry; for version 2.2
 I $D(^HL(779.001,DA(1),1,"B",DA)) D  Q
 .S MSGTXT(1)=" "
 .S MSGTXT(2)="    ** Version 2.2 already associated with A08 entry"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ; -- Entry Doesn't exist, add it
 S DIC="^HL(779.001,"_DA(1)_",1,"
 S DIC("P")=$P(^DD(779.001,100,0),"^",2)
 S DIC(0)="L"
 S X=DA
 I X,'$D(^HL(779.001,DA(1),1,"B",X)) D FILE^DICN K DO,DD
 S MSGTXT(1)=" "
 S MSGTXT(2)="    Version 2.2 added to entry A08 "
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
CHKACK ;Checks for version 2.2 in entry ACK of file HL7 MESSAGE TYPE file
 ;(#771.2)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N DA,DIR,DIE,MSGTXT
 D BMES^XPDUTL(">>> Check for version 2.2 in entry ACK in file #771.2")
 ;-- Check for ACK entry
 I '$D(^HL(771.2,"B","ACK")) D  Q
 .S MSGTXT(1)="    ** Entry for 'ACK' in HL7 MESSAGE TYPE file does "
 .S MSGTXT(2)="       not exist"
 .S MSGTXT(3)=""
 .S MSGTXT(4)="    ** The 'ACK' message type will need to exist before it"
 .S MSGTXT(5)="       can be updated with version 2.2.  The ACK entry"
 .S MSGTXT(6)="       will need to be built manually and updated"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ;Check for version 2.2 in ACK entry
 ; -- get pointer from 771.5 for version 2.2
 S DA="",DA=$O(^HL(771.5,"B","2.2",DA))
 ; -- get ien for ACK
 S DA(1)="",DA(1)=$O(^HL(771.2,"B","ACK",DA(1)))
 ; -- check for ACK entry; for version 2.2
 I $D(^HL(771.2,DA(1),"V","B",DA)) D  Q
 .S MSGTXT(1)=" "
 .S MSGTXT(2)="    ** Version 2.2 already associated with ACK entry"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ; -- Entry Doesn't exist, add it
 S DIC="^HL(771.2,"_DA(1)_",""V"","
 S DIC("P")=$P(^DD(771.2,3,0),"^",2)
 S DIC(0)="L"
 S X=DA
 I X,'$D(^HL(771.2,DA(1),"V","B",X)) D FILE^DICN K DO,DD
 S MSGTXT(1)=" "
 S MSGTXT(2)="    Version 2.2 added to entry ACK "
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 Q
 ;
ALLP ; -- Sets ALLP xref in file 870 for VIC entry
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 S DA=$$FIND1^DIC(870,"","X","VIC")
 S DIK="^HLCS(870,"
 D IX^DIK
 K DA,DIK
 Q
 ; 
 ; -- Done
 Q

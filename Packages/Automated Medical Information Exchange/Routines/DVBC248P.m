DVBC248P ;ALB/CP - PATCH DVBA*2.7*248 POST-INSTALL ROUTINE; MAY 10, 2023 ; 5/11/23 3:14pm
 ;;2.7;AMIE;**248**;Apr 10, 1995;Build 6
 ; Per VHA Directive 6402 this routine should not be modified
 ;
 Q
 ;
NEWENTRY(DVBIEN) ; 
 ;update file with copied entry but updated name
 N DVBNAME,DVBBODY,DVBPNM,DVBWK
 S DVBNAME="DBQ GENERAL MEDICAL Gulf War"
 S DVBPNM=$$GET1^DIQ(396.6,DVBIEN,6,"I")
 S DVBBODY=$$GET1^DIQ(396.6,DVBIEN,2,"I")
 ;
 s DVBWK=$$GET1^DIQ(396.6,DVBIEN,.07,"I")
 K DIC,DIE,DA,DR,X,Y,DO
 S DIC=396.6,DIC(0)="Z",X=DVBNAME
 D FILE^DICN
 I Y=-1 K DIC Q
 S (DA)=+Y,DIE=DIC
 S DR=".07///"_DVBWK_";2///"_DVBBODY_";6///"_DVBPNM_";.5///A"
 D ^DIE
 K DIC,DIE,DA,DR,X,Y
 Q
 ;
STATUPD ;
 ;update status for entry in AMIE Exam
 N DVBIEN,DVBNAME
 S DVBNAME=""
 S DVBIEN=0
 F  S DVBIEN=$O(^DVB(396.6,DVBIEN)) Q:DVBIEN=""  D
 . S DVBNAME=$P($G(^DVB(396.6,DVBIEN,0)),U,1)
 . Q:DVBNAME'="DBQ GENERAL MEDICAL Gulf War (including burn pits)"
 . D NEWENTRY(DVBIEN)
 . S DIE="^DVB(396.6,"
 . S DA=DVBIEN
 . S DR=".5///I" D ^DIE
 . K DIE,DA,DR,X,Y
 D BMES^XPDUTL("Exam Name DBQ GENERAL MEDICAL GULF WAR updated")
 D SPECUP
 Q
SPECUP ; 
 ;update status for all entries in Special Considerations
 N DVBSTAT S DVBSTAT=1
 N DVBIEN S DVBIEN=0
 K DIC,DIE,DA,DR,DLAYGO,X,Y
 F  S DVBIEN=$O(^DVB(396.25,DVBIEN)) Q:DVBIEN=""!('DVBIEN)  D
 . Q:$P($G(^DVB(396.25,DVBIEN,0)),U,2)=1
 . S DA=DVBIEN,(DLAYGO,DIE)="^DVB(396.25,",DIC(0)="L"
 . S DR=".02////"_DVBSTAT D ^DIE
 . K DIC,DIE,DA,DR,DLAYGO,X,Y
 D BMES^XPDUTL("Special Consideration File entries updated")
 Q

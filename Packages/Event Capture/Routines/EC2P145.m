EC2P145 ;ALB/DAN - Installation activities ;9/18/18  15:20
 ;;2.0;EVENT CAPTURE;**145**;8 May 96;Build 6
 ;
POST ;Post-install activities
 D SERUPD ;Add medical specialty/service
 D CHKLOC ;Check location names to see if they're correct
 D DELLOC ;Del "LOC" xref and then rebuild so it uses current names
 D GHOST ;Identify "ghost" DSS units (missing status)
 Q
 ;
SERUPD ;Section will add new values to the Medical Specialty file
 N NAME,CODE,OFF,NUM,DO,DIC,X,Y
 D BMES^XPDUTL("Checking Medical Specialty file..."),MES^XPDUTL("")
 F OFF=1:1 S CODE=$P($T(SERVICE+OFF),";;",2) Q:CODE="DONE"  D
 .S NAME=$P(CODE,U)
 .S NUM=$$FIND1^DIC(723,,"X",NAME,"B")
 .I NUM D MES^XPDUTL("Medical Specialty: "_NAME_" already exists.") Q
 .K DO
 .S DIC="^ECC(723,"
 .S DIC(0)=""
 .S X=NAME
 .D FILE^DICN
 .D MES^XPDUTL("Medical Specialty: "_NAME_" was "_$S(Y:"",1:"NOT ")_"added.")
 .Q
 Q
 ;
CHKLOC ;Check "LOC" index against actual names and report differences
 N NAME,REC,CHG,DEL,NEWNM
 S NAME="" F  S NAME=$O(^DIC(4,"LOC",NAME)) Q:NAME=""  D
 .S REC=0 F  S REC=$O(^DIC(4,"LOC",NAME,REC)) Q:'+REC  D
 ..I '$D(^DIC(4,REC)) S DEL(NAME,REC)="" Q
 ..S NEWNM=$P($G(^DIC(4,REC,0)),U) ;Current name of location
 ..I NEWNM'=NAME S CHG(NAME,REC)=NEWNM ;Note name change
 D MAIL
 Q
 ;
DELLOC ;Fix "LOC" table in file 4
 N DIK
 D BMES^XPDUTL("Deleting 'LOC' cross-reference in file 4...")
 K ^DIC(4,"LOC") ;One-time IA 6723 allows for this deletion
 D MES^XPDUTL("Done")
 D BMES^XPDUTL("Rebuilding 'LOC' cross-reference in file 4")
 S DIK="^DIC(4,",DIK(1)=720 D ENALL^DIK
 D MES^XPDUTL("Done")
 Q
 ;
GHOST ;Finds DSS units that are missing their status.  Missing status causes unit to appear in some lists, but not others, like a "ghost"
 N NODE,GHOST,DSSIEN
 D BMES^XPDUTL("Checking DSS Units for correct setup...")
 S DSSIEN=0 F  S DSSIEN=$O(^ECD(DSSIEN)) Q:'+DSSIEN  D
 .S NODE=$G(^ECD(DSSIEN,0)) Q:NODE=""
 .I $P(NODE,U,6)=""&($P(NODE,U,8)="") D
 ..I $P(NODE,U)=$$GET1^DIQ(509850.8,"1,",727.8251)!($P(NODE,U)=$$GET1^DIQ(509850.8,"1,",727.8252)) Q  ;Don't update audiology and speech pathology DSS units
 ..S GHOST($P(NODE,U))=DSSIEN
 ..S $P(^ECD(DSSIEN,0),U,6)=1 ;Set status to inactive
 ..S $P(^ECD(DSSIEN,0),U,8)=1 ;Set 'use in event capture' to 1 (yes)
 ..Q
 .Q
 D BMES^XPDUTL("Done")
 D MAIL2
 Q
 ;
MAIL ;Send email with results to holders of the ECMGR key
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECTEXT,NUM,NAME
 S XMDUZ="PATCH EC*2*145 POST-INSTALL"
 D GETXMY("ECMGR",.XMY)
 S CNT=1
 S ECTEXT(CNT)="A review of Event Capture Location names has completed.",CNT=CNT+1,ECTEXT(CNT)="Event Capture Location names were checked to make sure they are using the",CNT=CNT+1
 S ECTEXT(CNT)="correct name as found in the INSTITUTION file (#4).",CNT=CNT+1
 S ECTEXT(CNT)="",CNT=CNT+1
 I '$D(CHG),'$D(DEL) S ECTEXT(CNT)="No differences were found between your Event Capture Locations and the",CNT=CNT+1,ECTEXT(CNT)="INSTITUTION file.  No further action is required.",CNT=CNT+1
 I $D(CHG)!($D(DEL)) D
 .S ECTEXT(CNT)="Changes to your Event Capture Location names were required.",CNT=CNT+1
 .S ECTEXT(CNT)="Entries are identified by NAME(IEN), where IEN is the record number in the",CNT=CNT+1
 .S ECTEXT(CNT)="INSTITUTION file (file #4).",CNT=CNT+1
 .S ECTEXT(CNT)="",CNT=CNT+1
 I $D(CHG) D  S ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="The following locations had their name updated:",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S NAME="" F  S NAME=$O(CHG(NAME)) Q:NAME=""  S NUM=0 F  S NUM=$O(CHG(NAME,NUM)) Q:'+NUM  D
 ..S ECTEXT(CNT)=NAME_" ("_NUM_") is now "_$G(CHG(NAME,NUM)),CNT=CNT+1
 I $D(DEL) D  S ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="The following locations are no longer available:",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S NAME="" F  S NAME=$O(DEL(NAME)) Q:NAME=""  S NUM=0 F  S NUM=$O(DEL(NAME,NUM)) Q:'+NUM  S ECTEXT(CNT)=NAME_" ("_NUM_") is no longer available.",CNT=CNT+1
 I $D(CHG)!($D(DEL)) D
 .S ECTEXT(CNT)="These updates were done to get your Event Capture Location names",CNT=CNT+1,ECTEXT(CNT)="back in sync with the INSTITUTION file.  You should review your Event",CNT=CNT+1
 .S ECTEXT(CNT)="Capture Locations to make sure that locations identified for use in Event",CNT=CNT+1,ECTEXT(CNT)="Capture are correct.  No other action is required."
 S XMTEXT="ECTEXT(",XMSUB="Event Capture Location review"
 D ^XMD
 Q
 ;
MAIL2 ;Send email with results of DSS unit review to ECMGR key holders
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECTEXT,NAME
 S XMDUZ="PATCH EC*2*145 POST-INSTALL"
 D GETXMY("ECMGR",.XMY)
 S CNT=1
 S ECTEXT(CNT)="A review of Event Capture DSS Units has completed.",CNT=CNT+1,ECTEXT(CNT)="DSS units were reviewed to ensure they're correctly set up for use",CNT=CNT+1
 S ECTEXT(CNT)="in the Event Capture program.",CNT=CNT+1
 S ECTEXT(CNT)="",CNT=CNT+1
 I '$D(GHOST) S ECTEXT(CNT)="All DSS units are correctly set up.",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1,ECTEXT(CNT)="No further action is required.",CNT=CNT+1
 I $D(GHOST) D
 .S ECTEXT(CNT)="Changes to your DSS Units were required.",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="Entries are identified by NAME(IEN), where IEN is the record number in the",CNT=CNT+1
 .S ECTEXT(CNT)="DSS UNIT file (#724).",CNT=CNT+1
 .S ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="The following DSS units were updated:",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S NAME="" F  S NAME=$O(GHOST(NAME)) Q:NAME=""  S ECTEXT(CNT)=NAME_" ("_GHOST(NAME)_")",CNT=CNT+1
 .S ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="Please review the DSS units listed above to ensure they're now inactive."
 S XMTEXT="ECTEXT(",XMSUB="DSS Unit review"
 D ^XMD
 Q
 ;
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
 ;
SERVICE ;List of new entries for the Medical Specialty file
 ;;VOCATIONAL REHABILITATION
 ;;DONE

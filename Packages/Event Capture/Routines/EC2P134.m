EC2P134 ;ALB/DAN - Installation activities ;4/19/17  11:04
 ;;2.0;EVENT CAPTURE;**134**;8 May 96;Build 12
 ;
ENV ;Environment check to make sure old file 722 isn't there
 ;
 N DIU
 I '$D(^ECC(722,0)) W !,"Environment is ready for installation." Q
 I $D(^ECC(722,0)) D  ;If old file 722 exists, delete it.
 .W !,"Old file encountered during check..."
 .W !,"Removing 'EVENT CAPTURE EXTRACTS' file (#722) as it's obsolete."
 .S DIU="^ECC(722,"
 .S DIU(0)="DT" ;Remove data and templates as well as the file
 .D EN^DIU2
 .Q
 Q
 ;
POST ;Post-install activities
 D DTPD ;Delete test patient data
 D CHKLOC ;Check location names to see if they're correct
 D DELLOC ;Del "LOC" xref and then rebuild so it uses current names
 Q
 ;
DTPD ;Delete test patient data from file 721 if this is a production install
 N PROD,RESULTS,DIK
 S PROD=$$PROD^XUPROD
 I PROD D
 .D BMES^XPDUTL("Starting task in background to delete test patient data from the")
 .D MES^XPDUTL("EVENT CAPTURE PATIENT file (#721).  An email will be sent upon completion.")
 .D DTPD^ECUMRPC2(.RESULTS,"D")
 .D BMES^XPDUTL($S(@RESULTS@(0):"Task queued successfully.",1:"Error setting up task - contact national help desk."))
 .Q
 I 'PROD D BMES^XPDUTL("Not a production environment - no test patient data deleted.")
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
 D BMES^XPDUTL("Deleting 'LOC' cross-reference in file 4...")
 K ^DIC(4,"LOC") ;One-time IA 6723 allows for this deletion
 D MES^XPDUTL("Done")
 D BMES^XPDUTL("Rebuilding 'LOC' cross-reference in file 4")
 S DIK="^DIC(4,",DIK(1)=720 D ENALL^DIK
 D MES^XPDUTL("Done")
 Q
 ;
MAIL ;Send email with results to holders of the ECMGR key
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECTEXT,NUM,NAME
 S XMDUZ="PATCH EC*2*134 POST-INSTALL"
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
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
 ;

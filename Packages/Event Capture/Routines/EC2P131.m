EC2P131 ;ALB/DAN Post-Install events for Event Capture patch 131 ;10/27/15  16:08
 ;;2.0;EVENT CAPTURE;**131**;8 May 96;Build 13
 ;
POST ;Called from build to do post-install events
 N UPDATE
 D CHKPCE
 D MAIL
 D CHKDSS^ECUTL3
 D REASON
 Q
 ;
CHKPCE ;Change any DSS units that have SEND TO PCE set to "O" to "A"
 N IEN,DSSU
 S IEN=0 F  S IEN=$O(^ECD(IEN)) Q:'+IEN  S DSSU=$G(^ECD(IEN,0)) I $P(DSSU,U,14)="O" S $P(^ECD(IEN,0),U,14)="A",UPDATE($P(DSSU,U)_U_IEN_U_$S('$P(DSSU,U,6):"Active",1:"Inactive"))=""
 Q
 ;
MAIL ;Send findings via email
 N XMSUB,ECTEXT,XMDUZ,XMY,XMZ,XMTEXT,KIEN,DIFROM,NAME,CNT
 S XMDUZ="Event Capture Package"
 S XMY($G(DUZ,.5))="" ;Set recipient to installer or postmaster
 S KIEN=0 F  S KIEN=$O(^XUSEC("ECMGR",KIEN)) Q:'+KIEN  S XMY(KIEN)="" ;Holders of ECMGR included in email, XUSEC read allowed by DBIA #10076
 S ECTEXT(1)="The check for DSS Units with a Send to PCE setting of 'Outpatient Only'"
 S ECTEXT(2)="has completed.  Below are the results."
 S ECTEXT(3)=""
 I '$D(UPDATE) S ECTEXT(4)="No DSS Units were identified.  No further action is required."
 S CNT=4 ;start with line 4 to add to message
 I $D(UPDATE) D
 .S ECTEXT(CNT)="The following DSS Units had their Send to PCE setting changed to 'All Records':",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="NAME"_$$REPEAT^XLFSTR(" ",28)_"DSS IEN  STATUS",CNT=CNT+1,ECTEXT(CNT)="----"_$$REPEAT^XLFSTR(" ",28)_"-------  ------",CNT=CNT+1
 .S NAME="" F  S NAME=$O(UPDATE(NAME)) Q:NAME=""  S ECTEXT(CNT)=$P(NAME,U)_$$REPEAT^XLFSTR(" ",(32-$L($P(NAME,U))))_$P(NAME,U,2)_$$REPEAT^XLFSTR(" ",(9-$L($P(NAME,U,2))))_$P(NAME,U,3),CNT=CNT+1
 S XMTEXT="ECTEXT(",XMSUB="DSS Unit send to PCE review"
 D ^XMD ;Send email
 Q
 ;
REASON ;Add entries in file 720.4
 ;
 N ECXFDA,ECXERR,ECREAS,I,DONE,IEN,FDA
 ;
 ;-add procedure reason
 F I=1:1 S ECREAS=$P($T(ADDREAS+I),";;",2) Q:ECREAS="QUIT"  D
 .;
 .;-quit w/error message if entry already exists in file #720.4
 .I $$FIND1^DIC(720.4,"","X",ECREAS) D  Q
 ..D BMES^XPDUTL(">>>..."_ECREAS_" not added, entry already exists.")
 .;
 .;Setup field values of new entry
 .S ECXFDA(720.4,"+1,",.01)=ECREAS
 .S ECXFDA(720.4,"+1,",.02)=1 ;Set "ACTIVE?" field to 1 (active)
 .;
 .;-add new entry to file #720.4
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>..."_ECREAS_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>...Unable to add "_ECREAS_" to file.")
 ;
 Q
 ;
ADDREAS ;List of new procedure reasons
 ;;CHAP COUPLES COUNSELING
 ;;QUIT
 ;

EC2P119 ;ALB/DAN Update DSS names to uppercase ;1/14/13  11:27
 ;;2.0;EVENT CAPTURE;**119**;8 May 96;Build 12
POST ;Post install runs from here
 N DSSID,NAME,UPNAME,DATA,DUP,UPD,ERR,CNT
 D BMES^XPDUTL("Checking DSS UNIT names for lowercase letters")
 D CHECK
 D BMES^XPDUTL("Sending email to installer and holders of ECMGR key with results of check")
 D MAIL
 Q
 ;
CHECK ;Check existing DSS UNIT entries in file 724 for names that have lowercase letters.  Convert to uppercase if found.
 S DSSID=0 F  S DSSID=$O(^ECD(DSSID)) Q:'+DSSID  D
 .S NAME=$P(^ECD(DSSID,0),U),UPNAME=$$UP^XLFSTR(NAME)
 .I NAME=UPNAME Q  ;Nothing to change
 .I $D(^ECD("B",UPNAME)) S DUP(NAME)=UPNAME Q  ;Converting name would cause a duplicate
 .S DATA(724,DSSID_",",".01")=UPNAME D FILE^DIE(,"DATA") ;file change in name
 .I '$D(^TMP("DIERR",$J)) S UPD(NAME)=UPNAME Q  ;Uppercase name stored without error
 .S ERR(NAME)="" K ^TMP("DIERR",$J) Q  ;Error filing name.
 Q
 ;
MAIL ;Send email with results
 N XMSUB,ECTEXT,XMDUZ,XMY,XMZ,XMTEXT,KIEN,DIFROM
 S XMDUZ="Event Capture Patch 119 Post-install"
 S XMY($G(DUZ,.5))="" ;Set recipient to installer or postmaster
 S KIEN=0 F  S KIEN=$O(^XUSEC("ECMGR",KIEN)) Q:'+KIEN  S XMY(KIEN)="" ;Holders of ECMGR included in email, XUSEC read allowed by DBIA #10076
 S XMSUB="Patch EC*2*119 Post install COMPLETED"
 S XMTEXT="ECTEXT("
 S ECTEXT(1)="The post-install for patch 119, review of DSS UNIT names,"
 S ECTEXT(2)="has completed.  Below are the results of the review."
 S ECTEXT(3)=""
 I '$D(DUP)&('$D(UPD))&('$D(ERR)) S ECTEXT(4)="No changes were made and no further action is required." D ^XMD Q
 S CNT=4
 I $D(UPD) D  S ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="The following entries were updated during this process.",CNT=CNT+1,ECTEXT(CNT)="No further action is required for these entries.",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S NAME="" F  S NAME=$O(UPD(NAME)) Q:NAME=""  S ECTEXT(CNT)=NAME_" was changed to "_UPD(NAME),CNT=CNT+1
 I $D(DUP) D  S ECTEXT(CNT)="",CNT=CNT+1
 .S ECTEXT(CNT)="The following entries could not be updated because a duplicate entry",CNT=CNT+1,ECTEXT(CNT)="would have been created.  Please update entries manually or log a remedy",CNT=CNT+1,ECTEXT(CNT)="ticket for assistance.",CNT=CNT+1
 .S ECTEXT(CNT)="",CNT=CNT+1
 .S NAME="" F  S NAME=$O(DUP(NAME)) Q:NAME=""  S ECTEXT(CNT)=NAME_" would have created a duplicate entry to "_DUP(NAME),CNT=CNT+1
 I $D(ERR) D
 .S ECTEXT(CNT)="The following entries couldn't be updated because an error was encountered.",CNT=CNT+1,ECTEXT(CNT)="Please log a remedy ticket for assistance.",CNT=CNT+1,ECTEXT(CNT)="",CNT=CNT+1
 .S NAME="" F  S NAME=$O(ERR(NAME)) Q:NAME=""  S ECTEXT(CNT)="Couldn't update DSS UNIT "_NAME,CNT=CNT+1
 D ^XMD

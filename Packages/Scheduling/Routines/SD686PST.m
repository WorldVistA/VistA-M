SD686PST ;  ALB/SAT - SD*5.3*686 POST-INSTALL ;
 ;;5.3;Scheduling;**686**;Aug 13, 1993;Build 53
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;  Post-install routine for patch 686.  Identifies data errors in scheduling request files (#403.5, 409.3, 123, 409.85).
 ;
 D EXECUTE ;
 D AD
 Q
 ;
EXECUTE ;
 ;
 K ^TMP($J) ;
 ;
 N DA,I,FND,XMZ,LINE,X,SENDMSG ;
 S SENDMSG=0 ;
 W !,"Checking for data errors",! ;
 ;
 ;  Check for missing patient pointers in Request/Consultation (#123) file
 ;
 W !,"Consults..." ;
 S LINE=1,^TMP($J,"SDEC",LINE)="Records in consult file (#123) with null patient pointers (field #.02)" ;
 S DA=0,FND=0 F I=1:1 S DA=$O(^GMR(123,DA)) Q:'DA  W:I#1000=0 "." S X=$G(^(DA,0)) D  ;
 . I $P(X,"^",2)="" S FND=1,LINE=LINE+1,^TMP($J,"SDEC",LINE)="Null patient pointer (field #.02) in record "_DA ;
 ;
 I 'FND S LINE=LINE+1,^TMP($J,"SDEC",LINE)="NONE FOUND" ;
 E  S SENDMSG=1 ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 ;
 ;  Check for bad dates in Recall Reminders file (#403.5)
 ;
 W !,"Recall Reminders..." ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)="Records in recall reminders file (#403.5) with imprecise dates (fields #5 and #5.5)" ;
 S DA=0,FND=0 F I=1:1 S DA=$O(^SD(403.5,DA)) Q:'DA  W:I#1000=0 "." S X=$G(^(DA,0)) D  ;
 . I $P(X,"^",6)?5N1"00" S FND=1,LINE=LINE+1,^TMP($J,"SDEC",LINE)="Recall Date (#5) incorrect in record "_DA ;
 . I $P(X,"^",12)?5N1"00" S FND=1,LINE=LINE+1,^TMP($J,"SDEC",LINE)="Recall Date Per Patient (#5.5) incorrect in record "_DA ;
 ;
 I 'FND S LINE=LINE+1,^TMP($J,"SDEC",LINE)="NONE FOUND" ;
 E  S SENDMSG=1 ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 ;
 ;  Check for bad dates in Wait List file (#409.3)
 ;
 W !,"Wait List..." ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)="Records in wait list file (#409.3) with imprecise dates (field #22)" ;
 S DA=0,FND=0 F I=1:1 S DA=$O(^SDWL(409.3,DA)) Q:'DA  W:I#1000=0 "." S X=$G(^(DA,0)) D  ;
 . I $P(X,"^",16)?5N1"00" S FND=1,LINE=LINE+1,^TMP($J,"SDEC",LINE)="Desired Date of Appointment (#22) incorrect in record "_DA ;
 ;
 I 'FND S LINE=LINE+1,^TMP($J,"SDEC",LINE)="NONE FOUND" ;
 E  S SENDMSG=1 ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 ;
 ;  Check for bad dates in Appointment Request file (#409.85)
 ;
 W !,"Appointment Request..." ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)="Records in appointment request file (#409.85) with imprecise dates" ;
 S DA=0,FND=0 F I=1:1 S DA=$O(^SDEC(409.85,DA)) Q:'DA  W:I#1000=0 "." S X=$G(^(DA,0)) D  ;
 . I $P(X,"^",16)?5N1"00" S FND=1,LINE=LINE+1,^TMP($J,"SDEC",LINE)="CID/Preferred Date of Appointment (#22) incorrect in record "_DA ;
 ;
 I 'FND S LINE=LINE+1,^TMP($J,"SDEC",LINE)="NONE FOUND" ;
 E  S SENDMSG=1 ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 S LINE=LINE+1,^TMP($J,"SDEC",LINE)=" " ;
 ;
 ;  Send e-mail message with database errors listed.
 ;
 I SENDMSG D  ;
 . ;
 . N XMTO ;
 . S XMTO(DUZ)="" ; ,XMTO("Outlook e-mail address")="" ;  <<== Tested with Outlook e-mail address (e.g., xxx.yyy@domain.ext).  Add e-mail address of Outlook group if needed. wtc 9/6/2019
 . D SENDMSG^XMXAPI(DUZ,"Patch #686 - Database errors","^TMP($J,""SDEC"")",.XMTO,,.XMZ) ;
 . ;
 . W !,"A MailMan message has been sent to you containing a list of the database errors found.  Please forward the message to your IRM representative.",! ;
 ;
 K ^TMP($J) ;
 Q  ;
 ;
AD ;build AD cross-reference for patient contacts
 W !,"Building AD cross-reference for SDEC CONTACT file (#409.86)..."
 I $D(^SDEC(409.86,"AD")) W !,"Cross-reference data already exists, aborting." Q
 N SDXREF
 S SDXREF=$O(^DD("IX","BB",409.86,"AD",""))
 I SDXREF="" W !,"Cross-reference definition missing, aborting." Q
 D INDEX^DIKC(409.86,"","",SDXREF,"KSW409.863")
 Q
 ;

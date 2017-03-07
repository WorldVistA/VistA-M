ICD1889P ;HIOFO/FT - ICD*18*89 POST-INIT ;11/16/16
 ;;18.0;DRG Grouper;**89**;Oct 20, 2000;Build 9
 ;
 ; VASITE APIs - #10112
 ; XMD APIs - #10070
 ; XUPROD APIs - #4440 
 ; XPDUTL APIs- #10141
 ;
 Q
POST ;Check new files to see if all of the entries were created.
 N ICDCNT,ICDFILE,ICDIEN,ICDMSG,ICDTEXT,ICDTOTAL,X,Y
 S ICDTEXT(1)=">>> Checking number of entries in new DRG files..."
 D BMES^XPDUTL(.ICDTEXT)
 K ICDTEXT
 S ICDFILE(83)=337
 S ICDFILE(83.1)=772
 S ICDFILE(83.11)=1
 S ICDFILE(83.2)=402
 S ICDFILE(83.3)=476
 S ICDFILE(83.5)=63011
 S ICDFILE(83.51)=119717
 S ICDFILE(83.6)=52571
 S ICDFILE(83.61)=4723
 S ICDFILE(83.7)=14
 S ICDFILE(83.71)=23
 S ICDCNT=2
 F ICDIEN=83,83.1,83.11,83.2,83.3,83.5,83.51,83.6,83.61,83.7,83.71 D
 .S ICDTOTAL=$P($G(^ICDD(ICDIEN,0)),U,4)
 .I ICDTOTAL'=ICDFILE(ICDIEN) D
 ..S ICDCNT=ICDCNT+1
 ..S (ICDTEXT(ICDCNT),ICDMSG(ICDCNT))="     FILE "_ICDIEN_"="_ICDTOTAL_".  It should be "_$G(ICDFILE(ICDIEN))_"."
 I ICDCNT=2  D  Q  ;no discrepancy, quit post-init
 .S ICDTEXT(1)=">>>  The number of entries look fine."
 .D BMES^XPDUTL(.ICDTEXT)
 ;
 S ICDTEXT(1)=">>>  There is a discrepancy in the number of entries in the new DRG files."
 S ICDTEXT(2)=">>>  Please log a ticket."
 D BMES^XPDUTL(.ICDTEXT)
 Q:$$PROD^XUPROD()=0  ;not a production account. Don't send email.
 ;
MAIL ;send MailMan message to developers if file counts don't match
 N DIFROM ;per KIDS manual, NEW DIFROM before calling MailMan in env/pre/post routine
 N XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ=$S($G(DUZ)>0:DUZ,1:.5)
 S XMSUB="ICD*18*89 - Station "_$P($$SITE^VASITE(),U,3)_" file count issue"
 S ICDMSG(1)="ICD*18*89 was installed and found a difference in the number"
 S ICDMSG(2)="of entries for the following files:"
 S XMTEXT="ICDMSG("
 S XMY("user1@domain.ext")="",XMY("user2@domain.ext")=""
 D ^XMD
 Q

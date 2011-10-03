DG53P597 ; BAY/JAP- Patch DG*5.3*597 Post-Installation ; 04/19/2004
 ;;5.3;Registration;**597**;AUG 13, 1993
 ;
 ;be sure that all existing 1010EZ applications in 1010EZ HOLDING file (#712)
 ;are linked to file #2 thru the new field MOST RECENT 1010EZ (#1010.156);
 ;also update APPOINTMENT REQUEST ON 1010EZ field (#1010.159) using data from field #4.4/file #712
 ;and EMAIL ADDRESS field (#.133) using data from field #4.3/file #712
 ;in the applicant's file #2 record.
 ;
POST ;
 ;queue the task to background for 5:00 AM following date of install
 ;ZTRTN="QUE^DG53P597"
 N QUETIME,X1,X2
 S X1=DT,X2=1 D C^%DTC
 S QUETIME=X_".05"
 S ZTDTH=QUETIME
 S ZTIO="",ZTDESC="DG*5.3*597 POST-INSTALLATION TASK"
 S ZTRTN="QUE^DG53P597"
 D ^%ZTLOAD
 I '$G(ZTSK) W !!,"POST-INSTALL BACKGROUND TASK NOT QUEUED",! D NOTASK
 Q
 ;
QUE ;entry point from TaskManager
 ;
 ;only update file #2 with data from file #712 record if date filed exists
 ;(#3.4) LINK TO FILE #2 [10P:2]
 ;(#4.3) APPLICANT E-MAIL [4F]
 ;(#4.4) APPOINTMENT REQUESTED [5S]
 ;(#7.1) FILING DATE [5D]
 S START=$$NOW^XLFDT()
 S REC712=0,TOTAL=0,UPDATES=0
 F  S REC712=$O(^EAS(712,REC712)) Q:'REC712  D
 .S TOTAL=TOTAL+1,NEW=0
 .S DFN=+$P(^EAS(712,REC712,0),U,10),FILED=+$P($G(^EAS(712,REC712,2)),U,5)
 .Q:'DFN
 .Q:'$D(^DPT(DFN,0))
 .Q:'FILED
 .S EMAIL=$P($G(^EAS(712,REC712,1)),U,4),APPTREQ=$P($G(^EAS(712,REC712,1)),U,5)
 .I $P($G(^DPT(DFN,1010.15)),U,6)="" S NEW=1
 .S IENS=DFN_","
 .K DATA S DATA(2,IENS,.133)=EMAIL,DATA(2,IENS,1010.156)=REC712,DATA(2,IENS,1010.159)=APPTREQ
 .K ERRMSG D FILE^DIE("","DATA","ERRMSG")
 .I '$D(ERRMSG),NEW S UPDATES=UPDATES+1
 ;when process of file #712 is complete
 D MESS(TOTAL,UPDATES,$G(ZTSK),START)
 Q
 ;
MESS(TOTAL,UPDATES,ZTSK,START) ;
 ;send MailMan message to members of G.VA1010EZ as well installer of patch
 ;to inform that job has completed and number of file #2 records updated.
 ;
 S Y=START D DD^%DT S START=Y
 I $G(ZTSK) S MSG(1)="The post-installation background task (#"_ZTSK_") for DG*5.3*597,"
 I '$G(ZTSK) S MSG(1)="A post-installation update process for DG*5.3*597,"
 S MSG(2)="which started on "_START_", has completed."
 S MSG(3)=" "
 S MSG(4)="A total of "_TOTAL_" records in the 1010EZ HOLDING file (#712)"
 S MSG(5)="were processed."
 S MSG(6)=" "
 S MSG(7)=UPDATES_" records in the PATIENT file (#2) were updated as follows:"
 S MSG(8)="   Field #.133 from #712/#4.3"
 S MSG(9)="   Field #1010.156 from #712 IEN"
 S MSG(10)="   Field #1010.159 from #712/#4.4"
 S MSG(11)=" "
 K XMY
 S XMDUZ=.5,XMTEXT="MSG(",XMY(DUZ)="",WHERE=^XMB("NETNAME"),XMY("G.VA1010EZ@"_WHERE)=""
 S XMSUB="DG*5.3*597 Post-Installation Task Complete"
 D ^XMD
 K DFN,MSG,NEW,REC712,TOTAL,UPDATES,WHERE,XMZ,XMY,XMDUZ
 Q
 ;
NOTASK ;
 ;send MailMan message to members of G.VA1010EZ as well installer of patch
 ;to inform that post-install job was not successfully tasked.
 ;
 S MSG(1)="The post-installation background job for DG*5.3*597"
 S MSG(2)="was not successfully queued."
 S MSG(3)=" "
 S MSG(4)="Please have a member of IRM Service at your facility"
 S MSG(5)="run the post-installation update directly from"
 S MSG(6)="programmer mode by entering the following command:"
 S MSG(7)=" "
 S MSG(8)="D QUE^DG53P597"
 S MSG(9)=" "
 S MSG(10)="The process should take less than 30 minutes to complete."
 K XMY
 S XMDUZ=.5,XMTEXT="MSG(",XMY(DUZ)="",WHERE=^XMB("NETNAME"),XMY("G.VA1010EZ@"_WHERE)=""
 S XMSUB="DG*5.3*597 Post-Installation Failure"
 D ^XMD
 K MSG,WHERE,XMZ,XMY,XMDUZ
 Q

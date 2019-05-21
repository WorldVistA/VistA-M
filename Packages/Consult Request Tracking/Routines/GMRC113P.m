GMRC113P ;ABV/MKN - Post-Install routine for GMRC*3*113;8/18/2018 9:35
 ;;3.0;CONSULT/REQUEST TRACKING;**113**;DEC 27, 1997;Build 50
 ;
 ;;ICR Invoked
 ;;10063, ^%ZTLOAD - $$S
 ;;10141, ^XPDUTL - BMES, MES
 ;;10103, ^XLFDT - $$FMADD, $$NOW
 ;;10070, ^XMD - ENL, ENT1
 ;
 Q
 ;
POST ;Updates the CSLT CANCELLED TO DISCONTINUED parameter to seed initial values
 N DIC,DLAYGO,NA,TSTAMP,X
 D BMES^XPDUTL("Updating the parameter CSLT CANCELLED TO DISCONTINUED with initial values:")
 D BMES^XPDUTL("Is the overnight cancelled to discontinued job active? = NO")
 D MES^XPDUTL("How many days back to start with? = 31")
 D MES^XPDUTL("How many days back to end with? = 365")
 D PUT^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","Is the overnight cancelled to discontinued job active?","NO")
 D PUT^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","How many days back to start with?",31)
 D PUT^XPAR("PKG.CONSULT/REQUEST TRACKING","CSLT CANCELLED TO DISCONTINUED","How many days back to end with?",365)
 D BMES^XPDUTL("CSLT CANCELLED TO DISCONTINUED parameter has been initialized")
 ;Kill old option GMRC CANCELLED TO DISCONTINUED, replaced by GMRC CHANGE STATUS X TO DC in test version 7
 S DIK="^DIC(19,",DA=$O(^DIC(19,"B","GMRC CANCELLED TO DISCONTINUED","")) D:DA ^DIK
 ;Add to file #19.2 (OPTION SCHEDULING)
 D BMES^XPDUTL("Set up schedule for GMRC CHANGE STATUS X TO DC")
 I $$FIND1^DIC(19.2,,"B","GMRC CHANGE STATUS X TO DC","B") D MES^XPDUTL("Already scheduled")
 E  D
 .S (DLAYGO,DIC)=19.2,DIC(0)="L"
 .S X="GMRC CHANGE STATUS X TO DC"
 .S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="23"
 .S DIC("DR")="2////"_TSTAMP_";6////D@11:00PM" D ^DIC
 ;
 D QUEUE
 Q
 ;
QUEUE ;Create entries in new index ASTATUS, task entry point
 N ZTRTN,ZTDESC,ZTREQ,ZTIO,ZTDTH,ZTSK
 D BMES^XPDUTL("Calling TaskMan to create background job to create entries in new index ASTATUS")
 S ZTRTN="EN^GMRC113P",ZTDESC="Create entries in file #123 for new index ASTATUS",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("Unable to create TaskMan job - run EN^GMRC113P after install finishes") Q 
 D BMES^XPDUTL("Post-install queued as task #"_$G(ZTSK))
 Q
 ;
EN ;Create Consult record entries for new ASTATUS index
 N DA,DIK,HANGRECS,HANGSECS,IEN123,IEN12340,NUMRECS,X,ZTSTOP
 S HANGRECS=10000,HANGSECS=10 ;Hang every 10,000 records for 10 seconds
 S (NUMRECS,ZTSTOP)=0,IEN123=$G(^GMR(123,"ASTATUS",0),"@")
 F  S IEN123=$O(^GMR(123,IEN123),-1) Q:'IEN123!(ZTSTOP)  D
 .S ^GMR(123,"ASTATUS",0)=IEN123 ;This is to allow re-entrance of this function after being manually shut down
 .I $$S^%ZTLOAD D  Q
 ..S ZTSTOP=1,X=$$S^%ZTLOAD("GMRC*3.0*113 post-install received a shutdown request")
 ..D MSG("GMRC*3.0*113 post-install received a shutdown request")
 .S IEN12340=$O(^GMR(123,IEN123,40,0)) D:IEN12340?1.N
 ..K DA S DA=IEN12340,DA(1)=IEN123
 ..S DIK="^GMR(123,"_DA(1)_",40,",DIK(1)=".01^ASTATUS" D ENALL^DIK
 ..S NUMRECS=NUMRECS+1
 .H:'(NUMRECS#HANGRECS) HANGSECS
 K:'ZTSTOP ^GMR(123,"ASTATUS",0)
 S ZTREQ="@"
 I 'ZTSTOP D MSG("GMRC*3.0*113 - the background job has finished setting up the new index ""ASTATUS""")
 E  D
 .S X="GMRC*3.0*113 - the background job was stopped whilst adding records to the new index ""ASTATUS"". "
 .S X=X_"If you re-install the patch, it will continue where it left off."
 .D MSG(X)
 Q
 ;
MSG(SUB) ;create and send message
 N XMDUZ,XMSUB,XMZ,XMTEXT,XMY
 N IEN,A,B,C,LNCNT S (IEN,A,B,C)=0,LNCNT=1
 S XMY(DUZ)=""
 S XMDUZ=DUZ
 S XMSUB=SUB
 D XMZ^XMA2 ; call Create Message Module
 S XMTEXT="XMTEXT"
 S XMTEXT(1)="GMRC*3.0*113 post-install background job received a shutdown request"
 S XMTEXT(2)="- update of ""ASTATUS"" index aborted. if the patch is re-installed, the"
 S XMTEXT(3)="update to the index will continue at the Consult IEN where it left off"
 S XMTEXT(4)="in this run."
 D ENL^XMD
 D ENT1^XMD
 Q
 ;

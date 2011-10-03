GMRCYP42 ;ISP/TDP - PRE/POST INSTALL FOR GMRC*3*42; 3/9/2005
 ;;3.0;CONSULT/REQUEST TRACKING;**42**;DEC 27, 1997
ENV ;env check for service name conflict
 N GMRCMSG,GMRCSVC,I
 I $$PATCH^XPDUTL("GMRC*3.0*42") Q
 K ^TMP("GMRCYP42",$J)
 S GMRCSVC=0
 F  S GMRCSVC=$O(^GMR(123.5,GMRCSVC)) Q:'GMRCSVC  D
 . Q:'$D(^GMR(123.5,GMRCSVC,0))
 . D CHK1235($P(^GMR(123.5,GMRCSVC,0),U))
 I '$D(^TMP("GMRCYP42",$J)) D  Q
 . D BMES^XPDUTL("No conflicts with service being filed.")
 D WARNING(.GMRCMSG),MES^XPDUTL(.GMRCMSG)
 D BMES^XPDUTL(" ")
 S I=0 F  S I=$O(^TMP("GMRCYP42",$J,I)) Q:'I  D
 . D MES^XPDUTL(^TMP("GMRCYP42",$J,I,0))
 K ^TMP("GMRCYP42",$J)
 Q
CHK1235(SERVNM) ;check service name against exact or possible conflicts
 N X,Y
 S X=SERVNM
 X ^%ZOSF("UPPERCASE")
 I Y="CARE COORDINATION HOME TELEHEALTH SCREENING" D MSG(SERVNM,0) Q
 I Y["TELEHEALTH" D MSG(SERVNM,1) Q
 I Y["TELE HEALTH" D MSG(SERVNM,1) Q
 Q
MSG(TEXT,FLG) ;write install message if exact or partial match
 N MATCH,NEXT,MSG
 S MATCH=$S(+FLG:" partially ",1:" exactly ")
 S NEXT=$O(^TMP("GMRCYP42",$J,999),-1)+1
 S MSG=TEXT_MATCH_"matches the service being imported."
 S ^TMP("GMRCYP42",$J,NEXT,0)=MSG
 Q
WARNING(TXT) ;format warning statement for pre-install in case of conflicts
 S TXT(1)=$$FMTE^XLFDT($$NOW^XLFDT)
 S TXT(2)="This patch imports data for 1 service in the REQUEST SERVICES (#123.5) file."
 S TXT(3)="If the service does not exist in your file, it will be created as a new"
 S TXT(4)="entry. If the service does exist on your system, some fields of data will"
 S TXT(5)="be overwritten."
 ;S TXT(6)="(#1.01) PROVISIONAL DX PROMPT, (#1.02) PROVISIONAL DX INPUT, and "
 ;S TXT(7)="(#124) DEFAULT REASON FOR REQUEST. "
 S TXT(8)=" "
 S TXT(9)="Following this warning message, there will be one or more lines that "
 S TXT(10)="indicate that either an exact or partial match was found on your system."
 S TXT(11)="It is highly recommended that the install be aborted at this time until the"
 S TXT(12)="individual responsible for management of Consult/Request Tracking can "
 S TXT(13)="review and verify that these changes will not adversely affect operations"
 S TXT(14)="of the package."
 Q
 ;
PRE ; load service into REQUEST SERVICES (#123.5) file
 N I,SVC
 D BMES^XPDUTL("Adding CARE COORDINATION HOME TELEHEALTH SCREENING as a new consult")
 D MES^XPDUTL("   service in the REQUEST SERVICES (#123.5) file.")
 S SVC=$$FIND1^DIC(123.5,,"QX","CARE COORDINATION HOME TELEHEALTH SCREENING")
 I +SVC D EDIT(SVC)
 I '+SVC D ADD
 D BMES^XPDUTL("Pre-init complete.")
 Q
ADD ; add new REQUEST SERVICE
 N DEFAULT,DIC,DXI,DXP,INTERNAL,OERR,PRINT,PROTOCOL,X
 K DO
 S DIC="^GMR(123.5,"
 S DIC(0)="L"
 S X="CARE COORDINATION HOME TELEHEALTH SCREENING"
 S INTERNAL="CCHT SCREENING"
 S PRINT="CCHT SC"
 S DXP="O"
 S DXI="L"
 S DEFAULT="Initial Screening for Home Telehealth services."
 S PROTOCOL="GMRCACTM SERVICE ACTION MENU"
 S OERR="CONSULTS"
 S DIC("DR")="11////"_INTERNAL_";1.11////"_PRINT_";2////9;1.01////"_DXP_";1.02////"_DXI_";124///"_DEFAULT_";1.03////0;1.1///"_PRINT_"RN;123.03///"_PROTOCOL_";123.01///"_OERR
 D FILE^DICN
 I Y<0 D  Q
 . D BMES^XPDUTL("CARE COORDINATION HOME TELEHEALTH SCREENING failed to be added to the")
 . D MES^XPDUTL("   REQUEST SERVICES (#123.5) file.  Follow the instructions in the patch")
 . D MES^XPDUTL("   description for manually adding this service.")
 K Y
 Q
 ;
EDIT(SVIEN) ; edit existing REQUEST SERVICE
 N DA,DEFAULT,DIE,DR,DXI,DXP,INTERNAL,OERR,PRINT,PROTOCOL,X
 K DO
 S DA=SVIEN
 S DIE="^GMR(123.5,"
 S INTERNAL="CCHT SCREENING"
 S PRINT="CCHT SC"
 S DXP="O"
 S DXI="L"
 S DEFAULT="Initial Screening for Home Telehealth services."
 S PROTOCOL="GMRCACTM SERVICE ACTION MENU"
 S OERR="CONSULTS"
 S DR="11////"_INTERNAL_";1.11////"_PRINT_";2////9;1.01////"_DXP_";1.02////"_DXI_";124///"_DEFAULT_";1.03////0;I $D(^GMR(123.5,DA,2,""B"",""CCHT SCRN"")) S Y=123.03;1.1////"_PRINT_"RN;123.03///"_PROTOCOL_";123.01///"_OERR
 D ^DIE
 K Y
 Q
 ;
POST ; load services into SUB-SERVICE SPECIALTY of ALL SERVICES
 N SVC
 D BMES^XPDUTL("Adding CARE COORDINATION HOME TELEHEALTH SCREENING as a sub-service")
 D MES^XPDUTL("   to ALL SERVICES in the REQUEST SERVICES (#123.5) file.")
 S SVC=$$FIND1^DIC(123.5,,"QX","CARE COORDINATION HOME TELEHEALTH SCREENING") I +SVC D SUB(SVC)
 D BMES^XPDUTL("Post-init complete.")
 Q
SUB(SVIEN) ; add as sub of ALL SERVICES
 I $D(^GMR(123.5,"APC",SVIEN)) Q
 N DIC,DA,X
 K DO
 S DA(1)=1
 S DIC="^GMR(123.5,"_DA(1)_",10,"
 S DIC(0)="L"
 S X=SVIEN Q:'$L(X)
 D FILE^DICN
 I Y<0 D
 . D BMES^XPDUTL("CARE COORDINATION HOME TELEHEALTH SCREENING failed to be added as a")
 . D MES^XPDUTL("   sub-service to ALL SERVICES in the REQUEST SERVICES (#123.5) file.")
 . D MES^XPDUTL("   Follow the instructions in the patch description for manually adding")
 . D MES^XPDUTL("   this sub-service.")
 Q

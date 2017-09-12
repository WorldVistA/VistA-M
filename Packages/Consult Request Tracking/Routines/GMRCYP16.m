GMRCYP16 ;SLC/JFR - PRE/POST INSTALL FOR GMRC*3*16; 2/22/00 13:15
 ;;3.0;CONSULT/REQUEST TRACKING;**16**;DEC 27, 1997
ENV ;env check for service name conflict
 N GMRCSVC,I
 I $$PATCH^XPDUTL("GMRC*3.0*16") Q
 K ^TMP("GMRCYP16",$J)
 S GMRCSVC=0
 F  S GMRCSVC=$O(^GMR(123.5,GMRCSVC)) Q:'GMRCSVC  D
 . Q:'$D(^GMR(123.5,GMRCSVC,0))
 . D CHK1235($P(^GMR(123.5,GMRCSVC,0),U))
 I '$D(^TMP("GMRCYP16",$J)) D  Q
 . D BMES^XPDUTL("No conflicts with services being filed.")
 D WARNING(.GMRCMSG),MES^XPDUTL(.GMRCMSG)
 D BMES^XPDUTL(" ")
 S I=0 F  S I=$O(^TMP("GMRCYP16",$J,I)) Q:'I  D
 . D MES^XPDUTL(^TMP("GMRCYP16",$J,I,0))
 K ^TMP("GMRCYP16",$J)
 Q
CHK1235(SERVNM) ;check service name against exact or possible conflicts
 I SERVNM="CONTACT LENS REQUEST" D MSG(SERVNM,0) Q
 I SERVNM="HOME OXYGEN REQUEST" D MSG(SERVNM,0) Q
 I SERVNM="PROSTHETICS REQUEST" D MSG(SERVNM,0) Q
 I SERVNM="EYEGLASS REQUEST" D MSG(SERVNM,0) Q
 I SERVNM["LENS" D MSG(SERVNM,1) Q
 I SERVNM["OXYGEN" D MSG(SERVNM,1) Q
 I SERVNM["O2" D MSG(SERVNM,1) Q
 I SERVNM["PROSTHETICS" D MSG(SERVNM,1) Q
 I SERVNM["EYEGLASS"  D MSG(SERVNM,1) Q
 Q
MSG(TEXT,FLG) ;write install message if exact or partial match
 N MATCH,NEXT,MSG
 S MATCH=$S(+FLG:" partially ",1:" exactly ")
 S NEXT=$O(^TMP("GMRCYP16",$J,999),-1)+1
 S MSG=TEXT_MATCH_"matches one of the services being imported."
 S ^TMP("GMRCYP16",$J,NEXT,0)=MSG
 Q
WARNING(TXT) ;format warning statement for pre-install in case of conflicts
 S TXT(1)=$$FMTE^XLFDT($$NOW^XLFDT)
 S TXT(2)="This patch imports data for 4 services in the REQUEST SERVICES (#123.5) file."
 S TXT(3)="If the services do not exist in your file, they will be created as new"
 S TXT(4)="entries. If the services do exist on your system, certain fields of data will"
 S TXT(5)="be overwritten. The fields that will be overwritten are (#1.11) PRINT NAME,"
 S TXT(6)="(#1.01) PROVISIONAL DX PROMPT, (#1.02) PROVISIONAL DX INPUT, and "
 S TXT(7)="(#124) DEFAULT REASON FOR REQUEST. "
 S TXT(8)=" "
 S TXT(9)="Following this warning message, there will be one or more lines that "
 S TXT(10)="indicate that either an exact or partial match was found on your system."
 S TXT(11)="It is highly recommended that the install be aborted at this time until the"
 S TXT(12)="individual responsible for management of Consult/Request Tracking can "
 S TXT(13)="review and verify that these changes will not adversely affect operations"
 S TXT(14)="of the package."
 Q
 ;
 ;
POST ; load services into SUB-SERVICE SPECIALTY of ALL SERVICES
 N SVC
 S SVC=$$FIND1^DIC(123.5,,"QX","CONTACT LENS REQUEST") I +SVC D SUB(SVC)
 S SVC=$$FIND1^DIC(123.5,,"QX","HOME OXYGEN REQUEST") I +SVC D SUB(SVC)
 S SVC=$$FIND1^DIC(123.5,,"QX","EYEGLASS REQUEST") I +SVC D SUB(SVC)
 S SVC=$$FIND1^DIC(123.5,,"QX","PROSTHETICS REQUEST") I +SVC D SUB(SVC)
 Q
SUB(SVIEN) ; add as sub of ALL SERVICES
 I $D(^GMR(123.5,"APC",SVIEN)) Q
 N DIC,DA,X,Y
 S DA(1)=1
 S DIC="^GMR(123.5,"_DA(1)_",10,"
 S DIC(0)="XL"
 S X=$P(^GMR(123.5,SVIEN,0),U) Q:'$L(X)
 D ^DIC
 Q

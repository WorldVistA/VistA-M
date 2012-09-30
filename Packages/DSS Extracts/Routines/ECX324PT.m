ECX324PT ;ALB/JAP - PATCH ECX*3*24 Post-Install ; June 3, 1999
 ;;3.0;DSS EXTRACTS;**24**;Dec 22, 1997
 ;
POST ;Entry point
 N DIC,DIE,DA,DR,DINUM,X,Y,J,IEN,ECXX,DATA,NAME,FILE,FREQ,TYPE,HEAD,MAX,GRP,PIECE,ROU,XF
 ;inactivate fy99 clinic extract; record #2
 S XF=$P(^ECX(727.1,2,0),U,2)
 I XF'=727.803 D  Q
 .D MES^XPDUTL("   WARNING: Could not find FY1999 Clinic Visit Extract definition in")
 .D MES^XPDUTL("            File #727.1 in order to inactivate.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("            No further updates attempted.  Exiting...")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("            Please consult with NVS for DSS EXTRACTS support.")
 .D MES^XPDUTL(" ")
 S DIE="^ECX(727.1,",DA=2,HEAD="ZZZ",TYPE="Clinic/Inactive",DR="7///^S X=TYPE;8///^S X=HEAD" D ^DIE
 D MES^XPDUTL("OK... Clinic Visit Extract (CLI) for FY1999 has been inactivated.")
 D MES^XPDUTL(" ")
 ;update file #727.1 with new record data
 D MES^XPDUTL("Updating EXTRACT DEFINITIONS file (#727.1) with new extract")
 D MES^XPDUTL("definitions...")
 D MES^XPDUTL(" ")
 F J=1:1 S ECXX=$P($T(TEXT+J),";;",2) Q:ECXX="QUIT"  D
 .K DD,DO
 .S IEN=$P(ECXX,";",1),DATA=$P(ECXX,";",2),NAME=$P(DATA,U,1)
 .S FILE=$P(DATA,U,2),FREQ=$P(DATA,U,3),TYPE=$P(DATA,U,7),HEAD=$P(DATA,U,8)
 .S GRP=$P(DATA,U,9),PIECE=$P(DATA,U,10),MAX=$P(DATA,U,11),ROU=$P(DATA,U,12)
 .K X,Y S DIC="^ECX(727.1,",DIC(0)="L",X=NAME,DINUM=IEN
 .S DIC("DR")="1///"_FILE_";2///"_FREQ_";7///"_TYPE_";8///"_HEAD_";9///"_GRP_";11///"_PIECE_";12///"_MAX_";4///"_ROU
 .D FILE^DICN
 .I Y=-1 D  Q
 ..I $D(^ECX(727.1,IEN)),$O(^ECX(727.1,"AF",FILE,0))=IEN D  Q
 ...D MES^XPDUTL("   Entry #"_IEN_" for "_NAME_" extract already exists.")
 ...D MES^XPDUTL(" ")
 ..D MES^XPDUTL("   WARNING: Could not update entry #"_IEN_" for "_NAME_" extract.")
 ..D MES^XPDUTL("            Please consult with NVS for DSS EXTRACTS support.")
 ..D MES^XPDUTL(" ")
 .D MES^XPDUTL("   Setting record #"_IEN_" for the "_NAME_" extract... ok.")
 .D MES^XPDUTL(" ")
 ;set audit description for mental health
 I '$D(^ECX(727.1,11,1)) D
 .K DIE,DIC,DR,DA
 .F J=1:1 S ECXX=$P($T(MTL+J),";;",2) Q:ECXX="QUIT"  S ^TMP($J,"WP",J)=ECXX
 .D WP^DIE(727.1,"11,",10,,"^TMP($J,""WP"")")
 .K ^TMP($J,"WP")
 ;set all frequency fields to "m" in file #727.1
 S J=0 F  S J=$O(^ECX(727.1,J)) Q:'J  D
 .S $P(^ECX(727.1,J,0),U,3)="M",$P(^(0),U,4)="",$P(^(0),U,5)="",$P(^(0),U,6)=""
 ;set entries in file #727.5
 D EN^ECX324MH
 D OPT
 D ADD7272
 Q
 ;
TEXT ;data for file #727.1 records
 ;;11;MENTAL HEALTH^727.812^M^^^^Mental Health^MTL^MTL^24^200^ECXMTL
 ;;21;CLINIC I^727.816^M^^^^Clinic^CLI^SCX^25^200^ECXSCXN
 ;;22;CLINIC II^727.818^M^^^^Clinic II^CLJ^SCX^26^200^ECXSCXN
 ;;QUIT
 ;
OPT ;place option back in-service
 N OPT,DIC,DIE,DA,DR,X,Y
 S DIC="^DIC(19,",DIC(0)="XO",X="ECXDEFINE"
 D ^DIC
 S OPT=+Y
 Q:OPT<1
 S DIE=DIC,DA=OPT,DR="2///^S X=""@"""
 D ^DIE
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("   Setting option ECXDEFINE back in-service... ok.")
 D MES^XPDUTL(" ")
 Q
 ;
MTL ;audit description for mental health
 ;;Verify against: Usage Statistics, Site Report by Date
 ;;Menu Option:    Usage Statistics [YSMUSE], Site Report by Date [YSAS 
 ;;                MANAGEMENT REPORT]
 ;;  
 ;;The 'Usage Statistics' report in the MENTAL HEALTH VistA software should be 
 ;;used to verify the Psych instrument segment of the DSS MTL Extract Audit
 ;;report.  It must be noted that the Usage report is produced based on month 
 ;;and year, the days are ignored.
 ;;  
 ;;The 'Site Report by Date' should be used to verify the ASI segment on the
 ;;DSS MTL Extract Audit Report.  It is possible that the figures on the DSS
 ;;MTL report may be higher than those on the Site Report.  The reason being
 ;;that the MENTAL HEALTH 'Site Report' does not currently display test that
 ;;are inactive.  The DSS MTL Extract Audit Report will report both active
 ;;and inactive tests performed during a specified date range.
 ;;  
 ;;Currently, there is no report in the MENTAL HEALTH VistA package to verify
 ;;the GAF segment on the DSS MTL Extract Audit Report. However, the general
 ;;format seen in the MENTAL HEALTH VistA, Print GAF's by Clinic/Date [YSGAF
 ;;PRINT CLINIC] is being followed.
 ;;QUIT
 ;
ADD7272 ;add entries to file #727.2
 ;ECXX is in format: ien;test^source
 N ECX,ECXX,DA,DIC,DINUM,DIE,DR,X,Y,TEST,SOURCE,CNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LAB TESTS File (#727.2)...")
 D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)="",CNT=0
 F ECX=1:1 S ECXX=$P($T(NEW7272+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=$P(ECXX,";",1),ECXX=$P(ECXX,";",2)
 .Q:'$D(^ECX(727.2,1))
 .I $D(^ECX(727.2,1,1,0)),'$D(^ECX(727.2,1,1,ECXDA,0)) D
 ..S CNT=CNT+1
 ..S TEST=$P(ECXX,U,1),SOURCE=$P(ECXX,U,2)
 ..S DA(1)=1,DIC("P")=$P(^DD(727.2,1,0),U,2),DINUM=ECXDA
 ..S X=TEST,DIC="^ECX(727.2,1,1,",DLAYGO=727.21,DIC(0)="LX",DIC("DR")="2///^S X=SOURCE"
 ..K DD,DO D FILE^DICN K DLAYGO
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("    Adding "_TEST_" as entry #"_ECXDA_"... ok.")
 ..D MES^XPDUTL(" ")
 I CNT=0 D
 .D MES^XPDUTL("    Entries already exist -- nothing added.")
 .D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)="K X"
 Q
 ;
NEW7272 ;new records for file #727.2
 ;;32;MICROALBUMIN^U
 ;;33;HEPATITIS B SURFACE ANTIBODY^B
 ;;34;HEPATITIS C ANTIBODY^B
 ;;35;HIV ANTIBODY^B
 ;;36;CD4 RATIO (T CELL SCREEN)^B
 ;;37;HCV-QUANTITATIVE BY PCR^B
 ;;38;HIV VIRAL LOAD^B
 ;;39;HCV-QUALITATIVE BY PCR^B
 ;;40;HIV 1 BY EIA^B
 ;;QUIT

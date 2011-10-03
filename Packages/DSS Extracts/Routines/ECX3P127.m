ECX3P127 ;ALB/MRY - DSS FY2011 Conversion, Post-init ;11/23/10  13:37
 ;;3.0;DSS EXTRACTS;**127**;Dec 22, 1997;Build 36
 ;
 ;****************************************
 ;Every year: Populate FY Year's version
 ; TESTON^ECXTREX(XPDNM,"FY2011")
 ;****************************************
 ;
PRE ;Pre-install tasks
 ;Delete file 727.833 so that we start with a fresh data dictionary install
 N DIU
 S DIU=727.833,DIU(0)="D" ;D denotes that we're deleting data as well
 D EN^DIU2
 Q
POST ;post-init
 D TEST,MENU,EXTR,INACT
 N ECXI,ECXDTS,ECXOTS
 ;remove treating specialties from file 737.831
 F ECXI=1:1 S ECXDTS=$P($T(DTSP+ECXI),";;",2) Q:ECXDTS="QUIT"  D
 .D DTS
 ;add treating specialties into file 737.831
 F ECXI=1:1 S ECXOTS=$P($T(OTSP+ECXI),";;",2) Q:ECXOTS="QUIT"  D
 .D OTS
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2011")
 ;D MES^XPDUTL(" ")
 ;D MES^XPDUTL("Remember to assign the ECX DSS TEST key to qualified users.")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 ;
 ;initialize new field #  in file #728.44;
 N EC,ECD,X
 S EC=0 F  S EC=$O(^SC(EC)) Q:'EC  D
 .I $D(^SC(EC,0)) S ECD=^(0) I $P(ECD,U,3)="C" D
 ..S X=$P(ECD,U,17) I X'="" I $D(^ECX(728.44,EC,0)) S $P(^ECX(728.44,EC,0),U,12)=X
 Q
 ;
MENU ;Remove options from menu and place out of order, add new menu option for BCM
 N MENU,OPTION,CHECK,IEN
 F OPTION="ECXMTL","ECXPAI" D
 .S MENU="ECXMENU"
 .S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 .D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 F OPTION="ECX MTL SOURCE AUDIT","ECX PAI SOURCE AUDIT" D
 .S MENU="ECX SOURCE AUDITS"
 .S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 .D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 S OPTION="ECX DIVISION ID",MENU="ECX DSSDEPT MGMT"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES  NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 S CHECK=$$ADD^XPDMENU("ECXMENU","ECXBCM","BCM")
 D BMES^XPDUTL("ECXBCM option "_$S('+$G(CHECK):"NOT ",1:"")_"added to menu ECXMENU")
 Q
 ;
EXTR ;; ADD NEW EXTRACT TO EXTRACT DEFINITIONS FILE 727.1
 N DIC,DINUM,X,Y,J,IEN,ECXX,DATA,NAME,FILE,FREQ,TYPE,HEAD,MAX,GRP,PIECE,ROU,STATUS
 ;update file #727.1 with new record data
 D MES^XPDUTL("Updating EXTRACT DEFINITIONS file (#727.1) with new extract")
 D MES^XPDUTL("definitions...")
 D MES^XPDUTL(" ")
 F J=1:1 S ECXX=$P($T(TEXT+J),";;",2) Q:ECXX="QUIT"  D
 .K DD,DO
 .S IEN=$P(ECXX,";",1),DATA=$P(ECXX,";",2),NAME=$P(DATA,U,1)
 .S FILE=$P(DATA,U,2),FREQ=$P(DATA,U,3),TYPE=$P(DATA,U,7),HEAD=$P(DATA,U,8)
 .S GRP=$P(DATA,U,9),PIECE=$P(DATA,U,10),MAX=$P(DATA,U,11),ROU=$P(DATA,U,12),STATUS=$P(DATA,U,13)
 .I $D(^ECX(727.1,IEN)),$O(^ECX(727.1,"AF",FILE,0))'=IEN S DIK="^ECX(727.1,",DA=IEN D ^DIK
 .K X,Y S DIC="^ECX(727.1,",DIC(0)="L",X=NAME,DINUM=IEN
 .S DIC("DR")="1///"_FILE_";2///"_FREQ_";7///"_TYPE_";8///"_HEAD_";9///"_GRP_";11///"_PIECE_";12///"_MAX_";13///"_STATUS_";4///"_ROU
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
 K DD,DO
 Q
DTS ;Delete Treating Specialties from file 727.831
 N DIK,DINUM,DA
 S DINUM=$P(ECXDTS,U),DA=0
 S DIK="^ECX(727.831,"
 S DA=$O(^ECX(727.831,"B",DINUM,DA)) Q:'DA  D ^DIK
 D BMES^XPDUTL(">>>"_$P(ECXDTS,U,2)_">>>")
 D MES^XPDUTL("...removed from DSS TREATING SPECIALTY TRANSLATION File (#727.831)")
 Q
 ;
OTS ;Add Observation Treating Specialty to DSS TREATING SPECIALTY TRANSLATION File (#727.831)
 D BMES^XPDUTL(">>>"_$P(ECXOTS,U,2)_">>>")
 N DA,ECXFILE,DIC,DIE,DINUM,DLAYGO,DR,X,Y,ECXIFN
 S ECXERR=0
 S DIC="^ECX(727.831,"
 S DIC(0)="LX"
 S DINUM=$P(ECXOTS,U)
 S X=$P(ECXOTS,U,2)
 S DLAYGO=727.831
 D ^DIC
 S ECXIFN=Y
 I +ECXIFN=-1 D  Q
 .D MES^XPDUTL("     Entry not added to DSS TREATING SPECIALTY TRANSLATION File (#727.831).  No further updating will occur.")
 .D MES^XPDUTL("     Please contact Customer Service for assistance.")
 .Q
 I $P(ECXIFN,U,3)'=1&(+ECXIFN'=$P(ECXOTS,U)) D  Q
 .D MES^XPDUTL("     Entry exists in DSS TREATING SPECIALTY TRANSLATION File (#727.831), but with a different Treating Specialty.")
 .D MES^XPDUTL("     No further updating will occur.  Please review entry.")
 .S ECXERR=1
 .Q 
 D MES^XPDUTL("     Entry "_$S($P(ECXIFN,U,3)=1:"added to",1:"exists in")_" DSS TREATING SPECIALTY TRANSLATION File (#727.831).")
 D MES^XPDUTL("     Updating DSS TREATING SPECIALTY TRANSLATION File fields.")
 S DIE=DIC
 S DR="2///"_$P(ECXOTS,U,3)_";3///"_$P(ECXOTS,U,4)_";4///"_$P(ECXOTS,U,5)_";5///"_$P(ECXOTS,U,6)
 S DA=+ECXIFN
 D ^DIE
 Q
INACT ;inactivate MTL and PAI in EXTRACT DEFINITION file (#727.1)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXHDR,ECXOFF
 D MES^XPDUTL("   Inactivating MTL,PAS,DEN AND BCM entries ...")
 F ECXOFF=1:1 S ECXHDR=$P($T(HDRS+ECXOFF),";;",2) Q:ECXHDR=""  D
 .S ECXDA=+$O(^ECX(727.1,"C",ECXHDR,0))
 .I 'ECXDA D  Q
 ..K ECXMSG
 ..S ECXMSG(1)=" "
 ..S ECXMSG(2)="   ** ERROR INACTIVATING "_ECXHDR_" **"
 ..S ECXMSG(3)="      Entry not found in file"
 ..D MES^XPDUTL(.ECXMSG)
 .K ECXFDA,ECXERR
 .S ECXFDA(727.1,ECXDA_",",13)=1
 .D FILE^DIE("","ECXFDA","ECXERR")
 .Q:'$D(ECXERR)
 .D BMES^XPDUTL("   ** ERROR INACTIVING "_ECXHDR_" **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;
OTSP ;;Treating Specialty #^Treating Specialty Name^DOM/PRRTP/SARRTP Code^IN/OUT Code^Observation Pat Indicator^Inpat Outpat Code^
 ;;109^PSYCH RESID REHAB PROG^P^3^N^I
 ;;110^PTSD RESID REHAB PROG^T^3^N^I
 ;;111^SUBSTANCE ABUSE RESID PROG^S^3^N^I
 ;;QUIT
 Q
DTSP ;;Treating Specialty #^Treating Specialty Name
 ;;25^PSYCH RESID REHAB TRMT PROG
 ;;26^PTSD RESIDENTIAL REHAB PROG
 ;;27^SUBSTANCE ABUSE RES TRMT PROG
 ;;28^HOMELESS CWT/TRANS RESID
 ;;29^SUBST ABUSE CWT/TRANS RESID
 ;;36^BLIND REHAB OBSERVATION
 ;;38^PTSD CWT/TR
 ;;QUIT
 Q
TEXT ;;EXTRACT DEFINITIONS ^IEN;DESCRIPTION^FILE #^FREQUENCY^^^^AUDIT DESCRIPTION^GROUP^HEADER^PIECE^MAX LINES^ROUTINE
 ;;24;BAR CODE MEDICATION ADMINISTRATION^727.833^M^^^^BAR CODE MEDICATION ADM^BCM^BCM^27^200^ECXBCM^1
 ;;QUIT
 Q
HDRS ;List of headers to be inactivated
 ;;MTL
 ;;PAS
 ;;DEN
 ;;BCM
 ;;
 Q

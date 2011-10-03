ECX3P120 ;ALB/JAP - DSS FY2010 Conversion, Post-init ; 6/18/09 9:51am
 ;;3.0;DSS EXTRACTS;**120**;Dec 22, 1997;Build 43
 ;
 ;****************************************
 ;Every year: Populate FY Year's version
 ; TESTON^ECXTREX(XPDNM,"FY2010")
 ;****************************************
 ;
POST ;post-init
 D TEST,OPT
 N ECXI
 ;add observation treating specialty
TS F ECXI=1:1 S ECXOTS=$P($T(OTSP+ECXI),";;",2) Q:ECXOTS="QUIT"  D
 .D OTS
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2010")
 ;D MES^XPDUTL(" ")
 ;D MES^XPDUTL("Remember to assign the ECX DSS TEST key to qualified users.")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option;
 ;
 ;initialize new field #  in file #728.44;
 N EC,ECD,X
 S EC=0 F  S EC=$O(^SC(EC)) Q:'EC  D
 .I $D(^SC(EC,0)) S ECD=^(0) I $P(ECD,U,3)="C" D
 ..S X=$P(ECD,U,17) I X'="" I $D(^ECX(728.44,EC,0)) S $P(^ECX(728.44,EC,0),U,12)=X
 Q
OPT ;delete ECX LBB SOURCE AUDIT from ECX SOURCE AUDITS
 ;
 D MES^XPDUTL("...Cleaning up ECX SOURCE AUDITS menu")
 N DIC,Y
 S DIC="^DIC(19,",DIC(0)="MBX",X="ECX SOURCE AUDITS" D ^DIC Q:+Y<0
 S DA(1)=+Y
 S DIC="^DIC(19,"_DA(1)_",10,",DIC(0)="MBX",X="ECX LBB SOURCE AUDIT" D ^DIC Q:+Y<0
 S DA=+Y
 S DIK="^DIC(19,"_DA(1)_",10," D ^DIK
 Q
OTS ;Add Observation Treating Specialty to DSS TREATING SPECIALTY TRANSLATION File (#727.831)
 D BMES^XPDUTL(">>>"_$P(ECXOTS,U,2)_">>>")
 N DA,ECXFILE,DIC,DIE,DINUM,DLAYGO,DR,X,Y
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
 S DR="4///"_$P(ECXOTS,U,3)_";5///"_$P(ECXOTS,U,4)_";6///"_$P(ECXOTS,U,5)
 S DA=+ECXIFN
 D ^DIE
 Q
OTSP ;Treating Specialty #^Treating Specialty Name^Observation Pat Indicator^Inpat Outpat Code^Observation Stop Code
 ;;108^ED OBSERVATION^Y^O^297
 ;;QUIT
 Q

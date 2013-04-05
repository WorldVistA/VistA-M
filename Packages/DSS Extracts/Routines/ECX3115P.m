ECX3115P ;ALB/MRY -Populate DSS LOINC Code file Post-Init Rtn; 02/10/09
 ;;3.0;DSS EXTRACTS;**115**;Dec 22,1997;Build 3
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
POST ;
 ;Seed new LOINC Codes
 D ADDLNC
 ;Remove LOINC Codes
 D DELLNC
 Q
 ;
ADDLNC ;Add LOINC Codes
 N ECXLINE,ECXSTR,ECXDA,CNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LOINC CODES File (#727.29)...")
 D MES^XPDUTL(" ")
 S CNT=0
 N DIC,DIE,DA,DLAYGO,DR,X,Y,ECXLINE,ECXSTR,ECXDN,ECXDTN,ECXLN,ECXDRU
 S DIC="^ECX(727.29,",DIC(0)="L",DLAYGO=727.29
 F ECXLINE=1:1 S ECXSTR=$P($T(ALOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 . S X=$P(ECXSTR,"^") ;I $$GET1^DIQ(95.3,X,.01,"I")'=X Q
 . D ^DIC I Y<0 D  Q
 .. D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Unsuccessful entry of LOINC Code - "_X_".")
 .. D MES^XPDUTL("******")
 . S CNT=CNT+1
 . S ECXDN=$P(ECXSTR,"^",2)
 . S ECXDTN=$P(ECXSTR,"^",3)
 . S ECXLN=$P(ECXSTR,"^",4)
 . S ECXDRU=$P(ECXSTR,"^",5)
 . S DA=+Y,DR=".02///"_ECXDN_";.03///"_ECXDTN_";.04///"_ECXDRU_";.05///"_ECXLN
 . S DIE=DIC D ^DIE
 K DA,DIC,DIE,DLAYGO,X,Y
 S DIK="^ECX(727.29,",DIK(1)=".02^AC" D ENALL^DIK
 K DIK
 Q
 ;
ALOINC ;LOINC Codes (add)
 ;;2947-0^0003^Sodium (Serum)^Sodium Bld-sCnc^MEQ/L or MMOL/L
 ;;1558-6^0010^Glucose (Serum)^Glucose p fast SerPl-mCnc^MG/DL
 ;;24467-3^0020^CD-4 (Absolute T Cell Count)^CD3+CD4+ Cells # Bld^CELLS/MM3, CELLS/UL
 ;;21008-8^0038^HIV Viral Load^HIV1 RNA # SerPl Prb^COPIES/ML
 ;;29539-4^0038^HIV Viral Load^HIV Log Viral Load Plas Bdna^COPIES/ML
 ;;21333-0^0038^HIV Viral Load^HIV1 RNA # Ser^COPIES/ML
 ;;20570-8^0050^Hematocrit^Hct % Bld^%
 ;;2340-8^0057^Glucose POC^Glucose Bld Test Str Auto-mCnc^MG/DL
 ;;32016-8^0057^Glucose POC^Glucose BldC-mCnc^MG/DL
 ;;15152-2^0060^Bilirubin (Direct)^Bilirub Conj SerPl-mCnc^MG/DL
 ;;20564-1^0068^O2 Saturation^O2 Saturation^%
 ;;EXIT
 Q
 ;
DELLNC ;Remove LOINC Codes
 N LOINC,ENTRY,DA,DIK
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Removing entries to DSS LOINC CODES File (#727.29)...")
 D MES^XPDUTL(" ")
 S CNT=0
 ;
 F LOINC="3719-2","5222-5","14152-3" S ENTRY=+$O(^ECX(727.29,"B",LOINC,0)) I ENTRY D
 . S DA=ENTRY,DIK="^ECX(727.29," D ^DIK
 Q

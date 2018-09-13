ECX134PT ;ALB/BP - ECX*3.0*134 Post-Init Rtn; 02/10/09
 ;;3.0;DSS EXTRACTS;**134**;Dec 22,1997;Build 5
 ;
 Q
POST ;
 ;Remove LOINC Codes
 D DELLNC
 ;Seed new LOINC Codes
 D ADDLNC
 Q
 ;
DELLNC ;Remove LOINC Codes
 N LOINC,ENTRY,DA,DIK,ECXTN
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Removing entries to DSS LOINC CODES File (#727.29)...")
 D MES^XPDUTL(" ")
 ;
 F LOINC="29893-5","14092-1" S ENTRY=+$O(^ECX(727.29,"B",LOINC,0)) I ENTRY D
 .S ECXTN=$$GET1^DIQ(727.29,ENTRY,".03")
 .I ECXTN'="HIV Confirmatory Test" D  Q
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL(" Code "_LOINC_" not deleted from file")
 ..D MES^XPDUTL(" Patch may already have been installed, please verify ")
 ..D MES^XPDUTL(" ")
 .S DA=ENTRY,DIK="^ECX(727.29," D ^DIK
 Q
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
 . S X=$P(ECXSTR,"^",1)
 . D ^DIC I Y<0 D  Q
 .. D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Unsuccessful entry of LOINC Code - "_X_".")
 .. D MES^XPDUTL("******")
 . S CNT=CNT+1
 . S ECXDN=$P(ECXSTR,"^",2)
 . S ECXDTN=$P(ECXSTR,"^",3)
 . S ECXDRU=$P(ECXSTR,"^",4)
 . S ECXLN=$P(ECXSTR,"^",5)
 . S DA=+Y,DR=".02///"_ECXDN_";.03///"_ECXDTN_";.04///"_ECXDRU_";.05///"_ECXLN
 . S DIE=DIC D ^DIE
 K DA,DIC,DIE,DLAYGO,X,Y
 S DIK="^ECX(727.29,",DIK(1)=".02^AC" D ENALL^DIK
 K DIK
 Q
 ;
ALOINC ;LOINC CODE^LAR TEST #^DSS TEST NAME^REPORTING UNITS^LOINC NAME
 ;;57006-9^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV IgG Ser EIA-aCnc
 ;;29893-5^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Ser Ql EIA
 ;;14092-1^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Ser Ql IF
 ;;42768-2^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 & 2 Ab Ser-Imp
 ;;56888-1^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1+2 Ab+HIV1 p24 Ag Ser Ql EIA
 ;;58900-2^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1+2 Ab+HIV1 p24 Ag Ser EIA-aCnc
 ;;54218-3^0036^CD4/CD8 Ratio (T Cell Screen)^%^CD3+CD4+ Cells/CD3+CD8+ Cells Bld
 ;;25835-0^0038^HIV Viral Load^COPIES/ML^HIV1 RNA SerPl Ql PCR
 ;;41513-3^0038^HIV Viral Load^COPIES/ML^HIV1 RNA # SerPl Amp Prb DL=400
 ;;41515-8^0038^HIV Viral Load^COPIES/ML^HIV1 RNA # SerPl Amp Prb DL=75
 ;;5017-9^0038^HIV Viral Load^COPIES/ML^HIV1 RNA Bld Ql PCR
 ;;59419-2^0038^HIV Viral Load^COPIES/ML^HIV1 RNA # Plas bDNA
 ;;47358-7^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser Donr Ql EIA
 ;;32178-6^0047^Hepatitis B e AG^NEG-POS/NON-REAC-REAC^HBV e Ag Titr Ser
 ;;4537-7^0090^Erythrocyte Sedimentation Rate^MM/HR^ESR Bld Qn Westrgrn
 ;;30341-2^0090^Erythrocyte Sedimentation Rate^MM/HR^ESR Bld Qn
 ;;11572-5^0091^Rheumatoid Factor^IU/ML^RF Ser-aCnc
 ;;6928-6^0091^Rheumatoid Factor^IU/ML^Rheumatoid fact Ser EIA-aCnc
 ;;15205-8^0091^Rheumatoid Factor^IU/ML^Rheumatoid fact Ser Neph-aCnc
 ;;EXIT
 Q
 ;

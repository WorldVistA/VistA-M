ECX3129P ;ALB/BP - ECX*3.0*129 Post-Init Rtn; 02/10/09
 ;;3.0;DSS EXTRACTS;**129**;Dec 22,1997;Build 8
 ;
POST ;
 ;Rename DSS Test Names for some LOINC Codes
 D RNMLNC
 ;Remove LOINC Codes
 D DELLNC
 ;Seed new LOINC Codes
 D ADDLNC
 Q
 ;
RNMLNC ;Rename DSS Test Names for LOINC Codes
 N LOINC,ECXDTN,ECXLINE,ECXSTR,ECXIEN
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Updating DSS Test Names... ")
 D MES^XPDUTL(" ")
 F ECXLINE=1:1 S ECXSTR=$P($T(RLOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 . S LOINC=$P(ECXSTR,"^",1)
 . S ECXIEN=+$O(^ECX(727.29,"B",LOINC,0))
 . S ECXDTN=$P(ECXSTR,"^",2)
 . I ECXIEN D
 .. N DIE,DA,DR
 .. S DIE="^ECX(727.29,",DA=ECXIEN,DR=".03///"_ECXDTN
 .. D ^DIE
 Q
RLOINC ; LOINC CODE^DSS TEST NAME
 ;;30361-0^HIV Screening Antibody
 ;;31201-7^HIV Screening Antibody
 ;;7917-8^HIV Screening Antibody
 ;;7918-6^HIV Screening Antibody
 ;;7919-4^HIV Screening Antibody
 ;;29893-5^HIV Confirmatory Test
 ;;EXIT
 Q
DELLNC ;Remove LOINC Codes
 N LOINC,ENTRY,DA,DIK,ECXTN
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Removing entries to DSS LOINC CODES File (#727.29)...")
 D MES^XPDUTL(" ")
 ;
 F LOINC="5199-5","44873-8","5221-7","5225-8","14092-1" S ENTRY=+$O(^ECX(727.29,"B",LOINC,0)) I ENTRY D
 .S ECXTN=$$GET1^DIQ(727.29,ENTRY,".03")
 .I LOINC="5199-5",ECXTN'="Hepatitis C Antibody" D  Q
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL(" Code "_LOINC_" not deleted from file")
 ..D MES^XPDUTL(" Patch may already have been installed, please verify ")
 ..D MES^XPDUTL(" ")
 .I LOINC'="5199-5",ECXTN'="HIV Antibody" D  Q
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
 ;;48070-7^0033^Hepatitis B Surface Antibody^NEG-POS/NON-REAC-REAC^HBV surface IgG Ser Ql EIA
 ;;49177-9^0033^Hepatitis B Surface Antibody^NEG-POS/NON-REAC-REAC^HBV surface IgG Ser Ql
 ;;16129-9^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV IgG Ser Ql
 ;;22327-1^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV Ab Ser-aCnc
 ;;5198-7^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV Ab Ser EIA-aCnc
 ;;16936-7^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV IgG Ser-aCnc
 ;;40726-2^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV IgG Ser Ql EIA
 ;;47365-2^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV Ab Ser Donr Ql EIA
 ;;47441-1^0034^Hepatitis C Antibody^NEG-POS/NON-REAC-REAC^HCV Ab Ser Donr Ql
 ;;16975-5^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 IgG Ser Ql
 ;;21007-0^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Ser Donr Ql
 ;;29327-4^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Fld Ql
 ;;33807-9^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV2 IgG Ser Ql
 ;;33866-5^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab BldC Ql EIA
 ;;34591-8^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Fld Ql EIA
 ;;35437-3^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Saliva Ql EIA
 ;;40733-8^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 IgG Ser Ql EIA
 ;;41144-7^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab Saliva Ql
 ;;41145-4^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab BldC Ql
 ;;43010-8^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 Ab XXX Ql
 ;;42600-7^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 Ab XXX Ql EIA
 ;;43009-0^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 IgG Ser Ql
 ;;44533-8^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 Ab Ser Donr Ql
 ;;44607-0^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ser EIA-Imp
 ;;49580-4^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 Ab XXX Ql Rapid
 ;;49905-3^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab XXX Ql Rapid
 ;;53379-4^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 Ab XXX Ql
 ;;54086-4^0035^HIV Screening Antibody^NEG-POS/NON-REAC-REAC^HIV1 +2 IgG Bld.Dot Ql
 ;;10676-5^0037^HCV Quantitative by PCR^IU/ML^HCV RNA SerPl Amp Prb-aCnc
 ;;20416-4^0037^HCV Quantitative by PCR^IU/ML^HCV RNA # SerPl PCR
 ;;20571-6^0037^HCV Quantitative by PCR^IU/ML^HCV RNA # SerPl bDNA
 ;;49758-6^0037^HCV Quantitative by PCR^IU/ML^HCV RNA SerPl PCR DL=5-aCnc
 ;;50023-1^0037^HCV Quantitative by PCR^IU/ML^HCV RNA Pnl SerPl PCR
 ;;10351-5^0038^HIV Viral Load^COPIES/ML^HIV1 RNA SerPl Amp Prb-aCnc
 ;;24013-5^0038^HIV Viral Load^COPIES/ML^HIV1 RNA Ser-Imp
 ;;25836-8^0038^HIV Viral Load^COPIES/ML^HIV1 RNA # XXX PCR
 ;;5010-4^0039^HCV Qualitative by PCR^NEG-POS^HCV RNA Bld Ql PCR
 ;;14092-1^0040^HIV Confirmatory Test^NEG-POS^HIV1 Ab Ser Ql IF
 ;;13499-9^0040^HIV Confirmatory Test^NEG-POS^HIV1 Ab Patrn Ser IB-Imp
 ;;31073-0^0040^HIV Confirmatory Test^NEG-POS^HIV2 Ab Patrn Ser IB-Imp
 ;;32571-2^0040^HIV Confirmatory Test^NEG-POS^HIV1 Ab Ur Ql IB
 ;;33806-1^0040^HIV Confirmatory Test^NEG-POS^HIV2 IgG Ser Ql IB
 ;;34592-6^0040^HIV Confirmatory Test^NEG-POS^HIV1 Ab Fld Ql IB
 ;;35439-9^0040^HIV Confirmatory Test^NEG-POS^HIV1 Ab Saliva Ql IB
 ;;40732-0^0040^HIV Confirmatory Test^NEG-POS^HIV1 IgG Ser Ql IB
 ;;43185-8^0040^HIV Confirmatory Test^NEG-POS^HIV 1 & 2 Ab Patrn Ser IB-Imp
 ;;44873-8^0040^HIV Confirmatory Test^NEG-POS^HIV1 +2 Ab Ser Ql IB
 ;;5221-7^0040^HIV Confirmatory Test^NEG-POS^HIV1 Ab Ser Ql IB
 ;;5225-8^0040^HIV Confirmatory Test^NEG-POS^HIV2 Ab Ser Ql IB
 ;;22312-3^0041^Hepatitis A AB^NEG-POS^Hep A Ab Ser-aCnc
 ;;5183-9^0041^Hepatitis A AB^NEG-POS^Hep A AB Ser EIA-aCnc
 ;;5184-7^0041^Hepatitis A AB^NEG-POS^Hep A AB Ser RIA-aCnc
 ;;53776-1^0041^Hepatitis A AB^NEG-POS^HAV IgM+total Ser-Imp
 ;;5181-3^0042^Hepatitis A IgM AB^NEG-POS^Hep A IgM ser EIA-aCnc
 ;;32685-0^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core IgG Ser Ql
 ;;22316-4^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser-aCnc
 ;;5187-0^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser EIA-aCnc
 ;;47440-3^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser Donr Ql
 ;;40725-4^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core IgG Ser Ql EIA
 ;;51914-0^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core IgG+IgM Ser Ql
 ;;13919-6^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core IgG Ser EIA-aCnc
 ;;21005-4^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser Donr EIA-aCnc
 ;;22317-2^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser Donr-aCnc
 ;;22318-0^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core IgG Ser-aCnc
 ;;5188-8^0046^Hepatitis B Core AB^NEG-POS/NON-REAC-REAC^HBV core Ab Ser RIA-aCnc
 ;;29771-3^0055^Occult Blood, Fecal^NEG-POS^Occult Bld Stl Ql Imm
 ;;57905-2^0055^Occult Blood, Fecal^NEG-POS^Occult Bld sp1 Stl Ql Imm
 ;;56490-6^0055^Occult Blood, Fecal^NEG-POS^Occult Bld sp2 Stl Ql Imm
 ;;56491-4^0055^Occult Blood, Fecal^NEG-POS^Occult Bld sp3 Stl Ql Imm
 ;;26515-7^0077^Platelet Count^COUNT/VOLUME OR K/MM3^Platelet # Bld
 ;;777-3^0077^Platelet Count^COUNT/VOLUME OR K/MM3^Platelet # Bld Auto
 ;;5907-1^0077^Platelet Count^COUNT/VOLUME OR K/MM3^Deprecated Platelet # Bld Auto
 ;;14723-1^0078^Ferritin^NL/ML OR UG/L OR MOL/L OR NMOL/ML^Ferritin Ser-sCnc
 ;;2276-4^0078^Ferritin^NL/ML OR UG/L OR MOL/L OR NMOL/ML^Ferritin Ser-mCnc
 ;;24373-3^0078^Ferritin^NL/ML OR UG/L OR MOL/L OR NMOL/ML^Ferritin Bld-mCnc
 ;;20567-4^0078^Ferritin^nl/NL/ML OR UG/L OR MOL/L OR NMOL/ML^Ferritin Ser EIA-mCnc
 ;;4092-3^0079^Vancomycin, Trough^MCG/ML^Vancomycin Tr SerPl-mCnc
 ;;16935-9^0080^Hepatitis B Surface Antibody^MIU/ML^HBV surface Ab Ser-aCnc
 ;;21006-2^0080^Hepatitis B Surface Antibody^MIU/ML^HBV surface Ab Ser Donr EIA-aCnc
 ;;22323-0^0080^Hepatitis B Surface Antibody^MIU/ML^HBV surface Ab Ser Donr-aCnc
 ;;32019-2^0080^Hepatitis B Surface Antibody^MIU/ML^HBV surface Ab Titr Ser
 ;;5193-8^0080^Hepatitis B Surface Antibody^MIU/ML^HBV surface Ab Ser EIA-aCnc
 ;;5194-6^0080^Hepatitis B Surface Antibody^MIU/ML^HBV surface Ab Ser RIA-aCnc
 ;;47364-5^0081^Hepatitis B Surface Antigen^NEG-POS/NON-REAC-REAC^HBV surface Ag Ser Donr Ql EIA
 ;;50967-9^0081^Hepatitis B Surface Antigen^NEG-POS/NON-REAC-REAC^HBV surface Ag Bld Donr Ql Nt
 ;;5195-3^0081^Hepatitis B Surface Antigen^NEG-POS/NON-REAC-REAC^HBV surface Ag Ser Ql
 ;;5196-1^0081^Hepatitis B Surface Antigen^NEG-POS/NON-REAC-REAC^HBV surface Ag Ser Ql EIA
 ;;5197-9^0081^Hepatitis B Surface Antigen^NEG-POS/NON-REAC-REAC^HBV surface Ag Ser Ql RIA
 ;;7905-3^0081^Hepatitis B Surface Antigen^NEG-POS/NON-REAC-REAC^HBV surface Ag Ser Ql Nt
 ;;24113-3^0082^Hepatitis B core antibody IgM^NEG-POS/NON-REAC-REAC^HBV core IgM Ser Ql EIA
 ;;31204-1^0082^Hepatitis B core antibody IgM^NEG-POS/NON-REAC-REAC^HBV core IgM Ser Ql
 ;;22319-8^0083^Hepatitis B core antibody IgM - Qt^MIU/ML^HBV core IgM Ser-aCnc
 ;;5185-4^0083^Hepatitis B core antibody IgM - Qt^MIU/ML^HBV core IgM Ser EIA-aCnc
 ;;5186-2^0083^Hepatitis B core antibody IgM - Qt^MIU/ML^HBV core IgM Ser RIA-aCnc
 ;;13953-5^0084^Hepatitis B e antibody^NEG-POS/NON-REAC-REAC^HBV e Ab Ser Ql EIA
 ;;22320-6^0084^Hepatitis B e antibody^NEG-POS/NON-REAC-REAC^HBV e Ab Ser Ql
 ;;33463-1^0084^Hepatitis B e antibody^NEG-POS/NON-REAC-REAC^HBV e IgG Ser Ql EIA
 ;;41151-2^0084^Hepatitis B e antibody^NEG-POS/NON-REAC-REAC^HBV e IgG Ser Ql
 ;;22321-4^0085^Hepatitis B e antibody - Qt^MIU/ML^HBV e Ab Ser-aCnc
 ;;5189-6^0085^Hepatitis B e antibody - Qt^MIU/ML^HBV e Ab Ser EIA-aCnc
 ;;5190-4^0085^Hepatitis B e antibody - Qt^MIU/ML^HBV e Ab Ser RIA-aCnc
 ;;11258-1^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA Ser-aCnc
 ;;20442-0^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA # Ser bDNA
 ;;23869-1^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA Ser Prb-mCnc
 ;;29615-2^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA # SerPl PCR
 ;;29900-8^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA Ser bDNA-mCnc
 ;;32686-8^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA Ser-mCnc
 ;;42595-9^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA SerPl PCR-aCnc
 ;;47216-7^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA # SerPl PCR DL=200
 ;;48650-6^0086^Hepatitis B virus DNA^COPIES/ML^HBV DNA # SerPl PCR DL=500
 ;;5007-0^0087^Hepatitis B virus DNA - QUAL^NEG-POS/NON-REAC-REAC^HBV DNA Bld Ql PCR
 ;;13126-8^0087^Hepatitis B virus DNA - QUAL^NEG-POS/NON-REAC-REAC^HBV DNA Bld Ql IB
 ;;16934-2^0087^Hepatitis B virus DNA - QUAL^NEG-POS/NON-REAC-REAC^HBV DNAp Bld Ql PCR
 ;;29610-3^0087^Hepatitis B virus DNA - QUAL^NEG-POS/NON-REAC-REAC^HBV DNA SerPl Ql PCR
 ;;32286-7^0088^Hepatitis C genotype^TEXT^HCV Gentyp SerPl PCR
 ;;48574-8^0088^Hepatitis C genotype^TEXT^HCV Gentyp Bld PCR
 ;;24011-9^0089^Hepatitis C (RIBA)^NEG-POS/NON-REAC-REAC^HCV Ab Patrn Ser IB-Imp
 ;;33462-3^0089^Hepatitis C (RIBA)^NEG-POS/NON-REAC-REAC^HCV IgG Ser Ql IB
 ;;34162-8^0089^Hepatitis C (RIBA)^NEG-POS/NON-REAC-REAC^HCV IgG Patrn Ser IB-Imp
 ;;5199-5^0089^Hepatitis C (RIBA)^NEG-POS/NON-REAC-REAC^HCV Ab Ser Ql IB
 ;;EXIT
 Q
 ;

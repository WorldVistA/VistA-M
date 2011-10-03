ECX3112P ;ALB/MRY -Populate DSS LOINC Code file Post-Init Rtn; 04/11/08 ; 5/8/08 9:29am
 ;;3.0;DSS EXTRACTS;**112**;Dec 22,1997;Build 26
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
 D OPTIONS
 D SEED
 Q
 ;
OPTIONS ;
 ;Disable Link Lab Test options
 ;Init variables
 N MENU,PTR,SMENU,SPTR,NUM,DA,DIK
 F MENU="ECX SETUP LAB","ECXLABRS","ECXLARP" D
 .K ECXMSG
 .S ECXMSG(1)=" "
 .S ECXMSG(2)=$S(MENU="ECX SETUP LAB":"Disabling [ECX SETUP LAB] menu",MENU="ECXLABRS":"Disabling [ECXLABRS] menu",MENU="ECXLARP":"Disabling [ECXLARP] menu",1:"")
 .D MES^XPDUTL(.ECXMSG)
 .;Order thru option file and find menu and retrieve IEN
 .S PTR="",PTR=$O(^DIC(19,"B",MENU,PTR))
 .I 'PTR D BMES^XPDUTL("** "_MENU_" item not found, not updated **") Q
 .;Disable menu option
 .D OUT^XPDMENU(MENU,"MENU OPTION NO LONGER USED")
 .D BMES^XPDUTL(MENU_"   **  Menu option disabled  **")
 D BMES^XPDUTL("**  Menu updates completed  **")
 Q
SEED ;
 N ECXLINE,ECXSTR,ECXDA,CNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LOINC CODES File (#727.29)...")
 D MES^XPDUTL(" ")
 S CNT=0
 ;F ECXLINE=1:1 S ECXSTR=$P($T(LOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 ;. S ECXDA=+$P(ECXSTR,"^")
 ;. I '$D(^LAB(95.3,"B",ECXDA)) Q
 ;. I '$D(^ECX(727.29,ECXDA,0)) D
 ;.. S CNT=CNT+1
 ;.. S ECXDN=$P(ECXSTR,"^",2)
 ;.. S ECXDTN=$P(ECXSTR,"^",3)
 ;.. S ECXDRU=$P(ECXSTR,"^",5)
 ;.. S (DINUM,X)=ECXDA,DIC(0)="L",DLAYGO=727.29,DIC="^ECX(727.29,"
 ;.. S DIC("DR")=".02///"_ECXDN_";.03///"_ECXDTN_";.04///"_ECXDRU
 ;.. K DD,DO D FILE^DICN K DIC,DINUM,DLAYGO,X,Y
 N DIC,DIE,DA,DLAYGO,DR,X,Y,ECXLINE,ECXSTR,ECXDN,ECXDTN,ECXLN,ECXDRU
 S DIC="^ECX(727.29,",DIC(0)="L",DLAYGO=727.29
 F ECXLINE=1:1 S ECXSTR=$P($T(LOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
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
LOINC ;;LOINC #^DSS LAR TEST #^DSS TEST NAME^LOINC NAME^DSS REPORTING UNIT
 ;;718-7^0001^Hemoglobin^Hgb Bld-mCnc^G/DL
 ;;2823-3^0002^Potassium (Serum)^Potassium SerPl-sCnc^MEQ/L or MMOL/L
 ;;2951-2^0003^Sodium (Serum)^Sodium SerPl-sCnc^MEQ/L or MMOL/L
 ;;14334-7^0004^Lithium (Serum)^Lithium SerPlas CNC PT^MMOL/L
 ;;3719-2^0004^Lithium (Serum)^Lithium SerPl-mCnc^MEQ/L or MMOL/L
 ;;3094-0^0005^BUN (Blood Urea Nitrogen)^BUN SerPl-mCnc^MG/DL
 ;;26464-8^0006^WBC (Total WBC Count)^WBC # Bld^K/UL or K/MM3
 ;;6690-2^0006^WBC (Total WBC Count)^WBC # Bld Auto^K/UL or K/MM3
 ;;804-5^0006^WBC (Total WBC Count)^WBC # Bld Manual^K/UL or K/MM3
 ;;10535-3^0007^Digoxin^Digoxin SerPl-mCnc^NG/ML
 ;;4049-3^0008^Theophylline^Theophylline SerPl-mCnc^UG/ML
 ;;1920-8^0009^AST (Aspartate Transferase)^AST SerPl-cCnc^U/L
 ;;30239-8^0009^AST (Aspartate Transferase)^AST SerPl w P-5-P-cCnc^U/L
 ;;2345-7^0010^Glucose (Serum)^Glucose SerPl-mCnc^MG/DL
 ;;2164-2^0011^Creatinine Clearance^CrCl 24H Ur+SerPl-vRate^ML/MIN
 ;;2324-2^0013^GGTP (Gamma GT)^GGT SerPl-cCnc^IU/L
 ;;3968-5^0014^Dilantin (Phenytoin)^Phenytoin SerPl-mCnc^MCG/ML
 ;;4086-5^0015^Valproic Acid^Valproate SerPl-mCnc^MCG/ML
 ;;3432-2^0016^Carbamazepine (Tegretol)^Carbamazepine SerPl-mCnc^MCG/ML
 ;;17855-8^0017^Hemoglobin A1C  (Glycohemoglobin)^Hgb A1c Fr Bld Calc^%
 ;;17856-6^0017^Hemoglobin A1C  (Glycohemoglobin)^Hgb A1c Fr Bld HPLC^%
 ;;4548-4^0017^Hemoglobin A1C  (Glycohemoglobin)^Hgb A1c Fr Bld^%
 ;;4549-2^0017^Hemoglobin A1C  (Glycohemoglobin)^Hgb A1c Fr Bld Elph^%
 ;;1825-9^0018^Alpha 1 Antitrypsin^A1AT SerPl-mCnc^MG/DL
 ;;2857-1^0019^PSA (Prostatic Specific AG)^PSA SerPl-mCnc^NG/ML
 ;;8127-3^0020^CD-4 (Absolute T Cell Count)^CD4 Cells # Bld^CELLS/MM3, CELLS/UL
 ;;5902-2^0021^Prothrombin Time^PT PPP Qn^SEC
 ;;5964-2^0021^Prothrombin Time^PT Bld Qn^SEC
 ;;3026-2^0022^Total Thyroxine (T-4)^T4 SerPl-mCnc^MCG/DL
 ;;3053-6^0023^Total Triiodothyronine (T-3)^T3 SerPl-mCnc^NG/DL
 ;;11579-0^0024^Thyroid Stimulating Hormone (TSH)^TSH SerPl DL=0.01 mU/L-aCnc^MCU/ML
 ;;11580-8^0024^Thyroid Stimulating Hormone (TSH)^TSH SerPl DL=0.001 mU/L-aCnc^MCU/ML
 ;;3016-3^0024^Thyroid Stimulating Hormone (TSH)^TSH SerPl-aCnc^MCU/ML
 ;;2284-8^0025^Folic Acid/Folate^Folate SerPl-mCnc^NG/ML
 ;;2132-9^0026^Vitamin B12 Level^Vit B12 Ser-mCnc^PG/ML
 ;;13457-7^0027^LDLC (both calc and direct)^LDLc SerPl Calc-mCnc^MG/DL
 ;;18262-6^0027^LDLC (both calc and direct)^LDLc SerPl Direct Assay-mCnc^MG/DL
 ;;2089-1^0027^LDLC (both calc and direct)^LDLc SerPl-mCnc^MG/DL
 ;;49132-4^0027^LDLC (both calc and direct)^LDLc SerPl Elph-mCnc^MG/DL
 ;;2085-9^0028^HDLC^HDLc SerPl-mCnc^MG/DL
 ;;2093-3^0029^Total Cholesterol^Cholest SerPl-mCnc^MG/DL
 ;;2571-8^0030^Triglycerides^Trigl SerPl-mCnc^MG/DL
 ;;2160-0^0031^Serum Creatinine^Creat SerPl-mCnc^MG/DL
 ;;14957-5^0032^Microalbumin (Random Point)^Microalbumin Ur Qn^MG/DL
 ;;11218-5^0032^Microalbumin (Random Point)^Microalbumin Ur Qn Test Str^MG/DL
 ;;10900-9^0033^Hepatitis B Surface Antibody^HBV surface Ab Ser Ql EIA^NEG-POS/NON-REAC-REAC
 ;;22322-2^0033^Hepatitis B Surface Antibody^HBV surface Ab Ser Ql^NEG-POS/NON-REAC-REAC
 ;;39535-0^0033^Hepatitis B Surface Antibody^HBV surface Ab Ser Ql RIA^NEG-POS/NON-REAC-REAC
 ;;13955-0^0034^Hepatitis C Antibody^HCV Ab Ser Ql EIA^NEG-POS/NON-REAC-REAC
 ;;16128-1^0034^Hepatitis C Antibody^HCV Ab Ser Ql^NEG-POS/NON-REAC-REAC
 ;;5199-5^0034^Hepatitis C Antibody^HCV Ab Ser Ql IB^NEG-POS/NON-REAC-REAC
 ;;44873-8^0035^HIV Antibody^HIV1+2 Ab Ser Ql IB^NEG-POS/NON-REAC-REAC
 ;;5221-7^0035^HIV Antibody^HIV1 Ab Ser Ql IB^NEG-POS/NON-REAC-REAC
 ;;5225-8^0035^HIV Antibody^HIV2 Ab Ser Ql IB^NEG-POS/NON-REAC-REAC
 ;;7917-8^0035^HIV Antibody^HIV1 Ab Ser Ql^NEG-POS/NON-REAC-REAC
 ;;7918-6^0035^HIV Antibody^HIV1+2 Ab Ser Ql^NEG-POS/NON-REAC-REAC
 ;;7919-4^0035^HIV Antibody^HIV2 Ab Ser Ql^NEG-POS/NON-REAC-REAC
 ;;14092-1^0035^HIV Antibody^HIV1 Ab Ser Ql IF^NEG-POS/NON-REAC-REAC
 ;;30361-0^0035^HIV Antibody^HIV2 Ab Ser Ql EIA^NEG-POS/NON-REAC-REAC
 ;;31201-7^0035^HIV Antibody^HIV1+2 Ab Ser Ql EIA^NEG-POS/NON-REAC-REAC
 ;;8129-9^0036^CD4/CD8  Ratio (T Cell Screen)^CD4 Cells/CD8 Cells Bld^%
 ;;11011-4^0037^HCV Quantitative by PCR^HCV RNA SerPl PCR-a-Cnc^IU/ML
 ;;29609-5^0037^HCV Quantitative by PCR^HCV RNA SerPl bDNA-aCnc^IU/ML
 ;;34703-9^0037^HCV Quantitative by PCR^HCV RNA SerPl PCR DL=500-aCnc^IU/ML
 ;;34704-7^0037^HCV Quantitative by PCR^HCV RNA SerPl PCR DL=50-aCnc^IU/ML
 ;;20447-9^0038^HIV Viral Load^HIV1 RNA # SerPl PCR^COPIES/ML
 ;;48511-0^0038^HIV Viral Load^HIV1 RNA # SerPl PCR DL=50^COPIES/ML
 ;;48551-6^0038^HIV Viral Load^HIV1 RNA # SerPl PCR DL=400^COPIES/ML
 ;;23876-6^0038^HIV Viral Load^HIV1RNA Plas bDNA-aCnc^COPIES/ML
 ;;11259-9^0039^HCV Qualitative by PCR^HCV RNA SerPl Ql PCR^NEG-POS
 ;;29893-5^0040^HIV 1 by EIA^HIV1 Ab Ser Ql EIA^NEG-POS
 ;;5222-5^0040^HIV 1 by EIA^HIV1 Ag Ser Ql EIA^NEG-POS
 ;;13951-9^0041^Hepatitis A AB^HAV Ab Ser Ql EIA^NEG-POS
 ;;20575-7^0041^Hepatitis A AB^HAV Ab Ser Ql^NEG-POS
 ;;13950-1^0042^Hepatitis A IgM AB^HAV IgM Ser Ql EIA^NEG-POS
 ;;22314-9^0042^Hepatitis A IgM AB^HAV IgM Ser Ql^NEG-POS
 ;;22313-1^0043^Hepatitis A IgG AB^HAV IgG Ser-aCnc^NEG-POS
 ;;32018-4^0043^Hepatitis A IgG AB^HAV IgG Ser Ql^NEG-POS
 ;;40724-7^0043^Hepatitis A IgG AB^HAV IgG Ser Ql EIA^NEG-POS
 ;;1975-2^0044^Bilirubin (Total)^Bilirub SerPl-mCnc^MG/DL
 ;;1742-6^0045^ALT (Transferase Alanine Amino)^ALT SerPl-cCnc^IU/L
 ;;1743-4^0045^ALT (Transferase Alanine Amino)^ALT SerPl w P-5-P-cCnc^IU/L
 ;;1744-2^0045^ALT (Transferase Alanine Amino)^ALT SerPl w/o P-5-P-cCnc^IU/L
 ;;13952-7^0046^Hepatitis B Core AB^HBV core Ab Ser Ql EIA^NEG-POS/NON-REAC-REAC
 ;;16933-4^0046^Hepatitis B Core AB^HBV core Ab Ser Ql^NEG-POS/NON-REAC-REAC
 ;;13954-3^0047^Hepatitis B e Ag^HBV e Ag Ser Ql EIA^NEG-POS/NON-REAC-REAC
 ;;31844-4^0047^Hepatitis B e Ag^HBV e Ag Ser Ql^NEG-POS/NON-REAC-REAC
 ;;5192-0^0047^Hepatitis B e Ag^HBV e Ag Ser Ql RIA^NEG-POS/NON-REAC-REAC
 ;;6768-6^0048^Phosphatase Alkaline (Serum)^ALP SerPl-cCnc^IU/L
 ;;1751-7^0049^Albumin (Serum)^Albumin SerPl-mCnc^GM/DL
 ;;4544-3^0050^Hematocrit^Hct Fr Bld Auto^%
 ;;4545-0^0050^Hematocrit^Hct Fr Bld Spun^%
 ;;48703-3^0050^Hematocrit^Hct Fr Bld Est^%
 ;;3173-2^0051^Partial Thromboplastin Time (PTT)^aPTT Bld Qn^SEC
 ;;14979-9^0051^Partial Thromboplastin Time (PTT)^aPTT PPP Qn^SEC
 ;;34714-6^0052^INR  (International Normalized Ratio)^INR Bld Qn^RATIO
 ;;46418-0^0052^INR  (International Normalized Ratio)^INR BldC Qn^RATIO
 ;;6301-6^0052^INR  (International Normalized Ratio)^INR PPP Qn^RATIO
 ;;26057-0^0053^Vitamin B6^Vit B6 p PO SerPl-mCnc^NG/ML
 ;;2900-9^0053^Vitamin B6^Vit B6 SerPl-mCnc^NG/ML
 ;;13965-9^0054^Homocysteine^Homocysteine SerPl-sCnc^UMOL/L
 ;;2335-8^0055^Occult Blood, Fecal^Hemocult Stl Ql^NEG-POS
 ;;14563-1^0055^Occult Blood, Fecal^Hemocult sp1 Stl Ql^NEG-POS
 ;;14564-9^0055^Occult Blood, Fecal^Hemocult sp2 Stl Ql^NEG-POS
 ;;14565-6^0055^Occult Blood, Fecal^Hemocult sp3 Stl Ql^NEG-POS
 ;;12503-9^0055^Occult Blood, Fecal^Hemocult sp4 Stl Ql^NEG-POS
 ;;12504-7^0055^Occult Blood, Fecal^Hemocult sp5 Stl Ql^NEG-POS
 ;;27401-9^0055^Occult Blood, Fecal^Hemocult sp6 Stl Ql^NEG-POS
 ;;27925-7^0055^Occult Blood, Fecal^Hemocult sp7 Stl Ql^NEG-POS
 ;;27926-5^0055^Occult Blood, Fecal^Hemocult sp8 Stl Ql^NEG-POS
 ;;14958-3^0056^Microalbumin/Creatinine Ratio^Microalbumin/creat 24H rate Ur^MG/G
 ;;14959-1^0056^Microalbumin/Creatinine Ratio^Microalbumin/creat Ur-mRto^MG/G
 ;;30000-4^0056^Microalbumin/Creatinine Ratio^Microalbumin/creat Ur-rto^MG/G
 ;;30001-2^0056^Microalbumin/Creatinine Ratio^Microalbumin/creat Ur Test Str^MG/G
 ;;44292-1^0056^Microalbumin/Creatinine Ratio^Microalbumin/creat 12H Ur-rto^MG/G
 ;;41604-0^0057^Glucose POC^Glucose p fast BldC Glucomtr-mCnc^MG/DL
 ;;41653-7^0057^Glucose POC^Glucose BldC Glucomtr-mCnc^MG/DL
 ;;48425-3^0058^Troponin T^Troponin T Bld-mCnc^NG/ML
 ;;6597-9^0058^Troponin T^Troponin T BldV-mCnc^NG/ML
 ;;6598-7^0058^Troponin T^Troponin T SerPl-mCnc^NG/ML
 ;;10839-9^0059^Troponin I^Troponin I SerPl-mCnc^NG/ML
 ;;42757-5^0059^Troponin I^Troponin I Bld-mCnc^NG/ML
 ;;14152-3^0060^Bilirubin (Direct)^Bilirub Direct Fld-mCnc^MG/DL
 ;;1968-7^0060^Bilirubin (Direct)^Bilirub Direct SerPl-mCnc^MG/DL
 ;;1988-5^0061^C Reactive Protein^CRP SerPl-mCnc^MG/L
 ;;30522-7^0062^C Reactive Protein HS^CRP SerPl High Sens-mCnc^MG/L
 ;;17861-6^0063^Calcium (Serum)^Calcium SerPl-mCnc^MG/DL
 ;;2028-9^0064^Carbon Dioxide^CO2 SerPl-sCnc^MEQ/L
 ;;2075-0^0065^Chloride (Serum)^Chloride SerPl-sCnc^MEQ/L
 ;;33914-3^0066^Creatinine eGFR^Pred GFR SerPl MDRD-vRate^ML/MIN/1.73M2
 ;;30934-4^0067^B Natriuretic Peptide^BNP SerPl-mCnc^PG/ML
 ;;42637-9^0067^B Natriuretic Peptide^BNP Bld-mCnc^PG/ML
 ;;2708-6^0068^O2 Saturation^O2 % BldA^%
 ;;2709-4^0068^O2 Saturation^O2 % BldC^%
 ;;2710-2^0068^O2 Saturation^O2 % BldC Oximetry^%
 ;;2711-0^0068^O2 Saturation^O2 % BldV^%
 ;;28642-7^0068^O2 Saturation^O2 Satn Fr BldCoA^%
 ;;28643-5^0068^O2 Saturation^O2 Satn Fr BldCoV^%
 ;;11556-8^0069^PO2^pO2 Bld Qn^MM HG
 ;;2703-7^0069^PO2^pO2 BldA Qn^MM HG
 ;;2704-5^0069^PO2^pO2 BldC Qn^MM HG
 ;;14864-3^0069^PO2^pO2 BldCo Qn^MM HG
 ;;28648-4^0069^PO2^pO2 BldCoA Qn^MM HG
 ;;28649-2^0069^PO2^pO2 BldCoV Qn^MM HG
 ;;19211-2^0069^PO2^pO2 BldMV Qn^MM HG
 ;;2705-2^0069^PO2^pO2 BldV Qn^MM HG
 ;;2713-6^0069^PO2^O2 Satn from pO2 Fr Bld^MM HG
 ;;19254-2^0069^PO2^pO2 temp adj Bld Qn^MM HG
 ;;19255-9^0069^PO2^pO2 temp adj BldA Qn^MM HG
 ;;19256-7^0069^PO2^pO2 temp adj BldC Qn^MM HG
 ;;47716-6^0069^PO2^pO2 temp adj BldCo Qn^MM HG
 ;;19257-5^0069^PO2^pO2 temp adj BldMV Qn^MM HG
 ;;19258-3^0069^PO2^pO2 temp adj BldV Qn^MM HG
 ;;11557-6^0070^PCO2^pCO2 Bld Qn^MM HG
 ;;14003-8^0070^PCO2^pCO2 BldCo Qn^MM HG
 ;;19212-0^0070^PCO2^pCO2 BldMV Qn^MM HG
 ;;2019-8^0070^PCO2^pCO2 BldA Qn^MM HG
 ;;2020-6^0070^PCO2^pCO2 BldC Qn^MM HG
 ;;2021-4^0070^PCO2^pCO2 BldV Qn^MM HG
 ;;28644-3^0070^PCO2^pCO2 BldCoA Qn^MM HG
 ;;28645-0^0070^PCO2^pCO2 BldCoV Qn^MM HG
 ;;32771-8^0070^PCO2^pCO2 temp adj BldA Qn^MM HG
 ;;34705-4^0070^PCO2^pCO2 temp adj Bld Qn^MM HG
 ;;40619-9^0070^PCO2^pCO2 temp adj BldV Qn^MM HG
 ;;40620-7^0070^PCO2^pCO2 temp adj BldC Qn^MM HG
 ;;47599-6^0070^PCO2^CO2 temp adj BldCo Qn^MM HG
 ;;2885-2^0071^Total Protein (Serum)^Prot SerPl-mCnc^GM/DL
 ;;2777-1^0072^Phosphate (Serum)^Phosphate Ser-Pl-mCNC^mg/dl
 ;;2039-6^0073^CEA (Serum)^CEA SerPl-mCnc^ug/L
 ;;33762-6^0074^Pro B Natriuretic Peptide^proBNP SerPl-mCnc^PG/ML
 ;;48641-5^0075^Phosphate (Serum)-pre Dial^Phosphate pre dialSer-Pl-mCNC^mg/dl
 ;;48617-5^0076^Phosphate (Serum)-post Dial^Phosphate p dialSer-Pl-mCNC^mg/dl
 ;;EXIT

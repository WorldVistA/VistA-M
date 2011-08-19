SRTPUTL4 ;BIR/SJA - RISK ASSESSMENT UTILITY ;05/15/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 N SRZZ,SRXX,SRX1
 S SRZ=0 F  S SRZ=$O(SRYY(139.5,SRTPP,SRZ)) Q:'SRZ  D
 .I $P(SRYY(139.5,SRTPP,SRZ,"I"),"^")="" S SRZ1=$P($G(SRYY(139.5,SRTPP,SRZ,"I")),"^",2) D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRX(SRMM,SRZ)=$P(SRFLD,"^",2)_"^"_SRZ1
 .I $P(SRYY(139.5,SRTPP,SRZ,"I"),"^")="NS" S SRZ1=$P($G(SRYY(139.5,SRTPP,SRZ,"I")),"^",2) D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRDT=$P(SRFLD,"^",4) S:SRDT'="" SRLR(SRDT)=""
 S SRDT=0 F  S SRDT=$O(SRLR(SRDT)) Q:'SRDT  D
 .S SRZ=0 F  S SRZ=$O(SRX(SRZ)) Q:'SRZ  S SRZ1=0 F  S SRZ1=$O(SRX(SRZ,SRZ1)) Q:'SRZ1  I SRZ1=SRDT K SRX(SRZ,SRZ1)
 Q
TR S SRP=SRZ1,SRP=$TR(SRP,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
C ;;3^VACO ID
D ;;4^Recipient Height^
E ;;5^Recipient Weight^
I ;;9^IVIG Recipient^
AJ ;;10^Recipient ABO Blood Type^
AA ;;11^Date Placed on Waiting List^
AB ;;12^Recipient CMV^
AC ;;13^Recipient HLA-A Typing^
AD ;;14^Recipient HLA-B Typing^
AE ;;15^Recipient HLA-C Typing^
AF ;;16^Recipient HLA-BW Typing^
AG ;;17^Recipient HLA-DR Typing^
AH ;;18^Recipient HLA-DQ Typing^
AI ;;19^Transplant Comments^
BJ ;;20^Acetaminophen Toxicity^
BA ;;21^Acute Liver Failure^
BB ;;22^Lung Cancer^
BC ;;23^Alcoholic Cirrhosis^
BD ;;24^Alpha 1 Anti-Trypsin Deficiency^
BE ;;25^Bronchiectasis^
BF ;;26^Glomerular Sclerosis/Nephritis^
BG ;;27^Graft Failure^
BH ;;28^HBV Cirrhosis (Hepatitis B)^
BI ;;29^HCC (Hepatocellular CA)^
CJ ;;30^HCV Cirrhosis (Hepatitis C)^
CA ;;31^Donor Height^
CB ;;32^Interstitial Lung Disease^
CC ;;33^Membranous Nephropathy^
CD ;;34^Metabolic^
CE ;;35^NASH ^
CF ;;36^Donor Weight^
CG ;;37^Polycystic Disease^
CH ;;38^Primary Biliary Cholangitis^
CI ;;39^Primary Sclerosing Cholangitis^
DJ ;;40^Pulmonary Fibrosis^
DA ;;41^Pulmonary Hypertension^
DB ;;42^Renal Cancer^
DC ;;43^Sarcoidosis^
DD ;;44^Donor Race^
DE ;;45^Donor Gender^
DF ;;46^Donor Age^
DG ;;47^Biliary Stricture^
DH ;;48^Donor ABO Blood Type^
DI ;;49^Donor CMV^
EJ ;;50^LAS Score at Listing^
EA ;;51^LAS Score at Transplant^
EB ;;52^MELD Score at Listing^
EC ;;53^Biologic MELD score at listing^
ED ;;54^MELD score at transplant^
EE ;;55^Biologic MELD score at transplant^
EF ;;56^Bile Leak^
EG ;;57^UNOS Status at time of Transplant^
EH ;;58^UNOS Status at time of Listing^
EI ;;59^Diabetic Retinopathy^
FJ ;;60^Diabetic Neuropathy^
FA ;;61^Cardiac Disease (CAD, AF, EF<50%)^
FB ;;62^Inotrope Dependent Pre-Transplant^
FC ;;63^Medical Center Division^
FD ;;64^Donor HLA-A Typing^
FE ;;65^Donor HLA-B Typing^
FF ;;66^Donor HLA-C Typing^
FG ;;67^Donor HLA-BW Typing^
FH ;;68^Crossmatch D/R^
FI ;;69^Deceased Donor^
GJ ;;70^Donor Date of Birth^
GA ;;71^Elevated PAP^
GB ;;72^Donor HLA-DQ Typing^
GC ;;73^Donor HLA-DR Typing^
GD ;;74^Pulmonary Hypertension / Elevated PAP^
GE ;;75^Liver Disease^
GF ;;76^COPD ^
GG ;;77^Donor Substance Abuse^
GH ;;78^Porto Pulmonary Hypertension^
GI ;;79^History of Bleeding Esophageal and/or Gastric Varices^
HJ ;;80^Pre-Transplant Malignancy^
HA ;;81^History of Preop Transplant Skin Malignancy^
HB ;;82^History of Other Pre-Transplant Malignancy^
HC ;;83^Recipient Substance Abuse^
HD ;;84^Active Infection for PSC^
HE ;;85^Warm Ischemia Time For Organ^
HF ;;86^Acute or Chronic Encephalopathy^
HG ;;87^Cold Ischemia Time for Organ^
HH ;;88^History of Ascites^
HI ;;89^Total Ischemia Time for Organ^
IJ ;;90^Non-Compliance (Med and Diet)^
IA ;;91^On Methadone^
IB ;;92^Post Transplant Prophylaxis for TB/Antimycobacterial Treatment^
ID ;;94^Rejection^
IE ;;95^IgA Nephropathy^
IF ;;96^Calcineurin Inhibitor Toxicity^
IG ;;97^Lithium Toxicity^
IH ;;98^Obstructive Uropathy from BPH^
II ;;99^Autoimmune Hepatitis^
AJJ ;;100^Cryptogenic Cirrhosis^
AJA ;;101^Chronic Rejection^
AJB ;;102^Hepatic Artery Thrombosis^
AJC ;;103^Living Donor^
AJD ;;104^Donor with Malignancy^
AJE ;;105^Primary Non-Function^
AJF ;;106^Secondary Sclerosing Cholangitis^
AJG ;;107^Toxic Exposure^
AJH ;;108^HIV + (positive)^
AJI ;;109^Post Transplant Prophylaxis for CMV/Antiviral Treatment^
AAJ ;;110^Post Transplant Prophylaxis for PCP/Antibacterial Treatment^
AAA ;;111^Portal Vein Thrombosis^
AAB ;;112^Other Cardiomyopathy^
AAC ;;113^Lung Disease^
AAD ;;114^Renal Impairment (Serum Creatinine >1.5)^
AAE ;;115^Active Infection Requiring Antibiotics^
AAF ;;116^Bleeding/Transfusions^
AAG ;;117^Pneumonia^
AAH ;;118^On Ventilator > 48 Hours^
AAI ;;119^Cardiac Arrest Requiring CPR^
ABJ ;;120^Psychosis^
ABA ;;121^Stroke/CVA^
ABB ;;122^Coma Greater than 24 Hours Postop (Y/N)^
ABC ;;123^Superficial Incisional SSI^
ABD ;;124^Deep Incisional SSI^
ABE ;;125^Systemic Sepsis^
ABF ;;126^Return to Surgery within 30 days^
ABG ;;127^Seizures^
ABH ;;128^Emphysema^
ABI ;;129^Other Diagnosis^
ACJ ;;130^New Mechanical Circulatory Support^
ACA ;;131^Preop Functional Health Status^
ACB ;;132^Peripheral Vascular Disease^
ACC ;;133^Graft Failure Date^
ACD ;;134^Pancreas^
ACE ;;135^Glucose at Time of Listing^
ACF ;;136^C-peptide at Time of Listing^
ACG ;;137^Pancreatic Duct Anastomosis^
ACH ;;138^Glucose Post Transplant^
ACI ;;139^Amylase Post Transplant^
ADJ ;;140^Lipase Post Transplant^
ADA ;;141^Insulin Required Post transplant^
ADB ;;142^Oral Hypoglycemics Required Post Transplant^
ADC ;;143^PRA at Listing^
ADD ;;144^PRA at Transplant^
ADE ;;145^Hypertension Requiring Meds^
ADF ;;146^Transfusion >4 RBC Units^
ADG ;;147^Diabetes Mellitus^
ADH ;;148^Reoperation for Bleeding^
ADI ;;149^Amiodarone Use^
AEJ ;;150^Heparin Sensitivity^
AEA ;;151^Hyperlipidemia History^
AEB ;;152^Ventricular Tachycardia^
AEC ;;153^Prior Blood Transfusion^
AED ;;154^Creatinine on Day of Transplant^
AEE ;;155^Dilated Cardiomyopathy^
AEF ;;156^Coronary Artery Disease^
AEG ;;157^Ischemic Cardiomyopathy^
AEH ;;158^Alcoholic Cardiomyopathy^
AEI ;;159^Valvular Cardiomyopathy^
AFJ ;;160^Idiopathic Cardiomyopathy^
AFA ;;161^Viral Cardiomyopathy^
AFB ;;162^Peripartum Cardiomyopathy^
AFC ;;163^PVR Before Vasodilation^
AFD ;;164^PVR After Vasodilation^
AFE ;;165^LVEF % ^
AFF ;;166^PRA %^
AFG ;;167^PA Systolic Pressure^
AFH ;;168^PAW Mean Pressure^
AFI ;;169^FEV1 ^
AGJ ;;170^Date of Death^
AGA ;;171^Current Smoker^
AGB ;;172^Prior MI^
AGC ;;173^Number of Prior Heart Surgeries^
AGD ;;174^Cerebral Vascular Disease^
AGE ;;175^Congestive Heart Failure (CHF)^
AGF ;;176^IV NTG within 48 Hours^
AGG ;;177^Current Digoxin Use^
AGH ;;178^Current Diuretic Use^
AGI ;;179^Preoperative Circulatory Device^
AHA ;;181^Assessment Status^
AHB ;;182^Transplant Type^
AHD ;;184^Date Transmitted^
AHE ;;185^VA or Non-VA Indicator^
AHG ;;187^Date Started Dialysis^
AHI ;;189^Tracheostomy^
AIJ ;;190^Mediastinitis^
AIA ;;191^Renal Failure Requiring Dialysis^
AIB ;;192^Perioperative MI^
AIC ;;193^Operative Death^
AIG ;;197^Plasmapheresis^
 Q

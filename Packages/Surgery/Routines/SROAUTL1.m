SROAUTL1 ;BIR/ADM - RISK ASSESSMENT UTILITY ;07/19/2011
 ;;3.0;Surgery;**38,47,81,125,153,160,166,174,176**;24 Jun 93;Build 8
 S SRZ=0 F  S SRZ=$O(SRY(130,SRTN,SRZ)) Q:'SRZ  I SRY(130,SRTN,SRZ,"I")="" D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRX(SRZ)=$P(SRFLD,"^",2)
 Q
TR S SRP=SRZ,SRP=$TR(SRP,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
BJH ;;208^History of Hypertension Requiring Medication (Y/N)^Hypertension Requiring Meds^
BAC ;;213^Esophageal Varices (Y/N)^Esophogeal Varices^
BBJ ;;220^Previous PCI (Y/N)^Previous PCI^
BFF ;;266^Previous Cardiac Surgery (Y/N)^Previous Cardiac Surgery^
CBI ;;329^History of Revascularization/Amputation for PVD (Y/N)^Revascularization/Amputation^
CCJ ;;330^Rest Pain/Gangrene (Y/N)^Rest Pain/Gangrene^
CID ;;394^History of MI Within Past 6 Months (Y/N)^MI Within 6 Months^
CIE ;;395^Angina within One Month Preceding Surgery (Y/N)^Angina Within 1 Month^
BCF ;;236^Patient's Height^Height^
BCG ;;237^Patient's Weight^Weight^
EAI ;;519^Diabetes Mellitus: Chronic, Long-term Management^Diabetes Mellitus: Chronic, Long-term Management^
EBJ ;;520^Diabetes Mellitus: Management Prior to Surgery^Diabetes Mellitus: Management Prior to Surgery^
EAG ;;517^Tobacco Use^Tobacco Use^
EAH ;;518^Tobacco Use Timeframe^Tobacco Use Timeframe^
BDF ;;246^ETOH Greater than 2 Drinks/Day (Y/N)^ETOH > 2 Drinks/Day^
FAH ;;618^Positive Drug Screening^Positive Drug Screening^
CBE ;;325^Dyspnea^Dyspnea^
BCH ;;238^DNR Status (Y/N)^DNR Status^
DIB ;;492^Functional Health Status at Evaluation for Surgery^Preop Functional Status
BJD ;;204^Ventilator Dependent Greater than 48 Hrs (Y/N)^Ventilator Dependent^
BJC ;;203^History of COPD (Y/N)^History of Severe COPD^
CBF ;;326^Current Pneumonia (Y/N)^Current Pneumonia^
BAB ;;212^Ascites (Y/N)^Ascites^
CIF ;;396^CHF within One Month Preceding Surgery (Y/N)^CHF Within 1 Month^
CBH ;;328^Acute Renal Failure (Y/N)^Acute Renal Failure^
BAA ;;211^Currently on Dialysis (Y/N)^Currently on Dialysis^
CCB ;;332^Impaired Sensorium (Y/N)^Impaired Sensorium^
CCC ;;333^Coma (Y/N)^Coma^
DJJ ;;400^Hemiplegia (Y/N)^Hemiplegia^
EBA ;;521^Prior Surgical Repair/Carotid Artery Obstruction^Prior Surgical Repair/Carotid Artery Obstruction^
EBB ;;522^History of CVD Events^History of CVD Events^
DJA ;;401^Tumor Involving CNS (Y/N)^Tumor Involving CNS^
CCH ;;338^Disseminated Cancer (Y/N)^Disseminated Cancer^
BAH ;;218^Open Wound or Skin Infection (Y/N)^Open Wound or Infection^
CCI ;;339^Steroid Use for Chronic Condition (Y/N)^Steroid Use for Chronic Cond.^
BAE ;;215^Weight Loss > 10% of Usual Body Weight (Y/N)^Weight Loss > 10%^
BAF ;;216^History of Bleeding Disorders (Y/N)^Bleeding Disorders^
BAG ;;217^Transfusion Greater than 4 RBC Units this Admission (Y/N)^Transfusion > 4 RBC Units^
CCHPA ;;338.1^Chemotherapy Within Last 30 Days (Y/N)^Chemotherapy W/I 30 Days^
CCHPB ;;338.2^Radiotherapy Within Last 90 Days (Y/N)^Radiotherapy W/I 90 Days^
BAHPA ;;218.1^Preoperative Sepsis (Y/N)^Preoperative Sepsis^
BFI ;;269^Pregnancy Status^Pregnancy Status^
DAC ;;413^Transfer Status^Transfer Status^
PJAA ;;.011^In/Out-Patient Status
BDG ;;247^Length of Postoperative Hospital Stay
CDB ;;342^Date/Time of Death^Date/Time of Death
DAG ;;417^Patient's Race
DAH ;;418^Hospital Admission Date
DAI ;;419^Hospital Discharge Date
DBJ ;;420^Admitted/Transferred to Surgical Service
DBA ;;421^Discharged/Transferred to Chronic Care
DEB ;;452^Observation Admission Date/Time
DEC ;;453^Observation Discharge Date/Time
DED ;;454^Observation Treating Specialty
BCGPA ;;237.1^Preoperative Sleep Apnea

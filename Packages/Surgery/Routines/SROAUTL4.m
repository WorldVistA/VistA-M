SROAUTL4 ;BIR/ADM - RISK ASSESSMENT UTILITY ;07/19/2011
 ;;3.0;Surgery;**38,71,95,125,153,160,164,166,174,175,176,182,184**;24 Jun 93;Build 35
 N SRZZ,SRXX,SRX1
 S SRZ=0 F  S SRZ=$O(SRY(130,SRTN,SRZ)) Q:'SRZ  D
 .I SRY(130,SRTN,SRZ,"I")="" D TR S (SRX1,X)=$T(@SRP),SRFLD=$P(X,";;",2) D
 ..S X=SRX1,SRX(SRZ)=$P(SRFLD,"^",2)_"^"_$P(X,";;",3)
 ..I $D(SRX(667)) I $P($G(^SRF(SRTN,200.1)),"^",8),($P($G(^SRF(SRTN,200.1)),"^",8)'=3) K SRX(667)
 .I SRY(130,SRTN,SRZ,"I")="NS" D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRDT=$P(SRFLD,"^",4) S:SRDT'="" SRLR(SRDT)=""
 S SRDT=0 F  S SRDT=$O(SRLR(SRDT)) Q:'SRDT  K SRX(SRDT)
 Q
RED M SRZZ=SRX S SRZ=0 F  S SRZ=$O(SRX(SRZ)) Q:'SRZ  S SRZZ=$P($G(SRX(SRZ)),"^",2),SRXX(SRZZ)=$P($G(SRX(SRZ)),"^")_":"_SRZ
 K SRX M SRX=SRXX K SRXX
 Q
TR S SRP=SRZ,SRP=$TR(SRP,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
BCF ;;236^Patient's Height^Height^;;1-01
BCG ;;237^Patient's Weight^Weight^;;1-02
EAI ;;519^Diabetes Mellitus - Chronic, Long-Term Management^Diabetes - Long Term^;;1-03
EBJ ;;520^Diabetes Mellitus - Management Prior to Surgery^Diabetes - 2 Wks Preop^;;1-04
BJC ;;203^History of COPD (Y/N)^COPD^;;1-05
CDG ;;347^FEV1^FEV1^;;1-06
BJI ;;209^Cardiomegaly on Chest X-Ray (Y/N)^Cardiomegaly (X-ray)^;;1-07
EAG ;;517^Tobacco Use^Tobacco Use^;;1-08
EAH ;;518^Tobacco Use Timeframe^Tobacco Use Timeframe^;;1-08
FAH ;;618^Positive Drug Screening^Positive Drug Screening^;;1-10
CDI ;;349^Active Endocarditis (Y/N)^Active Endocarditis^;;1-11
DIB ;;492^Functional Health Status^Functional Status^;;1-12
FDJ ;;640^PCI^PCI^;;1-13
BJE ;;205^Prior Myocardial Infarction^Prior MI^;;1-14
CEB ;;352^Number of Prior Heart Surgeries^Number of Prior Heart Surgeries^;;1-15
DHE ;;485^Prior Heart Surgeries^;;1-16
BFE ;;265^Peripheral Arterial Disease^Peripheral Arterial Disease^;;1-17
EBA ;;521^Prior Surgical Repair/Carotid Artery Obstruction^Prior Surgical Repair/Carotid Artery Obstruction^;;1-18
EBB ;;522^History of CVD Events^History of CVD Events^;;1-19
BFG ;;267^Angina Severity^Angina Severity^;;1-20
FDC ;;643^Angina Timeframe^Angina Timeframe^;;1-20A
DBC ;;423^Preop Congestive Heart Failure^Preop Congestive Heart Failure^;;1-21
CEC ;;353^Current Diuretic Use (Y/N)^Current Diuretic Use^;;1-22
CEE ;;355^IV NTG within 48 Hours Preceding Surgery (Y/N)^IV NTG within 48 Hours^;;1-23
DGD ;;474^Preop use of Circulatory Device^Preop Circulatory Device^;;1-24
FDA ;;641^Hypertension^Hypertension^;;1-25
EJI ;;509^Preoperative Atrial Fibrillation^Preoperative Atrial Fibrillation^;;1-26
BCGPA ;;237.1^Preoperative Sleep Apnea^Preoperative Sleep Apnea^;;1-27
FFG ;;667^Sleep Apnea-Compliance^Sleep Apnea-Compliance^;;1-28
FFB ;;662^Impaired Cognitive Function in Past 3 Months^Impaired Cognitive Function^;;1-29
DEG ;;457^HDL^^457.1;;2-01
DEGPA ;;457.1^HDL, Date;;2-02
DFA ;;461^LDL^^461.1;;2-03
DFAPA ;;461.1^LDL, Date;;2-04
DFB ;;462^Total Cholesterol^^462.1;;2-05
DFBPA ;;462.1^Total Cholesterol, Date;;2-06
DEH ;;458^Serum Triglyceride^^458.1;;2-07
DEHPA ;;458.1^Serum Triglyceride, Date;;2-08
DEI ;;459^Serum Potassium^^459.1;;2-09
DEIPA ;;459.1^Serum Potassium, Date;;2-10
DFJ ;;460^Serum Total Bilirubin^^460.1;;2-11
DFJPA ;;460.1^Serum Total Bilirubin, Date;;2-12
BBC ;;223^Preoperative Serum Creatinine^Creatinine^290;;2-13
BIJ ;;290^Creatinine Date;;2-14
BBE ;;225^Preoperative Serum Albumin^^292;;2-15
BIB ;;292^Preoperative Serum Albumin Date;;2-16
BAI ;;219^Preoperative Hemoglobin^^239;;2-17
BCI ;;239^Preoperative Hemoglobin Date;;2-18
EJD ;;504^Hemoglobin A1c^^504.1;;2-19
EJDPA ;;504.1^Hemoglobin A1c, Date;;2-20
EJG ;;507^B-type Natriuretic Peptide (BNP)^^507.1;;2-21
EJGPA ;;507.1^B-type Natriuretic Peptide (BNP), Date;;2-22
DGF ;;476^Procedure Type;;3-01
CEG ;;357^Left Ventricular End-Diastolic Pressure^LVEDP^;;3-02
CEH ;;358^Aortic Systolic Pressure^Aortic Systolic Pressure^;;3-03
CEI ;;359^PA Systolic Pressure^*PA Systolic Pressure^;;3-04
CFJ ;;360^PAW Mean Pressure^*PAW Mean Pressure^;;3-05
CFC ;;363^LV Contraction Grade^LV Contraction Grade  (from contrast or radionuclide angiogram or 2D echo^;;3-06
DAE ;;415^Mitral Regurgitation^Mitral Regurgitation^;;3-07
DGG ;;477^Aortic Stenosis;;3-08
CFA ;;361^Left Main Stenosis^Left Main Stenosis^;;3-09
CFBPA ;;362.1^Left Anterior Descending (LAD) Stenosis^LAD Stenosis^;;3-10
CFBPB ;;362.2^Right Coronary Artery Stenosis^Right Coronary Stenosis^;;3-11
CFBPC ;;362.3^Circumflex Coronary Artery Stenosis^Circumflex Stenosis^;;3-12
DGH ;;478^Re-Do Lad Stenosis;;3-13
DGI ;;479^Re-Do Right Coronary Stenosis;;3-14
DHJ ;;480^Re-Do Circumflex Stenosis;;3-15
CFD ;;364^Physician's Preoperative Estimate of Operative Mortality^Physician's Preoperative Estimate of Operative Mortality^;;4-01
CFDPA ;;364.1^Date/Time of Estimate of Operative Mortality^Date/Time of Estimate of Operative Mortality^;;4-02
APAC ;;1.13^ASA Class^ASA Classification^;;4-03
DAD ;;414^Cardiac Surgical Priority^Surgical Priority^;;4-04
DADPA ;;414.1^Date/Time of Cardiac Surgical Priority^Date/Time of Cardiac Surgical Priority^;;4-05
APJI ;;1.09^Wound Classification^Wound Classification^;;4-06
DHA ;;481^Bridge to transplant/Device;;5-25
DEA ;;451^Total CPB Time;;5-26
DEJ ;;450^Total Ischemic Time;;5-27
DFH ;;468^Incision Type^;;5-28
DFI ;;469^Convert From Off Pump to CPB;;5-29
CHD ;;384^Operative Death (Y/N)^Operative Death^;;6-01
DAC ;;413^Transfer Status^Transfer Status^;;7-01
DAH ;;418^Hospital Admission Date And Time;;7-02
DDJ ;;440^Cardiac Catheterization Date;;7-03
PBJE ;;.205^Time Patient In OR;;7-04
PBB ;;.22^Time the Operation Began^Date/Time Operation Began^;;7-05
PBC ;;.23^Time the Operation Ended^Date/Time Operation Ended^;;7-06
PBCB ;;.232^Time Patient Out OR;;7-07
DGJ ;;470^Date and Time Patient Extubated;;7-08
DGA ;;471^Date and Time Patient Discharged from ICU;;7-09
DGC ;;473^Homeless(Y/N);;7-10
DDB ;;442^Employment Status;;7-11
CDB ;;342^Date/Time of Death^Date/Time of Death;;7-12
FHE ;;685^DC/REL Destination^DC/REL Destination;;7-13
FGJ ;;670^Current Residence^Current Residence;;7-14
FGA ;;671^Ambulation Device^Ambulation Device;;7-15
FGC ;;673^History of Cancer^History of Cancer;;7-16
FGD ;;674^History of Radiation Therapy^History of Radiation Therapy;;7-17
FGG ;;677^Num of Prior Surg in Same Oper^Num of Prior Surg in Same Oper;;7-18

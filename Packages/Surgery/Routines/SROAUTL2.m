SROAUTL2 ;BIR/ADM - RISK ASSESSMENT UTILITY ;01/29/07
 ;;3.0; Surgery ;**38,47,63,88,125,153,160**;24 Jun 93;Build 7
 S SRZ=0 F  S SRZ=$O(SRY(130,SRTN,SRZ)) Q:'SRZ  D
 .I SRY(130,SRTN,SRZ,"I")="" D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRX(SRZ)=$P(SRFLD,"^",2)
 .I SRY(130,SRTN,SRZ,"I")="NS" D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRDT=$P(SRFLD,"^",4) S:SRDT'="" SRLR(SRDT)=""
 S SRDT=0 F  S SRDT=$O(SRLR(SRDT)) Q:'SRDT  K SRX(SRDT)
 Q
RELATE S DFN=$P(^SRF(SRTN,0),"^"),SRDEATH=$P($G(^DPT(DFN,.35)),"^") I 'SRDEATH Q
 S X2=$P(^SRF(SRTN,0),"^",9),X1=SRDEATH D ^%DTC I X>90 Q
 S X=$P($G(^SRF(SRTN,.4)),"^",7) I X="" S SRX(903)="Death Unrelated/Related"
 Q
TR S SRP=SRZ,SRP=$TR(SRP,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
PJC ;;.03^Major or Minor^Major or Minor^
PDB ;;.42^Other Procedures^^
PCG ;;.37^Anesthesia Technique^^
CE ;;35^Concurrent Case^Concurrent Case^
PJD ;;.04^Surgery Specialty^Surgical Specialty^
BF ;;26^Principal Procedure^Principal Operation^
BGJ ;;270^Preoperative Serum Sodium^Serum Sodium^304
CJD ;;304^Date Preoperative Serum Sodium was Performed^^
BBD ;;224^Preoperative BUN (mg/dl)^BUN^291
BIA ;;291^Date Preoperative BUN was Performed^^
BBC ;;223^Preoperative Serum Creatinine (mg/dl)^Serum Creatinine^290
BIJ ;;290^Date Preoperative Serum Creatinine was Performed^^
BBE ;;225^Preoperative Serum Albumin (g/dl)^Serum Albumin^292
BIB ;;292^Date Preoperative Serum Albumin was Performed^^
BBH ;;228^Preoperative Total Bilirubin (mg/dl)^Total Bilirubin^295
BIE ;;295^Date Preoperative Total Bilrubin was Performed^^
BBG ;;227^Preoperative SGOT (mU/ml)^SGOT^294
BID ;;294^Date Preoperative SGOT was Performed^^
BBI ;;229^Preoperative Alkaline Phosphatase (mU/ml)^Alkaline Phosphatase^296
BIF ;;296^Date Preoperative Alkaline Phosphatase was Performed^^
BCJ ;;230^Preoperative WBC (X 1000/mm3)^WBC^297
BIG ;;297^Date Preoperative WBC was Performed
BCD ;;234^Preoperative Hematocrit^Hematocrit^301
CJA ;;301^Date Preoperative Hematocrit was Performed^^
BCA ;;231^Preoperative Platelet Count (X 1000/mm3)^Platelet Count^298
BIH ;;298^Date Preoperative Platelet Count was Performed^^
BCC ;;233^Preoperative PTT (seconds)^PTT^300
CJJ ;;300^Date Preoperative PTT was Performed^^
BCB ;;232^Preoperative PT (seconds)^PT^299
BII ;;299^Date Preoperative PT was Performed^^
BGD ;;274^Highest Postoperative Serum Sodium^Highest Serum Sodium^305
CJE ;;305^Date Highest Serum Sodium was Recorded^^
DJE ;;405^Lowest Serum Sodium^Lowest Serum Sodium^407
DJG ;;407^Date of Lowest Serum Sodium^^
BGE ;;275^Highest Postoperative Potassium^Highest Potassium^306
CJF ;;306^Date Highest Potassium was Recorded^^
DJF ;;406^Lowest Postoperative Potassium^Lowest Potassium^408
DJH ;;408^Date of Lowest Postoperative Potassium^^
BGG ;;277^Highest Postoperative Serum Creatinine^Highest Serum Creatinine^308
CJH ;;308^Date Highest Serum Creatinine was Recorded^^
BGH ;;278^Highest Postoperative CPK^Highest CPK^309
CJI ;;309^Date Highest CPK was Recorded^^
BGI ;;279^Highest Postoperative CPK-MB^Highest CPK-MB^310
CAJ ;;310^Date Highest CPK-MB Band was Recorded^^
BHJ ;;280^Highest Postoperative Total Bilirubin^Highest Total Bilirubin^311
CAA ;;311^Date Highest Total Bilirubin was Recorded^^
BHA ;;281^Highest Postoperative WBC^Highest WBC^312
CAB ;;312^Date Highest WBC was Recorded^^
BHC ;;283^Lowest Postoperative Hematocrit^Lowest Hematocrit^314
CAD ;;314^Date Lowest Hematocrit was Recorded^^
DEE ;;455^Highest Postoperative Serum Troponin I^Highest Troponin I^455.1
DEEPA ;;455.1^Date of Highest Postop Troponin I^^
DEF ;;456^Highest Postoperative Serum Troponin T^Highest Troponin T^456.1
DEFPA ;;456.1^Date of Highest Postop Troponin T^^
DHG ;;487^Preoperative INR^INR^487.1
DHGPA ;;487.1^Date Preoperative INR was Performed^^
DDD ;;444^Preoperative Anion Gap^Anion Gap^444.1
DDDPA ;;444.1^Date Preoperative Anion Gap was Recorded^^
DDE ;;445^Highest Postoperative Anion Gap^Highest Anion Gap^445.1
DDEPA ;;445.1^Date Highest Anion Gap was Recorded^^
EJD ;;504^Preoperative Hemoglobin A1c^Hemoglobin A1c^504.1
EJDPA ;;504.1^Date Preoperative Hemoglobin A1c was Performed^^
BG ;;27^Principal Procedure Code (CPT)^Principal CPT Code^
BAD ;;214^PGY of Primary Surgeon ('0' for Staff Surgeon)^PGY of Primary Surgeon^
PJCE ;;.035^Case Schedule Type^Surgical Priority^
APJI ;;1.09^Wound Classification^Wound Classification^
APAC ;;1.13^ASA Class^ASA Classification^
PBB ;;.22^Time the Operation Began^Date/Time Operation Began^
PBC ;;.23^Time the Operation Ends^Date/Time Operation Ended^
CDJ ;;340^Number of RBC Units Transfused^RBC Units Transfused^
DDC ;;443^Intraoperative Disseminated Cancer (Y/N)^Intraoperative Disseminated Cancer^
DDF ;;446^Intraoperative Ascites (Y/N)^Intraoperative Ascites
FF ;;66^Principal Diagnosis Code (ICD9)^Postop Diagnosis Code (ICD9)^
BDG ;;247^Length of Postoperative Stay^Length of Postoperative Hospital Stay^
AJB ;;102^Reason for not Creating an Assessment^Exclusion Criteria^
PJAA ;;.011^In/Out-Patient Status^Hospital Admission Status^
PAFF ;;.166^Attending Code^Attending Code
PBA ;;.21^Anesthesia Care Start Time^Anesthesia Start^
PBD ;;.24^Anesthesia Care End Time^Anesthesia Finish^

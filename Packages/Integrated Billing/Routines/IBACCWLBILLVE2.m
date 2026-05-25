IBACCWLBILLVE2 ;EDE/TAZ - ACC (Automated Community Care) Claims - VIEW ENCOUNTER (cont'd); 12-SEP-2023 ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;THIS ROUTINE ALLOWS THE USER TO VIEW THE X12 ENCOUNTER IN READABLE FORMAT.
 ;
MIA ;Inpatient Adjudication Information
 N CODE
 S CODE=$P(DATA,D,2) I $L(CODE) D SET("Covered Days or Visits Count",(CODE))
 S CODE=$P(DATA,D,3) I $L(CODE) D SET("HCPCS Payable Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,4) I $L(CODE) D SET("Lifetime Psychiatric Days Count",CODE)
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Claim DRG Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,6) I $L(CODE) D SET("Claim Payment Remark Code",CODE)
 S CODE=$P(DATA,D,7) I $L(CODE) D SET("Claim Disproportionate Share Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,8) I $L(CODE) D SET("Claim MSP Pass-through Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,9) I $L(CODE) D SET("Claim PPS Capital Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,10) I $L(CODE) D SET("PPS-Capital FSP DRG Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,11) I $L(CODE) D SET("PPS-Capital HSP DRG Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,12) I $L(CODE) D SET("PPS-Capital DSH DRG Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,13) I $L(CODE) D SET("Old Capital Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,14) I $L(CODE) D SET("PPS-Capital IME Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,15) I $L(CODE) D SET("PPS-Operating Hospital Specific DRG Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,16) I $L(CODE) D SET("Cost Report Day Count",CODE)
 S CODE=$P(DATA,D,17) I $L(CODE) D SET("PPS-Operating Federal Specific DRG Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,18) I $L(CODE) D SET("Claim PPS Capital Outlier Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,19) I $L(CODE) D SET("Claim Indirect Teaching Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,20) I $L(CODE) D SET("Non-Payable Professional Component Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,21) I $L(CODE) D SET("Claim Payment Remark Code",CODE)
 S CODE=$P(DATA,D,22) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,23) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,24) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,25) I $L(CODE) D SET("PPS-Capital Exception Amount",CODE)
 Q
 ;
NM1 ;Process NM1 record
 N CODE,NAME,STOP
 S STOP=0
 S CODE=$P(DATA,D,2) D  I 'STOP D SET(CODE,,1,1)
 . I CODE=40 S CODE="Receiver" Q
 . I CODE=41 S CODE="Submitter" Q
 . I CODE=45 S CODE="Ambulance Drop Off Location" Q
 . I CODE=71 S CODE="Attending Physician" Q
 . I CODE=72 S CODE="Operating Physician" Q
 . I CODE=77 D  Q
 .. ;I $P(DATA,D,9)="XX",$P(DATA,D,10)=$G(^TMP("IBACCWLBILLVE",$J,"BP NPI")) S STOP=1 Q   ;eBILL-5440;WCJ;GRAY build
 .. S CODE="Service Location"
 . I CODE=82 S CODE="Rendering Provider" Q
 . I CODE=85 D  Q
 .. I $P(DATA,D,9)="XX" S ^TMP("IBACCWLBILLVE",$J,"BP NPI")=$P(DATA,D,10)
 .. S CODE="Billing Provider"
 . I CODE=87 S CODE="Pay to Provider" Q
 . I CODE="DD" S CODE="Assistant Surgeon" Q
 . I CODE="DK" S CODE="Ordering Physician" Q
 . I CODE="DN" S CODE="Referring Provider" Q
 . I CODE="DQ" S CODE="Supervising Physician" Q
 . I CODE="IL" S CODE="Insured or Subscriber" Q
 . I CODE="P3" S CODE="Primary Care Provider" Q
 . I CODE="PE" S CODE="Payee" Q
 . I CODE="PR" S CODE="Payer" Q
 . I CODE="PW" S CODE="Ambulance Pickup Address" Q
 . I CODE="QB" S CODE="Purchase Service Provider" Q
 . I CODE="QC" S CODE="Patient" Q
 . I CODE="ZZ" S CODE="Other Operating Physician" Q
 I STOP Q
 I CODE?1"Ambulance".E Q
 S NAME=$S($P(DATA,D,3)=1:$$NAME(DATA),1:$P(DATA,D,4))
 I $L(NAME) D SET("Name",NAME)
 S CODE=$P(DATA,D,9),LINE=$P(DATA,D,10) I CODE'="" D  D SET(CODE,LINE)
 . I CODE="46" S CODE="Electronic Transmitter ID # (ETIN)" Q
 . I CODE="II" S CODE="Unique Health ID" Q
 . I CODE="MI" S CODE="Member ID Number" Q
 . I CODE="PI" S CODE="Payor Identification" Q
 . I CODE="XV" S CODE="CMS Plan ID" Q
 . I CODE="XX" S CODE="CMS National Provider Identifier" Q
 Q
 ;
PWK ;Claim Supplimental
 N CODE
 S CODE=$P(DATA,D,2) D  D SET("Attachment Report Type Code",CODE)
 . I CODE="03" S CODE="Report Justifying Treatment Beyond Utilization Guidelines" Q
 . I CODE="04" S CODE="Drugs Administered" Q
 . I CODE="05" S CODE="Treatment Diagnosis" Q
 . I CODE="06" S CODE="Initial Assessment" Q
 . I CODE="07" S CODE="Functional Goals" Q
 . I CODE="08" S CODE="Plan of Treatment" Q
 . I CODE="09" S CODE="Progress Report" Q
 . I CODE=10 S CODE="Continued Treatment" Q
 . I CODE=11 S CODE="Chemical Analysis" Q
 . I CODE=13 S CODE="Certified Test Result" Q
 . I CODE=15 S CODE="Justification for Admission" Q
 . I CODE=21 S CODE="Recovery Plan" Q
 . I CODE="A3" S CODE="Allergies/Sensitivity Plan" Q
 . I CODE="A4" S CODE="Autopsy Report" Q
 . I CODE="AM" S CODE="Ambulance Certification" Q
 . I CODE="AS" S CODE="Admission Summary" Q
 . I CODE="B2" S CODE="Prescription" Q
 . I CODE="B3" S CODE="Physician Order" Q
 . I CODE="B4" S CODE="Referral Form" Q
 . I CODE="BR" S CODE="Benchmark Testing Results" Q
 . I CODE="BS" S CODE="Baseline" Q
 . I CODE="BT" S CODE="Blanket Test Results" Q
 . I CODE="CB" S CODE="Chiropractic Justification" Q
 . I CODE="CK" S CODE="Consent Form(s)" Q
 . I CODE="CT" S CODE="Certification" Q
 . I CODE="D2" S CODE="Drug Profile Document" Q
 . I CODE="DA" S CODE="Dental Models" Q
 . I CODE="DB" S CODE="Durable Medical Equipment Prescription" Q
 . I CODE="DG" S CODE="Diagnostic Report" Q
 . I CODE="DJ" S CODE="Discharge Monitoring Report" Q
 . I CODE="DS" S CODE="Discharge Summary" Q
 . I CODE="EB" S CODE="Explanation of Benefits" Q
 . I CODE="HC" S CODE="Health Certificate" Q
 . I CODE="HR" S CODE="Health Clinic Records" Q
 . I CODE="I5" S CODE="Immunization Record" Q
 . I CODE="IR" S CODE="State School Immunization Record" Q
 . I CODE="LA" S CODE="Lab Results" Q
 . I CODE="M1" S CODE="Medical Record Attachment" Q
 . I CODE="MT" S CODE="Models" Q
 . I CODE="NN" S CODE="Nursing NotesNursing Notes" Q
 . I CODE="OB" S CODE="Operative Note" Q
 . I CODE="OC" S CODE="Oxygen Content Averaging Report" Q
 . I CODE="OD" S CODE="Orders and Treatment Documents" Q
 . I CODE="OE" S CODE="Objective Physical Exam Document" Q
 . I CODE="OX" S CODE="Oxygen Therapy Certification" Q
 . I CODE="OZ" S CODE="Support Data for Claim" Q
 . I CODE="P4" S CODE="Pathology Report" Q
 . I CODE="P5" S CODE="Patient Medical History Document" Q
 . I CODE="PE" S CODE="Parenteral or Enteral Certification" Q
 . I CODE="P6" S CODE="Periodontal Charts" Q
 . I CODE="PN" S CODE="Physicall Therapy Notes" Q
 . I CODE="PO" S CODE="Prosthetics or Orthotic Certification" Q
 . I CODE="PQ" S CODE="Peramedical Results" Q
 . I CODE="PY" S CODE="Physician's Report" Q
 . I CODE="PZ" S CODE="Physical Therapy Certification" Q
 . I CODE="RB" S CODE="Radiology Films" Q
 . I CODE="RR" S CODE="Radiology Reports" Q
 . I CODE="RT" S CODE="Report of Tests ad Analysis" Q
 . I CODE="RX" S CODE="Renewable Oxygen Content Averaging Report" Q
 . I CODE="SG" S CODE="Symptoms Document" Q
 . I CODE="V5" S CODE="Death Notification" Q
 . I CODE="XP" S CODE="Photographs" Q
 S CODE=$P(DATA,D,3) D  D SET("Attachment Transmission Code",CODE)
 . I CODE="AA" S CODE="Available on Request at Provider Site" Q
 . I CODE="AB" S CODE="Previous Submitted to Payer" Q
 . I CODE="AD" S CODE="Certification Included in this Claim" Q
 . I CODE="AF" S CODE="Narrative Segment Included in this Claim" Q
 . I CODE="AG" S CODE="No Documentation is Required." Q
 . I CODE="BM" S CODE="By Mail" Q
 . I CODE="EL" S CODE="Electronically Only" Q
 . I CODE="EM" S CODE="E-mail" Q
 . I CODE="FT" S CODE="File Transfer" Q
 . I CODE="FX" S CODE="By Fax" Q
 . I CODE="NS" S CODE="Not Specified" Q
 S CODE=$P(DATA,D,6) I CODE'="" D  D SET("Identification Code Qualifier",CODE)
 . I CODE="AC" S CODE="Attachment Control Number" Q
 I $P(DATA,D,7)'="" D SET("Attachment Control Number",$P(DATA,D,7))
 Q
 ;
REF ;Display Reference Segment
 N CODE,LINE
 S CODE=$P(DATA,D,2),LINE=$P(DATA,D,3) D  D SET(CODE,LINE)
 . I CODE="BT" S CODE="Immunization Bactch Number" Q
 . I CODE="D9" S CODE="Value Added Network Trace Number" Q
 . I CODE="EA" S CODE="Medical Record Number" Q
 . I CODE="EI" S CODE="Tax Identification #",LINE=$E($P(DATA,D,3),1,2)_"-"_$E($P(DATA,D,3),3,$L($P(DATA,D,3))) Q
 . I CODE="EW" S CODE="Mammography Certification Number" Q
 . I CODE="FY" S CODE="Claim Office #" Q
 . I CODE="F4" S CODE="Facility Certification Number" Q
 . I CODE="F5" S CODE="Medicare Version Code",LINE=$S($P(DATA,D,3)="Y":4081,1:"Regular crossover") Q
 . I CODE="F8" S CODE="Payer Claim Control Number" Q
 . I CODE="G1" S CODE="Prior Authorization Number" Q
 . I CODE="G2" S CODE="Provider Secondary Identifier" Q
 . I CODE="G3" S CODE="Predetermination of Benefits Identifier" Q
 . I CODE="G4" S CODE="Peer Review Authorization Number" Q
 . I CODE="LU" S CODE="Location Number" Q
 . I CODE="LX" S CODE="Investigational Device Exemption Identifier" Q
 . I CODE="NF" S CODE="NAIC Code" Q
 . I CODE="P4" S CODE="Demonstration Project Identifier" Q
 . I CODE="SY" S CODE="Social Security Number",LINE=$E($P(DATA,D,3),1,3)_"-"_$E($P(DATA,D,3),4,5)_"-"_$E($P(DATA,D,3),6,9) Q
 . I CODE="T4" S CODE="Claim Adjustment Indicator" Q
 . I CODE="VY" S CODE="Link Sequence Number" Q
 . I CODE="XZ" S CODE="Pharmacy Prescription Number" Q
 . I CODE="X4" S CODE="Clinical Laboratory Improvement Amendment Number" Q
 . I CODE="Y4" S CODE="Agency Claim Number" Q
 . I CODE="0B" S CODE="State License #" Q
 . I CODE="1G" S CODE="Provider UPIN" Q
 . I CODE="1J" S CODE="Care Plan Oversight Number" Q
 . I CODE="1W" S CODE="Member ID Number" Q
 . I CODE="2U" S CODE="Payer Identification #" Q
 . I CODE="4N" S CODE="Service Authorization Exception Code" D  Q
 .. I LINE=1 S LINE="Immediate/Urgent Care" Q
 .. I LINE=2 S LINE="Services Rendered in a Rectoactive Period" Q
 .. I LINE=3 S LINE="Emergency Care" Q
 .. I LINE=4 S LINE="Client has Temporary Medicaid" Q
 .. I LINE=5 S LINE="Request from County for Second Opinion to Determine if Receipient Can Work" Q
 .. I LINE=6 S LINE="Request for Override Pending" Q
 .. I LINE=7 S LINE="Special Handling"
 . I CODE="6R" S CODE="Provider Control Number" Q
 . I CODE="9A" S CODE="Repriced Claim Reference Number" Q
 . I CODE="9B" S CODE="Repriced Line Item Reference Number" Q
 . I CODE="9C" S CODE="Adjusted Repriced Claim Reference Number" Q
 . I CODE="9D" S CODE="Adjusted Repriced Line Item Reference Number" Q
 . I CODE="9F" S CODE="Referral Number"
 S CODE=$P(DATA,D,5) I $L(CODE) D  D SET(CODE,LINE)
 . S LINE=$P(CODE,D1,2)
 . I $P(CODE,D1,1)="2U" S CODE="Other Payer Primary Identifier" Q
 Q
 ;
SBR ;Display Subscriber Segment
 N CODE
 S SBR=SBR+1 I SBR>1 D SET("Other Subscriber Information",,1,1)
 S CODE=$P(DATA,D,2)
 D SET("Payer Responsibility",$S(CODE="T":"Tertiary",CODE="S":"Secondary",CODE="P":"Primary",1:"Other"))
 S CODE=$P(DATA,D,3) D  D SET("Relationship",CODE)
 . I CODE="01" S CODE="Spouse" Q
 . I CODE=18 S CODE="Self" Q
 . I CODE=19 S CODE="Child" Q
 . I CODE=20 S CODE="Employee" Q
 . I CODE=21 S CODE="Unknown" Q
 . I CODE=39 S CODE="Organ Donor" Q
 . I CODE=40 S CODE="Cadaver Donor" Q
 . I CODE=53 S CODE="Life Partner" Q
 . I CODE="G8" S CODE="Other Relationship" Q
 S CODE=$P(DATA,D,4) I $L(CODE) D SET("Group Number",CODE)
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Group Name",CODE)
 S CODE=$P(DATA,D,6) I CODE'="" D  D SET("Type of Insurance",CODE)
 . I CODE=12 S CODE="Medicare Secondary or Spouse Employer Group Health" Q
 . I CODE=13 S CODE="Medicare Secondary with Spouse Emplyer Group Health" Q
 . I CODE=14 S CODE="Medicare Secondary, No Fault Insurance as primary" Q
 . I CODE=15 S CODE="Medicare Secondary, Worker's Compensation" Q
 . I CODE=16 S CODE="Medicare Secondary, Public Health Service" Q
 . I CODE=41 S CODE="Medicare Secondary Black Lung" Q
 . I CODE=42 S CODE="Medicare Secondary Veterans Administration" Q
 . I CODE=43 S CODE="Medicare Secondary Disabled Beneficiary" Q
 . I CODE=47 S CODE="Medicare Secondary, Other Liability Insurance Primary" Q
 S CODE=$P(DATA,D,10) D  D SET("Type of Plan",CODE)
 . I CODE=11 S CODE="Other Non-Federal programs" Q
 . I CODE=12 S CODE="Preferred Provide Organization (PPO)" Q
 . I CODE=13 S CODE="Point of Service (POS)" Q
 . I CODE=14 S CODE="Exclusive Provider Organization (EPO)" Q
 . I CODE=15 S CODE="Indemnity Insurance" Q
 . I CODE=16 S CODE="Health Maintenance Organization (HMO) Medicare Risk" Q
 . I CODE=17 S CODE="Dental Maintenance Organization" Q
 . I CODE="AM" S CODE="Automobile Medical" Q
 . I CODE="BL" S CODE="Blue Cross/Blue Shield" Q
 . I CODE="CH" S CODE="Champus" Q
 . I CODE="CI" S CODE="Commercial Insurance" Q
 . I CODE="DS" S CODE="Disability" Q
 . I CODE="FI" S CODE="Federal Employees Program" Q
 . I CODE="HM" S CODE="Health Maintenance Organization" Q
 . I CODE="LM" S CODE="Liability Medical" Q
 . I CODE="MA" S CODE="Medicare Part A" Q
 . I CODE="MB" S CODE="Medicare Part B" Q
 . I CODE="MC" S CODE="Medicaid" Q
 . I CODE="OF" S CODE="Medicare Part D" Q
 . I CODE="TV" S CODE="Title V" Q
 . I CODE="VA" S CODE="Veterans Affairs Plan" Q
 . I CODE="WC" S CODE="Worker Compensation Health Claim" Q
 . I CODE="ZZ" S CODE="Mutually Defined/Unknown" Q
 Q
 ;
DATE(DATE,TYPE) ;Format Date/Time
 N D1
 S TYPE=$G(TYPE,"D8")
 I TYPE="TM" S D1=DATE G DATEQ
 I TYPE="D8"!(TYPE="DT") D  G DATEQ
 . S D1=$$FMTE^XLFDT($$HL7TFM^XLFDT($E(DATE,1,8)),1)
 . I TYPE="DT" S D1=D1_" "_$E(DATE,9,12)
 S D1=$$FMTE^XLFDT($$HL7TFM^XLFDT($P(DATE,"-",1),1))_"-"_$$FMTE^XLFDT($$HL7TFM^XLFDT($P(DATE,"-",2),1))
DATEQ ;
 Q D1
 ;
DOL(DATA) ;Format Dollars
 S DATA="$"_$FN(DATA,",",2)
 Q DATA
 ;
NAME(DATA) ;Format Person Name
 N LAST,FIRST,MI,SUF
 S LAST=$P(DATA,D,4),FIRST=$P(DATA,D,5),MI=$P(DATA,D,6),SUF=$P(DATA,D,8)
 Q LAST_$S($L(FIRST):", ",1:"")_FIRST_" "_$S($L(MI):MI_" ",1:"")_SUF
 ;
PHONE(NUM) ;Format phone number
 Q "("_$E(NUM,1,3)_") "_$E(NUM,4,6)_"-"_$E(NUM,7,10)
 ;
YN(YN) ;Translate Yes/No element
 Q $S(YN="W":"Not Applicable",YN="U":"Uknown",YN="Y":"Yes",1:"No")
 ;
ZIP(ZIP) ;Format Zip Code
 Q $E(ZIP,1,5)_$S($L(ZIP>5):"-"_$E(ZIP,6,9),1:"")
 ;
SET(TITLE,VALUE,BLANK,HEADER) ;
 D SET^IBACCWLBILLVE($G(TITLE),$G(VALUE),$G(BLANK),$G(HEADER))
 Q

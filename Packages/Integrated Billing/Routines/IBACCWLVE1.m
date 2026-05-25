IBACCWLVE1 ;EDE/TAZ - ACC (Automated Community Care) Claims - VIEW ENCOUNTER (cont'd); 12-SEP-2023 ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;THIS ROUTINE ALLOWS THE USER TO VIEW THE X12 ENCOUNTER IN READABLE FORMAT.
 ;
CAS ;Claim Level Adjustments
 N CODE
 S CODE=$P(DATA,D,2) D  D SET("Claim Adjustment Group Code",CODE)
 . I CODE="CO" S CODE="Contractual Obligations" Q
 . I CODE="CR" S CODE="Correction and Reversals" Q
 . I CODE="OA" S CODE="Other Adjustments" Q
 . I CODE="PI" S CODE="Payor Initiated Adjustments" Q
 . I CODE="PR" S CODE="Patient Responsibility" Q
 D SET("Adjustment Reason Code",$P(DATA,D,3))
 D SET("Adjustment Amount",$$DOL($P(DATA,D,4)))
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Adjustment Quantity",CODE)
 S CODE=$P(DATA,D,6) I $L(CODE) D SET("Adjustment Reason Code",CODE)
 S CODE=$P(DATA,D,7) I $L(CODE) D SET("Adjustment Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,8) I $L(CODE) D SET("Adjustment Quantity",CODE)
 S CODE=$P(DATA,D,9) I $L(CODE) D SET("Adjustment Reason Code",CODE)
 S CODE=$P(DATA,D,10) I $L(CODE) D SET("Adjustment Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,11) I $L(CODE) D SET("Adjustment Quantity",CODE)
 S CODE=$P(DATA,D,12) I $L(CODE) D SET("Adjustment Reason Code",CODE)
 S CODE=$P(DATA,D,13) I $L(CODE) D SET("Adjustment Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,14) I $L(CODE) D SET("Adjustment Quantity",CODE)
 S CODE=$P(DATA,D,15) I $L(CODE) D SET("Adjustment Reason Code",CODE)
 S CODE=$P(DATA,D,16) I $L(CODE) D SET("Adjustment Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,17) I $L(CODE) D SET("Adjustment Quantity",CODE)
 S CODE=$P(DATA,D,18) I $L(CODE) D SET("Adjustment Reason Code",CODE)
 S CODE=$P(DATA,D,19) I $L(CODE) D SET("Adjustment Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,20) I $L(CODE) D SET("Adjustment Quantity",CODE)
 Q
 ;
CLM ;Display Claim Segment
 N CODE,CODE1,PCE   ;WCJ;V41
 S CLM=CLM+1 I CLM=1 D SET("Claim Information",,1,1)
 D SET("Patient Control Number",$P(DATA,D,2))
 D SET("Total Claim Charge Amount",$$DOL($P(DATA,D,3)))
 S CODE=$P(DATA,D,6) I $L(CODE) D
 . D SET("Facility Code",$P(CODE,D1,1))
 . D SET("Facility Code Qualifier",$P(CODE,D1,2))
 . D SET("Claim Frequency",$P(CODE,D1,3))
 S CODE=$P(DATA,D,7) I CODE'="" D SET("Provider Signature on File",$$YN(CODE))
 S CODE=$P(DATA,D,8),CODE=$S(CODE="A":"Assigned",CODE="B":"Clinical Lab Services Only",1:"Not Assigned") D SET("Provide Accepts Assignment",CODE)
 D SET("Benefits Assigned",$$YN($P(DATA,D,9)))
 S CODE=$P(DATA,D,10) D SET("Release of Information",$S(CODE="I":"Informed Consent",CODE="Y":"Yes",1:""))
 I $P(DATA,D,11)'="" D SET("Signature Source","Signature provided by Provider")
 S CODE=$P(DATA,D,12) I CODE'="" D
 . F PCE=1:1:3 S CODE1=$P(CODE,D1,PCE) I CODE1'="" D
 .. I CODE1="AA" D SET($S(PCE=1:"Related Cause",1:""),"Auto Accident")
 .. I CODE1="EM" D SET($S(PCE=1:"Related Cause",1:""),"Employment")
 .. I CODE1="OA" D SET($S(PCE=1:"Related Cause",1:""),"Other Accident")
 . S CODE1=$P(CODE,D1,4) I CODE1'="" D SET("Auto Accident State or Province Code",CODE1)
 . S CODE1=$P(CODE,D1,5) I CODE1'="" D SET("Auto Accident Country Code",CODE1)
 S CODE=$P(DATA,D,13) I CODE'="" D  D SET("Special Program Code",CODE)
 . I CODE="01" S CODE="Early and Periodic Screening, Diagnosis, and Treatment (EPSDT) or Child Health Assessment Program (CHAP)" Q
 . I CODE="02" S CODE="Physically Handicapped Children's Program" Q
 . I CODE="03" S CODE="Special Federal Funding" Q
 . I CODE="05" S CODE="Disability" Q
 . I CODE="09" S CODE="Second Opinion or Surgery" Q
 S CODE=$P(DATA,D,20) I CODE'="" D  D SET("Predetermination of Benefits Code",CODE)
 . I CODE="PB" S CODE="Predetermination of Dental Benefits"
 S CODE=$P(DATA,D,21) I CODE'="" D  D SET("Delay Reason",CODE)
 . I CODE=1 S CODE="Proof of Eligibility Unknown or Unavailable" Q
 . I CODE=2 S CODE="Litigation" Q
 . I CODE=3 S CODE="Authorization Delays" Q
 . I CODE=4 S CODE="Delay in Certifying Provider" Q
 . I CODE=5 S CODE="Delay in Supplying Billing Forms" Q
 . I CODE=6 S CODE="Delay in Delivery of Custom-made Appliances" Q
 . I CODE=7 S CODE="Third Party Processing Delay" Q
 . I CODE=8 S CODE="Delay in Eligibility Determination" Q
 . I CODE=9 S CODE="Oiginal Claim Rejected/Denied Unrelate to Limitation Rules" Q
 . I CODE=10 S CODE="Administration Delay in Prior Approval Process" Q
 . I CODE=11 S CODE="Other" Q
 . I CODE=15 S CODE="Natural Disaster" Q
 Q
 ;
CRC ;Ambulance Certification
 N CNT,CODE,TITLE
 S CODE=$P(DATA,D,2) D  D SET(TITLE,$$YN($P(DATA,D,3)))
 . I CODE="07" S TITLE="Ambulance Certification" Q
 . I CODE="09" S TITLE="Durable Medical Equipment Certification" Q
 . I CODE=70 S TITLE="Hospice" Q
 . I CODE="E1" S TITLE="Spectacle Lenses" Q
 . I CODE="E2" S TITLE="Contact Lenses" Q
 . I CODE="E3" S TITLE="Spectacle Frames" Q
 . I CODE="ZZ" S TITLE="Mutually Defined EPSDT Screening Referral Information" Q
 . I CODE="75" S TITLE="Functional Limitations" Q
 ; Note:  Code 65 is a placeholder of a required field with no meaning
 F CNT=4:1:8 S CODE=$P(DATA,D,CNT) Q:CODE=""  I CODE'=65 D  D SET(TITLE,CODE)
 . S TITLE=$S(CNT=4:"Condition Code",1:"")
 . I CODE="01" S CODE="Patient was admitted to a hospital" Q
 . I CODE="04" S CODE="Patient was moved by stretcher" Q
 . I CODE="05" S CODE="Patient was unconscious or in shock" Q
 . I CODE="06" S CODE="Patient was transported in an emergency situation" Q
 . I CODE="07" S CODE="Patient had to be physically restrained" Q
 . I CODE="08" S CODE="Patient had visible hemorrhaging" Q
 . I CODE="09" S CODE="Ambulance Service was medically necessary" Q
 . I CODE=12 S CODE="Patient is confined to a bed or chair" Q
 . I CODE=38 S CODE="Certification signed by the physician is on file" Q
 . I CODE="AV" S CODE="Available - Not Used" Q
 . I CODE="IH" S CODE="Independent at Home" Q
 . I CODE="L1" S CODE="General Standard of 20 Degree or 0.5 Diopter Sphere or Cylinder Change Met" Q
 . I CODE="L2" S CODE="Replacement Due to Loss or Theft" Q
 . I CODE="L3" S CODE="Replacement Due to Breakage or Damage" Q
 . I CODE="L4" S CODE="Replacement Due to Patient Preference" Q
 . I CODE="L5" S CODE="Replacement Due to Medical Reason" Q
 . I CODE="NU" S CODE="Not Used" Q
 . I CODE="S2" S CODE="Under Treatment" Q
 . I CODE="ST" S CODE="New Service Requested" Q
 . I CODE="ZV" S CODE="Replacement Item" Q
 Q
 ;
DTP ;
 N CODE,DATE,TITLE,TYPE
 S CODE=$P(DATA,D,2),TYPE=$P(DATA,D,3),DATE=$$DATE($P(DATA,D,4),TYPE) D  D SET(TITLE,DATE)
 . I CODE="011" S TITLE="Date Shipped" Q
 . I CODE="050" S TITLE="Repricer Received Date" Q
 . I CODE="090" S TITLE="Assumed Care Date" Q
 . I CODE="091" S TITLE="Relinquished Care Date" Q
 . I CODE="096" S TITLE="Discharge " Q
 . I CODE=139 S TITLE="Estimated" Q
 . I CODE=196 S TITLE="Treatment Start Date" Q
 . I CODE=198 S TITLE="Treatment Completion Date" Q
 . I CODE=296 S TITLE="Work Return Date" Q
 . I CODE=297 S TITLE="Last Worked Date" Q
 . I CODE=304 S TITLE="Last Seen" Q
 . I CODE=314 S TITLE="Disability" Q
 . I CODE=360 S TITLE="Initial Disability Start" Q
 . I CODE=361 S TITLE="Initial Disabiliry End" Q
 . I CODE=431 S TITLE="Onset of Current Symptoms" Q
 . I CODE=434 S TITLE="Statement" Q
 . I CODE=435 S TITLE="Admission" Q
 . I CODE=439 S TITLE="Accident Date" Q
 . I CODE=441 S TITLE="Prior Placement" Q
 . I CODE=444 S TITLE="First Visit or Consultation" Q
 . I CODE=446 S TITLE="Replacement" Q
 . I CODE=452 S TITLE="Appliance Placement" Q
 . I CODE=453 S TITLE="Acute Manifestation of Chronic Condition" Q
 . I CODE=454 S TITLE="Initial Treatment" Q
 . I CODE=455 S TITLE="Last X-Ray Date" Q
 . I CODE=461 S TITLE="Last Certification Date" Q
 . I CODE=463 S TITLE="Begin Therapy Date" Q
 . I CODE=471 S TITLE="Prescription Date" Q
 . I CODE=472 S TITLE="Service Date" Q
 . I CODE=484 S TITLE="Last Menstual Period Date" Q
 . I CODE=573 S TITLE="Date Claim Paid" Q
 . I CODE=607 S TITLE="Certification Revision Date" Q
 . I CODE=738 S TITLE="Most Recent Hemoglobin or Hematocrit or Both" Q
 . I CODE=739 S TITLE="Most Recent Serum Creatine" Q
 . I CODE=999 S TITLE="Accepted with Errors" Q  ;TPF;IB*2*770v38;EBILL-9999
 Q
 ;
HCP ; Claim pricing/repricing information
 N ADD,CODE,TITLE
 S CODE=$P(DATA,D,2) D  D SET("Pricing Methodology",CODE)
 . I CODE="00" S CODE="Zero Pricing (Not Covered Under Contract" Q
 . I CODE="01" S CODE="Priced as Billed at 100%" Q
 . I CODE="02" S CODE="Priced at the Standard Fee Schedule" Q
 . I CODE="03" S CODE="Priced at a Contractual Percentage" Q
 . I CODE="04" S CODE="Bundled Pricing" Q
 . I CODE="05" S CODE="Peer Review Pricing" Q
 . I CODE="06" S CODE="Per Diem Pricing" Q
 . I CODE="07" S CODE="Flat Rate Pricing" Q
 . I CODE="08" S CODE="Combination Pricing" Q
 . I CODE="09" S CODE="Maternity Pricing" Q
 . I CODE=10 S CODE="Other Pricing" Q
 . I CODE=11 S CODE="Lower of Cost" Q
 . I CODE=12 S CODE="Ratio of Cost" Q
 . I CODE=13 S CODE="Cost Reimbursed" Q
 . I CODE=14 S CODE="Adjustment Pricing" Q
 D SET("Repriced Allowed Amount",$$DOL($P(DATA,D,3)))
 S CODE=$P(DATA,D,4) I $L(CODE) D SET("Repriced Saving Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Repricing Organizational Identifier",CODE)
 S CODE=$P(DATA,D,6) I $L(CODE) D SET("Repricing Per Diem or Flat Rate Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,7) I $L(CODE) D  D SET(TITLE,CODE)
 . I IOD="I" S TITLE="Repriced Approved DRG Code" Q
 . S TITLE="Repricing Approved Ambulatory Patient Group (APG) Code"
 S CODE=$P(DATA,D,8) I $L(CODE) D SET("Repriced Approved Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,9) I $L(CODE) D SET("Repriced Approved Revenue Code",CODE)
 S CODE=$P(DATA,D,10) I $L(CODE) D  D SET("Product or Service ID Qualifier")
 . I CODE="AD" S CODE="American Dental Association Codes" Q
 . I CODE="ER" S CODE="Jurisdiction Specific Procedure and Supply Code" Q
 . I CODE="HC" S CODE="HCPCS Code" Q
 . I CODE="HP" S CODE="HIPPS Skilled Nursing Facility Rate Code" Q
 . I CODE="IV" S CODE="HIEC Product/Service Code" Q
 . I CODE="WK" S CODE="Advanced Billing Concepts Code" Q
 S CODE=$P(DATA,D,11) I $L(CODE) D SET("Repriced Approved HCPCS Code",CODE)
 S CODE=$P(DATA,D,13) I $L(CODE) D  D SET("Repriced Approved Service Unit Count",CODE_ADD)
 . S ADD=$P(DATA,D,12)
 . I ADD="MJ" S ADD=" Minute"_$S(CODE>1:"s",1:"") Q
 . I ADD="UN" S ADD=" Unit"_$S(CODE>1:"s",1:"") Q
 . I ADD="DA" S ADD=" Day"_$S(CODE>1:"s",1:"") Q
 S CODE=$P(DATA,D,14) I $L(CODE) D  D SET("Reject Reason Code","UNKNOWN CODE")
 . I CODE="T1" S CODE="Cannot Identify Provider as TPO (Third Party Organization) Participant" Q
 . I CODE="T2" S CODE="Cannot Identify Payer as TPO (Third Party Organization) Participant" Q
 . I CODE="T3" S CODE="Cannot Identify Insured as TPO (Third Party Organization) Participant" Q
 . I CODE="T4" S CODE="Payer Name or Identifier Missing" Q
 . I CODE="T5" S CODE="Certification Information Missing" Q
 . I CODE="T6" S CODE="Claim does not contain enough information for re-pricing" Q
 S CODE=$P(DATA,D,15) I $L(CODE) D  D SET("Policy Compliance Code",CODE)
 . I CODE=1 S CODE="Procedure Followed (Compliance)" Q
 . I CODE=2 S CODE="Not Followed - Call Not Made (Non-Compliance Call Not Made" Q
 . I CODE=3 S CODE="Not Medically Necessary (Non-Compliance Non-Medically Necessary" Q
 . I CODE=4 S CODE="Not Followed Other (Non_Compliance Other" Q
 . I CODE=5 S CODE="Emergency Admit to Non-Network Hospital" Q
 S CODE=$P(DATA,D,16) I $L(CODE) D  D SET("Exception Code",CODE)
 . I CODE=1 S CODE="Non-Network Professional Provider in Network Hospital" Q
 . I CODE=2 S CODE="Emergency Care" Q
 . I CODE=3 S CODE="Services or Specialist not in Network" Q
 . I CODE=4 S CODE="Out of Service Area" Q
 . I CODE=5 S CODE="State Mandates" Q
 . I CODE=6 S CODE="Other" Q
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
 D SET^IBACCWLVE($G(TITLE),$G(VALUE),$G(BLANK),$G(HEADER))
 Q

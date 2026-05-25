IBACCWLBILLVE1A ;EDE/TAZ - ACC (Automated Community Care) Claims - VIEW ENCOUNTER (cont'd); 12-SEP-2023 ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;THIS ROUTINE CALLED BY IBACCWLBILLVE1 CODE MOVED FOR SAC RTN SIZE
 ;TPF;IB*2*770v38;EBILL-5482,5483
 ;
HI ;Display Diagnosis Codes
 ; 
 ; Returns DIAGPTRARR (Diagnosis Pointer Array) if IBFORM'="UB-04"
 ;
 N AMT,CDE,CNT,CODE,DTP,DTQ,HI,POA,QC,STR,TITLE
 S (HI,TITLE)=""
 F CNT=2:1:13 D
 . S CODE=$P(DATA,D,CNT) I CODE="" Q
 . S TITLE="",QC=$P(CODE,D1,1),IC=$P(CODE,D1,2),DTQ=$P(CODE,D1,3),DTP=$P(CODE,D1,4),AMT=$P(CODE,D1,5),POA=$P(CODE,D1,9)
 . I QC'=HI D
 .. S HI=QC
 .. I QC="ABF" S:CNT=3 TITLE="(ICD-10-CM) Additional Code(s)" Q    ;TPF;IB*2*770v38;EBILL-5482,5483
 .. I QC="ABJ" S TITLE="(ICD-10-CM) Admitting Diagnosis" S IC=$$ICDLKUP(IC) Q
 .. I QC="ABK" S TITLE="(ICD-10-CM) Primary Code" Q  ;TPF;IB*2*770v38;EBILL-5482,5483
 .. I QC="ABN" S TITLE="(ICD-10-CM) External Cause of Injury Code" S IC=$$ICDLKUP(IC) Q
 .. I QC="APR" S TITLE="(ICD-10-CM) Patient's Reason for Visit" S IC=$$ICDLKUP(IC) Q
 ..; I QC="BBQ" S TITLE="(ICD-10-PCS) Other Procedure Code" S IC=$$ICDLKUP(IC) Q   ;WCJ;V41;EBILL-5572
 ..; I QC="BBR" S TITLE="(ICD-10-PCS) Principal Procedure Code" S IC=$$ICDLKUP(IC) Q   ;WCJ;V41;EBILL-5572
 .. I QC="BBQ" S TITLE="(ICD-10-PCS) Other Procedure Code" S IC=$$PCSLKUP^IBACCWLRURREV1A(IC) Q   ;WCJ;V41;EBILL-5572
 .. I QC="BBR" S TITLE="(ICD-10-PCS) Principal Procedure Code" S IC=$$PCSLKUP^IBACCWLRURREV1A(IC) Q    ;WCJ;V41;EBILL-5572
 .. I QC="BE" S TITLE="Value Code" Q
 .. I QC="BF" S TITLE="(ICD-9-CM) Additional Code" S IC=$$ICDLKUP(IC) Q
 .. I QC="BG" S TITLE="Condition Code" Q
 .. I QC="BH" S TITLE="Occurrence Code" Q
 .. I QC="BI" S TITLE="Occurrence Span Code" Q
 .. I QC="BJ" S TITLE="(ICD-9-CM) Admitting Diagnosis" S IC=$$ICDLKUP(IC) Q
 .. I QC="BK" S TITLE="(ICD-9-CM) Primary Code" S IC=$$ICDLKUP(IC)  Q
 .. I QC="BN" S TITLE="(ICD-9-CM) External Cause of Injury Code" S IC=$$ICDLKUP(IC) Q
 .. I QC="BO" S TITLE="Common Procedural Code" Q
 .. I QC="BP" S TITLE="Anesthesia Related Surgical Procedure" Q
 .. I QC="BQ" S TITLE="(ICD-9-CM) Other Procedure Code" S IC=$$ICDLKUP(IC) Q
 .. I QC="BR" S TITLE="(ICD-9-CM) Principal Procedure Code" S IC=$$ICDLKUP(IC) Q
 .. I QC="CAH" S TITLE="Advanced Billing Concepts (ABC) Codes" Q
 .. I QC="DR" S TITLE="Diagnosis Related Group (DRG)" Q
 .. I QC="PR" S TITLE="(ICD-9-CM) Patient's Reason for Visit" S IC=$$ICDLKUP(IC) Q
 .. I QC="TC" S TITLE="Treatment Code" Q
 .. I QC="TQ" S TITLE="Systemized Nomenclature of Dentistry (SNODENT)" Q
 .;
 . I HI=QC D
 .. I QC="ABK"!(QC="ABF") S IC=$$ICDLKUP(IC) S:$G(IBFORM)'="UB-04" IC=((CNT-1)_"  ")_IC,DIAGPTRARR(CNT-1)=IC  Q  ;TPF;IB*2*770v38;EBILL-5482,5483
 .. I QC="BBQ"!(QC="BBR") S IC=$$PCSLKUP^IBACCWLRURREV1A(IC) Q
 .;
 . D SET^IBACCWLBILLVE1(TITLE,IC)
 . I DTP'="" D  D SET^IBACCWLBILLVE1(TITLE,$$DATE^IBACCWLBILLVE1(DTP,DTQ))
 .. I QC="BH" S TITLE="Occurrence Code Date" Q
 .. I QC="BI" S TITLE="Occurrence Span Code Dates" Q
 .. S TITLE="Principal Procedure Date"
 . I AMT'="" D SET^IBACCWLBILLVE1("Value Code Amount",$$DOL^IBACCWLBILLVE1(AMT))
 . I POA'="" D SET^IBACCWLBILLVE1("Present on Admission Indicator",$$YN^IBACCWLBILLVE1(POA))
 Q
 ;
 ;TAZ;IB*2*770v19;EBILL-4938
ICDLKUP(IC) ;Look up the ICD Code desciption v12
 N ICDARY,DESC,RSLT
 S IC=$E(IC,1,3)_"."_$E(IC,4,$L(IC))
 S RSLT=$$DIAGSRCH^LEX10CS(IC,.ICDARY)  ;ICR #5681 (Supported)
 S DESC="" D
 . I RSLT<0 S DESC="Unknown Code" Q
 . I $G(ICDARY(1,"IDS"))]"" S DESC=ICDARY(1,"IDS") Q
 . I $G(ICDARY(1,"LEX"))]"" S DESC=ICDARY(1,"LEX") Q
 . I $G(ICDARY(1,"MENU"))]"" S DESC=ICDARY(1,"MENU") Q
 . S DESC="Unknown Code"
ICDLKUPQ ;Exit lookup
 Q IC_" - "_DESC
 ;
 ;CALLED FROM IBACCWLBILLVE
DISUSERGROUP(USERGROUP) ;EP - RETURN USER GROUP NAME FOR WL TITLE
 ;
 N RET
 S RET=$S(USERGROUP="BILL":"Billing",USERGROUP="FRT":"Facility Revenue",USERGROUP="PTF":"PTF",USERGROUP="IV":"Insurance Verification",USERGROUP="RUR":"Revenue Utilization Review",1:"Uknown Group")
 Q RET
 ;
 ;K INCLUDE D GETINCLUSIONS^IBACCWLBILLVE1A(.INCLUDE,"BILL","O","CMS-1500")
 ;TPF;IB*2*770v53;EBILL-6203
 ;GETINCLUSIONS(INCLUDE,USRGRP,INOUT,FORM) ;EP - SET UP ARRAY HOLDING SECTIONS AND FIELD CAPTIONS TO INCLUDE IN DISPLAY
GETINCLUSIONS(INCLUDE,USRGRP,INOUT,FORM) ;EP - SET UP ARRAY HOLDING SECTIONS AND FIELD CAPTIONS TO INCLUDE IN DISPLAY
 ;
 N ACCAPPROPINCL,ACCDOLLARFRMT,ACCFIELDCAPOVER,ACCFIELDCAP,ACCHEADER,ACCSEGEXCL,LINE,TEXT
 N ACCFLDSPCFORMAT,ACCAPPLFORM,ACCSECCAPOVER,INCLUSION
 ;
 ;INOUT = I = IN PATIENT OR O = OUTPATEINT
 ;FORM = 1500, UB OR O_J430D (DENTAL)
 ;
 S INOUT=$G(INOUT)
 S FORM=$P($G(FORM),"-")  ;CMS, UB , J403D 
 ;
 Q:$G(USRGRP)=""
 ;
 S INCLUSION=USRGRP_"INCLUSION"
 F LINE=1:1 S TEXT=$P($T(@INCLUSION+LINE),";;",2,9999) Q:TEXT[("END")  D
 .S ACCAPPROPINCL=$P(TEXT,";",6)    ;IF APPROPRIATE THIS PATTYPE_FORM IS IN THIS STRING
 .Q:ACCAPPROPINCL'[("|"_INOUT_"_"_FORM_"|")
 .S ACCHEADER=$P(TEXT,";")          ;STANDARD VE SECTION HEADER - ENTER THE VE SECTION HEADER TO DISPLAY THE SEGMENT HEADER AND ANY FIELDS UNDER IT
 .S ACCFIELDCAP=$P(TEXT,";",2)      ;STANDARD VE FIELD CAPTION - ENTER THE VE FIELD CAPTION TO DISPLAY THE FIELD CONTENT
 .S ACCSECCAPOVER=$P(TEXT,";",3)    ;VE SECTION CAPTION OVERRIDE - REPLACE VE SEGMENT CAPTION WITH THIS
 .S ACCFIELDCAPOVER=$P(TEXT,";",4)  ;VE FIELD CAPTION OVERRIDE - REPLACE VE FIELD CAPTION WITH THIS
 .S ACCDOLLARFRMT=$P(TEXT,";",5)    ;SHOULD AMOUNT HAVE $ FORMAT
 .S ACCAPPLFORM=$P(TEXT,";",6)      ;THIS SEGMENT OR FIELD IS DISPLAYED GIVEN A FORM AND INOUT E.G. O_CMS  OUTPATIENT CMS 
 .S ACCSEGEXCL=$P(TEXT,";",7)       ;SEGMENT EXCLUSION. EXCLUDE SVD FOR THE SEGMENT OR FIELD
 .S ACCFLDSPCFORMAT=$P(TEXT,";",8)  ;SPECIAL FIELD FORMATTING E.G. SHOULD THREE LINES BE PRINTED AFTER THE FIELD? MUMPS CODE
 .;
 .Q:(ACCHEADER="")
 .I ACCHEADER'="",(ACCFIELDCAP="") D  Q
 ..S INCLUDE(ACCHEADER)=U_ACCSECCAPOVER_U_ACCAPPROPINCL_U_ACCSEGEXCL
 .;
 .S INCLUDE(ACCHEADER,ACCFIELDCAP)=ACCHEADER_U_ACCFIELDCAP_U_ACCSECCAPOVER_U_ACCFIELDCAPOVER_U_ACCDOLLARFRMT_U_ACCAPPROPINCL_U_ACCFLDSPCFORMAT_U_ACCSEGEXCL  ;IF '$D(INCLUDE(HEADER,FIELDCAP)) DO NOT DISPLAY
 .;S INCLUDE(ACCHEADER)=LINENUM  ;USE LINENUM TO OVERRIDE VALMCNT SEQUENTAIL INCREMENT
 .;IN SET API; S VALMCNT=INCLUDE(ACCHEADER) SETS THE BEGINNING OF A SECTION'S RECORD
 .;THEORETICALLY MOVING SECTIONS BELOW UNDER THE INCLUSION TAG WILL MOVE THE SECTIONS
 .;IN THE DATA ARRAY 
 Q
 ;FORMAT FOR SECTION AND FIELD INCLUSION
 ;VE SECTION HEADER  ; VE FIELD CAPTION ; SECTION HEADER OVERRIDE ; FIELD CAPTION OVERRIDE ; FIELD IS INCLUDED FOR GIVEN PAT TYPE_FORM
 ;SETTING UP  YET ANOTHER PARAMETER WITH A NUMBER COULD BE USED TO OVERRIDE THE STANDARD LM SEQUENTIUAL SETTING
 ;OF VALMCNT WHICH DETERMINES THE LINE NUMBER USED BY LM SET TO PLACE THE LINE INTO THE VALMAR DATA ARRAY.
 ;
BILLINCLUSION ;;
 ;;Billing Provider;Name;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Billing Provider;CMS National Provider Identifier;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Billing Provider;Tax Identification #;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Billing Provider;Contact;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Billing Provider;Phone;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Claim Information;Facility Code;;TOB / POS;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Claim Information;Facility Code Qualifier;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Claim Information;Claim Frequency;;;;|O_CMS|I_UB|O_UB|I_CMS|O_J430D|
 ;;Claim Information;Service Date;;;;|O_J430D|
 ;;Claim Information;Discharge;;;;|I_UB|
 ;;Claim Information;Statement;;;;|I_UB|O_UB|
 ;;Claim Information;Admission;;;;|I_UB|I_CMS|
 ;;Claim Information;Admission Type Code;;;;|I_UB|O_UB|
 ;;Claim Information;Admission Source Code;;;;|I_UB|O_UB|
 ;;Claim Information;Patient Status Code;;;;|O_UB|
 ;;Claim Information;(ICD-10-CM) Primary Code;;;;|O_CMS|I_UB|O_UB|I_CMS|
 ;;Claim Information;Present on Admission Indicator;;;;|I_UB|
 ;;Claim Information;(ICD-10-CM) Patient's Reason for Visit;;;;|O_UB|
 ;;Claim Information;(ICD-10-CM) Additional Code(s);;;;|O_CMS|I_UB|I_CMS|
 ;;Claim Information;Diagnosis Related Group (DRG);;;;|I_UB|
 ;;Claim Information;(ICD-10-PCS) Principal Procedure Code;;;;|I_UB|
 ;;Claim Information;Principal Procedure Date;;;;|I_UB|
 ;;Claim Information;(ICD-10-PCS) Other Procedure Code;;;;|I_UB|
 ;;Claim Information;Occurrence Code;;;;|O_UB|
 ;;Claim Information;Occurrence Code Date;;;;|O_UB|
 ;;Claim Information;Occurrence Span;;;;|I_UB|
 ;;Claim Information;Occurrence Span Dates;;;;|I_UB|
 ;;Claim Information;Value Code;;;;|I_UB|
 ;;Claim Information;Value Code Amount;;;;|I_UB|
 ;;Rendering Provider;Name;;;;|O_CMS|I_CMS|O_J430D|O_UB|
 ;;Rendering Provider;CMS National Provider Identifier;;;;|O_CMS|I_CMS|O_J430D|O_UB|
 ;;Rendering Provider;Provider Code;;;;|O_J430D|
 ;;Rendering Provider;Taxonomy Code;;;;|O_J430D|
 ;;Attending Physician;Name;;;;|I_UB|O_UB|
 ;;Attending Physician;CMS National Provider Identifier;;;;|I_UB|O_UB|
 ;;Referring Provider;Name;;;;|I_CMS|O_CMS|O_UB|
 ;;Referring Provider;CMS National Provider Identifier;;;;|I_CMS|O_CMS|O_UB|
 ;;Operatinging Provider;Name;;;;|I_UB|
 ;;Operating Provider;CMS National Provider Identifier;;;;|I_UB|
 ;;Service Location;Name;;;;|O_CMS|O_UB|I_CMS|
 ;;Service Location;CMS National Provider Identifier;;;;|O_CMS|O_UB|I_CMS|
 ;;Payer;;;;;|O_CMS|O_UB|I_CMS|O_J430D|;~N3~N4~
 ;;Payer;Assigned Number;;;;|O_CMS|O_UB|I_CMS|O_J430D|;~N3~N4~;I VALUE>1 F X=1:1:3 D SET1("","")
 ;;Payer;Service Line Revenue Code;;;;|I_UB|O_UB|
 ;;Payer;Procedure Code;;;;|O_CMS|O_UB|I_CMS|O_J430D|;~SVD~
 ;;Payer;Procedure Modifier;;;;|I_CMS|O_CMS|;~SVD~
 ;;Payer;Description;;;;|O_J430D|;
 ;;Payer;Diagnosis Code Pointer;;;;|O_CMS|I_CMS|
 ;;Payer;Service Date;;;;|O_CMS|O_UB|I_CMS|
 ;;Payer;Product or Service ID Qualifier;;;;|O_UB|
 ;;Payer;National Drug Code or Universal Product Number;;;;|O_UB|
 ;;Payer;Place of Service Code;;;;|O_J430D|
 ;;Payer;Oral Cavity Designation Code;;;;|O_J430D|
 ;;Payer;Diagnosis Code;;;;|O_J430D|
 ;;Payer;Service Line Paid Amount;;;$;|O_CMS|I_CMS|O_UB|
 ;;Payer;Paid Service Unit Count;;;;|O_CMS|I_CMS|O_UB|
 ;;Billing Provider;Name;;;;|I_CMS|
 ;;Billing Provider;CMS National Provider Identifier;;;;|I_CMS|
 ;;Billing Provider;Tax Identification #;;;;|I_CMS|
 ;;Billing Provider;Contact;;;;|I_CMS|
 ;;Billing Provider;Phone;;;;|I_CMS|
 ;;END

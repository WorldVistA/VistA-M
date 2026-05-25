IBACCWLVE1A ;EDE/TAZ - ACC (Automated Community Care) Claims - VIEW ENCOUNTER (cont'd); 12-SEP-2023 ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;THIS ROUTINE CALLED BY IBACCWLVE1 CODE MOVED FOR SAC RTN SIZE
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
 . D SET^IBACCWLVE1(TITLE,IC)
 . I DTP'="" D  D SET^IBACCWLVE1(TITLE,$$DATE^IBACCWLVE1(DTP,DTQ))
 .. I QC="BH" S TITLE="Occurrence Code Date" Q
 .. I QC="BI" S TITLE="Occurrence Span Code Dates" Q
 .. S TITLE="Principal Procedure Date"
 . I AMT'="" D SET^IBACCWLVE1("Value Code Amount",$$DOL^IBACCWLVE1(AMT))
 . I POA'="" D SET^IBACCWLVE1("Present on Admission Indicator",$$YN^IBACCWLVE1(POA))
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

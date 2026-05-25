IBACCWLVE3 ;EDE/TAZ - ACC (Automated Community Care) Claims - VIEW ENCOUNTER (cont'd); 12-SEP-2023 ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;THIS ROUTINE ALLOWS THE USER TO VIEW THE X12 ENCOUNTER IN READABLE FORMAT.
 ;
SV1 ; Professional Service
 N CNT,INFO
 S INFO=$P(DATA,D,2) D
 . S CODE=$P(INFO,D1,1) D  D SET("Product/Service ID",CODE)
 .. I CODE="ER" S CODE="Jurisdiction Specific Procedure and Supply Code" Q
 .. I CODE="HC" S CODE="HCPCS Code",$P(INFO,D1,2)=$$HCPCS($P(INFO,D1,2)) Q
 .. I CODE="IV" S CODE="HIEC Product/Service Code" Q
 .. I CODE="WK" S CODE="Advanced Billing Concepts Code" Q
 .. S CODE="UNKNOWN"
 . D SET("Procedure Code",$P(INFO,D1,2))
 . F CNT=3:1:6 S CODE=$P(INFO,D1,CNT) Q:CODE=""  S TITLE=$S(CNT=3:"Procedure Modifier",1:"") D SET(TITLE,$$CPTMOD(CODE))
 . S CODE=$P(INFO,D1,7) I $L(CODE) D SET("Description",CODE)
 D SET("Line Item Charge",$$DOL($P(DATA,D,3)))
 D SET("Quantity",$P(DATA,D,5)_$S($P(DATA,D,4)="MJ":" Minute(s)",1:" Unit(s)"))
 S CODE=$P(DATA,D,6) I $L(CODE) D SET("Place of Service",CODE)
 ;S INFO=$P(DATA,D,8) F CNT=1:1:4 S CODE=$P(INFO,D1,CNT) I $L(CODE) S TITLE=$S(CNT=1:"Diagnosis Code Pointer",1:"") D SET(TITLE,CODE)  ;TPF;IB*2*770v38;EBILL-5483
 S INFO=$P(DATA,D,8) F CNT=1:1:4 S CODE=$P(INFO,D1,CNT) I $L(CODE) S:$D(DIAGPTRARR(CODE)) CODE=DIAGPTRARR(CODE) S TITLE=$S(CNT=1:"Diagnosis Code Pointer",1:"") D SET(TITLE,CODE)
 S CODE=$P(DATA,D,10) I $L(CODE) D SET("Emergency Indicator",$$YN(CODE))
 S CODE=$P(DATA,D,12) I $L(CODE) D SET("EPSDT Indicator",$$YN(CODE))
 S CODE=$P(DATA,D,13) I $L(CODE) D SET("Family Planning Indicator",$$YN(CODE))
 S CODE=$P(DATA,D,16) I $L(CODE) D SET("Co-Pay Status Code",$S(CODE=0:"Copay Exempt",1:"UNKNOWN"))
 Q
 ;
SV2 ;Institutional Service Line
 N CNT,INFO
 D SET("Service Line Revenue Code",$P(DATA,D,2))
 S INFO=$P(DATA,D,3) D
 . S CODE=$P(INFO,D1,1) D  D SET("Product/Service ID",CODE)
 .. I CODE="ER" S CODE="Jurusdiction Specific Procedure and Supply Code" Q
 .. I CODE="HC" S CODE="HCPCS Code",$P(INFO,D1,2)=$$HCPCS($P(INFO,D1,2)) Q
 .. I CODE="HP" S CODE="HIPPS Skilled Nursing Facility Rate Code" Q
 .. I CODE="IV" S CODE="HIEC Product/Service Code" Q
 .. I CODE="WK" S CODE="Advanced Billing Concepts Code" Q
 . D SET("Procedure Code",$P(INFO,D1,2))
 . F CNT=3:1:6 S CODE=$P(INFO,D1,CNT) Q:CODE=""  S TITLE=$S(CNT=3:"Procedure Modifier",1:"") D SET(TITLE,$$CPTMOD(CODE))
 . S CODE=$P(INFO,D1,7) I $L(CODE) D SET("Description",$$CPTMOD(CODE))
 D SET("Line Item Charge",$$DOL($P(DATA,D,4)))
 D SET("Quantity",$P(DATA,D,6)_$S($P(DATA,D,5)="DA":" Day(s)",1:" Unit(s)"))
 S CODE=$P(DATA,D,8) I $L(CODE) D SET("Line Item Denied Charge or Non-Covered Charge Amount",CODE)
 Q
 ;
SV3 ;Dental Service
 N CNT
 S INFO=$P(DATA,D,2) D
 . S CODE=$P(INFO,D1,1) D  D SET("Product/Service ID",CODE)
 .. I CODE="AD" S CODE="American Dental Association Codes" Q
 .. I CODE="CDT" S CODE="Current Dental Terminology" Q
 . D SET("Procedure Code",$P(INFO,D1,2))
 . F CNT=3:1:6 S CODE=$P(INFO,D1,CNT) Q:CODE=""  S TITLE=$S(CNT=3:"Procedure Modifier",1:"") D SET(TITLE,$$CPTMOD(CODE))
 . S CODE=$P(INFO,D1,7) I $L(CODE) D SET("Description",$$CPTMOD(CODE))
 D SET("Line Item Charge",$$DOL($P(DATA,D,3)))
 D SET("Place of Service Code",$P(DATA,D,4))
 S CODE=$P(DATA,D,5) F CNT=1:1:5 D SET($S(CNT=1:"Oral Cavity Designation Code",1:""),$P(CODE,D1,CNT))
 S CODE=$P(DATA,D,6) I $L(CODE) D  D SET("Prothesis, Crown, or Inlay Code",CODE)
 . I CODE="I" S CODE="Initial Placement" Q
 . I CODE="R" S CODE="Replacement" Q
 S CODE=$P(DATA,D,7) I $L(CODE) D SET("Procedure Count",CODE)
 S CODE=$P(DATA,D,12) F CNT=1:1:4 D SET($S(CNT=1:"Diagnosis Code",1:""),$P(CODE,D1,CNT))
 Q
 ;
SV5 ;DME Service
 N INFO
 S INFO=$P(DATA,D,2) D
 . S CODE=$P(INFO,D1,1) D  D SET("Product/Service ID",CODE)
 .. I CODE="HC" S CODE="HCPCS Code",$P(INFO,D1,2)=$$HCPCS($P(INFO,D1,2))
 . D SET("Procedure Code",$P(INFO,D1,2))
 D SET("Length of Medical Necessity",$P(DATA,D,4)_$S($P(DATA,D,3)="DA":" Day(s)",1:""))
 D SET("DME Rental Price",$$DOL($P(DATA,D,5)))
 D SET("DME Purchase Price",$$DOL($P(DATA,D,6)))
 S CODE=$P(DATA,D,7) D  D SET("Rental Unit Price Indicator",CODE)
 . I CODE=1 S CODE="Weekly" Q
 . I CODE=4 S CODE="Monthly" Q
 . I CODE=1 S CODE="Daily" Q
 Q
 ;
SVD ;Line Adjudication Information
 N CNT
 D SET("Other Payer Primary Identifier",$P(DATA,D,2))
 D SET("Service Line Paid Amount",$P(DATA,D,3))
 S INFO=$P(DATA,D,4) D
 . S CODE=$P(INFO,D1,1) D  D SET("Product/Service ID",CODE)
 .. I CODE="AD" S CODE="American Dental Association Codes" Q
 .. I CODE="ER" S CODE="Jurusdiction Specific Procedure and Supply Code" Q
 .. I CODE="HC" S CODE="HCPCS Code",$P(INFO,D1,2)=$$HCPCS($P(INFO,D1,2)) Q
 .. I CODE="HP" S CODE="HIPPS Skilled Nursing Facility Rate Code" Q
 .. I CODE="IV" S CODE="HIEC Product/Service Code" Q
 .. I CODE="WK" S CODE="Advanced Billing Concepts Code" Q
 . D SET("Procedure Code",$P(INFO,D1,2))
 . F CNT=3:1:6 S CODE=$P(INFO,D1,CNT) Q:CODE=""  S TITLE=$S(CNT=3:"Procedure Modifier",1:"") D SET(TITLE,$$CPTMOD(CODE))
 . S CODE=$P(INFO,D1,7) I $L(CODE) D SET("Description",$$CPTMOD(CODE))
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Service Line Revenue Code",CODE)
 D SET("Paid Service Unit Count",$P(DATA,D,6))
 S CODE=$P(DATA,D,7) I $L(CODE) D SET("Bundled or Unbundled Line Number",CODE)
 Q
 ;
CPTMOD(CODE) ;CPT Code Modifier lookup v12
 N CPTARY,RSLT
 S RSLT=$$MOD^ICPTMOD(CODE,.CPTARY)  ;ICR #1996 (Supported)
 I RSLT'["" S CODE=CODE_" - Unknown Code" G CPTMODQ
 S CODE=CODE_" - "_$P(RSLT,U,3)
CPTMODQ Q CODE
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
HCPCS(CODE) ;CPT Code lookup v12
 N CPTARY,RSLT
 S RSLT=$$CPT^ICPTCOD(CODE,.CPTARY)   ;ICR #1995 (Supported)
 I RSLT'["" S CODE=CODE_" - Unknown Code" G HCPCSQ
 S CODE=CODE_" - "_$P(RSLT,U,3)
HCPCSQ Q CODE
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

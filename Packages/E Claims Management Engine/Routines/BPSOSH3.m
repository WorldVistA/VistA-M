BPSOSH3 ;AITC/MRD - Clinical Segment ;03/06/2025
 ;;1.0;E CLAIMS MGMT ENGINE;**40,41**;JUN 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
DXFIELDS ; Conditionally populate Diagnosis related fields.
 ;
 ; There will be a diagnosis (Dx) code only if:
 ;   o The OPECC performed the RED Resubmit with Edits Action from
 ;     the ECME User Screen.
 ;   o The Pharmacist performed the DIA Action from the Reject
 ;     Information Screen.
 ;   o The previous claim had a Dx code due to one of those reasons.
 ;
 N CLAIM,COB,DXCODE,FIELDIEN,FILL,IEN57,IEN59,RXIEN
 ;
 ; NCPDP field 424, Diagnosis Code.
 ;
 S FIELDIEN=$O(^BPSF(9002313.91,"B",424,""))
 ;
 ; First, pull the Dx code from the list of override fields.  A
 ; value of "REMOVED" indicates that the claim should be resubmitted
 ; without using a previously sent diagnosis code (i.e. do not
 ; populate the Diagnosis related fields on this claim).
 ;
 S DXCODE=$G(BPS("OVERRIDE","RX",1,FIELDIEN))
 I DXCODE="REMOVED" Q
 ;
 ; If no Dx code was found in the list of override fields,
 ; then check the most recent previous claim, if any.
 ;
 I DXCODE="" D
 . S IEN59=+$G(BPS("RX",BPS(9002313.0201),"IEN59"))
 . I IEN59="" Q
 . S IEN57=$O(^BPSTL("B",IEN59,""),-1)
 . I IEN57="" Q
 . S CLAIM=$$GET1^DIQ(9002313.57,IEN57,3,"I")
 . I CLAIM="" Q
 . S DXCODE=$$GET1^DIQ(9002313.0201,1_","_CLAIM,424)
 . S DXCODE=$TR($E(DXCODE,3,17)," ")
 . Q
 ;
 ; If still no Dx code, then if this is a refill, look at
 ; the most recently submitted claim on the previous fill.
 ; If that claim has a Dx Code, send that on this claim.
 ;
 I DXCODE="" D
 . S IEN59=+$G(BPS("RX",BPS(9002313.0201),"IEN59"))
 . I IEN59="" Q
 . S FILL=$$GET1^DIQ(9002313.59,IEN59,9,"I")
 . I +FILL=0 Q  ; Quit if original fill.
 . S FILL=FILL-1
 . S RXIEN=$$GET1^DIQ(9002313.59,IEN59,1.11,"I")
 . I RXIEN="" Q
 . S COB=$$GET1^DIQ(9002313.59,IEN59,18,"I")
 . I +COB=0 S COB=1
 . S IEN59=RXIEN_"."_$TR($J(FILL,4)," ","0")_COB
 . S CLAIM=$$GET1^DIQ(9002313.59,IEN59,3,"I")
 . I CLAIM="" Q
 . S DXCODE=$$GET1^DIQ(9002313.0201,1_","_CLAIM,424)
 . S DXCODE=$TR($E(DXCODE,3,17)," ")
 . Q
 ;
 ; If Dx code blank, then Quit; don't populate the Diagnosis fields.
 ;
 I DXCODE="" Q
 ;
 ; NCPDP field 424, Diagnosis Code (strip any decimal point).
 ;
 S BPS("RX",BPS(9002313.0201),"Diagnosis Code")=$TR(DXCODE,".")
 D XFLDCODE^BPSOSCF(230,FIELDIEN,"GFS")
 ;
 ; NCPDP field 491, Diagnosis Code Count.
 ;
 S FIELDIEN=$O(^BPSF(9002313.91,"B",491,""))
 D XFLDCODE^BPSOSCF(230,FIELDIEN,"GFS")
 ;
 ; NCPDP field 492, Diagnosis Code Qualifier.
 ;
 S FIELDIEN=$O(^BPSF(9002313.91,"B",492,""))
 D XFLDCODE^BPSOSCF(230,FIELDIEN,"GFS")
 ;
 Q
 ;
CLINICAL ; Conditionally create the Clinical Segment.
 ;
 ; The Clinical Segment is created only if there is a diagnosis code.
 ; There will be a diagnosis (Dx) code only if:
 ;   o The OPECC performed the RED Resubmit with Edits Action from
 ;     the ECME User Screen.
 ;   o The Pharmacist performed the DIA Action from the Reject
 ;     Information Screen.
 ;   o The previous claim had a Dx code due to one of those reasons.
 ; SEGREC is initiated in XLOOP^BPSOSH2.
 ;
 N DXCODE,FLDDATA
 ;
 ; Pull the diagnosis (Dx) code from the claim.  If blank, Quit.
 ;
 S DXCODE=$G(BPS(9002313.0201,IEN(9002313.0201),424,"I"))
 I DXCODE="" Q
 ;
 ; First add the segement ID.
 ;
 S SEGREC=SEGREC_$C(28)_$$SEGID^BPSOSH2(230)
 ;
 ; NCPDP field 491, Diagnosis Code Count.
 ;
 S FLDDATA=$G(BPS(9002313.0201,IEN(9002313.0201),491,"I"))
 S SEGREC=SEGREC_$C(28)_FLDDATA
 ;
 ; NCPDP field 492, Diagnosis Code Qualifier.
 ;
 S FLDDATA=$G(BPS(9002313.0201,IEN(9002313.0201),492,"I"))
 S SEGREC=SEGREC_$C(28)_FLDDATA
 ;
 ; NCPDP field 424, Diagnosis Code.
 ;
 S SEGREC=SEGREC_$C(28)_DXCODE
 ;
 S DATAFND=1
 ;
 Q
 ;
PREG ; Conditionally populate the field Pregnancy Indicator.
 ;
 ; There will be a pregnancy indicator only if the Pharmacist performed
 ; the PRG Action from the Reject Information Screen or the previous
 ; claim had this field populated.
 ;
 N CLAIM,FIELDIEN,IEN57,IEN59,PREG,RXIEN
 ;
 ; NCPDP field 335, Pregnancy Indicator.
 ;
 S FIELDIEN=$O(^BPSF(9002313.91,"B",335,""))
 ;
 ; First, pull the pregnancy indicator from the list of override fields.
 ;
 S PREG=$G(BPS("OVERRIDE",FIELDIEN))
 ;
 ; If no pregnancy indicator was found in the list of override fields,
 ; then check the most recent previous claim, if any.
 ;
 I PREG="" D
 . S IEN59=+$G(BPS("RX",1,"IEN59"))
 . I IEN59="" Q
 . S IEN57=$O(^BPSTL("B",IEN59,""),-1)
 . I IEN57="" Q
 . S CLAIM=$$GET1^DIQ(9002313.57,IEN57,3,"I")
 . I CLAIM="" Q
 . S PREG=$TR($E($$GET1^DIQ(9002313.02,CLAIM,335),3)," ")
 . Q
 ;
 ; Quit if no value found.
 ;
 I PREG="" Q
 ;
 ; NCPDP field 335, Pregnancy Indicator.
 ;
 S BPS("Patient","Pregnancy Indicator")=PREG
 D XFLDCODE^BPSOSCF(110,FIELDIEN,"GFS")
 ;
 Q
 ;

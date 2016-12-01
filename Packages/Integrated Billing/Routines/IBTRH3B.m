IBTRH3B ;ALB/VAD - IBT HCSR RESPONSE VIEW - Display set up ;02-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETSVC()    ; Get the Service Detail
 N DLN,I
 Q:'$G(IBTRIEN)
 I '$D(DATA(16)) D  Q
 . S DLN="",$E(DLN,36)="SERVICE DETAIL" D SETDLN(DLN)
 . S DLN="",DLN="  No Service Detail Lines available" D SETDLN(DLN)
 S I=0 F  S I=$O(DATA(16,I)) Q:I=""  D
 . S DLN="",$E(DLN,36)="SERVICE DETAIL - Line # "_I D SETDLN(DLN)
 . D GETSVCL(I)
 D SETDLN("")
 Q
 ;
GETSVCL(LN) ; Get the Service Detail
 N DLN,HCTR,I,SQ,VAL1,VAL3,TMPARY,Z1
 ;
 ; - Health Care Services Review info -
 S DLN="  Health Care Services Review" D SETDLN(DLN,"B")
 I $TR($G(DATA(16,LN,11)),"^","")'="" D
 . S VAL1=$P($G(DATA(16,LN,11)),U,1)_",",VAL3=$P($G(DATA(16,LN,11)),U,3)_","
 . S DLN="  Certification Action:  "
 . I $L($$GET1^DIQ(356.02,VAL1,.01)) S DLN=DLN_$$GET1^DIQ(356.02,VAL1,.01)_" - "_$$GET1^DIQ(356.02,VAL1,.02)  ;[356.2216,11.01]
 . D SETDLN(DLN)
 . S DLN="  Review Identification #:  "_$P($G(DATA(16,LN,11)),U,2) D SETDLN(DLN)  ;[356.2216,11.02]
 . S DLN="  Review Decision Reason:  "
 . I $L($$GET1^DIQ(356.021,VAL3,.01)) S DLN=DLN_$$GET1^DIQ(356.021,VAL3,.01)_" - "_$E($$GET1^DIQ(356.021,VAL3,.02),1,45)  ;[356.22,11.03]
 . D SETDLN(DLN)
 . S DLN="  Second Surgical Opinion Ind:  "_$$EXTERNAL^DILFD(356.2216,11.04,,$P($G(DATA(16,LN,11)),U,4)) D SETDLN(DLN)  ;[356.2216,11.04]
 I $TR($G(DATA(16,LN,11)),"^","")="" S DLN="  No Health Care Services Review Information"
 D SETDLN("")
 ;
 S DLN="  Admin Ref #:  "_$P($G(DATA(16,LN,9)),U,2) D SETDLN(DLN)  ;[356.2216,9.02]
 S DLN="  Previous Review Autho #:  "_$P($G(DATA(16,LN,9)),U,1) D SETDLN(DLN)  ;[356.2216,9.01]
 D SETDLN("")
 ;
 S DLN="  Proposed/Actual Service Date:  "_$$FMTE^XLFDT($P($G(DATA(16,LN,0)),U,11))
 I $P($G(DATA(16,LN,0)),U,17)'="" S DLN=DLN_" - "_$$FMTE^XLFDT($P($G(DATA(16,LN,0)),U,17))
 D SETDLN(DLN)  ;[356.2216,.11] - [356.2216,.17]
 S DLN="  Cert. Effective Date:  "_$$FMTE^XLFDT($P($G(DATA(16,LN,0)),U,14))
 I $P($G(DATA(16,LN,0)),U,16)'="" S DLN=DLN_" - "_$$FMTE^XLFDT($P($G(DATA(16,LN,0)),U,16))
 D SETDLN(DLN)  ;[356.2216,.14] - [356.2216,.16)
 S DLN="  Cert. Issue Date:  "_$$FMTE^XLFDT($P($G(DATA(16,LN,0)),U,12))  ;[356.2216,.12]
 S $E(DLN,44)="Cert. Expiration Date:  "_$$FMTE^XLFDT($P($G(DATA(16,LN,0)),U,13)) D SETDLN(DLN)  ;[356.2216,.13]
 D SETDLN("")
 ;
 ; - Request for Additional Information -
 ;    > Up to 12 LOINC codes
 S DLN="  Request for Additional Information" D SETDLN(DLN,"B")
 S HCTR=+$P($G(DATA(16,LN,10,0)),U,4)
 I +HCTR F SQ=1:1:HCTR D
 . S DLN="    LOINC: "_+I D SETDLN(DLN)
 . S DLN="    Code List Qualifier Code:  "_$$GET1^DIQ(365.023,+$P($G(DATA(16,LN,10,SQ)),U,2),.02) D SETDLN(DLN)  ;[356.2216,10.02 ptr to #356.006]
 . S DLN="    Industry Code:  "_$P($G(DATA(16,LN,10,SQ)),U,3) D SETDLN(DLN)  ;[356.2216,10.03]
 . D SETDLN("")
 I '+HCTR S DLN="    No Request for Additional Information" D SETDLN(DLN),SETDLN("")
 ;
 ; - Professional Service info if #356.2216,1.12 = "P"
 I $P($G(DATA(16,LN,1)),U,12)="P" D
 . S DLN="  Professional Service" D SETDLN(DLN,"B")
 . S DLN="  Product or Service ID Qualifier:  "_$$EXTERNAL^DILFD(356.2216,1.01,,$P(DATA(16,LN,1),U,1)) D SETDLN(DLN)  ;[356.2216,1.01]
 . S DLN="  Procedure Code:  "_$$EXTERNAL^DILFD(356.2216,1.02,,$P(DATA(16,LN,1),U,2)) D SETDLN(DLN)  ;[356.2216,1.02]
 . I $P($P(DATA(16,LN,1),U,3),";",1)'="" S DLN="  Procedure Code:  "_$$EXTERNAL^DILFD(356.2216,1.03,,$P(DATA(16,LN,1),U,3)) D SETDLN(DLN)  ;[356.2216,1.03]
 . S DLN="  Procedure Modifier:  "_$P($G(^DIC(81.3,+$P(DATA(16,LN,1),U,4),0)),U,1)  ;[356.2216,1.04-1.07] ==> DBIA#3026
 . F SQ=5,6,7 I $L($P(DATA(16,LN,1),U,SQ)) S DLN=DLN_", "_$P($G(^DIC(81.3,+$P(DATA(16,LN,1),U,SQ),0)),U,1)  ; DBIA#3026
 . D SETDLN(DLN)
 . S DLN="  Procedure Code Description:  "_$P(DATA(16,LN,1),U,8) D SETDLN(DLN)  ;[356.2216,1.08]
 . S DLN="  Procedure Code (range of procedure code. This is ending):  "_$$EXTERNAL^DILFD(356.2216,1.03,,$P(DATA(16,LN,1),U,3)) D SETDLN(DLN)  ;[356.2216,1.03]
 . S DLN="  Service Line Amount:  "_$S(+$P(DATA(16,LN,1),U,9):"$",1:"")_$P(DATA(16,LN,1),U,9) D SETDLN(DLN)  ;[356.2216,1.09]
 . S DLN="  Unit or Basis for Measurement Code:  "_$$EXTERNAL^DILFD(356.2216,1.1,,$P(DATA(16,LN,1),U,10)) D SETDLN(DLN)  ;[356.2216,1.1]
 . S DLN="  Service Unit Count:  "_$P(DATA(16,LN,1),U,11) D SETDLN(DLN)  ;[356.2216,1.11]
 . S DLN="  Diagnosis Code Pointer:  "_$$EXTERNAL^DILFD(356.2216,2.01,,$P($G(DATA(16,LN,2)),U,1)) D SETDLN(DLN)  ;[356.2216,2.01-2.04]
 . F SQ=2,3,4 I $L($P($G(DATA(16,LN,2)),U,SQ)) S DLN="",$E(DLN,28)=$$EXTERNAL^DILFD(356.2216,(2+(.01*SQ)),,$P($G(DATA(16,LN,2)),U,SQ)) D SETDLN(DLN)
 . S DLN="  EPSDT Indicator:  "_$$EXTERNAL^DILFD(356.2216,2.05,,$P($G(DATA(16,LN,2)),U,5)) D SETDLN(DLN)  ;[356.2216,2.05]
 . S DLN="  Nursing Home Level of Care:  "_$$GET1^DIQ(356.019,+$P($G(DATA(16,LN,2)),U,9),.02) D SETDLN(DLN)  ;[356.2216,2.09 ptr to #356.019]
 . D SETDLN("")
 ;
 ; - Institutional Service Line info if #356.2216,1.12 = "I"
 I $P($G(DATA(16,LN,1)),U,12)="I" D
 . S DLN="  Institutional Service Line" D SETDLN(DLN,"B")
 . S DLN="  Service Line Revenue Code:  "_$$GET1^DIQ(399.2,+$P($G(DATA(16,LN,2)),U,6),.02) D SETDLN(DLN)   ; [[356.2216,2.06 ptr to #399.2]
 . S DLN="  Product or Service ID Qualifier:  "_$$EXTERNAL^DILFD(356.2216,1.01,,$P(DATA(16,LN,1),U,1)) D SETDLN(DLN)  ;[356.2216,1.01]
 . S DLN="  Procedure Code:  "_$$EXTERNAL^DILFD(356.2216,1.02,,$P(DATA(16,LN,1),U,2)) D SETDLN(DLN)  ;[356.2216,1.02]
 . I $P($P(DATA(16,LN,1),U,3),";",1)'="" S DLN="  Procedure Code:  "_$$EXTERNAL^DILFD(356.2216,1.03,,$P(DATA(16,LN,1),U,3)) D SETDLN(DLN)  ;[356.2216,1.03]
 . S DLN="  Procedure Modifier:  "_$P($G(^DIC(81.3,+$P(DATA(16,LN,1),U,4),0)),U,1)  ;[356.2216,1.04-1.07] ==> DBIA#3026
 . F SQ=5,6,7 I $L($P(DATA(16,LN,1),U,SQ)) S DLN=DLN_", "_$P($G(^DIC(81.3,+$P(DATA(16,LN,1),U,SQ),0)),U,1)  ; DBIA#3026
 . D SETDLN(DLN)
 . S DLN="  Procedure Code Description:  "_$P(DATA(16,LN,1),U,8) D SETDLN(DLN)  ;[356.2216,1.08]
 . S DLN="  Procedure Code (range of procedure code. This is ending):  "_$$EXTERNAL^DILFD(356.2216,1.03,,$P(DATA(16,LN,1),U,3)) D SETDLN(DLN)  ;[356.2216,1.03]
 . S DLN="  Service Line Amount:  $"_$P(DATA(16,LN,1),U,9) D SETDLN(DLN)  ;[356.2216,1.09]
 . S DLN="  Unit or Basis for Measurement Code:  "_$P(DATA(16,LN,1),U,10) D SETDLN(DLN)  ;[356.2216,1.1]
 . S DLN="  Service Unit Count:  "_$P(DATA(16,LN,1),U,11) D SETDLN(DLN)  ;[356.2216,1.11]
 . S DLN="  Service Line Rate:  "_$P($G(DATA(16,LN,2)),U,7) D SETDLN(DLN)  ;[356.2216,2.07]
 . S DLN="  Nursing Home Residential Status Code:  "_$$GET1^DIQ(356.011,+$P($G(DATA(16,LN,2)),U,8),.02) D SETDLN(DLN)  ;[356.2216,2.08 ptr to #356.011]
 . S DLN="  Nursing Home Level of Care:  "_$$GET1^DIQ(356.019,+$P($G(DATA(16,LN,2)),U,9),.02) D SETDLN(DLN)  ;[356.2216,2.09 ptr to #356.019]
 . D SETDLN("")
 ;
 ; - Dental Services info if #356.2216,1.12 = "D"
 I $P($G(DATA(16,LN,1)),U,12)="D" D
 . S DLN="  Dental Service" D SETDLN(DLN,"B")
 . S DLN="  Procedure Code:  "_$$EXTERNAL^DILFD(356.2216,1.02,,$P(DATA(16,LN,1),U,2)) D SETDLN(DLN)  ;[356.2216,1.02]
 . I $P($P(DATA(16,LN,1),U,3),";",1)'="" S DLN="  Procedure Code:  "_$$EXTERNAL^DILFD(356.2216,1.03,,$P(DATA(16,LN,1),U,3)) D SETDLN(DLN)  ;[356.2216,1.03]
 . S DLN="  Procedure Modifier:  "_$P($G(^DIC(81.3,+$P(DATA(16,LN,1),U,4),0)),U,1)  ;[356.2216,1.04-1.07] ==> DBIA#3026
 . F SQ=5,6,7 I $L($P(DATA(16,LN,1),U,SQ)) S DLN=DLN_", "_$P($G(^DIC(81.3,+$P(DATA(16,LN,1),U,SQ),0)),U,1)  ; DBIA#3026
 . D SETDLN(DLN)
 . S DLN="  Procedure Code Description:  "_$P(DATA(16,LN,1),U,8) D SETDLN(DLN)  ;[356.2216,1.08]
 . S DLN="  Procedure Code (range of procedure code. This is ending):  "_$$EXTERNAL^DILFD(356.2216,1.03,,$P(DATA(16,LN,1),U,3)) D SETDLN(DLN)  ;[356.2216,1.03]
 . S DLN="  Service Line Amount:  $"_$P(DATA(16,LN,1),U,9) D SETDLN(DLN)  ;[356.2216,1.09]
 . F SQ=1:1:5 I $L($P($G(DATA(16,LN,3)),U,SQ)) S DLN="  Oral Cavity Designation Code #"_+SQ_":  "_$P($G(DATA(16,LN,3)),U,SQ) D SETDLN(DLN)  ;[356.2216,3.01-3.05 ptr to #81]
 . S DLN="  Prosthesis, Crown or Inlay:  "_$$EXTERNAL^DILFD(356.2216,3.06,,$P($G(DATA(16,LN,3)),U,6)) D SETDLN(DLN)  ;[356.2216,3.06]
 . S DLN="  Service Unit Count:  "_$P(DATA(16,LN,1),U,11) D SETDLN(DLN)  ;[356.2216,1.11]
 . D SETDLN("")
 . ;
 . ; - Tooth Information if #356.2216,1.12 = "D"
 . S DLN="  Tooth Information" D SETDLN(DLN,"B")
 . I $D(DATA(16,LN,4)) D
 . . S SQ="" F  S SQ=$O(DATA(16,LN,4,SQ)) Q:SQ=""  D
 . . . I '$D(DATA(16,LN,4,SQ,0)) Q
 . . . S DLN="  Tooth Code:  "_$$GET1^DIQ(356.022,+$P($G(DATA(16,LN,4,SQ,0)),U,1),.02) D SETDLN(DLN)  ;[356.2216,4.01 ptr to #81]
 . . . F I=1:1:5 I $L($P($G(DATA(16,LN,4,SQ,0)),U,(I+1))) S DLN="  Tooth Surface #"_+I_":  "_$$EXTERNAL^DILFD(356.22164,((I+1)*.01),,$P($G(DATA(16,LN,4,SQ,0)),U,(I+1))) D SETDLN(DLN)  ;[356.2216,4.02]
 . . . D SETDLN("")
 . I '$D(DATA(16,LN,4)) S DLN="No Tooth Information" D SETDLN(DLN),SETDLN("")
 ;
 ; - Health Care Services Delivery info
 S DLN="  Health Care Services Delivery" D SETDLN(DLN,"B")
 I $TR($G(DATA(16,LN,5)),"^","")'="" D
 . S DLN="  Quantity Qualifier:  "_$$GET1^DIQ(365.016,+$P($G(DATA(16,LN,5)),U,1),.02)  ;[356.2216,5.01 ptr to #365.016]
 . S $E(DLN,44)="Service Unit Count:  "_$P(DATA(16,LN,5),U,2) D SETDLN(DLN)  ;[356.2216,5.02]
 . S DLN="  Unit/Basis for Measure Code:  "_$$EXTERNAL^DILFD(356.2216,5.03,,$P(DATA(16,LN,5),U,3))  ;[356.2216,5.03]
 . S $E(DLN,44)="Sample Selection Modulus:  "_$P(DATA(16,LN,5),U,4) D SETDLN(DLN)  ;[356.2216,5.04]
 . S DLN="  Time Period Qualifier:  "_$$GET1^DIQ(365.015,+$P($G(DATA(16,LN,5)),U,5),.02)  ;[356.2216,5.05 ptr to #365.015]
 . S $E(DLN,44)="Period Count:  "_$P(DATA(16,LN,5),U,6) D SETDLN(DLN)  ;[356.2216,5.06]
 . S DLN="  Delivery Frequency:  "_$$GET1^DIQ(365.025,+$P($G(DATA(16,LN,5)),U,7),.02) D SETDLN(DLN)  ;[356.2216,5.07 ptr to #365.025]
 . S DLN="  Delivery Pattern:  "_$$GET1^DIQ(356.007,+$P($G(DATA(16,LN,5)),U,8),.02) D SETDLN(DLN)  ;[356.2216,5.08 ptr to #356.007]
 I $TR($G(DATA(16,LN,5)),"^","")="" S DLN="  No Health Care Services Delivery" D SETDLN(DLN)
 D SETDLN("")
 ;
 ; - Additional Service Information
 I $D(DATA(16,LN,6)) S DLN="  Additional Service Information" D SETDLN(DLN,"B")
 S SQ="" F  S SQ=$O(DATA(16,LN,6,SQ)) Q:SQ=""  D
 . S DLN="  Report Type:  "_$$GET1^DIQ(356.018,+$P($G(DATA(16,LN,6,SQ,0)),U,2),.02) D SETDLN(DLN)  ;[356.22166,.01 ptr to #356.018]
 . S DLN="  Report Transmission Code:  "_$P($G(DATA(16,LN,6,SQ,0)),U,2) D SETDLN(DLN)  ;[356.22166,.02]
 . S DLN="  Attachment Control #:  "_$P($G(DATA(16,LN,6,SQ,0)),U,3) D SETDLN(DLN)  ;[356.22166,.03]
 . S DLN="  Attachment Description:  "_$P($G(DATA(16,LN,6,SQ,0)),U,4) D SETDLN(DLN)  ;[356.22166,.04]
 . D SETDLN("")
 ;
 ; - Service Message Text
 S DLN="  Service Message Text:" D SETDLN(DLN,"B")
 I $D(DATA(16,LN,7)) D
 . S SQ="" F  S SQ=$O(DATA(16,LN,7,SQ)) Q:SQ=""  D
 .. K TMPARY D FSTRNG^IBJU1($G(DATA(16,LN,7,SQ,0)),75,.TMPARY)
 .. F Z1=1:1:TMPARY S DLN="  "_TMPARY(Z1) D SETDLN(DLN)
 .. ;;S DLN="  "_$G(DATA(16,LN,7,SQ,0)) D SETDLN(DLN)  ;[356.2216,7]
 I '$D(DATA(16,LN,7)) S DLN="  No Service Message Text" D SETDLN(DLN)
 D SETDLN("")
 ; - Service Provider Information (can repeat up to 12 times)
 S DLN="  Service Provider Information" D SETDLN(DLN,"B")
 I $D(DATA(16,LN,8,0)) D
 . S SQ=0 F  S SQ=$O(DATA(16,LN,8,SQ)) Q:SQ=""  D
 . . N PRVPTR,PRVDATA,TAXNMY
 . . S DLN="   Entity Provider Code:  "_$P($G(DATA(16,LN,8,SQ,0)),U,1) D SETDLN(DLN)  ;[356.22168,.01]
 . . S PRVPTR=$P($G(DATA(16,LN,8,SQ,0)),U,3)
 . . S PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 . . S DLN="   Provider ID:  "_$P(PRVDATA,U,7)  ;[356.22168,.03 ptr to Provider ^VA(200), ^IBA(355.93) or ^DIC(4)]
 . . S TAXNMY=$$GTXNMY^IBTRH3(PRVPTR)  ; Get the Taxonomy Code and Person Class Description.
 . . S $E(DLN,44)="Provider Taxonomy:  "_$P(TAXNMY,U,1) D SETDLN(DLN)  ; Taxonomy code.
 . . S DLN="   Person Class:  "_$P(TAXNMY,U,2)  ; Person Class Description.
 . . S DLN="   Provider Name (Full):  "_$P(PRVDATA,U,1) D SETDLN(DLN)  ;[^VA(200,.01), ^IBA(355.93,.01), or ^DIC(4,.01)]
 . . S DLN="   Provider Address (Full): "_$P(PRVDATA,U,2) D SETDLN(DLN)  ;[^IBA(355.93,.05) or ^VA(200,.111)]
 . . I $L($P(PRVDATA,U,3)) S DLN="",$E(DLN,29)=$P(PRVDATA,U,3) D SETDLN(DLN)  ;[^IBA(355.93,.06) or ^VA(200,.112)]
 . . S DLN="",$E(DLN,29)=$P(PRVDATA,U,4)_", "_$$GET1^DIQ(5,$P(PRVDATA,U,5)_",",1)_"  "_$P(PRVDATA,U,6) D SETDLN(DLN)  ;[^IBA(355.93,.07-.09) or ^VA(200,.113-.115)]
 . . D SETDLN("")
 . . ; - Additional Service Information Contact
 . . S DLN="  Additional Service Information Contact" D SETDLN(DLN,"B")
 . . I $D(DATA(16,LN,8,SQ,4,0))!$D(DATA(16,LN,8,SQ,5,0)) D
 . . . S DLN="  Response Contact Name:  "_$P($G(DATA(16,LN,8,SQ,4,0)),U,4)  ;Last Name - [356.22168,4.04]
 . . . S DLN=DLN_", "_$P($G(DATA(16,LN,8,SQ,4,0)),U,5)  ;First Name - [356.22168,4.05]
 . . . S DLN=DLN_" "_$P($G(DATA(16,LN,8,SQ,4,0)),U,6)  ;Middle Name - [356.22168,4.06]
 . . . S DLN=DLN_" "_$P($G(DATA(16,LN,8,SQ,4,0)),U,7) D SETDLN(DLN)  ;Suffix - [356.22168,4.07]
 . . . S DLN="  Identification Code Qualifier:  "_$P($G(^IBE(365.023,+$P($G(DATA(16,LN,8,SQ,4,0)),U,8))),U,2) D SETDLN(DLN)  ;[356.22168,4.08 ptr to #365.023]
 . . . S DLN="  Response Contact Identifier:  "_$P($G(DATA(16,LN,8,SQ,4,0)),U,9) D SETDLN(DLN)  ;[356.22168,4.09]
 . . . S DLN="  Response Contact Address:  "
 . . . S DLN=DLN_"  "_$P($G(DATA(16,LN,8,SQ,5,0)),U,1) D SETDLN(DLN)  ;[356.22168,5]
 . . . I $L($P($G(DATA(16,LN,8,SQ,5,0)),U,2)) S DLN="",$E(DLN,30)=$P(DATA(16,LN,8,SQ,5,0),U,2) D SETDLN(DLN)  ;[356.22168,5.01]
 . . . S DLN="",$E(DLN,30)=$P($G(DATA(16,LN,8,SQ,5,0)),U,3)  ;[356.22168,5.02]
 . . . S DLN=DLN_",  " I +$P($G(DATA(16,LN,8,SQ,5,0)),U,4) S DLN=DLN_$$GET1^DIQ(5,$P(^DIC(5,+$P($G(DATA(16,LN,8,SQ,5,0)),U,4),0),U,2)_",",1)  ;[356.22168,5.03 ptr to File #5]
 . . . S DLN=DLN_"  "_+$P($G(DATA(16,LN,8,SQ,5,0)),U,5) D SETDLN(DLN)  ;[356.22168,5.04]
 . . . I +$P($G(DATA(16,LN,8,SQ,5,0)),U,6) S DLN="",$E(DLN,30)=$$GET1^DIQ(779.004,$P($G(DATA(16,LN,8,SQ,5,0)),U,6),.01)  ;[356.22168,5.06 ptr to #779.004]
 . . . S DLN=DLN_"   "_$P($G(DATA(16,LN,8,SQ,5,0)),U,7) D SETDLN(DLN)  ;[356.22168,5.06]
 . . . D SETDLN("")
 . . . S DLN="  Response Contact Name:  "_$P($G(DATA(16,LN,8,SQ,0)),U,6) D SETDLN(DLN)  ;[356.22168,.06]
 . . . S DLN="  Response Contact #:  "
 . . . I $P($G(DATA(16,LN,8,SQ,0)),U,7)'=""!($L($G(DATA(16,LN,8,SQ,1)))) D  ;[356.22168,1]
 . . . . S DLN=DLN_$$EXTERNAL^DILFD(356.22168,.07,,+$P($G(DATA(16,LN,8,SQ,0)),U,7))
 . . . . S DLN=DLN_": "_$G(DATA(16,LN,8,SQ,1)) D SETDLN(DLN)
 . . . F I=2,3 I $L($G(DATA(16,LN,8,SQ,I))) D  ;[356.22168,2-3]
 . . . . S DLN="",$E(DLN,19)=$$EXTERNAL^DILFD(356.22168,(.06+(I*.01)),,+$P($G(DATA(16,LN,8,SQ,0)),U,(6+I)))
 . . . . S DLN=DLN_": "_$G(DATA(16,LN,8,SQ,I)) D SETDLN(DLN)
 . . I '$D(DATA(16,LN,8,SQ,4,0)),'$D(DATA(16,LN,8,SQ,5,0)) S DLN="  No Additional Service Information Contact Data" D SETDLN(DLN)
 . . D SETDLN("")
 I '$D(DATA(16,LN,8,0)) S DLN="  No Service Provider Information" D SETDLN(DLN),SETDLN("")
 Q
 ;
SETDLN(DLN,SPEC) ; Add Display Line to ^TMP global.
 S VALMCNT=VALMCNT+1
 S ^TMP(IBTRNM,$J,VALMCNT,0)=DLN
 I $G(SPEC)="B" D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 Q

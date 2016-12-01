IBTRH3A ;ALB/VAD - IBT HCSR RESPONSE VIEW - Display set up ;02-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETINFO(IBTRNM,IBTRIEN) ; Get data items, as they would display on the bill
 N DLN
 D GETUMO(),GETPAT(),GETSVC^IBTRH3B()
 Q
 ;
GETUMO() ; Get the UMO Contact Information
 N GOTONE,SQ,X
 Q:'$G(IBTRIEN)
 D SETDLN("")
 S DLN="  UMO Contact Information" D SETDLN(DLN,"B")
 I $TR($G(DATA(19)),"^","")'="" D
 . S DLN="  UMO Name:  "_$P($G(DATA(19)),U,1) D SETDLN(DLN)  ;[356.2219,.01]
 . S DLN="  UMO Contact #:  "
 . I $P($G(DATA(19)),U,2)'=""!($L($G(DATA(20)))) D   ;[356.2219,2]
 . . S DLN=DLN_$$EXTERNAL^DILFD(356.22,19.01,,+$P($G(DATA(19)),U,2))
 . . S DLN=DLN_": "_$G(DATA(20)) D SETDLN(DLN)
 . F X=2,3 I $L($G(DATA(19+X))) D   ;[356.22,21-22]
 . . S DLN="",$E(DLN,19)=$$EXTERNAL^DILFD(356.22,(19+(X*.01)),,+$P($G(DATA(19)),U,X))
 . . S DLN=DLN_": "_$G(DATA(20+X)) D SETDLN(DLN)
 . D SETDLN("")
 I $TR($G(DATA(19)),"^","")="" S DLN="  No UMO Contact Information" D SETDLN(DLN)
 Q
 ;
GETPAT() ; Get the Patient Event Detail
 N DLN,GOTONE,PRVPTR,PRVDATA,SQ,SQCNT,TAXNMY,VAL1,VAL3
 Q:'$G(IBTRIEN)
 S $E(DLN,32)="PATIENT EVENT DETAIL" D SETDLN(DLN)
 I $G(DATA(105))'="" D
 . S DLN="  Patient Event Trace Number:  "
 . S SQ=0 F  S SQ=$O(DATA(105,SQ)) Q:SQ=""  D
 . . S $E(DLN,32)=$P(DATA(105,SQ,0),U,4) D SETDLN(DLN) S DLN=""  ;[356.22105,.04]
 D SETDLN("")
 ; - Health Care Services Review info -
 S DLN="  Health Care Services Review" D SETDLN(DLN,"B")
 I $TR($G(DATA(103,0)),"^","")'="" D
 . S VAL1=$P($G(DATA(103,0)),U,1)_",",VAL3=$P($G(DATA(103,0)),U,3)_","
 . S DLN="  Certification Action:  "
 . I $L($$GET1^DIQ(356.02,VAL1,.01)) S DLN=DLN_$$GET1^DIQ(356.02,VAL1,.01)_" - "_$$GET1^DIQ(356.02,VAL1,.02)  ;[356.22,103.01]
 . D SETDLN(DLN)
 . S DLN="  Certification/Authorization #:  " S DLN=DLN_$P($G(DATA(103,0)),U,2) D SETDLN(DLN)  ;[356.22,103.02]
 . S DLN="  Review Decision Reason:  "
 . I $L($$GET1^DIQ(356.021,VAL3,.01)) S DLN=DLN_$$GET1^DIQ(356.021,VAL3,.01)_" - "_$E($$GET1^DIQ(356.021,VAL3,.02),1,45)  ;[356.22,103.03]
 . D SETDLN(DLN)
 . S DLN="  Second Surgical Opinion Ind:  " S DLN=DLN_$P($G(DATA(103,0)),U,4) D SETDLN(DLN)  ;[356.22,103.04]
 . D SETDLN("")
 S DLN="  Previous Admin Ref #:  " S DLN=DLN_$P($G(DATA(17)),U,2) D SETDLN(DLN)  ;[356.22,17.02]
 S DLN="  Previous Review Autho #:  " S DLN=DLN_$P($G(DATA(17)),U,1) D SETDLN(DLN)  ;[356.22,17.01]
 S DLN="  Proposed/Actual "_$S($P($G(DATA(0)),U,4)="I":"Admission",1:"Appointment")_" Date:  "   ;[356.22,.04]
 S DLN=DLN_$$FMTE^XLFDT($P($G(DATA(0)),U,7)) D SETDLN(DLN)  ;[356.22,.07]
 S DLN="  Proposed or Discharge Date:  " S DLN=DLN_$$FMTE^XLFDT($P($G(DATA(2)),U,22)) D SETDLN(DLN)  ;[356.22,2.22]
 S DLN="  Cert. Effective Date:  " S DLN=DLN_$$FMTE^XLFDT($P($G(DATA(2)),U,25))
 I $P($G(DATA(2)),U,26)'="" S DLN=DLN_" - "_$$FMTE^XLFDT($P($G(DATA(2)),U,26))
 D SETDLN(DLN)  ;[356.22,2.25] - [356.22,2.26]
 S DLN="  Cert. Issue Date:  " S DLN=DLN_$$FMTE^XLFDT($P($G(DATA(2)),U,23))  ;[356.22,2.23]
 S $E(DLN,44)="Cert. Expiration Date:  " S DLN=DLN_$$FMTE^XLFDT($P($G(DATA(2)),U,24)) D SETDLN(DLN)  ;[356.22,2.24]
 D SETDLN("")
 ; - Health Care Services Delivery info -
 S DLN="  Health Care Services Delivery" D SETDLN(DLN,"B")
 I $TR($G(DATA(4)),"^","")'="" D
 . S DLN="  Quantity Qualifier:  " S DLN=DLN_$$GET1^DIQ(365.016,+$P($G(DATA(4)),U,1),.02)  ;[356.22,4.01]
 . S $E(DLN,44)="Service Unit Count:  " S DLN=DLN_$P($G(DATA(4)),U,2) D SETDLN(DLN)  ;[356.22,4.02]
 . S DLN="  Unit/Basis for Measure Code:  " S DLN=DLN_$$EXTERNAL^DILFD(356.22,4.03,,$P($G(DATA(4)),U,3))  ;[356.22,4.03]
 . S $E(DLN,44)="Sample Selection Modulus:  " S DLN=DLN_$P($G(DATA(4)),U,4) D SETDLN(DLN)  ;[356.22,4.04]
 . S DLN="  Time Period Qualifier:  " S DLN=DLN_$$GET1^DIQ(365.015,+$P($G(DATA(4)),U,5),.02)  ;[356.22,4.05]
 . S $E(DLN,44)="  Period Count:  " S DLN=DLN_$P($G(DATA(4)),U,6) D SETDLN(DLN)  ;[356.22,4.06]
 . S DLN="  Delivery Frequency:  " S DLN=DLN_$$GET1^DIQ(365.025,+$P($G(DATA(4)),U,7),.02) D SETDLN(DLN)  ;[356.22,4.07]
 . S DLN="  Delivery Pattern:  " S DLN=DLN_$$GET1^DIQ(356.007,+$P($G(DATA(4)),U,8),.02) D SETDLN(DLN)  ;[356.22,4.08]
 I $G(DATA(4))="" S DLN="  No Health Care Services Delivery Information" D SETDLN(DLN)
 D SETDLN("")
 ; - Patient Diagnosis info -
 S DLN="  Patient Diagnosis Information" D SETDLN(DLN,"B")   ; Up to 12 Dx Code(s) & Date(s)
 S GOTONE=0
 S SQ="" F  S SQ=$O(DATA(3,SQ)) Q:SQ=""  D
 . I '+SQ Q
 . S GOTONE=1
 . S DLN="  Diagnosis Type:  "_$$GET1^DIQ(356.006,+$P($G(DATA(3,SQ,0)),U,1),.02) D SETDLN(DLN)  ;[356.223,.01]
 . S DLN="  Diagnosis Code:  "_$$EXTERNAL^DILFD(356.223,.02,,$P($G(DATA(3,SQ,0)),U,2)) D SETDLN(DLN)  ;[356.223,.02]
 . S DLN="  Diagnosis Date:  "_$$FMTE^XLFDT($P($G(DATA(3,SQ,0)),U,3)) D SETDLN(DLN)  ;[356.223,.03]
 . D SETDLN("")
 I 'GOTONE S DLN="  No Diagnosis Information" D SETDLN(DLN),SETDLN("")
 ; 
 ; - Institutional Claim Code info -
 I $P($G(DATA(7)),U,3)'="" D
 . S DLN="  Institutional Claim Code" D SETDLN(DLN,"B")
 . S DLN="  Admission Type Code:" S DLN=DLN_$$EXTERNAL^DILFD(356.22,7.01,,$P($G(DATA(7)),U,1))  ;[356.22,7.01]
 . S $E(DLN,44)="  Admission Source Code:  " S DLN=DLN_$$GET1^DIQ(356.009,+$P($G(DATA(7)),U,1),.02) D SETDLN(DLN)  ;[356.22,7.02]
 . S DLN="  Patient Status Code:  " S DLN=DLN_$$EXTERNAL^DILFD(356.22,.04,,$P($G(DATA(0)),U,4)) D SETDLN(DLN)  ;[356.22,.04]
 . D SETDLN("")
 ;
 ; - Ambulance Transport info -
 S DLN="  Ambulance Transport Information" D SETDLN(DLN,"B")
 I $TR($G(DATA(18)),"^","")'=""!($P($G(DATA(4)),U,3)'="") D
 . S DLN="  Ambulance Transport Code:  " S DLN=DLN_$$EXTERNAL^DILFD(356.22,18.03,,$P($G(DATA(18)),U,3))  ;[356.22,18.03]
 . S $E(DLN,44)="Unit/Basis for Measure Code:  " S DLN=DLN_$$EXTERNAL^DILFD(356.22,18.01,,$P($G(DATA(4)),U,3)) D SETDLN(DLN)  ;[356.22,18.01]
 . S DLN="  Transport Distance:  " S DLN=DLN_$P($G(DATA(18)),U,6) D SETDLN(DLN)  ;[356.22,18.06]
 I $TR($G(DATA(18)),"^","")="",$P($G(DATA(4)),U,3)="" S DLN="  No Ambulance Transport Information" D SETDLN(DLN)
 D SETDLN("")
 ; - Spinal Manipulation Service info -
 S DLN="  Spinal Manipulation Service Information" D SETDLN(DLN,"B")
 I $TR($G(DATA(7)),"^","")'="" D
 . S DLN="  Treatment Series Number:  "_$P(DATA(7),U,5)  ;[356.22,7.05]
 . S $E(DLN,44)="Treatment Count:  "_$P(DATA(7),U,6) D SETDLN(DLN)  ;[356.22,7.06]
 . S DLN="  Subluxation Level Code 1:  "_$$GET1^DIQ(356.012,+$P(DATA(7),U,7),.02) D SETDLN(DLN)  ;[356.22,7.07]
 . S DLN="  Subluxation Level Code 2:  "_$$GET1^DIQ(356.012,+$P(DATA(7),U,8),.02) D SETDLN(DLN)  ;[356.22,7.08]
 I $TR($G(DATA(7)),"^","")="" S DLN="  No Spinal Manipulation Service Information" D SETDLN(DLN)
 D SETDLN("")
 ; - Home Oxygen Therapy info -
 S DLN="  Home Oxygen Therapy Information" D SETDLN(DLN,"B")
 I $TR($G(DATA(8)),"^","")'=""!($TR($G(DATA(9)),"^","")'="") D
 . S DLN="  Oxygen Equipment Type Code 1:  "_$$GET1^DIQ(356.013,+$P($G(DATA(8)),U,1),.02) D SETDLN(DLN)  ;[356.22,8.01]
 . S DLN="  Oxygen Equipment Type Code 2:  "_$$GET1^DIQ(356.013,+$P($G(DATA(8)),U,2),.02) D SETDLN(DLN)  ;[356.22,8.02]
 . S DLN="  Oxygen Equipment Type Code 3:  "_$$GET1^DIQ(356.013,+$P($G(DATA(8)),U,3),.02) D SETDLN(DLN)  ;[356.22,8.03]
 . S DLN="  Oxygen Flow Rate:  "_$P($G(DATA(8)),U,5)  ;[356.22,8.05]
 . S $E(DLN,44)="Daily Oxygen Use Count:  "_$P($G(DATA(8)),U,6) D SETDLN(DLN)  ;[356.22,8.06]
 . S DLN="  Oxygen Use Period Hour Count:  "_$P($G(DATA(8)),U,7) D SETDLN(DLN)  ;[356.22,8.07]
 . S DLN="  Respiratory Therapist Order Text:  "_$P($G(DATA(8)),U,8) D SETDLN(DLN)  ;[356.22,8.08]
 . S DLN="  Arterial Blood Gas Quantity:  "_$P($G(DATA(9)),U,1) D SETDLN(DLN)  ;[356.22,9.01]
 . S DLN="  Oxygen Saturation Quantity:  "_$P($G(DATA(9)),U,2) D SETDLN(DLN)  ;[356.22,9.02]
 . S DLN="  Oxygen Test Condition:  "_$$GET1^DIQ(356.014,+$P($G(DATA(9)),U,3),.02) D SETDLN(DLN)  ;[356.22,9.03]
 . S DLN="  Oxygen Test Findings #1:  "_$E($$GET1^DIQ(356.015,+$P($G(DATA(9)),U,4),.02),1,50) D SETDLN(DLN)  ;[356.22,9.04]
 . S DLN="  Oxygen Test Findings #2:  "_$E($$GET1^DIQ(356.015,+$P($G(DATA(9)),U,5),.02),1,50) D SETDLN(DLN)  ;[356.22,9.05]
 . S DLN="  Oxygen Test Findings #3:  "_$E($$GET1^DIQ(356.015,+$P($G(DATA(9)),U,6),.02),1,50) D SETDLN(DLN)  ;[356.22,9.06]
 . S DLN="  Portable Oxygen System Flow Rate:  "_$P($G(DATA(9)),U,7) D SETDLN(DLN)  ;[356.22,9.07]
 . S DLN="  Oxygen Delivery System Code:  "_$E($$GET1^DIQ(356.016,+$P($G(DATA(9)),U,8),.02),1,40) D SETDLN(DLN)  ;[356.22,9.08]
 I $TR($G(DATA(8)),"^","")="",$TR($G(DATA(9)),"^","")="" S DLN="  No Home Oxygen Therapy Information" D SETDLN(DLN)
 D SETDLN("")
 ; - Home Health Care info -
 S DLN="  Home Health Care Information" D SETDLN(DLN,"B")
 I $P($G(DATA(2)),U,15)'=""!($TR($P($G(DATA(10)),U,1,3),"^","")'="") D
 . S DLN="  Prognosis Code:  "_$$GET1^DIQ(356.004,+$P($G(DATA(2)),U,15),.02) D SETDLN(DLN)  ;[356.22,2.15]
 . S DLN="  Home Health Start Date:  "_$$FMTE^XLFDT($P($G(DATA(10)),U,1)) D SETDLN(DLN)  ;[356.22,10.01]
 . S DLN="  Home Health Certification Period:   "
 . I $L($P($G(DATA(10)),U,2))!($L($P($G(DATA(10)),U,3))) D
 . . S DLN=DLN_$$FMTE^XLFDT($P($G(DATA(10)),U,2))  ;[356.22,10.02]
 . . S DLN=DLN_"  -  "_$$FMTE^XLFDT($P($G(DATA(10)),U,3))  ;[356.22,10.03]
 . D SETDLN(DLN)
 . S DLN="  Medicare Coverage Indicator:  "_$$EXTERNAL^DILFD(356.22,10.04,,$P($G(DATA(10)),U,4)) D SETDLN(DLN)  ;[356.22,10.04]
 . S DLN="  Certification Type Code:  "_$$GET1^DIQ(356.002,+$P($G(DATA(2)),U,2),.02) D SETDLN(DLN)  ;[356.22,2.02]
 I $P($G(DATA(2)),U,15)="",$TR($P($G(DATA(10)),U,1,3),"^","")="" S DLN="  No Home Health Care Information" D SETDLN(DLN)
 D SETDLN("")
 ; - Additional Patient info -
 S DLN="  Additional Patient Information" D SETDLN(DLN,"B")
 I $D(DATA(11)) D
 . S SQ=0
 . F  S SQ=$O(DATA(11,SQ)) Q:SQ=""  D
 . . S DLN="  Report Type:  "_$P($G(^IBT(356.018,+$P($G(DATA(11,SQ,0)),U,1),0)),U,2) D SETDLN(DLN)  ;[356.22,11.01] ptr to ^IBT(356.018)]
 . . S DLN="  Report Transmission Code:  "_$P($G(DATA(11,SQ,0)),U,2) D SETDLN(DLN)  ;[356.22,11.02]
 . . S DLN="  Attachment Control #:  "_$E($P($G(DATA(11,SQ,0)),U,3),1,50) D SETDLN(DLN)  ;[356.22,11.03]
 . . S DLN="  Attachment Description:  "_$E($P($G(DATA(11,SQ,0)),U,4),1,50) D SETDLN(DLN)  ;[356.22,11.04]
 . . D SETDLN("")
 I '$D(DATA(11)) S DLN="  No Additional Patient Information" D SETDLN(DLN),SETDLN("")
 ; - Message Text -
 S DLN="  Message Text:  " D SETDLN(DLN,"B")
 I +$G(DATA(12,0)) D
 . S SQCNT=+$G(DATA(12,0))
 . F SQ=1:1:SQCNT S DLN="  "_$G(DATA(12,SQ)) D SETDLN(DLN)  ;[356.22,12]
 I '+$G(DATA(12,0)) S DLN="  No Message Text" D SETDLN(DLN)
 D SETDLN("")
 ; - Additional Patient Information Contact Data -
 S DLN="  Additional Patient Information Contact Data" D SETDLN(DLN,"B")
 S GOTONE=0
 I $D(DATA(13)) D
 .S SQ="" F  S SQ=$O(DATA(13,SQ)) Q:SQ=""  D
 ..I $G(DATA(13,SQ,4))="",$G(DATA(13,SQ,5))="" Q
 ..S GOTONE=1
 ..S DLN="  Response Contact Name:  "_$P($G(DATA(13,SQ,4)),U,4)  ;Last Name-[356.2213,4.04]
 ..S DLN=DLN_", "_$P($G(DATA(13,SQ,4)),U,5)  ;First Name-[356.2213,4.05]
 ..S DLN=DLN_" "_$P($G(DATA(13,SQ,4)),U,6)  ;Middle Name-[356.2213,4.06]
 ..S DLN=DLN_" "_$P($G(DATA(13,SQ,4)),U,7) D SETDLN(DLN)  ;Suffix-[356.2213,4.07]
 ..S DLN="  Identification Code Qualifier:  "_$$GET1^DIQ(365.023,+$P($G(DATA(13,SQ,4)),U,8),.02) D SETDLN(DLN)  ;[356.2213,4.08]
 ..S DLN="  Response Contact Identifier:  "_$P($G(DATA(13,SQ,4)),U,9) D SETDLN(DLN)  ;[356.2213,4.09]
 ..S DLN="  Response Contact Address:"
 ..S DLN=DLN_"  "_$P($G(DATA(13,SQ,5)),U,1) D SETDLN(DLN)  ;[356.2213,5]
 ..I $L($P($G(DATA(13,SQ,5)),U,2)) S DLN="",$E(DLN,30)=$P(DATA(13,SQ,5),U,2) D SETDLN(DLN)  ;[356.2213,5.01]
 ..S DLN="",$E(DLN,30)=$P($G(DATA(13,SQ,5)),U,3)  ;[356.2213,5.02]
 ..S DLN=DLN_",  " I +$P($G(DATA(13,SQ,5)),U,4) S DLN=DLN_$$GET1^DIQ(5,$P(^DIC(5,+$P($G(DATA(13,SQ,5)),U,4),0),U,2)_",",1)  ;[356.2213,5.03]
 ..S DLN=DLN_"  "_$P($G(DATA(13,SQ,5)),U,5) D SETDLN(DLN)  ;[356.2213,5.04]
 ..I +$P($G(DATA(13,SQ,5)),U,6) S DLN="",$E(DLN,30)=$$GET1^DIQ(779.004,$P($G(DATA(13,SQ,5)),U,6),.01)  ;[356.2213,5.05]
 ..S DLN=DLN_"   "_$P($G(DATA(13,SQ,5)),U,7) D SETDLN(DLN)  ;[356.2213,5.06]
 ..D SETDLN("")
 ..S DLN="  Response Contact Name:  "_$P($G(DATA(13,SQ,0)),U,6) D SETDLN(DLN)  ;[356.2213,.06]
 ..S DLN="  Response Contact #:  "
 ..I $P($G(DATA(13,SQ,0)),U,7)'=""!($L($G(DATA(13,SQ,1)))) D   ;[356.2213,1]
 ...S DLN=DLN_$$EXTERNAL^DILFD(356.2213,.07,,+$P($G(DATA(13,SQ,0)),U,7))
 ...S DLN=DLN_": "_$G(DATA(13,SQ,1)) D SETDLN(DLN)
 ..F X=2,3 I $L($G(DATA(13,SQ,X))) D  ;[356.2213,2-3]
 ...S DLN="",$E(DLN,19)=$$EXTERNAL^DILFD(356.2213,(.06+(X*.01)),,+$P($G(DATA(13,SQ,0)),U,(6+X)))
 ...S DLN=DLN_": "_$G(DATA(13,SQ,X)) D SETDLN(DLN)
 ..D SETDLN("")
 I '+GOTONE S DLN="  No Additional Patient Information Contact" D SETDLN(DLN),SETDLN("")
 ; - Pat Event Prov Info (repeats up to 14 times)-[356.2213]
 S DLN="  Patient Event Provider Information" D SETDLN(DLN,"B")
 S GOTONE=0
 I $D(DATA(13)) D
 .S SQ="" F  S SQ=$O(DATA(13,SQ)) Q:SQ=""  D
 ..I $G(DATA(13,SQ,0))="" Q
 ..S GOTONE=1,TAXNMY=""
 ..S DLN="   Entity Provider Code:  "_$$GET1^DIQ(365.022,+$P($G(DATA(13,SQ,0)),U,1),.02) D SETDLN(DLN)  ;[356.2213,.01]
 ..S PRVPTR=$P($G(DATA(13,SQ,0)),U,3)
 ..S PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 ..; PRVDATA = name ^ line 1 ^ line 2 ^ city ^ state ^ zip ^ NPI
 ..S DLN="   Provider ID:  "_$P(PRVDATA,U,7)  ;[356.2213,.03] ptr to Provider File ^VA(200), ^IBA(355.93) or ^DIC(4)]
 ..S TAXNMY=$$GTXNMY^IBTRH3(PRVPTR)   ; Get the Taxonomy Code and Person Class Description.
 ..S $E(DLN,44)="Provider Taxonomy:  "_$P(TAXNMY,U,1) D SETDLN(DLN)  ; Taxonomy code.
 ..S DLN="   Person Class:  "_$P(TAXNMY,U,2)    ; Person Class Description.
 ..S DLN="   Provider Name:  "_$P(PRVDATA,U,1) D SETDLN(DLN)  ;[^VA(200,.01), ^IBA(355.93,.01), or ^DIC(4,.01)]
 ..S DLN="   Provider Address: "_$P(PRVDATA,U,2) D SETDLN(DLN)  ;[^IBA(355.93,.05) or ^VA(200,.111)]
 ..I $L($P(PRVDATA,U,3)) S DLN="",$E(DLN,22)=$P(PRVDATA,U,3) D SETDLN(DLN)  ;[^IBA(355.93,.06) or ^VA(200,.112)]
 ..S DLN="",$E(DLN,22)=$P(PRVDATA,U,4)_$S($P(PRVDATA,U,4)'="":", ",1:"")_$$GET1^DIQ(5,$P(PRVDATA,U,5)_",",1)_"  "_$P(PRVDATA,U,6) D SETDLN(DLN)  ;[^IBA(355.93,.07-.09) or ^VA(200,.113-.115)]
 ..D SETDLN("")
 I '+GOTONE S DLN="   No Patient Event Provider Information" D SETDLN(DLN),SETDLN("")
 S DLN="  Patient Event Transport Information" D SETDLN(DLN,"B")
 S GOTONE=0
 I $D(DATA(14)) D
 .S SQ="" F  S SQ=$O(DATA(14,SQ)) Q:SQ=""  D
 ..I $G(DATA(14,SQ,0))="" Q
 ..S GOTONE=1
 ..S DLN="   Entity Identifier Code:  "_$P($G(DATA(14,SQ,0)),U,1) D SETDLN(DLN)  ;[356.2214,.01]
 ..S DLN="   Transport Location Name:  "_$P($G(DATA(14,SQ,0)),U,2) D SETDLN(DLN)  ;[356.2214,.02]
 ..S DLN="   Transport Location Address:  "_$P($G(DATA(14,SQ,0)),U,3) D SETDLN(DLN)  ;[356.2214,.03]
 ..I $L($P($G(DATA(14,SQ,0)),U,4)) S DLN="",$E(DLN,33)=$P(DATA(14,SQ,0),U,4) D SETDLN(DLN)  ;[356.2214,.04]
 ..S DLN="",$E(DLN,33)=$P($G(DATA(14,SQ,0)),U,5)  ;[356.2214,.05]
 ..S DLN=DLN_", " I +$P($G(DATA(14,SQ,0)),U,6) S DLN=DLN_$$GET1^DIQ(5,$P(^DIC(5,+$P($G(DATA(14,SQ,0)),U,6),0),U,2)_",",1)  ;[356.2214,5.03]
 ..S DLN=DLN_"  "_$P($G(DATA(14,SQ,0)),U,7) D SETDLN(DLN)  ;[356.2214,.07]
 ..D SETDLN("")
 I '+GOTONE S DLN="   No Patient Event Transport Information" D SETDLN(DLN),SETDLN("")
 Q
 ;
SETDLN(DLN,SPEC) ; Add Display Line to ^TMP global.
 S VALMCNT=VALMCNT+1
 S ^TMP(IBTRNM,$J,VALMCNT,0)=DLN
 I $G(SPEC)="B" D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 Q
 ;

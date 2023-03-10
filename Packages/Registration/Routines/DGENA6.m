DGENA6 ;ALB/CJM,ISA,KWP,RTK,LBD,CKN,RN - Enrollment API to create enrollment record; 04/24/03 ; 8/31/05 2:44pm
 ;;5.3;Registration;**232,327,417,491,513,672,940,993,1014,1045**;Aug 13, 1993;Build 15
 ;
 ;CREATE line tag moved from DGENA in DG*5.3*232.;MM  
 ;
CREATE(DFN,APP,EFFDATE,REASON,REMARKS,DGENR,ENRDATE,END,DGENRYN) ;  DG*5.3*993 Added 9th parameter DGENRYN
 ;Description: Creates a local enrollment as a local array.
 ;Input :
 ;  DFN- Patient IEN
 ;  APP - the Enrollment Application Date to use
 ;  EFFDATE - the Effective Date, if  NULL assume the same as the
 ;     Enrollment Date
 ;  REASON - used to create an enrollment with CANCELLED/DECLINED status,
 ;     pass in the code for REASON CANCELED/DECLINED
 ;  REMARKS - if creating an enrollment with CANCELLED/DECLINED status,
 ;     and the reason is can optionally pass in textual remarks for
 ;     CANCELED/DECLINED REMARKS 
 ;  ENRDATE - the Enrollment Date to use (optional)
 ;  END - the Enrollment End Date to use (optional)
 ;  DGENRYN  - (Optional) ENROLL Y/N question for registration 0=NO 1=YES
 ;Output:
 ;  Function Value - returns 1 if successful, 0 otherwise
 ;  DGENR - a local array where the enrollment object will be stored,
 ;     pass by reference
 ;
 K DGENR
 S DGENR="",DGENRYN=$G(DGENRYN)
 N DGELGSUB,PRIORITY,DEATH,PRIGRP,DODUPD,DGSTUS,DGNOW,DGEIEN,DGENFLG,DGREG
 S DGREG=1   ;DG*5.3*1014 Restrict change of status when changing primary eligibility for non-veterans.
 S DGEIEN=$$FINDCUR^DGENA(DFN)
 I DGEIEN S DGENFLG=$$GET1^DIQ(27.11,DGEIEN_",",.14,"I")
 ;S DGNOW=$$NOW^XLFDT()
 ;Re-Enrollment - var PRIGRP contains priority and subgroup
 S PRIGRP=$$PRIORITY^DGENELA4(DFN,,.DGELGSUB,$G(ENRDATE),$G(APP),$G(DGENRYN)) ;DG*5.3*993 Added 6th parameter DGENRYN
 S PRIORITY=$P(PRIGRP,"^")  ; Re-Enrollment - Priority is first piece
 S DGENR("APP")=$G(APP)
 S DGENR("DATE")=$G(ENRDATE)
 S DGENR("END")=$G(END)
 S DGENR("DFN")=DFN
 S DGENR("SOURCE")=1
 I $G(DGENRYN)=0,$G(DGENR("STATUS"))'=6 S DGENR("STATUS")=25
 I $G(DGENFLG)=0,$G(DGENR("STATUS"))'=6 S DGENR("STATUS")=25
 I ($G(DGENFLG)=0)!($G(DGENRYN)=0) S DGREG=0        ;DG*5.3*1014 Restrict change of status when changing primary eligibility for non-veterans. 
 D  ;drops out of block when status is determined
 .I $G(REASON) D  Q
 ..S DGENR("STATUS")=7,DGENR("REMARKS")=$G(REMARKS),DGENR("REASON")=REASON ;CANCELED/DECLINED
 .E  S DGENR("REMARKS")="",DGENR("REASON")=""
 .S DEATH=$$DEATH^DGENPTA(DFN)
 .I DEATH D  Q
 ..S DGENR("STATUS")=6 ;DECEASED
 ..S DGENR("END")=DEATH
 ..S DODUPD=$P($G(^DPT(DFN,.35)),"^",4) ;Get Date of Death last updated date
 ..;S EFFDATE=DEATH ;Removed - DG*5.3*672
 ..S EFFDATE=$S($G(DODUPD)'="":DODUPD,1:DT) ;DG*5.3*672
 ..;Find patient's current enrollment record
 ..N DGENRIEN,DGENRC
 ..S DGENRIEN=$$FINDCUR^DGENA(DFN)
 ..I DGENRIEN S:$G(DGENRYN)="" DGENRYN=$$GET1^DIQ(27.11,DGENRIEN_",",.14,"I") ;DG*5.3*993 Added REGISTRATION ONLY
 ..S DGENRC=$$GET^DGENA(DGENRIEN,.DGENRC)
 ..S DGENR("DATE")=$S($G(DGENRC("DATE"))'="":DGENRC("DATE"),1:"")  ;enrollment date
 .I DGREG,'$$VET^DGENPTA(DFN) D  Q  ;NOT ELIGIBLE  ; DG*5.3*1014 Restrict change of status when changing primary eligibility for non-veterans.
 ..N DGPAT,DGENRIEN,DGENRC
 ..S DGENR("STATUS")=20 ;new status for Ineligible Project
 ..;Find patient's current enrollment record
 ..S DGENRIEN=$$FINDCUR^DGENA(DFN)
 ..S DGENRC=$$GET^DGENA(DGENRIEN,.DGENRC)
 ..S DGENR("DATE")=$S($G(DGENRC("DATE"))'="":DGENRC("DATE"),1:"")  ;enrollment date
 ..;Phase II The TESTVAL was moved from DGENA1 to DGENA3 (SRS 6.5.2.1)
 ..;if vet has an Ineligible Date then the Effective Date should be the later of the Ineligible Date or App Date
 ..I $$GET^DGENPTA(DFN,.DGENPTA),DGENPTA("INELDATE"),$$TESTVAL^DGENA3("EFFDATE",DGENPTA("INELDATE")),DGENRC=1 S EFFDATE=$G(DGENPTA("INELDATE"))
 ..I '$G(EFFDATE) S EFFDATE=$G(APP)
 ..;If currently enrolled, set end date = ineligible date
 ..I DGENRC=1 S DGENR("END")=$G(DGENPTA("INELDATE"))
 ..;If not currently enrolled or no ineligible date, set end date = application date
 ..I '$G(DGENR("END")) S DGENR("END")=$G(APP)
 .;Determine preliminary enrollment status based on enrollment group threshold
 .;Get enrollment group threshold
 .N DGEGTIEN,DGEGT,DGENRC,DGENRIEN
 .S DGEGTIEN=$$FINDCUR^DGENEGT
 .S DGEGT=$$GET^DGENEGT(DGEGTIEN,.DGEGT)
 .;If patient's enrollment status not above enrollment group threshold 
 .;set status to Rejected:  Initial Application by VAMC)
 .I $G(PRIORITY)'="",'$$ABOVE2^DGENEGT1(DFN,$G(APP),PRIORITY,$P(PRIGRP,U,2)) D  Q
 ..;Find patient's current enrollment record
 ..S DGENRIEN=$$FINDCUR^DGENA(DFN)
 ..S DGENRC=$$GET^DGENA(DGENRIEN,.DGENRC)
 ..S DGENR("DATE")=$S($G(DGENRC("DATE"))'="":DGENRC("DATE"),1:"")  ;enrollment date
 ..S DGENR("END")=$G(APP)  ;enrollment end date = application date
 ..S EFFDATE=$G(APP)  ; effective date = application date
 ..S DGENR("STATUS")=14  ;Rejected: Initial Application by VAMC
 .S DGENR("STATUS")=1 Q  ;UNVERIFIED
 S DGENR("FACREC")=$$INST^DGENU()
 S DGENR("PRIORITY")=PRIORITY
 ;Phase II add subgroup (SRS 6.4)
 S DGENR("SUBGRP")=$P(PRIGRP,"^",2)
 S DGENR("EFFDATE")=$S($G(EFFDATE):EFFDATE,$G(ENRDATE):$G(ENRDATE),1:$G(APP))
 S DGENR("USER")=$G(DUZ)
 S DGENR("DATETIME")=$$NOW^XLFDT ;Moved to top of the routine DG*5.3*672
 S DGENR("PRIORREC")=""
 S DGENR("RCODE")=""  ;DJE field added with DG*5.3*940 - Closed Application - RM#867186
 ;Next line: DG*5.3*993 New fields for decoupling
 ; DG*5.3*1045 Set Registration Only Status when Ineligible Date is blank
 N DGINELIG,DGENPTA
 I $$GET^DGENPTA(DFN,.DGENPTA) S DGINELIG=$G(DGENPTA("INELDATE"))
 I $G(DGENRYN)=0,$G(DGINELIG)="",$G(DGENR("STATUS"))'=6,$G(DGENR("STATUS"))'=20 S DGENR("STATUS")=25
 I $G(DGENFLG)=0,$G(DGINELIG)="",$G(DGENR("STATUS"))'=6,$G(DGENR("STATUS"))'=20 S DGENR("STATUS")=25
 S DGENR("PTAPPLIED")=DGENRYN,DGENR("REGREA")=$G(DGENRRSN),DGENR("REGDATE")=$G(DGENRODT),DGENR("REGSRC")=$G(DGENSRCE)
 M DGENR("ELIG")=DGELGSUB
 ;
 Q 1

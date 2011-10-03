DGENA3 ;ALB/CJM,ISA/KWP,RTK,TDM,LBD,PHH,PJR,TDM - Enrollment API - Consistency check 05/05/99 ; 4/10/09 1:27pm
 ;;5.3;Registration;**232,306,327,367,417,454,456,491,514,451,808**;Aug 13,1993;Build 4
 ;CHECKand TESTVAL moved from DGENA1
CHECK(DGENR,DGPAT,ERRMSG) ;
 ;Phase II consistency checks do not include INACTIVE(3),REJECTED(4),SUSPENDED(5),EXPIRED(8),PENDING(9) enrollment statuses.  References to these statuses have been removed.
 ;Description: Does validation checks on the enrollment contained in the
 ;     DGENR array.
 ;Input:
 ;  DGENR - this local array contains an enrollment and should be passed
 ;      by reference
 ;  DGPAT - this local array contains the patient object, it is optional
 ;          If not passed,the database is referenced. (pass by reference)
 ;Output:
 ;  Function Value - returns 1 if all validation checks passed, 0
 ;     otherwise
 ;  ERRMSG - if the consistency checks fail, an error msg is returned (pass by reference)
 N VALID,DGELGSUB,SUB,PRIGRP
 S VALID=0
 S ERRMSG=""
 D  ;drops out of block if invalid condition found
 .I '$G(DGENR("DFN")) S ERRMSG="PATIENT NOT FOUND IN DATABASE" Q
 .I '$D(^DPT(DGENR("DFN"),0)) S ERRMSG="PATIENT NOT FOUND IN DATABASE" Q
 .;if it points to a prior record, the DFN must match
 .I DGENR("PRIORREC") D  Q:(ERRMSG'="")
 ..N DFN
 ..S DFN=$P($G(^DGEN(27.11,DGENR("PRIORREC"),0)),"^",2)
 ..I DFN,DFN'=DGENR("DFN") S ERRMSG="PATIENT'S PRIOR ENROLLMENT BELONGS TO ANOTHER PATIENT"
 .;check for required fields
 .F SUB="APP","SOURCE","STATUS","EFFDATE" I $G(DGENR(SUB))="" S ERRMSG="ENROLLMENT FIELD "_$$GET1^DID(27.11,$$FIELD^DGENU(SUB),"","LABEL")_" IS MISSING" Q
 .Q:(ERRMSG'="")
 .;if the enrollment priority is present, it must be correct
 .M DGELGSUB=DGENR("ELIG")
 .;Phase II if the enrollment priority is present it must be correct based on the eligibility factors (SRS 6.5.1.2 d)
 .;  ** temporarily commented out for HVE Phase II and III **
 .;I DGENR("PRIORITY") D  Q:(ERRMSG'="")
 .;.S PRIGRP=$$PRI^DGENELA4(DGENR("ELIG","CODE"),.DGELGSUB,DGENR("DATE"),$G(DGENR("APP")))
 .;.;check priority
 .;.I DGENR("STATUS")=6 Q     ; do not check priority for deceased
 .;.I DGENR("PRIORITY")'=$P(PRIGRP,"^") D  Q
 .;..I $G(DGCDIS("VCD"))'="" Q
 .;..S ERRMSG="ENROLLMENT PRIORITY IS INCONSISTENT WITH ELIGIBILITY DATA - PRIORITY SHOULD BE "_$P(PRIGRP,"^")_$$EXTERNAL^DILFD(27.11,.12,"F",$P(PRIGRP,"^",2))
 .;.;check subgroup if priority = 7 or 8
 .;.Q:DGENR("PRIORITY")<7
 .;.; sub-priority "e" can be overridden with "a" at HEC
 .;.I "^1^1^5^5^1^"[("^"_DGENR("SUBGRP")_"^"_$P(PRIGRP,"^",2)_"^") Q
 .;.; sub-priority "g" can be overridden with "c" at HEC
 .;.I "^3^3^7^7^3^"[("^"_DGENR("SUBGRP")_"^"_$P(PRIGRP,"^",2)_"^") Q
 .;.S ERRMSG="ENROLLMENT PRIORITY IS INCONSISTENT WITH ELIGIBILITY DATA - PRIORITY SHOULD BE "_$P(PRIGRP,"^")_$$EXTERNAL^DILFD(27.11,.12,"F",$P(PRIGRP,"^",2))
 .; end of temporary comments
 .;
 .;Phase II require priority if status is VERIFIED(2),REJECTED-INITIAL APP(14),REJECTED-FISCAL YEAR(11),REJECTED-MIDCYCLE(12),REJECTED-STOP ENROLL(13),REJECTED BELOW EGT THRESHOLD(SRS 6.5.1.2 b)
 .I (DGENR("STATUS")=2)!(DGENR("STATUS")=14)!(DGENR("STATUS")=11)!(DGENR("STATUS")=12)!(DGENR("STATUS")=13)!(DGENR("STATUS")=22),DGENR("PRIORITY")="" D  Q
 ..S ERRMSG="ENROLLMENT PRIORITY IS REQUIRED WITH ENROLLMENT STATUSES: VERIFIED,REJECTED-INITIAL APPLICATION BY VAMC,REJECTED-FISCAL YEAR,REJECTED-MID-CYCLE,REJECTED-STOP NEW ENROLLMENTS,REJECTED-BELOW EGT"
 .;Phase II require enrollment date when status is verified(2)(SRS 6.5.1.2 d)
 .I DGENR("STATUS")=2,DGENR("DATE")="" S ERRMSG="ENROLLMENT DATE IS REQUIRED WHEN STATUS IS VERIFIED" Q
 .;Phase II if enrollment date present with statuses other than verified then veteran must be previously VERIFIED(2) and enrolled (SRS 6.5.1.2 d)
 .N CURIEN S CURIEN=$$FINDCUR^DGENA(DGENR("DFN"))
 .I DGENR("DATE"),DGENR("DATE")'="@",DGENR("STATUS")'=2,'CURIEN S ERRMSG="ENROLLMENT DATE IS PRESENT WITH STATUS OTHER THAN VERIFIED AND THE VETERAN WAS NOT PREVIOUSLY ENROLLED." Q
 .I DGENR("DATE"),DGENR("DATE")'="@",DGENR("STATUS")'=2,CURIEN,$P($G(^DGEN(27.11,CURIEN,0)),"^",4)'=2 S ERRMSG="ENROLLMENT DATE IS PRESENT WITH STATUS OTHER THAN VERIFIED WAS PREVIOUSLY ENROLLED BUT THE PREVIOUS STATUS WAS NOT VERIFIED." Q
 .;if status is not CANCELED/DECLINED, the REASON field should be ""
 .I (DGENR("STATUS")'=7),DGENR("REASON") S ERRMSG="ENROLLMENT STATUS OF OTHER THAN CANCELED/DECLINED IS INCONSISTENT WITH REASON CANCELED/DECLINED" Q
 .;if not an eligible vet, enrollment must not have status of VERIFIED, or UNVERIFIED
 .;if status is CANCELED/DECLINED, then reason is required
 .I (DGENR("STATUS")=7),'DGENR("REASON") S ERRMSG="STATUS OF CANCELED/DECLINED REQUIRES REASON" Q
 .;if status is DECEASED and Date of Death is missing, send bulletin
 .; This bulletin has been disabled.  DG*5.3*808
 .;I DGENR("STATUS")=6 D
 .;.I $D(DGPAT),'DGPAT("DEATH") D BULLETIN
 .;.I '$D(DGPAT),'$$DEATH^DGENPTA(DGENR("DFN")) D BULLETIN
 .Q:(ERRMSG'="")
 .;certain statuses not allowed for a dead patient
 .I $D(DGPAT),DGPAT("DEATH"),(DGENR("STATUS")=1)!(DGENR("STATUS")=2) S ERRMSG="ENROLLMENT STATUS OF VERIFIED OR UNVERIFIED NOT ALLOWED FOR A DECEASED PATIENT" Q
 .I '$D(DGPAT),$$DEATH^DGENPTA(DGENR("DFN")),(DGENR("STATUS")=1)!(DGENR("STATUS")=2) S ERRMSG="ENROLLMENT STATUS OF VERIFIED OR UNVERIFIED NOT ALLOWED FOR A DECEASED PATIENT" Q
 .;all the field values must be valid
 .S SUB="" F  S SUB=$O(DGENR(SUB)) Q:((ERRMSG'="")!(SUB=""))  D
 ..I SUB'="ELIG",(SUB'="DATE"),(SUB'="FACREC") I '$$TESTVAL(SUB,DGENR(SUB)) S ERRMSG="ENROLLMENT FIELD "_$$GET1^DID(27.11,$$FIELD^DGENU(SUB),"","LABEL")_" IS NOT VALID"
 .Q:(ERRMSG'="")
 .S SUB="" F  S SUB=$O(DGENR("ELIG",SUB)) Q:((ERRMSG'="")!(SUB=""))  D
 ..I '$$TESTVAL(SUB,DGENR("ELIG",SUB)) S ERRMSG="ENROLLMENT FIELD  "_$$GET1^DID(27.11,$$FIELD^DGENU(SUB),"","LABEL")_" IS NOT VALID"
 .;if this point is reached it's valid
 .S VALID=1
 Q VALID
TESTVAL(SUB,VAL) ;
 ;Description: returns 1 if VAL is a valid value for subscript SUB
 N DISPLAY,FIELD,RESULT,VALID
 S VALID=1
 I (VAL'="") D
 .S FIELD=$$FIELD^DGENU(SUB)
 .;if there is no external value then it is not valid
 .S DISPLAY=$$EXTERNAL^DILFD(27.11,FIELD,"F",VAL)
 .I (DISPLAY="") S VALID=0 Q
 .I $$GET1^DID(27.11,FIELD,"","TYPE")'="POINTER" D
 ..D CHK^DIE(27.11,FIELD,,VAL,.RESULT) I RESULT="^" S VALID=0 Q
 Q VALID
BULLETIN ; Status vs. Date of Death Data Discrepancy Bulletin
 ; This bulletin has been disabled.  DG*5.3*808
 Q
 N DGBULL,DGLINE,DGMGRP,DGNAME,DIFROM,VA,VAERR,XMTEXT,XMSUB,XMDUZ
 S DGMGRP=$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",""))
 Q:'DGMGRP
 D XMY^DGMTUTL(DGMGRP,0,1)
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^DPT(DFN,0)),"^",9)
 S XMTEXT="DGBULL("
 S XMSUB="STATUS VS. DATE OF DEATH DATA DISCREPANCY"
 S DGLINE=0
 D LINE^DGEN("Patient: "_DGNAME,.DGLINE)
 D LINE^DGEN("SSN: "_DGSSN,.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("This Veteran's Enrollment Status is Deceased,",.DGLINE)
 D LINE^DGEN("however, there is no Date of Death on file for VistA.",.DGLINE)
 D LINE^DGEN("Actions you should take:",.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("- Add Date of Death Information in VistA, or",.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("- Contact the HEC to remove an erroneous Date of Death.",.DGLINE)
 D ^XMD
 Q

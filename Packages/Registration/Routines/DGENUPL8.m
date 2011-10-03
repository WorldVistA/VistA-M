DGENUPL8 ;ISA/KWP,RTK,PHH,ERC - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ; 8/15/08 12:41pm
 ;;5.3;REGISTRATION;**232,266,327,314,365,417,514,688**;Aug 13,1993;Build 29
 ;Moved ENRUPLD from DGENUPL3
 ;
ENRUPLD(DGENR,DGPAT) ;
 ;Description: uploads an enrollment receieved from HEC. The consistency
 ;checks are assumed to have been done, the other patient and eligibility
 ;data filed already.
 ;
 ;Inputs:
 ;  DGENR - enrollment array (pass by reference)
 ;  DGPAT - patient array (pass by reference)
 ;
 ;Output: none
 ;
 ;Phase II if HEC sends enrollment statuses VERIFIED(2),UNVERIFIED(1),REJECTED-FISCAL YEAR(11),REJECTED-MID-CYCLE(12),REJECTED-STOP ENROLLING NEW APPLiCANTS(13),PENDING-NO ELIGIBILITY CODE IN VIVA(15)
 ; PENDING-ELIGIBILITY UNVERIFIED(17),PENDING MEANS TEST REQUIRED(16),PENDING-OTHER(18),NOT ELIGIBLE; REFUSED TO PAY COPAY(19)
 ; NOT ELIGIBLE; INELIGIBLE DATE(20),PENDING PURPLE HEART UNCONFIRMED(21),DECEASED(6),CANCELED/DECLINED(7),REJECTED-INITIAL APPLICATION BY VAMC(14),REJECTED BELOW EGT THRESHOLD(22) then store enrollment (SRS6.5.1.2 f)
 ;
 N CURIEN,CURENR
 ;
 ;source should not be VAMC, since it is not a local enrollment
 I DGENR("SOURCE")=1 S DGENR("SOURCE")=2
 ;
 ;is there a local enrollment?
 S CURIEN=$$FINDCUR^DGENA(DGENR("DFN"))
 ;
 ;if there is no current enrollment, store HEC enrollment and quit
 I 'CURIEN D  G EXIT
 .;Phase II (SRS 6.5.1.2 f)
 .I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^23^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1)
 I '$$GET^DGENA(CURIEN,.CURENR) D  G EXIT
 .;Phase II (SRS 6.5.1.2 f)
 .I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^23^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;check for duplicate
 Q:$$DUP(.DGENR,.CURENR)
 ;
 ;if there is no local enrollment, HEC enrollment becomes current
 I CURENR("SOURCE")'=1 D  G EXIT
 .;Phase II (SRS 6.5.1.2 f)
 .I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^23^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1)
 ;********************************************************************
 ;check for exceptions to making HEC enrollment the patient's current enrollment,i.e.,cases in which local enrollment remains the current enrollment
 ;********************************************************************
 ;
 ;if local enrollment has status of Deceased, if the patient is dead and HEC's enrollment doesn't have status of Deceased reject upload
 I (CURENR("STATUS")=6),DGENR("STATUS")'=6,DGPAT("DEATH") D  G EXIT
 .D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),"LOCAL SITE REQUESTED TO VERIFY PATIENT DEATH",.ERRCOUNT)
 .D ADDMSG^DGENUPL3(.MSGS,"ELIBILITY UPLOAD DOESN'T CONTAINED DATE OF DEATH AND WAS REJECTED, PLEASE VERIFY PATIENT DEATH",1)
 .D NOTIFY^DGENUPL3(.DGPAT,.MSGS)
 .S ERROR=1
 ;
 ;Phase II if local enrollment has status UNVERIFIED(1),REJECTED-INITIAL APPLICATION BY VAMC(14),PENDING(9)
 ;and HEC sends status of REJECTED-FISCAL YEAR(11),REJECTED-MID-CYCLE(12),REJECTED-STOP ENROLLING APPLICATIONS(13),PENDING-NO ELIGIBILITY CODE in VIVA(15),REJECTED BELOW EGT THRESHOLD
 ;PENDING-ELIGIBILITY UNVERIFIED(17),PENDING-MEANS TEST REQUIRED(16),PENDING-OTHER(18)
 ;CANCELED/DECLINED(7) accept upload (SRS 6.5.1.2 h)
 I "^1^9^14^"[("^"_CURENR("STATUS")_"^"),"^7^11^12^13^15^16^17^18^19^20^21^22^23^"[("^"_DGENR("STATUS")_"^") D  G EXIT
 .I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;if local enrollment has status of Canceled/Declined, HEC enrollment has status of Verified or Unverified, HEC enrollment has an earlier or same effective date accept upload
 I (CURENR("STATUS")=7),"^1^2^"[("^"_DGENR("STATUS")_"^"),(CURENR("EFFDATE")'<DGENR("EFFDATE")) D  G EXIT
 .I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;If local enrollment has a status of Unverified(1) and the HEC enrollment
 ; status is Verified(2), Deceased(6), Cancelled/declined(7) or Pending; Means(16)
 ; Test Required accept upload
 I "^1^"[("^"_CURENR("STATUS")_"^"),"^2^6^7^16^19^20^21^"[("^"_DGENR("STATUS")_"^") D  G EXIT
 .I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;********************************************************
 ;end of exceptions
 ;********************************************************
 ;
 ;none of the exceptions apply, so make the HEC enrollment current
 ;Phase II (SRS 6.5.1.2 f)
 I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1)
EXIT Q
 ;
DUP(DGENR1,DGENR2) ;
 ;Descripition: returns 1 if the enrollments are dupliates (other than
 ;audit information), 0 otherwise
 ;
 ;Inputs:
 ;  DGENR1, DGENR2 are arrays containing enrollments (pass by reference)
 ;
 ;Outputs:
 ;  Function Value: 1 if identical, 0 otherwise
 ;
 N SUB,SAME
 S SAME=1
 S SUB=""
 F  S SUB=$O(DGENR1(SUB)) Q:SUB=""  D
 .Q:(SUB="ELIG")
 .Q:(SUB="DATETIME")
 .Q:(SUB="USER")
 .Q:(SUB="PRIORREC")
 .I DGENR1(SUB)'=DGENR2(SUB) S SAME=0
 I SAME D
 .S SUB=""
 .F  S SUB=$O(DGENR1("ELIG",SUB)) Q:SUB=""  I DGENR1("ELIG",SUB)'=DGENR2("ELIG",SUB) S SAME=0
 Q SAME
 ;
STOREHIS(DGENR,PRIORTO) ;
 ;Description: Stores the enrollment contained in the DGENR array
 ; before the enrollment pointed to by PRIORTO.
 ;
 ;Inputs:
 ;  DGENR - an array containing an enrollment to be stored
 ;  PRIORTO - ien of the enrollment where the new enrollment should be
 ;            stored.  DGENR will be stored as its prior enrollment.
 ;
 Q:'$G(PRIORTO)
 ;
 N DGENRIEN,OK
 S OK=1
 ;
 ;the new record should point to the record prior to PRIORTO
 S DGENR("PRIORREC")=$$FINDPRI^DGENA(PRIORTO)
 ;
 ;store the record
 S DGENRIEN=$$STORE^DGENA1(.DGENR,1)
 I 'DGENRIEN S OK=0
 ;
 ;now point the record=PRIORTO to the new record
 D:OK
 .N DATA
 .S DATA(.09)=DGENRIEN
 .I $$UPD^DGENDBS(27.11,PRIORTO,.DATA) ;then success
 Q

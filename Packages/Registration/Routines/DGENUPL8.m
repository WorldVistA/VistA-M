DGENUPL8 ;ISA/KWP,RTK,PHH,ERC - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ;8/15/08 12:41pm
 ;;5.3;REGISTRATION;**232,266,327,314,365,417,514,688,940,952**;Aug 13,1993;Build 160
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
 .I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^23^24^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1) ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
 I '$$GET^DGENA(CURIEN,.CURENR) D  G EXIT
 .;Phase II (SRS 6.5.1.2 f)
 .I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^23^24^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1) ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
 ;
 ;check for duplicate
 Q:$$DUP(.DGENR,.CURENR)
 ;
 ;if there is no local enrollment, HEC enrollment becomes current
 I CURENR("SOURCE")'=1 D  G EXIT
 .;Phase II (SRS 6.5.1.2 f)
 .I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^23^24^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1) ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
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
 I "^1^9^14^"[("^"_CURENR("STATUS")_"^"),"^7^11^12^13^15^16^17^18^19^20^21^22^23^24^"[("^"_DGENR("STATUS")_"^") D  G EXIT  ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
 .I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;if local enrollment has status of Canceled/Declined, HEC enrollment has status of Verified or Unverified, HEC enrollment has an earlier or same effective date accept upload
 I (CURENR("STATUS")=7),"^1^2^24^"[("^"_DGENR("STATUS")_"^"),(CURENR("EFFDATE")'<DGENR("EFFDATE")) D  G EXIT  ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
 .I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;If local enrollment has a status of Unverified(1) and the HEC enrollment
 ; status is Verified(2), Deceased(6), Cancelled/declined(7) or Pending; Means(16)
 ; Test Required accept upload
 I "^1^"[("^"_CURENR("STATUS")_"^"),"^2^6^7^16^19^20^21^24^"[("^"_DGENR("STATUS")_"^") D  G EXIT ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
 .I $$STORECUR^DGENA1(.DGENR,1)
 ;
 ;********************************************************
 ;end of exceptions
 ;********************************************************
 ;
 ;none of the exceptions apply, so make the HEC enrollment current
 ;Phase II (SRS 6.5.1.2 f)
 I "^1^2^6^7^11^12^13^14^15^16^17^18^19^20^21^22^24^"[("^"_DGENR("STATUS")_"^") I $$STORECUR^DGENA1(.DGENR,1) ;DJE DG*5.3*940 - Closed Application (status 24) - RM#867186
EXIT Q
 ;
DUP(DGENR1,DGENR2) ;
 ;Description: returns 1 if the enrollments are duplicates (other than
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
 ;
OTHUPLD(DFN,DGOTH,DGSSN,PRELIG) ; uploads OTH data. DG*5.3*952
 ;
 ; DFN - patient DFN
 ; DGOTH - OTH array (passed by reference)
 ; DGSSN - patient SSN
 ; PRELIG - primary eligibility code
 ;
 ; assumes MSGID,ERRCOUNT to be defined in the calling routine
 ;
 N DA,DIK
 N CNT,IEN33,IEN3301,QFLG,PNDCRTS,Z
 S IEN33=+$O(^DGOTH(33,"B",DFN,"")),QFLG=0
 I $$GET1^DIQ(8,PRELIG_",",.01)="EXPANDED MH CARE NON-ENROLLEE",'$$CHKTS(IEN33,.DGOTH) D  Q
 .D ADDERROR^DGENUPL(MSGID,DGSSN,"VISTA HAS THE MOST RECENT OTH-90 DATA",.ERRCOUNT)
 .Q
 S PNDCRTS=$$GET1^DIQ(33,IEN33_",",.08,"I")
 ; pending request
 I $G(DGOTH("P"))'="" D
 .S Z=$$FILPEND^DGOTHUT1(DFN,"0^^^^^^") I +Z=0 D ADDERROR^DGENUPL(MSGID,DGSSN,$P(Z,U,2),.ERRCOUNT) S QFLG=1 Q
 .I $P(DGOTH("P"),U,2)'="@" D
 ..S Z=$$FILPEND^DGOTHUT1(DFN,DGOTH("P")) I +Z=0 D ADDERROR^DGENUPL(MSGID,DGSSN,$P(Z,U,2),.ERRCOUNT) S QFLG=1
 ..Q
 .Q
 I QFLG Q
 ; re-sort array
 D SORTOTH(.DGOTH)
 ; denied requests
 I $D(DGOTH("D"))>0 D  Q:QFLG
 .; clear sub-file 33.03
 .S DIK="^DGOTH(33,"_IEN33_",3,",DA(1)=IEN33
 .S DA=0 F  S DA=$O(^DGOTH(33,IEN33,3,DA)) Q:'DA  D ^DIK
 .K DA
 .S CNT="" F  S CNT=$O(DGOTH("D",CNT)) Q:'CNT!QFLG  D
 ..I $P(DGOTH("D",CNT),U)="@" Q  ; skip this entry, if it is marked for deletion
 ..; if there's a pending request with the same creation timestamp, delete it
 ..I PNDCRTS=$P(DGOTH("D",CNT),U,5) D  Q:QFLG
 ...S Z=$$FILPEND^DGOTHUT1(DFN,"0^^^^^^") I +Z=0 D ADDERROR^DGENUPL(MSGID,DGSSN,$P(Z,U,2),.ERRCOUNT) S QFLG=1
 ...Q
 ..S Z=$$FILDEN^DGOTHUT1(DFN,DGOTH("D",CNT))
 ..I +Z=0 D ADDERROR^DGENUPL(MSGID,DGSSN,$P(Z,U,2),.ERRCOUNT) S QFLG=1 Q
 ..Q
 .Q
 ; approved periods
 I $D(DGOTH("A"))>0 D  Q:QFLG
 .S IEN3301=0 F  S IEN3301=$O(^DGOTH(33,IEN33,1,IEN3301)) Q:'IEN3301  D
 ..S DIK="^DGOTH(33,"_IEN33_",1,"_IEN3301_",1,",DA(2)=IEN33,DA(1)=IEN3301
 ..S DA=0 F  S DA=$O(^DGOTH(33,IEN33,1,IEN3301,1,DA)) Q:'DA  D ^DIK
 ..K DA S DIK="^DGOTH(33,"_IEN33_",1,",DA(1)=IEN33,DA=IEN3301 D ^DIK
 ..Q
 .S CNT="" F  S CNT=$O(DGOTH("A",CNT)) Q:'CNT!QFLG  D
 ..I $P(DGOTH("A",CNT),U,3)="@" Q  ; skip this entry, if it is marked for deletion
 ..; if there's a pending request with the same creation timestamp, delete it
 ..I PNDCRTS=$P(DGOTH("A",CNT),U,9) D  Q:QFLG
 ...S Z=$$FILPEND^DGOTHUT1(DFN,"0^^^^^^") I +Z=0 D ADDERROR^DGENUPL(MSGID,DGSSN,$P(Z,U,2),.ERRCOUNT) S QFLG=1
 ...Q
 ..S Z=$$FILAUTH^DGOTHUT1(DFN,DGOTH("A",CNT))
 ..I +Z=0 D ADDERROR^DGENUPL(MSGID,DGSSN,$P(Z,U,2),.ERRCOUNT) S QFLG=1 Q
 ..Q
 .Q
 Q
 ;
CHKTS(IEN33,DGOTH) ; check "last edited" timestamps in file 33 DG*5.3*952
 ;
 ; IEN33 - file 33 ien
 ; DGOTH - OTH array (passed by reference)
 ;
 ; returns 0 if the latest timestamp in file 33 is more recent than the latest timestamp in DGOTH, returns 1 otherwise
 ;
 N IENS,LASTTS1,LASTTS2,RES,TMPTS,Z,Z1
 S RES=1 I $G(IEN33)'>0 G CHKTSX
 S (LASTTS1,LASTTS2)=0
 ; find the latest timestamp in file 33
 S IENS=IEN33_","
 S TMPTS=+$$GET1^DIQ(33,IENS,.05,"I") I TMPTS>LASTTS1 S LASTTS1=TMPTS
 S Z=0 F  S Z=$O(^DGOTH(33,IEN33,1,Z)) Q:'Z  D
 .S Z1=0 F  S Z1=$O(^DGOTH(33,IEN33,1,Z,1,Z1)) Q:'Z1  D
 ..S IENS=Z1_","_Z_","_IEN33_","
 ..S TMPTS=+$$GET1^DIQ(33.11,IENS,.06,"I") I TMPTS>LASTTS1 S LASTTS1=TMPTS
 ..Q
 .Q
 S Z=0 F  S Z=$O(^DGOTH(33,IEN33,3,Z)) Q:'Z  D
 .S IENS=Z_","_IEN33_","
 .S TMPTS=+$$GET1^DIQ(33.03,IENS,.05,"I") I TMPTS>LASTTS1 S LASTTS1=TMPTS
 .Q
 I LASTTS1=0 G CHKTSX
 ; find the latest timestamp in DGOTH array
 S TMPTS=+$P($G(DGOTH("P")),U,6) I TMPTS>LASTTS2 S LASTTS2=TMPTS
 S Z=0 F  S Z=$O(DGOTH("A",Z)) Q:'Z  S TMPTS=+$P($G(DGOTH("A",Z)),U,10) I TMPTS>LASTTS2 S LASTTS2=TMPTS
 S Z=0 F  S Z=$O(DGOTH("D",Z)) Q:'Z  S TMPTS=+$P($G(DGOTH("D",Z)),U,6) I TMPTS>LASTTS2 S LASTTS2=TMPTS
 ; compare timestamps
 I LASTTS1>LASTTS2 S RES=0
 ;
CHKTSX ; exit point
 Q RES
 ;
SORTOTH(DGOTH) ; re-sort DGOTH array DG*5.3*952
 ;
 ; DGOTH - OTH array (passed by reference)
 ;
 N CNT,TMP,TYPE,VAL,Z,Z1
 ; sort approved requests by 365 day period # and 90 day period #
 ; sort denied requests by submission date and creation timestamp
 F TYPE="A","D" D
 .K TMP S CNT="" F  S CNT=$O(DGOTH(TYPE,CNT)) Q:'CNT  D
 ..S VAL=DGOTH(TYPE,CNT),Z=$P(VAL,U),Z1=$P(VAL,U,$S(TYPE="A":2,1:5))
 ..I Z'="",Z1'="" S TMP(Z,Z1)=VAL
 ..Q
 .K DGOTH(TYPE) S CNT=0
 .S Z="" F  S Z=$O(TMP(Z)) Q:Z=""  D
 ..S Z1="" F  S Z1=$O(TMP(Z,Z1)) Q:Z1=""  S CNT=CNT+1,DGOTH(TYPE,CNT)=TMP(Z,Z1)
 ..Q
 .Q
 Q

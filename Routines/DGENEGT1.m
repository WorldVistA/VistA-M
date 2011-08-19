DGENEGT1 ;ALB/KCL,ISA/KWP,LBD,RGL,BRM,DLF,TDM - Enrollment Group Threshold API's ; 6/17/09 11:05am
 ;;5.3;Registration;**232,417,454,491,513,451,564,672,717,688,803,754**;Aug 13, 1993;Build 46
 ;
 ;
NOTIFY(DGEGT,OLDEGT) ;
 ; Description: This is used to send a message to local mail group.
 ; The notification is used to communicate changes in the Enrollment
 ; Group Threshold (EGT) setting to users at the local site.
 ;
 ;  Input:
 ;    DGEGT - the new Enrollment Group Threshold array, passed by reference
 ;   OLDEGT - the previous Enrollment Group Threshold array, passed by reference
 ;
 ; Output: None
 ;
 N TEXT,XMDUN,XMDUZ,XMTEXT,XMROU,XMSTRIP,XMSUB,XMY,XMZ,OLDPRI
 ;
 ; init subject and sender
 S XMSUB="Enrollment Group Threshold (EGT) Changed"
 S (XMDUN,XMDUZ)="Registration Enrollment Module"
 ;
 ; recipient
 S XMY("G.DGEN EGT UPDATES")=""
 ;
 ; get old EGT priority
 S OLDPRI=$G(OLDEGT("PRIORITY"))
 ;
 S XMTEXT="TEXT("
 S TEXT(1)="The Secretary of the VA has officially changed the enrollment priority"
 S TEXT(2)="grouping of veterans who shall receive care.  This change may place"
 S TEXT(3)="veterans under your facilities care into a 'Not Enrolled' category."
 S TEXT(4)=""
 S TEXT(5)=""
 S TEXT(6)="           Prior EGT Priority:  "_$S($G(OLDPRI):$$EXTERNAL^DILFD(27.16,.02,"F",OLDPRI),1:"N/A")_$S($G(OLDEGT("SUBGRP")):$$EXTERNAL^DILFD(27.16,.03,"F",OLDEGT("SUBGRP")),1:"")
 S TEXT(7)=""
 S TEXT(8)=""
 S TEXT(9)="  New Enrollment Group Threshold (EGT) Settings:"
 S TEXT(10)=""
 S TEXT(11)="                 EGT Priority:  "_$$EXTERNAL^DILFD(27.16,.02,"F",DGEGT("PRIORITY"))_$S($G(DGEGT("SUBGRP")):$$EXTERNAL^DILFD(27.16,.03,"F",DGEGT("SUBGRP")),1:"")
 S TEXT(12)="                     EGT Type:  "_$$EXTERNAL^DILFD(27.16,.04,"F",DGEGT("TYPE"))
 S TEXT(13)="           EGT Effective Date:  "_$$EXTERNAL^DILFD(27.16,.01,"F",DGEGT("EFFDATE"))
 ;
 ; mailman deliverey
 D ^XMD
 ;
 Q
 ;
 ;
DISPLAY() ;
 ; Description: Display Enrollment Group Threshold (EGT) settings.
 ;
 N DGEGT
 ;
 W !
 I '$$GET^DGENEGT($$FINDCUR^DGENEGT(),.DGEGT) W !,"Enrollment Group Threshold (EGT) settings not found."
 E  D
 .W !,?3,"Enrollment Group Threshold (EGT) Settings"
 .W !,?3,"========================================="
 .W !
 .W !?5,"Date Entered",?25,": ",$S('$G(DGEGT("ENTERED")):"-none-",1:$$EXTERNAL^DILFD(27.16,.01,"F",DGEGT("ENTERED")))
 .W !?5,"EGT Priority",?25,": ",$S('$G(DGEGT("PRIORITY")):"-none-",1:$$EXTERNAL^DILFD(27.16,.02,"F",DGEGT("PRIORITY")))_$S($G(DGEGT("SUBGRP"))="":"",1:$$EXTERNAL^DILFD(27.16,.03,"F",DGEGT("SUBGRP")))
 .W !?5,"EGT Type",?25,": ",$S($G(DGEGT("TYPE"))="":"-none-",1:$$EXTERNAL^DILFD(27.16,.04,"F",DGEGT("TYPE")))
 .W !?5,"EGT Effective Date",?25,": ",$S('$G(DGEGT("EFFDATE")):"-none-",1:$$EXTERNAL^DILFD(27.16,.05,"F",DGEGT("EFFDATE")))
 ;
 Q
 ;
ABOVE(DPTDFN,ENRPRI,ENRGRP,EGTPRI,EGTGRP,EGTFLG) ;
 ; Description: This function will determine if the enrollment is above
 ; the threshold.
 ;
 ;Input:
 ; DPTDFN - Patient File IEN
 ; ENRPRI - Enrollment Priority
 ; ENRGRP - Enrollment Sub-Group
 ; EGTPRI - EGT Priority (optional) - not used
 ; EGTGRP - EGT Sub-Group (optional) - not used
 ; EGTFLG - Flag to bypass additional EGT type 2 check (optional)
 ;          It is used by $$ABOVE2 to prevent re-entering the
 ;          sub-priority API ($$SUBPRI^DGENELA4)
 ; Output:
 ; Returns 1 if above 0 below. 
 ;
 I $G(ENRGRP)="" S ENRGRP=""
 I $G(ENRPRI)="" S ENRPRI=""
 N ABOVE,EGT,TODAY,X
 I '$$GET^DGENEGT($$FINDCUR^DGENEGT(),.EGT) Q 1
 D NOW^%DTC S TODAY=X
 I TODAY<EGT("EFFDATE") Q 1
 ;
 ;EGT type 2 - Stop New Enrollments
 ; or EGT type 4 - Enrollment Decision (ESP DG*5.3*491)
 I EGT("TYPE")=2!(EGT("TYPE")=4) D  Q ABOVE
 .S ABOVE=0
 .I ENRPRI<7 D  Q
 ..I ENRPRI'>EGT("PRIORITY") S ABOVE=1 Q
 .;do check for priorities 7 and 8
 .I ENRPRI<EGT("PRIORITY") S ABOVE=1 Q
 .I ENRGRP'>EGT("SUBGRP") S ABOVE=1 Q
 .I $$OVRRIDE(.DPTDFN,.EGT) S ABOVE=1
 ;
 ;EGT types 1 & 3
 ;do check for priorities 7 and 8
 I ENRPRI>6&(ENRPRI=EGT("PRIORITY")) S ABOVE=0 D  Q ABOVE
 .I ENRGRP'>(EGT("SUBGRP")) S ABOVE=1
 I ENRPRI'>(EGT("PRIORITY")) Q 1
 Q 0
 ;
ABOVE2(DPTDFN,ENRDT,PRIORITY,SUBGRP) ;
 ;
 ; Input: DPTDFN    - Patient File IEN
 ;        ENRDT     - enrollment effective date
 ;        PRIORITY  - enrollment priority
 ;        SUBGRP    - enrollment sub-priority (internal numeric value)
 ;
 ; Output: 1 or 0 for above or below EGT threshold
 ;
 N ABOVE,TODAY,X,EGT
 S ABOVE=1
 S:'$G(SUBGRP) SUBGRP=""
 S:'$G(PRIORITY) PRIORITY=""
 S:'$G(ENRDT) ENRDT=""
 D NOW^%DTC S TODAY=X
 Q:'$$GET^DGENEGT($$FINDCUR^DGENEGT(ENRDT),.EGT) 1
 Q:'$G(EGT("EFFDATE")) 1
 Q:TODAY<EGT("EFFDATE") 1
 Q:EGT("TYPE")#2 $$ABOVE(DPTDFN,PRIORITY,SUBGRP,"","",1)  ;If EGT type 1 or 3
 I '$$ABOVE(DPTDFN,PRIORITY,SUBGRP,"","",1) Q 0
 Q ABOVE
 ;
OVRRIDE(DPTDFN,EGT) ;check for previous EGT override by HEC and new rules
 N CVDT,ENRCAT,ENRDT,EGTENR,ENRIEN,DGPAT,STOP,CUR,CE
 S (STOP,CUR)=0
 I '$$GET^DGENELA(DPTDFN,.DGPAT) Q 0  ;Get current Patient file data
 ; Find most recent enrollment record
 S ENRIEN=$$FINDCUR^DGENA(.DPTDFN)
 F  Q:STOP!CUR  D
 .I 'ENRIEN S STOP=1 Q  ;cannot check if no current enrollment
 .I '$$GET^DGENA(ENRIEN,.EGTENR) S STOP=1 Q  ;need enr info to proceed
 .S ENRIEN=$$FINDPRI^DGENA(ENRIEN)
 .; If status is Pending, Deceased, Not Eligible, or Not Applicable
 .; ignore record and get previous
 .I "^6^15^16^17^18^19^20^21^23^"[(U_EGTENR("STATUS")_U) Q
 .S CUR=1
 I STOP Q 0
 S ENRDT=$$EDATE($G(EGTENR("APP")),$G(EGTENR("EFFDATE"))) S:'ENRDT ENRDT=DT
 S ENRCAT=$P($G(^DGEN(27.15,+EGTENR("STATUS"),0)),"^",2)
 ; If enrollment status was overridden at HEC, then cont. enroll.
 I EGTENR("SOURCE")=2,ENRDT'<EGT("EFFDATE"),ENRCAT="E" Q 1
 ; If status is Rejected or Cancelled/Declined, quit (no cont. enroll.)
 I "^4^7^11^12^13^22^"[(U_EGTENR("STATUS")_U) Q 0
 ; If Application Date or Effective Date of Change are prior to the
 ; EGT Effective Date then cont. enroll.
 I ENRDT<EGT("EFFDATE") Q 1
 ; If Enrollment Record is Verified, and meets one of the special CE
 ; rules, then cont. enroll.
 I ENRCAT="E" S CE=$$RULES(DPTDFN,.EGTENR,.EGT,.DGPAT) I CE Q CE>0
 ; Check previous enrollment records for Application Date/Effective
 ; Date and special CE rules
 S (STOP,CE)=0
 F  Q:STOP  D
 .I 'ENRIEN S STOP=1 Q  ;cannot check if no current enrollment
 .I '$$GET^DGENA(ENRIEN,.EGTENR) S STOP=1 Q  ;need enr info to proceed
 .S ENRIEN=$$FINDPRI^DGENA(ENRIEN)
 .; If status is Pending, Deceased, Not Eligible; Ineligible Date,
 .; or Not Applicable ignore record and get previous
 .I "^6^15^16^17^18^19^20^21^23^"[(U_EGTENR("STATUS")_U) Q
 .S ENRDT=$$EDATE($G(EGTENR("APP")),$G(EGTENR("EFFDATE"))) S:'ENRDT ENRDT=DT
 .S ENRCAT=$P($G(^DGEN(27.15,+EGTENR("STATUS"),0)),"^",2)
 .; If Application Date or Effective Date of Change are prior to the
 .; EGT Effective Date then cont. enroll.
 .I ENRDT<EGT("EFFDATE") S (STOP,CE)=1 Q
 .; If Enrollment Record is Verified, and meets one of the special CE
 .; rules, then cont. enroll.
 .I ENRCAT="E" S CE=$$RULES(DPTDFN,.EGTENR,.EGT,.DGPAT) I CE S STOP=1,CE=CE>0 Q
 Q CE
 ;
RULES(DPTDFN,EGTENR,EGT,DGPAT) ;check for new cont enrollment rules (DG*5.3*672)
 N RTN,STAEXP
 ; If veteran ever had a verified enrollment with SC 10%+ and is now
 ; SC 0% non-compensable then cont. enroll
 I EGTENR("ELIG","VACKAMT")&(EGTENR("ELIG","SCPER")>9)&(DGPAT("SCPER")=0)&(DGPAT("VACKAMT")'>0) Q 1
 ; If veteran ever had a verified enrollment with one of these
 ; eligibilities then cont. enroll:  AA, HB, VA Pension
 I EGTENR("ELIG","VACKAMT")&((EGTENR("ELIG","A&A")="Y")!(EGTENR("ELIG","HB")="Y")!(EGTENR("ELIG","VAPEN")="Y")) Q 1
 ; If AO Exposure Location = Korean DMZ prior to ESR implementation,
 ; or AO Exposure Location = Vietnam prior to Special Treatment
 ;    Authority (STA) termination
 ; then cont. enroll.
 ; **** NOTE: For patch DG*5.3*672 the ESR implementation date will
 ; be set to 12/29/2040.  This will be changed to the actual ESR
 ; implementation date in a later patch.
 ; DG*5.3*688 - Date changed to 3/21/2009
 I DGPAT("AO")="Y" D  I $G(RTN) Q RTN
 .I $S($D(EGTENR("ELIG","AOEXPLOC")):EGTENR("ELIG","AOEXPLOC"),1:DGPAT("AOEXPLOC"))="K",EGTENR("EFFDATE"),EGTENR("EFFDATE")<3090321 S RTN=1
 .I EGTENR("ELIG","AOEXPLOC")="V" D   ;Added with DG*5.3*754
 ..S STAEXP=$$STAEXP^DGENELA4("AO") Q:STAEXP<1
 ..I EGTENR("EFFDATE"),EGTENR("EFFDATE")<STAEXP S RTN=1
 ; If SWAC/EC = YES prior to Special Treatment (STA) termination
 ; then cont. enroll.
 I DGPAT("EC")="Y" D  I $G(RTN) Q RTN   ;Added with DG*5.3*754
 .Q:EGTENR("ELIG","EC")'="Y"
 .S STAEXP=$$STAEXP^DGENELA4("EC") Q:STAEXP<1
 .I EGTENR("EFFDATE"),EGTENR("EFFDATE")<STAEXP S RTN=1
 ; If combat vet end date is before application date, cont. enroll
 I $G(EGTENR("ELIG","CVELEDT"))'<ENRDT Q 1
 ; If veteran is enrolled due to MT status or Medicaid, cont. enroll
 ; UNLESS first verified enrollment record is due to MT status or
 ; Medicaid and the primary MT of that income year was changed to a
 ; status that would not enroll (e.g. due to IVM converted test,
 ; Hardship removal, or Medicaid removal).
 I ((EGTENR("PRIORITY")=7!EGTENR("PRIORITY")=8)&("^2^16^"[(U_EGTENR("ELIG","MTSTA")_U)))!((EGTENR("PRIORITY")=5)&((EGTENR("ELIG","MTSTA")=4)!(EGTENR("ELIG","MEDICAID")=1))) S RTN=1 D  Q RTN
 .N ENIEN,ENR,MTDT,MTIEN
 .S ENIEN=0 F  S ENIEN=$O(^DGEN(27.11,"C",+DPTDFN,ENIEN)) Q:'ENIEN  I $P($G(^DGEN(27.11,+ENIEN,0)),U,4)=2 D  Q
 ..I '$$GET^DGENA(ENIEN,.ENR) Q
 ..I ((ENR("PRIORITY")=7!ENR("PRIORITY")=8)&("^2^16^"[(U_ENR("ELIG","MTSTA")_U)))!((ENR("PRIORITY")=5)&(ENR("ELIG","VAPEN")'="Y")&((ENR("ELIG","MTSTA")=4)!(ENR("ELIG","MEDICAID")=1))) D
 ...S MTDT=$E(ENR("APP"),1,3)_"1231",MTIEN=$$LST^DGMTU(MTDT) Q:'MTIEN
 ...I $P($G(^DGMT(408.31,MTIEN,0)),U,3)=6 S RTN=-1
 Q 0
 ;
EDATE(APP,EFF) ; Compare the Application Date and Effective Date and
 ; return the earlier date
 N EDT
 S APP=$G(APP),EFF=$G(EFF)
 S EDT=APP I 'EDT S EDT=EFF Q EDT
 I EFF S:EFF<EDT EDT=EFF
 Q EDT

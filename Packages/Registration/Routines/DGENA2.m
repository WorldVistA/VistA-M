DGENA2 ;ALB/CJM,RTK,TDM,JAM,ASF,RN - Enrollment API - Automatic Update; 9/19/2002 ;1/31/03 11:54am
 ;;5.3;Registration;**121,122,147,232,327,469,491,779,788,824,982,993,1015,1045**;Aug 13,1993;Build 15
 ;
AUTOUPD(DFN,EVENT) ;
 ;Description: If the patient meets the criteria for transmission to HEC,
 ;   he is entered to the IVM PATIENT file for future transmission.
 ;   This procedure checks for changes in enrollment priority,
 ;   status and fields in the eligibility sub-record. If any changes are
 ;   found, the current enrollment record is automatically updated.
 ;Input:
 ;  DFN - Patient IEN
 ;  EVENT - Event Type (optional)
 ;          EVENT 1 : Date of Death Deleted
 ;          EVENT 2 : Ineligible Date Deleted
 ;Output: None
 ;
 ;if the eligibility/enrollment upload is in progess, do not do anything
 Q:($G(DGENUPLD)="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS")
 ;
 ; If the INCOME TEST DATA (Z10) upload is in progess, do not do anything
 Q:($G(IVMZ10)="UPLOAD IN PROGRESS")
 ;
 N DGENRIEN,DGENR1,DGENR2,STATUS,EFFDATE,OK,DEATH
 ;
 ;try to prevent problems rsulting from calling FM within FM
 N DS,D0,DO,D1,DA,DD,DS,DG,DIC,DICR,DIE,DIG,DIH,DIV,DIW,DIX,DQ,DR
 ;
 S EVENT=+$G(EVENT)
 ;
 D EVENT^IVMPLOG(DFN)
 ;
 D:$$LOCK^DGENA1($G(DFN))  ;may drop out of block
 .S DGENRIEN=$$FINDCUR^DGENA(DFN)
 .Q:'DGENRIEN
 .; DG*5.3*1045; comment out the line below. Do not use the global variable DGENRYN. 
 .;  Instead, the PT APPLIED FOR ENROLLMENT? field is retrieved in the $$GET^DGENA
 .;S:$G(DGENRYN)="" DGENRYN=$$GET1^DIQ(27.11,DGENRIEN_",",.14,"I") ;DG*5.3*993 Load new PT APPLIED FOR ENROLLMENT? field
 .Q:'$$GET^DGENA(DGENRIEN,.DGENR1)
 .S STATUS=$$EXT^DGENU("STATUS",DGENR1("STATUS"))
 .S (DEATH,EFFDATE)=$$DEATH^DGENPTA(DFN)
 .I STATUS'="VERIFIED",STATUS'="UNVERIFIED",STATUS'="DECEASED",STATUS'="REGISTRATION ONLY",STATUS'["NOT ELIGIBLE",STATUS'["PENDING",STATUS'["REJECTED" Q  ;DG*5.3*993 Added REGISTRATION ONLY
 .I STATUS="DECEASED",((EVENT'=1)!(DEATH)) Q
 .I DEATH,'$$VET^DGENPTA(DFN) Q     ;DG*5.3*993
 .; DG*5.3*1045 Commented the below line to update the Not Eligible, Inelgible Date status in the Patient Enrollment file.
 .;I STATUS["NOT ELIGIBLE",((EVENT'=2)!('$$VET^DGENPTA(DFN))) Q
 .S:'EFFDATE EFFDATE=DT
 .; DG*5.3*1045; comment out line below and replace the 9th parameter DGENRYN with DGENR1 array value
 .;Q:'$$CREATE^DGENA6(DFN,DGENR1("APP"),EFFDATE,DGENR1("REASON"),DGENR1("REMARKS"),.DGENR2,DGENR1("DATE"),DGENR1("END"),DGENRYN)  ;DG*5.3*993 Added 9th parameter DGENRYN
 .Q:'$$CREATE^DGENA6(DFN,DGENR1("APP"),EFFDATE,DGENR1("REASON"),DGENR1("REMARKS"),.DGENR2,DGENR1("DATE"),DGENR1("END"),DGENR1("PTAPPLIED"))
 .S OK=1
 .S:(DGENR1("PRIORITY")'=DGENR2("PRIORITY"))!(DGENR2("STATUS")'=DGENR1("STATUS")) OK=0
 .I OK D
 ..N SUB
 ..S SUB=""
 ..F  S SUB=$O(DGENR2("ELIG",SUB)) Q:SUB=""  S:(DGENR1("ELIG",SUB)'=DGENR2("ELIG",SUB)) OK=0
 .I 'OK D
 ..I (DGENR1("EFFDATE")=DGENR2("EFFDATE")),(DGENR1("SOURCE")=DGENR2("SOURCE")),(DGENR1("USER")=DGENR2("USER")),(DGENR1("DATETIME")\1)=(DGENR2("DATETIME")\1) D
 ...;in this case it's an overlay
 ...S DGENR2("PRIORREC")=DGENR1("PRIORREC")
 ...I $$EDITCUR^DGENA1(.DGENR2)
 ..E  D
 ...;in this case create a new record, to preserve the audit trail
 ...I $$STORECUR^DGENA1(.DGENR2)
 D UNLOCK^DGENA1($G(DFN))
 Q
MTUPD ;
 ;Description - entry point for Means Test Event Driver for Enrollment
 ;
 D AUTOUPD($G(DFN))
 Q
 ;
SDDIS ;Entry point for the DGEN SD DISPLAY CURRENT ENROLLMENT protocol,
 ;which hangs of the Scheduling Event Driver
 ;
 N DFN S DFN=$P($G(SDATA),"^",2)
 ;
 ;don't display if running in the background
 Q:$D(ZTQUEUED)
 ;
 ;don't want to display enrollment for non-vets with no enrollment status
 Q:('$$VET^DGENPTA(DFN))&('$$STATUS^DGENA(DFN))
 ;
 ;if making an appt., & in interactive mode, display enrollment status
 I ($G(SDAMEVT)=1),$G(SDMODE)=0 D
 .D DISPLAY^DGENU($P($G(SDATA),"^",2))
 .D PAUSE^VALM1
 ;
 ;want to do the same thing for check-in, unless appt just made
 I ($G(SDAMEVT)=4),$G(SDMODE)=0 D
 .;want to try avoiding giving display if it was done already
 .;so, if it is an unscheduled appt made today, skip
 .N PTNODE,SCNODE
 .S SCNODE=$G(^TMP("SDAMEVT",$J,"AFTER","SC"))
 .S PTNODE=$G(^TMP("SDAMEVT",$J,"AFTER","DPT"))
 .I +$P(SCNODE,"^",7)=$G(DT),$P(PTNODE,"^",7)=4 Q  ;unscheduled appt made today
 .D DISPLAY^DGENU($P($G(SDATA),"^",2))
 .D PAUSE^VALM1
 Q
 ;
ENROLL ;Entry point for the DGEN SD ENROLL PATIENT protocol, which hangs of
 ;the Scheduling Event Driver. This event enrolls patients upon check-out
 ;if there is no prior enrollment record.
 ;
 ; Input  -- SDATA & SDAMEVT defined by the scheduling event driver
 ; Output -- none
 ;
 N DGENR,DFN
 ;
 ;NOTE - it appears from testing that means test status REQUIRED is set
 ;within scheduling, obviating the need to do it here.  This is why
 ;several lines are commented out.
 ;
 ;N DGENR,DGOKF,DGREQF,DFN,DGMSGF,DG,DGMT,DGMTCOR,DGMTE,DGRGAUTO,DGWRT,XMZ,DIG,DIH
 ;
 ;appointment made, check if enrollment appointment request needs reset.
 ;if appointment cancelled, or no-show put back on call list if no appts.
 I ($G(SDAMEVT)=1)!($G(SDAMEVT)=2)!($G(SDAMEVT)=3) D REQUST(SDAMEVT,SDATA)
 ;check-out?
 Q:($G(SDAMEVT)'=5)
 ;
 S DFN=$P($G(SDATA),"^",2)
 ;
 ;don't enroll if the patient has an enrollment record
 I $$FINDCUR^DGENA(DFN) Q
 ;
 ;non-vet?
 Q:'$$VET^DGENPTA(DFN)
 ;
 ;dead?
 Q:$$DEATH^DGENPTA(DFN)
 ;
 ;Does patient require a Means Test?
 ;S DGMSGF=1
 ;D EN^DGMTR
 ;
 ;Create local enrollment array
 I $$CREATE^DGENA6(DFN,DT,,,,.DGENR) D
 . ;
 . ;Store local enrollment as current
 . I $$STORECUR^DGENA1(.DGENR) D
 . . ;
 . . ;If patient's means test status is required, send bulletin
 . . ;I $$MTREQ^DGEN(DFN) D MTBULL^DGEN(DFN,.DGENR)
 Q
 ;
REQUST(SDAMEVT,SDATA) ;
 ;1. Check if cancelled appt. If no appts found put back on call list.
 ;2. Automatic collection of Appointment Request Date and Appointment
 ;Request Response
 ;- Set when Enrollment Application Date >= 8/1/2005 AND
 ;-     Appointment Request Date is null. 
 ;
 ; Input  -- SDATA and SDAMEVT defined by scheduling event driver
 ; Output -- none
 ;
 ; $$GET1^DIQ to file #44 supported by ICR #93-A 
 ; and file #40.07 supported by ICR #93-C (only FM read to access field 1 - not using the "C" cross reference)
 N DGENRIEN,DGENR,DPTERR,DGCOM,DGADT,DFN,DGCLN
 I ($G(SDAMEVT)=2)!($G(SDAMEVT)=3) G CANNS
 ;apointment made?
 Q:($G(SDAMEVT)'=1)
 ;
 S DFN=$P($G(SDATA),"^",2)
 S DGADT=$P($G(SDATA),"^",3)
 S DGCLN=$P($G(SDATA),"^",4)
 ;get enrollment ien
 S DGENRIEN=$$FINDCUR^DGENA(DFN)
 I DGENRIEN,$$GET^DGENA(DGENRIEN,.DGENR) ;set-up enrollment array
 I $G(DGENR("APP"))>3050731 D
 . ;and, no appointment request date. Set request="yes", request date
 . I '$$GET1^DIQ(2,DFN,1010.1511,"I") D
 . . ;quit if 'non-count' clinic
 . . I ($$GET1^DIQ(44,DGCLN,2502,"I")="Y") Q
 . . ;quit if appt. date/time < date notified of request for appointment
 . . I DGADT<DT Q
 . . ;set fields
 . . N FDATA
 . . S FDATA(2,DFN_",",1010.159)=1
 . . S FDATA(2,DFN_",",1010.1511)=DT
 . . D FILE^DIE("","FDATA","DPTERR")
 . ;if appointment made, appt. request="yes", request status'="filled"
 . ;- set request status='filled' w comment
 . ; also, if non count clinic, do not file data.
 . I ($$GET1^DIQ(44,DGCLN,2502,"I")="Y") Q
 . I ($$GET1^DIQ(2,DFN,1010.159,"I")),($$GET1^DIQ(2,DFN,1010.161,"I")'="F") D
 . . ; jam; DG*5.3*982 - If not a Primary Care appointment, do not file data
 . . ;   -get clinic stop codes and call logic to check for and quit if this is a Primary Care Appt.
 . . N DGSCODE,DGCRCODE
 . . S DGSCODE=$$GET1^DIQ(44,DGCLN,8,"I"),DGCRCODE=$$GET1^DIQ(44,DGCLN,2503,"I")
 . . S DGSCODE=$$GET1^DIQ(40.7,DGSCODE,1),DGCRCODE=$$GET1^DIQ(40.7,DGCRCODE,1)
 . . ; ASF DG*5.3*1015 - remove primary clinic requirement
 . . ;I '$$PCACHK^DGENACL2(DGSCODE,DGCRCODE) Q 
 . . ;set fields
 . . N FDATA
 . . S FDATA(2,DFN_",",1010.161)="F"
 . . S DGCOM=$$GET1^DIQ(2,DFN,1010.163)
 . . S DGCOM=DGCOM_$S(DGCOM'="":"<>",1:"")_"AutoComm:"_$S($$GET1^DIQ(2,DFN,1010.161,"I")="":"null",1:$S($$GET1^DIQ(2,DFN,1010.161,"I")="I":"IN PROGRESS",1:$$GET1^DIQ(2,DFN,1010.161)))_"|FILLED by Scheduling"
 . . S FDATA(2,DFN_",",1010.163)=DGCOM
 . . D FILE^DIE("","FDATA","DPTERR")
 Q
 ;
CANNS ;If appointment cancelled or no-show, no appts made, put back on call list
 N DGRDTI,SDARRY,SDCNT,FDATA
 ;
 S DFN=$P($G(SDATA),"^",2)
 ;
 S DGRDTI=$$GET1^DIQ(2,DFN,1010.1511,"I")
 I 'DGRDTI Q
 S SDARRY(1)=DGRDTI_";" ;Look out from 'notify of request date' to future.
 S SDARRY(3)="R;I;NT" ;appointments made
 S SDARRY(4)=DFN
 ; jam; DG*5.3*982 - Modify this logic to add check for Primary Care Appointments.  If no PCA, put on the call list
 ; jam; DG*5.3*982; get fields 13, 14 and 15 (Primary Stop Code and IEN and Credit Stop Code and IEN and Non-Count Clinic indicator)
 S SDARRY("FLDS")="13;14;15"
 S SDCNT=$$SDAPI^SDAMA301(.SDARRY)
 I SDCNT>0 D  ;If only non-count clinic appts. put on call list, (DG*5.3*982 - or if no Primary Care appts, put on call list)
 . N DGCOUNT,DGSDCL,DGSDADT,DGAPPT,DGCREDIT,DGSTOP
 . S DGCOUNT=0 ; count clinic
 . S DGSDCL=0 F  S DGSDCL=$O(^TMP($J,"SDAMA301",DFN,DGSDCL)) Q:'DGSDCL  D  Q:DGCOUNT
 . . S DGSDADT="" F  S DGSDADT=$O(^TMP($J,"SDAMA301",DFN,DGSDCL,DGSDADT)) Q:'DGSDADT  D  Q:DGCOUNT
 . . . S DGAPPT=^TMP($J,"SDAMA301",DFN,DGSDCL,DGSDADT)
 . . . I $P(DGAPPT,U,15)="Y" Q   ; DG*5.3*982 - quit if this is a Non-Count Clinic - no need to go to the global
 . . . ; DG*5.3*982 - code below added to check for Primary Care appt
 . . . S DGCREDIT=$P($P(DGAPPT,U,14),";",2)   ;-Set the appointment's Credit Stop Code
 . . . S DGSTOP=$P($P(DGAPPT,U,13),";",2)     ;-Set the appointment's Stop Code Number
 . . . ; ASF DG*5.3*1015 - remove primary clinic requirement
 . . . S DGCOUNT=DGCOUNT+1
 . . . ;I $$PCACHK^DGENACL2(DGSTOP,DGCREDIT) S DGCOUNT=DGCOUNT+1    ;-Check for a Primary Care Appointment match
 . I DGCOUNT=0 S SDCNT=0  ;if only non-count clinic appts. (DG*5.3*982 - or no Prim Care appt), put on call list
 I SDCNT=0 D
 . S FDATA(2,DFN_",",1010.161)="@" ;delete status
 . S FDATA(2,DFN_",",1010.163)="@" ;delete comment
 . D FILE^DIE("","FDATA","DPTERR")
 Q

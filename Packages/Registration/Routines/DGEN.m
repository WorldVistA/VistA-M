DGEN ;ALB/RMO/CJM,JAM,RN - Patient Enrollment Option; 11/17/00 12:12pm ; 12/6/00 5:32pm
 ;;5.3;Registration;**121,122,165,147,232,314,624,993,1027,1045**;Aug 13,1993;Build 15
 ;
EN ;Entry point for stand-alone enrollment option
 ; Input  -- None
 ; Output -- None
 N DFN
 ;
 ;Get Patient file (#2) IEN - DFN
 D GETPAT^DGRPTU(,,.DFN,) G ENQ:DFN<0
 ;
 ;Load patient enrollment screen
 D EN^DGENL(DFN)
ENQ Q
 ;
EN1(DFN) ;Entry point for enrollment from registration and disposition
 ; Input  -- DFN Patient IEN
 ; Output -- None
 N DGDISP,DGENOUT,DGX,DGSTS,DGNOPMT
 ;
 ;Check if patient should be asked to enroll
 ;Begin DG*5.3*993
 S DGDISP=$P(XQY0,U,1)="DG DISPOSITION APPLICATION"
 S DGSTS=$$STATUS^DGENA(DFN)
 I DGDISP,$G(DGENRYN)=0 S DGDISP=0  ; coming from DG DISPOSITION DGENRYN is 0 DB
 I $G(DGENRYN)=1 S DGNOPMT=0   ; Added condition for Yes
 I $G(DGENRYN)="" D
 . I DGSTS=25 S DGDISP=0
 ;END DG*5.3*993
 N DGCHK S DGCHK=$$CHK(DFN)
 I (DGCHK)!(DGDISP) D
 . I $$ENRPAT(DFN,.DGENOUT,$G(DGENRYN))
 I '$$VET^DGENPTA(DFN) D REGONLY(DFN)   ; DG*5.3*993 NON-VETERANS 
 ;
 ;If user did not timeout or '^' and
 ;patient is an eligible veteran or has an enrollment status
 I '$G(DGENOUT),($$VET^DGENPTA(DFN)!($$STATUS^DGENA(DFN))) D
 . D DISPLAY^DGENU(DFN)  ;Display enrollment
EN1Q Q
 ;
CHK(DFN) ;Check if patient should be asked to enroll
 ; Input  -- DFN Patient IEN
 ; Output -- 1=Yes and 0=No
 N Y,STATUS
 S Y=1
 ;Is patient an eligible veteran
 S Y=$$VET^DGENPTA(DFN)
 ;
 ;Is patient already enrolled or pending enrollment
 S STATUS=$$STATUS^DGENA(DFN)
 ; Purple Heart added status 21
 I Y,(STATUS=9)!(STATUS=1)!(STATUS=2)!(STATUS=14)!(STATUS=15)!(STATUS=16)!(STATUS=17)!(STATUS=18)!(STATUS=21) S Y=0 ;DG*5.3*993
 Q +$G(Y)
 ;
CHK3(DFN) ;Check to restrict Register Only Patients to enroll from Patient Enrollment EP protocol
 ; Input  -- DFN Patient IEN
 ; Output -- 1=Yes and 0=No
 N Y,STATUS
 S Y=1
 S Y=$$VET^DGENPTA(DFN)
 S STATUS=$$STATUS^DGENA(DFN)
 I Y,(STATUS=9)!(STATUS=1)!(STATUS=2)!(STATUS=14)!(STATUS=15)!(STATUS=16)!(STATUS=17)!(STATUS=18)!(STATUS=21)!(STATUS=25) S Y=0 ;DG*5.3*993 To Disable EP protocol
 Q +$G(Y)
 ;End DG*5.3*993
ENRPAT(DFN,DGENOUT,DGENRYN) ;Enroll patient DG*5.3*993 Added third parameter 
 ; Input  -- DFN      Patient IEN
 ;        -- DGENRYN  (Optional) ENROLL Y/N question for registration 0=NO 1=YES
 ; Output -- 1=Successful and 0=Failure
 ;           DGENOUT  1=Timeout or up-arrow
 ;DG*5.3*993 - DO YOU WISH TO ENROLL now in initial registration questions DGENRYN=0 if NO to enroll
 N Y
 I $G(DGDISP),$G(DGNOPMT) S Y=$$ASK("enroll",.DGENOUT) S:Y DGENRYN=1 ;DG*5.3*993 If option used is Disposition an Application
 S DGENRYN=$G(DGENRYN)
 D  G ENRPATQ
 . S DGOKF=$$ENROLL(DFN,DGENRYN) ;DG*5.3*993 Added second parameter DGENRYN
 ;End of DG*5.3*993 mods
ENRPATQ Q +$G(DGOKF)
 ;
ASK(ACTION,DGENOUT) ;Ask patient if s/he would like to enroll or cease enrollment
 ; Input  -- ACTION   Action description
 ; Output -- 1=Yes and 0=No
 ;           DGENOUT  1=Timeout or up-arrow
 N DIR,DTOUT,DUOUT,Y
 S DIR("A")="Do you wish to "_ACTION_" in the VA Patient Enrollment System"
 S DIR("B")="YES",DIR(0)="Y"
 W ! D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S DGENOUT=1
 Q +$G(Y)
 ;
ENROLL(DFN,DGENRYN) ;Create new local unverified enrollment  DG*5.3*993 Added 2nd parameter DGENRYN
 ; Input -- DFN Patient IEN
 ;       -- DGENRYN  (Optional) ENROLL Y/N question for registration 0=NO 1=YES
 ; Output -- 1=Successful and 0=Failure
 N DGENR,DGOKF,DGREQF,APPDATE,DGNOW,STATUS,DGDSPM,DGENRP,DGMNU,DGEIEN,DGAPDT,DGEXST,DGAD,DGPT,DGREGO
 S DGEXST=0
 S DGMNU=0
 S DGAD=0
 S DGREGO=0
 S DGNOW=$$NOW^XLFDT()
 S STATUS=$$STATUS^DGENA(DFN)
 ;Lock enrollment record
 I '$$LOCK^DGENA1(DFN) D  G ENROLLQ
 . W !,">>> Another user is editing, try later ..."
 . D PAUSE^VALM1
 ;
 S DGDSPM=$P(XQY0,U,1)="DG DISPOSITION APPLICATION"
 S DGENRP=$P(XQY0,U,1)="DGEN PATIENT ENROLLMENT"
 I (DGDSPM)!(DGENRP) S DGMNU=1
 I DGENRP G ENROLLQ
 ;now that the enrollment history is locked, need to check again whether or not patient may be enrolled (query reply may have been received)
 G:'$$CHK^DGEN(DFN)&($G(DGDSPM)) ENROLLQ
 ;
 I $G(DGENRYN)=0,$G(DGENRODT)="" S DGENRODT=DGNOW   ;
 S DGEIEN=$$FINDCUR^DGENA(DFN)
 I DGEIEN S DGAPDT=$$GET1^DIQ(27.11,DGEIEN_",",.01,"I"),DGPT=$$GET1^DIQ(27.11,DGEIEN_",",.14,"I")
 I $G(DGAPDT) S DGEXST=1
 I ($G(DGENRYN)=0)!($G(DGPT)=0)!($G(STATUS)=25) S DGREGO=1
 I ($G(DGENRYN)=0)!($G(STATUS)=25),'DGEXST S APPDATE=DT S DGAD=1
 ;Ask Application Date if not already entered at beginning of registration DG*5.3*993
 I ($G(DGENRYN)=1)!($G(DGPT)=1) D
 . I $G(DGENRDT)?1.N.E S APPDATE=DGENRDT
 ;. E  I 'DGREGO,'DGMNU W ! I $$PROMPT^DGENU(27.11,.01,DT,.APPDATE,,1)
 ;
 ;
 D
 . ;Does patient require a Means Test?
 . D EN^DGMTR
 . ;Create local enrollment array
 . I $$CREATE^DGENA6(DFN,$G(APPDATE),,,,.DGENR,,,$G(DGENRYN)) D  ;DG*5.3*993 Added 9th parameter DGENRYN
 . . ;Store local enrollment as current
 . . I $$STORECUR^DGENA1(.DGENR) D
 . . . S DGOKF=1
 . . . ;Ask preferred facility
 . . . I $G(DGENRYN)'=0 D PREFER^DGENPT(DFN)
 . . . ;If patient's means test status is required, send bulletin
 . . . I $$MTREQ(DFN) D MTBULL(DFN,.DGENR)
ENROLLQ D UNLOCK^DGENA1(DFN)
 Q +$G(DGOKF)
 ;
CANCEL(DFN,DGENR,EFFDATE) ;Cancel current enrollment
 ; Input
 ;    DFN      Patient IEN
 ;    DGENR    Array containing current enrollment (pass by reference)
 ;    EFFDATE  Enrollment Effective Date Of Change  (optional)
 ; Output
 ;   Function Return Value is 1 if Successful and 0 on Failure
 ;
 N DGENR2,DGOKF,REASON,REMARKS,BEGIN,END,ERRMSG
 ;Lock enrollment record
 I '$$LOCK^DGENA1(DFN) D  G CANCELQ
 .W !,">>> Another user is editing, try later ..."
 .D PAUSE^VALM1
 W !
 ;Ask effective date of change for cessation
 I '$G(EFFDATE) D  G:'EFFDATE CANCELQ
 .N DIR
 .S BEGIN=$S(DGENR("DATE"):DGENR("DATE"),1:DGENR("APP"))
 .S END=DGENR("END")
 .S DIR(0)="D^::AEX"
 .S DIR("A")="Effective Date of Cancellation"
 .S DIR("B")=$$VIEWDATE(DT)
ASKDATE .W !,"Please enter the date to cease enrollment, no earlier than "_$$VIEWDATE(BEGIN)
 .I END W !,"and no later than "_$$VIEWDATE(END)_"."
 .D ^DIR
 .I $D(DIRUT)!('Y) S EFFDATE="" Q
 .E  S EFFDATE=Y I (EFFDATE<BEGIN)!(END&(END<EFFDATE)) G ASKDATE
 .;
 ;Ask reason canceled/declined enrollment
 I '$$PROMPT^DGENU(27.11,.05,,.REASON,1) G CANCELQ
 ;If reason is 'Other', ask for remarks 
 I REASON=4,'$$PROMPT^DGENU(27.11,25,,.REMARKS,1) G CANCELQ
 ;Create local enrollment array
 I $$CREATE^DGENA6(DFN,DGENR("APP"),EFFDATE,REASON,$G(REMARKS),.DGENR2,DGENR("DATE"),EFFDATE) D
 .;Store local enrollment as current
 .I $$STORECUR^DGENA1(.DGENR2,,.ERRMSG) D
 ..S DGOKF=1
 .E  D
 ..W !,$G(ERRMSG)
 ;
 D UNLOCK^DGENA1(DFN)
CANCELQ Q +$G(DGOKF)
 ;
DECLINE(DFN,APPDATE) ;Create Declined enrollment
 ; Input  -- DFN      Patient IEN
 ;           APPDATE  Application date  (optional)
 ; Output -- 1=Successful and 0=Failure
 N DGENR,DGOKF,REASON,REMARKS
 ;Lock enrollment record
 I '$$LOCK^DGENA1(DFN) D  G DECLINEQ
 . W !,">>> Another user is editing, try later ..."
 . D PAUSE^VALM1
 ;Ask enrollment date
 W !
 I '$G(APPDATE),'$$PROMPT^DGENU(27.11,.01,DT,.APPDATE) G DECLINEQ
 ;Ask reason declined enrollment
 I '$$PROMPT^DGENU(27.11,.05,,.REASON,1) G DECLINEQ
 ;If reason is 'Other', ask for remarks 
 I REASON=4,'$$PROMPT^DGENU(27.11,25,,.REMARKS,1) G DECLINEQ
 ;Create local enrollment array
 I $$CREATE^DGENA6(DFN,APPDATE,DT,REASON,$G(REMARKS),.DGENR) D
 . ;Store local enrollment as current
 . I $$STORECUR^DGENA1(.DGENR) D
 . . S DGOKF=1
 . . ;Ask preferred facility
 . . D PREFER^DGENPT(DFN)
 D UNLOCK^DGENA1(DFN)
DECLINEQ ;
 Q +$G(DGOKF)
 ;
MTBULL(DFN,DGENR) ;Create/Send means test 'REQUIRED' bulletin for PATIENT ENROLLMENT
 ;
 ;  Input:
 ;         DFN - patient IEN
 ;       DGENR - this local array represents the PATIENT ENROLLMENT and
 ;               should be passed by reference
 ;
 ; Output: None
 ;
 N DGBULL,DGLINE,DGMGRP,DGNAME,DIFROM,VA,VAERR,XMTEXT,XMSUB,XMDUZ
 ;
 ; get Means Test 'Required' mail group
 S DGMGRP=$P($G(^DG(43,1,"NOT")),"^",13)
 ;
 ; if mail group not defined, exit
 I 'DGMGRP G MTBULLQ
 ;
 ; set up XMY array
 D XMY^DGMTUTL(DGMGRP,0,1)
 ;
 ; obtain patient identifier
 D PID^VADPT6
 ;
 ; patient name
 S DGNAME=$P($G(^DPT(DFN,0)),"^")
 ;
 ; local array containing msg text
 S XMTEXT="DGBULL("
 ;
 ; - msg subject
 S XMSUB=$E("Patient: "_DGNAME,1,30)_" ("_VA("BID")_") "_"Means Test Required"
 ;
 ; - insert lines of text into message
 S DGLINE=0
 D LINE("The following patient is enrolled in the VA Patient Enrollment",.DGLINE)
 D LINE("System and 'REQUIRES' a means test.",.DGLINE)
 D LINE("",.DGLINE)
 D LINE("        Patient Name: "_DGNAME,.DGLINE)
 D LINE("          Patient ID: "_VA("PID"),.DGLINE)
 D LINE("",.DGLINE)
 D LINE("     Enrollment Date: "_$$EXT^DGENU("DATE",DGENR("DATE")),.DGLINE)
 D LINE("   Enrollment Status: "_$$EXT^DGENU("STATUS",DGENR("STATUS")),.DGLINE)
 D LINE("          Entered By: "_$$EXT^DGENU("USER",DGENR("USER")),.DGLINE)
 D LINE("   Date/Time Entered: "_$$EXT^DGENU("DATETIME",DGENR("DATETIME")),.DGLINE)
 D ^XMD
 ;
MTBULLQ Q
 ;
LINE(DGTEXT,DGLINE) ;Add lines of text to mail message
 ;
 ;  Input:
 ;    DGTEXT - as line of text to be inserted into mail message
 ;    DGLINE - as number of lines in message, passed by reference
 ;
 ; Output:
 ;    DGBULL - as local array containing message text
 ;
 S DGLINE=DGLINE+1
 S DGBULL(DGLINE)=DGTEXT
 Q
 ;
MTREQ(DFN) ; --
 ;Determine if Means Test (required) bulletin should be sent for patient.
 ;
 ;  Input:
 ;        DFN - patient IEN
 ;
 ; Output:
 ;        1=Successful and 0=Failure
 ;
 N DGMTNODE,DGMTREQ
 ;
 ;Last means test for patient
 S DGMTNODE=$$LST^DGMTU(DFN)
 ;
 ;If scheduling bulletin already sent, exit
 I $P($G(^DGMT(408.31,+DGMTNODE,"BUL")),"^")=DT G MTREQQ
 ;
 ;If patient means test status is 'REQUIRED'
 I $P(DGMTNODE,"^",4)="R" D
 . ;set flag (send bulletin)
 . S DGMTREQ=1
 ;
MTREQQ Q +$G(DGMTREQ)
 ;
VIEWDATE(FMDATE) ;
 ;This function changes a FM date to its external representation
 N Y
 S Y=$G(FMDATE)
 D DD^%DT
 Q Y
 ;
REGONLY(DFN) ;
 ; DG*5.3*1045 - capture ineligible reason DGINELREA
 N DGIENS,DGFDA,DGINELIG,DGENPTA,DGINELREA
 I $$GET^DGENPTA(DFN,.DGENPTA) S DGINELIG=$G(DGENPTA("INELDATE")),DGINELREA=$G(DGENPTA("INELREA"))
 ;Lock enrollment record
 I '$$LOCK^DGENA1(DFN) D  Q
 . W !,">>> Another user is editing, try later ..."
 . D PAUSE^VALM1
 Q:$$FINDCUR^DGENA(DFN)
 ; DG*5.3*1027 - Create empty enrollment record
 S DGFDA(27.11,"+1,",.01)=DT
 S DGFDA(27.11,"+1,",.02)=DFN
 D UPDATE^DIE("","DGFDA","DGIENS")
 I '$D(DGIENS(1)) D UNLOCK^DGENA1(DFN) Q
 K DGFDA
 ; DG*5.3*1027 - Set CURRENT ENROLLMENT field in the PATIENT file
 S DGFDA(2,DFN_",",27.01)=DGIENS(1) D FILE^DIE("","DGFDA")
 K DGFDA
 ; DG*5.3*1027 - Set field values into the enrollment record
 S DGFDA(27.11,DGIENS(1)_",",.03)=1
 ; DG*5.3*1045- Set Enrollment Status to 20 if Ineligible date and Ineligible reason are populated 
 I $G(DGINELIG)'="",$G(DGINELREA)'="" D
 . S DGFDA(27.11,DGIENS(1)_",",.04)=20
 ELSE  D
 . S DGFDA(27.11,DGIENS(1)_",",.04)=25
 S DGFDA(27.11,DGIENS(1)_",",.06)=$$INST^DGENU()
 S DGFDA(27.11,DGIENS(1)_",",.07)=""
 S DGFDA(27.11,DGIENS(1)_",",.08)=DT
 S DGFDA(27.11,DGIENS(1)_",",.14)=0
 ; DG*5.3*1027;RN - Added condition for application date if ineligible date is populated
 I $G(DGENRYN)=1,$G(DGINELIG)'="" S DGFDA(27.11,DGIENS(1)_",",.14)=1,DGFDA(27.11,DGIENS(1)_",",.01)=$G(DGENRDT)
 ;DG*5.3*1027;RN - Added logic for Registration reason, source and registration date for a non-veteran
 I $G(DGINELIG)="",$G(DGENRRSN)?."" S DGENRRSN=$$FIND1^DIC(408.43,"","X","UNANSWERED")
 I $G(DGENRODT)?."" S DGENRODT=DGNOW
 I $G(DGENSRCE)?."" S DGENSRCE=1
 S DGFDA(27.11,DGIENS(1)_",",.15)=$G(DGENRRSN)
 S DGFDA(27.11,DGIENS(1)_",",.16)=$G(DGENRODT)
 S DGFDA(27.11,DGIENS(1)_",",.17)=$G(DGENSRCE)
 S DGFDA(27.11,DGIENS(1)_",",50.01)=$$NATCODE^DGENELA($$GET1^DIQ(2,DFN_",",".361","I"))
 S DGFDA(27.11,DGIENS(1)_",",75.01)=$$NOW^XLFDT()
 S DGFDA(27.11,DGIENS(1)_",",75.02)=$G(DUZ)
 D FILE^DIE("","DGFDA")
 D UNLOCK^DGENA1(DFN)
 Q

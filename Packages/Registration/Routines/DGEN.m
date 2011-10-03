DGEN ;ALB/RMO/CJM - Patient Enrollment Option; 11/17/00 12:12pm ; 12/6/00 5:32pm
 ;;5.3;Registration;**121,122,165,147,232,314,624**;Aug 13,1993
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
 ; Input  -- DFN      Patient IEN
 ; Output -- None
 N DGENOUT
 ;
 ;Check if patient should be asked to enroll
 I $$CHK(DFN) D
 . ;Enroll patient
 . I $$ENRPAT(DFN,.DGENOUT)
 ;
 ;If user did not timeout or '^' and
 ;patient is an eligible veteran or has an enrollment status
 I '$G(DGENOUT),($$VET^DGENPTA(DFN)!($$STATUS^DGENA(DFN))) D
 . ;Display enrollment
 . D DISPLAY^DGENU(DFN)
EN1Q Q
 ;
CHK(DFN) ;Check if patient should be asked to enroll
 ; Input  -- DFN      Patient IEN
 ; Output -- 1=Yes and 0=No
 N Y,STATUS
 S Y=1
 ;Is patient an eligible veteran
 S Y=$$VET^DGENPTA(DFN)
 ;
 ;Is patient already enrolled or pending enrollment
 S STATUS=$$STATUS^DGENA(DFN)
 ; Purple Heart added status 21
 I Y,(STATUS=9)!(STATUS=1)!(STATUS=2)!(STATUS=14)!(STATUS=15)!(STATUS=16)!(STATUS=17)!(STATUS=18)!(STATUS=21) S Y=0
 Q +$G(Y)
 ;
ENRPAT(DFN,DGENOUT) ;Enroll patient
 ; Input  -- DFN      Patient IEN
 ; Output -- 1=Successful and 0=Failure
 ;           DGENOUT  1=Timeout or up-arrow
 N DGOKF
 ;Ask patient if s/he would like to enroll
 I $$ASK("enroll",.DGENOUT) D
 . ;If 'Yes' enroll patient
 . S DGOKF=$$ENROLL(DFN)
 ELSE  D
 . ;Quit if timeout or '^'
 . Q:$G(DGENOUT)
 . ;Otherwise patient declined enrollment
 . ;Cancel/decline functionality disabled by DG*5.3*232
 . ;S DGOKF=$$DECLINE(DFN,DT)
 . S DGOKF=0
 . ;* Prompt for requested appt. (DG*5.3*624)
 . I $P($G(^DPT(DFN,1010.15)),"^",9)="" DO
 . . N DGSXS,DGAPPTAN
 . . S DGSXS=$$PROMPT^DGENU(2,1010.159,1,.DGAPPTAN,"",1)
 . . I DGSXS DO
 . . . N DA,DR,DIE
 . . . S DA=DFN
 . . . S DIE="^DPT("
 . . . S DR="1010.159////^S X=DGAPPTAN"
 . . . D ^DIE
 . . . K DA,DR,DIE
 . . . ;*Set Appointment Request Date to current date
 . . . N DA,DR,DIE
 . . . S DIE="^DPT("
 . . . S DA=DFN
 . . . S DR="1010.1511////^S X=DT"
 . . . D ^DIE
 . . . K DA,DR,DIE
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
ENROLL(DFN) ;Create new local unverified enrollment
 ; Input  -- DFN      Patient IEN
 ; Output -- 1=Successful and 0=Failure
 N DGENR,DGOKF,DGREQF,APPDATE
 ;Lock enrollment record
 I '$$LOCK^DGENA1(DFN) D  G ENROLLQ
 . W !,">>> Another user is editing, try later ..."
 . D PAUSE^VALM1
 ;
 ;now that the enrollment history is locked, need to check again whether or not patient may be enrolled (query reply may have been received)
 G:'$$CHK^DGEN(DFN) ENROLLQ
 ;
 ;Ask Application Date
 W !
 I $$PROMPT^DGENU(27.11,.01,DT,.APPDATE) D
 . ;Does patient require a Means Test?
 . D EN^DGMTR
 . ;Create local enrollment array
 . I $$CREATE^DGENA6(DFN,APPDATE,,,,.DGENR) D
 . . ;Store local enrollment as current
 . . I $$STORECUR^DGENA1(.DGENR) D
 . . . S DGOKF=1
 . . . ;Ask preferred facility
 . . . D PREFER^DGENPT(DFN)
 . . . ;If patient's means test status is required, send bulletin
 . . . I $$MTREQ(DFN) D MTBULL(DFN,.DGENR)
 I $P($G(^DPT(DFN,1010.15)),"^",11)="" DO
 . N DGSXS,DGAPPTAN,DGDFLT
 . S DGDFLT=$P($G(^DPT(DFN,1010.15)),"^",9)
 . S:DGDFLT="" DGDFLT=1
 . S DGSXS=$$PROMPT^DGENU(2,1010.159,DGDFLT,.DGAPPTAN,"",1)
 . I DGSXS DO
 . . N DA,DR,DIE
 . . S DA=DFN
 . . S DIE="^DPT("
 . . S DR="1010.159////^S X=DGAPPTAN"
 . . D ^DIE
 . . K DA,DR,DIE
 . . ;*If patient answered NO to "Do you want an appt" question
 . . I $P($G(^DPT(DFN,1010.15)),"^",9)=0 DO
 . . . N DA,DR,DIE
 . . . S DIE="^DPT("
 . . . S DA=DFN
 . . . S DR="1010.1511////^S X=DT"
 . . . D ^DIE
 . . . K DA,DR,DIE
 . . ;*If patient answered YES to "Do you want an appt" question
 . . I $P($G(^DPT(DFN,1010.15)),"^",9)=1 DO
 . . . N DA,DR,DIE
 . . . S DIE="^DPT("
 . . . S DA=DFN
 . . . S DR="1010.1511////^S X=APPDATE"
 . . . D ^DIE
 . . . K DA,DR,DIE
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

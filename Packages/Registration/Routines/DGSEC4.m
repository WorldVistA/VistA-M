DGSEC4 ;ALB/MM,JAP - Utilities for record access & sensitive record processing;10/6/99 ; 10/26/05 12:46pm
 ;;5.3;Registration;**249,281,391,471,684,699**;Aug 13, 1993
 ;
 ;Line tags OWNREC & SENS moved from DGSEC in DG*5.3*249 when DGSEC 
 ;reached the maximum routine size.
 ;
PTSEC(RESULT,DFN,DGMSG,DGOPT) ;RPC/API entry point for patient sensitive & record access checks
 ;Output array (Required)
 ;    RESULT(1)= -1-RPC/API failed
 ;                  Required variable not defined
 ;                0-No display/action required
 ;                  Not accessing own, employee, or sensitive record
 ;                1-Display warning message
 ;                  Sensitive and DG SENSITIVITY key holder
 ;                  or Employee and DG SECURITY OFFICER key holder
 ;                2-Display warning message/require OK to continue
 ;                  Sensitive and not a DG SENSITIVITY key holder
 ;                  Employee and not a DG SECURITY OFFICER key holder
 ;                3-Access to record denied
 ;                  Accessing own record
 ;                4-Access to Patient (#2) file records denied
 ;                  SSN not defined
 ;   RESULT(2-10) = error or display messages
 ;
 ;Input parameters: DFN = Patient file entry (Required)
 ;                  DGMSG = If 1, generate message (optional)
 ;                  DGOPT  = Option name^Menu text (Optional)
 ;
 K RESULT
 I $G(DFN)="" D  Q
 .S RESULT(1)=-1
 .S RESULT(2)="Required variable missing."
 S DGMSG=$G(DGMSG)
 D OWNREC(.RESULT,DFN,$G(DUZ),DGMSG)
 I RESULT(1)=1 S RESULT(1)=3 Q
 I RESULT(1)=2 S RESULT(1)=4 Q
 K RESULT
 D SENS(.RESULT,DFN,$G(DUZ))
 I RESULT(1)=1 D
 .I $G(DUZ)="" D  Q
 ..;DUZ must be defined to access sensitive record & update DG Security log
 ..S RESULT(1)=-1
 ..S RESULT(2)="Your user code is undefined.  This must be defined to access a restricted patient record."
 .D SETLOG1^DGSEC(DFN,DUZ,,$G(DGOPT))
 Q
NOTICE(RESULT,DFN,DGOPT,ACTION) ;RPC/API entry point for log entry and message generation
 ;Input parameters:  
 ;  DFN    = Patient file DFN
 ;  DGOPT  = Option name^Menu text (Optional)
 ;  ACTION = 1 - Set DG Security Log entry, 2 - Generate mail 
 ;           message, 3 - Both (Optional - Defaults to both)
 ;
 ;Output:  RESULT = 1 - DG Security Log updated and/or Sensitive Record msg sent (Determined by ACTION value)
 ;                  0 - Required variable undefined
 ;
 I $G(DFN)="" S RESULT=0 Q
 I $G(DUZ)="" S RESULT=0 Q
 S DGOPT=$G(DGOPT)
 I $G(ACTION)="" S ACTION=3
 I ACTION'=1 D BULTIN1^DGSEC(DFN,DUZ,DGOPT)
 I ACTION'=2 D SETLOG1^DGSEC(DFN,DUZ,,DGOPT)
 S RESULT=1
 Q
 ;
OWNREC(DGREC,DFN,DGDUZ,DGMSG,DGNEWPT,DGPTSSN) ;Determine if user accessing his/her own Patient file (#2) record
 ;Input:
 ; DGREC - Array name passed by reference
 ; DFN - Patient (#2) file IEN
 ; DGDUZ - New Person (#200) file IEN (Not required. If not sent will return 0.)
 ; DGMSG - If 1, generate message (Optional) Will default to 1
 ; DGNEWPT - Set to 1 when adding a new entry to the Patient file
 ; DGPTSSN - new patient's SSN
 ;   DGNEWPT & DGPTSSN parameters only defined if DPTLK is adding
 ;   a new Patient (#2) file entry  
 ;
 ;Output:
 ; DGREC(1)=0 - Not attempting to access own Patient (#2) file record, 
 ;            DUZ not defined, RESTRICT PATIENT RECORD ACCESS parameter
 ;            in MAS Parameters (#43) file not set to yes, or user holds
 ;            DG RECORD ACCESS security key.
 ;         =1 - Attempting to access own Patient file record
 ;         =2 - SSN undefined
 ;         =-1 - Required variable not defined.
 ; Other nodes in array will contain error message text.
 ;
 ;DFN required
 I '$D(DFN),($G(DGNEWPT)'=1) D  Q
 .S DGREC(1)=-1
 .S DGREC(2)="DFN not defined."
 S DGREC(1)=0
 ;Check if parameter is on
 I +$P($G(^DG(43,1,"REC")),U)=0 Q
 N DGNPSSN
 ;I $D(DUZ)=0 Q
 I (+$G(DGDUZ))<1 Q
 ;Check if user holds security key
 I $D(^XUSEC("DG RECORD ACCESS",DGDUZ)) Q
 I $G(DGMSG)="" S DGMSG=1
 N DGNPERR
 ; quit if user is a proxy user, i.e., not a real person
 I $$ACTIVE^XUSAP(DGDUZ),$$USERTYPE^XUSAP(DGDUZ,"CONNECTOR PROXY")!($$USERTYPE^XUSAP(DGDUZ,"APPLICATION PROXY")) Q
 S DGNPSSN=$$GET1^DIQ(200,DGDUZ_",",9,"I","","DGNPERR")
 I 'DGNPSSN D  Q
 .S DGREC(1)=2
 .S DGREC(2)="Your SSN is missing from the NEW PERSON file.  Contact your ADP Coordinator."
 .;Only send message if parameter set to 1
 .I DGMSG=1 D MSG(DGDUZ)
 I +$G(DGNEWPT)'=1 S DGPTSSN=$P($G(^DPT(DFN,0)),U,9)
 I +$G(DGNEWPT)=1 S DGPTSSN=$TR(DGPTSSN,"-","")
 I DGNPSSN=DGPTSSN D  Q
 .S DGREC(1)=1
 .S DGREC(2)="Security regulations prohibit computer access to your own medical record."
 Q
MSG(DGDUZ) ;Send Missing SSN in New Person file message to mailgroup
 ;Input:  DGDUZ - New Person (#200) file IEN (Required)
 ;
 N DGNPERR,DGNPNAME,DGTEXT,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S DGNPNAME=$$GET1^DIQ(200,DGDUZ_",",.01,"","DGNPERR")
 S XMSUB="MISSING SSN IN NEW PERSON FILE"
 S DGTEXT(1)="The following NEW PERSON record does not contain a Social Security Number."
 S DGTEXT(2)="This is required to access PATIENT file entries."
 S DGTEXT(3)=""
 S DGTEXT(4)=$S(DGNPNAME'="":DGNPNAME,1:"UNKNOWN")
 S DGTEXT(5)="NEW PERSON (#200) File Internal Entry Number (DUZ):  "_+DGDUZ
 S DGTEXT(6)=""
 S DGTEXT(7)="This message has been sent to DG MISSING NEW PERSON SSN mail group."
 S DGTEXT(8)="Please take appropriate action."
 S XMTEXT="DGTEXT("
 S XMDUZ=$S(DGNPNAME'="":DGNPNAME,1:.5)
 S XMY("G.DG MISSING NEW PERSON SSN")=""
 S XMCHAN=1
 D ^XMD
 Q
SENS(DGSENS,DFN,DGDUZ,DDS,DGSENFLG) ;Determine if sensitive record
 ;Input:
 ;  DGSENS - Array name passed by reference
 ;  DFN - Patient (#2) file IEN (Required)
 ;  DGDUZ - New Person (#200) file IEN
 ;  DDS - Screenman variable
 ;  DGSENFLG - If defined, patient record sensitivity not checked
 ;
 ;Output:
 ;  DGSENS(1)=0 - Record is not sensitive or DGSENFLG set
 ;           =1 - Sensitive record and user holds DG SENSITIVITY key
 ;              - Employee and user holds DG SECURITY OFFICER key
 ;           =2 - Sensitive record and user does not hold key
 ;              - Employee and user does not hold key
 ;           =-1 - Required input variable not defined
 ;  If 1, 2 or -1, array will contain error/display message
 ;
 N DGMSG,DGA1,DG1,DGDATE,DGLNE,DGT,DGTIME,DGEMPLEE
 ;Patient file DFN must be defined.
 I '$D(DFN) D  Q 
 .S DGSENS(1)=-1
 .S DGSENS(2)="DFN not defined."
 S DGSENS(1)=0
 I $D(DGSENFLG) Q
 ;Determine if patient is employee
 S DGEMPLEE=$$EMPL(DFN)
 ;Quit if not an employee & not found in DG Security Log file
 I 'DGEMPLEE,('$D(^DGSL(38.1,+DFN,0))) Q
 ;Quit if not an employee and not flagged as sensitive
 I 'DGEMPLEE,($P($G(^DGSL(38.1,+DFN,0)),U,2)'=1) Q
 ;DUZ & user name must be defined
 S DGMSG=$S('$G(DGDUZ):"user code",'$D(^VA(200,DGDUZ,0)):"user name",1:"")
 I DGMSG'="" D  Q
 .S DGSENS(1)=-1
 .S DGSENS(2)="Your "_DGMSG_" is undefined.  This must be defined to access"
 .S DGSENS(3)=" a restricted patient record."
 S DGSENS(1)=1
 ;Inpatient check - no longer used (kept for future reference)
 ;D H^DGUTL S DGT=DGTIME D ^DGPMSTAT
 S DGSENS(2)="***WARNING***"
 I $G(DDS)'="" S DGSENS(2)=DGSENS(2)_"  ***RESTRICTED RECORD***"
 I $G(DDS)="" S DGSENS(3)="***RESTRICTED RECORD***"
 I DGEMPLEE,('$D(^XUSEC("DG SECURITY OFFICER",+$G(DGDUZ)))) D  Q
 .S DGSENS(1)=2
 .D PRIV
 I '$D(^XUSEC("DG SENSITIVITY",+$G(DGDUZ))) D
 .S DGSENS(1)=2
 .D PRIV
 Q
PRIV ;Privacy Act statement for DGSENS array
 S $P(DGLNE,"* ",38)=""
 I $G(DDS)="" S DGSENS(4)=DGLNE
 S DGSENS(5)="* This record is protected by the Privacy Act of 1974 and the Health    *"
 S DGSENS(6)="* Insurance Portability and Accountability Act of 1996. If you elect    *"
 S DGSENS(7)="* to proceed, you will be required to prove you have a need to know.    *"
 S DGSENS(8)="* Accessing this patient is tracked, and your station Security Officer  *"
 S DGSENS(9)="* will contact you for your justification.                              *"
 I $G(DDS)="" S DGSENS(10)=DGLNE
 Q
EMPL(DFN,DGCHELIG) ;Does patient have any eligibility codes equal to
 ;                EMPLOYEE
 ;Input:
 ;       DFN - Patient (#2) file IEN (required).
 ;  DGCHELIG - Flags to determine mode of execution (optional).
 ;             Value of the parameter can contain any combination
 ;             of the following characters:
 ;               "P" - check primary eligibility code
 ;               "S" - check secondary eligibility codes
 ;
 ;             If this parameter is either not defined or set to an
 ;             illegal value, the value of "PS" will be assumed.
 ;Output:
 ;         1 - Patient has EMPLOYEE as an eligibility code
 ;         0 - Patient doesn't have EMPLOYEE as an eligibility code
 ;
 ;Notes: EMPLOYEE is entry 14 in the MAS ELIGIBILITY CODE file (#8.1)
 N DGELIG,DGEMPLEE
 S DGEMPLEE=0
 I $G(DGCHELIG)'["P",$G(DGCHELIG)'["S" S DGCHELIG="PS"
 ;Check primary eligibility
 I DGCHELIG["P" D
 .S DGELIG=+$G(^DPT(DFN,.36))
 .I $D(^DIC(8,"D",14,DGELIG)) S DGEMPLEE=1
 ;Check secondary eligibilities (if needed)
 I DGCHELIG["S",'DGEMPLEE D
 .S DGELIG=0
 .F  S DGELIG=+$O(^DPT("AEL",DFN,DGELIG)) Q:'DGELIG  I $D(^DIC(8,"D",14,DGELIG)) S DGEMPLEE=1 Q
 Q DGEMPLEE

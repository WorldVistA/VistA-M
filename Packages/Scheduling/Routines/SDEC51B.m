SDEC51B ;ALB/LAB,ANU - VISTA SCHEDULING RPCS ;APR 12, 2021@14:39
 ;;5.3;Scheduling;**784,785**;Aug 13, 1993;Build 14
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to ^GMR(123 In ICR #4837
 ; Reference to ^GMR(123.5 In ICR #4557
 ; Reference to ^GMR(123 In ICR #6185
 ; Reference to ^ORD(100.01 In ICR #2638
 ; Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056 
 Q
 ;
CONSLIST(SDECY,DFN) ;Return a list of ACTIVE or PENDING CONSULTS for patient
 ;INPUT - DFN (Date File Number) Pointer to PATIENT (#2) File. 
 ;RETURN PARMETER:
 ; List of consults in ACTIVE or PENDING CPRS STATUS.  Data is delimited by 
 ; carat (^). 
 ; Field List:
 ; (1)     Internal IEN 
 ; (2)     Request Type
 ; (3)     File Entry Date
 ; (4)     To Service/Specialty
 ; (5)     Clinic IEN
 ; (6)     Clinic Name
 ; (7)     Date of Request
 ; (8)     URGENCY name or Earliest date
 ; (9)     Provider IEN
 ; (10)    Provider Name
 ; (11)    Service Rendered as in or outpatient
 ; (12)    Associated Stop Code
 ; (13)    Prohibited Clinic Flag
 ; (14)    Clinic indicated Date
 ; (15)    # of Phone contacts
 ; (16)    Date of Last Letter
 ; (17)    Covid Priority
 ;
 N ACTIVE,PENDING,ERRPOP,ERRMSG,SDECI,SDTMP
 S SDECI=$G(SDECI,0)
 D INIT
 D VALIDATE
 I ERRPOP D ERR1^SDECERR(-1,ERRMSG,.SDECI,SDECY) Q
 D SELCONS ;select "open" consults
 D EXIT
 Q
 ;
INIT ;
 K ^TMP("SDEC51B",$J)
 S SDECY="^TMP(""SDEC51B"","_$J_")"
 S ACTIVE=$O(^ORD(100.01,"B","ACTIVE",0))
 S PENDING=$O(^ORD(100.01,"B","PENDING",0))
 S ERRPOP=0,SDECI=0,ERRMSG=""
 ; data header
 D HDR
 Q
 ;
VALIDATE ;
 ;*Add validation of DFN
 I '(+DFN) D  Q
 .;create error message - DFN required
 .S ERRMSG="DFN required. "
 .S ERRPOP=1
 I '$D(^DPT(DFN,0)) D
 .;create error - Invalid DFN
 .S ERRMSG="Invalid DFN"
 .S ERRPOP=1
 Q
 ;
HDR ;Get the header information
 ;     
 ; Consult IEN^Request Type^ORIGDT^TO Service^CLINIEN^CLINNAME^Date of Request                                
 ; Prio^Provider IEN^Provider Name^Service Rendered As
 ; Req_Proc_Act^Stop^PRHBLOC^Earliest
 ; CPHONE^CLET^Covid_Priority
 ;         1                 2           3             4
 S SDTMP="T00020CONSULTIEN^T00020REQTYPE^T00020ORIGDT^T00030TO_SERVICE"
 ;                     5                6             7              8
 S SDTMP=SDTMP_"^T00010CLINIEN^T00030CLINNAME^T00030DATE_OF_REQUEST^T00030PRIO"
 ;                      9              10               11
 S SDTMP=SDTMP_"^T00030PROVIEN^T00030PROVNAME^T00030SERVICE_RENDERED_AS"
 ;                     12          13            14            15          16     17
 S SDTMP=SDTMP_"^T00100STOP^T00030PRHBLOC^T00030EARLIEST^T00030CPHONE^T00030CLET^T00030COVID_PRIORITY"
 S @SDECY@(SDECI)=SDTMP_$C(30)
 Q
SELCONS ;selection all open consults - those consults in PENDING and ACTIVE status
 N SDCONSID,CPRSSTAT,SDURGEN,SDREQTYPE,STOP,SIEN,SDTOSVC,PRHBLOC,COVPRIORITY,IFCSTAT
 N SDORIGDT,SDTOSVC,SDTOSVCI,SDCLIEN,SDCLNAME,SDDOREQ,SDPRIO,SDPRIEN,SDPRNAME,SDSRA,SDCOMM,SDSTOP
 N SDCONLET,SDCONTACT,SDEARLI,SDLET
 S SDCONSID=""
 F  S SDCONSID=$O(^GMR(123,"F",DFN,SDCONSID)) Q:SDCONSID=""  D
 .S CPRSSTAT=$$GET1^DIQ(123,SDCONSID,8,"I")
 .S IFCSTAT=$$GET1^DIQ(123,SDCONSID,.125,"I")
 .I (IFCSTAT'="P")&((CPRSSTAT=ACTIVE)!(CPRSSTAT=PENDING)) D
 ..D ASSIGNINFO
 ..D BLDREC
 ;
 Q
 ;
ASSIGNINFO ;
 N SDCONSARR,SDARRERR,SDECALL,SDECLET
 D GETS^DIQ(123,SDCONSID,".01;.05;1;2;3;5;10;13;14;17","IE","SDCONSARR","SDARRERR")
 S SDORIGDT=$G(SDCONSARR(123,SDCONSID_",",.01,"I"))
 S SDTOSVC=$G(SDCONSARR(123,SDCONSID_",",1,"E"))
 S SDTOSVCI=$G(SDCONSARR(123,SDCONSID_",",1,"I"))
 S SDCLIEN=$G(SDCONSARR(123,SDCONSID_",",2,"I")) S:SDCLIEN="" SDCLIEN=$G(SDCONSARR(123,SDCONSID_",",.05,"I"))
 S SDCLNAME=$G(SDCONSARR(123,SDCONSID_",",2,"E")) S:SDCLNAME="" SDCLNAME=$G(SDCONSARR(123,SDCONSID_",",.05))
 S SDDOREQ=$G(SDCONSARR(123,SDCONSID_",",3,"I"))
 S SDREQTYPE=$G(SDCONSARR(123,SDCONSID_",",13,"E"))
 S SDPRIO=$$PRIO^SDEC51A(SDCONSID)
 S SDPRIEN=$G(SDCONSARR(123,SDCONSID_",",10,"I"))
 S SDPRNAME=$G(SDCONSARR(123,SDCONSID_",",10,"E"))
 S SDSRA=$G(SDCONSARR(123,SDCONSID_",",14,"E"))
 S SDEARLI=$G(SDCONSARR(123,SDCONSID_",",17,"I"))
 S SDSTOP="",STOP=""
 I +SDTOSVCI D
 .S SIEN=0 F  S SIEN=$O(^GMR(123.5,SDTOSVCI,688,SIEN)) Q:'+SIEN  D
 ..S STOP=$$GET1^DIQ(123.5688,SIEN_","_SDTOSVCI_",",.01,"I") ;ICR 4557
 ..I SDSTOP="" S SDSTOP=STOP
 ..E  S SDSTOP=SDSTOP_"|"_STOP
 S PRHBLOC=$S($$GET1^DIQ(44,+SDCLIEN_",",2500,"I")="Y":1,1:0)
 S SDCONLET=$$CALLCON^SDECAR1A(DFN,SDCONSID) ; SDECALL_U_SDECLET  # OF CALLS MADE^DATE LAST LETTER SENT
 S SDCONTACT=$P(SDCONLET,U,1)
 S SDLET=$P(SDCONLET,U,2)
 S COVPRIORITY=$$PRIORITY^SDEC51(SDCONSID) ; Get covid priority
 Q
 ; 
BLDREC ;build consult record
 ;
 ; Consult IEN^Request Type^ORIGDT^TO Service^CLINIEN^CLINNAME^Date of Request                                
 S SDTMP=SDCONSID_U_SDREQTYPE_U_SDORIGDT_U_SDTOSVC_U_SDCLIEN_U_SDCLNAME_U_SDDOREQ
 ; Prio^Provider IEN^Provider Name^Service Rendered As
 S SDTMP=SDTMP_U_SDPRIO_U_SDPRIEN_U_SDPRNAME_U_SDSRA
 ; Req_Proc_Act^Stop^PRHBLOC^Earliest
 S SDTMP=SDTMP_U_SDSTOP_U_PRHBLOC_U_SDEARLI
 ; CPHONE^CLET^Covid_Priority
 S SDTMP=SDTMP_U_SDCONTACT_U_SDLET_U_COVPRIORITY
 S SDECI=SDECI+1 S ^TMP("SDEC51B",$J,SDECI)=SDTMP_$C(30)
 Q
 ;
EXIT ;
 I SDECI=0 D
 . S SDECI=SDECI+1
 . S ^TMP("SDEC51B",$J,SDECI)=0_$C(30)
 S ^TMP("SDEC51B",$J,SDECI)=^TMP("SDEC51B",$J,SDECI)_$C(31)
 Q
 ;
CONSULT1(SDECY,SDCONSID) ; RPC: SDEC GET PAT CONSULT BY IEN - Return a CONSULT
 ;INPUT - SDCONSID (Consult ID) IEN to REQUEST/CONSULTATION (#123) File. 
 ;RETURN PARAMETER:
 ; Consults in ACTIVE or PENDING CPRS STATUS. Data is delimited by carat (^). 
 ; Field List:
 ; (1)     Internal IEN 
 ; (2)     Request Type
 ; (3)     File Entry Date
 ; (4)     To Service/Specialty
 ; (5)     Clinic IEN
 ; (6)     Clinic Name
 ; (7)     Date of Request
 ; (8)     URGENCY name or Earliest date
 ; (9)     Provider IEN
 ; (10)    Provider Name
 ; (11)    Service Rendered as in or outpatient
 ; (12)    Associated Stop Code
 ; (13)    Prohibited Clinic Flag
 ; (14)    Clinic indicated Date
 ; (15)    # of Phone contacts
 ; (16)    Date of Last Letter
 ; (17)    Covid Priority
 ;
 N DFN,ACTIVE,PENDING,ERRPOP,ERRMSG,SDECI,SDTMP,COVPRIORITY,PRHBLOC,SDCLIEN
 N SDCLNAME,SDCONLET,SDCONSARR,SDCONTACT,SDDOREQ,SDEARLI,SDECALL,SDECI
 N SDECLET,SDLET,SDORIGDT,SDPRIEN,SDPRIO,SDPRNAME,SDREQTYPE,SDSRA,SDSTOP,SDTMP
 N SDTOSVCI,SIEN,STOP,SDTOSVC
 D INIT
 D VALIDATE1
 I ERRPOP D ERR1^SDECERR(-1,ERRMSG,.SDECI,SDECY) Q
 S DFN=$$GET1^DIQ(123,SDCONSID,.02,"I")
 D ASSIGNINFO
 D BLDREC
 D EXIT
 Q
 ;
VALIDATE1 ;
 ;*Add validation of DFN
 I '(+SDCONSID) D  Q
 .;create error message - Consultation ID is required
 .S ERRMSG="Consultation ID is required."
 .S ERRPOP=1
 I '$D(^GMR(123,SDCONSID,0)) D
 .;create error - Invalid Consult ID
 .S ERRMSG="Invalid Consult ID."
 .S ERRPOP=1
 Q

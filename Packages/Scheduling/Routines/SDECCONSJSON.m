SDECCONSJSON ;ALB/ANU,MGD,LAB - VISTA SCHEDULING RPCS ;MAR 31, 2022@14:39
 ;;5.3;Scheduling;**784,785,788,805,807,813**;Aug 13, 1993;Build 6
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to ^GMR(123    In ICR #4837
 ;Reference to ^GMR(123.5  In ICR #4557
 ;Reference to ^GMR(123    In ICR #6185
 ;Reference to ^ORD(100.01 In ICR #2638
 ;Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056  
 Q
 ;
JSONCONSLIST(SDCONJSON,DFN) ;Return a list of ACTIVE or PENDING CONSULTS for patient
 ;INPUT - DFN (Date File Number) Pointer to PATIENT (#2) File. 
 ;RETURN PARMETER:
 ; List of consults in ACTIVE or PENDING CPRS STATUS.  Data is delimited by carat (^). 
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
 ; Number of Email Contacts
 ; Number of Text Contacts
 ; Number of Secure messages contact
 ;
 N ACTIVE,PENDING,ERRPOP,ERRMSG,SDECI,SDTMP,SDCONSREC,ERR
 S SDECI=$G(SDECI,0),ERR=""
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D JSONSELCONS ;select "open" consults
 Q
 ;
INIT ; initialize values needed
 S ACTIVE=$O(^ORD(100.01,"B","ACTIVE",0))
 S PENDING=$O(^ORD(100.01,"B","PENDING",0))
 S ERRPOP=0,SDECI=0,ERRMSG=""
 Q
 ; 
VALIDATE ; validate incoming parameters
 ;*Add validation of DFN
 I '(+DFN) D
 . ;create error message - DFN required
 . D ERRLOG^SDESJSON(.SDCONSREC,1)
 . S ERRPOP=1
 I $G(DFN)>0,'$D(^DPT(DFN,0)) D
 . ;create error - Invalid DFN
 . D ERRLOG^SDESJSON(.SDCONSREC,2)
 . S ERRPOP=1
 Q
 ;
JSONSELCONS ;selection all open consults - those consults in PENDING and ACTIVE status
 N SDCONSID,CPRSSTAT,IFCSTAT,CPRSSTAT
 S SDCONSID=""
 F  S SDCONSID=$O(^GMR(123,"F",DFN,SDCONSID)) Q:SDCONSID=""  D
 .S CPRSSTAT=$$GET1^DIQ(123,SDCONSID,8,"I")
 .S IFCSTAT=$$GET1^DIQ(123,SDCONSID,.125,"I")
 .I (IFCSTAT'="P")&((CPRSSTAT=ACTIVE)!(CPRSSTAT=PENDING)) D
 ..D BLDCONSULTREC
 I '$D(SDCONSREC("Consult")) S SDCONSREC("Consult")=""
 D BLDJSON
 K SDCONSARR
 Q
 ;
BLDCONSULTREC ;Build a consult record for every consult
 N SDCLIEN,SDCLNAME,SDCONLET,SDSTOP,STOP,SIEN,SDTOSVCI,SDCONSARR,SDARRERR,CANCHANGEPID,PID
 D GETS^DIQ(123,SDCONSID,".01;.05;1;2;3;5;10;13;14;17","IE","SDCONSARR","SDARRERR")
 S SDECI=SDECI+1
 S SDCONSREC("Consult",SDECI,"ConsultIEN")=SDCONSID
 S SDCONSREC("Consult",SDECI,"RequestType")=$G(SDCONSARR(123,SDCONSID_",",13,"E"))
 S SDCONSREC("Consult",SDECI,"FileEntryDate")=$G(SDCONSARR(123,SDCONSID_",",.01,"I"))
 S SDCONSREC("Consult",SDECI,"ToService")=$G(SDCONSARR(123,SDCONSID_",",1,"E"))
 ;Need explanation of why for clinic ien and name
 S SDCLIEN=$G(SDCONSARR(123,SDCONSID_",",2,"I")) S:SDCLIEN="" SDCLIEN=$G(SDCONSARR(123,SDCONSID_",",.05,"I"))
 S SDCLNAME=$G(SDCONSARR(123,SDCONSID_",",2,"E")) S:SDCLNAME="" SDCLNAME=$G(SDCONSARR(123,SDCONSID_",",.05))
 S SDCONSREC("Consult",SDECI,"ClinicIEN")=SDCLIEN
 S SDCONSREC("Consult",SDECI,"ClinicName")=SDCLNAME
 S SDCONSREC("Consult",SDECI,"DateOfRequest")=$G(SDCONSARR(123,SDCONSID_",",3,"I"))
 S SDCONSREC("Consult",SDECI,"UrgencyOrEarliestDate")=$$PRIO^SDEC51A(SDCONSID)
 S SDCONSREC("Consult",SDECI,"ProviderIEN")=$G(SDCONSARR(123,SDCONSID_",",10,"I"))
 S SDCONSREC("Consult",SDECI,"ProviderName")=$G(SDCONSARR(123,SDCONSID_",",10,"E"))
 S SDCONSREC("Consult",SDECI,"ServiceRenderedAs")=$G(SDCONSARR(123,SDCONSID_",",14,"E"))
 S SDCONSREC("Consult",SDECI,"ProhibitedClinicFlag")=$S($$GET1^DIQ(44,+SDCLIEN_",",2500,"I")="Y":1,1:0)
 I $D(^SDEC(409.87,"B",SDCONSID)) D
 .S PID=$$GETPID(SDCONSID)
 .S SDCONSREC("Consult",SDECI,"ClinicIndicatedDate")=PID
 I '$D(^SDEC(409.87,"B",SDCONSID)) D
 .S SDCONSREC("Consult",SDECI,"ClinicIndicatedDate")=$G(SDCONSARR(123,SDCONSID_",",17,"I"))
 S SDCONLET=$$CALLCON^SDECAR1A(DFN,SDCONSID) ; # OF CALLS MADE^DATE LAST LETTER SENT
 K SDECALL,SDECLET ; Returned from call to $$CALLCON^SDECAR1A
 S SDCONSREC("Consult",SDECI,"NumberOfPhoneContact")=$P(SDCONLET,U,1)
 S SDCONSREC("Consult",SDECI,"DateOfLastLetter")=$P(SDCONLET,U,2)
 S SDCONSREC("Consult",SDECI,"NumberOfEmailContact")=$P(SDCONLET,U,3) ;813
 S SDCONSREC("Consult",SDECI,"NumberOfTextContact")=$P(SDCONLET,U,4) ;813
 S SDCONSREC("Consult",SDECI,"NumberOfSecureMessage")=$P(SDCONLET,U,5) ;813
 S SDCONSREC("Consult",SDECI,"CovidPriority")=$$PRIORITY^SDEC51(SDCONSID) ; Get Covid priority
 S CANCHANGEPID=$$CONSCANCELCHECK(SDCONSID,DFN)
 S SDCONSREC("Consult",SDECI,"CanEditPid")=CANCHANGEPID
 ;build stop code list
 S SDSTOP="",STOP=""
 S SDTOSVCI=$G(SDCONSARR(123,SDCONSID_",",1,"I"))
 I +SDTOSVCI D
 .S SIEN=0 F  S SIEN=$O(^GMR(123.5,SDTOSVCI,688,SIEN)) Q:'+SIEN  D
 ..S STOP=$$GET1^DIQ(123.5688,SIEN_","_SDTOSVCI_",",.01,"I") ;ICR 4557
 ..I SDSTOP="" S SDSTOP=STOP
 ..E  S SDSTOP=SDSTOP_"|"_STOP
 S SDCONSREC("Consult",SDECI,"AssociateStopCode")=SDSTOP
 Q
 ;
GETPID(SDCONSID) ;
 N CHIEN,CHSIEN,OLDESTPID
 S CHIEN=$O(^SDEC(409.87,"B",SDCONSID,0))
 S CHSIEN=$O(^SDEC(409.87,CHIEN,1,9999999),-1)
 S OLDESTPID=$$GET1^DIQ(409.871,CHSIEN_","_CHIEN_",",1,"I")
 Q OLDESTPID
CONSCANCELCHECK(SDCONSID,DFN) ;looking for most recent appt linked to this consult and checking if cancelled by patient or clinic
 N FOUND,APPTIEN,CANCHANGE
 S APPTIEN="",FOUND=0,CANCHANGE=0
 F  S APPTIEN=$O(^SDEC(409.84,"CPAT",DFN,APPTIEN),-1) Q:'APPTIEN!(FOUND=1)  D
 .I $P($$GET1^DIQ(409.84,APPTIEN,.22,"I"),";")=SDCONSID S FOUND=1 D
 ..I $$GET1^DIQ(409.84,APPTIEN,.17,"I")="PC" S CANCHANGE=1
 ..I $$GET1^DIQ(409.84,APPTIEN,.1,"I")=1 S CANCHANGE=1
 Q CANCHANGE
BLDJSON ;
 D ENCODE^SDESJSON(.SDCONSREC,.SDCONJSON,.ERR)
 K SDCONSREC
 Q
 ;
JSONCONSLIST1(SDCONJSON,SDCONSID) ;Return a single ACTIVE or PENDING CONSULT for a patient
 ;INPUT - SDCONSID (Consult ID) IEN to REQUEST/CONSULTATION (#123) File.
 ;RETURN PARMETER:
 ; List of consults in ACTIVE or PENDING CPRS STATUS.  Data is delimited by carat (^). 
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
 ; Number of Email Contacts
 ; Number of Text Contacts
 ; Number of Secure messages contact
 ;
 N ACTIVE,PENDING,ERRPOP,ERRMSG,SDECI,SDTMP,SDCONSREC,DFN,ERR
 S SDECI=$G(SDECI,0),ERR=""
 D INIT
 D VALIDATE1
 I ERRPOP D BLDJSON Q
 S DFN=$$GET1^DIQ(123,SDCONSID,.02,"I")
 D BLDCONSULTREC
 D BLDJSON
 K SDCONSARR
 Q
 ;
VALIDATE1 ;
 ; *Add validation of IEN
 I '(+SDCONSID) D
 . ; create error message - Consultation ID is required
 . D ERRLOG^SDESJSON(.SDCONSREC,5)
 . S ERRPOP=1
 I $G(SDCONSID)>0,'$D(^GMR(123,SDCONSID,0)) D
 . ; create error - Invalid Consult ID
 . D ERRLOG^SDESJSON(.SDCONSREC,6)
 . S ERRPOP=1
 Q

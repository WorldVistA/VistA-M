SDES2GETMEDLIST ;ALB/JAS,JAS,JHC - SDES2 GET PATIENT'S MEDICATIONS LIST ;  02 March 2025
 ;;5.3;Scheduling;**853,861,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 Q
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to LIST^ORQQPS supported by ICR #1659
 ;
 ;
 ; RPC: SDES2 GET PATIENT MED LIST
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = 36 character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ")         = The DUZ of the user taking action on the calling application.
 ; SDCONTEXT("USER SECID")       = The SECID of the user taking action on the calling application.
 ; SDCONTEXT("PATIENT DFN")      = The DFN of the Veteran/user taking action on the calling application.
 ; SDCONTEXT("PATIENT ICN")      = The ICN of the Veteran/user taking action on the calling application.
 ;
 ; PARAMS("DFN")                 = The DFN of the patient for Med List retrieval
 ; PARAMS("START DATE")          = Start Date in ISO format (Optional - defaults to TODAY)
 ; PARAMS("END DATE")            = End Date in ISO format (Optional - defaults to 9999999)
 ;
GETMEDLIST(JSONRETURN,SDCONTEXT,PARAMS) ; Get Patient's Medications List
 ;
 N DTRANGE,SDDFN,SDERRORS,SDENDDT,SDSTRTDT,SDRETURN
 ;
 ; Validate SDCONTEXT
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Medication",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 ; Validate PARAMS
 ;
 S DTRANGE=$$VALPARAMS(.PARAMS,.SDERRORS)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Medication",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 S SDSTRTDT=$P(DTRANGE,"^"),SDENDDT=$P(DTRANGE,"^",2)
 ;
 ; Retrieve Patient's Medications List
 ;
 S SDDFN=PARAMS("DFN")
 D MEDLIST(.SDRETURN,SDDFN,SDSTRTDT,SDENDDT)
 ;
 ; Build JSON return
 ;
 I '$D(SDRETURN) S SDRETURN("Medication",1)=""
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
VALPARAMS(PARAMS,SDERRORS) ; Validate and Process DFNs
 ;
 ; Validate DFN
 ;
 N VALRET
 D VALFILEIEN^SDES2VALUTIL(.VALRET,.SDERRORS,2,$G(PARAMS("DFN")),1,0,1,2)
 I 'VALRET,$D(SDERRORS) Q 0
 ;
 ; Validate Start/End Dates
 ;
 N STRTDTISO,ENDDTISO,STRTDT,ENDDT,FMDATES
 ; Get the start and end date. Strip off time because we do not need it.
 S STRTDTISO=$P($G(PARAMS("START DATE")),"T")
 S ENDDTISO=$P($G(PARAMS("END DATE")),"T")
 ; Start date passed, but no end date - validate start date alone
 I STRTDTISO'="",(ENDDTISO="") S FMDATES=$$VALISODTTM^SDES2VALISODTTM(.SDERRORS,STRTDTISO,,,498,499)
 ; Start date is not passed, but end date is passed
 I STRTDTISO="",(ENDDTISO'="") S $P(FMDATES,U,2)=$$VALISODTTM^SDES2VALISODTTM(.SDERRORS,ENDDTISO,,,501,502)
 ; Both dates are passed in, validate the range
 I STRTDTISO'="",(ENDDTISO'="") S FMDATES=$$VALISODATERANGE^SDES2VALISODTTM(.SDERRORS,STRTDTISO,ENDDTISO)
 Q:$D(SDERRORS) 0
 ;
 I $G(FMDATES)'="" S STRTDT=$P($G(FMDATES),U),ENDDT=$P($G(FMDATES),U,2)
 I '$G(STRTDT) S STRTDT=DT
 I '$G(ENDDT) S ENDDT=9999999
 I ENDDT<STRTDT D ERRLOG^SDES2JSON(.SDERRORS,13)
 Q STRTDT_"^"_ENDDT
 ;
MEDLIST(SDRETURN,SDDFN,SDSTRTDT,SDENDDT) ;
 N MEDDATA,SDCOUNT,SDRESULT
 ;
 ; Call ORQQPS LIST
 ;
 D LIST^ORQQPS(.SDRESULT,SDDFN,SDSTRTDT,SDENDDT)
 ; id^nameform^stop date^route^schedule/infusion rate^refills remaining
 Q:'$D(SDRESULT)
 ;
 ; Patient's medication information
 ;
 S SDCOUNT=0
 F  S SDCOUNT=$O(SDRESULT(SDCOUNT)) Q:'SDCOUNT  I $D(SDRESULT(SDCOUNT)) D
 . S MEDDATA=SDRESULT(SDCOUNT)
 . ;
 . ; Set med data fields for return
 . ;
 . S SDRETURN("Medication",SDCOUNT,"MedicationID")=$P(SDRESULT(SDCOUNT),"^")
 . S SDRETURN("Medication",SDCOUNT,"MedicationName")=$P(SDRESULT(SDCOUNT),"^",2)
 . S SDRETURN("Medication",SDCOUNT,"StopDate")=$$FMTISO^SDAMUTDT($P(SDRESULT(SDCOUNT),"^",3))
 . S SDRETURN("Medication",SDCOUNT,"Route")=$P(SDRESULT(SDCOUNT),"^",4)
 . S SDRETURN("Medication",SDCOUNT,"ScheduleInfusionRate")=$P(SDRESULT(SDCOUNT),"^",5)
 . S SDRETURN("Medication",SDCOUNT,"RefillsRemaining")=$P(SDRESULT(SDCOUNT),"^",6)
 ;
 K DRG,LSTDS,LSTFD,LSTRD  ; Kill variables leaking from LIST^ORQQPS
 Q

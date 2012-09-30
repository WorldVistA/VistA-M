BPSNCPD9 ;ALB/DMB - Eligibility Verification Entry Point ;09/21/2010
 ;;1.0;E CLAIMS MGMT ENGINE;**10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; Main entry point for eligibility verification claims
 ; Input Parameters:
 ;   DFN - Patient
 ;   BPSARRY - Array of values
 ;      "PLAN"        - IEN to the GROUP INSURANCE PLAN (#355.3) file 
 ;      "DOS"         - Date of Service
 ;      "IEN"         - Prescription IEN
 ;      "FILL NUMBER" - Fill Number
 ;      "REL CODE"    - Relationship Code
 ;      "PERSON CODE" - Person Code
 ; Output
 ;   RESULT
 ;       Piece 1 - 0: Not submitted or 1: Submitted
 ;       Piece 2 - Message   
 ;
EN(DFN,BPSARRY) ;
 ; Validate Incoming Parameters
 I '$G(DFN) Q "0^Invalid Patient IEN"
 I '$G(BPSARRY("PLAN")) Q "0^Invalid Plan"
 I '$G(BPSARRY("DOS")) Q "0^Invalid Date of Service"
 S BPSARRY("IEN")=$G(BPSARRY("IEN"))
 S BPSARRY("FILL NUMBER")=$G(BPSARRY("FILL NUMBER"))
 S BPSARRY("REL CODE")=$G(BPSARRY("REL CODE"))
 S BPSARRY("PERSON CODE")=$G(BPSARRY("PERSON CODE"))
 ;
 N PHARM,SITE,ERR,MOREDATA,IEN59,RXACT,POLICY,RETV,NEWREQ,IB
 N PREVREQ,REQLIST,MSG,CERTIEN
 S ERR=""
 ;
 ; Get division
 ; If there is an RX/Fill, get the division from the Rx
 I BPSARRY("IEN"),BPSARRY("FILL NUMBER")]"" D  I 'SITE Q 0_U_"The RX is missing the Division"
 . S SITE=$$GETSITE^BPSOSRX8(BPSARRY("IEN"),BPSARRY("FILL NUMBER"))
 ;
 ; If no RX/Fill, get the default pharmacy from the ECME SETUP file and then 
 ;   the associated division
 I 'BPSARRY("IEN")!(BPSARRY("FILL NUMBER")="") D  I ERR]"" Q 0_U_ERR
 . S PHARM=$$GET1^DIQ(9002313.99,1,.08,"I")
 . I 'PHARM S ERR="Default Pharmacy not defined in ECME Setup" Q
 . I '$$BPSACTV^BPSUTIL(PHARM) S ERR="Default Pharmacy not active" Q
 . S SITE=$O(^BPS(9002313.56,PHARM,"OPSITE",0))
 . I 'SITE S ERR="No division associated with the default Pharmacy" Q
 . S SITE=$P($G(^BPS(9002313.56,PHARM,"OPSITE",SITE,0)),U,1)
 . I 'SITE S ERR="No division associated with the default Pharmacy" Q
 ;
 ; Check that the division is active
 I '$$ECMEON^BPSUTIL(SITE) Q 0_U_"ECME switch is not on for the site"
 ;
 ; Call billing determination
 K MOREDATA
 S RXACT="ELIG"
 D BASICMOR^BPSOSRX8(RXACT,BPSARRY("DOS"),SITE,"","","","","","",.MOREDATA)
 S BPSARRY("DFN")=DFN
 S BPSARRY("EPHARM")=$$GETPHARM^BPSUTIL(SITE)
 S BPSARRY("USER")=DUZ
 S BPSARRY("RX ACTION")=RXACT
 S BPSARRY("DIVISION")=SITE
 I +$$CERTTEST^BPSNCPD4(.CERTIEN)=1 Q 0_U_"Certification question not answered"
 D EN^BPSNCPD2(DFN,RXACT,.MOREDATA,.BPSARRY,.IB)
 I +MOREDATA("BILL")'=1 Q 0_U_"Not submittable: "_$P(MOREDATA("BILL"),U,2)
 I '$P($G(MOREDATA("IBDATA",1,3)),U,7) Q 0_U_"Not submittable: No Policy Information returned"
 ;
 ; Create the IEN for the BPS Transaction record and initialize the log
 S POLICY=9000+$P($G(MOREDATA("IBDATA",1,3)),U,7)
 S IEN59=$$IEN59^BPSOSRX(DFN,POLICY,1)
 D LOG^BPSOSL(IEN59,$T(+0)_"-Start of eligibility verification","DT")
 ;
 ; If override flag is set, prompt for override values - TEST ONLY
 I $$CHECK^BPSTEST D GETOVER^BPSTEST(DFN,POLICY,"",RXACT,"E",1) W !
 ;
 ; If there is a person code or relationship code, create the Override record for the Person Code and Relationship code
 ; Quit if error occurs
 S ERR=""
 I BPSARRY("REL CODE")!BPSARRY("PERSON CODE") D  I ERR]"" Q ERR
 . N BPFLD,BPOVRIEN,BPFDA,BPSMSG
 . S BPFDA(9002313.511,"+1,",.01)=IEN59
 . S BPFDA(9002313.511,"+1,",.02)=$$NOW^BPSOSRX()
 . S BPFLD=$O(^BPSF(9002313.91,"B",303,"")) I BPFLD]"" S BPFDA(9002313.5111,"+2,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+2,+1,",.02)=BPSARRY("PERSON CODE")
 . S BPFLD=$O(^BPSF(9002313.91,"B",306,"")) I BPFLD]"" S BPFDA(9002313.5111,"+3,+1,",.01)=BPFLD,BPFDA(9002313.5111,"+3,+1,",.02)=BPSARRY("REL CODE")
 . D UPDATE^DIE("","BPFDA","BPOVRIEN","BPSMSG")
 . I $D(BPSMSG("DIERR"))!($G(BPOVRIEN(1))="") D  Q
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-Override Record could not be created")
 .. D LOG^BPSOSL(IEN59,"BPOVRIEN Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"BPOVRIEN")
 .. D LOG^BPSOSL(IEN59,"BPSMSG Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"BPSMSG")
 .. S ERR=0_U_"Could Not Save Person Code or Relationship Code"
 . S MOREDATA("BPOVRIEN")=BPOVRIEN(1)
 ;
 ; Call CHKREQST^BPSOSRX7 to see if there are other requests on the queue. 
 ; If the return value is negative, quit with error.
 S PREVREQ=$$CHKREQST^BPSOSRX7(DFN,POLICY,.REQLIST)
 I PREVREQ<-1 D  Q 0_U_"There was a queueing issue and the request could not be submitted"
 . D LOG^BPSOSL(IEN59,$T(+0)_"-CHKREQST~BPSOSRX7 returned an error: "_PREVREQ_". Request not submitted.")
 ;
 ; Create the request
 S RETV=$$REQST^BPSOSRX("E",DFN,POLICY,.MOREDATA,1,IEN59)
 S NEWREQ=+$P(RETV,U,2)
 ;
 ; If error, log error and quit
 I +RETV=0 D  Q 0_U_ERR
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Create request error: "_RETV_". Request Will Not Be submitted.")
 . S ERR="Eligibility Request not created - "_$P(RETV,U,2)
 ;
 ; Update log with successful request
 D LOG^BPSOSL(IEN59,$T(+0)_"-BPS REQUEST "_NEWREQ_" has been created")
 ;
 ; The rest of processing is based on the return value of the call to CHKREQST above.
 ; If positive, need to link the current request to the previous request on the queue.
 ; Check the result of trying to link the requests
 I PREVREQ>1 D  Q +RETV_U_MSG
 . S RETV=$$NXTREQST^BPSOSRX6(PREVREQ,NEWREQ)
 . ; If 1 is  returned, all is good, log message and quit
 . I +RETV=1 D  Q
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-Request "_NEWREQ_" linked to "_PREVREQ)
 .. S MSG="Request submitted but will not be processed until previous request finishes"
 . ;
 . ; If we got here, we were not able to link the request
 . D LOG^BPSOSL(IEN59,$T(+0)_"-NXTREQST~BPSOSRX6 returned an error: "_RETV_". Request not submitted.")
 . S MSG="There was a queueing issue and the request could not be created"
 ;
 ; If we got to here, CHKREQST returned 0 so we need to activate the request
 S RETV=$$ACTIVATE^BPSNCPD4(NEWREQ,"E")
 ;
 ; If error, log error and quit
 I RETV'=0 D  Q 0_U_ERR
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Activation error: "_RETV_". Request Will Not Be submitted.")
 . S ERR="Eligibility Request not submitted - "_$P(RETV,U,2)
 ;
 ; Log activation
 D LOG^BPSOSL(IEN59,$T(+0)_"-BPS REQUEST: "_NEWREQ_" has been activated")
 ;
 ; Start filer to process queue requests
 D LOG^BPSOSL(IEN59,$T(+0)_"-Start RUNNING^BPSOSRX")
 D RUNNING^BPSOSRX()
 ;
 Q 1_U_"Request successfully submitted to ECME"
 ;

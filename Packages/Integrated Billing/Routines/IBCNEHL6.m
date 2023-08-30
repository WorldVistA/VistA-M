IBCNEHL6 ;EDE/DM - HL7 Process Incoming RPI Continued ; 19-OCT-2017
 ;;2.0;INTEGRATED BILLING;**601,621,737,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
FIL ; Finish processing the response message - file into insurance buffer
 ;
 ; Input Variables
 ; ERACT, ERFLG, ERROR, IIVSTAT, MAP, RIEN, TRACE, TRKIEN
 ;
 ; If no record IEN, quit
 I $G(RIEN)="" Q
 ;
 N BUFF,CALLEDBY,DFN,FILEIT,IBEICDV,IBFDA,IBIEN,IBINSDTA,IBISMBI,IBQFL
 N RDAT0,RSRVDT,RSTYPE,SYMBOL,TQDATA,TQN,TQSRVDT,TRKDTA
 ; Initialize variables from the Response File
 S RDAT0=$G(^IBCN(365,RIEN,0)),TQN=$P(RDAT0,U,5)
 S TQDATA=$G(^IBCN(365.1,TQN,0))
 S IBQFL=$P(TQDATA,U,11)
 S DFN=$P(RDAT0,U,2),BUFF=$P(RDAT0,U,4)
 S IBISMBI=+$$MBICHK^IBCNEUT7(BUFF) ; IB*2*601/DM
 S IBEICDV=((IBQFL="V")&($P(TQDATA,U,10)="4")) ; IB*2.0*621/DM
 S IBIEN=$P(TQDATA,U,5),RSTYPE=$P(RDAT0,U,10)
 S RSRVDT=$P($G(^IBCN(365,RIEN,1)),U,10)
 ;
 ; If an unknown error action or an error filing the response message,
 ; send a warning email message
 ; Note - A call to UEACT will always set ERFLAG=1
 ;
 ; IB*2.0*506 Removed the following line of code to Treat all AAA Action Codes
 ; as though the Payer/FSC Responded.
 ;I ",W,X,R,P,C,N,Y,S,"'[(","_$G(ERACT)_",")&($G(ERACT)'="")!$D(ERROR) D UEACT^IBCNEHL3
 ;
 ; If an error occurred, processing complete
 I $G(ERFLG)=1 Q
 ;
 ;  For an original response, set the Transmission Queue Status to 'Response Received' &
 ;  update remaining retries to comm failure (5)
 ;IB*743/CKB - called earlier when saving the MSA segment 
 ;I $G(RSTYPE)="O" D SST^IBCNEUT2(TQN,3),RSTA^IBCNEUT7(TQN)
 ;
 ; Update the TQ service date to the date in the response file
 ; if they are different AND the Error Action <>
 ; 'P' for 'Please submit original transaction'
 ;
 ; *** Temporary change to suppress update of service & freshness dates.
 ; *** To reinstate, remove comment (;) from next line.
 ;I TQN'="",$G(RSTYPE)="O" D
 ;. S TQSRVDT=$P($G(^IBCN(365.1,TQN,0)),U,12)
 ;. I RSRVDT'="",TQSRVDT'=RSRVDT,$G(ERACT)'="P" D SAVETQ^IBCNEUT2(TQN,RSRVDT)
 ;. ; update freshness date by same delta
 ;. D SAVFRSH^IBCNEUT5(TQN,+$$FMDIFF^XLFDT(RSRVDT,TQSRVDT,1))
 ;
 ;  Check for error action
 ; IB*2*601/DM, IB*2.0*621/DM  If the response is MBI or EICD verification, keep processing after error
 I $G(ERACT)'=""!($G(ERTXT)'="") D  G:('IBISMBI)&('IBEICDV) FILX
 . S ERACT=$$ERRACT^IBCNEHLU(RIEN),ERCON=$P(ERACT,U,2),ERACT=$P(ERACT,U)
 . D ERROR^IBCNEHL3(TQN,ERACT,ERCON,TRACE)
 . I IBEICDV S BUFF=$P($G(^IBCN(365,RIEN,0)),U,4) ;IB*2.0*621/DM reset BUFF
 ;
 I EVENTYP=1 D PROCTRK^IBCNEHL7(TRKIEN) Q  ;IB*621  Process EICD Tracking file #365.18
 ;
 ; Stop processing if identification response and not an active policy
 S FILEIT=1
 I $G(IIVSTAT)=6,TQN]"" D
 . I TQDATA="" Q
 . I IBQFL'="I" Q
 . S FILEIT=0
 I 'FILEIT G FILX
 ;
 ; -
 ; ** Very important:  Variable 'CALLEDBY' must be set for this routine so
 ;    that when a payer response is saved to the buffer either as an
 ;    update to an existing buffer entry or as a new buffer entry a new
 ;    eIV inquiry is not automatically triggered and resent to the payer again.
 ;    When certain fields are changed in file #355.33 a trigger calls routine
 ;    ^IBCNERTQ which can create and send a new inquiry in real time to the payer.
 ;    We want this to occur in all cases _EXCEPT_ when it is a payer response.
 ;    Which means _EXCEPT_ when it is triggered as a result of this routine.
 ;
 S CALLEDBY="IBCNEHL1"
 ;
 ;  If there is an associated buffer entry & one or both of the following
 ;  is true, stop filing (don't update buffer entry)
 ;  1) buffer status is not 'Entered'
 ;  2) the buffer entry is verified (* symbol)  ;IB*737/DTG stop use of '*' verified
 ;I BUFF'="",($P($G(^IBA(355.33,BUFF,0)),U,4)'="E")!($$SYMBOL^IBCNBLL(BUFF)="*") G FILX
 I BUFF'="",($P($G(^IBA(355.33,BUFF,0)),U,4)'="E") G FILX  ;IB*737/DTG stop use of '*' verified
 ;
 ; Set buffer symbol based on value returned from EC
 ; IB*2*601/DM
 ;S SYMBOL=MAP(IIVSTAT)
 I 'IBISMBI S SYMBOL=MAP(IIVSTAT)
 ; if subscriber ID is populated set SYMBOL to '%' otherwise a '#'
 I IBISMBI S SYMBOL=$S($$GET1^DIQ(365,RIEN_",","SUBSCRIBER ID")'="":MAP("MBI%"),1:MAP("MBI#"))
 ;
 ;  If there is an associated buffer entry, update the buffer entry w/
 ;  response data
  ;IB*743/CKB - add the locking of the Buffer
 ;I BUFF'="" D RP^IBCNEBF(RIEN,"",BUFF)
 N BUFDONE,BUFLOCK,BUFSTAT
 S (BUFDONE,BUFLOCK)=0  ; BUFDONE indicates that a user processed the entry already 
 I BUFF'="" D
 . ;If STATUS (#355.33,.04) is NOT ENTERED, ABORT - DON'T touch the buffer entry
 . ; (#355.33), and continue normal processing
 . I $$GET1^DIQ(355.33,BUFF_",",.04,"I")'="E" S BUFDONE=1 Q
 . ;BUFSTAT is ENTERED, attempt to Lock buffer entry
 . S BUFLOCK=$$BUFLOCK(BUFF,1)
 . ;Lock acquired
 . I BUFLOCK D  Q
 . . ;Re-evaluate STATUS (#355.33,.04)
 . . S BUFSTAT=$$GET1^DIQ(355.33,BUFF_",",.04,"I")
 . . ;If BUFSTAT is NOT ENTERED, DO NOT modify or touch the buffer entry (#355.33),
 . . ; release lock , and continue normal processing
 . . I BUFSTAT'="E" S BUFDONE=1 Q
 . . ;If BUFSTAT is ENTERED, continue normal processing (modify buffer entry), release lock
 . . I BUFSTAT="E" D RP^IBCNEBF(RIEN,"",BUFF)
 . . ;Unlock buffer
 . . N XX S XX=$$BUFLOCK(BUFF,0)
 . ;
 . ;Lock NOT acquired
 . ;DON'T reevaluate BUFLOCK after calling $$BUFLOCK(BUFF,0)
 . I 'BUFLOCK D
 . . ;Re-evaluate STATUS (#355.33,.04)
 . . S BUFSTAT=$$GET1^DIQ(355.33,BUFF_",",.04,"I")
 . . ;If BUFSTAT is NOT ENTERED, DO NOT modify or touch the buffer entry (#355.33), and
 . . ; continue normal processing
 . . I BUFSTAT'="E" S BUFDONE=1 Q
 . . ;If BUFSTAT is ENTERED, do tag UPDBUF
 . . D UPDBUF(BUFF,SYMBOL)
 I BUFF'="",'BUFLOCK G FILX
 I $G(BUFDONE)=1 G FILX
 ;
 ;  If no associated buffer entry, create one & populate w/ response
 ;  data (routine call sets IBFDA)
 ;IB/743 CKB - the locking of the buffer is done in $$ADDSTF^IBCNEBF
 I BUFF="" D RP^IBCNEBF(RIEN,1) S BUFF=+IBFDA,UP(365,RIEN_",",.04)=BUFF
 ;
 ; IB*2*601/DM for an MBI query, set the patient relationship to insured to "Patient"
 I IBISMBI S UP(355.33,BUFF_",",60.06)="01"
 ;
 ; IB*2*621/DM for EICD verification response with errors, populate PATID, GRPNUM and SUBID in buffer
 I ($G(ERTXT)'=""),IBEICDV D
 . N TRKIEN
 . S TRKIEN=$O(^IBCN(365.18,"C",TQN,""))
 . S TRKDTA=$P(TQDATA,U,21)_","_TRKIEN_","
 . K IBINSDTA D GETS^DIQ(365.185,TRKDTA,".03;.04;.05",,"IBINSDTA") ; grab selected fields (external) 
 . S UP(355.33,BUFF_",",62.01)=IBINSDTA(365.185,TRKDTA,.05) ; Member/Patient ID
 . S UP(355.33,BUFF_",",90.02)=IBINSDTA(365.185,TRKDTA,.03) ; Group Number
 . S UP(355.33,BUFF_",",90.03)=IBINSDTA(365.185,TRKDTA,.04) ; Subscriber ID
 ; Set eIV Processed Date to now
 S UP(355.33,BUFF_",",.15)=$$NOW^XLFDT()
 D FILE^DIE("I","UP","ERROR")
FILX ;
 Q
 ;
 ;IB*743/TAZ&CKB - Buffer Lock/Unlock Function
BUFLOCK(BUFF,ONOFF) ;Get a lock on the Buffer entry associated with this Response IEN
 ; Input:
 ;   BUFF    Buffer IEN file #355.33
 ;   ONOFF   0=unlock / 1=lock
 ; Output:
 ;   OK      0=Not successful / 1=Successful
 N CNT,OK
 S OK=0
 I BUFF="" G LOCKEND
 ;Unlock Buffer
 I 'ONOFF L -^IBA(355.33,BUFF) S OK=1 G LOCKEND
 ;Attempt to Lock for 30 minutes
 F CNT=1:1:30 D  G:OK LOCKEND
 . L +^IBA(355.33,BUFF):DILOCKTM I $T S OK=1 Q
 . H 55
LOCKEND ;
 Q OK
 ;
 ;IB*743/CKB & DJW    UPDBUF tag
UPDBUF(BUFF,SYMBOL) ; Update the IIV PROCESSED DATE (#355.33,.15) and update Buffer eIV Symbol based
 ; on the incoming Response.
 ;
 ; Per eBiz eInsurance 12/2022 - If there is a Buffer entry & the lock is NOT acquired, do the
 ;  following if the buffer status is ENTERED:  Set the eIV Processed Date so that the trace #
 ;  will display, the 'magic sentence' saying the service date and STC the response is based on 
 ;  is displayed, the eligibility benefit info associated with the response is displayed and 
 ;  available when accepting the buffer entry.  DO NOT set the other fields in the buffer such
 ;  as effective date, group #/name, etc on the buffer entry as eBiz wants to the buffer fields
 ;  set to the values that they were 1 second before the eIV response arrived back at the site.
 ; 
 ;  Therefore, only the eligiblity benefit data from the response will be available when and if
 ;    a user accepts the buffer entry and no other data from the response.  That is why we are
 ;    *NOT* calling RP^IBCNEBF here.  PATCH IB*743// DJW 
 ;
 N BUFERR,BUFUPD
 ; Set eIV Processed Date to Now
 S BUFUPD(355.33,BUFF_",",.15)=$$NOW^XLFDT()
 D FILE^DIE("I","BUFUPD","BUFERR")
 ;
 ; Update insurance buffer with the eIV symbol as returned by EC
 I SYMBOL D BUFF^IBCNEUT2(BUFF,SYMBOL)
 Q

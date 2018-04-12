IBCNEHL6 ;EDE/DM - HL7 Process Incoming RPI Continued ; 19-OCT-2017
 ;;2.0;INTEGRATED BILLING;**601**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
FIL ; Finish processing the response message - file into insurance buffer
 ;
 ; Input Variables
 ; ERACT, ERFLG, ERROR, IIVSTAT, MAP, RIEN, TRACE
 ;
 ; If no record IEN, quit
 I $G(RIEN)="" Q
 ;
 N BUFF,CALLEDBY,DFN,FILEIT,IBFDA,IBIEN,IBQFL,RDAT0,RSRVDT,RSTYPE,SYMBOL,TQDATA,TQN,TQSRVDT,IBISMBI
 ; Initialize variables from the Response File
 S RDAT0=$G(^IBCN(365,RIEN,0)),TQN=$P(RDAT0,U,5)
 S TQDATA=$G(^IBCN(365.1,TQN,0))
 S IBQFL=$P(TQDATA,U,11)
 S DFN=$P(RDAT0,U,2),BUFF=$P(RDAT0,U,4)
 S IBISMBI=+$$MBICHK^IBCNEUT7(BUFF) ; IB*2*601/DM
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
 I $G(RSTYPE)="O" D SST^IBCNEUT2(TQN,3),RSTA^IBCNEUT7(TQN)
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
 I $G(ERACT)'=""!($G(ERTXT)'="") D  G:'IBISMBI FILX   ; IB*2*601/DM  If MBI response keep processing
 . S ERACT=$$ERRACT^IBCNEHLU(RIEN),ERCON=$P(ERACT,U,2),ERACT=$P(ERACT,U)
 . D ERROR^IBCNEHL3(TQN,ERACT,ERCON,TRACE)
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
 ;  2) the buffer entry is verified (* symbol)
 I BUFF'="",($P($G(^IBA(355.33,BUFF,0)),U,4)'="E")!($$SYMBOL^IBCNBLL(BUFF)="*") G FILX
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
 I BUFF'="" D RP^IBCNEBF(RIEN,"",BUFF)
 ;
 ;  If no associated buffer entry, create one & populate w/ response
 ;  data (routine call sets IBFDA)
 I BUFF="" D RP^IBCNEBF(RIEN,1) S BUFF=+IBFDA,UP(365,RIEN_",",.04)=BUFF
 ;
 ; IB*2*601/DM for an MBI query, set the patient relationship to insured to "Patient"
 I IBISMBI S UP(355.33,BUFF_",",60.06)="01"
 ;
 ;  Set eIV Processed Date to now
 S UP(355.33,BUFF_",",.15)=$$NOW^XLFDT()
 D FILE^DIE("I","UP","ERROR")
FILX ;
 Q
 ;

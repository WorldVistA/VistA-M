IBCNEHL3 ;DAOU/ALA - HL7 Process Incoming RPI Continued ;03-JUL-2002  ; Compiled June 2, 2005 14:20:19
 ;;2.0;INTEGRATED BILLING;**300,416,497,506**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This is a continuation of IBCNEHL1 which processes an incoming
 ;  RPI IIV message.
 ;  
 ;  This routine is based on IBCNEHLS which was introduced with patch 184, and subsequently
 ;  patched with patch 271.  IBCNEHLS is obsolete and deleted with patch 300.
 ;
 Q   ; no direct calls allow
 ;
ERROR(TQN,ERACT,ERCON,TRCN) ; Entry point
 ; Input:  TQN - IEN for eIV Transmission Queue (#365.1), required
 ;         ERACT - Error Action Code (#365.14), required
 ;         ERCON - Error Condition Code (#365.17), required
 ;         TRCN - Trace # from eIV Response (#365)
 ;
 ;         IIVSTAT - IIV status transmitted by EC
 ;                   Note: MAP(IIVSTAT) = IIV STATUS IEN
 N MSG,ERDESC,ERIEN,XMY,DA,DIE,DR
 ;
 I $G(TQN)="" G ERRORX
 ;
 ;/Removed the following lines of code as part of IB*2.0*506 but wanted to
 ;/leave this code available if it should be needed in the future.
 ; Scenarios:
 ; #1 - If error message = "Resubmission Allowed" OR "Please Resubmit
 ; Original Transaction" - set TQ
 ; Fut Trans Dt to T + Comm Failure Days and Status to "Hold"
 ;I ERACT="R"!(ERACT="P") D G ERRORX
 ;. I $P($G(^IBCN(365.1,TQN,0)),U,9)="" D Q ; first time payer asked us to resubmit
 ;. . ; Update IIV TQ fields: "Hold" (4), IIV Site Param Comm Failure Days
 ;. . D UPDATE(TQN,4,+$P($G(^IBE(350.9,1,51)),U,5),ERACT)
 ;. . ;
 ;. ; payer asked us to resubmit for the 2nd time for this inquiry
 ;. ; Update IIV TQ fields: "Response Received" (3), n/a ("")
 ;. D UPDATE(TQN,3,"",ERACT,ERCON)
 ;. ; clear future transmission date so it won't display in the buffer
 ;. S DA=TQN,DIE="^IBCN(365.1,",DR=".09///@" D ^DIE
 ;
 ; #2 - If error message = "Please Wait 30 Days and Resubmit" - set TQ
 ; Fut Trans Dt to T + 30 and Status to "Hold"
 ;I ERACT="W" D G ERRORX
 ;. ; Update IIV TQ fields: "Hold" (4), 30
 ;. D UPDATE(TQN,4,30,ERACT)
 ;
 ; #3 - If error message = "Please Wait 10 Days and Resubmit" - set TQ
 ; Fut Trans Dt to T + 10 and Status to "Hold"
 ;I ERACT="X" D G ERRORX
 ;. ; Update IIV TQ fields: "Hold" (4), 10
 ;. D UPDATE(TQN,4,10,ERACT)
 ;
 ; #4 - If error message = "Resubmission Not Allowed" or
 ; "Do not resubmit ...." OR "Please correct and resubmit"
 ; - set TQ Status to "Response Received"
 ; If we receive error txt, treat as an "N"
 ;I ERACT="" S ERACT="N"
 ;I ERACT="N"!(ERACT="Y")!(ERACT="S")!(ERACT="C") D G ERRORX
 ;. ; Update IIV TQ fields: "Response Received" (3), n/a ("")
 ;. D UPDATE(TQN,3,"",ERACT,ERCON)
 ;
 ; #5 - Error message is unfamiliar - new Error Action Code
 ; *** Currently processed in IBCNEHL1 ***
 ;/End of removed code for IB*2.0*506
 ;
 ; /IB*2.0*506 Beginning
 ; For all Scenarios 1 thru 5, set TQ Status to "Response Received"
 I ERACT="" S ERACT="N"
 I ",R,P,W,X,N,Y,S,C,"[(","_ERACT_",") D  G ERRORX
 . ; Update IIV TQ fields: "Response Received" (3), n/a ("")
 . D UPDATE(TQN,3,"",ERACT,ERCON)
 ; /IB*2.0*506 End
 ;
ERRORX ; ERROR exit pt
 Q
 ;
UPDATE(TQN,TSTS,TDAYS,ERACT,ERCON) ;  Update Transmission Queue (#365.1)
 ; Update/Create Buffer information as necessary
 ; * If unsolicited error or negative Verification response do not
 ; update TQ entry.  However, create a new Buffer entry.
 ; Input Variables
 ; ERACT,ERCON,IIVSTAT,TDAYS,TQN,TSTS
 ;
 ; Output Variables
 ; IIVSTAT (updated)
 ;
 ; Init optional param
 S ERCON=$G(ERCON)
 ;
 ; Init vars
 N D,D0,DA,DFN,DI,DIC,DIE,DQ,DR,FTDT,IBDATA,IBIEN,IBQFL,IBSTS,IBSYM
 N INSIEN,RSTYPE,SYMBOL,TQDATA,X
 ;
 ; If no ZEB segment received, set IIVSTAT to "V"
 I $TR(IIVSTAT," ")="" S IIVSTAT="V"
 ;
 S TQDATA=$G(^IBCN(365.1,TQN,0))
 I TQDATA="" G UPDATX
 ;
 ; Ins Buffer IEN
 S IBIEN=$P(TQDATA,U,5)
 S IBQFL=$P(TQDATA,U,11)
 S RSTYPE=$P($G(^IBCN(365,RIEN,0)),U,10)
 ;
 ; If unsolicited error or negative Identification response DON'T
 ; update TQ entry or Buffer (includes not creating a new buffer)
 I RSTYPE="U",(IBQFL="I") G UPDATX
 ;
 I RSTYPE="U" S IBIEN=""  ; makes sure a new buffer is created
 ;
 ; Ins Buffer processing
 I IBIEN'="" D
 . ; Ins Buf data
 . S IBDATA=$G(^IBA(355.33,+IBIEN,0))
 . S IBSTS=$P(IBDATA,U,4)   ; Status
 . S IBSYM=$P(IBDATA,U,12)  ; Symbol
 . ; If IB status is (A)ccepted or (R)ejected or IB symbol is "*"
 . ;  (verified) or IB symbol is "-" (denied), update TQ status to
 . ;  Resp Rec'd (3) and DON'T update the Ins Buffer symbol
 . I IBSTS="A"!(IBSTS="R")!(IBSYM=8)!(IBSYM=9) S TSTS=3 Q
 . ; If TQ status is "Hold", update buffer symbol to "?" (10)
 . I TSTS=4 D BUFF^IBCNEUT2(IBIEN,10) Q  ; Set buffer symbol to "?"
 . ; If TQ status is "Response Received", update buffer symbol to "-" (9) for Error
 . ; Action Codes ('N','Y','S') & Action Codes ('P','R', if 2nd time payer sent that code)
 . I TSTS=3,(ERACT="N"!(ERACT="Y")!(ERACT="S")!(ERACT="C")!(ERACT="P")!(ERACT="R")) D  Q
 .. S SYMBOL=MAP(IIVSTAT)
 .. D BUFF^IBCNEUT2(IBIEN,SYMBOL) ; Set buffer symbol to EC value
 .. D IIVPROC(IBIEN)   ; Set IIV process date & IIV status
 . ; If TQ status is "Response Received", update buffer symbol to "!" (12 = B9) for new Error Action Code
 . I TSTS=3,",W,X,R,P,C,N,Y,S,"'[(","_ERACT_",") D BUFF^IBCNEUT2(IBIEN,22) Q
 ;
 ; Non-Ins Buffer processing, create entry only for Verification queries
 I IBIEN="",IBQFL="V" D
 . ; Determine Patient DFN
 . S DFN=$P(TQDATA,U,2)
 . ; Determine Patient Ins record IEN
 . S INSIEN=$P(TQDATA,U,13)  ; If INSIEN="" avoids TQ update
 . ; If ERACT="C" symbol is passed by EC
 . I ERACT="C" S SYMBOL=MAP(IIVSTAT) D BUF Q
 . ;  Resubmission Not Allowed or Do Not Resubmit ...
 . I ERACT="N"!(ERACT="Y")!(ERACT="S") S SYMBOL=MAP(IIVSTAT) D BUF Q
 . ; An unknown error action - generate a '#'
 . I ",W,X,R,P,C,N,Y,S,"'[(","_ERACT_",") S SYMBOL=22 D BUF Q
 ;
 I RSTYPE="U" G UPDATX  ; finished creating new buffer
 ;
 ; Update TQ record - Status
 D SST^IBCNEUT2(TQN,TSTS)
 ;
 ; If TQ Status = "Hold", update TQ record - Future Transmission Date
 I TSTS=4,+$G(TDAYS) D
 . S FTDT=$$FMADD^XLFDT($$DT^XLFDT,TDAYS)
 . S DIE="^IBCN(365.1,",DA=TQN,DR=".09///^S X=FTDT"
 . D ^DIE
 I TSTS=4,$P(TQDATA,U,8) D
 . S DIE="^IBCN(365.1,",DA=TQN,DR=".08///0"
 . D ^DIE
 ;
UPDATX ; UPDATE exit point
 Q
 ;
PCK ; Payer Check
 ;  Find the associated Response IEN
 ;
 ; Input Variables
 ; MSGID
 ;
 ; Output Variables
 ; RIEN,ERFLG
 ;
 N BUFF,DA,DFN,DIE,DR,IEN,IERN,IN1DATA,MDTM,QFL,PAYR,PIEN,PP
 N PRDATA,PRIEN,RSIEN,X
 N NOPAYER,TQIEN
 ;
 K ^TMP("IBCNEMID",$J)
 D FIND^DIC(365,"","","P",MSGID,"","B","","","^TMP(""IBCNEMID"",$J)")
 ;
 S PP=0,QFL=0,(RIEN,PIEN)=""
 S NOPAYER=$$FIND1^DIC(365.12,,"X","~NO PAYER"),TQIEN=$O(^IBCN(365.1,"C",MSGID,""))
 F  S PP=$O(^TMP("IBCNEMID",$J,"DILIST",PP)) Q:'PP  D  Q:QFL
 . S PRIEN=$P(^TMP("IBCNEMID",$J,"DILIST",PP,0),U,1)
 . ;
 . ;  If this is a response w/o an IN1 segment
 . ;  Get payer IEN from TQ as original response shell will change for
 . ;  ~NO PAYER if a payer response is received
 . S IN1DATA=$$GIN1()
 . I IN1DATA="",PRIEN'="",TQIEN'="" D
 ..  S QFL=1,PIEN=$P(^IBCN(365.1,TQIEN,0),U,3)
 . ;
 . I 'PIEN D PFN(IN1DATA) I 'PIEN S QFL=1 Q
 . ;
 . ; If message id/payer found & Response (#365) status is NOT
 . ; 'Response Received' update the existing response entry (set RIEN)
 . I $P(^IBCN(365,PRIEN,0),U,3)=PIEN,($P(^IBCN(365,PRIEN,0),U,6)'=3) D  Q
 .. S RIEN=PRIEN,QFL=1
 ..;
 ..; If message id/payer found & Response (#365) status equals
 . ; 'Response Received', RIEN is still null so that this tag knows
 . ; to create a new unsolicited response entry
 . ; 
 . ; If payer response received to ~NO PAYER, update eIV Response file
 . ; w/ responding payer
 . I RIEN="" S PRDATA=$G(^IBCN(365,PRIEN,0)) I $P(PRDATA,U,3)=NOPAYER,$P(PRDATA,U,6)'=3,$P(PRDATA,U,10)="O" D  Q
 .. S RIEN=PRIEN,QFL=1
 .. S DIE="^IBCN(365,",DA=RIEN,DR=".03///^S X=PIEN" D ^DIE
 ;
 ;  If message id/payer not found or unsolicited response, create new response entry
 I RIEN="" D  Q:ERFLG
 . I $G(PRIEN)'="" D
 .. S PRDATA=$G(^IBCN(365,PRIEN,0))
 .. S DFN=$P(PRDATA,U,2),IEN=$P(PRDATA,U,5),MDTM=$P(PRDATA,U,8)
 . ;
 . I PIEN="" D  Q:ERFLG
 ..  S IN1DATA=$$GIN1()
 ..  I IN1DATA]"" D PFN(IN1DATA) I 'PIEN S PIEN="",QFL=1
 . S PAYR=PIEN,(RSTYPE,BUFF)=""
 . D RESP^IBCNEDEQ
 . S RIEN=RSIEN
 ;
 ; If no payer in response file, set it
 I $G(PIEN)'="",$G(RIEN)'="",$P($G(^IBCN(365,PIEN,0)),U,3)="" D
 . S DIE="^IBCN(365,",DA=RIEN,DR=".03///^S X=PIEN" D ^DIE
 Q
 ;
BUF ; Create Buffer Record if Doesn't Exist
 ;
 ; Input Variables
 ; RIEN,RSTYPE,TQN
 ;
 ; Output Variables
 ; ERROR,SYMBOL is killed,TQIEN and IRIEN may be reset
 ;
 N BUFF,IBFDA,UP
 I $G(RSTYPE)="U" S (TQIEN,IRIEN)=""
 D RP^IBCNEBF(RIEN,1)
 S BUFF=+IBFDA
 S UP(365,RIEN_",",.04)=+IBFDA
 I RSTYPE="O" S UP(365.1,TQN_",",.05)=+IBFDA
 D FILE^DIE("I","UP","ERROR")
 K SYMBOL
 Q
 ;
IIVPROC(BUFF) ; Set IIV Processed Date to current dt/tm & IIV stat (aka SYMBOL)
 ; Input Variables
 ; BUFF
 ;
 ; Output Variables
 ; SYMBOL
 ;
 N IDUZ,UP
 S UP(355.33,BUFF_",",.15)=$$NOW^XLFDT()
 ;  Set IDUZ to the specific, non-human user.
 S IDUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB EIV")
 D FILE^DIE("I","UP","ERROR")
 ; set the symbol of the buffer entry
 D BUFF^IBCNEUT2(BUFF,SYMBOL)  ; reset symbol to appropriate value
 Q
 ;
PFN(IN1DATA) ;  Find Payer from HL7 msg
 ;
 ; Input Variables
 ; IN1DATA, TRACE
 ;
 ; Output Variables
 ; ERFLG,ERROR,PIEN
 ;
 N IERN,PAYRID
 S PAYRID=$$CLNSTR^IBCNEHLU($P($P(IN1DATA,HLFS,4),$E(HL("ECH"))),HL("ECH"),$E(HL("ECH")))
 S PIEN=+$$FIND1^DIC(365.12,"","MX",PAYRID)
 I PIEN=0 D  Q
 . S ERFLG=1,IERN=$$ERRN^IBCNEUT7("ERROR(""DIERR"")")
 . S ERROR("DIERR",IERN,"TEXT",1)="National Id: "_PAYRID_" not found in Payer Table"
 . S ERROR("DIERR",IERN,"TEXT",2)="for Trace Number: "_TRACE
 Q
 ;
GIN1() ;Get IN1 segment
 ;
 ; Input Variables
 ; HCT
 ;
 ; Returns value of SEGMT
 ;
 N IPCT,SEGMT
 S IPCT=HCT,SEGMT=""
 F  S IPCT=$O(^TMP($J,"IBCNEHLI",IPCT)) Q:IPCT=""  D
 . I $E(^TMP($J,"IBCNEHLI",IPCT,0),1,3)="IN1" S SEGMT=^TMP($J,"IBCNEHLI",IPCT,0)
 Q SEGMT
 ;
 ; =================================================================
WARN ;  Create and send a response processing error warning message
 ;
 ; Input Variables
 ; ERROR, TRACE
 ;
 ; Output Variables
 ; ERFLG=1
 ;
 N MCT,MSG,SUBCNT,VEN,XMY
 S VEN=0,MCT=9,ERFLG=1,SUBCNT=""
 S MSG(1)="IMPORTANT: Error While Processing Response Message from the EC"
 S MSG(2)="-------------------------------------------------------------"
 S MSG(3)="*** IRM *** Please contact Help Desk because the"
 S MSG(4)="response message received from the Eligibility Communicator"
 S MSG(5)="could not be processed.  Programming changes may be necessary"
 S MSG(6)="to properly handle the response."
 S MSG(7)="The associated Trace # is "_$S($G(TRACE)="":"Unknown",1:TRACE)_". If applicable,"
 S MSG(8)="please review the response with the eIV Response Report by Trace#."
 S MSG(9)=" "
 F  S VEN=$O(ERROR("DIERR",VEN)) Q:'VEN  D
 .S MCT=MCT+1,MSG(MCT)="Error:"
 .F  S SUBCNT=$O(ERROR("DIERR",VEN,"TEXT",SUBCNT)) Q:'SUBCNT  S MCT=MCT+1,MSG(MCT)=ERROR("DIERR",VEN,"TEXT",SUBCNT)
 .S MCT=MCT+1,MSG(MCT)=" "
 .I $G(ERROR("DIERR",VEN,"PARAM","FILE"))'="" S MCT=MCT+1,MSG(MCT)="File: "_ERROR("DIERR",VEN,"PARAM","FILE")
 .I $G(ERROR("DIERR",VEN,"PARAM","IENS"))'="" S MCT=MCT+1,MSG(MCT)="IENS: "_ERROR("DIERR",VEN,"PARAM","IENS")
 .I $G(ERROR("DIERR",VEN,"PARAM","FIELD"))'="" S MCT=MCT+1,MSG(MCT)="Field: "_ERROR("DIERR",VEN,"PARAM","FIELD")
 .S MCT=MCT+1,MSG(MCT)=" "
 .Q
 D MSG^IBCNEUT5(MGRP,MSG(1),"MSG(",,.XMY)
 Q
 ;
 ; =================================================================
UEACT ; Send warning msg if Unknown Error Action Code was received or
 ; encountered problem filing date
 ;
 ; Input Variables
 ; ERROR, IBIEN, IBQFL, RIEN, RSTYPE, TQDATA, TRACE
 ;
 ; Output Variables
 ; ERFLG=1 (SET IN WARN TAG)
 ;
 N DFN,SYMBOL
 D WARN  ; send warning msg
 ;
 ; If the response could not be created or there is no associated TQ entry, stop processing
 I '$G(RIEN)!(TQDATA="") Q
 ;
 ;  For an original response, set the Transmission Queue Status to 'Response Received' &
 ;  update remaining retries to comm failure (5)
 I $G(RSTYPE)="O" D SST^IBCNEUT2(TQN,3),RSTA^IBCNEUT7(TQN)
 ;
 ; If it is an identification and policy is not active don't
 ; create buffer entry
 I IBQFL="I",IIVSTAT'=1 Q
 ;
 ; If unsolicited message or no buffer in TQ, create new buffer entry
 I RSTYPE="U" S IBIEN=""
 I IBIEN="" D  Q
 .  S DFN=$P(TQDATA,U,2)        ; Determine Patient DFN
 .  S SYMBOL=22 D BUF^IBCNEHL3  ; Create a new buffer entry
 ;
 ;Update buffer symbol
 D BUFF^IBCNEUT2(IBIEN,22)
 ;
 Q
 ;
CHK1() ; check auto-update criteria for patient who is the subscriber
 ; called from tag AUTOUPD, uses variables defined there
 ;
 ; returns 1 if given policy satisfies auto-update criteria, returns 0 otherwise
 N RES
 S RES=0
 I $P(RDATA13,U,2)'=$P(IDATA7,U,2) G CHK1X  ; Subscriber ID doesn't match   ; IB*2.0*497 compare subscriber ID data at their new locations
 I $P(RDATA1,U,2)'=$P(IDATA3,U) G CHK1X  ; DOB doesn't match
 I '$$NAMECMP^IBCNEHLU($P(RDATA13,U),$P(IDATA7,U)) G CHK1X  ; Insured's name doesn't match  ; IB*2.0*497 compare name of insured data at their new locations
 S RES=1
CHK1X ;
 Q RES
 ;
CHK2(MWNRTYP) ; check auto-update criteria for patient who is not the subscriber
 ; called from tag AUTOUPD, uses variables defined there
 ;
 ; returns 1 if policy satisfies auto-update criteria, returns 0 otherwise
 N DOB,ID,IDATA5,IENS,NAME,PDOB,PNAME,RES
 S RES=0
 S IDATA5=$G(^DPT(IEN2,.312,IEN312,5))
 S IENS=IEN2_","
 S ID=$P(RDATA13,U,2)    ; IB*2.0*497 Subscriber ID needs to be retrieved from its new location
 I ID'=$P(IDATA7,U,2),ID'=$P(IDATA5,U) G CHK2X  ; both Subscriber ID and Patient ID don't match ; IB*2.0*497 compare subscriber ID at new locations
 S DOB=$P(RDATA1,U,2),PDOB=$$GET1^DIQ(2,IENS,.03,"I")
 I DOB'=$P(IDATA3,U),DOB'=PDOB G CHK2X  ; both Subscriber and Patient DOB don't match
 S NAME=$P(RDATA13,U),PNAME=$$GET1^DIQ(2,IENS,.01)   ; IB*2.0*497 get name of insured at its new location
 I '+MWNRTYP,'$$NAMECMP^IBCNEHLU(NAME,$P(IDATA7,U)),'$$NAMECMP^IBCNEHLU(NAME,PNAME) G CHK2X  ; non-Medicare, both Subscriber and Patient name don't match ; IB*2*497
 I +MWNRTYP,'$$NAMECMP^IBCNEHLU(NAME,PNAME) G CHK2X  ; Medicare, Patient name doesn't match
 S RES=1
CHK2X ;
 Q RES
 ;
UPDIREC(RIEN,IEN312) ; update insurance record field in transmission queue (365.1/.13)
 ; RIEN - ien in eIV Response file (365)
 ; IEN312 - ien in pat. insurance multiple (2.312)
 ;
 N DATA,ERROR,IENS
 I RIEN'>0!(IEN312'>0) Q
 S IENS=$P($G(^IBCN(365,RIEN,0)),U,5)_"," I IENS="," Q
 S DATA(365.1,IENS,.13)=IEN312
 D FILE^DIE("ET","DATA","ERROR")
 Q
 ;
LCKERR ; send locking error message
 N MSG,XMY
 S MSG(1)="WARNING: Unable to Auto-file Response Message from the EC"
 S MSG(2)="---------------------------------------------------------"
 S MSG(3)="Failed to lock patient insurance entry:"
 S MSG(4)="  Patient name - "_$$GET1^DIQ(2,DFN_",",.01)
 S MSG(5)="  Insurance - "_$$GET1^DIQ(2.312,IENS,.01)
 S MSG(6)="  IENS - "_$S($G(IENS)="":"Unknown",1:IENS)
 S MSG(7)=" "
 S MSG(8)="The response will be filed into Insurance Buffer instead."
 S MSG(9)=" "
 D MSG^IBCNEUT5(MGRP,MSG(1),"MSG(",,.XMY)
 Q

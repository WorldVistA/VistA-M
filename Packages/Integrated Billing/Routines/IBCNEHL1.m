IBCNEHL1 ;DAOU/ALA - HL7 Process Incoming RPI Messages ;26-JUN-2002  ; Compiled December 16, 2004 15:29:01
 ;;2.0;INTEGRATED BILLING;**300,345,416,444**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process incoming IIV response messages.
 ;  This includes updating the record in the IIV Response File,
 ;  updating the Buffer record (if there is one and creating a new
 ;  one if there isn't) with the appropriate Buffer Symbol and data
 ;  
 ;  This routine is based on IBCNEHLR which was introduced with patch 184, and subsequently
 ;  patched with patches 252 and 271.  IBCNEHLR is obsolete and deleted with patch 300.
 ;
 ;**Modified by  Date        Reason
 ;  DAOU/BHS     10/04/2002  Added logic to update the service date in
 ;                           the TQ entry so long as the Error Action is
 ;                           not Please submit original transaction.
 ;  DAOU/DB      03/11/2004  Added logic to utilize new status flag
 ;                           transmitted to VistA from EC (IIVSTAT)
 ;               03/15/2004  Update other retries to comm failure (if
 ;                           not response rcvd)
 ;  DAOU/BEE     07/14/2004  Cleaned up routine - Made more readable
 ;                           Cleaned up variables                          
 ;  PROXICOM/RTO 08/23/2006  Fixed logic issue when determining whether
 ;                           to update a buffer entry
 ;
 ;  Variables
 ;    SEG = HL7 Segment Name
 ;    MSGID = Original Message Control ID
 ;    ACK =  Acknowledgment (AA=Accepted, AE=Error)
 ;    ERTXT = Error Message Text
 ;    ERFLG = Error quit flag
 ;    ERACT = Error Action
 ;    ERCON = Error Condition
 ;    RIEN = Response Record IEN
 ;    IIVSTAT = EC generated flag interpreting status of response
 ;              1 = +
 ;              6 = -
 ;              V = #
 ;    MAP = Array that maps EC's IIV status flag to IIV STATUS TABLE (#365.15)   IEN
 ;
EN ; Entry Point
 N AUTO,EBDA,ERFLG,ERROR,G2OFLG,HCT,HLCMP,HLREP,HLSCMP,IIVSTAT,IRIEN,MAP,MGRP,RIEN,RSUPDT,SEG,SUBID,TRACE,UP,ACK
 S (ERFLG,G2OFLG)=0,MGRP=$$MGRP^IBCNEUT5(),HCT=1,SUBID="",IIVSTAT=""
 ;
 S HLCMP=$E(HL("ECH")) ; HL7 component separator
 S HLSCMP=$E(HL("ECH"),4) ; HL7 subcomponent separator
 S HLREP=$E(HL("ECH"),2) ; HL7 repetition separator
 ; Create map from EC to VistA
 S MAP(1)=8,MAP(6)=9,MAP("V")=21
 ;
 ;  Loop through the message and find each segment for processing
 F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D  Q:ERFLG
 . D SPAR^IBCNEHLU
 . S SEG=$G(IBSEG(1))
 . ; check if we are inside G2O group of segments
 . I SEG="ZTY" S G2OFLG=1
 . I G2OFLG,SEG'="ZTY",SEG'="CTD" S G2OFLG=0
 . ; If we are outside of Z_Benefit_group, kill EB multiple ien
 . I +$G(EBDA),".MSH.MSA.PRD.PID.GT1.IN1.IN3."[("."_SEG_".")!('G2OFLG&(SEG="CTD")) K EBDA
 . ;
 . I SEG="MSA" D MSA^IBCNEHL2(.ERACT,.ERCON,.ERROR,.ERTXT,.IBSEG,MGRP,.RIEN,.TRACE) Q:ERFLG
 . ;
 . ;  Contact Segment
 . I SEG="CTD",'G2OFLG D CTD^IBCNEHL2(.ERROR,.IBSEG,RIEN)
 . ;
 . ;  Patient Segment
 . I SEG="PID" D PID^IBCNEHL2(.ERFLG,.ERROR,.IBSEG,RIEN)
 . ;
 . ;  Guarantor Segment
 . I SEG="GT1" D GT1^IBCNEHL2(.ERROR,.IBSEG,RIEN,.SUBID)
 . ;
 . ;  Insurance Segment
 . I SEG="IN1" D IN1^IBCNEHL2(.ERROR,.IBSEG,RIEN,SUBID)
 . ;
 . ;  Addt'l Insurance Segment
 . ;I SEG="IN2" ; for future expansion, add IN2 tag to IBCNEHL2
 . ;
 . ;  Addt'l Insurance - Cert Segment
 . I SEG="IN3" D IN3^IBCNEHL2(.ERROR,.IBSEG,RIEN)
 . ;
 . ;  Eligibility/Benefit Segment
 . I SEG="ZEB" D ZEB^IBCNEHL2(.EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ; Healthcare Delivery Segment
 . I SEG="ZHS" D ZHS^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ; Reference ID Segment
 . I SEG="ZRF" D ZRF^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ; Subscriber Date Segment
 . I SEG="ZSD" D ZSD^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ; Subscriber Additional Info Segment
 . I SEG="ZII" D ZII^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ; Benefit Related Entity Segment
 . I SEG="ZTY" D ZTY^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ; Benefit Related Entity Contact Segment
 . I SEG="CTD",G2OFLG D G2OCTD^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN)
 . ;
 . ;  Notes Segment
 . I SEG="NTE" D NTE^IBCNEHL2(EBDA,.IBSEG,RIEN)
 ;
 S AUTO=$$AUTOUPD(RIEN)
 I $G(ACK)'="AE",$G(ERACT)="",$G(ERTXT)="",'$D(ERROR),+AUTO D  Q
 .D:$P(AUTO,U,3)'="" AUTOFIL($P(AUTO,U,2),$P(AUTO,U,3),$P(AUTO,U,6))
 .D:$P(AUTO,U,4)'="" AUTOFIL($P(AUTO,U,2),$P(AUTO,U,4),$P(AUTO,U,6))
 .Q
 D FIL
 Q
 ;
 ; =================================================================
AUTOFIL(DFN,IEN312,ISSUB) ; Finish processing the response message - file directly into patient insurance
 ;
 N BUFF,DATA,ERROR,IENS,PREL,RDATA0,RDATA1,RDATA5,RSTYPE,TQN,TSTAMP
 ;
 Q:$G(RIEN)=""
 S TSTAMP=$$NOW^XLFDT(),IENS=IEN312_","_DFN_","
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1)),RDATA5=$G(^IBCN(365,RIEN,5))
 S TQN=$P(RDATA0,U,5),RSTYPE=$P(RDATA0,U,10)
 I ISSUB S DATA(2.312,IENS,17)=$P(RDATA1,U) ; name
 S DATA(2.312,IENS,3.01)=$P(RDATA1,U,2) ; dob
 S DATA(2.312,IENS,3.05)=$P(RDATA1,U,3) ; ssn
 I ISSUB,$P(RDATA1,U,8)'="" S DATA(2.312,IENS,6)=$P(RDATA1,U,8) ; whose insurance
 S PREL=$$PREL($P(RDATA1,U,9),$$GET1^DIQ(2.312,IENS,4.03,"I"))
 I ISSUB,PREL'="" S DATA(2.312,IENS,4.03)=PREL ; pt. relationship
 ;
 S DATA(2.312,IENS,1.03)=TSTAMP ; date last verified
 S DATA(2.312,IENS,1.04)="" ; last verified by
 S DATA(2.312,IENS,1.05)=TSTAMP ; date last edited
 S DATA(2.312,IENS,1.06)="" ; last edited by
 S DATA(2.312,IENS,1.09)=5 ; source of info = eIV
 ;subscriber address
 S DATA(2.312,IENS,3.06)=$P(RDATA5,U) ; street line 1
 S DATA(2.312,IENS,3.07)=$P(RDATA5,U,2) ; street line 2
 S DATA(2.312,IENS,3.08)=$P(RDATA5,U,3) ; city
 S DATA(2.312,IENS,3.09)=$P(RDATA5,U,4) ; state
 S DATA(2.312,IENS,3.1)=$P(RDATA5,U,5) ; zip
 ;
 D FILE^DIE("ET","DATA","ERROR") I $D(ERROR) D WARN K ERROR D FIL Q
 ; set eIV auto-update field separately because of the trigger on field 1.05
 K DATA S DATA(2.312,IENS,4.04)="YES" D FILE^DIE("ET","DATA","ERROR") I $D(ERROR) D WARN Q
 ; file new EB data
 S ERFLG=$$EBFILE(DFN,IEN312,RIEN,1)
 ; bail out if something went wrong during filing of EB data
 I $G(ERFLG) Q
 ; update insurance record ien in transmission queue
 D UPDIREC(RIEN,IEN312)
 ;  For an original response, set the Transmission Queue Status to 'Response Received' &
 ;  update remaining retries to comm failure (5)
 I $G(RSTYPE)="O" D SST^IBCNEUT2(TQN,3),RSTA^IBCNEUT7(TQN)
 ; update buffer file entry so only stub remains and status is changed
 S BUFF=+$P($G(^IBCN(365,RIEN,0)),U,4)
 I BUFF D
 .D STATUS^IBCNBEE(BUFF,"A",0,0,0) ; update buffer entry's status to accepted
 .D DELDATA^IBCNBED(BUFF) ; delete buffer's insurance/patient data
 .Q
 Q
 ;
FIL ; Finish processing the response message - file into insurance buffer
 ;
 ; Input Variables
 ; ERACT, ERFLG, ERROR, IIVSTAT, MAP, RIEN, TRACE
 ;
 ; If no record IEN, quit
 I $G(RIEN)="" Q
 ;
 N BUFF,DFN,FILEIT,IBFDA,IBIEN,IBQFL,RDAT0,RSRVDT,RSTYPE,SYMBOL,TQDATA,TQN,TQSRVDT
 ; Initialize variables from the Response File
 S RDAT0=$G(^IBCN(365,RIEN,0)),TQN=$P(RDAT0,U,5)
 S TQDATA=$G(^IBCN(365.1,TQN,0))
 S IBQFL=$P(TQDATA,U,11)
 S DFN=$P(RDAT0,U,2),BUFF=$P(RDAT0,U,4)
 S IBIEN=$P(TQDATA,U,5),RSTYPE=$P(RDAT0,U,10)
 S RSRVDT=$P($G(^IBCN(365,RIEN,1)),U,10)
 ;
 ; If an unknown error action or an error filing the response message,
 ; send a warning email message
 ; Note - A call to UEACT will always set ERFLAG=1
 I ",W,X,R,P,C,N,Y,S,"'[(","_$G(ERACT)_",")&($G(ERACT)'="")!$D(ERROR) D UEACT
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
 I $G(ERACT)'=""!($G(ERTXT)'="") D ERROR^IBCNEHL3(TQN,ERACT,ERCON,TRACE) G FILX
 ;
 ; Stop processing if identification response and not an active policy
 S FILEIT=1
 I $G(IIVSTAT)=6,TQN]"" D
 . I TQDATA="" Q
 . I IBQFL'="I" Q
 . S FILEIT=0
 I 'FILEIT G FILX
 ;
 ;  If there is an associated buffer entry & one or both of the following
 ;  is true, stop filing (don't update buffer entry)
 ;  1) buffer status is not 'Entered'
 ;  2) the buffer entry is verified (* symbol)
 I BUFF'="",($P($G(^IBA(355.33,BUFF,0)),U,4)'="E")!($$SYMBOL^IBCNBLL(BUFF)="*") G FILX
 ;
 ;  Set buffer symbol based on value returned from EC
 S SYMBOL=MAP(IIVSTAT)
 ;
 ;  If there is an associated buffer entry, update the buffer entry w/
 ;  response data
 I BUFF'="" D RP^IBCNEBF(RIEN,"",BUFF)
 ;
 ;  If no associated buffer entry, create one & populate w/ response
 ;  data (routine call sets IBFDA)
 I BUFF="" D RP^IBCNEBF(RIEN,1) S BUFF=+IBFDA,UP(365,RIEN_",",.04)=BUFF
 ;
 ;  Set eIV Processed Date to now
 S UP(355.33,BUFF_",",.15)=$$NOW^XLFDT()
 D FILE^DIE("I","UP","ERROR")
FILX ;
 Q
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
 S VEN=0,MCT=8,ERFLG=1,SUBCNT=""
 S MSG(1)="IMPORTANT: Error While Processing Response Message from the EC"
 S MSG(2)="-------------------------------------------------------------"
 S MSG(3)="*** IRM *** Please contact Help Desk because the"
 S MSG(4)="response message received from the Eligibility Communicator"
 S MSG(5)="could not be processed.  Programming changes may be necessary"
 S MSG(6)="to properly handle the response."
 S MSG(7)="The associated Trace # is "_$S($G(TRACE)="":"Unknown",1:TRACE)_". If applicable,"
 S MSG(8)="please review the response with the eIV Response Report by Trace#."
 F  S VEN=$O(ERROR("DIERR",VEN)) Q:'VEN  D
 . F  S SUBCNT=$O(ERROR("DIERR",VEN,"TEXT",SUBCNT)) Q:'SUBCNT  D
 . . S MCT=MCT+1,MSG(MCT)=ERROR("DIERR",VEN,"TEXT",SUBCNT)
 . S MCT=MCT+1,MSG(MCT)=" "
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
AUTOUPD(RIEN) ;
 ; Returns "1^file 2 ien^file 2.312 ien^2nd file 2.312 ien^Medicare flag^subsriber flag", if entry
 ; in file 365 is eligible for auto-update, returns 0 otherwise.
 ;
 ; Medicare flag: 1 for Medicare, 0 otherwise
 ; Subscriber flag: 1 if patient is the subscriber, 0 otherwise
 ;
 ; For non-Medicare response: 1st file 2.312 ien is set, 2nd file 2.312 ien is empty, pieces 5-7 are empty
 ; For Medicare response: 1st file 2.312 ien contains ien for Medicare Part A, 2nd file 2.312 ien contains ien for Medicare Part B,
 ;                        either one may be empty, but at least one of them is set if entry is eligible.
 ;
 ; RIEN - ien in file 365
 ;
 N APPIEN,GDATA,GIEN,GNAME,GNUM,GOK,IEN2,IEN312,IEN36,IDATA0,IDATA3,ISSUB,MWNRA,MWNRB,MWNRIEN,MWNRTYP
 N ONEPOL,PIEN,RDATA0,RDATA1,RES,TQIEN
 S RES=0
 I +$G(RIEN)'>0 Q RES  ; invalid ien for file 365
 I $G(IIVSTAT)'=1 Q RES ; only auto-update 'active policy' responses
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1))
 S PIEN=$P(RDATA0,U,3) I +PIEN>0 S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 I +$G(APPIEN)'>0 Q RES  ; couldn't find eIV application entry
 I $P(^IBE(365.12,PIEN,1,APPIEN,0),U,7)=0 Q RES  ; auto-accept is OFF
 S IEN2=$P(RDATA0,U,2) I +IEN2'>0 Q RES  ; couldn't find patient
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25),MWNRTYP=0,(MWNRA,MWNRB)=""
 I PIEN=MWNRIEN S MWNRTYP=$$ISMCR^IBCNEHLU(RIEN)
 S ONEPOL=$$ONEPOL^IBCNEHLU(PIEN,IEN2)
 ; try to find a matching pat. insurance
 S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""!(RES>0)  D
 .S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""!(RES>0&('+MWNRTYP))  D
 ..S IDATA0=$G(^DPT(IEN2,.312,IEN312,0)),IDATA3=$G(^DPT(IEN2,.312,IEN312,3))
 ..I $$EXPIRED^IBCNEDE2($P(IDATA0,U,4)) Q  ; Insurance policy has expired
 ..S ISSUB=$$PATISSUB^IBCNEHLU(IDATA0)
 ..; Patient is the subscriber
 ..I ISSUB,'$$CHK1 Q
 ..; Patient is the dependent
 ..I 'ISSUB,'$$CHK2(MWNRTYP) Q
 ..; check group number
 ..S GNUM=$P(RDATA1,U,7),GIEN=+$P(IDATA0,U,18),GOK=1
 ..; check non-Medicare group number
 ..I '+MWNRTYP D  Q:'GOK  ; Group number doesn't match
 ...I 'ONEPOL D
 ....I GIEN'>0 S GOK=0 Q
 ....S GNUM1=$P($G(^IBA(355.3,GIEN,0)),U,4)
 ....I GNUM=""!(GNUM1="")!(GNUM'=GNUM1) S GOK=0
 ....Q
 ...I ONEPOL D
 ....I GNUM'="",GIEN'="" S GNUM1=$P($G(^IBA(355.3,GIEN,0)),U,4) I GNUM1'="",GNUM'=GNUM1 S GOK=0
 ....Q
 ...Q
 ..; check for Medicare part A/B
 ..I +MWNRTYP D  Q:'GOK  ; Group number doesn't match
 ...I GIEN'>0 S GOK=0 Q
 ...S GDATA=$G(^IBA(355.3,GIEN,0))
 ...I $P(GDATA,U,14)="A" D
 ....I $P(MWNRTYP,U,2)="MA"!($P(MWNRTYP,U,2)="B") S MWNRA=IEN312 Q
 ....S GOK=0
 ....Q
 ...I $P(GDATA,U,14)="B" D
 ....I $P(MWNRTYP,U,2)="MB"!($P(MWNRTYP,U,2)="B") S MWNRB=IEN312 Q
 ....S GOK=0
 ....Q
 ...Q
 ..S RES=1_U_IEN2_U_$S(+MWNRTYP:MWNRA_U_MWNRB_U_1,1:IEN312_U_U_0)
 ..S $P(RES,U,6)=ISSUB
 ..Q
 .Q
 Q RES
 ;
CHK1() ; check auto-update criteria for patient who is the subscriber
 ; called from tag AUTOUPD, uses variables defined there
 ;
 ; returns 1 if givent policy satisfies auto-update criteria, returns 0 otherwise
 N RES
 S RES=0
 I $P(RDATA1,U,5)'=$P(IDATA0,U,2) G CHK1X  ; Subscriber ID doesn't match
 I $P(RDATA1,U,2)'=$P(IDATA3,U) G CHK1X  ; DOB doesn't match
 I '$$NAMECMP($P(RDATA1,U),$P(IDATA0,U,17)) G CHK1X  ; Insured's name doesn't match
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
 S ID=$P(RDATA1,U,5)
 I ID'=$P(IDATA0,U,2),ID'=$P(IDATA5,U) G CHK2X  ; both Subscriber ID and Patient ID don't match
 S DOB=$P(RDATA1,U,2),PDOB=$$GET1^DIQ(2,IENS,.03,"I")
 I DOB'=$P(IDATA3,U),DOB'=PDOB G CHK2X  ; both Subscriber and Patient DOB don't match
 S NAME=$P(RDATA1,U),PNAME=$$GET1^DIQ(2,IENS,.01)
 I '+MWNRTYP,'$$NAMECMP(NAME,$P(IDATA0,U,17)),'$$NAMECMP(NAME,PNAME) G CHK2X  ; non-Medicare, both Subscriber and Patient name don't match
 I +MWNRTYP,'$$NAMECMP(NAME,PNAME) G CHK2X  ; Medicare, Ptient name doesn't match
 S RES=1
CHK2X ;
 Q RES
 ;
PREL(CODE,EXCODE) ; convert pat. relationship to insured code to HIPAA
 ; CODE - code to convert
 ; EXCODE - existing VistA code either from 2.312/4.03 or 355.33/60.14
 N CSTR,RES
 S CSTR=".01.18.19." ; codes for self, spouse, and child
 S RES="" I $G(CODE)="" Q RES  ; nothing to convert
 I CODE="09" Q RES  ; code for "unknown" = no change
 I CODE="34" S:CSTR[("."_$G(EXCODE)_".") RES="G8" Q RES  ; G8 if existing code is self/spouse/child, no change otherwise
 S RES=$$PRELCNV^IBCNSP1(CODE,1)
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
EBFILE(DFN,IEN312,RIEN,AFLG) ; file eligibility/benefit data from file 365 into file 2.312
 ; DFN - file 2 ien
 ; IEN312 - file 2.312 ien
 ; RIEN - file 365 ien
 ; AFLG - 1 if called from autoupdate, 0 if called from ins. buffer process entry
 ; Returns "" on success, ERFLG on failure. Also called from ACCEPT^IBCNBAR for manual processing of ins. buffer entry.
 ;
 ;
 N DA,DIK,DATA,DATA1,EBIENS,ERFLG,ERROR,GIEN,GSKIP,IENROOT,IENS,IENSTR,TYPE,TYPE1,Z,Z1,Z2
 ; delete existing EB data
 S DIK="^DPT("_DFN_",.312,"_IEN312_",6,",DA(2)=DFN,DA(1)=IEN312
 S Z="" F  S Z=$O(^DPT(DFN,.312,IEN312,6,"B",Z)) Q:Z=""  S DA=$O(^DPT(DFN,.312,IEN312,6,"B",Z,"")) D ^DIK
 ; file new EB data
 S IENSTR=IEN312_","_DFN_","
 S GIEN=+$P($G(^DPT(DFN,.312,IEN312,0)),U,18)
 S Z="" F  S Z=$O(^IBCN(365,RIEN,2,"B",Z)) Q:Z=""!$G(ERFLG)  D
 .S EBIENS=$O(^IBCN(365,RIEN,2,"B",Z,""))_","_RIEN_","
 .; if filing Medicare Part A/B data, make sure we only file the correct EB group
 .S GSKIP=0 I GIEN>0 D
 ..S TYPE=$$GET1^DIQ(365.02,EBIENS,.05)
 ..S TYPE1=$P($G(^IBA(355.3,GIEN,0)),U,14)
 ..I TYPE="MA",TYPE1="B" S GSKIP=1
 ..I TYPE="MB",TYPE1="A" S GSKIP=1
 ..Q
 .I GSKIP Q  ; wrong Medicare Part A/B EB group - skip it
 .D GETS^DIQ(365.02,EBIENS,"**",,"DATA","ERROR") I $D(ERROR) D:AFLG WARN Q
 .; make sure we have data to file
 .I '$D(DATA(365.02)) Q
 .S IENS="+1,"_IENSTR,Z1=$O(DATA(365.02,"")) M DATA1(2.322,IENS)=DATA(365.02,Z1)
 .D UPDATE^DIE("E","DATA1","IENROOT","ERROR") I $D(ERROR) D:AFLG WARN Q
 .S IENS="+1,"_IENROOT(1)_","_IENSTR K DATA1,IENROOT
 .S Z2="" F  S Z2=$O(DATA(365.26,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3226,IENS)=DATA(365.26,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.27,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3227,IENS)=DATA(365.27,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.28,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3228,IENS)=DATA(365.28,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.29,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3229,IENS)=DATA(365.29,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.291,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.32291,IENS)=DATA(365.291,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN
 ..Q
 .K DATA
 .Q
 Q $G(ERFLG)
 ;
NAMECMP(NAME1,NAME2) ; check if 2 names have the same first name and last name components
 ; NAME1, NAME2 - names to compare, should be in "last,first [middle]" format
 ;
 ; returns 1 if both first name and last name are the same between two names, returns 0 otherwise
 N NM1,NM2,RES
 S RES=0
 S NM1=$$HLNAME^HLFNC(NAME1),NM2=$$HLNAME^HLFNC(NAME2)
 I $P(NM1,U)=$P(NM2,U),$P(NM1,U,2)=$P(NM2,U,2) S RES=1
 Q RES

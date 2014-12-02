IBCNEHL1 ;DAOU/ALA - HL7 Process Incoming RPI Messages ;26-JUN-2002
 ;;2.0;INTEGRATED BILLING;**300,345,416,444,438,497,506**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process incoming IIV response messages.
 ;  This includes updating the record in the IIV Response File,
 ;  updating the Buffer record (if there is one and creating a new
 ;  one if there isn't) with the appropriate Buffer Symbol and data
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
 ;              1 = + (auto-update requirement)
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
 .D SPAR^IBCNEHLU
 .S SEG=$G(IBSEG(1))
 .; check if we are inside G2O group of segments
 .I SEG="ZTY" S G2OFLG=1
 .I G2OFLG,SEG'="ZTY",SEG'="CTD" S G2OFLG=0
 .; If we are outside of Z_Benefit_group, kill EB multiple ien
 .; I +$G(EBDA),".MSH.MSA.PRD.PID.GT1.IN1.IN3."[("."_SEG_".")!('G2OFLG&(SEG="CTD")) K EBDA
 .;
 .Q:SEG="PRD"  ; IB*2*497  PRD segment is not processed
 .;
 .I SEG="MSA" D MSA^IBCNEHL2(.ERACT,.ERCON,.ERROR,.ERTXT,.IBSEG,MGRP,.RIEN,.TRACE) Q
 .;
 .;  Contact Segment
 .I SEG="CTD",'G2OFLG D CTD^IBCNEHL2(.ERROR,.IBSEG,RIEN) Q
 .;
 .;  Patient Segment
 .I SEG="PID" D PID^IBCNEHL2(.ERFLG,.ERROR,.IBSEG,RIEN) Q
 .;
 .;  Guarantor Segment
 .I SEG="GT1" D GT1^IBCNEHL2(.ERROR,.IBSEG,RIEN,.SUBID) Q
 .;
 .;  Insurance Segment
 .I SEG="IN1" D IN1^IBCNEHL2(.ERROR,.IBSEG,RIEN,SUBID) Q
 .;
 .;  Addt'l Insurance Segment
 .;I SEG="IN2" ; for future expansion, add IN2 tag to IBCNEHL2
 .;
 .;  Addt'l Insurance - Cert Segment
 .I SEG="IN3" D IN3^IBCNEHL2(.ERROR,.IBSEG,RIEN) Q 
 .;
 .; IB*2*497 GROUP LEVEL REFERENCE ID segment (x12 loops 2100C and 2100D)
 . I SEG="ZRF",'$D(EBDA) D GZRF^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 .;
 .;  Eligibility/Benefit Segment
 .I SEG="ZEB" D ZEB^IBCNEHL2(.EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Healthcare Delivery Segment
 .I SEG="ZHS" D ZHS^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Benefit level Reference ID Segment  (X12 loops 2110C and 2110D)
 .I SEG="ZRF",+$G(EBDA) D ZRF^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q  ;IB*2*497 add check to make sure z benefit group
 .;
 .; Subscriber Date Segment
 .I SEG="ZSD" D ZSD^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Subscriber Additional Info Segment
 .I SEG="ZII" D ZII^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Benefit Related Entity Segment
 .I SEG="ZTY" D ZTY^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Benefit Related Entity Contact Segment
 .I SEG="CTD",G2OFLG D G2OCTD^IBCNEHL4(EBDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Benefit Related Entity Notes Segment
 .I SEG="NTE",+$G(EBDA) D EBNTE^IBCNEHL2(EBDA,.IBSEG,RIEN) Q
 .;
 .; Reject Reasons Segment
 .I SEG="ERR" K ERDA D ERR^IBCNEHL4(.ERDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Notes Segment
 .I SEG="NTE",'$D(EBDA),+$G(ERDA) D NTE^IBCNEHL4(ERDA,.ERROR,.IBSEG,RIEN) Q
 .;
 .; Subscriber date segment (subscriber level)
 .I SEG="ZTP" D ZTP^IBCNEHL4(.ERROR,.IBSEG,RIEN) Q
 . ; ib*2*497  -  add processing for ROL, DG1, and ZMP segments
 . ; Provider Code segment 
 . I SEG="ROL" D ROL^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 . ;
 . ; Health Care Diagnosis Code segment
 . I SEG="DG1" D DG1^IBCNEHL5(.ERROR,.IBSEG,RIEN) Q
 .;
 .; Military Personnel Information segment
 . I SEG="ZMP" D ZMP^IBCNEHL5(.ERROR,.IBSEG,RIEN)
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
 N BUFF,DATA,ERROR,IENS,PREL,RDATA0,RDATA1,RDATA5,RDATA13,RSTYPE,TQN,TSTAMP,MIL,OKAY   ; IB*2.0*497 (vd)
 ;
 Q:$G(RIEN)=""
 S TSTAMP=$$NOW^XLFDT(),IENS=IEN312_","_DFN_","
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1)),RDATA5=$G(^IBCN(365,RIEN,5))
 S RDATA13=$G(^IBCN(365,RIEN,13))         ; IB*2.0*497 (vd)
 S TQN=$P(RDATA0,U,5),RSTYPE=$P(RDATA0,U,10)
 I ISSUB S DATA(2.312,IENS,7.01)=$P(RDATA13,U) ; name     - IB*2.0*497 (vd)
 S DATA(2.312,IENS,3.01)=$P(RDATA1,U,2) ; dob
 S DATA(2.312,IENS,3.05)=$P(RDATA1,U,3) ; ssn
 I ISSUB,$P(RDATA1,U,8)'="" S DATA(2.312,IENS,6)=$P(RDATA1,U,8) ; whose insurance
 ; pt. relationship (365,8.01) IB*2*497 code from 365,8.01 needs evaluation and possible conversion
 S PREL=$$GET1^DIQ(365,RIEN,8.01) I ISSUB,PREL'="" S DATA(2.312,IENS,4.03)=$$PREL^IBCNEHLU(2.312,4.03,PREL)
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
 S DATA(2.312,IENS,3.13)=$P(RDATA5,U,6) ; country
 S DATA(2.312,IENS,3.14)=$P(RDATA5,U,7) ; country subdivision
 ;
 L +^DPT(DFN,.312,IEN312):15 I '$T D LCKERR^IBCNEHL3 D FIL Q
 D FILE^DIE("ET","DATA","ERROR") I $D(ERROR) D WARN^IBCNEHL3 K ERROR D FIL G AUTOFILX
 ;
 ; set eIV auto-update field separately because of the trigger on field 1.05
 K DATA S DATA(2.312,IENS,4.04)="YES" D FILE^DIE("ET","DATA","ERROR") I $D(ERROR) D WARN^IBCNEHL3 G AUTOFILX
 S ERFLG=$$GRPFILE(DFN,IEN312,RIEN,1) I $G(ERFLG) G AUTOFILX  ;IB*2*497  file data at 2.312, 9, 10 and 11 subfiles; if error is produced update buffer entry and then quit processing
 ; file new EB data
 S ERFLG=$$EBFILE(DFN,IEN312,RIEN,1)
 ; bail out if something went wrong during filing of EB data
 I $G(ERFLG) G AUTOFILX
 ; update insurance record ien in transmission queue
 D UPDIREC^IBCNEHL3(RIEN,IEN312)
 ;  For an original response, set the Transmission Queue Status to 'Response Received' &
 ;  update remaining retries to comm failure (5)
 I $G(RSTYPE)="O" D SST^IBCNEUT2(TQN,3),RSTA^IBCNEUT7(TQN)
 ; update buffer file entry so only stub remains and status is changed
 S BUFF=+$P($G(^IBCN(365,RIEN,0)),U,4)
 I BUFF D
 .D STATUS^IBCNBEE(BUFF,"A",0,0,0) ; update buffer entry's status to accepted
 .D DELDATA^IBCNBED(BUFF) ; delete buffer's insurance/patient data
 .Q
AUTOFILX ;
 L -^DPT(DFN,.312,IEN312)
 Q
 ;
GRPFILE(DFN,IEN312,RIEN,AFLG) ;  ib*2*497  file data at node 12 and at subfiles 2.312,9, 10 and 11
 ; DFN - file 2 ien
 ; IEN312 - file 2.312 ien
 ; RIEN = file 365 ien
 ; AFLG - 1 if called from autoupdate, 0 if called from ins. buffer process entry
 ; output - returns 0 or 1
 ;          0 - entry update received an error when attempting to file
 ;          1 - successful update
 N DA,Z,Z2,DATA12,IENS,IENS365,IENS312,REF,PROV,DIAG,REF3129,PROV332,DIAG3121,NODE,ERROR,ERFLG
 ; retrieve external values of data located at node 12 of 365
 S IENS=IEN312_","_DFN_","
 D GETS^DIQ(365,RIEN,"12.01:12.07",,"MIL")
 M DATA12(2.312,IENS)=MIL(365,RIEN_",")
 D FILE^DIE("ET","DATA12","ERROR") I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
 ; remove existing sub-file entries at nodes 9, 10, and 11 before update of new data
 F NODE="9","10","11" D
 . S DIK="^DPT("_DFN_",.312,"_IEN312_","_NODE_",",DA(2)=DFN,DA(1)=IEN312
 . S DA=0 F  S DA=$O(^DPT(DFN,.312,IEN312,NODE,DA)) Q:DA=""!(DA?1.A)  D ^DIK
 S IENS312="+1,"_IEN312_","_DFN_","
 ; update node 9 data
 S Z="" F  S Z=$O(^IBCN(365,RIEN,9,"B",Z)) Q:'Z  D
 . S IENS365=$O(^IBCN(365,RIEN,9,"B",Z,""))_","_RIEN_","
 . D GETS^DIQ(365.09,IENS365,"*",,"REF")
 S Z2="" F  S Z2=$O(REF(365.09,Z2)) Q:Z2=""  M REF3129(2.3129,IENS312)=REF(365.09,Z2) D UPDATE^DIE("E","REF3129",,"ERROR") K REF3129 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
 ; update node 10 data
 S Z="" F  S Z=$O(^IBCN(365,RIEN,10,"B",Z)) Q:'Z  D
 . S IENS365=$O(^IBCN(365,RIEN,10,"B",Z,""))_","_RIEN_","
 . D GETS^DIQ(365.04,IENS365,"*",,"PROV")
 S Z2="" F  S Z2=$O(PROV(365.04,Z2)) Q:Z2=""  M PROV332(2.332,IENS312)=PROV(365.04,Z2) D UPDATE^DIE("E","PROV332",,"ERROR") K PROV332 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
 ; update node 11 data
 S Z="" F  S Z=$O(^IBCN(365,RIEN,11,"B",Z)) Q:'Z  D
 . S IENS365=$O(^IBCN(365,RIEN,11,"B",Z,""))_","_RIEN_","
 . D GETS^DIQ(365.01,IENS365,"*",,"DIAG")
 S Z2="" F  S Z2=$O(DIAG(365.01,Z2)) Q:Z2=""  M DIAG3121(2.31211,IENS312)=DIAG(365.01,Z2) D UPDATE^DIE("E","DIAG3121",,"ERROR") K DIAG3121 I $D(ERROR) D:AFLG WARN^IBCNEHL3 K ERROR
GRPFILEX ;
 Q $G(ERFLG)
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
 I $G(ERACT)'=""!($G(ERTXT)'="") S ERACT=$$ERRACT^IBCNEHLU(RIEN),ERCON=$P(ERACT,U,2),ERACT=$P(ERACT,U) D ERROR^IBCNEHL3(TQN,ERACT,ERCON,TRACE) G FILX
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
AUTOUPD(RIEN) ;
 ; Returns "1^file 2 ien^file 2.312 ien^2nd file 2.312 ien^Medicare flag^subscriber flag", if entry
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
 N APPIEN,GDATA,GIEN,GNAME,GNUM,GNUM1,GOK,IEN2,IEN312,IEN36,IDATA0,IDATA3,ISSUB,MWNRA,MWNRB,MWNRIEN,MWNRTYP
 N ONEPOL,PIEN,RDATA0,RDATA1,RES,TQIEN,IDATA7,RDATA13,RDATA14   ; IB*2.0*497
 S RES=0
 I +$G(RIEN)'>0 Q RES  ; invalid ien for file 365
 I $G(IIVSTAT)'=1 Q RES ; only auto-update 'active policy' responses
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1))
 S RDATA13=$G(^IBCN(365,RIEN,13)),RDATA14=$G(^IBCN(365,RIEN,14))   ; IB*2.0*497  longer fields for GROUP NAME, GROUP NUMBER, NAME OF INSURED, and SUBSCRIBER ID
 S PIEN=$P(RDATA0,U,3) I +PIEN>0 S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 I +$G(APPIEN)'>0 Q RES  ; couldn't find eIV application entry
 ; Check dictionary 365.1 MANUAL REQUEST DATE/TIME Flag, Quit if Set.
 I $P(RDATA0,U,5)'="",$P($G(^IBCN(365.1,$P(RDATA0,U,5),3)),U,1)'="" Q RES
 I $P(^IBE(365.12,PIEN,1,APPIEN,0),U,7)=0 Q RES  ; auto-accept is OFF
 S IEN2=$P(RDATA0,U,2) I +IEN2'>0 Q RES  ; couldn't find patient
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25),MWNRTYP=0,(MWNRA,MWNRB)=""
 I PIEN=MWNRIEN S MWNRTYP=$$ISMCR^IBCNEHLU(RIEN)
 S ONEPOL=$$ONEPOL^IBCNEHLU(PIEN,IEN2)
 ; try to find a matching pat. insurance
 S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""!(RES>0)  D
 .S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""!(RES>0&('+MWNRTYP))  D
 ..S IDATA0=$G(^DPT(IEN2,.312,IEN312,0)),IDATA3=$G(^DPT(IEN2,.312,IEN312,3))
 ..S IDATA7=$G(^DPT(IEN2,.312,IEN312,7))   ; IB*2.0*497 (vd)
 ..I $$EXPIRED^IBCNEDE2($P(IDATA0,U,4)) Q  ; Insurance policy has expired
 ..S ISSUB=$$PATISSUB^IBCNEHLU(IDATA0)
 ..; Patient is the subscriber
 ..I ISSUB,'$$CHK1^IBCNEHL3 Q
 ..; Patient is the dependent
 ..I 'ISSUB,'$$CHK2^IBCNEHL3(MWNRTYP) Q
 ..; check group number
 ..S GNUM=$P(RDATA14,U,2),GIEN=+$P(IDATA0,U,18),GOK=1  ;IB*2*497  group number needs to be retrieved from new field
 ..; check non-Medicare group number
 ..I '+MWNRTYP D  Q:'GOK  ; Group number doesn't match
 ...I 'ONEPOL D
 ....I GIEN'>0 S GOK=0 Q
 ....S GNUM1=$P($G(^IBA(355.3,GIEN,2)),U,2)    ; IB*2.0*497 (vd)
 ....I GNUM=""!(GNUM1="")!(GNUM'=GNUM1) S GOK=0
 ....Q
 ...I ONEPOL D
 ....I GNUM'="",GIEN'="" S GNUM1=$P($G(^IBA(355.3,GIEN,2)),U,2) I GNUM1'="",GNUM'=GNUM1 S GOK=0  ; IB*2.0*497 (vd)
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
 S DA=0 F  S DA=$O(^DPT(DFN,.312,IEN312,6,DA)) Q:DA=""!(DA?1.A)  D ^DIK
 ;
 ; /IB*2.0*506 Beginning
 ; File the new Requested Service Date field (file #2.312,8.01) from the file #365,1.1 field,
 ; if the Service Date is not present, then use the Eligibility Date which would be from the file #365,1.11 field
 ; ALSO, file the new Requested Service Type field (file #2.312,8.02) from the file #365.02,.04 field.
 N DIE,DR,NODE0,RSRVDT,RSTYPE,TQIEN
 S TQIEN=$P($G(^IBCN(365,RIEN,0)),U,5),NODE0=$G(^IBCN(365.1,TQIEN,0)),RSTYPE=$P(NODE0,U,20)
 S RSRVDT=$P($G(^IBCN(365,RIEN,1)),U,10) I RSRVDT="" S RSRVDT=$P(NODE0,U,12)
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN,DA=IEN312,DR="8.01///"_RSRVDT_";8.02///"_RSTYPE
 D ^DIE
 ; /IB*2.0*506 End
 ;
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
 .D GETS^DIQ(365.02,EBIENS,"**",,"DATA","ERROR") I $D(ERROR) D:AFLG WARN^IBCNEHL3 Q
 .; make sure we have data to file
 .I '$D(DATA(365.02)) Q
 .S IENS="+1,"_IENSTR,Z1=$O(DATA(365.02,"")) M DATA1(2.322,IENS)=DATA(365.02,Z1)
 .D UPDATE^DIE("E","DATA1","IENROOT","ERROR") I $D(ERROR) D:AFLG WARN^IBCNEHL3 Q
 .S IENS="+1,"_IENROOT(1)_","_IENSTR K DATA1,IENROOT
 .S Z2="" F  S Z2=$O(DATA(365.26,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3226,IENS)=DATA(365.26,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.27,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3227,IENS)=DATA(365.27,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.28,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3228,IENS)=DATA(365.28,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.29,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.3229,IENS)=DATA(365.29,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.291,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.32291,IENS)=DATA(365.291,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .S Z2="" F  S Z2=$O(DATA(365.292,Z2)) Q:Z2=""!$G(ERFLG)  D
 ..M DATA1(2.32292,IENS)=DATA(365.292,Z2) D UPDATE^DIE("E","DATA1",,"ERROR") K DATA1 I $D(ERROR) D:AFLG WARN^IBCNEHL3
 ..Q
 .K DATA
 .Q
 Q $G(ERFLG)
 ;

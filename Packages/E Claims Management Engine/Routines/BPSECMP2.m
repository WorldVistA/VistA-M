BPSECMP2 ;BHAM ISC/FCS/DRS - Parse Claim Response ;11/14/07  13:23
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,6,7,8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Reference to STORESP^IBNCPDP supported by DBIA 4299
 ;Reference to ^DPT supported by DBIA 10035
 ;Reference to $$SITE^VASITE supported by DBIA 10112
 ;
 Q
 ; Parameters:
 ;    CLAIMIEN: IEN from BPS Claims
 ;    RESPIEN:  IEN from BPS Response
 ;    EVENT:    This is used by PSO to create specific events (BILL).
 ;    USER:     User who is creating the event.  This is required when EVENT is sent.
IBSEND(CLAIMIEN,RESPIEN,EVENT,USER) ;
 N BPSARRY,RXIEN,FILLNUM,IND,TRNDX
 N CLAIMNFO,RESPNFO,RXINFO,RFINFO,TRANINFO
 N RESPONSE,RXACT,CLREAS,BILLNUM,DFN,REQCLAIM
 N DIE,DA,DR,AMT
 ;
 ; Quit if there is not a Response or Claim IEN
 I '$G(RESPIEN) Q
 I '$G(CLAIMIEN) Q
 ;
 ; Get Claims and Response Data
 D GETS^DIQ("9002313.02",CLAIMIEN,"103;400*;401;402;403;430","","CLAIMNFO")
 D GETS^DIQ("9002313.0301","1,"_RESPIEN,"112;503;505;506;507;509;518","I","RESPNFO")
 ;
 ; Get the Transaction IEN and Data
 S IND=$S(CLAIMNFO("9002313.02",CLAIMIEN_",","103")="B2":"AER",1:"AE")
 S TRNDX=$O(^BPST(IND,CLAIMIEN,""))
 I TRNDX="" Q
 D GETS^DIQ("9002313.59",TRNDX,"1.05;3;5;13;404;509;510;1201","I","TRANINFO")
 ;
 ; If Certify Mode is On, don't send to IB
 I $$GET1^DIQ(9002313.59902,"1,"_TRNDX_",","902.22")["MODE ON" Q
 ;
 ; Get Patient
 S DFN=TRANINFO("9002313.59",TRNDX_",",5,"I")
 ;
 ; Get Policy, Plan ID and Rate Type
 S BPSARRY("POLICY")=TRANINFO("9002313.59",TRNDX_",",1.05,"I")
 I $D(^BPST(TRNDX,10,1,0)) D
 . S BPSARRY("PLAN")=$P(^BPST(TRNDX,10,1,0),U)
 . S BPSARRY("RTYPE")=$P(^BPST(TRNDX,10,1,0),U,8)
 ;
 ; Store RXACT into a local variable as it is will be used a lot
 S RXACT=TRANINFO("9002313.59",TRNDX_",",1201,"I")
 ;
 ; Setup User data
 ; If event is passed in, the user should be passed in as well
 ; If no Event, but action is Auto-Reversal (AREV) or CMOP
 ;   processing (CR*/PC), use postmaster (.5)
 ; Else use the user from BPS Transaction
 I EVENT]"" S BPSARRY("USER")=USER
 E  I ",AREV,CRLB,CRLX,CRLR,CRRL,PC,"[(","_RXACT_",") S BPSARRY("USER")=.5
 E  S BPSARRY("USER")=TRANINFO("9002313.59",TRNDX_",",13,"I")
 ;
 ; Send eligibility response to IB
 I RXACT="ELIG" D  Q
 . S BPSARRY("STATUS")=RXACT
 . S BPSARRY("RESPIEN")=RESPIEN
 . S BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 ;
 ; Determine Prescription IEN
 S RXIEN=$P(^BPSC(CLAIMIEN,400,1,0),"^",5)
 ;
 ; If no RX record, this was a certification test so don't send to IB
 I $$RXAPI1^BPSUTIL1(RXIEN,.01)="" Q
 ;
 ; Determine Payer Response
 ; Treat Duplicate of Accepted Reversal ("S") as accepted
 S RESPONSE=RESPNFO(9002313.0301,"1,"_RESPIEN_",",112,"I")
 S RESPONSE=$S(RESPONSE="A":"ACCEPTED",RESPONSE="C":"CAPTURED",RESPONSE="D":"DUPLICATE",RESPONSE="P":"PAYABLE",RESPONSE="R":"REJECTED",RESPONSE="S":"ACCEPTED",1:"OTHER")
 ;
 ; Get Prescription Information
 D RXAPI^BPSUTIL1(RXIEN,".01;4;6;7;8;16;27","RXINFO","IE")
 ;
 ; Get Refill Info if this is a refill
 S FILLNUM=+$E($P(TRNDX,".",2),1,4)
 I FILLNUM>0 D RXSUBF^BPSUTIL1(RXIEN,52,52.1,FILLNUM,".01;1;1.1;11","RFINFO","E")
 ;
 ; Date of Service
 S BPSARRY("DOS")=CLAIMNFO("9002313.02",CLAIMIEN_",","401")
 I BPSARRY("DOS") S BPSARRY("DOS")=BPSARRY("DOS")-17000000
 ;
 ; Information needed for PAID/BILLING event
 S BPSARRY("PAID")=0
 I RESPONSE="PAYABLE"!(RESPONSE="DUPLICATE") D
 . ; Patient Pay Amount
 . S AMT=$G(RESPNFO(9002313.0301,"1,"_RESPIEN_",",505,"I"))
 . I AMT S BPSARRY("PAT RESP")=$$DFF2EXT^BPSECFM(AMT)
 . ; Ingredient Cost Paid
 . S AMT=$G(RESPNFO(9002313.0301,"1,"_RESPIEN_",",506,"I"))
 . I AMT S BPSARRY("ING COST PAID")=$$DFF2EXT^BPSECFM(AMT)
 . ; Dispensing Fee Paid
 . S AMT=$G(RESPNFO(9002313.0301,"1,"_RESPIEN_",",507,"I"))
 . I AMT S BPSARRY("DISP FEE PAID")=$$DFF2EXT^BPSECFM(AMT)
 . ; Total Amount Paid
 . S BPSARRY("PAID")=$$DFF2EXT^BPSECFM(RESPNFO(9002313.0301,"1,"_RESPIEN_",",509,"I"))
 . ; Amount of Copay
 . S AMT=$G(RESPNFO(9002313.0301,"1,"_RESPIEN_",",518,"I"))
 . I AMT S BPSARRY("COPAY")=$$DFF2EXT^BPSECFM(AMT)
 . ;
 . S BPSARRY("AUTH #")=RESPNFO(9002313.0301,"1,"_RESPIEN_",",503,"I")
 . S BPSARRY("RX NO")=RXINFO(52,RXIEN,.01,"E")
 . S BPSARRY("DRUG")=$$RXAPI1^BPSUTIL1(RXIEN,6,"I")
 . I FILLNUM<1 S BPSARRY("DAYS SUPPLY")=RXINFO(52,RXIEN,8,"E")
 . E  S BPSARRY("DAYS SUPPLY")=$G(RFINFO(52.1,FILLNUM,1.1,"E"))
 . ; Billing Quantity and Units
 . S BPSARRY("QTY")=$G(TRANINFO("9002313.59",TRNDX_",",509,"I"))
 . S BPSARRY("UNITS")=$G(TRANINFO("9002313.59",TRNDX_",",510,"I"))
 . ; NCPDP Quantity and Units
 . S BPSARRY("NCPDP QTY")=$P(CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","442"),"E7",2)/1000
 . S BPSARRY("NCPDP UNITS")=$P(CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","600"),"28",2)
 ;
 ; Get primary IB bill# and prior payment amount
 I $D(^BPST(TRNDX,10,1,2)) D
 . S BPSARRY("PRIMARY BILL")=$P(^BPST(TRNDX,10,1,2),U,8)
 . S BPSARRY("PRIOR PAYMENT")=$P(^BPST(TRNDX,10,1,2),U,9)
 ;
 ; Setup miscellaneous values
 S BPSARRY("RXCOB")=$$COB59^BPSUTIL2(TRNDX)
 S BPSARRY("NDC")=$$GETNDC^PSONDCUT(RXIEN,FILLNUM)
 S BPSARRY("FILL NUMBER")=FILLNUM
 S BPSARRY("FILLED BY")=RXINFO(52,RXIEN,16,"I")
 S BPSARRY("PRESCRIPTION")=RXIEN
 S BPSARRY("BILLED")=$P(CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","430"),"DU",2)
 S BPSARRY("BILLED")=$$DFF2EXT^BPSECFM(BPSARRY("BILLED"))
 S BPSARRY("CLAIMID")=$P(CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","402"),"D2",2)
 S BPSARRY("RELEASE DATE")=$S(FILLNUM=0:$$RXAPI1^BPSUTIL1(RXIEN,31,"I"),1:$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,FILLNUM,17,"I"))
 S BPSARRY("RESPONSE")=RESPONSE
 S BPSARRY("EPHARM")=$$GET1^DIQ(9002313.59,TRNDX,1.07,"I")
 ;
 ; For reversals, get reversal reason and check for closed reason
 ; Call IB with Reversal Event
 ; If there is a close reason, call IB with CLOSE event
 ;    and update BPS Claim with close information
 I EVENT="",$$ISREVERS^BPSOSU(CLAIMIEN) D  Q
 . S REQCLAIM=TRANINFO("9002313.59",TRNDX_",",3,"I")
 . S BPSARRY("REVERSAL REASON")=TRANINFO("9002313.59",TRNDX_",",404,"I")
 . S BPSARRY("RTS-DEL")=0
 . ; Get RX action, which determine close event
 . I RXACT="RS" S CLREAS="PRESCRIPTION NOT RELEASED",BPSARRY("RTS-DEL")=1
 . I RXACT="DE" D
 . . S CLREAS="PRESCRIPTION DELETED",BPSARRY("RTS-DEL")=1
 . . ; check whether RX was in fact deleted in Pharmacy
 . . ; if not then the refill was deleted
 . . I $$RXSTATUS^BPSSCRU2(RXIEN)'=13 S BPSARRY("CLOSE COMMENT")="DELETION OF REFILL ONLY - ORIGINAL RX MAY REMAIN ACTIVE"
 . ; If accepted inpatient autoreversal, then close the claim
 . I RXACT="AREV",RESPONSE="ACCEPTED",REQCLAIM,$P($G(^BPSC(REQCLAIM,0)),U,7)=2 D
 .. S CLREAS="INPATIENT RX AUTO-REVERSAL",BPSARRY("CLOSE COMMENT")="INPATIENT PRESCRIPTION"
 . I $D(CLREAS) S BPSARRY("CLOSE REASON")=$O(^IBE(356.8,"B",CLREAS,0))
 . ;
 . ; Call IB for Reversal Event
 . S BPSARRY("STATUS")="REVERSED",BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 . ; If there is no close reason, quit
 . I '$D(BPSARRY("CLOSE REASON")) Q
 . ; Call IB for CLOSE event
 . ;  Note for close, user is always postmaster (.5)
 . S BPSARRY("STATUS")="CLOSED",BPSARRY("USER")=.5
 . S BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 . ;
 . ; Populate the original claim request with the close reason
 . I REQCLAIM D
 .. S DIE="^BPSC(",DA=REQCLAIM
 .. S DR="901///1;902///"_$$NOW^XLFDT()_";903////.5;904///"_BPSARRY("CLOSE REASON")
 .. D ^DIE
 . ; If this is a primary claim, check and send a bulletin if the secondary claim is open or if there
 . ;   is a non-cancelled IB bill for the secondary claim
 . ; NOTE that we only want to do a bulletin for an Inpatient Auto-Reversal or an RX action.  If the code 
 . ;   above is modified to create other automatic close events, additional checks may need to be added
 . ;   before creating the bulletin.
 . I BPSARRY("RXCOB")=1 D BULL(RXIEN,FILLNUM,CLAIMIEN,DFN,CLREAS,BPSARRY("CLAIMID"))
 ;
 ; If we got here, then it is not a reversal
 ; If EVENT is set, send Submit event
 I EVENT="" S BPSARRY("STATUS")="SUBMITTED",BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 ;
 ; Sent Paid (Billable) event is the claim was paid and released or EVENT is BILL
 ;   Note: User is always postmaster except for BackBilling (BB)
 I EVENT="BILL"!(RESPONSE="PAYABLE"!(RESPONSE="DUPLICATE")&(BPSARRY("RELEASE DATE")]"")) D
 . I RXACT'="BB" S BPSARRY("USER")=.5
 . ;set reject flag and store primary plan to serve secondary billing when primary claim was rejected
 . I BPSARRY("RXCOB")=2 I $P($$STATUS^BPSOSRX(RXIEN,FILLNUM,,,1),U)["E REJECTED" D
 . . N REJS
 . . S BPSARRY("PRIMREJ")=1,BPSARRY("PRIMPLAN")=$P(^BPST(+$$IEN59^BPSOSRX(RXIEN,FILLNUM,1),10,1,0),U)
 . . D DUR1^BPSNCPD3(RXIEN,FILLNUM,.REJS,"",1)
 . . S BPSARRY("REJ CODE LST")=$G(REJS(1,"REJ CODE LST"))
 . . M BPSARRY("REJ CODES")=REJS(1,"REJ CODES")
 . ;
 . S BPSARRY("STATUS")="PAID",BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 Q
 ;
BULL(RX,FILL,CLAIMIEN,DFN,REASON,ECME) ;
 ; Create bulletin to tell OPECC to reverse/close secondary claim
 ; Input Parameters
 ;   RX - Prescription IEN (required)
 ;   FILL - Fill Number (required)
 ;   CLAIMIEN - BPS Claims IEN for the primary reversal
 ;   DFN - Patient IEN
 ;   REASON - Close Reason
 ;   ECME - ECME Number 
 ;
 ; Validate parameters
 I '$G(RX) Q
 I $G(FILL)="" Q
 ;
 ; Check to see a bulletin needs to be created
 I '$$SENDBULL(RX,FILL) Q
 ;
 N STATION,PRICLAIM,PRIBILL,SECBILL,BPSBILLS,PATNAME,SSN,DOS
 N BPSL,BPSX,XMSUB,XMDUZ,XMY,XMTEXT
 ;
 ; Get Station and Primary claim ID
 S STATION=$P($$SITE^VASITE(),U,3) ;IA 10112
 S PRICLAIM=$$GET1^DIQ(9002313.02,$G(CLAIMIEN)_",",.01)
 ;
 ; Get primary and secondary bill number
 ; If the bill exists, concatenate the Station number
 I $$RXBILL^IBNCPUT3(RX,FILL,"P","",.BPSBILLS)
 S PRIBILL=$O(BPSBILLS(""),-1) I PRIBILL S PRIBILL=STATION_"-"_$P(BPSBILLS(PRIBILL),U,1)_" "
 K BPSBILLS
 I $$RXBILL^IBNCPUT3(RX,FILL,"S","",.BPSBILLS)
 S SECBILL=$O(BPSBILLS(""),-1) I SECBILL S SECBILL=STATION_"-"_$P(BPSBILLS(SECBILL),U,1)_" "
 ;
 ; Get Patient Name and last four digits of the SSN - Supported by IA 10035
 I $G(DFN) D
 . S PATNAME=$P($G(^DPT(DFN,0)),U,1)
 . S SSN=$P($G(^DPT(DFN,0)),U,9)
 . S SSN=$E(SSN,$L(SSN)-3,$L(SSN))
 ;
 ; Get DOS in the correct format
 S DOS=$$GET1^DIQ(9002313.02,$G(CLAIMIEN)_",",401)
 I DOS S DOS=$E(DOS,5,6)_"/"_$E(DOS,7,8)_"/"_$E(DOS,1,4)
 ;
 ; Build Body of message
 S BPSL=0
 S BPSL=BPSL+1,BPSX(BPSL)="Primary claim "_PRIBILL_"(ECME #:"_$G(ECME)_") was closed for the following"
 S BPSL=BPSL+1,BPSX(BPSL)="reason: "_$G(REASON)
 S BPSL=BPSL+1,BPSX(BPSL)="Secondary claim "_SECBILL_"must be manually closed at this time."
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 S BPSL=BPSL+1,BPSX(BPSL)="Patient Name: "_$G(PATNAME)_" ("_$G(SSN)_")"
 S BPSL=BPSL+1,BPSX(BPSL)="Prescription: "_$$RXAPI1^BPSUTIL1(RX,.01,"E")_" Fill: "_FILL
 S BPSL=BPSL+1,BPSX(BPSL)="Drug Name: "_$$RXAPI1^BPSUTIL1(RX,6,"E")
 S BPSL=BPSL+1,BPSX(BPSL)="Date of Service: "_DOS
 S BPSL=BPSL+1,BPSX(BPSL)="Primary Claim #: "_PRICLAIM
 S BPSL=BPSL+1,BPSX(BPSL)="Close Reason (Reason Not Billable): "_$G(REASON)
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 S BPSL=BPSL+1,BPSX(BPSL)="Note: Depending how the secondary prescription claim was submitted,"
 S BPSL=BPSL+1,BPSX(BPSL)="this may require using the ECME User Screen to reverse the payable"
 S BPSL=BPSL+1,BPSX(BPSL)="secondary claim or using the correct VistA option to close the paper"
 S BPSL=BPSL+1,BPSX(BPSL)="secondary claim."
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 ;
 ; Set variables needed by Mail routines - subject, from, to, body
 S XMSUB="ACTION: Close Secondary claim for ECME "_$G(ECME)
 S XMDUZ="BPS PACKAGE",XMY("G.BPS OPECC")="",XMTEXT="BPSX("
 D ^XMD
 Q 
 ;
SENDBULL(RX,FILL) ;
 ; Check if a bulletin should be created, which we want to do if:
 ;   > There is a non-cancelled IB bill for the secondary claim
 ;   > There is a open ECME secondary claim
 ; 
 ; Input Parameters
 ;   RX - Prescription IEN (required)
 ;   FILL - Fill Number (required)
 ; Output
 ;   0 - Do not create the bulletin
 ;   1 - Create bulletin
 ;
 ; Validate parameters
 I '$G(RX) Q 0
 I $G(FILL)="" Q 0
 ;
 ; If the secondary claim has a non-cancelled bill, create the bulletin
 ; This could be true even if there is not a secondary claim in ePharmacy (e.g., for a paper claim)
 N BPSBILLS,BILL,ACTIVE,IB
 I $$RXBILL^IBNCPUT3(RX,FILL,"S","",.BPSBILLS)
 ; Loop through the bills and set ACTIVE flag if any of the bills are not cancelled
 S (BILL,ACTIVE)=0 F  S BILL=$O(BPSBILLS(BILL)) Q:'BILL!ACTIVE  D
 . S IB=$G(BPSBILLS(BILL))
 . I $P(IB,U,8)'=7,($P(IB,U,2)'="CB"),($P(IB,U,2)'="CN") S ACTIVE=1
 I ACTIVE Q 1
 ;
 ; Do not create the bulletin if the secondary transaction or claim does not exist
 N IEN59SEC,CLAIM
 S IEN59SEC=$$IEN59^BPSOSRX(RX,FILL,2)
 I 'IEN59SEC Q 0
 S CLAIM=$P($G(^BPST(IEN59SEC,0)),U,4)
 I 'CLAIM Q 0
 I '$D(^BPSC(CLAIM)) Q 0
 ;
 ; Return 1 if the secondary claim is open, 0 if it is closed
 Q '$$CLOSED02^BPSSCR03(CLAIM)
 ;
DURSYNC(IEN59) ;
 ; Synch DURs between ECME and PSO
 ; Parameters:
 ;   IEN59 is the BPS Transaction IEN
 N RXIEN,RXFILL
 ;
 ; Check Parameter
 I IEN59="" Q
 ;
 ; Get Prescription and Fill number
 S RXIEN=$$GET1^DIQ(9002313.59,IEN59_",",1.11,"I")
 S RXFILL=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",",902.17,"E")
 I RXIEN=""!(RXFILL="") Q
 ;
 ; Call PSO to sync reject codes
 D SYNC^PSOREJUT(RXIEN,RXFILL,"",$$COB59^BPSUTIL2(IEN59))
 Q
 ;
 ; Process Other Paid Amount Grouping from the Pricing Segment
 ; Note that FDATA, TRANSACT, FDAIEN, and FDAIEN03 are newed
 ;   and initialized by BPSECMPS
PROCOTH ;
 Q:$G(FDATA(TRANSACT,563))=""
 N NNDX,FILE,ROOT,FDATA3,FLDNUM
 S FILE="9002313.1401"
 S ROOT="FDATA3(9002313.1401)"
 S NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,564,NNDX)) Q:NNDX=""  D
 .S FLDNUM=.01 D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",NNDX,ROOT)
 .F FLDNUM=564,565 I $D(FDATA(TRANSACT,FLDNUM,NNDX)) D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",$G(FDATA(TRANSACT,FLDNUM,NNDX)),ROOT)
 D UPDATE^DIE("S","FDATA3(9002313.1401)")
 Q
 ;
 ; Process the Benefits Stage fields from the Pricing Segment
 ; Note that FDATA, TRANSACT, FDAIEN, and FDAIEN03 are newed
 ;   and initialized by BPSECMPS
PROCBEN ;
 Q:$G(FDATA(TRANSACT,392))=""
 N NNDX,FILE,ROOT,FDATA3,FLDNUM
 S FILE="9002313.039201"
 S ROOT="FDATA3(9002313.039201)"
 S NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,393,NNDX)) Q:NNDX=""  D
 .S FLDNUM=.01 D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",NNDX,ROOT)
 .F FLDNUM=393,394 I $D(FDATA(TRANSACT,FLDNUM,NNDX)) D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",$G(FDATA(TRANSACT,FLDNUM,NNDX)),ROOT)
 D UPDATE^DIE("S","FDATA3(9002313.039201)")
 Q
 ;
 ; Process the Additional Message Information Multiple from the Status Segment
 ; Note that FDATA, TRANSACT, FDAIEN, and FDAIEN03 are newed
 ;   and initialized by BPSECMPS
PROCADM ;
 N NNDX,FILE,ROOT,FDATA3,FLDNUM,FDATA03,FILE03,ROOT03
 S FILE="9002313.13001",ROOT="FDATA3(9002313.13001)"
 S FILE03="9002313.0301",ROOT03="FDATA03(9002313.0301)"
 S NNDX=""
 ; D.0 Processing: 526 is in a multiple with the group 132
 I $O(FDATA(TRANSACT,132,0))]"" D  Q
 . F  S NNDX=$O(FDATA(TRANSACT,526,NNDX)) Q:NNDX=""  D
 . . S FLDNUM=.01 D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",NNDX,ROOT)
 . . F FLDNUM=131,132,526 I $D(FDATA(TRANSACT,FLDNUM,NNDX)) D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",$G(FDATA(TRANSACT,FLDNUM,NNDX)),ROOT)
 . D UPDATE^DIE("S","FDATA3(9002313.13001)")
 ;
 ; 5.1 Processing: 526 is not in a group but is stored in one
 I $O(FDATA(TRANSACT,526,0))]"" D  Q
 . F  S NNDX=$O(FDATA(TRANSACT,526,NNDX)) Q:NNDX=""  D
 . . S FLDNUM=.01 D FDA^DILF(FILE,"+1,"_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",1,ROOT)
 . . S FLDNUM=132 D FDA^DILF(FILE,"+1,"_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"","01",ROOT)
 . . D FDA^DILF(FILE,"+1,"_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),526,"",$G(FDATA(TRANSACT,526,NNDX)),ROOT)
 . D UPDATE^DIE("S","FDATA3(9002313.13001)")
 . ; Set Additional Message Information Count field
 . D FDA^DILF(FILE03,"+"_TRANSACT_","_FDAIEN(TRANSACT),130,"",1,ROOT03)
 . D UPDATE^DIE("S","FDATA03(9002313.0301)")
 Q
 ;
 ; Process DUR Response Segment
 ; Note that FDATA, TRANSACT, FDAIEN, and FDAIEN03 are newed
 ;   and initialized by BPSECMPS
PROCDUR ;
 Q:$O(FDATA(TRANSACT,567,0))=""
 N NNDX,FILE,ROOT,FDAT1101,FLDNUM
 S FILE="9002313.1101"
 S ROOT="FDAT1101(9002313.1101)"
 S NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,567,NNDX)) Q:NNDX=""  D
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",FDATA(TRANSACT,567,NNDX),ROOT)
 .F FLDNUM=439,528,529,530,531,532,533,544,570 I $D(FDATA(TRANSACT,FLDNUM,NNDX))  D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",FDATA(TRANSACT,FLDNUM,NNDX),ROOT)
 D UPDATE^DIE("S","FDAT1101(9002313.1101)")
 Q

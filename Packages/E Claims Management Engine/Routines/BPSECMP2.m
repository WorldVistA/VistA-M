BPSECMP2 ;BHAM ISC/FCS/DRS - Parse Claim Response ;11/14/07  13:23
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,6,7,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Reference to STORESP^IBNCPDP supported by DBIA 4299
 Q
 ; Parameters:
 ;    CLAIMIEN: IEN from BPS Claims
 ;    RESPIEN:  IEN from BPS Response
 ;    EVENT:    This is used by PSO to create specific events (BILL).
 ;    USER:     User who is creating the event.  This is required when EVENT is sent.
IBSEND(CLAIMIEN,RESPIEN,EVENT,USER) ;
 N BPSARRY,RXIEN,FILLNUM,IND,TRNDX,RELDATE,X,Y,%DT
 N CLAIMNFO,RESPNFO,RXINFO,RFINFO,TRANINFO
 N RESPONSE,RXACT,CLREAS,BILLNUM,DFN,REQCLAIM
 N DIE,DA,DR
 ;
 ; Quit if there is not a Response or Claim IEN
 I '$G(RESPIEN) Q
 I '$G(CLAIMIEN) Q
 ;
 ; Get Claims and Response Data
 D GETS^DIQ("9002313.02",CLAIMIEN,"103;400*;401;402;403;426","","CLAIMNFO")
 D GETS^DIQ("9002313.0301","1,"_RESPIEN,"112;503;509;518","I","RESPNFO")
 ;
 ; Get the Transaction IEN and Data
 S IND=$S(CLAIMNFO("9002313.02",CLAIMIEN_",","103")="B2":"AER",1:"AE")
 S TRNDX=$O(^BPST(IND,CLAIMIEN,""))
 I TRNDX="" Q
 D GETS^DIQ("9002313.59",TRNDX,"1.05;3;5;13;404;501;1201","I","TRANINFO")
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
 ; If no Event, but action is Auto-Reversal (AREV) or CMOP (CR*/PC/RL),
 ;     user postmaster (.5)
 ; Else use the user from BPS Transaction
 I EVENT]"" S BPSARRY("USER")=USER
 E  I ",AREV,CRLB,CRLX,CRLR,PC,RL,"[(","_RXACT_",") S BPSARRY("USER")=.5
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
 D RXAPI^BPSUTIL1(RXIEN,".01;4;6;7;8;16;27","RXINFO","IE")          ; esg - 4/28/10 - add Rx QTY (*8)
 ;
 ; Get Refill Info if this is a refill
 S FILLNUM=+$E($P(TRNDX,".",2),1,4)
 I FILLNUM>0 D RXSUBF^BPSUTIL1(RXIEN,52,52.1,FILLNUM,".01;1;1.1;11","RFINFO","E")      ; esg - 4/28/10 - add Rx QTY (*8)
 ;
 ; Fill Date
 S BPSARRY("FILL DATE")=CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","401")
 S %DT="X",X=BPSARRY("FILL DATE") D ^%DT S:Y'=-1 BPSARRY("FILL DATE")=Y
 ;
 ; Information needed for PAID/BILLING event
 S BPSARRY("PAID")=0
 I RESPONSE="PAYABLE" D
 . S BPSARRY("PAID")=$$DFF2EXT^BPSECFM(RESPNFO(9002313.0301,"1,"_RESPIEN_",",509,"I"))
 . S BPSARRY("COPAY")=$$DFF2EXT^BPSECFM(RESPNFO(9002313.0301,"1,"_RESPIEN_",",518,"I"))
 . S BPSARRY("AUTH #")=RESPNFO(9002313.0301,"1,"_RESPIEN_",",503,"I")
 . S BPSARRY("RX NO")=RXINFO(52,RXIEN,.01,"E")
 . S BPSARRY("DRUG")=$$RXAPI1^BPSUTIL1(RXIEN,6,"I")
 . I FILLNUM<1  D
 .. S BPSARRY("DAYS SUPPLY")=RXINFO(52,RXIEN,8,"E")
 .. S BPSARRY("QTY")=RXINFO(52,RXIEN,7,"E")              ; Rx fill quantity
 . E  D
 .. S BPSARRY("DAYS SUPPLY")=$G(RFINFO(52.1,FILLNUM,1.1,"E"))
 .. S BPSARRY("QTY")=$G(RFINFO(52.1,FILLNUM,1,"E"))      ; Rx refill quantity
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
 S BPSARRY("BILLED")=$P(CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","426"),"DQ",2)
 S BPSARRY("BILLED")=$$DFF2EXT^BPSECFM(BPSARRY("BILLED"))
 S BPSARRY("CLAIMID")=$P(CLAIMNFO("9002313.0201","1,"_CLAIMIEN_",","402"),"D2",2)
 S RELDATE=$S(FILLNUM=0:$$RXAPI1^BPSUTIL1(RXIEN,31,"I"),1:$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,FILLNUM,17,"I"))
 S BPSARRY("RELEASE DATE")=$P(RELDATE,".")
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
 .. S CLREAS="OTHER",BPSARRY("CLOSE COMMENT")="INPATIENT PRESCRIPTION"
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
 ;
 ; If we got here, then it is not a reversal
 ; If EVENT is set, send Submit event
 I EVENT="" S BPSARRY("STATUS")="SUBMITTED",BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 ;
 ; Sent Paid (Billable) event is the claim was paid and released or EVENT is BILL
 ;   Note: User is always postmaster except for BackBilling (BB)
 I EVENT="BILL"!(RESPONSE="PAYABLE"&(BPSARRY("RELEASE DATE")]"")) D
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
 ; Synch DURs between ECME and PSO
 ; Parameters:
 ;   IEN59 is the BPS Transaction IEN
DURSYNC(IEN59) ;
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

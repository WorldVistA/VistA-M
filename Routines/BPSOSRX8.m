BPSOSRX8 ;ALB/SS - ECME REQUESTS ;10-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;check parameters for EN^BPSNCPDP
 ;BRXIEN - Rx ien
 ;BRX - rx refil no
 ;BWHERE - RX action
 ;DFN - patient's ien
 ;PNAME - patient name
 ;BILLNDC - NDC
 ;return 
 ;1 - passed
 ;0^message - failed
CHCKPAR(BRXIEN,BRX,BWHERE,DFN,PNAME,BILLNDC) ;
 I '$G(BRXIEN) Q "0^Prescription IEN parameter missing"
 I $G(BWHERE)="" Q "0^RX Action parameter missing"
 I $G(BRX)="" Q "0^Prescription does not exist"
 I $G(DFN)="" Q "0^Patient's IEN does not exist"
 I $G(PNAME)="" Q "0^Patient name missing"
 I $G(BILLNDC)="" Q "0^Invalid NDC"
 Q 1
 ;
 ;===== check if we need to print the messages to the screen =======
PRINTSCR(BWHER) ;
 I ",ARES,AREV,CRLB,CRLR,CRLX,DDED,DE,HLD,PC,PE,PL,RS,"[(","_BWHER_",") Q 0
 Q 1  ;print messages to the screen
 ;check if any IB DATA is missing
 ;returns 
 ; 0 - passed
 ; or 
 ; RESPONSE code^CLMSTAT message^D(display message)^number of seconds to hang if display 
IBDATAOK(MOREDATA,BPSARRY) ;
 N BPRESP S BPRESP=2
 I $G(BPSARRY("NO ECME INSURANCE")) S BPRESP=6
 ; Check for missing data (Will IB billing determination catch this?)
 I $D(MOREDATA("IBDATA",1,1)),$P(MOREDATA("IBDATA",1,1),"^",1)="" Q BPRESP_U_"Information missing from IB data.^D^2"
 ; Check for missing/invalid payer sheets (I think IB billing determination will catch this)
 I $P($G(MOREDATA("IBDATA",1,1)),"^",4)="" Q BPRESP_U_"Invalid/missing payer sheet from IB data.^D^2"
 ; Check if IB says to bill
 I '$G(MOREDATA("BILL")) Q BPRESP_U_"Flagged by IB to not 3rd Party Insurance bill through ECME.^D^2"
 Q 0
 ;Get Site
GETSITE(BRXIEN,BFILL) ;
 I 'BFILL Q $$RXAPI1^BPSUTIL1(BRXIEN,20,"I")
 I BFILL Q $$RXSUBF1^BPSUTIL1(BRXIEN,52,52.1,+BFILL,8,"I")
 Q 0
 ;
 ; Store general information/parameters into MOREDATA
 ; In instances where duz is null set it equal to .5 (postmaster)
BASICMOR(BWHERE,BFILLDAT,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,MOREDATA) ;
 S MOREDATA("USER")=$S('DUZ:.5,1:DUZ)
 S MOREDATA("RX ACTION")=$G(BWHERE)
 S MOREDATA("DATE OF SERVICE")=$P($G(BFILLDAT),".",1)
 S MOREDATA("REVERSAL REASON")=$S($G(REVREAS)="":"UNKNOWN",1:$E($G(REVREAS),1,40))
 I $G(DURREC)]"" S MOREDATA("DUR",1,0)=DURREC
 I $G(BPOVRIEN)]"" S MOREDATA("BPOVRIEN")=BPOVRIEN
 I $G(BPSCLARF)]"" S MOREDATA("BPSCLARF")=BPSCLARF
 I $TR($G(BPSAUTH),"^")]"" S MOREDATA("BPSAUTH")=BPSAUTH
 Q
 ;====== Prepare ret. value
 ;return RESPONSE ^ CLMSTAT ^ Display= D ^ seconds to HANG
RSPCLMS(BPREQTYP,RESPONSE,MOREDATA,BPADDINF) ;
 I BPREQTYP="C",RESPONSE=0 Q RESPONSE_U_$S($G(MOREDATA("ELIG"))="T":"TRICARE ",1:"")_"Prescription "_BRX_$S($G(MOREDATA("ELIG"))="T":"",1:" successfully")_" submitted to ECME for claim generation.^D^"
 I BPREQTYP="C",RESPONSE>0 Q RESPONSE_U_"No claim submission made: "_$S($G(BPADDINF)'="":BPADDINF,1:"Unable to queue claim submission.")_"^D"
 I BPREQTYP="U",RESPONSE=0 Q RESPONSE_U_"Reversing prescription "_BRX_".^D^2"
 I BPREQTYP="U",RESPONSE>0 Q RESPONSE_U_"No claim submission made.  Unable to queue reversal.^D^2"
 I BPREQTYP="UC",RESPONSE=10 Q RESPONSE_U_$S($G(MOREDATA("ELIG"))="T":"TRICARE ",1:"")_"Prescription "_BRX_$S($G(MOREDATA("ELIG"))="T":"",1:" successfully")_" submitted to ECME for claim reversal.^D^"
 I BPREQTYP="UC",RESPONSE=0 Q RESPONSE_U_$S($G(MOREDATA("ELIG"))="T":"TRICARE ",1:"")_"Prescription "_BRX_$S($G(MOREDATA("ELIG"))="T":"",1:" successfully")_" submitted to ECME for claim generation.^D^"
 I BPREQTYP="UC",RESPONSE>0,RESPONSE'=10 Q RESPONSE_U_"No claim submission made: "_$S($G(BPADDINF)'="":BPADDINF,1:"Unable to queue claim submission.")_"^D"
 Q ""
 ;
SENDBUL(RESPONSE,BWHERE,BRXIEN,BFILL,SITE,DFN,PNAME,BPSERTXT,BPSRESP) ;
 ; if RESPONSE=4 (Unable to queue claim)
 ; and
 ; If not OP, then send an email to the OPECC
 I RESPONSE=4,",AREV,BB,ERES,EREV,"'[(","_BWHERE_",") D BULL^BPSNCPD1(BRXIEN,BFILL,$G(SITE),$G(DFN),$G(PNAME),,$G(BPSERTXT),$G(BPSRESP))
 Q

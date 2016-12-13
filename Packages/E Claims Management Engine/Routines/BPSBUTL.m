BPSBUTL ;BHAM ISC/MFR/VA/DLF - IB Communication Utilities ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7,8,9,10,11,15,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;Reference to STORESP^IBNCPDP supported by DBIA 4299
 Q
 ;
 ;CLAIM - pointer to #9002313.02
 ;TRNDX - ptr to #9002313.59
 ;REASON -  text name of the close reason
 ;PAPER - 1=drop to paper
 ;RELCOP - 1 (Yes) or 0 (No) release copay or not?
 ;COMMENT - comment
 ;ERROR - array by reference for error details
 ;
CLOSE(CLAIM,TRNDX,REASON,PAPER,RELCOP,COMMENT,ERROR) ; Send IB an update on the CLAIM status for a Closed Claim
 N DFN,BPSARRY,BILLNUM,CLAIMNFO,FILLNUM,RXIEN,TRANINFO
 ;
 ; - Data gathering
 D GETS^DIQ("9002313.59",TRNDX,"1.11;9","I","TRANINFO")
 S RXIEN=TRANINFO(9002313.59,TRNDX_",",1.11,"I")
 I $$RXAPI1^BPSUTIL1(RXIEN,.01)="" S ERROR="Prescription not found." Q
 S BPSARRY("FILL NUMBER")=TRANINFO(9002313.59,TRNDX_",",9,"I")
 D GETS^DIQ("9002313.02",CLAIM,"400*;401;402;403;426","","CLAIMNFO")
 S BPSARRY("DOS")=$G(CLAIMNFO("9002313.02",CLAIM_",","401"))
 I BPSARRY("DOS") S BPSARRY("DOS")=BPSARRY("DOS")-17000000
 S FILLNUM=+BPSARRY("FILL NUMBER")
 S DFN=$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 S BPSARRY("FILLED BY")=$$RXAPI1^BPSUTIL1(RXIEN,16,"I")
 S BPSARRY("PRESCRIPTION")=RXIEN
 S BPSARRY("BILLED")=$$DFF2EXT^BPSECFM($P(CLAIMNFO("9002313.0201","1,"_CLAIM_",","426"),"DQ",2))
 S BPSARRY("CLAIMID")=$P(CLAIMNFO("9002313.0201","1,"_CLAIM_",","402"),"D2",2)
 S BPSARRY("PLAN")=$P(^BPST(TRNDX,10,1,0),"^")
 S BPSARRY("STATUS")="CLOSED"
 S BPSARRY("PAID")=0
 S BPSARRY("RELEASE DATE")=$S(FILLNUM=0:$$RXAPI1^BPSUTIL1(RXIEN,31,"I"),1:$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,FILLNUM,17,"I"))
 S BPSARRY("USER")=DUZ
 S BPSARRY("EPHARM")=$$GET1^DIQ(9002313.59,TRNDX,1.07,"I")
 S BPSARRY("RXCOB")=$$COB59^BPSUTIL2(TRNDX)
 I REASON'="" D
 . S BPSARRY("CLOSE REASON")=$O(^IBE(356.8,"B",REASON,0))
 . S BPSARRY("DROP TO PAPER")=+$G(PAPER)
 . S BPSARRY("RELEASE COPAY")=+$G(RELCOP)
 I $G(COMMENT)]"" S BPSARRY("CLOSE COMMENT")=COMMENT
 ;
 ; If dropped to Paper, increment the counter in BPS Statistics
 I BPSARRY("DROP TO PAPER")=1 D INCSTAT^BPSOSUD("R",8)
 ;
 ; Call IB
 S BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 Q
 ; Send IB an update on the CLAIM status for a restocked or deleted prescription
CLOSE2(RXIEN,BFILL,BWHERE) ;
 N IEN59,BPSARRY,DFN,BILLNUM,FILL,REASON
 N CLAIMNFO
 N DIE,DA,DR
 ;
 ; Check parameters
 I '$G(RXIEN) S ERROR="No prescription parameter" Q
 I $G(BFILL)="" S ERROR="No fill parameter" Q
 I $G(BWHERE)="" S ERROR="No RX Action parameter" Q
 ;
 I $$RXAPI1^BPSUTIL1(RXIEN,.01)="" S ERROR="Prescription not found." Q
 I ",DE,RS,"'[(","_BWHERE_",") S ERROR="Invalid BWHERE parameter" Q
 ;
 ; Calculate the transaction IEN and see that it exists
 S IEN59=$$IEN59^BPSOSRX(RXIEN,BFILL,1)
 I '$D(^BPST(IEN59,0)) Q
 ;
 ; Get claim data
 S CLAIM=$P(^BPST(IEN59,0),"^",4)
 I 'CLAIM S ERROR="Claim not found in BPS Transaction" Q
 D GETS^DIQ("9002313.02",CLAIM,"400*;401;402;426","","CLAIMNFO")
 S BPSARRY("FILL NUMBER")=+BFILL
 S BPSARRY("DOS")=$G(CLAIMNFO("9002313.02",CLAIM_",","401"))
 I BPSARRY("DOS") S BPSARRY("DOS")=BPSARRY("DOS")-17000000
 ;
 ; Get prescription data
 S FILLNUM=BPSARRY("FILL NUMBER")
 S DFN=$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 S BPSARRY("FILLED BY")=$$RXAPI1^BPSUTIL1(RXIEN,16,"I")
 S BPSARRY("PRESCRIPTION")=RXIEN
 S BPSARRY("BILLED")=$$DFF2EXT^BPSECFM($P(CLAIMNFO("9002313.0201","1,"_CLAIM_",","426"),"DQ",2))
 S BPSARRY("CLAIMID")=$P(CLAIMNFO("9002313.0201","1,"_CLAIM_",","402"),"D2",2)
 S BPSARRY("PLAN")=$P(^BPST(IEN59,10,1,0),"^")
 S BPSARRY("STATUS")="CLOSED"
 S BPSARRY("PAID")=0
 S BPSARRY("RELEASE DATE")=$S(FILLNUM=0:$$RXAPI1^BPSUTIL1(RXIEN,31,"I"),1:$$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,FILLNUM,17,"I"))
 S BPSARRY("USER")=.5
 S BPSARRY("EPHARM")=$$GET1^DIQ(9002313.59,IEN59,1.07,"I")
 S BPSARRY("RXCOB")=$$COB59^BPSUTIL2(IEN59)
 ;
 ; Determine the reversal reason based on the BWHERE value
 I BWHERE="RS" S REASON="PRESCRIPTION NOT RELEASED"
 I BWHERE="DE" S REASON="PRESCRIPTION DELETED"
 I REASON]"" S BPSARRY("CLOSE REASON")=$O(^IBE(356.8,"B",REASON,0))
 ;
 ;if a refill was deleted while RX is still active (not deleted) then send DELETION OF REFILL comment for CT record
 I BWHERE="DE",$$RXSTATUS^BPSSCRU2(RXIEN)'=13 S BPSARRY("CLOSE COMMENT")="DELETION OF REFILL ONLY - ORIGINAL RX MAY REMAIN ACTIVE"
 ;
 ;
 ; Update IB
 S BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSARRY)
 ;
 ; Update the claim file that the claim is closed and the reason why.
 S DIE="^BPSC(",DA=CLAIM
 S DR="901///1;902///"_$$NOW^XLFDT()_";903////.5;904///"_BPSARRY("CLOSE REASON")
 D ^DIE
 ;
 ; If this is a primary claim, check and send a bulletin if the secondary claim is open or if there
 ;   is a non-cancelled IB bill for the secondary claim
 I BPSARRY("RXCOB")=1 D BULL^BPSECMP2(RXIEN,BFILL,CLAIM,DFN,REASON,BPSARRY("CLAIMID"))
 Q
 ;
 ; Function to return Transaction, claim, and response IENs
 ; Parameters:
 ;    RXI: Prescription IEN
 ;    RXR: Fill Number
 ;    COB: COB Indicator
 ; Returns:
 ;    IEN59^Claim IEN^Response IEN^Reversal Claim IEN^Reversal Response IEN^Prescription/Service Ref Number from BPS CLAIMS file
CLAIM(RXI,RXR,COB) ;
 N IEN59,CLAIMIEN,RESPIEN,REVCLAIM,REVRESP,ECMENUM
 I '$G(RXI) Q ""
 ; Note that IEN59 will treat RXR="" as the original fill (0)
 ;   and COB="" as primary (1)
 S IEN59=$$IEN59^BPSOSRX(RXI,$G(RXR),$G(COB))
 I '$D(^BPST(IEN59,0)) Q ""
 S CLAIMIEN=$P(^BPST(IEN59,0),"^",4),RESPIEN=$P(^BPST(IEN59,0),"^",5)
 S REVCLAIM=$P($G(^BPST(IEN59,4)),"^",1),REVRESP=$P($G(^BPST(IEN59,4)),"^",2)
 S ECMENUM=$$ECMENUM^BPSSCRU2(IEN59)
 Q IEN59_U_CLAIMIEN_U_RESPIEN_U_REVCLAIM_U_REVRESP_U_ECMENUM
 ;
 ; NABP - Return the value in the Service Provider ID (201-B1) field
 ;   of the claim.  Note that as of the NPI release (BPS*1*2), this
 ;   API may return NPI instead of NABP/NCPDP
NABP(RXP,BFILL) ;
 I '$G(RXP) Q ""
 I $G(BFILL)="" S BFILL=0
 N BPSTIEN,BPSCIEN,DFILL,NABP
 S DFILL=$E($TR($J("",4-$L(BFILL))," ","0")_BFILL,1,4)
 S BPSTIEN=RXP_"."_DFILL_"1"
 I 'BPSTIEN Q ""
 S BPSCIEN=$P($G(^BPST(BPSTIEN,0)),U,4)
 I 'BPSCIEN Q ""
 S NABP=$P($G(^BPSC(BPSCIEN,200)),U)
 Q NABP
 ;
 ; DIVNCPDP - For a specific outpatient site, return the NPI & NCPDP.
 ; Note that the procedure name is misleading but when originally
 ;   coded, this procedure only returned NCPDP.
 ;
 ; Input
 ;   BPSDIV - Outpatient Site (#59)
 ; Output
 ;   "" - No BPSDIV passed in
 ;   NCPDP and NPI separated by a caret
DIVNCPDP(BPSDIV) ;
 N BPSPHARM,NPI,NCPDP
 I '$G(BPSDIV) Q "^"
 ;
 ; Get the NCPDP
 S NCPDP=""
 S BPSPHARM=$$GETPHARM^BPSUTIL(BPSDIV)
 I BPSPHARM S NCPDP=$$GET1^DIQ(9002313.56,BPSPHARM_",",.02)
 ;
 ; Get the NPI and validate it
 S NPI=+$$NPI^BPSNPI("Pharmacy_ID",BPSDIV)
 I NPI=-1 S NPI=""
 ;
 Q NCPDP_"^"_NPI
 ;
 ;ADDCOMM - Add a comment to a ECME claim
 ;Input:
 ; BPRX - ien in file #52 
 ; BPREF - refill number (0,1,2,...)
 ; BPRCMNT - comment text
 ;Output:
 ;  1 - okay
 ; -1 - failed
ADDCOMM(BPRX,BPREF,BPRCMNT,BPBKG) ;
 ;
 ;BPRX    (required) - Prescription IEN
 ;BPREF   (optional) - Refill number
 ;BPRCMNT (required) - Comment text
 ;BPBKG   (optional) - Value 1 indicates process is running in background - BPS*1*15
 ;
 N IEN59,BPNOW,BPREC,BPDA,BPERR
 ; Check parameters
 I '$G(BPRX) Q -1
 I $G(BPRCMNT)="" Q -1
 ; Get BPS Transaction number, if needed, and check for existance
 S IEN59=$$IEN59^BPSOSRX(BPRX,$G(BPREF),1)
 I IEN59="" Q -1
 I '$D(^BPST(IEN59)) Q -1
 ; Lock record and quit if you cannot get the lock
 L +^BPST(9002313.59111,+IEN59):10
 I '$T Q -1
 ; Create record and file data
 S BPNOW=$$NOW^XLFDT
 D INSITEM^BPSCMT01(9002313.59111,+IEN59,BPNOW)
 S BPREC=$O(^BPST(IEN59,11,"B",BPNOW,99999999),-1)
 I BPREC>0 D
 .;If BPBKG is passed this is a background process and user is POSTMASTER - BPS*1*15
 . S BPDA(9002313.59111,BPREC_","_IEN59_",",.02)=$S($G(BPBKG):.5,1:+$G(DUZ))
 . S BPDA(9002313.59111,BPREC_","_IEN59_",",.03)=$E($G(BPRCMNT),1,63)
 . D FILE^DIE("","BPDA","BPERR")
 L -^BPST(9002313.59111,+IEN59)
 ; Quit with result
 I BPREC>0,'$D(BPERR) Q 1
 Q -1
 ;
 ;REOPEN - Reopen closed claim
 ;Input:
 ; BP59 - ien in BPS TRANSACTION file
 ; BP02 - ien in BPS CLAIMS file
 ; BPREOPDT - reopen date/time 
 ; BPDUZ - user DUZ (#200 ien)
 ; BPCOMM - reopen comment text
 ;Output:
 ; 0^message_error - error
 ; 1 - success
REOPEN(BP59,BP02,BPREOPDT,BPDUZ,BPCOMM) ;
 N RECIENS,BPDA,ERRARR,BPREFNO,BPRXIEN,BPZ,BPSARRY,BPDFN,BPRETVAL,BPZ1
 S BPDFN=$P($G(^BPST(BP59,0)),U,6)
 S BPREFNO=$P($G(^BPST(BP59,1)),U)
 I BPREFNO="" Q "0^Null Fill Number"
 S BPRXIEN=$P($G(^BPST(BP59,1)),U,11)
 I BPRXIEN="" Q "0^Null RX ien Number"
 ;in VA there is only one med/claim but in some cases it can different than "1"
 ;so take the latest one
 S BPZ=$O(^BPSC(BP02,400,9999999),-1)
 I BPRXIEN="" Q "0^Database Error"
 ;============
 ;Now update ECME database
 S BPRETVAL=$$UPDREOP^BPSREOP1(BP02,0,BPREOPDT,BPDUZ,BPCOMM)
 I +BPRETVAL=0 D  Q BPRETVAL
 . ;try to reverse it in case it was done partially
 . I $$UPDREOP^BPSREOP1(BP02,1,"@",+BPDUZ,"@")
 ;============
 ;Now call IB API for "REOPEN" event
 S BPSARRY("STATUS")="REOPEN"
 S BPSARRY("DOS")=$P($G(^BPSC(BP02,401)),U)
 I BPSARRY("DOS") S BPSARRY("DOS")=BPSARRY("DOS")-17000000
 S BPSARRY("FILL NUMBER")=BPREFNO
 S BPSARRY("PRESCRIPTION")=BPRXIEN
 S BPSARRY("CLAIMID")=$$CONVCLID^BPSSCRU6($P($G(^BPSC(BP02,400,+BPZ,400)),U,2))
 S BPSARRY("DRUG")=$$DRUGIEN^BPSSCRU6(BPRXIEN,BPDFN)
 S BPSARRY("PLAN")=$P($G(^BPST(BP59,10,1,0)),"^")
 S BPSARRY("USER")=BPDUZ
 S BPSARRY("REOPEN COMMENT")=BPCOMM
 S BPSARRY("EPHARM")=$$GET1^DIQ(9002313.59,BP59,1.07,"I")
 S BPSARRY("RXCOB")=$$COB59^BPSUTIL2(BP59)
 S BPRETVAL=$$STORESP^IBNCPDP(BPDFN,.BPSARRY)
 ;if successful
 I +BPRETVAL>0 Q "1^ReOpening Claim: "_$P($G(^BPSC(BP02,0)),U)_" ... OK"
 ;===========
 ;if it was unsuccessful
 ;reverse ECME database (keep the user who made the attempt)
 I $$UPDREOP^BPSREOP1(BP02,1,"@",+BPDUZ,"@")
 ;return IB error message
 Q BPRETVAL
 ;
GETDAT(RX,FIL,COB,LDOS,LDSUP) ;Returns Last Date of Service and Last Days Supply
 ;Input:
 ;  RX (req)  --> RX IEN
 ;  FIL (req) --> Fill number
 ;  COB (opt) --> Coordination of Benifits indicator; default is 1
 ;Output:
 ;  LDOS  --> Last Date of Service
 ;  LDSUP --> Last Days Supply
 ;
 Q:'($G(RX))!($G(FIL)="")
 S:'$G(COB) COB=1
 N IEN59,IEN02,STAT,IEN57
 S IEN02=""
 S IEN59=$$IEN59^BPSOSRX(RX,FIL,COB)
 S STAT=$P($G(^BPST(IEN59,0)),U,2)
 I STAT=99 S IEN02=$P($G(^BPST(IEN59,0)),U,4)
 I IEN02="" D
 . S IEN57=""
 . F  S IEN57=$O(^BPSTL("B",IEN59,IEN57),-1) Q:IEN57=""!(IEN02)  D
 .. S STAT=$P($G(^BPSTL(IEN57,0)),U,2)
 .. I STAT=99 S IEN02=$P($G(^BPSTL(IEN57,0)),U,4)
 I 'IEN02 S (LDOS,LDSUP)="" Q
 S LDOS=$$GET1^DIQ(9002313.02,IEN02,401,"E")  ;LAST DATE OF SERVICE
 I LDOS S LDOS=LDOS-17000000    ;CONVERT DATE TO FILEMAN FORMAT
 S LDSUP=$$GET1^DIQ(9002313.0201,"1,"_IEN02,405,"I")  ;LAST DAYS SUPPLY
 I LDSUP'="" S LDSUP=+$E(LDSUP,3,99)      ; remove the "D5" NCPDP field ID  (bps*1*15)
 Q
 ;
NFLDT(RX,FIL,COB) ;Returns Next Avail Fill Date (B04-BT) from ECME - BPS*1.0*15
 ;Input:                                                                
 ;  RX (req)  --> RX IEN                                                
 ;  FIL (req) --> Fill number                                           
 ;  COB (opt) --> Coordination of Benefits indicator; default is 1      
 ;Output:
 ;  NFLDT --> Next Avail Fill Date                                          
 Q:'$G(RX)!($G(FIL)="") ""
 S:'$G(COB) COB=1
 N IEN59,IEN02,STAT,NFLDT,IEN03
 S IEN02=""
 S IEN59=$$IEN59^BPSOSRX(RX,FIL,COB)
 S IEN03=+$P($G(^BPST(IEN59,0)),U,5),NFLDT=""
 S:IEN03 NFLDT=$$GET1^DIQ(9002313.0301,"1,"_IEN03,2004,"I") ;NEXT FILL DATE
 S:NFLDT NFLDT=NFLDT-17000000 ;CONVERT DATE TO FILEMAN FORMAT
 Q NFLDT
 ;
BBILL(RX,RFILL,COB) ;Return Back Bill Indicator for Pharmacy - BPS*1.0*15
 N IEN59,RXACT
 ;Return 0 if no RXI value input 
 I '$G(RX) Q 0
 ; Note that $$IEN59 will treat RFILL="" as the original fill (0)
 S IEN59=$$IEN59^BPSOSRX(RX,$G(RFILL),$G(COB))
 ;No transaction found return 0
 I '$D(^BPST(IEN59,0)) Q 0
 ;Determine if RX ACTION (field #1201) is Back Bill
 S RXACT=$P($G(^BPST(IEN59,12)),U)
 ;Back Bill code not found return 0
 I RXACT'="BB",RXACT'="P2",RXACT'="P2S" Q 0
 ;Otherwise return Back Bill indicator
 Q 1
 ;
AMT(RX,FIL,COB) ; Return Gross Amount Due - BPS*1*15
 ;  RX - rx ien
 ; FIL - fill#, defaults to original fill if not passed in
 ; COB - cob payer sequence, defaults to 1 if not passed in
 ;
 N AMT,IEN59,QN
 S AMT=""
 I '$G(RX) G AMTX
 S IEN59=$$IEN59^BPSOSRX(RX,$G(FIL),$G(COB))  ; ien to BPS Transaction file
 I '$D(^BPST(IEN59,0)) G AMTX                 ; make sure it exists
 S QN=+$O(^BPST(IEN59,10,0)) I 'QN G AMTX     ; get 9002313.59902 subfile ien
 S AMT=+$P($G(^BPST(IEN59,10,QN,2)),U,4)      ; gross amount due, field 902.15
AMTX ;
 Q AMT
 ;
ELIG(RX,FIL,COB) ; Veteran Eligibility - BPS*1*15
 ; RX  - rx ien
 ; FIL - fill#, defaults to original fill if not passed in
 ; COB - cob payer sequence, defaults to 1 if not passed in
 ;
 Q:'$G(RX) ""
 ; ien to BPS Transaction file
 N IEN59 S IEN59=$$IEN59^BPSOSRX(RX,$G(FIL),$G(COB)) Q:'IEN59 ""
 Q:'$D(^BPST(IEN59,0)) ""
 ; ELIGIBILITY field 901.04
 Q $P($G(^BPST(IEN59,9)),U,4)
 ;
GETBAMT(RXIEN,FILL,COB)  ; Retrieve the billed amount
 ; RXIEN = Prescription ien (required)
 ; FILL# = Fill Number (optional, defaults to latest fill)
 ; COB = Coordination of Benefits (optional, defaults to 1)
 N X,BAMT,CLAIMIEN
 S X=$$CLAIM(RXIEN,$G(FILL),$G(COB))
 S CLAIMIEN=$P(X,U,2)
 S BAMT=$$TOTPRICE^BPSSCRLG(CLAIMIEN)
 Q BAMT
 ;
RESUBMIT(RX,REFILL,COB) ; Return Resubmit indicator for Pharmacy - BPS*1*20.
 N BPSIEN59,BPSRXACT
 I '$G(RX) Q 0
 ;
 ; Determine BPS Transaction number.  If none, Quit with '0'.
 ;
 S BPSIEN59=$$IEN59^BPSOSRX(RX,$G(REFILL),$G(COB))
 I 'BPSIEN59 Q 0
 I '$D(^BPST(BPSIEN59,0)) Q 0
 ;
 ; Pull the RX Action from the BPS Transaction.  If it's not one that
 ; indicates resubmission from the ECME User Screen, then Quit with
 ; '0'.  Otherwise, Quit with '1'.
 ;
 S BPSRXACT=$$GET1^DIQ(9002313.59,BPSIEN59_",",1201)
 I ",ERES,ERWV,ERNB,"'[(","_BPSRXACT_",") Q 0
 Q 1
 ;
GETCOB(RXIEN,FILL) ; Retrieve the COB payer sequence for usage by PSO
 ;   Input:  RXIEN and FILL (both are required)
 ;  Output:  Function value will be one of the following
 ;           ""  (if the prescription fill cannot be found in BPS Transaction)
 ;           -1  (when there are multiple COB's/payers found in BPS Transaction)
 ;           Otherwise,
 ;           COB#^BPS Transaction IEN
 N RET,PRI59,SEC59
 S RET=""
 I '$G(RXIEN) G GETCOBX
 I $G(FILL)="" G GETCOBX
 ;
 S PRI59=+$$IEN59^BPSOSRX(RXIEN,FILL,1)   ; possible primary BPS transaction ien
 S SEC59=+$$IEN59^BPSOSRX(RXIEN,FILL,2)   ; possible secondary BPS transaction ien
 ;
 I $D(^BPST(PRI59)),$D(^BPST(SEC59)) S RET=-1 G GETCOBX   ; both payers exist, get out
 I $D(^BPST(PRI59)) S RET=1_U_PRI59 G GETCOBX
 I $D(^BPST(SEC59)) S RET=2_U_SEC59 G GETCOBX
 ;
GETCOBX ;
 Q RET
 ;

BPSBUTL ;BHAM ISC/MFR/VA/DLF - IB Communication Utilities ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7,8,9,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 S BPSARRY("FILL DATE")=$$EXT2FM^BPSOSU1(CLAIMNFO("9002313.0201","1,"_CLAIM_",","401"))
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
 ;
 I $$RXAPI1^BPSUTIL1(RXIEN,.01)="" S ERROR="Prescription not found." Q
 I ",DDED,DE,RS,"'[(","_BWHERE_",") S ERROR="Invalid BWHERE parameter" Q
 ;
 ; Calculate the transaction IEN and see that it exists
 S FILL=".0000"_+BFILL
 S IEN59=RXIEN_"."_$E(FILL,$L(FILL)-3,$L(FILL))_"1"
 I '$D(^BPST(IEN59,0)) Q
 ;
 ; Get claim data
 S CLAIM=$P(^BPST(IEN59,0),"^",4)
 D GETS^DIQ("9002313.02",CLAIM,"400*;401;402;426","","CLAIMNFO")
 S BPSARRY("FILL NUMBER")=+BFILL
 S BPSARRY("FILL DATE")=$$EXT2FM^BPSOSU1(CLAIMNFO("9002313.0201","1,"_CLAIM_",","401"))
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
 I BWHERE="DE"!(BWHERE="DDED") S REASON="PRESCRIPTION DELETED"
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
ADDCOMM(BPRX,BPREF,BPRCMNT) ;
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
 . S BPDA(9002313.59111,BPREC_","_IEN59_",",.02)=+$G(DUZ)
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
 N RECIENS,BPDA,ERRARR,BPREFNO,BPRXIEN,BPFILLDT,BPCLMID,BPZ,BPSARRY,BPDFN,BPRETVAL,BPZ1
 S BPDFN=$P($G(^BPST(BP59,0)),U,6)
 S BPREFNO=$P($G(^BPST(BP59,1)),U)
 I BPREFNO="" Q "0^Null Fill Number"
 S BPRXIEN=$P($G(^BPST(BP59,1)),U,11)
 I BPRXIEN="" Q "0^Null RX ien Number"
 ;in VA there is only one med/claim but in some cases it can different than "1"
 ;so take the latest one
 S BPZ=$O(^BPSC(BP02,400,9999999),-1)
 I BPRXIEN="" Q "0^Database Error"
 S BPFILLDT=$$YMD2FM^BPSSCRU6(+$P($G(^BPSC(BP02,400,+BPZ,400)),U))
 S BPCLMID=$$CONVCLID^BPSSCRU6($P($G(^BPSC(BP02,400,+BPZ,400)),U,2))
 ;============
 ;Now update ECME database
 S BPRETVAL=$$UPDREOP^BPSREOP1(BP02,0,BPREOPDT,BPDUZ,BPCOMM)
 I +BPRETVAL=0 D  Q BPRETVAL
 . ;try to reverse it in case it was done partially
 . I $$UPDREOP^BPSREOP1(BP02,1,"@",+BPDUZ,"@")
 ;============
 ;Now call IB API for "REOPEN" event
 S BPSARRY("STATUS")="REOPEN"
 S BPSARRY("FILL DATE")=BPFILLDT
 S BPSARRY("FILL NUMBER")=BPREFNO
 S BPSARRY("PRESCRIPTION")=BPRXIEN
 S BPSARRY("CLAIMID")=BPCLMID
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

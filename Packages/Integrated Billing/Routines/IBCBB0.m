IBCBB0 ;ALB/ESG - IB edit check routine continuation ;12-Mar-2008
 ;;2.0;INTEGRATED BILLING;**377,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
BP(IBIFN) ; make sure the claim has a valid Billing Provider w/address
 N BPZ,BPAD1,BPCITY,BPST,BPZIP,IBZ
 S BPZ=$$B^IBCEF79(IBIFN)
 I 'BPZ D  G BPX
 . S IBER=IBER_"IB140;"                ; fatal error# IB140 - This claim has no Billing Provider.
 . D WARN^IBCBB11($P(BPZ,U,2))         ; display reason as a warning
 . Q
 ;
 ; billing provider exists....check the address pieces.
 ; for printed, UB claims we always use the billing provider data in FL-1 from the Inst file.
 ; for EDI claims or for printed CMS-1500 claims, we use the GETBP^IBCEF79 utility to get the billing provider data.
 I '$$TXMT^IBCEF4(IBIFN),$$FT^IBCEF(IBIFN)=3 D
 . S BPAD1=$$GETFAC^IBCEP8(+BPZ,0,1)
 . S BPCITY=$$GETFAC^IBCEP8(+BPZ,0,"3C")
 . S BPST=$$GETFAC^IBCEP8(+BPZ,0,"3S")
 . S BPZIP=$$GETFAC^IBCEP8(+BPZ,0,"3Z")
 . Q
 ;
 E  D
 . D GETBP^IBCEF79(IBIFN,"",+BPZ,"IBCBB0",.IBZ)
 . S BPAD1=$G(IBZ("IBCBB0","ADDR1"))
 . S BPCITY=$G(IBZ("IBCBB0","CITY"))
 . S BPST=$G(IBZ("IBCBB0","ST"))
 . S BPZIP=$G(IBZ("IBCBB0","ZIP"))
 . Q
 ;
 I '$L(BPAD1)!'$L(BPCITY)!'$L(BPST)!'$L(BPZIP) S IBER=IBER_"IB148;"
BPX ;
 Q
 ;
PAYTO(IBIFN) ; check for missing Pay-to Provider information
 ;
 ; Possible IB error codes for Pay-to Provider:
 ;    IB177 - No Pay-to Provider defined for this claim.
 ;    IB178 - Pay-to Provider on the claim is missing a name.
 ;    IB179 - Pay-to Provider on the claim is missing an NPI.
 ;    IB180 - Pay-to Provider on the claim is missing a Tax ID number.
 ;    IB181 - Address Line 1, City, State, and ZIP are required for Pay-to Provider.
 ;
 N Z,PTPERR,PTPINST,PTPFT,PTPFTN,Z1,PTPFLAG
 S Z=$$PRVDATA^IBJPS3(IBIFN)
 S PTPERR=$P(Z,U,10)           ; list of any pay-to provider errors as listed above
 I PTPERR'="" S IBER=IBER_PTPERR
 ;
 I IBER["IB177" G PAYTOX       ; no need to continue if there is no pay-to provider
 ;
 ; display a warning if the pay-to provider facility type is wrong
 S PTPINST=$P(Z,U,11)                         ; pay-to provider Institution file pointer (file 4 ien)
 S PTPFT=+$$GET1^DIQ(4,+PTPINST_",",13,"I")   ; pay-to provider facility type ien
 S PTPFTN=$$WHAT^XUAF4(PTPINST,13)            ; pay-to provider facility type name
 I PTPFTN="" S PTPFTN="UNKNOWN"
 ;
 S (Z1,PTPFLAG)=""
 I PTPFT S Z1=+$O(^IBE(350.9,1,20,"B",PTPFT,0))
 I Z1 S PTPFLAG=$P($G(^IBE(350.9,1,20,Z1,0)),U,2)
 ;
 ; display warning message if the flag is not true
 I 'PTPFLAG D WARN^IBCBB11("Pay-to Prov "_$P(Z,U,1)_" on this claim has facility type "_PTPFTN_".")
 ;
PAYTOX ;
 Q
 ;
PAYERADD(IBIFN) ; check to make sure payer address is present for all payers on the claim
 ; Address line 1, city, state, and zip must be present for all non-Medicare payers on the claim
 ;
 NEW IBZ,OK,Z,IBL,N,SEQ,ADDR,IBXDATA,IBXSAVE,IBXARRAY,IBXARRY,IBXERR
 ;
 ; check current payer address if not Medicare
 I '$$WNRBILL^IBEFUNC(IBIFN) D
 . D F^IBCEF("N-CURR INS CO FULL ADDRESS","IBZ",,IBIFN)
 . S OK=1
 . F Z=1,4,5,6 I $G(IBZ(Z))="" S OK=0 Q
 . I 'OK S IBER=IBER_"IB172;"
 . Q
 ;
 ; check other payer addresses if they exist
 D F^IBCEF("N-OTH INSURANCE SEQUENCE","IBL",,IBIFN)    ; other payer sequence array
 I '$O(IBXSAVE(1,0)) G PAYERAX                         ; no other payers on claim
 S N=0 F  S N=$O(IBXSAVE(1,N)) Q:'N  D
 . S SEQ=IBXSAVE(1,N)                                  ; other payer sequence letter
 . I $$WNRBILL^IBEFUNC(IBIFN,SEQ) Q                    ; ignore Medicare addresses
 . S ADDR=$$ADD^IBCNADD(IBIFN,SEQ)                     ; other payer address string
 . S OK=1
 . F Z=1,4,5,6 I $P(ADDR,U,Z)="" S OK=0 Q
 . I 'OK S IBER=IBER_"IB173;"
 . Q
 ;
PAYERAX ;
 Q
 ;

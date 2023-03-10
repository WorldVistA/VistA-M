PSOBPSUT ;BIRM/MFR - BPS (ECME) Utilities ;07 Jun 2005  8:39 PM
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,281,287,289,358,385,403,408,512,630,562,680**;DEC 1997;Build 5
 ; Reference to $$ECMEON^BPSUTIL in ICR #4410
 ; Reference to IBSEND^BPSECMP2 in ICR #4411
 ; Reference to $$STATUS^BPSOSRX in ICR #4412
 ; Reference to $$NDCFMT^PSSNDCUT in ICR #4707
 ; Reference to $$CLAIM^BPSBUTL in ICR #4719
 ; Reference to ^PS(55 in ICR #2228
 ; Reference to ^PSDRUG( in ICR #221
 ; Reference to ^PSDRUG("AQ" in ICR #3165
 ;
ECME(RX) ; Returns "e" if Rx/Refill is Electronically Billable (3rd party)
 Q $S($$STATUS^BPSOSRX(RX,$$LSTRFL^PSOBPSU1(RX))'="":"e",1:"")
 ;
STATUS(RX,RFL,COB) ; Returns the Rx's ECME Status (calls STATUS^BPSOSRX)
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (o) COB - Coordination of Benefits (1=primary, etc.)
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$G(COB) S COB=1
 Q $P($$STATUS^BPSOSRX(RX,RFL,,,COB),"^")
 ;
SUBMIT(RX,RFL,IGRL,IGCMP) ; Returns whether the Rx should be submitted to ECME at the moment or not
 ; Input:  (r) RX   - Rx IEN (#52)
 ;         (o) RFL  - Refill # (Def.: most recent)
 ;         (o) IGRL - Ignore Release Date? (1-YES/0-NO) (Def.: 0 - NO)
 ;         (o) IGCMP- Ignore CMOP/Suspense check? (1-YES/0-NO) (Def.: 0 - NO)
 ;
 ; - Get the REFILL # (multiple IEN)
 N STATUS
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; - Not the latest fill for the prescription
 I RFL'=$$LSTRFL^PSOBPSU1(RX) Q 0
 ; - Status not ACTIVE, DISCONTINUED, or EXPIRED
 S STATUS=$$GET1^DIQ(52,RX,100,"I")
 I ",0,11,12,14,15,"'[(","_STATUS_",") Q 0
 ; Will suspend for CMOP
 I '$G(IGCMP),$$CMOP(RX,RFL) Q 0
 ; - ECME turned OFF for Rx's site
 I '$$ECMEON^BPSUTIL($$RXSITE(RX,RFL)) Q 0
 ; - Rx is RELEASED - Do not submit
 I '$G(IGRL),$$RXRLDT(RX,RFL) Q 0
 ; - Future Fill/AUTO SUSPENSE ON - will suspend
 I '$G(IGCMP),$$RXFLDT(RX,RFL)>DT,$$GET1^DIQ(59,$$RXSITE(RX,RFL),.16,"I") Q 0
 Q 1
 ;
CMOP(RX,RFL) ; Returns if the Rx will be a CMOP Rx or not
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ; Output: 1 - CMOP / 0 - NON-CMOP
 ;
 N DFN,CMOP,MAIL,MAILEXP,DRUG,WARNS,STATUS,MW,A
 ; Get the REFILL # (multiple IEN)
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; MAIL=MAIL Code, MAILEXP=Mail Code Expiration Date
 S CMOP=0
 S DFN=$$GET1^DIQ(52,RX,2,"I"),MAIL=$$GET1^DIQ(55,DFN,.03,"I"),MAILEXP=$$GET1^DIQ(55,DFN,.05,"I")
 I MAIL>1,MAILEXP=""!(MAILEXP>DT) G QCMOP
 ; Get drug IEN and check DRUG if CMOP  ,$S($G(MAILEXP)=""!($G(MAILEXP)>DT):1,1:0)
 S DRUG=$$GET1^DIQ(52,RX,6,"I") G QCMOP:'DRUG,QCMOP:'$D(^PSDRUG("AQ",DRUG))
 ; Not marked for O.P.
 I $$GET1^DIQ(50,DRUG,63)'["O" G QCMOP
 ; Drug Warning >11
 S WARNS=$$GET1^DIQ(50,DRUG,8) I $L(WARNS)>11 G QCMOP
 ; If tradename
 I $$GET1^DIQ(52,RX,6.5)'="" G QCMOP
 ; If Cancelled, Expired, Deleted, Hold
 S STATUS=$$GET1^DIQ(52,RX,100,"I") I (STATUS>9&(",14,15,"'[(","_STATUS_",")))!(STATUS=4)!(STATUS=3) G QCMOP
 ; Rx RELEASED
 I $$RXRLDT^PSOBPSUT(RX,RFL) G QCMOP
 ; MAIL/WINDOW
 S MW=$S('RFL:$$GET1^DIQ(52,RX,11,"I"),1:$$GET1^DIQ(52.1,RFL_","_RX,2,"I"))
 ; IF WINDOW/ORIGINAL/FUTURE FILL SETS MW = MAIL
 I MW="W",$$RXFLDT^PSOBPSUT(RX,RFL)>DT S MW="M"
 ; If not MAIL
 I MW'="M" G QCMOP
 S CMOP=1
 ;
QCMOP Q CMOP
 ;
RXRLDT(RX,RFL) ; Returns the Rx Release Date
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;        
 ; Output:  RXRLDT - Rx Release Date
 N RXRLDT
 I '$G(RX) Q ""
 S RXRLDT=$$GET1^DIQ(52,RX,31,"I")
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I RFL S RXRLDT=$$GET1^DIQ(52.1,RFL_","_RX,17,"I")
 I RFL["P" S RXRLDT=$$GET1^DIQ(52.2,+$E(RFL,2,9)_","_RX,8,"I")
 Q RXRLDT
 ;
RXFLDT(RX,RFL) ; Returns the Rx Fill Date
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)      
 ; Output:  RXFLDT - Rx Fill Date (FM format)
 N RXFLDT
 I '$G(RX) Q ""
 S RXFLDT=$$GET1^DIQ(52,RX,22,"I")
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I RFL S RXFLDT=$$GET1^DIQ(52.1,RFL_","_RX,.01,"I")
 I RFL["P" S RXFLDT=$$GET1^DIQ(52.2,+$E(RFL,2,9)_","_RX,.01,"I")
 Q RXFLDT
 ;
RXSUDT(RX,RFL) ; Returns the prescription/fill Suspense Date for the RX/Reject passed in
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill IEN (#52.1)
 ;Output: SUSPENSE DATE (External format) or <NULL>, if not suspended
 ;
 I $G(^PSRX(RX,"STA"))'=5 Q ""
 N SURX,SURFL
 S SURX=$O(^PS(52.5,"B",RX,0)) I 'SURX Q ""
 I $$GET1^DIQ(52.5,SURX,.05,"I") Q ""
 S SURFL=+$$GET1^DIQ(52.5,SURX,9) I RFL'=SURFL Q ""
 Q $$GET1^DIQ(52.5,SURX,.02,"I")
 ;
RXSITE(RX,RFL) ; Returns the Rx DIVISION
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill #
 ; Output:  SITE - Rx Fill Date
 ;        
 N SITE
 I '$G(RX) Q ""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I RFL S SITE=$$GET1^DIQ(52.1,RFL_","_RX,8,"I")
 I RFL["P" S SITE=$$GET1^DIQ(52.2,+$E(RFL,2,9)_","_RX,.09,"I")
 I (RFL=0)!'$G(SITE) S SITE=$$GET1^DIQ(52,RX,20,"I")
 Q SITE
 ;
RXSTATE(RX,RFL) ; Returns the Rx Division STATE
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill #
 ; Output:  SITE - Rx Fill Date
 N SITE
 S SITE=$$RXSITE(RX,RFL) I 'SITE Q ""
 Q +$$GET1^DIQ(59,SITE,.08,"I")
 ;
RXSTATEP(RX,RFL,STATE) ; Returns the Rx Export States
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill #
 ;             STATE - Selected State
 ; Output:  RSLT - Export States
 N SITE,MBMST,RSLT,DFN
 S MBMST=$$GET1^DIQ(58.41,STATE,21,"I")
 S RSLT="^"
 I (+MBMST=0)!(+MBMST=1) D
 .S SITE=$$RXSITE(RX,RFL) I 'SITE Q
 .S RSLT=RSLT_+$$GET1^DIQ(59,SITE,.08,"I")_"^"
 I (+MBMST=1)!(+MBMST=2) D
 .S DFN=$$GET1^DIQ(52,RX,2,"I") D ADD^VADPT I +VAPA(5)]"" S RSLT=RSLT_+VAPA(5)_"^"
 Q RSLT
 ;
RXSTATEZ(RX,RFL,STATE) ; Returns the Rx Export States
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill #
 ;             STATE - Selected State
 ; Output:  RSLT - Export to State
 N SITE,MBMST,RSLT,DFN
 S MBMST=$$GET1^DIQ(58.41,STATE,21,"I")
 I (+MBMST=0)!(+MBMST=1) S SITE=$$RXSITE(RX,RFL) Q:'SITE 0 Q +$$GET1^DIQ(59,SITE,.08,"I")
 I +MBMST=2 S DFN=$$GET1^DIQ(52,RX,2,"I") D ADD^VADPT I +VAPA(5)]"" Q +VAPA(5)
 Q 0
 ;
RXQTY(RXIEN,FILL) ; Returns the Quantity Dispense for the Fill
 ; Input:  (r) RXIEN - Rx IEN (#52) 
 ;         (o) FILL  - Refill # (Default: most recent)
 ; Output:  RXQTY - Quantity Dispensed
 N RXQTY
 I '$G(RXIEN) Q ""
 S RXQTY=$$GET1^DIQ(52,RXIEN,7,"I")
 I '$D(FILL) S FILL=$$LSTRFL^PSOBPSU1(RXIEN)
 I FILL S RXQTY=$$GET1^DIQ(52.1,FILL_","_RXIEN,1,"I")
 I FILL["P" S RXQTY=$$GET1^DIQ(52.2,+$E(FILL,2,9)_","_RXIEN,.04,"I")
 Q RXQTY
 ;
RXDAYSUP(RXIEN,FILL) ; Returns the Days Supply for the Fill
 ; Input:  (r) RXIEN - Rx IEN (#52) 
 ;         (o) FILL  - Refill # (Default: most recent)
 ; Output:  RXDAYSUP - Days Supply
 N RXDAYSUP
 I '$G(RXIEN) Q ""
 S RXDAYSUP=$$GET1^DIQ(52,RXIEN,8,"I")
 I '$D(FILL) S FILL=$$LSTRFL^PSOBPSU1(RXIEN)
 I FILL S RXDAYSUP=$$GET1^DIQ(52.1,FILL_","_RXIEN,1.1,"I")
 I FILL["P" S RXDAYSUP=$$GET1^DIQ(52.2,+$E(FILL,2,9)_","_RXIEN,.041,"I")
 Q RXDAYSUP
 ;
RXPRV(RXIEN,FILL) ; Returns the Rx Fill Provider IEN
 ; Input:  (r) RXIEN  - Rx IEN (#52) 
 ;         (o) FILL - Refill # (Default: most recent - except Partial)
 ;                    Note: "P1", "P2"... represent partial fills
 ; Output:  RXPRV - Rx Fill Provider IEN
 N RXPRV
 I '$G(RXIEN) Q ""
 I '$D(FILL) S RFL=$$LSTRFL^PSOBPSU1(RXIEN)
 I FILL S RXPRV=$$GET1^DIQ(52.1,FILL_","_RXIEN,15,"I")
 I FILL["P" S RXPRV=$$GET1^DIQ(52.2,+$E(FILL,2,9)_","_RXIEN,6,"I")
 I '$G(RXPRV) S RXPRV=$$GET1^DIQ(52,RXIEN,4,"I")
 Q RXPRV
 ;
RXRPH(RXIEN,FILL) ; Returns the Pharmacist IEN for the Fill
 ; Input:  (r) RXIEN - Rx IEN (#52) 
 ;         (o) FILL  - Refill # (Default: most recent)
 ; Output:  RXRPH - Pharmacist IEN (Pointer to File #200)
 N RXRPH
 I '$G(RXIEN) Q ""
 I '$D(FILL) S FILL=$$LSTRFL^PSOBPSU1(RXIEN)
 I FILL S RXRPH=$$GET1^DIQ(52.1,FILL_","_RXIEN,4,"I")
 I FILL["P" S RXRPH=$$GET1^DIQ(52.2,+$E(FILL,2,9)_","_RXIEN,.05,"I")
 I '$G(RXRPH) S RXRPH=$$GET1^DIQ(52,RXIEN,23,"I")
 Q RXRPH
 ;
VALUE(RX,FILL,ORFLD,RFFLD,PRFLD,OROK) ; Retrieve corresponding Internal value for the specific prescription fill
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (r) FILL - Refill #
 ;         (r) ORFLD - Original Fill Field #
 ;         (r) RFFLD - Refill Field #
 ;         (r) PRFLD - Partial Field #
 ;         (o) OROK  - OK to retrieve from Original Fill (1: YES/0:NO)
 ; Output:  VALUE - Fill Field Value
 ;
 N VALUE
 I '$G(RX)!($G(FILL)="") Q ""
 I RFFLD,FILL S VALUE=$$GET1^DIQ(52.1,FILL_","_RX,RFFLD,"I")
 I PRFLD,FILL["P" S VALUE=$$GET1^DIQ(52.2,+$E(FILL,2,9)_","_RX,PRFLD,"I")
 I ORFLD,(FILL=0!(($G(VALUE)="")&$G(OROK))) S VALUE=$$GET1^DIQ(52,RX,ORFLD,"I")
 Q $G(VALUE)
 ;
MANREL(RX,RFL,PID) ; ePharmacy Manual Rx Release
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill # (Default: most recent)
 ;       (o) PID - Displays PID/Drug/Rx in the NDC prompts
 ;Output: "" (null - OK to Release) OR "^" (User entered "^", or no valid NDC on file for ePharmacy Rx)
 ;       
 N ACTION
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; Check for unresolved TRICARE/CHAMPVA non-billable reject code, PSO*7*358
 I $$PSOET^PSOREJP3(RX,RFL) W ! Q "^"
 ; Checking for REJECTS before proceeding to Rx Release
 I $$FIND^PSOREJUT(RX,RFL) D  I ACTION="Q"!(ACTION="^") W ! Q "^"
 . S ACTION=$$HDLG^PSOREJU1(RX,RFL,"79,88,943","ED","OIQ","Q")
 ; - ePharmacy switch is OFF
 I '$$ECMEON^BPSUTIL($$RXSITE^PSOBPSUT(RX,RFL)) Q ""
 ; - Not an ePharmacy Rx
 I $$STATUS^PSOBPSUT(RX,RFL)="" Q ""
 I '$D(PSOTRIC) N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 ; - NDC editing before Rx release
 S ACTION=$$CHGNDC^PSONDCUT(RX,RFL,$G(PID))
 I ACTION="^"!(ACTION=2) D  Q "^"
 . W:ACTION="^" !!,$C(7),"A valid NDC must be entered before the Release function can be completed.",! H 1
 . I $G(PSOTRIC) D:ACTION=2 TRIC
 ; - Checking for OPEN/UNRESOLVED 3rd. Party Payer Rejects (After possible NDC edit)
 I $$FIND^PSOREJUT(RX,RFL) D  I ACTION="Q"!(ACTION="^") W ! Q "^"
 . S ACTION=$$HDLG^PSOREJU1(RX,RFL,"79,88,943","ED","OIQ","Q")
 I $G(PSOTRIC),$$STATUS^PSOBPSUT(RX,RFL)["IN PROGRESS" D TRIC Q "^"
 Q ""
 ;
TRIC ;
 W !!,$C(7),$S(PSOTRIC=1:"TRICARE",1:"CHAMPVA")_" Rx remains in 'IN PROGRESS' status for ECME, and cannot be released.",! H 1
 Q
 ;
AUTOREL(RX,RFL,RLDT,NDC,SRC,STS,HNG) ; Sends Rx Release information to ECME/IB and updates NDC
 ;                                     in the DRUG/PRESCRIPTION files
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill #  (Default: most recent)
 ;       (r) RLDT- Release Date
 ;       (r) NDC - NDC Number (Must be 11 digits)
 ;       (o) SRC - SOURCE: "C" - CMOP / "A" - OPAI
 ;       (o) STS - Status: (S)uccessful/(U)nsuccessful Release (Default: "S" - Successful)
 ;       (o) HNG - HANG time after resubmission and before checking the status of the claim (Default: 0)
 ;       
 N RXNDC,SITE
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S:'$D(STS) STS="S" S:'$D(SRC) SRC="" S HNG=+$G(HNG)
 S RXNDC=$$GETNDC^PSONDCUT(RX,RFL)
 ; - Saves the NDC from CMOP/Automated Dispensing Machine in the Prescription file
 I $$NDCFMT^PSSNDCUT(NDC)'="" D SAVNDC^PSONDCUT(RX,RFL,$$NDCFMT^PSSNDCUT(NDC),$S(SRC="C":1,1:0))
 ; - Not an ePharmacy Rx
 I $$STATUS^PSOBPSUT(RX,RFL)="" Q ""
 ; - Unsuccessful Release 
 I STS="U" D  Q
 . D REVERSE^PSOBPSU1(RX,RFL,"CRLX",,"UNSUCCESSFUL "_$S(SRC="C":"CMOP",1:"EXT INTERFACE")_" RELEASE",1)
 ; - Notifying IB of a Rx RELEASE event 
 D RELEASE^PSOBPSU1(RX,RFL)
 ; - Invalid NDC from Automated Dispensing Machine
 I SRC="A",$$NDCFMT^PSSNDCUT(NDC)="" D  Q
 . D REVERSE^PSOBPSU1(RX,RFL,"CRLR",,"INVALID EXT INTERFACE NDC",1,NDC)
 ; - Invalid NDC number for CMOP
 I SRC="C",$$NDCFMT^PSSNDCUT(NDC)="" D  Q
 . D REVERSE^PSOBPSU1(RX,RFL,"CRLR",,"INVALID CMOP NDC",1,NDC)
 ; - If NDC not equal RXNDC, issue reversal and submit new claim
 I SRC="A",$$NDCFMT^PSSNDCUT(NDC)'=RXNDC D  Q
 . D ECMESND^PSOBPSU1(RX,RFL,RLDT,"CRLB",$$NDCFMT^PSSNDCUT(NDC),,"AUTO RELEASE",,1,,1),UPDFL^PSOBPSU2(RX,RFL,RLDT)
 . H HNG
 . ; - If new claim returned PAYABLE, save new NDC in the DRUG/PRESCRIPTION files
 . I $$STATUS^PSOBPSUT(RX,RFL)="E PAYABLE" D SAVNDC^PSONDCUT(RX,RFL,$$NDCFMT^PSSNDCUT(NDC),0,1)
 ; - If NDC not equal RXNDC, issue reversal and submit new claim
 I SRC="C",$$NDCFMT^PSSNDCUT(NDC)'=RXNDC D  Q
 . ; - Reverse/Resubmit with correct NDC
 . D ECMESND^PSOBPSU1(RX,RFL,RLDT,"CRLB",$$NDCFMT^PSSNDCUT(NDC),1,"CMOP RELEASE",,1,,1),UPDFL^PSOBPSU2(RX,RFL,RLDT)
 . ; - Wait for a response from the Payer for the submission above
 . H HNG
 . ; - If new claim returned PAYABLE, save new NDC in the DRUG/PRESCRIPTION files
 . I $$STATUS^PSOBPSUT(RX,RFL)="E PAYABLE" D SAVNDC^PSONDCUT(RX,RFL,$$NDCFMT^PSSNDCUT(NDC),1,1)
 ; - Calls ECME api responsible for notifying IB to create a BILL
 D IBSEND(RX,RFL,$S(SRC="C":2,1:1),NDC)
 Q
 ;
IBSEND(RX,RFL,AUTO,PSONDC) ; Rx Release
 ; Create Release Event
 ; Calls ECME, if needed
 ; If Payable or Duplicate, calls IB to create a bill
 ;
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill #  (Default: most recent)
 ;       (o) AUTO - Set if called by Auto Release Process (1=OPAI, 2=CMOP)
 ;       (o) PSONDC - NDC to be on outgoing claim
 ;
 N PSORELDT
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; - ECME turned OFF for Rx's site
 I '$$ECMEON^BPSUTIL($$RXSITE^PSOBPSUT(RX,RFL)) Q
 N STATUS
 S STATUS=$$STATUS(RX,RFL)
 ; - Not an ePharmacy Rx
 I STATUS="" Q ""
 ; - Notifying IB of a Rx RELEASE event 
 ; - Do not call for auto release process as it has already been done
 S AUTO=+$G(AUTO)
 I 'AUTO D RELEASE^PSOBPSU1(RX,RFL,DUZ)
 ; - If the previous ECME claim was reversed or incomplete, re-submit the claim to the payer
 I (STATUS="E REVERSAL ACCEPTED")!(STATUS="IN PROGRESS") D  Q
 . S PSORELDT=$$RXRLDT^PSOBPSUT(RX,RFL)
 . S PSONDC=$$NDCFMT^PSSNDCUT($G(PSONDC))
 . D ECMESND^PSOBPSU1(RX,RFL,PSORELDT,$S(AUTO:"C",1:"")_"RRL",PSONDC,$S(AUTO=2:1,1:""))
 ; - Notifying ECME of a BILLING event 
 I STATUS="E PAYABLE"!(STATUS="E DUPLICATE") D  Q
 . N PSOCLAIM S PSOCLAIM=$$CLAIM^BPSBUTL(RX,RFL)
 . D IBSEND^BPSECMP2($P(PSOCLAIM,"^",2),$P(PSOCLAIM,"^",3),"BILL",DUZ)
 Q
 ;
RETRX(RX,RFL) ; - Re-transmit a claim for the prescription/fill?
 ;Input: (r) RX  - Rx IEN (#52)
 ;       (o) RFL - Refill # (Default: most recent)
 ;Output: 1 - Re-transmit  /  0 - Don't re-transmit
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I RFL Q +$$GET1^DIQ(52.1,RFL_","_RX,82,"I")
 Q +$$GET1^DIQ(52,RX,82,"I")

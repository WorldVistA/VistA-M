PSOBPSU1 ;BIRM/MFR - BPS (ECME) Utilities 1 ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**148,260,281,287,303,289,290,358,359,385,403,427**;DEC 1997;Build 21
 ;Reference to $$EN^BPSNCPDP supported by IA 4415 & 4304
 ;References to $$NDCFMT^PSSNDCUT,$$GETNDC^PSSNDCUT supported by IA 4707
 ;References to $$ECMEON^BPSUTIL,$$CMOPON^BPSUTIL supported by IA 4410
 ;References to $$STORESP^IBNCPDP supported by IA 4299
 ;Reference to $$CLAIM^BPSBUTL supported by IA 4719
 ;
ECMESND(RX,RFL,DATE,FROM,NDC,CMOP,RVTX,OVRC,CNDC,RESP,IGSW,ALTX,CLA,PA,RXCOB) ; - Sends Rx Release 
 ;information to ECME/IB and updates NDC in the files 50 & 52; DBIA4304
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;       (o) DATE - Date of Service
 ;       (r) FROM - Function within OP (See BWHERE param. in EN^BPSNCPDP api)
 ;       (o) NDC  - NDC Number (If not passed, will be retrieved from DRUG file)
 ;       (o) CMOP - CMOP Rx (1-YES/0-NO) (Default: 0)
 ;       (o) RVTX - REVERSE text (e.g., RX EDIT, RX RELEASE-NDC CHANGE, etc)
 ;       (o) OVRC - Three sets of 3 NCPDP override codes separated by "~".  Each piece of the set 
 ;                  is delimited by an "^"
 ;                  Piece 1: NCPDP Reason for Service Code for overriding DUR REJECTS
 ;                  Piece 2: NCPDP Professional Service Code for overriding DUR REJECTS
 ;                  Piece 3: NCPDP Result of Service Code for overriding DUR REJECTS
 ;       (o) CNDC - Changed NDC? 1 - Yes / 0 - No (Default: NO)
 ;       (o) IGSW - Ignore Switches (Master and CMOP)? 1 - Yes / 0 - No (Default: NO)
 ;       (o) ALTX - Alternative Text to be placed in the Rx ECME Activity Log
 ;       (o) CLA  - NCPDP Clarification Code(s) for overriding DUR/RTS REJECTS
 ;       (o) PA   - NCPDP Prior Authorization Type and Number (separated by "^")
 ;       (o) RXCOB- Payer Sequence
 ;Output:    RESP - Response from $$EN^BPSNCPDP api
 ;
 N ACT,NDCACT,DA,PSOELIG,PSOBYPS,ACT1,SMA
 I '$D(RFL) S RFL=$$LSTRFL(RX)
 ; - ECME is not turned ON for the Rx's Division
 I '$G(IGSW),'$$ECMEON^BPSUTIL($$RXSITE^PSOBPSUT(RX,RFL)) S RESP="-1^ECME SWITCH OFF" Q
 ; - ECME CMOP is not turned ON for the Rx's Division
 I '$G(IGSW),$G(CMOP),'$$CMOPON^BPSUTIL($$RXSITE^PSOBPSUT(RX,RFL)) S RESP="-1^CMOP SWITCH OFF" Q
 ; - Saving the NDC to be displayed on the ECME Act Log
 I $G(CNDC) D
 . I $G(NDC)'="" S NDCACT=NDC Q
 . S NDCACT=$$GETNDC^PSONDCUT(RX,RFL)
 I $$NDCFMT^PSSNDCUT($G(NDC))="" D
 . S NDC=$$GETNDC^PSSNDCUT($$GET1^DIQ(52,RX,6,"I"),$$RXSITE^PSOBPSUT(RX,RFL),+$G(CMOP))
 . I $G(NDC)'="" D SAVNDC^PSONDCUT(RX,RFL,NDC,+$G(CMOP),1)
 S PPDU="",PPDU=$$GPPDU^PSONDCUT(RX,RFL,NDC,,1,FROM) K PPDU
 ;
 ; Determine if this has multiple overrides from the SMA action of the reject worklist
 S SMA=0
 I $G(OVRC)]"",$G(CLA)]"" S SMA=1
 I $G(OVRC)]"",$G(PA)]"" S SMA=1
 I $G(CLA)]"",$G(PA)]"" S SMA=1
 ;
 ; - Creating ECME Act Log in file 52
 S ACT="" I $$STATUS^PSOBPSUT(RX,RFL)="E PAYABLE" S ACT="Rev/Resubmit"
 S ACT=ACT_" ECME:"
 ;
 ; - Marked any 'unresolved' REJECTS as 'resolved' (Reason: 1 - Claim re-submitted)
 N CLSCOM
 I 'SMA D
 . I $P($G(OVRC),"~")'="" S CLSCOM="DUR Override Codes "_$TR($P(OVRC,"~"),"^","/")_" submitted."
 . I $G(CLA)'="" S CLSCOM="Clarification Code(s) "_CLA_" submitted."
 . I $G(PA)'="" S CLSCOM="Prior Authorization Code ("_$P(PA,"^")_"/"_$P(PA,"^",2)_") submitted."
 D CLSALL^PSOREJUT(RX,RFL,DUZ,1,$G(CLSCOM),$P($G(OVRC),"~",1),$P($G(OVRC),"~",2),$P($G(OVRC),"~",3),$G(CLA),$G(PA))
 ; - Call to ECME (NEWing STAT because ECME was overwriting it - Important variable for CMOP release PSXVND)
 N STAT
 I $G(RVTX)="",FROM="ED" S RVTX="RX EDITED"
 S RESP=$$EN^BPSNCPDP(RX,RFL,$$DOS(RX,RFL,.DATE),FROM,NDC,$G(RVTX),$G(OVRC),,$G(CLA),$G(PA),$G(RXCOB))
 I $$STATUS^PSOBPSUT(RX,RFL)="E PAYABLE" D SAVNDC^PSONDCUT(RX,RFL,NDC,+$G(CMOP),1,FROM)
 ;
 ; - Reseting the Re-transmission flag
 D RETRXF^PSOREJU2(RX,RFL,0)
 ; Storing eligibility flag
 S PSOELIG=$P(RESP,"^",3) D:PSOELIG'="" ELIG^PSOBPSU2(RX,RFL,PSOELIG)
 ;
 ; Check if this is a bypass RX-claim.  If it is, write it to the Bypass-Override Report
 S PSOBYPS=$$BYPASS(PSOELIG,$P(RESP,"^",2))
 I PSOBYPS D EN^PSOBORP2(RX,RFL,RESP)
 ;
 ; If from SMA action, split message across multiple log entries
 ; The last entry will be filed in the code that follows this section as we append other data
 ;   to the last message.
 I SMA,+RESP'=2,+RESP'=6,+RESP'=10 D
 . N MSG
 . ; If there are DUR overrides, create the message and file it since this will never be the last message
 . I $G(OVRC)]"" D
 .. S MSG=ACT_"REJECT WORKLIST-DUR OVERRIDE CODES("_$TR(OVRC,"^","/")_")"
 .. D RXACT^PSOBPSU2(RX,RFL,MSG,"M",DUZ)
 . ; If there are Clarification codes, create the message
 . ; Only file it if we also have a Prior Auth message.
 . ; Otherwise more data will be added to it and it will be filed below.
 . I $G(CLA)]"" D
 .. S MSG=ACT_"REJECT WORKLIST-(CLARIF. CODE="_CLA_")"
 .. I $G(PA)]"" D RXACT^PSOBPSU2(RX,RFL,MSG,"M",DUZ)
 . ; If there are Prior Auth overrides, create the message.
 . ; More data will be added to it and it will be filed below.
 . I $G(PA)]"" D
 .. S ALTX="REJECT WORKLIST-(PRIOR AUTH.="_$TR(PA,"^","/")_")"
 ;
 ; - Logging ECME Act Log to file 52
 I $G(ALTX)="" D
 . N X,ROUTE S (ROUTE,X)=""
 . S ROUTE=$S(FROM="RF":$$GET1^DIQ(52.1,RFL_","_RX_",",2),FROM="OF":$$GET1^DIQ(52,RX_",",11),1:"")
 . S:FROM="OF" X=ROUTE_" FILL(NDC:"_$$GETNDC^PSONDCUT(RX,RFL)_")"
 . S:FROM="RF" X=ROUTE_" REFILL(NDC:"_$$GETNDC^PSONDCUT(RX,RFL)_")"
 . S:FROM="RN" X="RX RENEWED(NDC:"_$$GETNDC^PSONDCUT(RX,RFL)_")"
 . S:FROM="PL" X="PRINTED FROM SUSPENSE(NDC:"_$$GETNDC^PSONDCUT(RX,RFL)_")"
 . S:FROM="PE"!(FROM="PP") X="PULLED FROM SUSPENSE(NDC:"_$$GETNDC^PSONDCUT(RX,RFL)_")"
 . S:FROM="PC" X="CMOP TRANSMISSION(NDC:"_$$GETNDC^PSONDCUT(RX,RFL)_")"
 . S:FROM="RRL"!(FROM="CRRL") X="RELEASED RX PREVIOUSLY REVERSED"
 . S:FROM="ED" X="RX EDITED"
 . S:$G(RVTX)'="" X=RVTX
 . I 'SMA,$G(OVRC)'="" S X="DUR OVERRIDE CODES("_$TR(OVRC,"^","/")_")"
 . S:$G(CNDC) X=X_"(NDC:"_NDCACT_")" S ACT=ACT_X
 . S ACT=ACT_$$STS(RX,RFL,RESP)
 I $G(ALTX)'="" S ACT=ACT_ALTX_$$STS(RX,RFL,RESP)
 I +RESP=2 S ACT="Not ECME Billable: "_$P(RESP,"^",2)
 I +RESP=6 S ACT=$P(RESP,"^",2)
 I +RESP=10 S ACT="ECME reversed/NOT re-submitted: "_$P(RESP,"^",2)
 S:PSOELIG="T" ACT="TRICARE-"_ACT
 S:PSOELIG="C" ACT="CHAMPVA-"_ACT
 S ACT1=""
 I $P(RESP,"^",6),$P(RESP,"^",7)'=""  S ACT1="-"_$S($P(RESP,"^",6)="2":"s",$P(RESP,"^",6)="3":"t",1:"p")_$P(RESP,"^",7)
 S ACT=$E(ACT_ACT1,1,75)
 D RXACT^PSOBPSU2(RX,RFL,ACT,"M",DUZ)
 D ELOG^PSOBPSU2(RESP)  ;-Logs an ECME Act Log if Rx Qty is different than Billing Qty
 ; If not a bypass RX-claim, then call TRICCHK so the user can process
 I PSOELIG="T"!(PSOELIG="C"),'PSOBYPS D TRICCHK^PSOREJU3(RX,RFL,RESP,FROM,$G(RVTX))
 Q
 ;
BYPASS(PSOELIG,REASON) ;PSO*427
 ; Check if this Rx gets bypassed. Bypassed Rx show up on the TRICARE/CHAMPVA
 ;   Override/Bypass Report and will not get the Reject Notification Screen.
 ;
 ; Input:
 ;    POSELIG: Eligibility (C:CHAMPVA, T:TRICARE, V:VETERAN)
 ;    REASON: Non billable reason returned by ECME
 ; Output:
 ;    0: Not a Bypass Rx
 ;    1: Bypass Rx
 ;
 ; Check Parameters
 I $G(PSOELIG)="" Q 0
 I $G(REASON)="" Q 0
 ;
 ; Only TRICARE and CHAMPVA are bypassed
 I PSOELIG'="T",PSOELIG'="C" Q 0
 ;
 ; Check for TRICARE/CHAMPVA and EI (Veteran claims would not have gotten this far)
 I ",AGENT ORANGE,IONIZING RADIATION,SC TREATMENT,SOUTHWEST ASIA,MILITARY SEXUAL TRAUMA,HEAD/NECK CANCER,COMBAT VETERAN,SHAD^PROJECT 112/SHAD,"[(","_REASON_",") Q 1
 Q 0
 ;
REVERSE(RX,RFL,FROM,RSN,RTXT,IGRL,NDC) ; - Reverse a claim and close all OPEN/UNRESOLVED Rejects
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;       (r) FROM - Function within OP (See BWHERE param. in EN^BPSNCPDP api)
 ;       (o) RSN  - Close Reason (2:RX ON HOLD;4: RX RETURNED TO STOCK,5:RX DELETED,etc...)
 ;       (o) RTXT - Close Reason TEXT (Usually no passed if RSN is passed)
 ;       (o) IGRL - Ignore RELEASE DATE, reverse anyway  
 ;       (o) NDC  - NDC number related to the reversal (Note: might be an invalid NDC)
 I '$D(RFL) S RFL=$$LSTRFL(RX)
 N PSOET S PSOET=$$PSOET^PSOREJP3(RX,RFL)   ;cnf, PSO*7.0*358
 I 'PSOET,$$STATUS^PSOBPSUT(RX,RFL)="" Q    ;cnf, PSO*7.0*358, add PSOET check, allow reversal for TRICARE non-billable reject
 N RESP,STS,ACT,STAT,DA,STATUS,NOACT,REVECME S RSN=+$G(RSN),RTXT=$G(RTXT),REVECME=1
 I RTXT="",RSN D
 . S:RSN=2 RTXT="RX PLACED ON HOLD" S:RSN=3 RTXT="RX SUSPENDED" S:RSN=4 RTXT="RX RETURNED TO STOCK"
 . S:RSN=5 RTXT="RX DELETED" S:RSN=7 RTXT="RX DISCONTINUED" S:RSN=8 RTXT="RX EDITED"
 D CLSALL^PSOREJUT(RX,RFL,DUZ,RSN,RTXT)
 I '$G(IGRL),$$RXRLDT^PSOBPSUT(RX,RFL) Q
 ; - Reseting the Re-transmission flag if Rx is being suspended
 I RSN=3!($$GET1^DIQ(52,RX,100,"I")=5) D RETRXF^PSOREJU2(RX,RFL,1)
 S STATUS=$$STATUS^PSOBPSUT(RX,RFL),NOACT=0
 I STATUS'="E PAYABLE",STATUS'="IN PROGRESS",STATUS'="E REVERSAL REJECTED",STATUS'="E REVERSAL STRANDED",STATUS'="E DUPLICATE" S NOACT=1
 ; Only perform ECME reversal for a released CMOP if rx/fill is Discontinued.
 I FROM="DC",$$CMOP^PSOBPSUT(RX,RFL) S REVECME=0
 I REVECME S RESP=$$EN^BPSNCPDP(RX,RFL,$$DOS(RX,RFL),FROM,$$GETNDC^PSONDCUT(RX,RFL),RTXT)
 N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 ; - Logging ECME Act Log
 I '$G(NOACT),REVECME D
 . S ACT=$S(PSOTRIC=1:"TRICARE ",PSOTRIC=2:"CHAMPVA ",1:"")_"Reversal sent to ECME: "_RTXT_$S($G(NDC)'="":" ("_NDC_")",1:"")_$$STS(RX,RFL,+RESP)
 . D RXACT^PSOBPSU2(RX,RFL,ACT,"M",DUZ)
 Q
 ;
DOS(RX,RFL,DATE) ; Return the Date Of Service for ECME
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;       (o) DATE - Possible Date Of Service
 ;Output:    DOS  - Actual Date Of Service
 I '$D(RFL) S RFL=$$LSTRFL(RX)
 ; - Retrieving RELEASE DATE from file 52 if DATE not passed in
 I $G(DATE)="" S DATE=$$RXRLDT^PSOBPSUT(RX,RFL)
 ; - If no date or future date, use today's date
 I DATE>DT!'DATE S DATE=$$DT^XLFDT
 Q (DATE\1)
 ;
RELEASE(RX,RFL,USR) ; - Notifies IB that the Rx was RELEASED
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (o) USR  - User responsible for releasing the Rx (Default: .5 - Postmaster)
 N IBAR,RXAR,RFAR,PSOIBN
 S:'$D(RFL) RFL=$$LSTRFL(RX)
 S:'$D(USR) USR=.5
 D GETS^DIQ(52,RX_",",".01;2;6;7;8;22","I","RXAR")
 S DFN=+$G(RXAR(52,RX_",",2,"I"))
 S IBAR("PRESCRIPTION")=RX,IBAR("RX NO")=$G(RXAR(52,RX_",",.01,"I"))
 S IBAR("CLAIMID")=$P($$CLAIM^BPSBUTL(RX,RFL),U,6)
 S IBAR("USER")=USR
 S IBAR("DRUG")=RXAR(52,RX_",",6,"I"),IBAR("NDC")=$$GETNDC^PSONDCUT(RX,RFL)
 S IBAR("FILL NUMBER")=RFL,IBAR("DOS")=$$DOS(RX,RFL),IBAR("RELEASE DATE")=$$RXRLDT^PSOBPSUT(RX,RFL)
 S IBAR("QTY")=$G(RXAR(52,RX_",",7,"I")),IBAR("DAYS SUPPLY")=$G(RXAR(52,RX_",",8,"I"))
 I RFL D
 . D GETS^DIQ(52.1,RFL_","_RX_",",".01;1;1.1","I","RFAR")
 . S IBAR("QTY")=$G(RFAR(52.1,RFL_","_RX_",",1,"I"))
 . S IBAR("DAYS SUPPLY")=$G(RFAR(52.1,RFL_","_RX_",",1.1,"I"))
 S IBAR("STATUS")="RELEASED"
 S PSOIBN=$$STORESP^IBNCPDP(DFN,.IBAR)
 Q
 ;
LSTRFL(RX) ;  - Returns the latest fill for the Rx
 ; Input: (r) RX     - Rx IEN (#52)
 ;Output:     LSTRFL - Most recent refill #
 N I,LSTRFL
 S (I,LSTRFL)=0 F  S I=$O(^PSRX(RX,1,I)) Q:'I  S LSTRFL=I
 Q LSTRFL
 ;
ECMEACT(RX,RFL,COMM,USR) ; - Add an Act to the ECME Act Log (FILE 52)
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;       (r) COMM - Comments (up to 75 characters)
 ;       (o) USR  - User logging the comments (Default: DUZ)
 S:'$D(RFL) RFL=$$LSTRFL^PSOBPSU1(RX)
 D RXACT^PSOBPSU2(RX,RFL,COMM,"M",+$G(USR))
 Q
 ;
STS(RX,RFL,RSP) ; Adds the Status to the ECME Act Log according to Rx/fill claim status Response
 N STS
 S STS=$S($$STATUS^PSOBPSUT(RX,RFL)'="IN PROGRESS"&($$STATUS^PSOBPSUT(RX,RFL)'=""):"-"_$$STATUS^PSOBPSUT(RX,RFL),1:"")
 S:+RSP=1 STS="-NO SUBMISSION THROUGH ECME" S:+RSP=3 STS="-NO REVERSAL NEEDED" S:+RSP=4 STS="-NOT PROCESSED"
 S:+RSP=5 STS="-SOFTWARE ERROR"_$S($P($G(RESP),"^",2)'="":" ("_$P(RESP,"^",2)_")",1:"")
 I +RSP=2,$$STATUS^PSOBPSUT(RX,RFL)'="" S STS="-NOT BILLABLE:"_$S(PSOELIG="T":"TRICARE",PSOELIG="C":"CHAMPVA",1:"")_":"_$P(RSP,"^",2)
 Q STS

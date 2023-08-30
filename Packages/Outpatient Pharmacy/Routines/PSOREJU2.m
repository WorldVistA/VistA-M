PSOREJU2 ;BIRM/MFR - BPS (ECME) - Clinical Rejects Utilities (1) ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**148,260,287,341,290,358,359,385,403,421,427,478,562,680,681**;DEC 1997;Build 11
 ; Reference to $$TAXID^IBCEF75 in ICR #6768
 ; Reference to $$DIVNCPDP^BPSBUTL in ICR #4719
 ; Reference to 9002313.23 in ICR #4714
 ; Reference to $$CSNPI^BPSUTIL in ICR #4146
 ;
GET(RX,RFL,REJDATA,REJID,OKCL,CODE,RRRFLG) ; get reject data from subfile 52.25
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (r) REJDATA(REJECT IEN,FIELD) - Array where these Reject fields will be returned:
 ;                       "BIN" - Payer BIN number
 ;                       "PCN" - Processor Control Number
 ;                       "CODE" - Reject Code (79 or 88 or 943)
 ;                       "DATE/TIME" - DATE/TIME Reject was detected
 ;                       "PAYER MESSAGE" - Message returned by the payer
 ;                       "REASON" - Reject Reason description (from payer)
 ;                       "INSURANCE NAME" - Patient's Insurance Company Name
 ;                       "INSURANCE POINTER" - Patient Insurance Company Pointer
 ;                       "COB" - Coordination of Benefits
 ;                       "GROUP NAME" - Patient's Insurance Group Name
 ;                       "GROUP NUMBER" - Patient's Insurance Group Number
 ;                       "CARDHOLDER ID" - Patient's Insurance Cardholder ID
 ;                       "PLAN CONTACT" - Plan's Contact (eg., "1-800-...")
 ;                       "PLAN PREVIOUS FILL DATE" - Last time Rx was paid by payer
 ;                       "STATUS" - REJECTS status ("OPEN/UNRESOLVED" or "CLOSED/RESOLVED")
 ;                       "DUR TEXT" - Payer's DUR description
 ;                       "DUR ADD MSG TEXT" - Payer's DUR additional description
 ;                       "OTHER REJECTS" - Other Rejects on the same response
 ;                       "REASON SVC CODE" - Reason for Service Code
 ;                  If REJECT is closed, the following fields will be returned:
 ;                       "CLA CODE" - Clarification Code submitted
 ;                       "PRIOR AUTH TYPE" - Prior Authorization Type
 ;                       "PRIOR AUTH NUMBER" - Prior Authorization Type
 ;                       "CLOSED DATE/TIME" - DATE/TIME Reject was closed
 ;                       "CLOSED BY" - Name of the user responsible for closing Reject
 ;                       "CLOSE REASON" - Reason for closing Reject (text)
 ;                       "CLOSE COMMENTS" - User entered comments at close
 ;         (o) REJID - REJECT IEN in the PRESCRIPTION file for retrieve this REJECT
 ;         (o) OKCL - If set to 1, CLOSED REJECTs will also be returned
 ;         (o) CODE - Only REJECTs with this CODE should be returned
 ;         (o) RRRFLG - If set to 1 with CODE present, also return Reject Resolution Required REJECTs
 ;                      If set to 1 and CODE not passed, then only return RRR REJECTs
 ;
 N REJS,ARRAY,REJFLD,IDX,COM,Z
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 K REJDATA
 I '$O(^PSRX(RX,"REJ",0)) Q
 ;
 K REJS S RFL=+$G(RFL)
 I $G(REJID) D
 . I +$P($G(^PSRX(RX,"REJ",REJID,0)),"^",4)'=RFL Q
 . I '$G(OKCL),$P($G(^PSRX(RX,"REJ",REJID,0)),"^",5) Q
 . S REJS(REJID)=""
 E  D
 . S IDX="A"
 . F  S IDX=$O(^PSRX(RX,"REJ",IDX),-1) Q:'IDX  D
 . . I +$P($G(^PSRX(RX,"REJ",IDX,0)),"^",4)'=RFL Q
 . . I '$G(OKCL),$P($G(^PSRX(RX,"REJ",IDX,0)),"^",5) Q
 . . S REJS(IDX)=""
 I '$D(REJS) Q
 ;
 S IDX=0
 F  S IDX=$O(REJS(IDX)) Q:'IDX  D
 . N SKIP
 . K ARRAY D GETS^DIQ(52.25,IDX_","_RX_",","*","","ARRAY")
 . K REJFLD M REJFLD=ARRAY(52.25,IDX_","_RX_",")
 . ;
 . ; check CODE and RRRFLG to see if we want this reject data
 . S SKIP=0    ; default is to include it
 . I $G(CODE)'="",REJFLD(.01)'=CODE S SKIP=1               ; CODE exists and doesn't match this reject
 . I SKIP,$G(RRRFLG),$G(REJFLD(30))="YES" S SKIP=0         ;  but include these if RRRFLG is true and this is an RRR reject
 . I $G(CODE)="",$G(RRRFLG),$G(REJFLD(30))'="YES" S SKIP=1 ; want only RRR rejects in this case
 . I SKIP Q    ; get out if we're skipping this one
 . ;
 . S REJDATA(IDX,"CODE")=$G(REJFLD(.01))
 . S REJDATA(IDX,"DATE/TIME")=$G(REJFLD(1))
 . S REJDATA(IDX,"PAYER MESSAGE")=$G(REJFLD(2))
 . S REJDATA(IDX,"REASON")=$G(REJFLD(3))
 . S REJDATA(IDX,"PHARMACIST")=$G(REJFLD(4))
 . S REJDATA(IDX,"INSURANCE NAME")=$G(REJFLD(20))
 . S REJDATA(IDX,"INSURANCE POINTER")=$G(REJFLD(33))  ;PSO*427
 . S REJDATA(IDX,"COB")=$G(REJFLD(27))
 . S REJDATA(IDX,"GROUP NAME")=$G(REJFLD(6))
 . S REJDATA(IDX,"GROUP NUMBER")=$G(REJFLD(21))
 . S REJDATA(IDX,"BIN")=$G(REJFLD(29))
 . S REJDATA(IDX,"PCN")=$G(REJFLD(34))
 . S REJDATA(IDX,"CARDHOLDER ID")=$G(REJFLD(22))
 . S REJDATA(IDX,"PLAN CONTACT")=$G(REJFLD(7))
 . S REJDATA(IDX,"PLAN PREVIOUS FILL DATE")=$G(REJFLD(8))
 . S REJDATA(IDX,"STATUS")=$G(REJFLD(9))
 . S REJDATA(IDX,"OTHER REJECTS")=$G(REJFLD(17))
 . S REJDATA(IDX,"DUR TEXT")=$G(REJFLD(18))
 . S REJDATA(IDX,"DUR ADD MSG TEXT")=$G(REJFLD(28))
 . S REJDATA(IDX,"REASON SVC CODE")=$G(REJFLD(14))
 . S REJDATA(IDX,"RESPONSE IEN")=$G(REJFLD(16))
 . S REJDATA(IDX,"RRR FLAG")=$G(REJFLD(30))  ;PSO*421
 . S REJDATA(IDX,"RRR THRESHOLD AMT")=$G(REJFLD(31))  ;PSO*421
 . S REJDATA(IDX,"RRR GROSS AMT DUE")=$G(REJFLD(32))  ;PSO*421
 . I '$G(OKCL) Q
 . S REJDATA(IDX,"CLOSED DATE/TIME")=$G(REJFLD(10))
 . S REJDATA(IDX,"CLOSED BY")=$G(REJFLD(11))
 . S REJDATA(IDX,"CLOSE REASON")=$G(REJFLD(12))
 . S REJDATA(IDX,"CLOSE COMMENTS")=$G(REJFLD(13))
 . S REJDATA(IDX,"COD1")=$G(REJFLD(14))
 . S REJDATA(IDX,"COD2")=$G(REJFLD(15))
 . S REJDATA(IDX,"COD3")=$G(REJFLD(19))
 . S REJDATA(IDX,"CLA CODE")=$G(REJFLD(24))
 . S REJDATA(IDX,"PRIOR AUTH TYPE")=$G(REJFLD(25))
 . S REJDATA(IDX,"PRIOR AUTH NUMBER")=$G(REJFLD(26))
 . S COM=0 F  S COM=$O(^PSRX(RX,"REJ",IDX,"COM",COM)) Q:'COM  D
 . . S Z=^PSRX(RX,"REJ",IDX,"COM",COM,0)
 . . S REJDATA(IDX,"COMMENTS",COM,"DATE/TIME")=$P(Z,"^")
 . . S REJDATA(IDX,"COMMENTS",COM,"USER")=$P(Z,"^",2)
 . . S REJDATA(IDX,"COMMENTS",COM,"COMMENTS")=$P(Z,"^",3)
 Q
 ;
HELP(OPTS) ; Display the Help Text for the DUR handling options (OVERRIDE/IGNORE/STOP/QUIT)
 ;
 I OPTS["O" D
 . W !?1,"(O)verride - This option will provide the prompts for the code sets needed to"
 . W !?1,"             override this reject and get a payable 3rd party claim. Before"
 . W !?1,"             you select this option, you may need to call the 3rd party payer"
 . W !?1,"             to determine which code sets are needed to override a particular"
 . W !?1,"             reject. Once the proper override is accepted the label will print"
 . W !?1,"             and the prescription can be filled."
 ;
 I OPTS["I" D
 . W !?1,"(I)gnore   - Choosing Ignore will by-pass 3rd party processing and will allow"
 . W !?1,"             you to print a label and fill the prescription. This essentially"
 . W !?1,"             ignores the clinical safety issues suggested by the 3rd party"
 . W !?1,"             payer and will NOT result in a payable claim."
 ;           
 I OPTS["Q" D
 . W !?1,"(Q)uit     - Choosing Quit will postpone the processing of this prescription"
 . W !?1,"             until this 3rd party reject is resolved. A label will not be"
 . W !?1,"             printed for this prescription and it can not be filled/dispensed"
 . W !?1,"             until this reject is resolved. Rejects can be resolved through"
 . W !?1,"             the Worklist option under the ePharmacy menu."
 Q
 ;
DVINFO(RX,RFL,LM) ; Returns header displayable Division Information
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (o) LM   - ListManager format? (1 - Yes / 0 - No) - Default: 0
 N DVIEN,DVINFO,NCPNPI,PSOTAXID,TXT
 S DVIEN=+$$RXSITE^PSOBPSUT(RX,RFL)
 S DVINFO="Division : "_$E($$GET1^DIQ(59,DVIEN,.01),1,15)
 ;
 ; Check for Controlled Substance Drug and if a BPS Pharmacy for CS has
 ; been defined.  If so, use NCPDP# & NPI for the CS Pharmacy.
 S NCPNPI=$$CSNPI^BPSUTIL(RX,RFL)
 ;
 ; If not a Controlled Substance, use NCPDP# & NPI info based on Division.
 ; Display both NPI and NCPDP numbers
 I +NCPNPI=-1 S NCPNPI=$$DIVNCPDP^BPSBUTL(DVIEN)
 S $E(DVINFO,28)="NPI: "_$P(NCPNPI,U,2)
 S $E(DVINFO,44)="NCPDP: "_$P(NCPNPI,U)
 S PSOTAXID=$P($$TAXID^IBCEF75,U,2)      ; IA 6768
 S $E(DVINFO,62)="TAX ID: "_$E(PSOTAXID,1,2)_"-"_$E(PSOTAXID,3,$L(PSOTAXID))
 Q DVINFO
 ;
PTINFO(RX,LM) ; Returns header displayable Patient Information
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) LM   - ListManager format? (1 - Yes / 0 - No) - Default: 0
 N DFN,VADM,PTINFO,SSN4
 S DFN=$$GET1^DIQ(52,RX,2,"I") D DEM^VADPT S SSN4=$P($G(VADM(2)),"^",2)
 S PTINFO="Patient  : "_$E($G(VADM(1)),1,$S($G(LM):24,1:20))_"("_$E(SSN4,$L(SSN4)-3,$L(SSN4))_")"
 S PTINFO=PTINFO_"  Sex: "_$P($G(VADM(5)),"^")
 S $E(PTINFO,$S($G(LM):61,1:54))="DOB: "_$P($G(VADM(3)),"^",2)_"("_$P($G(VADM(4)),"^")_")"
 Q PTINFO
 ;
RETRXF(RX,RFL,ONOFF) ; - Set/Reset the Re-transmission flag
 ;Input: (r) RX    - Rx IEN (#52)
 ;       (r) RFL   - Refill IEN (#52.1)
 ;       (o) ONOFF - Turn flag ON or OFF (1 - ON / 0 - OFF) (Default: OFF) 
 I RFL>0,'$D(^PSRX(RX,1,RFL,0)) QUIT
 N DA,DIE,DR
 S DR="82///"_$S($G(ONOFF):"YES",1:"@")
 I 'RFL S DA=RX,DIE="^PSRX("
 I RFL S DA(1)=RX,DA=RFL,DIE="^PSRX("_RX_",1,"
 D ^DIE
 Q
 ;
REASON(TXT) ; Extracts the Reason for service code from the REASON text field
 ; Input: (r) TXT  - Reason text (e.g., NN Reason for Service Code Text)
 ;Output:   REASON - NN (if on valid and on file (#9002313.23), null otherwise)
 N REASON,DIC,X,Y
 S REASON=$P(TXT," ") I $L(REASON)'=2 Q ""
 S DIC=9002313.23,X=REASON D ^DIC I Y<0 Q ""
 Q REASON
 ;
SETOPN(RX,REJ) ; - Set the Reject RE-OPENED flag to YES
 ;Input: (r) RX    - Rx IEN (#52)
 ;       (r) REJ   - Reject IEN (#52.25)
 ;       
 I '$D(^PSRX(RX,"REJ",REJ)) Q
 N DIE,DA,DR
 S DIE="^PSRX("_RX_",""REJ"",",DA(1)=RX,DA=REJ,DR="23///YES" D ^DIE
 Q
 ;
PRT(FIELD,P,L) ; Sets the lines for fields that require text wrapping
 ;Input: FIELD - Subscript name from the DATA(REJ,FIELD) array
 ;         P   - Position where the content should be printed
 ;         L   - Lenght of the text on each line
 N TXT,I
 S TXT=DATA(REJ,FIELD) I $L(TXT)'>L W ?P,TXT Q
 F I=1:1 Q:TXT=""  D
 . I I=1 W ?P,$E(TXT,1,L),! S TXT=$E(TXT,L+1,999) Q
 . W ?P,$E(TXT,1,L) S TXT=$E(TXT,L+1,999) W:TXT'="" !
 Q
 ;
PA() ; - Ask for Prior Authorization Type and Number
 ; Called by PA^PSOREJP1 (PA acton) and SMA^PSOREJP1 (SMA action)
 ;
 ;Output:(PAT^PAN) PAT - Prior Authorization Type
 ;                 (See DD File #9002313.26 for possible values)
 ;                 PAN - Prior Authorization Number (11 digits)
 ;        
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PAN,PAT,X,Y
 S DIC("B")=0
 S DIC(0)="QEAM",DIC=9002313.26,DIC("A")="Prior Authorization Type: "
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT))!(Y=-1) Q "^"  ;Check for "^" or timeout
 S PAT=$P(Y,U,2)
 ;
 K DIR,DIC,X,Y
 S DIR(0)="52.25,26",DIR("A")="Prior Authorization Number"
 S DIR("?")="^D PANHLP^PSOREJU2",DIR("??")=""
 D ^DIR I (Y["^")!$D(DTOUT) Q "^"
 S PAN=Y
 Q (PAT_"^"_PAN)
 ;
PANHLP ; Prior Authorization Number Help
 W "OR you may leave it blank if the claim does not require a number."
 Q

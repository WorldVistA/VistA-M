PSOREJUT ;BIRM/MFR - BPS (ECME) - Clinical Rejects Utilities ;06/07/05
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,287,289,290,358,359,385,403,421,427,448,478,528,544,562**;DEC 1997;Build 19
 ;Reference to DUR1^BPSNCPD3 supported by IA 4560
 ;Reference to $$ADDCOMM^BPSBUTL supported by IA 4719
 ;
SAVE(RX,RFL,REJ,REOPEN) ; - Saves DUR Information in the file 52
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (o) REOPEN - value of 1 means claim being reopened; null or no value passed means reopen claim functionality not being used
 ;         (r) REJ - Array containing information about the REJECT on the following subscripts:
 ;                   "BIN" - BIN Number
 ;                   "PCN" - PCN Number
 ;                   "CODE"   - Reject Code (79 or 88 or 943)
 ;                   "DATE/TIME"   - Date/Time Reject Detected
 ;                   "PAYER MESSAGE" - Message returned by Payer (up to 140 chars long)
 ;                   "REASON" - Reject Reason (up to 100 chars long)
 ;                   "DUR TEXT" - Payer's DUR description
 ;                   "DUR ADD MSG TEXT" - Payer's DUR additional message text description
 ;                   "INSURANCE NAME" - Patient's Insurance Company Name
 ;                   "INSURANCE POINTER" - Patient's Insurance Company IEN
 ;                   "GROUP NAME" - Patient's Insurance Group Name
 ;                   "GROUP NUMBER" - Patient's Insurance Group Number
 ;                   "CARDHOLDER ID" - Patient's Insurance Cardholder ID
 ;                   "COB" - Coordination of Benefits
 ;                   "PLAN CONTACT" - Patient's Insurance Plan Contact (1-800)
 ;                   "PREVIOUS FILL" - Plan's Previous Fill Date
 ;                   "OTHER REJECTS" - Other Rejects with same Response
 ;                   "PHARMACIST" - Pharmacist DUZ
 ;                   "RESPONSE IEN" - Pointer to the RESPONSE file in ECME
 ;                   "REASON SVC CODE" - Reason for Service Code (pointer to BPS NCPDP REASON FOR SERVICE CODE)
 ;                   "RE-OPENED" - Re-Open Flag
 ;                   "RRR FLAG" - Reject Resolution Required indicator (expecting 1/0 into SAVE)
 ;                   "RRR THRESHOLD AMT" - Reject Resolution Required Dollar Threshold
 ;                   "RRR GROSS AMT DUE" - Reject Resolution Required Gross Amount Due
 ;Output: REJ("REJECT IEN")
 N %,DIC,DR,DA,X,DINUM,DD,DO,DLAYGO,ERR,PSOAUTO
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$G(PSODIV) S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 S REJ("BIN")=$E($G(REJ("BIN")),1,6)
 S REJ("PCN")=$G(REJ("PCN"))
 S REJ("CODE")=$G(REJ("CODE"))
 ;
 ; convert REJ("RRR FLAG") into internal format (1/0) if necessary. When coming into SAVE from the Re-open Reject
 ; action, this flag is in the external format (YES/NO).   esg - 3/29/16 - PSO*7*448
 I $G(REJ("RRR FLAG"))="YES" S REJ("RRR FLAG")=1
 I $G(REJ("RRR FLAG"))="NO" S REJ("RRR FLAG")=0
 ;
 ;Ignore this additional Check if reject is Reject Resolution Required reject - PSO*7*421
 I '$G(REJ("RRR FLAG")),REJ("CODE")'=79&(REJ("CODE")'=88)&(REJ("CODE")'=943)&('$G(PSOTRIC))&('$G(REOPEN)) S ERR=$$EVAL^PSOREJU4(PSODIV,REJ("CODE"),$G(OPECC)) Q:'+ERR
 S REJ("PAYER MESSAGE")=$E($G(REJ("PAYER MESSAGE")),1,140),REJ("REASON")=$E($G(REJ("REASON")),1,100)
 S REJ("DUR TEXT")=$E($G(REJ("DUR TEXT")),1,100),REJ("DUR ADD MSG TEXT")=$E($G(REJ("DUR ADD MSG TEXT")),1,100),REJ("GROUP NAME")=$E($G(REJ("GROUP NAME")),1,30)
 S REJ("INSURANCE NAME")=$E($G(REJ("INSURANCE NAME")),1,30),REJ("PLAN CONTACT")=$E($G(REJ("PLAN CONTACT")),1,30)
 S REJ("GROUP NUMBER")=$E($G(REJ("GROUP NUMBER")),1,30),REJ("OTHER REJECTS")=$E($G(REJ("OTHER REJECTS")),1,15)
 S REJ("CARDHOLDER ID")=$E($G(REJ("CARDHOLDER ID")),1,20),REJ("COB")=$G(REJ("COB"))
 D NOW^%DTC
 I $G(REJ("DATE/TIME"))="" S REJ("DATE/TIME")=%
 S DIC="^PSRX("_RX_",""REJ"",",DA(1)=RX,DIC(0)=""
 S X=$G(REJ("CODE")),DINUM=$O(^PSRX(RX,"REJ",9999),-1)+1
 S PSOAUTO=$$AUTORES(RX,RFL,REJ("CODE"),$G(REJ("REASON SVC CODE")))
 S DIC("DR")="1///"_$G(REJ("DATE/TIME"))_";2///"_REJ("PAYER MESSAGE")_";3///"_REJ("REASON")_";4////"_$G(REJ("PHARMACIST"))_";5///"_RFL
 S DIC("DR")=DIC("DR")_";6///"_REJ("GROUP NAME")_";7///"_REJ("PLAN CONTACT")_";8///"_$G(REJ("PREVIOUS FILL"))
 I PSOAUTO=1 D
 . S DIC("DR")=DIC("DR")_";9///1"
 . S DIC("DR")=DIC("DR")_";10///"_%
 . S DIC("DR")=DIC("DR")_";11///.5"
 . S DIC("DR")=DIC("DR")_";12///9"
 E  S DIC("DR")=DIC("DR")_";9///0"
 S DIC("DR")=DIC("DR")_";14///"_$G(REJ("REASON SVC CODE"))_";16///"_$G(REJ("RESPONSE IEN"))
 S DIC("DR")=DIC("DR")_";17///"_$G(REJ("OTHER REJECTS"))_";18///"_REJ("DUR TEXT")_";20///"_REJ("INSURANCE NAME")
 S DIC("DR")=DIC("DR")_";21///"_REJ("GROUP NUMBER")_";22///"_REJ("CARDHOLDER ID")_";23///"_$G(REJ("RE-OPENED"))
 S DIC("DR")=DIC("DR")_";27///"_REJ("COB")
 S DIC("DR")=DIC("DR")_";28///"_REJ("DUR ADD MSG TEXT")
 S DIC("DR")=DIC("DR")_";29///"_REJ("BIN")
 S DIC("DR")=DIC("DR")_";34///"_REJ("PCN")
 ;Update Reject Resolution Required fields - PSO*7*421
 I $G(REJ("RRR FLAG")) D
 .S DIC("DR")=DIC("DR")_";30///"_REJ("RRR FLAG")
 .S DIC("DR")=DIC("DR")_";31///"_REJ("RRR THRESHOLD AMT")
 .S DIC("DR")=DIC("DR")_";32///"_REJ("RRR GROSS AMT DUE")
 S DIC("DR")=DIC("DR")_";33///"_REJ("INSURANCE POINTER")
 F  L +^PSRX(RX):5 Q:$T  H 15
 K DD,DO D FILE^DICN K DD,DO S REJ("REJECT IEN")=+Y
 S REJ("OVERRIDE MSG")=$G(DATA("OVERRIDE MSG"))
 ;Comments use POSTMASTER as user for auto transfers - PSO*7*421
 I REJ("OVERRIDE MSG")'="" D
 .N ORIGIN S ORIGIN=$G(DUZ)
 .S:REJ("OVERRIDE MSG")["Automatically transferred" ORIGIN=.5
 .D SAVECOM^PSOREJP3(RX,REJ("REJECT IEN"),REJ("OVERRIDE MSG"),$G(REJ("DATE/TIME")),ORIGIN)
 .;Insert comment for Transfer and RRR Rejects - PSO*7*421
 .I REJ("OVERRIDE MSG")["Automatically transferred" D
 ..N X,TXT
 ..S TXT="Auto Send to Pharmacy Worklist due to Transfer Reject Code"
 ..I $G(REJ("RRR FLAG")) S TXT="Auto Send to Pharmacy Worklist due to RRR Code"
 ..I $G(PSOTRIC) S TXT="Auto Send to Pharmacy Worklist & OPECC - CVA/TRI"
 ..S X=$$ADDCOMM^BPSBUTL(RX,RFL,TXT,1) ; IA 4719
 ;
 I PSOAUTO=1 D
 . N X,TXT
 . S TXT="Not transferred to Pharmacy-Unable to Resolve Backbill/Resubmit"
 . S X=$$ADDCOMM^BPSBUTL(RX,RFL,TXT,1)
 ;
 L -^PSRX(RX)
 Q
 ; 
CLSALL(RX,RFL,USR,REA,COM,COD1,COD2,COD3,CLA,PA) ; Close/Resolve All Rejects
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (o) USR  - User DUZ responsible for closing all rejects
 ;       (r) REA  - Close REASON code
 ;       (o) COM  - Close COMMENTS
 ;       (o) COD1 - First set of DUR overrides (Reason Code^Professional Code^Result Code)
 ;       (o) COD2 - Second set of DUR overrides (Reason Code^Professional Code^Result Code)
 ;       (o) COD3 - Third set of DUR overrides (Reason Code^Professional Code^Result Code)
 ;       (o) CLA  - NCPDP Clarification Code for overriding RTS and DUR REJECTS
 ;       (o) PA   - NCPDP Prior Authorization Type and Number (separated by "^")
 N REJ,REJDATA,DIE,DR,DA
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; - if eT,eC Non-Billable and the claim was Re-submitted don't close OPEN/UNRESOLVED rejects
 I $G(REA)=1 I $$PSOETEC^PSOREJP5(RX,RFL) Q
 ; - Closing OPEN/UNRESOLVED rejects
 I $$FIND(RX,RFL,.REJDATA,,1) D
 . S REJ="" F  S REJ=$O(REJDATA(REJ)) Q:'REJ  D
 . . D CLOSE(RX,RFL,REJ,USR,REA,$G(COM),$G(COD1),$G(COD2),$G(COD3),$G(CLA),$G(PA))
 Q
 ;
CLOSE(RX,RFL,REJ,USR,REA,COM,COD1,COD2,COD3,CLA,PA,IGNR) ; - Mark a DUR/REFILL TOO SOON reject RESOLVED
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (r) REJ - REJECT ID (IEN)
 ;         (o) USR - User (file #200 IEN) responsible for closing the REJECT
 ;         (r) REA - Reason for closing the REJECT  (52.25,12):
 ;                       1:CLAIM RE-SUBMITTED
 ;                       2:RX ON HOLD
 ;                       3:RX SUSPENDED
 ;                       4:RX RETURNED TO STOCK
 ;                       5:RX DELETED
 ;                       6:IGNORED - NO RESUBMISSION
 ;                       7:RX DISCONTINUED
 ;                       8:RX EDITED
 ;                      99:OTHER
 ;         (o) COM  - Close comments manually entered by the user
 ;         (o) COD1 - First set of DUR overrides (Reason Code^Professional Code^Result Code)
 ;         (o) COD2 - Second set of DUR overrides (Reason Code^Professional Code^Result Code)
 ;         (o) COD3 - Third set of DUR overrides (Reason Code^Professional Code^Result Code)
 ;         (o) CLA  - NCPDP Clarification Code for overriding RTS and DUR REJECTS
 ;         (o) PA   - NCPDP Prior Authorization Type and Number (separated by "^")
 ;         (o) IGNR - Ignore Flag; 1=IGNORE, 0=NOT IGNORE
 ;
 I '$G(RX)!'$G(REJ) Q
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$D(^PSRX(RX,"REJ",REJ)) Q
 I $$GET1^DIQ(52.25,REJ_","_RX,5)'=+$G(RFL) Q
 S:'$G(REA) REA=99 S COM=$TR($G(COM),";^",",,")
 N DQ,DA,DIE,DR,X,Y,REJCOM,I,SMACOM,SMA
 D NOW^%DTC
 S REJCOM="AUTOMATICALLY CLOSED" I REA'=1 S REJCOM=COM
 S DA(1)=RX,DA=REJ,DIE="^PSRX("_RX_",""REJ"","
 S DR="9///1;10///"_%_";11////"_$G(USR)_";12///"_REA_";13///"_REJCOM_";14///"_$P($G(COD1),"^")_";15///"_$P($G(COD1),"^",2)
 S DR=DR_";19///"_$P($G(COD1),"^",3)_";24///"_$G(CLA)_";25///"_$P($G(PA),"^")_";26///"_$P($G(PA),"^",2)
 D ^DIE
 ; Quit if this is a "eT" (non-billable TRICARE) or "eC" (non-billable CHAMPVA)
 Q:$$PSOET^PSOREJP3(RX,RFL)
 ;
 ; Add comment to the ECME User Screen
 ; First check if this is has more than one override value from the SMA action of the reject worklist
 ; If it is, we will need to enter multiple comments
 S SMA=0
 I $G(COD1)]"",$G(CLA)]"" S SMA=1
 I $G(COD1)]"",$G(PA)]"" S SMA=1
 I $G(CLA)]"",$G(PA)]"" S SMA=1
 I SMA D  Q
 . I $G(COD1)]"" D
 .. S SMACOM=$TR("DUR Override Codes "_$G(COD1)_"~"_$G(COD2)_"~"_$G(COD3)_" submitted.","^","/")
 .. S X=$$ADDCOMM^BPSBUTL(RX,RFL,SMACOM)
 . I $G(CLA)]"" D
 .. S SMACOM="Clarification Code(s) "_CLA_" submitted."
 .. S X=$$ADDCOMM^BPSBUTL(RX,RFL,SMACOM)
 . I $G(PA)]"" D
 .. S SMACOM="Prior Authorization Code ("_$P(PA,"^")_"/"_$P(PA,"^",2)_") submitted."
 .. S X=$$ADDCOMM^BPSBUTL(RX,RFL,SMACOM)
 . S SMACOM="Multiple actions taken to resolve. See comments for details."
 . S X=$$ADDCOMM^BPSBUTL(RX,RFL,SMACOM)
 ;
 ; If not SMA, fall through to here and enter one comment
 ; If IGNR flag is set, add that to the comment string before sending
 S X=$$ADDCOMM^BPSBUTL(RX,RFL,$S($G(IGNR):"IGNORED - ",1:"")_COM)
 Q
 ;
FIND(RX,RFL,REJDATA,CODE,BESC,RRRFLG) ; - Returns whether a Rx/fill contains UNRESOLVED rejects
 ; Input: (r) RX - Rx IEN (#52) 
 ; (o) RFL - Refill # (If not passed, look original and all refills)
 ; (o) CODE - Can be null, a specific Reject Code(s) to be checked or multiple codes separated by comma's
 ; (o) BESC - Bypass ECME Status Check (default behavior is to do the check); pass 1 to skip the check below
 ;            We need to skip this check when looking for non-ECME billable rejects (eT or eC for example)
 ; (o) RRRFLG - Pass a 1 in this parameter to also look for any unresolved Reject Resolution Required (RRR)
 ;              rejects when CODE is also passed.  If CODE is not passed in, then pass a 1 here to ONLY look for
 ;              unresolved RRR rejects.
 ;              The default here is 0 if not passed.
 ;
 ; Output: 1 - Rx contains unresolved Rejects
 ;         0 - Rx does not contain unresolved Rejects
 ;  .REJDATA - Array containing the Reject(s) data (see GET^PSOREJU2 for fields documentation)
 ;
 N RCODE,I,REJS
 S REJS=0,RCODE=""
 K REJDATA
 I '$G(BESC),$G(RFL),$$STATUS^PSOBPSUT(RX,RFL)="" Q 0
 I $G(CODE)]"",CODE["," S REJS=$$MULTI^PSOREJU4(RX,$G(RFL),.REJDATA,$G(CODE),REJS,+$G(RRRFLG)) G FEND
 S REJS=$$SINGLE^PSOREJU4(RX,$G(RFL),.REJDATA,$G(CODE),REJS,+$G(RRRFLG))
FEND ;
 Q $S(REJS:1,1:0)
 ;
SYNC(RX,RFL,USR,RXCOB) ;
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (o) USR - User using the system when this routine is called
 ;         (o) RXCOB - Coordination of Benefits code
 I '$G(RXCOB) S RXCOB=1
 N REJ,REJS,REJLST,I,IDX,CODE,DATA,TXT,PSOTRIC,ERR,PSODIV,OPECC,OVREJ,ESH
 N REJRRR,RRRVAL ; PSO*7*421
 L +^PSRX("REJ",RX):0 Q:'$T
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 D DUR1^BPSNCPD3(RX,RFL,.REJ,"",RXCOB)
 S PSOTRIC="" S:$G(REJ(1,"ELIGBLT"))="T" PSOTRIC=1 S:$G(REJ(1,"ELIGBLT"))="C" PSOTRIC=2 S:PSOTRIC="" PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,.PSOTRIC)
 K REJS S (OPECC,IDX,ERR)=""
 F  S IDX=$O(REJ(IDX)) Q:IDX=""  S TXT=$G(REJ(IDX,"REJ CODE LST")) D
 . F I=1:1:$L(TXT,",") S CODE=$P(TXT,",",I),OVREJ="" D
 . . I CODE="" Q
 . . I ",M6,M8,99,NN,"[(","_CODE_",") S ESH="",ESH=$$DUR^PSOBPSU2(RX,RFL) Q:'ESH&('PSOTRIC)
 . . ;Additional check for Reject Resolution Required included - PSO*7*421
 . . I CODE'="79"&(CODE'="88")&(CODE'="943")&('$G(PSOTRIC)) S ERR=$$EVAL^PSOREJU4(PSODIV,CODE,OPECC,RX,RFL,RXCOB,.RRRVAL) Q:'+ERR
 . . I +$G(ERR) S OVREJ=1 S:+$G(RRRVAL) REJRRR(IDX)=RRRVAL
 . . I $$DUP^PSOREJU1(RX,+$$CLEAN^PSOREJU1($G(REJ(IDX,"RESPONSE IEN")))) Q
 . . S REJS(IDX,CODE)=OVREJ
 I '$D(REJS) L -^PSRX("REJ",RX) Q
SYNC2 ;
 S (IDX,CODE)="" F  S IDX=$O(REJS(IDX)) Q:IDX=""  D
 . F  S CODE=$O(REJS(IDX,CODE)) Q:CODE=""  K DATA D
 . . ;Additional check for Reject Resolution Required - PSO*7*421
 . . I 'OPECC&(CODE'=79)&(CODE'=88)&(CODE'=943) D
 . . .I '+$G(REJRRR(IDX)) S DATA("OVERRIDE MSG")="Automatically transferred due to override for reject code." Q
 . . .;Reject Resolution Required fields
 . . .S DATA("RRR FLAG")=1
 . . .S DATA("RRR GROSS AMT DUE")=$P(REJRRR(IDX),U,2)
 . . .S DATA("RRR THRESHOLD AMT")=$P(REJRRR(IDX),U,3)
 . . .S DATA("OVERRIDE MSG")="Automatically transferred due to Reject Resolution Required reject code"
 . . I OPECC&(CODE'=79)&(CODE'=88)&(CODE'=943) S DATA("OVERRIDE MSG")="Transferred by "_$S(CODE["eT":"",CODE["eC":"",1:"OPECC.")
 . . I $D(COMMTXT) S:COMMTXT'="" DATA("OVERRIDE MSG")=DATA("OVERRIDE MSG")_" "_$$CLEAN^PSOREJU1($P(COMMTXT,":",2))
 . . S DATA("DUR TEXT")=$$CLEAN^PSOREJU1($G(REJ(IDX,"DUR FREE TEXT DESC")))
 . . S DATA("DUR ADD MSG TEXT")=$$CLEAN^PSOREJU1($G(REJ(IDX,"DUR ADD MSG TEXT")))
 . . ; In NCPDP D0, the Payer Additional Message is a repeating field and we want to display as much of the
 . . ;   data on the reject information screen as possible so we put the messages together up to the field
 . . ;   length of 140
 . . N CNT,MSG
 . . S CNT="",DATA("PAYER MESSAGE")=""
 . . F  S CNT=$O(REJ(IDX,"PAYER MESSAGE",CNT)) Q:CNT=""!($L(DATA("PAYER MESSAGE"))>140)  D
 . . . S MSG=$$CLEAN^PSOREJU1(REJ(IDX,"PAYER MESSAGE",CNT))
 . . . I MSG]"" S DATA("PAYER MESSAGE")=DATA("PAYER MESSAGE")_MSG_"  "
 . . ; Call CLEAN again to strip the extra trailing spaces we might have added
 . . S DATA("PAYER MESSAGE")=$$CLEAN^PSOREJU1(DATA("PAYER MESSAGE"))
 . . S DATA("CODE")=CODE,DATA("REASON")=$$CLEAN^PSOREJU1($G(REJ(IDX,"REASON")))
 . . S DATA("PHARMACIST")=$G(USR),DATA("INSURANCE NAME")=$$CLEAN^PSOREJU1($G(REJ(IDX,"INSURANCE NAME")))
 . . S DATA("INSURANCE POINTER")=$$CLEAN^PSOREJU1($G(REJ(IDX,"INSURANCE POINTER")))
 . . S DATA("GROUP NAME")=$$CLEAN^PSOREJU1($G(REJ(IDX,"GROUP NAME"))),DATA("GROUP NUMBER")=$$CLEAN^PSOREJU1($G(REJ(IDX,"GROUP NUMBER")))
 . . S DATA("CARDHOLDER ID")=$$CLEAN^PSOREJU1($G(REJ(IDX,"CARDHOLDER ID"))),DATA("PLAN CONTACT")=$$CLEAN^PSOREJU1($G(REJ(IDX,"PLAN CONTACT")))
 . . S DATA("PREVIOUS FILL")=$$CLEAN^PSOREJU1($$DAT^PSOREJU1($G(REJ(IDX,"PREVIOUS FILL DATE"))))
 . . S DATA("OTHER REJECTS")=$$CLEAN^PSOREJU1($$OTH^PSOREJU1(CODE,$G(REJ(IDX,"REJ CODE LST"))))
 . . S DATA("RESPONSE IEN")=+$$CLEAN^PSOREJU1($G(REJ(IDX,"RESPONSE IEN")))
 . . S DATA("REASON SVC CODE")=$$REASON^PSOREJU2($G(REJ(IDX,"REASON"))),DATA("COB")=IDX
 . . S DATA("MESSAGE")=$$CLEAN^PSOREJU1($G(REJ(IDX,"MESSAGE")))
 . . S DATA("DUR RESPONSE DATA")=$$CLEAN^PSOREJU1($G(REJ(IDX,"DUR RESPONSE DATA")))
 . . S DATA("BIN")=$$CLEAN^PSOREJU1($G(REJ(IDX,"BIN")))
 . . S DATA("PCN")=$$CLEAN^PSOREJU1($G(REJ(IDX,"PCN")))
 . . D SAVE(RX,RFL,.DATA)
 L -^PSRX("REJ",RX)
 Q
 ;
AUTORES(RX,RFL,REJ,RSC) ; Auto-resolve reject check
 ; Input: (r) RX - Rx IEN (#52) 
 ; (r) RFL - Refill #
 ; (r) REJ - Reject Code
 ; (r) RSC - Reason for Service Code
 ;
 ; Identify rejects to automatically resolve:
 ; * Rx must be released
 ; * Refills or renewals only, do not consider original fills
 ; * Back-billed or resubmission prescriptions only
 ; * If reject 79, auto-resolve without checking Reason for Service Code
 ; * If reject 88 or 943, limit to Reason for Service Codes of 'ID' or 'ER'
 ;
 N BPS59,RENEW
 I '$$RXRLDT^PSOBPSUT(RX,RFL) Q 0
 I RFL=0 D  I RENEW=0 Q 0
 . S RENEW=0
 . I $$GET1^DIQ(52,RX,.01)?1.N1.A S RENEW=1
 . I $$GET1^DIQ(52,RX,39.4)'="" S RENEW=1
 S BPS59=$$IEN59^BPSOSRX(RX,RFL)
 I ("^BB^ED^ERES^ERWV^ERNB^P2S^RSNB^")'[("^"_$$GET1^DIQ(9002313.59,BPS59,1201)_"^") Q 0
 I REJ=79 Q 1
 I (REJ'=88)&(REJ'=943) Q 0
 I (RSC'="ID")&(RSC'="ER") Q 0
 Q 1
 ;

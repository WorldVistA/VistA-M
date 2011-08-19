PSOREJUT ;BIRM/MFR - BPS (ECME) - Clinical Rejects Utilities ;06/07/05
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,287,289,290,358**;DEC 1997;Build 35
 ;Reference to DUR1^BPSNCPD3 supported by IA 4560
 ;Reference to $$ADDCOMM^BPSBUTL supported by IA 4719
 ;
SAVE(RX,RFL,REJ,REOPEN) ; - Saves DUR Information in the file 52
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (o) REOPEN - value of 1 means claim being reopened; null or no value passed means reopen claim functionality not being used
 ;         (r) REJ - Array containing information about the REJECT on the following subscripts:
 ;                   "CODE"   - Reject Code (79 or 88)
 ;                   "DATE/TIME"   - Date/Time Reject Detected
 ;                   "PAYER MESSAGE" - Message returned by Payer (up to 140 chars long)
 ;                   "REASON" - Reject Reason (up to 100 chars long)
 ;                   "DUR TEXT" - Payer's DUR description
 ;                   "INSURANCE NAME" - Patient's Insurance Company Name
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
 ;Output: REJ("REJECT IEN")
 N %,DIC,DR,DA,X,DINUM,DD,DO,DLAYGO
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$G(PSODIV) S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 S REJ("CODE")=$G(REJ("CODE"))
 I REJ("CODE")'=79&(REJ("CODE")'=88)&('$G(PSOTRIC))&('$G(REOPEN)) S ERR="",ERR=$$EVAL^PSOREJU4(PSODIV,REJ("CODE"),$G(OPECC),.ERR) Q:'+ERR
 S REJ("PAYER MESSAGE")=$E($G(REJ("PAYER MESSAGE")),1,140),REJ("REASON")=$E($G(REJ("REASON")),1,100)
 S REJ("DUR TEXT")=$E($G(REJ("DUR TEXT")),1,100),REJ("GROUP NAME")=$E($G(REJ("GROUP NAME")),1,30)
 S REJ("INSURANCE NAME")=$E($G(REJ("INSURANCE NAME")),1,30),REJ("PLAN CONTACT")=$E($G(REJ("PLAN CONTACT")),1,30)
 S REJ("GROUP NUMBER")=$E($G(REJ("GROUP NUMBER")),1,30),REJ("OTHER REJECTS")=$E($G(REJ("OTHER REJECTS")),1,15)
 S REJ("CARDHOLDER ID")=$E($G(REJ("CARDHOLDER ID")),1,20),REJ("COB")=$G(REJ("COB"))
 I $G(REJ("DATE/TIME"))="" D NOW^%DTC S REJ("DATE/TIME")=%
 S DIC="^PSRX("_RX_",""REJ"",",DA(1)=RX,DIC(0)=""
 S X=$G(REJ("CODE")),DINUM=$O(^PSRX(RX,"REJ",9999),-1)+1
 S DIC("DR")="1///"_$G(REJ("DATE/TIME"))_";2///"_REJ("PAYER MESSAGE")_";3///"_REJ("REASON")_";4////"_$G(REJ("PHARMACIST"))_";5///"_RFL
 S DIC("DR")=DIC("DR")_";6///"_REJ("GROUP NAME")_";7///"_REJ("PLAN CONTACT")_";8///"_$G(REJ("PREVIOUS FILL"))
 S DIC("DR")=DIC("DR")_";9///0;14///"_$G(REJ("REASON SVC CODE"))_";16///"_$G(REJ("RESPONSE IEN"))
 S DIC("DR")=DIC("DR")_";17///"_$G(REJ("OTHER REJECTS"))_";18///"_REJ("DUR TEXT")_";20///"_REJ("INSURANCE NAME")
 S DIC("DR")=DIC("DR")_";21///"_REJ("GROUP NUMBER")_";22///"_REJ("CARDHOLDER ID")_";23///"_$G(REJ("RE-OPENED"))
 S DIC("DR")=DIC("DR")_";27///"_REJ("COB")
 F  L +^PSRX(RX):5 Q:$T  H 15
 K DD,DO D FILE^DICN K DD,DO S REJ("REJECT IEN")=+Y
 S REJ("OVERRIDE MSG")=$G(DATA("OVERRIDE MSG"))
 I REJ("OVERRIDE MSG")'="" D SAVECOM^PSOREJP3(RX,REJ("REJECT IEN"),REJ("OVERRIDE MSG"),$G(REJ("DATE/TIME")),$G(DUZ))
 K ERR
 L -^PSRX(RX)
 Q
 ; 
CLSALL(RX,RFL,USR,REA,COM,COD1,COD2,COD3,CLA,PA) ; Close/Resolve All Rejects
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (r) REA  - Close REASON code
 ;       (o) COM  - Close COMMENTS
 ;       (o) USR  - User DUZ responsible for closing all rejects
 ;       (o) COD1 - NCPDP Reason for Service Code for overriding DUR REJECTS
 ;       (o) COD2 - NCPDP Professional Service Code for overriding DUR REJECTS
 ;       (o) COD3 - NCPDP Result of Service Code for overriding DUR REJECTS
 ;       (o) CLA  - NCPDP Clarification Code for overriding RTS and DUR REJECTS
 ;       (o) PA   - NCPDP Prior Authorization Type and Number (separated by "^")
 N REJ,REJDATA,DIE,DR,DA
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; - Closing OPEN/UNRESOLVED rejects
 I $$FIND(RX,RFL,.REJDATA) D
 . S REJ="" F  S REJ=$O(REJDATA(REJ)) Q:'REJ  D
 . . D CLOSE(RX,RFL,REJ,USR,REA,$G(COM),$G(COD1),$G(COD2),$G(COD3),$G(CLA),$G(PA))
 Q
 ;
CLOSE(RX,RFL,REJ,USR,REA,COM,COD1,COD2,COD3,CLA,PA) ; - Mark a DUR/REFILL TOO SOON reject RESOLVED
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RFL - Refill # (Default: most recent)
 ;         (r) REJ - REJECT ID (IEN)
 ;         (o) USR - User (file #200 IEN) responsible for closing the REJECT
 ;         (r) REA - Reason for closing the REJECT:
 ;                       1:CLAIM RE-SUBMITTED
 ;                       2:RX ON HOLD
 ;                       3:RX SUSPENDED
 ;                       4:RX RETURNED TO STOCK
 ;                       5:RX DELETED
 ;                       6:OVERRIDEN W/OUT RE-SUBMISSION
 ;                       7:DISCONTINUED
 ;                       8:RX EDIT
 ;                      99:OTHER
 ;         (o) COM  - Close comments manually entered by the user
 ;         (o) COD1 - NCPDP Reason for Service Code for overriding DUR REJECTS
 ;         (o) COD2 - NCPDP Professional Service Code for overriding DUR REJECTS
 ;         (o) COD3 - NCPDP Result of Service Code for overriding DUR REJECTS
 ;         (o) CLA  - NCPDP Clarification Code for overriding RTS and DUR REJECTS
 ;         (o) PA   - NCPDP Prior Authorization Type and Number (separated by "^")
 I '$G(RX)!'$G(REJ) Q
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$D(^PSRX(RX,"REJ",REJ)) Q
 I $$GET1^DIQ(52.25,REJ_","_RX,5)'=+$G(RFL) Q
 S:'$G(REA) REA=99 S COM=$TR($G(COM),";^",",,")
 N DQ,DA,DIE,DR,X,Y,REJCOM
 D NOW^%DTC
 S REJCOM="AUTOMATICALLY CLOSED" I REA'=1 S REJCOM=COM
 S DA(1)=RX,DA=REJ,DIE="^PSRX("_RX_",""REJ"","
 S DR="9///1;10///"_%_";11////"_$G(USR)_";12///"_REA_";13///"_REJCOM_";14///"_$G(COD1)_";15///"_$G(COD2)
 S DR=DR_";19///"_$G(COD3)_";24///"_$G(CLA)_";25///"_$P($G(PA),"^")_";26///"_$P($G(PA),"^",2)
 D ^DIE S:'$$PSOET^PSOREJP3(RX,RFL) X=$$ADDCOMM^BPSBUTL(RX,RFL,COM)   ;cnf, PSO*7*358, add check for PSOET (pseudoreject)
 Q
 ;
FIND(RX,RFL,REJDATA,CODE) ; - Returns whether a Rx/fill contains UNRESOLVED rejects
 ; Input: (r) RX - Rx IEN (#52) 
 ; (o) RFL - Refill # (If not passed, look original and all refills)
 ; (o) CODE - Can be null, a specific Reject Code(s) to be checked or multiple codes separated by comma's
 ; Output: 1 - Rx contains unresolved Rejects 
 ; 0 - Rx does not contain unresolved Rejects
 ; .REJDATA - Array containing the Reject(s) data (see 
 ; GET^PSOREJU2 for fields documentation)
 N RCODE,I,REJS
 S REJS=0,RCODE=""
 K REJDATA
 I $G(RFL),$$STATUS^PSOBPSUT(RX,RFL)="" Q 0
 I $G(CODE),CODE["," S REJS=$$MULTI^PSOREJU4(RX,$G(RFL),.REJDATA,$G(CODE),REJS) G FEND
 S REJS=$$SINGLE^PSOREJU4(RX,$G(RFL),.REJDATA,$G(CODE),REJS)
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
 L +^PSRX("REJ",RX):0 Q:'$T
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 D DUR1^BPSNCPD3(RX,RFL,.REJ,"",RXCOB)
 S PSOTRIC="" S:$G(REJ(1,"ELIGBLT"))="T" PSOTRIC=1 S:PSOTRIC="" PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,.PSOTRIC)
 K REJS S (OPECC,IDX,ERR)=""
 F  S IDX=$O(REJ(IDX)) Q:IDX=""  S TXT=$G(REJ(IDX,"REJ CODE LST")) D
 . F I=1:1:$L(TXT,",") S CODE=$P(TXT,",",I),OVREJ="" D
 . . I ",M6,M8,99,NN,"[(","_CODE_",") S ESH="",ESH=$$DUR^PSOBPSU2(RX,RFL) Q:'ESH&('PSOTRIC)
 . . I CODE'="79"&(CODE'="88")&('$G(PSOTRIC)) S ERR=$$EVAL^PSOREJU4(PSODIV,CODE,OPECC,.ERR) Q:'+ERR
 . . S:+$G(ERR) OVREJ=1
 . . I $$DUP^PSOREJU1(RX,+$$CLEAN^PSOREJU1($G(REJ(IDX,"RESPONSE IEN")))) Q
 . . S REJS(IDX,CODE)=OVREJ
 I '$D(REJS) L -^PSRX("REJ",RX) Q
SYNC2 ;
 S (IDX,CODE)="" F  S IDX=$O(REJS(IDX)) Q:IDX=""  D
 . F  S CODE=$O(REJS(IDX,CODE)) Q:CODE=""  K DATA D
 . . I 'OPECC&(CODE'[79)&(CODE'[88) S DATA("OVERRIDE MSG")="Automatically transferred due to override for reject code."
 . . I OPECC&(CODE'[79)&(CODE'[88) S DATA("OVERRIDE MSG")="Transferred by "_$S(CODE'["eT":"OPECC.",1:"")   ;cnf,PSO*7.0*358
 . . I $D(COMMTXT) S:COMMTXT'="" DATA("OVERRIDE MSG")=DATA("OVERRIDE MSG")_" "_$$CLEAN^PSOREJU1($P(COMMTXT,":",2))
 . . S DATA("DUR TEXT")=$$CLEAN^PSOREJU1($G(REJ(IDX,"DUR FREE TEXT DESC")))
 . . S DATA("PAYER MESSAGE")=$$CLEAN^PSOREJU1($G(REJ(IDX,"PAYER MESSAGE")))
 . . S DATA("CODE")=CODE,DATA("REASON")=$$CLEAN^PSOREJU1($G(REJ(IDX,"REASON")))
 . . S DATA("PHARMACIST")=$G(USR),DATA("INSURANCE NAME")=$$CLEAN^PSOREJU1($G(REJ(IDX,"INSURANCE NAME")))
 . . S DATA("GROUP NAME")=$$CLEAN^PSOREJU1($G(REJ(IDX,"GROUP NAME"))),DATA("GROUP NUMBER")=$$CLEAN^PSOREJU1($G(REJ(IDX,"GROUP NUMBER")))
 . . S DATA("CARDHOLDER ID")=$$CLEAN^PSOREJU1($G(REJ(IDX,"CARDHOLDER ID"))),DATA("PLAN CONTACT")=$$CLEAN^PSOREJU1($G(REJ(IDX,"PLAN CONTACT")))
 . . S DATA("PREVIOUS FILL")=$$CLEAN^PSOREJU1($$DAT^PSOREJU1($G(REJ(IDX,"PREVIOUS FILL DATE"))))
 . . S DATA("OTHER REJECTS")=$$CLEAN^PSOREJU1($$OTH^PSOREJU1(CODE,$G(REJ(IDX,"REJ CODE LST"))))
 . . S DATA("RESPONSE IEN")=+$$CLEAN^PSOREJU1($G(REJ(IDX,"RESPONSE IEN")))
 . . S DATA("REASON SVC CODE")=$$REASON^PSOREJU2($G(REJ(IDX,"REASON"))),DATA("COB")=IDX
 . . D SAVE(RX,RFL,.DATA)
 L -^PSRX("REJ",RX)
 Q

PSOREJU1 ;BIRM/MFR - BPS (ECME) - Clinical Rejects Utilities (1) ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,287,289,358,359**;DEC 1997;Build 27
 ;Reference to File 9002313.21 - BPS NCPDP PROFESSIONAL SERVICE CODE supported by IA 4712
 ;Reference to File 9002313.22 - BPS NCPDP RESULT OF SERVICE CODE supported by IA 4713
 ;Reference to File 9002313.23 - BPS NCPDP REASON FOR SERVICE CODE supported by IA 4714
 ;Reference to File 9002313.25 - BPS NCPDP SUBMISSION CLARIFICATION CODE supported by IA 5064
 ;Reference to File 200 - NEW PERSON supported by IA 10060
 ;Reference to SIG^XUSESIG supported by IA 10050
 ;
ACTION(RX,REJ,OPTS,DEF) ;
 ; Input:  (r) RX   - Rx IEN (#52) 
 ;         (r) REJ  - REJECT ID (IEN)
 ;         (r) OPTS - Available options ("QIO" for QUIT/IGNORE/OVERRIDE)
 ;         (o) DEF  - Default Option ("O", "I" or "Q")
 ; Output: ACTION: "I^Comments" - Ignore Reject
 ;                 "O^COD1^COD2^COD3" - Override with the Override codes COD1(Prof.),COD2(Reason) and COD3(Result)
 ;                 "Q" - Quit
 ;                 "^" - Up-arrow entered or timed out
 ;
 N ACTION,COM,OVR,X,DIR,DIRUT,Y
 ;         
 I '$G(RX)!'$G(REJ) Q
 I '$G(PSONBILL) Q:'$D(^PSRX(RX,"REJ",REJ))
 ;
 ; - Display DUR/79 REJECT information
 D DISPLAY^PSOREJU3(RX,REJ)
 ;
ASK K ACTION,DIR,DIRUT
 S DIR(0)="SO^",DIR("A")=""
 S:(OPTS["O") DIR(0)=DIR(0)_"O:(O)VERRIDE - RESUBMIT WITH OVERRIDE CODES;",DIR("A")=DIR("A")_"(O)verride,"
 S:(OPTS["I") DIR(0)=DIR(0)_"I:(I)GNORE - FILL Rx WITHOUT CLAIM SUBMISSION;",DIR("A")=DIR("A")_"(I)gnore,"
 S:(OPTS["D") DIR(0)=DIR(0)_"D:(D)iscontinue - DO NOT FILL PRESCRIPTION;",DIR("A")=DIR("A")_"(D)iscontinue,"
 S:(OPTS["Q") DIR(0)=DIR(0)_"Q:(Q)UIT - SEND TO WORKLIST (REQUIRES INTERVENTION);",DIR("A")=DIR("A")_"(Q)uit,"
 S $E(DIR(0),$L(DIR(0)))="",$E(DIR("A"),$L(DIR("A")))="",DIR("??")="^D HELP^PSOREJU2("""_OPTS_""")"
 S:$G(DEF)'="" DIR("B")=DEF D ^DIR I $D(DIRUT) W ! Q "Q"
 ;
 ; - STOP/QUIT Action
 S ACTION=Y I ACTION="Q" Q ACTION
 ;
 ; - IGNORE Action 
 K DIR,DIRUT,X
 ;
 ;PSO*7.0*358, add logic for TRICARE ignore
 I PSOTRIC,ACTION="I",'$$CONT W $C(7),!," ACTION NOT TAKEN!",! H 1 G ASK
 ;
 I ACTION="I" S:'PSOTRIC COM=$$COM() S:PSOTRIC COM=$$TCOM^PSOREJP3() G ASK:COM="^" G ASK:'$$SIG() S ACTION=ACTION_"^"_COM
 ;
 ; - OVERRIDE Action
 I ACTION="O" D  G ASK:OVR="^"
 . S OVR=$$OVR() S ACTION=ACTION_"^"_OVR
 ;
DC1 ;Discontinue
 I ACTION="D" S ACTION=$$DC(RX,ACTION) I $D(DIRUT) S ACTION="D" D DISPLAY^PSOREJU3(RX,REJ) G ASK
 ;
 Q ACTION
 ;
DC(RX,ACTION) ; - Discontinue inside and outside call
 N RXN,MSG,REA,DA,PSCAN,RXNUM
 S DA=RX,RXNUM=""
 D NOOR^PSOCAN4 I $D(DIRUT) W $C(7)," ACTION NOT TAKEN!",! H 1 S PSORX("DFLG")=1,ACTION="Q" Q ACTION
 D REQ^PSOCAN4 I $D(DIRUT) W $C(7)," ACTION NOT TAKEN!",! H 1 S PSORX("DFLG")=1,ACTION="Q" Q ACTION
 S REA="C",RXNUM=$P(^PSRX(DA,0),"^")
 S MSG="Discontinued "_$S($G(PSOFDR):" from Reject Processing Screen",1:"")
 S PSCAN(RXNUM)=DA_"^C"
 D CAN^PSOCAN
 N PSOCKDC S PSOCKDC=1,PSOQFLAG=1,PSOLST(1)=52_"^"_DA_"^"_$$GET1^DIQ(52,RXNUM,100),ORN=1
 D ECME^PSORXL1 I '$G(PPL) S PPL=""  ;remove rx from label print
 Q ACTION
 ;
CONT() ;- Ask to continue for bypassing claims processing  ;PSO*7.0*358
 N DIR,DIRUT,Y
 S DIR(0)="Y",DIR("A")="You are bypassing claims processing. Do you wish to continue",DIR("B")="NO"
 D ^DIR I $D(DIRUT) S Y=0
 Q $G(Y)
 ;
SIG() ; - Get electronic signature
 N CODE,X,X1,Y
 S CODE=$P($G(^VA(200,DUZ,20)),U,4),Y=0 I '$L(CODE) D  Q Y
 . W $C(7),!,"You do not have an electronic signature code."
 . W !,"Please contact your IRM office." H 2
 D SIG^XUSESIG S Y=(X1'="")
 Q Y
 ;
COM() ; - Ask for CLOSE comments
 K COM,DIR,DIRUT,X
 W ! S DIR(0)="F^3:100" S DIR("A")="Comments" D ^DIR
 S COM=X I $D(DIRUT) S COM="^"
 Q COM
 ;
OVR() ; - Ask for OVERRIDE codes
 N COD1,COD2,COD3,DIR,DIRUT W !
 S COD1=$$OVRCOD(1,$$GET1^DIQ(52.25,REJ_","_RX,14)) I COD1="^" Q "^"
 S COD2=$$OVRCOD(2) I COD2="^" Q "^"
 S COD3=$$OVRCOD(3) I COD3="^" Q "^"
 ;
 D OVRDSP^PSOREJU1(COD1_"^"_COD2_"^"_COD3) W !
 ;
 S DIR(0)="Y",DIR("A")="     Confirm? ",DIR("B")="YES"
 D ^DIR I $G(Y)=0!$D(DIRUT) Q "^"
 ;
 Q (COD2_"^"_COD1_"^"_COD3)
 ;
OVRDSP(LST) ; - Display the Override Codes
 N I W !
 F I=1:1:3 D
 . W !?5,$S(I=1:"Reason for Service Code  : ",I=2:"Professional Service Code: ",1:"Result of Service Code   : ")
 . W $E($$OVRX(I,$P(LST,"^",I)),1,48)
 Q
 ;
CLA() ; - Ask for up to 3 Clarification Codes
 N DIC,X,Y,PSOSCC,DTOUT,DUOUT,PSOQ,PSOI,I
 S DIC(0)="QEAM",DIC=9002313.25,PSOQ=0,PSOSCC=""
 F PSOI=1:1:3 Q:PSOQ  S DIC("A")="Submission Clarification Code "_PSOI_": " D CLADIC
 Q $S(PSOSCC="":"^",1:PSOSCC)
 ;
CLADIC D ^DIC I ($D(DUOUT))!($D(DTOUT))!(Y=-1) S PSOQ=1 Q
 F I=1:1:PSOI I $P(PSOSCC,"~",I)=$P(Y,U,2) W "  Duplicates not allowed",! G CLADIC
 S $P(PSOSCC,"~",PSOI)=$P(Y,U,2)
 Q
 ;
HDLG(RX,RFL,CODES,FROM,OPTS,DEF) ; - REJECT Handling
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (r) CODES - List of REJECT CODES to be handled separated by commas (default is "79,88")
 ;       (r) FROM  - Same values as BWHERE param. in the EN^BPSNCPDP api
 ;       (r) OPTS  - Available options ("IOQ" for IGNORE/OVERRIDE/QUIT)
 ;       (o) DEF   - Default Option ("O", "I" or "Q")
 ;Output: ACTION   - "O"-Override, "I"-Ignore,"Q"-Quit,"^"-Up-arrow entered
 ;       
 N REJDATA,NEWDATA,CODE,ACTION,REJ,RESP,REJCDI,PSOTRIC,DCODE S CODE=""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 I PSOTRIC D  ;note that Tricare Rejects need all codes, not just 79/88's
 . S OPTS="DQ",DEF="Q",(DCODE,CODES)=""
 . I $D(^XUSEC("PSO TRICARE",DUZ)) S OPTS=OPTS_"I" ;PSO*7.0*358, if user has security key, include IGNORE in TRICARE options
 . F  S DCODE=$O(^PSRX(RX,"REJ","B",DCODE)) Q:DCODE=""  S CODES=CODES_","_DCODE
 . S CODES=$E(CODES,2,9999)
 . I CODES["88"!(CODES["79") S OPTS="ODQ" S:$D(^XUSEC("PSO TRICARE",DUZ)) OPTS=OPTS_"I" ;PSO*7.0*358, if user has security key, include IGNORE in TRICARE options
 ;  -  In progress Rx not allowed to be filled
 I PSOTRIC,$$STATUS^PSOBPSUT(RX,RFL)["IN PROGRESS" S ACTION="",(DEF,OPTS)="D" D TRICCHK^PSOREJU3(RX,RFL,"",FROM) D  Q ACTION
 . I $P(ACTION,"^")="D" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,7,,$P(ACTION,"^",2))
 ;
 F REJCDI=1:1 S CODE=$P(CODES,",",REJCDI) Q:CODE=""  D  I ACTION="Q"!(ACTION="^") Q
 . S ACTION=""
 . I $$FIND^PSOREJUT(RX,RFL,.REJDATA,CODE) D
 . . S REJ=$O(REJDATA(""))
 . . S ACTION=$$ACTION(RX,REJ,OPTS,$G(DEF)) I ACTION="Q"!(ACTION="^") Q  ;PSO*7.0*358,add PSOTRIC as parameter
 . . ;PSO*7.0*358, put in Tricare audit if Ignore action and Tricare Rx
 . . I $P(ACTION,"^")="I" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,6,$P(ACTION,"^",2)) D:PSOTRIC AUDIT^PSOTRI(RX,RFL,,$P(ACTION,"^",2),$S($$PSOET^PSOREJP3(RX,RFL):"N",1:"R")) Q
 . . I $P(ACTION,"^")="O" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,1,,$P(ACTION,"^",3),$P(ACTION,"^",2),$P(ACTION,"^",4))
 . . I $P(ACTION,"^")="D" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,7,,$P(ACTION,"^",2)) Q
 . . D ECMESND^PSOBPSU1(RX,RFL,,FROM,$$GETNDC^PSONDCUT(RX,RFL),,,$P(ACTION,"^",2,4),,.RESP)
 . . I $G(RESP) D  Q
 . . . W !!?10,"Claim could not be submitted. Please try again later!"
 . . . W !,?10,"Reason: ",$S($P(RESP,"^",2)="":"UNKNOWN",1:$P(RESP,"^",2)),$C(7)
 . . K NEWDATA I $$FIND^PSOREJUT(RX,RFL,.NEWDATA,CODE) D  I ACTION="Q"!(ACTION="^") Q
 . . . S ACTION=$$ACTION(RX,$O(NEWDATA("")),OPTS,$G(DEF)) I ACTION="Q"!(ACTION="^") Q  ;PSO*7.0*358,add PSOTRIC as parameter
 . . . I $P(ACTION,"^")="I" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,6,$P(ACTION,"^",2))
 . . . I $P(ACTION,"^")="O" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,1,,$P(ACTION,"^",3),$P(ACTION,"^",2),$P(ACTION,"^",4))
 Q ACTION
 ;
OVRX(TYPE,CODE) ; - Returns the extended code/description of the NCPDP DUR override codes
 ; Input: (r) TYPE  - 1 (REASON FOR SERVICE), 2 (PROFESSIONAL SERVICE) or 3 (RESULT OF SERVICE)
 ;        (r) CODE  - Table IEN
 ; Output: "CODE - DESCRIPTION"
 N FILE,DIC,X,Y
 S FILE=9002313+$S(TYPE=1:.23,TYPE=2:.21,1:.22)
 S DIC=FILE,X=CODE D ^DIC
 I TYPE=1 Q CODE_" - "_$$GET1^DIQ(9002313.23,+Y,1)
 I TYPE=2 Q CODE_" - "_$$GET1^DIQ(9002313.21,+Y,1)
 I TYPE=3 Q CODE_" - "_$$GET1^DIQ(9002313.22,+Y,1)
 Q ""
 ;
 ;
OVRCOD(TYPE,VALUE) ; - Prompt for NCPDP Override Codes
 N DIC,X,Y,FILE,PRPT
 ; 
 I TYPE=1 S FILE=9002313.23,PRPT="Reason for Service Code  : "
 I TYPE=2 S FILE=9002313.21,PRPT="Professional Service Code: "
 I TYPE=3 S FILE=9002313.22,PRPT="Result of Service Code   : "
 S DIC=FILE,DIC(0)="Z"
 I $G(VALUE)'="" S X=VALUE D ^DIC I Y>0 W !,PRPT,VALUE,"       ",$P(Y(0),"^",2) Q VALUE
 S DIC=FILE,DIC(0)="AQE",DIC("A")=PRPT
 D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) Q "^"
 Q $P(Y,"^",2)
 ;
SEL(FIELD,FILE,ARRAY,DEFAULT) ; - Provides field selection (one, multiple or ALL)
 N DIC,DTOUT,DUOUT,QT,Y,X
 W !!,"You may select a single or multiple "_FIELD_"S,"
 W !,"or enter ^ALL to select all "_FIELD_"S.",!
 K ARRAY S DIC=FILE,DIC(0)="QEZAM",DIC("A")=FIELD_": "
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 . I $$UP^XLFSTR(X)="^ALL" K ARRAY S ARRAY="ALL",QT=1 Q
 . I $D(DTOUT)!$D(DUOUT) K ARRAY S ARRAY="^",QT=1 Q
 . W "   ",$P(Y,"^",2),$S($D(ARRAY(+Y)):"       (already selected)",1:"")
 . W ! S ARRAY(+Y)="",DIC("A")="ANOTHER ONE: " K DIC("B")
 I '$D(ARRAY) S ARRAY="^"
 Q
 ;
LMREJ(RX,RFL,MSG,BCK) ; Used by ListManager hidden actions to detect unresolved 3rd Party Rejects
 ;Input:  (r) RX   - Rx IEN (#52)
 ;        (o) RFL  - Refill # (Default: most recent)
 ;Output: (o) MSG  - Usually this will be used to set VALMSG variable, which should be passed in by ref.
 ;        (o) BCK  - This will be used to set VALMBCK variable, which should be passed in by ref.
 ;
 I '$D(^PSRX(+RX)) Q 0
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I $$FIND^PSOREJUT(RX,RFL) D  Q 1
 . S MSG="NOT ALLOWED! Rx has OPEN 3rd Party Payer Reject.",BCK="R" W $C(7),$C(7)
 Q 0
 ;
DUP(RX,RSP,CLOSED) ; Checks if REJECT has already been logged in the PRESCRIPTION file
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (o) RSP - Response IEN
 ;         (o) CLOSED - If CLOSED=1 and Reject is closed, then do not count as duplicate
 ; Output:     DUP - 1: Already logged (duplicate) 
 ;                   0: Not yet logged on PRESCRIPTION file
 N DUP,IDX
 I $G(CLOSED)="" S CLOSED=0
 S (DUP,IDX)=0
 F  S IDX=$O(^PSRX(RX,"REJ",IDX)) Q:'IDX  D  Q:DUP
 . I +RSP=+$$GET1^DIQ(52.25,IDX_","_RX,16,"I") S DUP=1
 . I CLOSED=1,+$$GET1^DIQ(52.25,IDX_","_RX,9,"I")=1 S DUP=0
 Q DUP
 ;
OTH(CODE,LST) ; Removes the current Reject code from the list
 ; Input:  (r) CODE  - Current Reject Code (79 or 88)
 ;         (o) LST   - List of all Reject codes with response (comma separated)
 ; Output:     OTH   - List of OTHER Reject codes (w/out 79 or 88)
 ;
 N I,OTH
 F I=1:1:$L(LST,",") D
 . I $P(LST,",",I),$P(LST,",",I)'=CODE S OTH=$G(OTH)_","_$P(LST,",",I)
 S $E(OTH)=""
 Q OTH
 ;
DAT(DAT) ; - External Date
 S X=$$HL7TFM^XLFDT(DAT) I X<0 Q ""
 Q X
 ;
CLEAN(STR) ; Remove blanks from the end of a string and replaces ";" with ","
 N LEN F LEN=$L(STR):-1:1 Q:$E(STR,LEN)'=" "
 S STR=$TR(STR,";",",")
 Q $E(STR,1,LEN)

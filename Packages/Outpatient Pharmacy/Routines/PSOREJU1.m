PSOREJU1 ;BIRM/MFR - BPS (ECME) - Clinical Rejects Utilities (1) ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,287,289,358,359,385,403,421,482,562**;DEC 1997;Build 19
 ;Reference to File 9002313.21 - BPS NCPDP PROFESSIONAL SERVICE CODE supported by IA 4712
 ;Reference to File 9002313.22 - BPS NCPDP RESULT OF SERVICE CODE supported by IA 4713
 ;Reference to File 9002313.23 - BPS NCPDP REASON FOR SERVICE CODE supported by IA 4714
 ;Reference to File 9002313.25 - BPS NCPDP SUBMISSION CLARIFICATION CODE supported by IA 5064
 ;Reference to File 9002313.26 - BPS NCPDP PRIOR AUTHORIZATION TYPE CODE supported by IA 5585 
 ;Reference to File 200 - NEW PERSON supported by IA 10060
 ;Reference to SIG^XUSESIG supported by IA 10050
 ;Reference to AMT^BPSBUTL supported by IA 4719
 ;
ACTION(RX,REJ,OPTS,DEF,RRR) ;
 ; Input:  (r) RX   - Rx IEN (#52) 
 ;         (r) REJ  - REJECT ID (IEN)
 ;         (r) OPTS - Available options ("QIDO" for QUIT/IGNORE/DISCONTINUE/OVERRIDE)
 ;         (o) DEF  - Default Option ("O", "I" or "Q")
 ;         (o) RRR - Reject Resolution Required information  Flag(0/1)^Threshold Amt^Gross Amt Due  (Default: 0)
 ;                   If Flag = 0, there is no Reject Resolution Required reject code.  Parameter added with PSO*421
 ; Output: ACTION: "I^Comments" - Ignore Reject
 ;                 "O^COD1^COD2^COD3" - Override with the Override codes COD1(Prof.),COD2(Reason) and COD3(Result)
 ;                 "D" - Discontinue
 ;                 "Q" - Quit
 ;                 "^" - Up-arrow entered or timed out
 ;
 N ACTION,COM,OVR,X,DIR,DIRUT,Y
 ;         
 I '$G(RX)!'$G(REJ) Q
 I '$G(PSONBILL) Q:'$D(^PSRX(RX,"REJ",REJ))
 ;
 ; - Display DUR/79 REJECT information and Reject Resolution Required REJECT information (RRR added PSO*421)
 D DISPLAY^PSOREJU3(RX,REJ,,RRR)
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
 N PSOIT
 ;
 ; - STOP/QUIT Action
 S ACTION=Y I ACTION="Q" Q ACTION
 ;
 ; - IGNORE Action 
 K DIR,DIRUT,X
 ;
 S PSOIT=""
 I ACTION="I" S PSOIT=$$IGNORE(RX,RFL)
 I $P(PSOIT,"^")=0 D  G ASK
 . I $P(PSOIT,"^",2)'="" D
 . . W $C(7),!,"Gross Amount Due is $"_$P(PSOIT,"^",2)_". IGNORE requires EPHARMACY SITE MANAGER key.",!
 ;
 ;PSO*7.0*358, add logic for TRICARE/CHAMPVA ignore
 I PSOTRIC,ACTION="I",'$$CONT W $C(7),!," ACTION NOT TAKEN!",! H 1 G ASK
 ;
 I ACTION="I" S:'PSOTRIC COM=$$COM() S:PSOTRIC COM=$$TCOM^PSOREJP3(RX,RFL) G ASK:COM="^" G ASK:'$$SIG() S ACTION=ACTION_"^"_COM
 ;
 ; - OVERRIDE Action
 I ACTION="O" D  G ASK:OVR="^"
 . S OVR=$$OVR() S ACTION=ACTION_"^"_OVR
 ;
DC1 ;Discontinue
 I ACTION="D" S ACTION=$$DC(RX,ACTION,1) I $D(DIRUT) S ACTION="D" D DISPLAY^PSOREJU3(RX,REJ) G ASK
 ;
 Q ACTION
 ;
DC(RX,ACTION,DC1) ; - Discontinue inside and outside call
 ; DC1 Indicates that DIRUT needs to be returned if applicable
 S DC1=+$G(DC1)
 N RXN,MSG,REA,DA,PSCAN,RXNUM
 S DA=RX,RXNUM=""
 ; Variable PSOTRIC is used by NOOR^PSOCAN4 to determine the default for the nature of order prompt
 I '$D(PSOTRIC) N PSOTRIC S PSOTRIC=$$TRIC^PSOREJP1(RX)
 N VALMBCK,PS
 S VALMBCK="",PS="Discontinue"
 D YN^PSOCAN I VALMBCK="R" W $C(7)," ACTION NOT TAKEN!",! H 1 S PSORX("DFLG")=1,ACTION="Q" S:DC1 DIRUT=1 Q ACTION
 N PKIR
 K DIR
 D COM^PSOCAN1 I $D(DIRUT) W $C(7)," ACTION NOT TAKEN!",! H 1 S PSORX("DFLG")=1,ACTION="Q" Q ACTION
 N PSOCANRD S PSOCANRD=$P(^PSRX(DA,0),"^",4)
 D REQ^PSOCAN4 I $D(DIRUT) W $C(7)," ACTION NOT TAKEN!",! H 1 S PSORX("DFLG")=1,ACTION="Q" Q ACTION
 S REA="C",RXNUM=$P(^PSRX(DA,0),"^")
 S MSG="Discontinued "_$S($G(PSOFDR):" from Reject Processing Screen",1:"")
 S PSCAN(RXNUM)=DA_"^C"
 D CAN^PSOCAN
 ;
 ; DMB-12/12/2011 - Removed setting PSOQFLAG.  Also fixed $$GET1 to use internal IEN.  I am not sure
 ; if these next two lines are even needed. It especially seems a bit premature at this point to
 ; remove the RX from the label list when the Rx probably hasn't been added yet.  In addition, PSORXL
 ; has code to remove discontinued RXs from the label list (using the ECME^PSORXL1 call).
 S PSOLST(1)=52_"^"_DA_"^"_$$GET1^DIQ(52,DA,100),ORN=1
 N PSOCKDC S PSOCKDC=1 D ECME^PSORXL1 I '$G(PPL) S PPL=""  ;remove rx from label print
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
 ; Called by ASK above (Reject Notification Screen)
 N COD1,COD2,COD3,DIR,DIRUT W !
 S COD1=$$OVRCOD(1,$$GET1^DIQ(52.25,REJ_","_RX,14)) I COD1="^"!(COD1="") Q "^"
 S COD2=$$OVRCOD(2) I COD2="^" Q COD2
 S COD3=$$OVRCOD(3) I COD3="^" Q COD3
 ;
 D OVRDSP^PSOREJU1(COD1_"^"_COD2_"^"_COD3) W !
 ;
 S DIR(0)="Y",DIR("A")="     Confirm? ",DIR("B")="YES"
 D ^DIR I $G(Y)=0!$D(DIRUT) Q "^"
 ;
 Q (COD1_"^"_COD2_"^"_COD3)
 ;
OVRDSP(LST) ; - Display the Override Codes
 N I W !
 F I=1:1:3 D
 . W !?5,$S(I=1:"Reason for Service Code  : ",I=2:"Professional Service Code: ",1:"Result of Service Code   : ")
 . W $E($$OVRX(I,$P(LST,"^",I)),1,48)
 Q
 ;
CLA() ; - Ask for up to 3 Clarification Codes
 ; Called by SMA^PSOREJP1 (SMA action) and CLA^PSOREJP1 (CLA action)
 N DIC,X,Y,PSOSCC,DTOUT,DUOUT,PSOQ,PSOI,I,DUP
 S DIC(0)="QEAM",DIC=9002313.25,PSOQ=0,PSOSCC=""
 F PSOI=1:1:3 Q:PSOQ  S DIC("A")="Submission Clarification Code "_PSOI_": " D CLADIC
 Q $S(PSOQ=1:"^",1:PSOSCC)
 ;
CLADIC ;
 ; DIC variables, PSOI, PSOSCC, and DUP newed and set by CLA
 D ^DIC
 I ($D(DUOUT))!($D(DTOUT)) S PSOQ=1 Q
 I Y=-1 S PSOQ=2 Q
 S DUP=0
 F I=1:1:PSOI I $P(PSOSCC,"~",I)=$P(Y,U,2) S DUP=1 Q
 I DUP=1 W "  Duplicates not allowed",! G CLADIC
 S $P(PSOSCC,"~",PSOI)=$P(Y,U,2)
 Q
 ;
HDLG(RX,RFL,CODES,FROM,OPTS,DEF) ; - REJECT Handling
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (r) CODES - List of REJECT CODES to be handled separated by commas (default is "79,88,943")
 ;       (r) FROM  - Same values as BWHERE param. in the EN^BPSNCPDP api
 ;       (r) OPTS  - Available options ("IOQ" for IGNORE/OVERRIDE/QUIT)
 ;       (o) DEF   - Default Option ("O", "I" or "Q")
 ;Output: ACTION   - "O"-Override, "I"-Ignore,"Q"-Quit,"D"-Discontinue,"^"-Up-arrow entered
 ;       
 N REJDATA,NEWDATA,ACTION,REJ,RESP,RESPI,REJI,PSOTRIC,RESPREJ,REJIEN,RRR
 S ACTION="",RRR=0
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 ; Get all open/unresolved rejects
 I '$$FIND^PSOREJUT(RX,RFL,.REJDATA) Q ACTION
 ;
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 ;
 ; Check for TRICARE/CHAMPVA open rejects, PSO*421
 I PSOTRIC D HDLGTC(.REJDATA,.OPTS,.DEF,.CODES,DUZ)
 ;
 ; In progress TRICARE/CHAMPVA Rx not allowed to be filled
 I PSOTRIC,$$STATUS^PSOBPSUT(RX,RFL)["IN PROGRESS" D TRICCHK^PSOREJU3(RX,RFL,"",FROM) Q ACTION
 ;
 ; Check for VET with open RRR rejects, PSO*421
 I 'PSOTRIC D HDLGRRR(.REJDATA,.OPTS,.DEF,.RRR,.CODES)
 ;
 ; Check for open rejects that match CODES
 I '$$FIND^PSOREJUT(RX,RFL,.REJDATA,CODES) Q ACTION
 ;
 ; Get reject for last response, if multiple responses exist.
 S REJ=$O(REJDATA(""))
 S ACTION=$$ACTION(RX,REJ,OPTS,$G(DEF),RRR)
 ; Loop through each REJECT IEN and perform action
 S REJI="" F  S REJI=$O(REJDATA(REJI)) Q:REJI=""  D
 . I $P(ACTION,"^")="I" D CLOSE^PSOREJUT(RX,RFL,REJI,DUZ,6,$P(ACTION,"^",2),"","","","","",1) D AUDIT^PSOTRI(RX,RFL,,$P(ACTION,"^",2),$S($$PSOET^PSOREJP3(RX,RFL):"N",1:"R"),$S(PSOTRIC=1:"T",PSOTRIC=2:"C",1:""))
 . I $P(ACTION,"^")="O" D CLOSE^PSOREJUT(RX,RFL,REJI,DUZ,1,,$P(ACTION,"^",2,4))
 . I $P(ACTION,"^")="D" D CLOSE^PSOREJUT(RX,RFL,REJI,DUZ,7,,$P(ACTION,"^",2))
 ; Resubmit claim if overriding
 I $P(ACTION,"^")="O" D
 . D ECMESND^PSOBPSU1(RX,RFL,,FROM,$$GETNDC^PSONDCUT(RX,RFL),,,$P(ACTION,"^",2,4),,.RESP)
 . I $G(RESP) D  Q
 . . W !!?10,"Claim could not be submitted. Please try again later!"
 . . W !,?10,"Reason: ",$S($P(RESP,"^",2)="":"UNKNOWN",1:$P(RESP,"^",2)),$C(7)
 . ; Get all open/unresolved rejects, PSO*421
 . K NEWDATA I $$FIND^PSOREJUT(RX,RFL,.NEWDATA) D  I ACTION="Q"!(ACTION="^") Q
 . . ;For TRICARE/CHAMPVA, override OPTS and DEF if necessary, PSO*421 
 . . I PSOTRIC D HDLGTC(.NEWDATA,.OPTS,.DEF,.CODES,DUZ)
 . . ;For Vet, override OPTS, DEF and set up RRR variable if necessary, PSO*421
 . . I 'PSOTRIC D HDLGRRR(.NEWDATA,.OPTS,.DEF,.RRR,.CODES)
 . . S OPTS=$TR(OPTS,"O")  ; Remove the "O" to prevent the user from picking the override option repeatedly
 . . I '$$FIND^PSOREJUT(RX,RFL,.NEWDATA,CODES) Q
 . . S ACTION=$$ACTION(RX,$O(NEWDATA("")),OPTS,$G(DEF),RRR) I ACTION="Q"!(ACTION="^") Q
 . . I $P(ACTION,"^")="I" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,6,$P(ACTION,"^",2),"","","","","",1) D AUDIT^PSOTRI(RX,RFL,,$P(ACTION,"^",2),"R",$S(PSOTRIC=1:"T",PSOTRIC=2:"C",1:""))
 . . I $P(ACTION,"^")="O" D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,1,,$P(ACTION,"^",2,4))
 Q ACTION
 ;
HDLGRRR(RRRDATA,OPTS,DEF,RRR,CODES)  ; Check for VET with open RRR rejects, new tag PSO*421
 ; Input: (r) RRRDATA - reject array returned by $$FIND 
 ; (r) OPTS  - Available options ("QIDO" for QUIT/IGNORE/DISCONTINUE/OVERRIDE)
 ;           - possibly modified by subroutine
 ; (r) DEF   - Default Option ("O", "I" or "Q")
 ;           - possibly modified by subroutine
 ; (r) CODES - Open reject codes
 ;           - modified by subroutine
 ; Output:(r) RRR   - Reject Resolution Required information  Flag(0/1)^Threshold Amt^Gross Amt Due
 ;           - only return a value for RRR if not 79 or 88 or 943
 ;
 N REJIEN,EX7988,SAVECODES
 S SAVECODES=CODES
 S (REJIEN,CODES)="",RRR=0,EX7988=0
 ; Set CODES with all open RRR, 79, 88, and 943 reject codes for RX/Fill returned from $$FIND
 F  S REJIEN=$O(RRRDATA(REJIEN)) Q:(REJIEN="")!EX7988  D
 . ;find RRR reject
 . I RRRDATA(REJIEN,"RRR FLAG")="YES" S RRR=1_U_RRRDATA(REJIEN,"RRR THRESHOLD AMT")_U_RRRDATA(REJIEN,"RRR GROSS AMT DUE"),CODES=RRRDATA(REJIEN,"CODE")_","_CODES Q
 . ; If reject code 79 or 88 or 943 is present, then don't set up RRR for display on reject notification screen (EX7988=1)
 . I "/79/88/943/"[("/"_RRRDATA(REJIEN,"CODE")_"/") S RRR=0,EX7988=1
 I 'RRR S CODES=SAVECODES Q  ;if not RRR, don't override CODES
 ;Strip the last comma off CODES
 I $E(CODES,$L(CODES))="," S CODES=$E(CODES,1,$L(CODES)-1)
 ; Set action prompt. 
 S OPTS="IQ",DEF="Q"
 Q
 ;
HDLGTC(REJDATA,OPTS,DEF,CODES,DUZ) ; Check for TRICARE/CHAMPVA open rejects, new tag PSO*421
 ; Input: (r) REJDATA - reject array returned by $$FIND 
 ; (r) OPTS  - Available options ("QIDO" for QUIT/IGNORE/DISCONTINUE/OVERRIDE)
 ;           - possibly modified by subroutine
 ; (r) DEF   - Default Option ("O", "I" or "Q")
 ;           - possibly modified by subroutine
 ; (r) CODES - Open reject codes
 ;           - modified by subroutine
 ; (r) DUZ   - Internal IEN of user
 N REJIEN
 S (REJIEN,CODES)=""
 ; Set CODES with all open reject codes for RX/Fill returned from $$FIND
 F  S REJIEN=$O(REJDATA(REJIEN)) Q:REJIEN=""  S CODES=REJDATA(REJIEN,"CODE")_","_CODES
 ; Strip the last comma off CODES
 I $E(CODES,$L(CODES))="," S CODES=$E(CODES,1,$L(CODES)-1)
 ; Set action prompt.
 S DEF="Q"
 S OPTS="DQ"
 I (","_CODES_",")[(",79,") S OPTS="ODQ"
 I (","_CODES_",")[(",88,") S OPTS="ODQ"
 I (","_CODES_",")[(",943,") S OPTS="ODQ"
 ; Include the Ignore action prompt if user holds key.
 I $D(^XUSEC("PSO TRICARE/CHAMPVA",DUZ)) S OPTS=OPTS_"I"
 Q
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
 ; Called by OVR above (reject notification screen), OVR^PSOREJP1 (OVR action)
 N DIC,DTOUT,DUOUT,FILE,PRPT,X,Y
 I TYPE=1 S FILE=9002313.23,PRPT="Reason for Service Code  : "
 I TYPE=2 S FILE=9002313.21,PRPT="Professional Service Code: "
 I TYPE=3 S FILE=9002313.22,PRPT="Result of Service Code   : "
 S DIC=FILE,DIC(0)="AQE",DIC("A")=PRPT
 I $G(VALUE)'="" S DIC("B")=VALUE
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) Q "^"
 ; At second and third prompts of the set, user entering no data is like exiting the option
 I TYPE'=1,Y<0 Q "^"
 Q $P(Y,"^",2)
 ; 
OVRCOD1(VALUE,NUM) ; - Prompt for Reason for Service Code - PSO*7*421
 ; Called by SMAOVR (SMA action) only
 N DIR,DTOUT,DTOUT,DIRUT,DIROUT,KFLAG,X,Y
 S DIR(0)="P^9002313.23:AOEMZ"
 S DIR("A")="Reason for Service Code "_NUM_"  "
 S DIR("B")=VALUE
 S DIR("PRE")="I X=""@"" S X=""^"",KFLAG=1"
 S KFLAG=0
 D ^DIR Q:KFLAG "@"
 I $D(DIRUT)!$D(DIROUT) Q "^"
 Q $P(Y,"^",2)
 ;
OVRCOD2(TYPE,VALUE,NUM) ; - Prompt for NCPDP Override Codes - PSO*7*421
 ; Called by SMAOVR (SMA action) only
 N DIC,DTOUT,DUOUT,FILE,PRPT,X,Y
 I TYPE=1 S FILE=9002313.23,PRPT="Reason for Service Code "_NUM_"  : "
 I TYPE=2 S FILE=9002313.21,PRPT="Professional Service Code "_NUM_": "
 I TYPE=3 S FILE=9002313.22,PRPT="Result of Service Code  "_NUM_"  : "
 S DIC=FILE,DIC(0)="AQE",DIC("A")=PRPT
 I $G(VALUE)'="" S DIC("B")=VALUE
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) Q "^"
 ; At second and third prompts of the set, user entering no data is like exiting the option
 I TYPE'=1,Y<0 Q "^"
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
 ; Input:  (r) CODE  - Current Reject Code (79 or 88 or 943)
 ;         (o) LST   - List of all Reject codes with response (comma separated)
 ; Output:     OTH   - List of OTHER Reject codes (w/out 79 or 88 or 943)
 ;
 N I,OTH
 F I=1:1:$L(LST,",") D
 . I $P(LST,",",I)]"",$P(LST,",",I)'=CODE S OTH=$G(OTH)_","_$P(LST,",",I)
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
 ;
DSC(FILE,VALUE,FIELD) ;Look up code descriptions
 N IEN
 I '$G(FILE)!($G(VALUE)="")!('$G(FIELD)) Q ""
 I '$D(^BPS(FILE)) Q ""
 I '$D(^BPS(FILE,"B",VALUE)) Q ""
 S IEN=$O(^BPS(FILE,"B",VALUE,"")) I '$D(^BPS(FILE,IEN)) Q ""
 Q $$GET1^DIQ(FILE,IEN,FIELD)
 ;
SMAOVR(RSC,NUM) ; - Ask for OVERRIDE codes - allows deletion of defaults - PSO*7*421
 ; Called by SMA^PSOREJP1 (SMA action)
 ;
 ; INPUT: RSC - Reason for Service code
 ;        NUM - Sequence number (1-3)
 ;
 N COD1,COD2,COD3 W !
 I RSC]"" S COD1=$$OVRCOD1($G(RSC),NUM) I COD1="^"!(COD1="")!(COD1="@") Q COD1
 I RSC']"" S COD1=$$OVRCOD2(1,$G(RSC),NUM) I COD1="^"!(COD1="") Q COD1
 S COD2=$$OVRCOD2(2,"",NUM) I COD2="^" Q "^"
 S COD3=$$OVRCOD2(3,"",NUM) I COD3="^" Q "^"
 Q (COD1_U_COD2_U_COD3)
 ;
IGNORE(RX,RFL) ;
 ; RX = Prescription IEN
 ; RFL = Refill
 ; Return value 1 = Allow IGNORE.
 ; Return value 0 = Don't allow IGNORE.
 ; Return value 0^GrossAmtDue = Don't allow. Return amt for user msg.
 ;
 N DIR,DIRUT,PSOAMT,PSODIV,PSODIVIEN,PSOIGNORE
 ;
 ; Get Gross Amount Due
 S PSOAMT=$$AMT^BPSBUTL(RX,RFL)  ; DBIA #4719
 ;
 ; Get Ignore Threshold Value
 S PSODIV=$$GET1^DIQ(52,RX,20,"I")
 S PSODIVIEN=$O(^PS(52.86,"B",PSODIV,""))
 S PSOIGNORE=$$GET1^DIQ(52.86,PSODIVIEN,7)
 ;
 ; If Ignore Threshold is NIL or Gross Amt Due < Ignore
 ; Threshold - Allow IGNORE. Check of security key not
 ; required for these conditions.
 I (PSOIGNORE="")!(PSOAMT<PSOIGNORE) Q 1
 ;
 ; At this point Gross Amt Due is equal to or greater
 ; than the Ignore Threshold. User must have required
 ; security key to continue.
 ;
 S PSOAMT=$J(PSOAMT*100\1/100,0,2)
 ;
 ; User does not have required security key to continue.
 ; Don't allow IGNORE. Return PSOAMT to be used in message
 ; to user.
 I '$D(^XUSEC("PSO EPHARMACY SITE MANAGER",DUZ)) Q 0_"^"_PSOAMT
 ;
 ; User has required security key. Prompt if OK to continue.
 S DIR(0)="Y"
 S DIR("A")="Gross Amount Due is $"_PSOAMT_". Do you want to continue (Y/N)"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q 0
 Q Y

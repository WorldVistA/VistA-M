PSOREJU3 ;BIRM/LJE - BPS (ECME) - Clinical Rejects Utilities (3) ;04/25/08
 ;;7.0;OUTPATIENT PHARMACY;**287,290,358,359,385,421,427,448,478,513,482,528,561,562,680**;DEC 1997;Build 5
 ; Reference to 9002313.99 in ICR #4305
 ; Reference to $$CLAIM^BPSBUTL in ICR #4719
 ; Reference to LOG^BPSOSL in ICR #6764
 ; Reference to IEN59^BPSOSRX in ICR #4412
 ; Reference to $$CSNPI^BPSUTIL in ICR #4146
 ;
 Q
 ;
TRICCHK(RX,RFL,RESP,FROM,RVTX) ;check to see if Rx is non-billable or in an "In Progress" state on ECME
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (r) RFL - REFILL
 ;         (o) RESP - Response from $$EN^BPSNCPDP api
 ;   TRICCHK assumes that the calling routine has validated that the fill is TRICARE or CHAMPVA.
 ;
 ;  - \Need to be mindful of foreground and background processing.
 ;
 N ESTAT,ETOUT,NFROM,PSOBEI
 I '$D(FROM) S FROM=""
 S ESTAT=$P(RESP,"^",4)
 S NFROM=0
 I FROM="PL"!(FROM="PC") S NFROM=1
 Q:ESTAT["PAYABLE"!(ESTAT["REJECTED")
 S PSOBEI=$$ELIGDISP^PSOREJP1(RX,RFL)
 ;
 D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRICCHK, RESP="_RESP)  ; ICR#s 4412,6764
 D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRICCHK, FROM="_FROM_"  ESTAT="_ESTAT)
 I ESTAT["IN PROGRESS",FROM="PC" D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-Would have noted in Activity Log that Rx was left in CMOP suspense") Q  ; ICR#s 4412,6764
 ;
 I ESTAT["IN PROGRESS",FROM="RRL"!($G(RVTX)="RX RELEASE-NDC CHANGE") D  Q
 . I 'NFROM D
 . . W !!,PSOBEI_" Prescription "_$$GET1^DIQ(52,RX,".01")_" cannot be released until ECME 'IN PROGRESS'"
 . . W !,"status is resolved payable.",!!
 ;
 I $D(RESP) D  Q
 . I +RESP=6 W:'NFROM&('$G(CMOP)) !!,"Inactive ECME "_PSOBEI,!! D  Q
 . . S ACT="Inactive ECME "_PSOBEI D RXACT^PSOBPSU2(RX,RFL,ACT,"M",DUZ)
 . I +RESP=2!(+RESP=3) N PSONBILL S PSONBILL=1 D TRIC2 Q
 . I +RESP=4!(ESTAT["IN PROGRESS") D  Q
 . . ;
 . . ; Do not put the Rx into the suspense queue if this claim activity
 . . ; was triggered by a release message from OPAI or CMOP.
 . . ; 
 . . I $E(FROM,1,2)="CR" Q
 . . ;
 . . ; Put the Rx into the suspense queue.
 . . ;
 . . N PSONPROG S PSONPROG=1 D TRIC2
 ;
 Q
 ;
TRIC2 ;
 N ACTION,DA,DIR,DIRUT,PSCAN,PSOIT,PSORESP,PSOTRIC
 N REA,REJ,REJCOD,REJDATA,X,ZZZ
 S PSOTRIC=1,REJ=9999999999
 D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRIC2, CMOP="_$G(CMOP)_" PSONPROG="_$G(PSONPROG))
 I $G(CMOP)&($G(PSONPROG)) D TACT Q
 ;
 ; If the prescription is non-billable, put the eT/eC reject on the
 ; Prescription (WRKLST^PSOREJU4), then determine the reject number.
 ;
 I +RESP=2 D
 . D WRKLST^PSOREJU4(RX,RFL,,DUZ,DT,1,"",RESP)
 . S X=$$FIND^PSOREJUT(RX,RFL,.REJDATA,"eT,eC",1)
 . S REJ=0
 . F  S REJ=$O(REJDATA(REJ)) Q:'REJ  I "eT,eC"[REJDATA(REJ,"CODE") Q
 . Q
 ;
 Q:$G(CMOP)
 D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRIC2, NFROM="_NFROM)
 I 'NFROM D DISPLAY(RX,REJ)
 I 'NFROM&($G(PSONPROG)) D  D SUSP Q
 . W !!,"This prescription will be suspended.  After the third party claim is resolved,"
 . W !,"it may be printed or pulled early from suspense.",!
 . R !!,"Press <RETURN> to continue...",ZZZ:60,!
 I NFROM&($G(PSONPROG)) D TACT Q
 Q:NFROM
TRIC3 ;
 D MSG
 I FROM="PL"!(FROM="PC") D SUSP Q
 ;cnf, PSO*7*358, add code for options
 N ACTION,COM,DEF,DIR,DIRUT,OPTS
TRIC4 S DIR(0)="SO^",DIR("A")="",OPTS="DQ",DEF="D"
 S PSORESP=$P($G(RESP),U,2)
 I PSORESP["NO ACTIVE/VALID ROI" S DEF="Q"  ;IB routine IBNCPDP1 contains this text.
 I PSORESP="NOT INSURED" S DEF="Q"
 ;reference to ^XUSEC( supported by IA 10076
 I $D(^XUSEC("PSO TRICARE/CHAMPVA",DUZ)) S OPTS=OPTS_"I" ;PSO*7.0*358, if user has security key, include IGNORE in TRICARE/CHAMPVA options
 S:(OPTS["D") DIR(0)=DIR(0)_"D:(D)iscontinue - DO NOT FILL PRESCRIPTION;",DIR("A")=DIR("A")_"(D)iscontinue,"
 S:(OPTS["Q") DIR(0)=DIR(0)_"Q:(Q)UIT - SEND TO WORKLIST (REQUIRES INTERVENTION);",DIR("A")=DIR("A")_"(Q)uit,"
 S:(OPTS["I") DIR(0)=DIR(0)_"I:(I)GNORE - FILL Rx WITHOUT CLAIM SUBMISSION;",DIR("A")=DIR("A")_"(I)gnore,"
 S $E(DIR(0),$L(DIR(0)))="",$E(DIR("A"),$L(DIR("A")))="",DIR("??")="^D HELP^PSOREJU2("""_OPTS_""")"
 S:$G(DEF)'="" DIR("B")=DEF D ^DIR I $D(DIRUT) S Y="Q" W !
 ;
 S ACTION=Y
 I ACTION="D" S ACTION=$$DC^PSOREJU1(RX,ACTION)    ;cnf, PSO*7*358
 S PSOIT=""
 I ACTION="I" S PSOIT=$$IGNORE^PSOREJU1(RX,RFL)
 I $P(PSOIT,"^")=0 D  G TRIC4
 . I $P(PSOIT,"^",2)'="" D
 . . W $C(7),!,"Gross Amount Due is $"_$P(PSOIT,"^",2)_". IGNORE requires EPHARMACY SITE MANAGER key."
 I ACTION="I" G TRIC4:'$$CONT^PSOREJU1() S COM=$$TCOM^PSOREJP3(RX,RFL) G TRIC4:COM="^" G TRIC4:'$$SIG^PSOREJU1() D
 . D CLOSE^PSOREJUT(RX,RFL,REJ,DUZ,6,COM,"","","","","",1)   ;TRICARE/CHAMPVA non-billable should have only 1 reject - eT/eC
 . D AUDIT^PSOTRI(RX,RFL,,COM,$S($$PSOETEC^PSOREJP5(RX,RFL):"N",1:"R"),$P(RESP,"^",3))
 Q
 ;
MSG ;
 W !!,"This is a non-billable "_$$ELIGDISP^PSOREJP1(RX,RFL)_" prescription."    ;cnf, PSO*7*358
 Q
SUSP ;Suspense Rx due to IN PROGRESS status in ECME
 D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-SUSP")
 N DA,ACT,RX0,SD,RXS,PSOWFLG,DIK,RXN,XFLAG,RXP,DD,DO,X,Y,DIC,VALMSG,COMM,LFD,DFLG,RXCMOP
 N PSOQFLAG,PSORXZD,PSOQFLAG,PSOKSPPL,PSOZXPPL,PSOZXPI,RXLTOP
 S DA=RX D SUS^PSORXL1
TACT ;
 D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TACT, PSONPROG="_$G(PSONPROG)_"  PSONBILL="_$G(PSONBILL))
 S ACT=$$ELIGDISP^PSOREJP1(RX,RFL)_"-Rx placed on Suspense due to"_$S($G(PSONPROG):" ECME IN PROGRESS status",$G(PSONBILL):"the Rx being Non-billable",1:"")
 I '$G(DUZ) N DUZ S DUZ=.5
 D RXACT^PSOBPSU2(RX,RFL,ACT,"M",DUZ)
 Q
 ;
DISPLAY(RX,REJ,KEY,RRR) ; - Displays REJECT information
 ; Input:  (r) RX  - Rx IEN (#52) 
 ;         (r) REJ - REJECT ID (IEN)
 ;         (o) KEY - Display "Press any KEY to continue..." (1-YES/0-NO) (Default: 0)
 ;         (o) RRR - Reject Resolution Required information  Flag(0/1)^Threshold Amt^Gross Amt Due  (Default: 0)
 ;                   If Flag = 0, there is no Reject Resolution Required reject code.  Parameter added with PSO*421
 ;         
 Q:$G(NFROM)
 I '$G(RX)!'$G(REJ) Q
 I '$D(^PSRX(RX,"REJ",REJ))&('$G(PSONBILL))&('$G(PSONPROG)) Q
 ;
 N DATA,RFL,LINE,%
 S RFL=+$$GET1^DIQ(52.25,REJ_","_RX,5)
 I '$G(PSONBILL)&('$G(PSONPROG)) D GET^PSOREJU2(RX,RFL,.DATA,REJ) I '$D(DATA(REJ)) Q
 ;
 D HDR
 S $P(LINE,"-",74)="" W !?3,LINE
 W !?3,$$DVINFO(RX,RFL)
 W !?3,$$PTINFO^PSOREJU2(RX)
 W !?3,"Rx/Drug  : ",$$GET1^DIQ(52,RX,.01),"/",RFL," - ",$E($$GET1^DIQ(52,RX,6),1,20),?54
 W:'$G(PSONBILL)&('$G(PSONPROG)) "ECME#: ",$P($$CLAIM^BPSBUTL(RX,RFL),U,6)
 D TYPE G DISP2:$G(PSONBILL)!($G(PSONPROG))
 I $G(DATA(REJ,"PAYER MESSAGE"))'="" W !?3,"Payer Message: " D PRT^PSOREJU2("PAYER MESSAGE",18,58)
 I $G(DATA(REJ,"DUR TEXT"))'="" W !?3,"DUR Text     : ",DATA(REJ,"DUR TEXT")
 W !?3,"Insurance    : ",DATA(REJ,"INSURANCE NAME"),?50,"Contact: ",DATA(REJ,"PLAN CONTACT")
 W !?3,"Group Name   : ",$E(DATA(REJ,"GROUP NAME"),1,26)
 W ?45,"Group Number: ",$E(DATA(REJ,"GROUP NUMBER"),1,15)
 I $G(DATA(REJ,"CARDHOLDER ID"))'="" W !?3,"Cardholder ID: ",$E(DATA(REJ,"CARDHOLDER ID"),1,20)
 I DATA(REJ,"PLAN PREVIOUS FILL DATE")'="" D
 . W !?3,"Last Fill Dt.: ",DATA(REJ,"PLAN PREVIOUS FILL DATE")
 . W:DATA(REJ,"PLAN PREVIOUS FILL DATE")'="" "   (from payer)"
 ;
 N PSOAR,PSOCNT,PSOCOMMENT,PSODATA,PSODATE,PSODATE1
 N PSODFN,PSOPC,PSOSTATUS,PSOSTR,PSOUSER
 ;
 ; Get Patient ID
 S PSODFN=$$GET1^DIQ(52,RX,2,"I")
 ;
 ; Loop through Patient Comments - Add ACTIVE Comments to PSOAR array
 S PSODATE=""
 S PSOCNT=0
 K PSOAR
 F  S PSODATE=$O(^PS(55,PSODFN,"PC","B",PSODATE)) Q:PSODATE=""  D
 . S PSOPC=""
 . F  S PSOPC=$O(^PS(55,PSODFN,"PC","B",PSODATE,PSOPC)) Q:PSOPC=""  D
 . . K PSODATA
 . . D GETS^DIQ(55.17,PSOPC_","_PSODFN_",",".01;1;2;3","IE","PSODATA")
 . . ; 
 . . ; Only display ACTIVE Patient Comments
 . . S PSOSTATUS=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",2,"I"))
 . . I PSOSTATUS'="Y" Q
 . . ;
 . . S PSODATE1=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",.01,"E"))
 . . S PSOUSER=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",1,"E"))
 . . S PSOCOMMENT=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",3,"E"))
 . . S PSOSTR=PSODATE1_" - "_PSOCOMMENT_" ("_PSOUSER_")"
 . . S PSOCNT=PSOCNT+1
 . . S PSOAR(PSOCNT)=PSOSTR
 ;
 ; If PSOAR array exists, display Active Patient Comments
 I $D(PSOAR) D
 . W !?3,"Patient Billing Comment(s):"
 . ;
 . ; Loop through PSOAR in reverse order to display Patient
 . ; Comments in reverse chronological order
 . S PSOCNT=""
 . F  S PSOCNT=$O(PSOAR(PSOCNT),-1) Q:PSOCNT=""  D
 . . ;
 . . ; Use ^DIWP to display Patient Comments with proper
 . . ; line breaking
 . . N %,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z
 . . K ^UTILITY($J,"W")
 . . S X=PSOAR(PSOCNT)
 . . S DIWL=1
 . . S DIWR=78
 . . D ^DIWP
 . . ;
 . . S PSOLAST=0
 . . F PSOY=1:1 Q:('$D(^UTILITY($J,"W",1,PSOY,0)))  D
 . . . S PSOCOM=$G(^UTILITY($J,"W",1,PSOY,0))
 . . . W !?3,PSOCOM
 . K ^UTILITY($J,"W")
 ;
 I $G(RRR) D   ;added with PSO*421
 . W !!?3,"Reject Resolution Required"
 . W !?3,"Gross Amount Due ($"_$J($P(RRR,U,3)*100\1/100,0,2)_") is greater than or equal to"
 . W !?3,"Threshold Dollar Amount ($"_$P(RRR,U,2)_")"
 . W !?3,"Please select Quit to resolve this reject on the Reject Worklist."
DISP2 ;
 W !?3,LINE,$C(7) I $G(KEY) W !?3,"Press <RETURN> to continue..." R %:DTIME W !
 Q
 ;
TYPE ;
 I $G(PSONBILL)!($G(PSONPROG)) D  Q
 . D NOW^%DTC S Y=% D DD^%DT
 . W !?3,"Date/Time: "_$$FMTE^XLFDT(Y)
 . W !?3,"Reason   : ",$S($G(PSONBILL):"Not Billable.",$G(PSONPROG):"ECME Status is in an 'IN PROGRESS' state and cannot be filled",1:"")
 ;
 I $G(DATA(REJ,"REASON"))'="" W !?3,"Reason   : " D PRT^PSOREJU2("REASON",14,62)
 N RTXT,OCODE,OTXT,I
 S (OTXT,RTXT,OCODE)="",RTXT=$S(DATA(REJ,"CODE")=79:"REFILL TOO SOON",DATA(REJ,"CODE")=88!(DATA(REJ,"CODE")=943):"DUR REJECT",1:$$EXP^PSOREJP1(DATA(REJ,"CODE")))_" ("_DATA(REJ,"CODE")_")"
 F I=1:1 S OCODE=$P(DATA(REJ,"OTHER REJECTS"),",",I) Q:OCODE=""   D
 . S OTXT=OTXT_", "_$S(OCODE=79:"REFILL TOO SOON",OCODE=88!(OCODE=943):"DUR REJECT",1:$$EXP^PSOREJP1(OCODE))_" ("_OCODE_")"
 S RTXT=RTXT_OTXT_".  Received on "_$$FMTE^XLFDT($G(DATA(REJ,"DATE/TIME")))_"."
 S OTXT=""
 W !?3,"Reject(s): " D WRAP(RTXT,14)
 Q
 ;
WRAP(PSOTXT,INDENT) ;
 N I,K,PSOWRAP,PSOMARG
 S PSOWRAP=1,PSOMARG=$S('$G(PSORM):80,$D(IOM):IOM,1:80)-(INDENT+5)
W1 S:$L(PSOTXT)<PSOMARG PSOWRAP(PSOWRAP)=PSOTXT I $L(PSOTXT)'<PSOMARG F I=PSOMARG:-1:0 I $E(PSOTXT,I)?1P S PSOWRAP(PSOWRAP)=$E(PSOTXT,1,I),PSOTXT=$E(PSOTXT,I+1,999),PSOWRAP=PSOWRAP+1 G W1
 F K=1:1:PSOWRAP W ?INDENT,PSOWRAP(K),!
 Q
 ;
HDR ; Display the reject notification screen header
 N ELDSP,TAB
 S ELDSP=$$ELIGTCV^PSOREJP1(RX,RFL,1)  ; returns TRICARE, CHAMPVA or VETERAN
 I $L(ELDSP) S ELDSP=ELDSP_" - "       ; Add the " - " for CVA/TRI only
 ;
 I $G(PSONBILL) S TAB=$S($L(ELDSP):24,1:29) W !!?TAB,"*** "_ELDSP_"NON-BILLABLE ***" Q
 I $G(PSONPROG) S TAB=$S($L(ELDSP):18,1:23) W !!?TAB,"*** "_ELDSP_"'IN PROGRESS' ECME status ***" Q
 S TAB=$S($L(ELDSP):11,1:16) W !!?TAB,"*** "_ELDSP_"REJECT RECEIVED FROM THIRD PARTY PAYER ***"
 Q
 ;
SUBMIT(RXIEN,RFCNT,PSOTRIC) ;called from PSOCAN2 (routine size exceeded)
 N SUBMITE S SUBMITE=$$SUBMIT^PSOBPSUT(RXIEN)
 I SUBMITE D
 . N ACTION
 . D ECMESND^PSOBPSU1(RXIEN,,,$S($O(^PSRX(RXIEN,1,0)):"RF",1:"OF"))
 . ; Quit if there is an unresolved TRICARE or CHAMPVA non-billable reject code, PSO*7*358
 . I $$PSOET^PSOREJP3(RXIEN) S ACTION="Q" Q 
 . I $$FIND^PSOREJUT(RXIEN) S ACTION=$$HDLG^PSOREJU1(RXIEN,,"79,88,943","OF","IOQ","Q")
 I 'SUBMITE&(PSOTRIC) D
 . I $$STATUS^PSOBPSUT(RXIEN,RFCNT'["PAYABLE") D TRICCHK(RXIEN,RFCNT)
 Q
 ;
TRISTA(RX,RFL,RESP,FROM,RVTX) ;called from suspense
 N ETOUT,ESTAT,TRESP,TSTAT,PSOTRIC
 S:'$D(RESP) RESP=""
 S (ESTAT,PSOTRIC)="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 Q:'PSOTRIC 0
 S TRESP=RESP,ESTAT=$P(TRESP,"^",4) S:ESTAT="" ESTAT=$$STATUS^PSOBPSUT(RX,RFL)
 Q:ESTAT["E PAYABLE" 0
 I $$TRIAUD(RX,RFL) D  Q 0  ;if TRICARE or CHAMPVA Rx is in audit due to override or bypass, allow to print from suspense, cnf
 . D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRISTA, $$TRIAUD returned 1, $$TRISTA is Quitting with 0")  ; ICR#s 4412,6764
 I +RESP=2,$$BYPASS^PSOBPSU1($P(RESP,"^",3),$P(RESP,"^",2)) D  Q 0   ;if 'Bypass' RX, allow to print from suspense, cnf
 . D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRISTA, $$BYPASS returned 1, $$TRISTA is Quitting with 0")  ; ICR#s 4412,6764
 Q:ESTAT["E REJECTED" 1  ;rejected TRICARE or CHAMPVA is not allowed to print from suspense
 ;if 'in progress' (4) or not billable (2,3) don't allow to print from suspense (IA 4415 Values)
 I '$D(RESP)!($P(RESP,"^",1)="")!($G(RESP)="") D
 . S TSTAT=$$STATUS^PSOBPSUT(RX,RFL) S TRESP=$S(TSTAT["IN PROGRESS":4,TSTAT["NOT BILLABLE":2,1:0)
 . S $P(TRESP,"^",4)=TSTAT
 ;
 I +TRESP=2!(+TRESP=3) D  Q 1
 . D WRKLST^PSOREJU4(RX,RFL,"",DUZ,DT,1,"",RESP)  ;send TRICARE or CHAMPVA non billable to worklist (pseudo reject), cnf
 . D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRISTA, calling WRKLST~PSOREJU4, $$TRISTA is Quitting with 1")  ; ICR#s 4412,6764
 I +TRESP=4!(ESTAT["IN PROGRESS") D  Q 1
 . D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-TRISTA, TRESP="_TRESP_", ESTAT="_ESTAT_", $$TRISTA is Quitting with 1")  ; ICR#s 4412,6764
 Q 0
 ;
TRIAUD(RXIEN,RXFILL) ;is RXIEN in the TRICARE/CHAMPVA audit and no open rejects  ;cnf
 ; RXIEN will only be in TRICARE/CHAMPVA audit if a bypass or override has occurred and rejects are closed
 ; returns  0  if RXIEN is not in TRICARE/CHAMPVA audit at all or not in audit for right fill number
 ;             rejects must be closed for 0 to be returned
 ;          1  if RXIEN is in TRICARE/CHAMPVA audit for the right fill number and rejects are closed
 ;
 N X,AUDIEN,REJIEN
 S X=0,AUDIEN=""
 I '$D(^PS(52.87,"C",RXIEN)) Q X   ;RXIEN is not in the TRICARE/CHAMPVA audit
 ;
 I $G(RXFILL)="" S RXFILL=$$LSTRFL^PSOBPSU1(RXIEN)  ;Get latest fill if not passed in
 ;
 ;check audit entries for right fill number
 F  S AUDIEN=$O(^PS(52.87,"C",RXIEN,AUDIEN)) Q:AUDIEN=""  I RXFILL=$$GET1^DIQ(52.87,AUDIEN,2) S X=1 Q
 I 'X Q X
 ;
 ;make sure rejects are closed
 S REJIEN=0
 F  S REJIEN=$O(^PSRX(RXIEN,"REJ",REJIEN)) Q:'+REJIEN  D  I 'X Q   ;I 'X, then the reject is not closed
 . S X=$$CLOSED^PSOREJP1(RXIEN,REJIEN,0)
 ;
 Q X
 ;
ECMECHK(RX,FILL) ;
 ; This function returns a '1' if any of the conditions below are met:
 ;    - RX has an unresolved DUR or Refill Too Soon reject
 ;    - RX has an unresolved Reject Resolution Required (RRR) reject (only for Veteran and original fill)
 ;    - RX is TRICARE/CHAMPVA and has any unresolved reject
 ;    - RX is TRICARE/CHAMPVA and IN PROGRESS
 ; This is used by functions such as PPLADD^PSOSUPOE to determine if
 ;   a label should be printed (we do not want a label for the conditions)
 ;
 ; Incoming Parameters:
 ;   RX - Internal IEN of the Prescription File (required)
 ;   FILL - Fill Number (optional, defaults to last fill if not passed in)
 ; Returns:
 ;   0 - None of the conditions exists
 ;   1 - One of the conditions above is met
 ;
 I '$G(RX) Q 0
 I $G(FILL)="" S FILL=$$LSTRFL^PSOBPSU1(RX)
 ;
 ; DUR or Refill Too Soon or RRR rejects
 I $$FIND^PSOREJUT(RX,FILL,"","79,88,943",,1) Q 1
 ;
 ; If not TRICARE/CHAMPVA, quit with 0 as the rest of the checks
 ;   are all TRICARE/CHAMPVA dependent
 I '$$TRIC^PSOREJP1(RX,FILL) Q 0
 ;
 ; No label for TRICARE/CHAMPVA with unresolved rejects
 I $$FIND^PSOREJUT(RX,FILL,,,1) Q 1   ; 5th parameter to $$FIND also finds non-billable TRI/CVA rejects
 ;
 ;No label for TRICARE/CHAMPVA claims that are IN PROGRESS
 I $P($$STATUS^PSOBPSUT(RX,FILL),U)="IN PROGRESS" Q 1
 Q 0
 ;
DVINFO(RX,RFL,LM) ; Returns header displayable Division Information
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill # (Default: most recent)
 ;       (o) LM   - ListManager format? (1 - Yes / 0 - No) - Default: 0
 N DVIEN,DVINFO,NCPNPI,TXT
 S DVIEN=+$$RXSITE^PSOBPSUT(RX,RFL)
 S DVINFO="Division : "_$$GET1^DIQ(59,DVIEN,.01)
 ;
 ; Check for Controlled Substance Drug and if a BPS Pharmacy for CS has
 ; been defined.  If so, use NCPDP# & NPI for the CS Pharmacy.
 S NCPNPI=$$CSNPI^BPSUTIL(RX,RFL)
 ;
 ; If not a Controlled Substance, use NCPDP# & NPI info based on Division.
 ; Display both NPI and NCPDP numbers - PSO*7.0*421
 I +NCPNPI=-1 S NCPNPI=$$DIVNCPDP^BPSBUTL(DVIEN)
 S $E(DVINFO,33)="NPI: "_$P(NCPNPI,U,2)
 S $E(DVINFO,$S($G(LM):59,1:52))="NCPDP: "_$P(NCPNPI,U)
 Q DVINFO

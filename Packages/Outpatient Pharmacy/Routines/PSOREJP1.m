PSOREJP1 ;BIRM/MFR - Third Party Reject Display Screen ;04/29/05
 ;;7.0;OUTPATIENT PHARMACY;**148,247,260,281,287,289,290,358,359**;DEC 1997;Build 27
 ;Reference to File 9002313.93 - BPS NCPDP REJECT CODES supported by IA 4720
 ;Reference to ^PS(59.7 supported by IA 694
 ;Reference to ^PSDRUG("AQ" supported by IA 3165
 ;Reference to File 9002313.25 supported by IA 5064
 ;
EN(RX,REJ,CHANGE) ; Entry point
 ;
 ; - DO NOT change the IF logic below as both of them might get executed (intentional)
 N FILL,LASTLN,PSOTRIC,PSOCODE,PSOTCODE
 S FILL=+$$GET1^DIQ(52.25,REJ_","_RX,5)
 S PSOTRIC="",PSOTRIC=$$TRIC(RX,FILL,PSOTRIC),PSOCODE=$$GET1^DIQ(52.25,REJ_","_RX,.01)
 S PSOTCODE=0 S:PSOCODE'=79&(PSOCODE'=88)&(PSOTRIC) PSOTCODE=1
 I $$CLOSED(RX,REJ) D EN^VALM("PSO REJECT DISPLAY - RESOLVED")
 I '$$CLOSED(RX,REJ)&(PSOTRIC) D EN^VALM("PSO REJECT TRICARE")   ;cnf, PSO*7*358, replace PSOTCODE with PSOTRIC
 I '$$CLOSED(RX,REJ)&('PSOTCODE)&('PSOTRIC) D EN^VALM("PSO REJECT DISPLAY")   ;cnf, PSO*7*358, add PSOTRIC check
 D FULL^VALM1
 Q
 ;
HDR      ; - Builds the Header section
 N LINE1,LINE2,X
 S VALMHDR(1)=$$DVINFO^PSOREJU2(RX,FILL,1),VALMHDR(2)=$$PTINFO^PSOREJU2(RX,1)
 ;cnf, PSO*7*358, add REJ to parameter list for RXINFO^PSOREJP3
 S VALMHDR(3)=$$RXINFO^PSOREJP3(RX,FILL,1),VALMHDR(4)=$$RXINFO^PSOREJP3(RX,FILL,2,REJ)
 Q
 ;
TRIC(RX,RFL,PSOTRIC) ; - Return 1 for TRICARE or 0 (zero) for not TRICARE
 S PSOTRIC="",PSOTRIC=$S(RFL=0&($$GET1^DIQ(52,RX_",",85,"I")="T"):1,$$GET1^DIQ(52.1,RFL_","_RX_",",85,"I")="T":1,1:0)
 Q PSOTRIC
 ;
INIT ; Builds the Body section
 N DATA,LINE
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S PSOTRIC="",PSOTRIC=$$TRIC(RX,RFL,PSOTRIC)
 F I=1:1:$G(LASTLN) D RESTORE^VALM10(I)
 K ^TMP("PSOREJP1",$J) S VALMCNT=0,LINE=0
 D GET^PSOREJU2(RX,FILL,.DATA,REJ,1)
 D REJ                   ; Display the REJECT Information
 D OTH                   ; Display the Other Rejects Information
 D COM^PSOREJP3          ; Display the Comment
 D INS                   ; Display the Insurance Information
 D CLS                   ; Display the Resolution Information
 S VALMCNT=LINE
 Q
 ;
REJ ; - DUR Information
 N TYPE,PFLDT,TREJ,TDATA,PSOTRIC,PSOET S TDATA=""
 S PSOTRIC="",PSOTRIC=$$TRIC(RX,FILL,PSOTRIC)
 D SETLN("REJECT Information"_$S($G(PSOTRIC):" (TRICARE)",1:""),1,1)
 S TYPE=$S($G(DATA(REJ,"CODE"))=79:"79 - REFILL TOO SOON",1:"")
 I TYPE="" S TYPE=DATA(REJ,"CODE")_" - "_$E($$EXP(DATA(REJ,"CODE")),1,23)_"-"
 D SETLN("Reject Type    : "_TYPE_" received on "_$$FMTE^XLFDT($G(DATA(REJ,"DATE/TIME"))),,,18)
 ;cnf, PSO*7*358, if TRICARE non-billable then reset Status line
 S PSOET=$$PSOET^PSOREJP3(RX,FILL)
 I PSOET D SETLN("Status         : NO CLAIM SUBMITTED")
 I 'PSOET D SETLN("Reject Status  : "_$G(DATA(REJ,"STATUS"))_" - "_$$STATUS^PSOBPSUT(RX,FILL),,,18)
 D SET("PAYER MESSAGE",63)
 D SET("REASON",63)
 S PFLDT=$$FMTE^XLFDT($G(DATA(REJ,"PLAN PREVIOUS FILL DATE")))
 D SET("DUR TEXT",63,$S(PFLDT="":1,1:0))
 I PFLDT'="" D SETLN("Last Fill Date : "_PFLDT_" (from payer)",,1,18)
 Q
 ;
OTH ; - Other Rejects Information
 N LST,I,RJC,J,LAST
 S LST=$G(DATA(REJ,"OTHER REJECTS")) I LST="" Q
 D SETLN()
 D SETLN("OTHER REJECTS",1,1)
 F I=1:1:$L(LST,",") S RJC=$P(LST,",",I) D
 . S LAST=1 F J=(I+1):1:$L(LST,",") I $P(LST,",",J)'="" S LAST=0 Q
 . I RJC'="" D SETLN(RJC_" - "_$$EXP(RJC),,$S(LAST:1,1:0),6)
 Q
 ;
INS ; - Insurance Information
 D SETLN()
 D SETLN("INSURANCE Information",1,1)
 N PSOINS,PSOINS1,I
 S PSOINS=$G(DATA(REJ,"INSURANCE NAME"))
 F I=1:1:(50-($L(PSOINS)+18)) S PSOINS=PSOINS_" "
 S PSOINS1=$G(DATA(REJ,"COB"))
 I PSOINS1="SECONDARY" S PSOINS=PSOINS_"Coord. Of Benefits: "_PSOINS1
 D SETLN("Insurance      : "_PSOINS,,,18)
 D SETLN("Contact        : "_$G(DATA(REJ,"PLAN CONTACT")),,,18)
 D SETLN("Group Name     : "_$G(DATA(REJ,"GROUP NAME")),,,18)
 D SETLN("Group Number   : "_$G(DATA(REJ,"GROUP NUMBER")),,,18)
 D SETLN("Cardholder ID  : "_$G(DATA(REJ,"CARDHOLDER ID")),,1,18)
 Q
 ;
CLS ; - Resolution Information
 N X
 I '$$CLOSED(RX,REJ) Q
 D SETLN()
 D SETLN("RESOLUTION Information",1,1)
 D SETLN("Resolved By    : "_$G(DATA(REJ,"CLOSED BY")),,,18)
 D SETLN("Date/Time      : "_$G(DATA(REJ,"CLOSED DATE/TIME")),,,18)
 I $G(DATA(REJ,"CLOSE COMMENTS"))'="" D SET("CLOSE COMMENTS",63)
 I $G(DATA(REJ,"COD1"))'="" D SETLN("Reason for Svc : "_$$OVRX^PSOREJU1(1,$G(DATA(REJ,"COD1"))),,,18)
 I $G(DATA(REJ,"COD2"))'="" D SETLN("Profes. Svc    : "_$$OVRX^PSOREJU1(2,$G(DATA(REJ,"COD2"))),,,18)
 I $G(DATA(REJ,"COD3"))'="" D SETLN("Result of Svc  : "_$$OVRX^PSOREJU1(3,$G(DATA(REJ,"COD3"))),,,18)
 I $G(DATA(REJ,"CLA CODE"))'="" D
 . N CLAPNTR S CLAPNTR=$$GET1^DIQ(52.25,REJ_","_RX_",",24,"I")
 . S X=DATA(REJ,"CLA CODE")_" - "_$$GET1^DIQ(9002313.25,CLAPNTR,".02")
 . D SETLN("Clarific. Code : "_X,,,18)
 I $G(DATA(REJ,"PRIOR AUTH TYPE"))'="" D
 . S X=$$GET1^DIQ(52.25,REJ_","_RX,25,"I")_" - "_(DATA(REJ,"PRIOR AUTH TYPE"))
 . D SETLN("Prior Auth.Type: "_X,,,18),SETLN("Prior Auth. #  : "_DATA(REJ,"PRIOR AUTH NUMBER"),,,18)
 D SETLN("Reason         : "_$G(DATA(REJ,"CLOSE REASON")),,1,18)
 Q
 ;
 ;
SET(FIELD,L,UND) ; Sets the lines for fields that require text wrapping
 N TXT,T
 S TXT=DATA(REJ,FIELD) I $L(TXT)'>L D SETLN($$LABEL(FIELD)_TXT,,$S($G(UND):1,1:0),80-L) Q
 F I=1:1 Q:TXT=""  D
 . I I=1 D SETLN($$LABEL(FIELD)_$E(TXT,1,L),,,80-L) S TXT=$E(TXT,L+1,999) Q
 . S T="",$E(T,81-L)=$E(TXT,1,L) D SETLN(T,,$S($E(TXT,L+1,999)=""&$G(UND):1,1:0),80-L) S TXT=$E(TXT,L+1,999)
 Q
 ;
LABEL(FIELD) ; Sets the label for the field
 I FIELD="REASON" Q "Reason Code    : "
 I FIELD="PAYER MESSAGE" Q "Payer Addl Msg : "
 I FIELD="DUR TEXT" Q $S(+$$ISDUR^PSOREJP5(RX,REJ):"+DUR Text      : ",1:"DUR Text       : ")
 I FIELD="CLOSE COMMENTS" Q "Comments       : "
 Q ""
 ;
VIEW ; - Rx View hidden action
 N VALMCNT,TITLE
 I $G(PSOBACK) D  Q
 . S VALMSG="Not available through Backdoor!",VALMBCK="R"
 S TITLE=VALM("TITLE")
 ;
 ; - DO structure used to avoid losing variables RX,FILL,REJ,LINE,TITLE
 DO
 . N PSOVDA,DA,PS
 . S (PSOVDA,DA)=RX,PS="REJECT"
 . N RX,REJ,FILL,LINE,TITLE D DP^PSORXVW
 ;
 S VALMBCK="R",VALM("TITLE")=TITLE
 Q
 ;
EDT ; - Rx Edit hidden action
 N VALMCNT,TITLE
 I $G(PSOBACK) D  Q
 . S VALMSG="Not available through Backdoor!",VALMBCK="R"
 S TITLE=VALM("TITLE")
 ;
 ; - DO structure used to avoid losing variables RX,FILL,REJ,LINE,TITLE
 DO
 . N PSOSITE,ORN,PSOPAR,PSOLIST
 . S PSOSITE=$$RXSITE^PSOBPSUT(RX,FILL),ORN=RX
 . S PSOPAR=$G(^PS(59,PSOSITE,1)),PSOLIST(1)=ORN_","
 . N RX,REJ,FILL,LINE,TITLE D EPH^PSORXEDT
 ;
 K VALMBCK I $$CLOSED(RX,REJ),$D(PSOSTFLT),PSOSTFLT="U" S CHANGE=1 Q
 S VALMBCK="R",VALM("TITLE")=TITLE
 Q
 ;
OVR ; - Override a REJECT action
 N PSOET
 I $$CLOSED(RX,REJ,1) Q
 ;cnf, PSO*7*358
 S PSOET=$$PSOET^PSOREJP3(RX,FILL)
 I PSOET S VALMSG="OVR not allowed for TRICARE Non-Billable claim.",VALMBCK="R" Q
 N COD1,COD2,COD3
 D FULL^VALM1 W !
 S COD1=$$OVRCOD^PSOREJU1(1,$$GET1^DIQ(52.25,REJ_","_RX,14)) I COD1="^" S VALMBCK="R" Q
 S COD2=$$OVRCOD^PSOREJU1(2) I COD2="^" S VALMBCK="R" Q
 S COD3=$$OVRCOD^PSOREJU1(3) I COD3="^" S VALMBCK="R" Q
 D OVRDSP^PSOREJU1(COD1_"^"_COD2_"^"_COD3)
 D SEND^PSOREJP3(COD1,COD2,COD3)
 Q
 ;
RES ; - Re-submit a claim action
 N PSOET
 I $$CLOSED(RX,REJ,1) Q
 ;cnf, PSO*7*358
 S PSOET=$$PSOET^PSOREJP3(RX,FILL)
 I PSOET S VALMSG="RES not allowed for TRICARE Non-Billable claim.",VALMBCK="R" Q
 D FULL^VALM1 W !
 D SEND^PSOREJP3()
 Q
 ;
CLA ; - Submit Clarification Code
 N CLA,PSOET
 I $$CLOSED(RX,REJ,1) Q
 ;cnf, PSO*7*358
 S PSOET=$$PSOET^PSOREJP3(RX,FILL)
 I PSOET S VALMSG="CLA not allowed for TRICARE Non-Billable claim.",VALMBCK="R" Q
 D FULL^VALM1 W !
 S CLA=$$CLA^PSOREJU1() I CLA="^" S VALMBCK="R" Q
 W ! D SEND^PSOREJP3(,,,CLA)
 Q
 ;
PA ; - Submit Prior Authorization
 N PA,PSOET
 I $$CLOSED(RX,REJ,1) Q
 ;cnf, PSO*7*358
 S PSOET=$$PSOET^PSOREJP3(RX,FILL)
 I PSOET S VALMSG="PA not allowed for TRICARE Non-Billable claim.",VALMBCK="R" Q
 D FULL^VALM1 W !
 S PA=$$PA^PSOREJU2() I PA="^" S VALMBCK="R" Q
 W ! D SEND^PSOREJP3(,,,,PA)
 Q
 ;
MP ; - Patient Medication Profile
 I $G(PSOBACK) D  Q
 . S VALMSG="Not available through Backdoor!",VALMBCK="R"
 N SITE,PATIENT
 D FULL^VALM1 W !
 S SITE=+$$RXSITE^PSOBPSUT(RX,FILL) S:$G(PSOSITE) SITE=PSOSITE
 S PATIENT=+$$GET1^DIQ(52,RX,2,"I")
 D LST^PSOPMP0(SITE,PATIENT) S VALMBCK="R"
 Q
 ;
EXIT ;
 K ^TMP("PSOREJP1",$J)
 Q
 ;
SETLN(TEXT,REV,UND,HIG) ; Sets a line to be displayed in the Body section
 N X
 S:$G(TEXT)="" $E(TEXT,80)=""
 S:$L(TEXT)>80 TEXT=$E(TEXT,1,80)
 S LINE=LINE+1,^TMP("PSOREJP1",$J,LINE,0)=$G(TEXT)
 ;
 I LINE>$G(LASTLN) D SAVE^VALM10(LINE) S LASTLN=LINE
 ;
 I $G(REV) D  Q
 . D CNTRL^VALM10(LINE,1,$L(TEXT),IORVON,IOINORM)
 . I $G(UND) D CNTRL^VALM10(LINE,$L(TEXT)+1,80,IOUON,IOINORM)
 I $G(UND) D CNTRL^VALM10(LINE,1,80,IOUON,IOINORM)
 I $G(HIG) D
 . D CNTRL^VALM10(LINE,HIG,80,IOINHI_$S($G(UND):IOUON,1:""),IOINORM)
 Q
HELP ;
 Q
 ;
CLOSED(RX,REJ,MSG) ; Returns whether the REJECT is RESOLVED or NOT
 I $$GET1^DIQ(52.25,REJ_","_RX,10,"I") D:$G(MSG)  Q 1
 . S VALMSG="This Reject is marked resolved!",VALMBCK="R" W $C(7)
 Q 0
 ;
REOPN(RX,REJ) ; Returns whether the REJECT was RE-OPENED or NOT
 Q $S($$GET1^DIQ(52.25,REJ_","_RX,23)="":0,1:1)
 ;
EXP(CODE) ; - Returns the explanation field (.02) for a reject code
 ;  Input:  (r) CODE - .01 field (Code) value from file 9002313.93
 ; Output: .02 field (Explanation) value from file 9002313.93
 N DIC,X,Y
 S DIC=9002313.93,DIC(0)="Z",X=CODE D ^DIC
 Q $P($G(Y(0)),"^",2)
 ;
OUT(RX) ; - Supported call by outside PROTOCOLs to act on specific REJECTs
 N I,RFL,DATA,REJ,PSOBACK,VALMCNT,RXN
 I '$D(^XUSEC("PSORPH",DUZ)) D  Q
 . S VALMSG="PSORPH key required to use the REJ action.",VALMBCK="R"
 I $G(PS)="REJECT" D
 . S VALMSG="REJ action is not available at this point.",VALMBCK="R"
 S PSOBACK=1
 S (RFL,I)=0 F I=1:1 Q:'$D(^PSRX(RX,1,I))  S RFL=I
 S X=$$FIND^PSOREJUT(RX,RFL,.DATA) S REJ=$O(DATA(""))
 I '$G(REJ) S VALMSG="Invalid selection!",VALMBCK="R" Q
 D EN(RX,REJ) S VALMBCK="R"
 Q
 ;

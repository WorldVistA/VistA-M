RCDPESPC ;AITC/MBS - ePayment Lockbox Site Parameter Reports ; 4/23/19 8:52am
 ;;4.5;Accounts Receivable;**349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*349 - New subroutine to display parameter settings by category
SPRPT ; EP from RCDPESP1
 ; Site parameter report entry point updated to select categories
 ; Input: RCTYPE - Type of report (Medical/Rx/TRICARE/All)
 ;        RCCATS - List of categories selected for report
 ; RCLSTMGR - 1 if user selected to display report in List Manager
 ; RCNTR - counter
 ; RCFLD - DD field number
 ; RCHDR - header information
 ; RCPARM - parameters
 ; RCSTOP - exit flag
 N CATS,J,LN,NUMCATS,RCACTV,RCCARCD,RCCIEN,RCCODE,RCDATA,RCDESC,RCFLD,RCGLB,RCHDR,RCI,RCITEM,RCNTR,RCPARM,RCSTAT,RCSTOP,RCSTRING,V,X,XX,Y
 ;
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clear out old data
 ;
 S NUMCATS=$L(RCCATS,U)
 S RCCATS=$$SRTCATS(RCCATS)
 ;
 ; RCGLB - ^TMP global storage locations
 ; ^TMP($J,"RC342") - AR SITE PARAMETER file (#342)
 ; ^TMP($J,"RC344.6") - RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; ^TMP($J,"RC344.61") - RCDPE PARAMETER file (#344.61)
 F J=342,344.6,344.61 S RCGLB(J)=$NA(^TMP($J,"RC"_J)) K @RCGLB(J)
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"10S")
 S RCHDR("PGNMBR")=0  ; page number
 ;
 ; AR SITE PARAMETER file (#342)
 D GETS^DIQ(342,"1,",".01;.14;.15;7.02;7.03;7.04;7.05;7.06;7.07;7.08;7.09","E",RCGLB(342)) ; PRCA*4.5*345
 ; RCDPE PARAMETER file (#344.61),  *future build*, add Tricare auto-decrease fields
 S Y=".02;.03;.04;.05;.06;.07;.1;.11;.12;.13;1.01;1.02;1.03;1.04"  ; PRCA*4.5*345
 S Y=Y_";1.05;1.06;1.07;1.08;1.09;1.1" ; PRCA*4.5*349 - Add TRICARE
 D GETS^DIQ(344.61,"1,",Y,"E",RCGLB(344.61)) ; PRCA*4.5*321/PRCA*4.5*326/PRCA*4.5*332
 ; add site to header data
 S RCHDR("SITE")="Site: "_@RCGLB(342)@(342,"1,",.01,"E")
 ;
 ; get auto-post and auto-decrease settings, save zero node
 S X=$G(^RCY(344.61,1,0))
 S XX=$G(^RCY(344.61,1,1))                      ; PRCA*4.5*349 - Added line
 S RCPARM("AUTO-POST")=$P(X,U,2)
 S RCPARM("AUTO-DECREASE")=$P(X,U,3)
 S RCPARM(344.61,0)=X
 S RCPARM(344.61,1)=XX                          ; PRCA*4.5*349 - Added line
 S RCPARM("RX AUTO-POST")=$P(XX,U,1)
 S RCPARM("RX AUTO-DECREASE")=$P(XX,U,2)        ; PRCA*4.5*349 - Added line
 S RCPARM("TRI AUTO-POST")=$P(XX,U,5)           ; PRCA*4.5*349 - Added line
 S RCPARM("TRI AUTO-DECREASE")=$P(XX,U,6)       ; PRCA*4.5*349 - Added line
 ;
 ; Display categories in order selected
 F I=1:1:NUMCATS D
 . S LN="RPT"_$P(RCCATS,U,I) D @LN
 ;
 D AD2RPT^RCDPESP1(" "),AD2RPT^RCDPESP1($$ENDORPRT^RCDPEARL)
 ;
 I $G(RCLSTMGR) Q  ; PRCA*4.5*349 - If displaying as ListMan report, return here and let ListMan handle it
 ;
 S RCSTOP=0 U IO D SPHDR^RCDPESP1(.RCHDR)
 S J=0 F  S J=$O(^TMP($J,"RC SP REPORT",J)) Q:'J!RCSTOP  S Y=^TMP($J,"RC SP REPORT",J,0) D
 . I $E(Y,1)=$C(12),J>1 D ASK^RCDPEARL(.RCSTOP) I 'RCSTOP D SPHDR^RCDPESP1(.RCHDR) S Y=$E(Y,2,$L(Y))
 . W !,Y Q:'$O(^TMP($J,"RC SP REPORT",J))  ; quit if last line
 . I '$G(ZTSK),$E(IOST,1,2)="C-",$Y+3>IOSL D ASK^RCDPEARL(.RCSTOP) I 'RCSTOP D SPHDR^RCDPESP1(.RCHDR) Q
 . Q:RCSTOP  Q:$Y+2<IOSL
 . D SPHDR^RCDPESP1(.RCHDR)
 ;
 I '$G(ZTSK),$E(IOST,1,2)="C-",'RCSTOP D ASK^RCDPEARL(.RCSTOP)
 ;
 ; close device
 U IO(0) D ^%ZISC
 K @RCGLB(344.6)  ; delete old data
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clean up
 ;
 Q
 ;
RPTGN ; Display General EDI Lockbox Site Parameters
 D AD2RPT^RCDPESP1($C(12)_"### General EDI Lockbox Site Parameters ###")
 ; 7.02:7.04 - EFT/ERA days unmatched
 F RCFLD=7.02,7.03,7.04 D
 . S Y=$$GET1^DID(342,RCFLD,,"LABEL")_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 . D AD2RPT^RCDPESP1(Y)
 ;Workload notification day parameter
 S Y=$$GET1^DID(344.61,.1,,"LABEL")_": "_@RCGLB(344.61)@(344.61,"1,",.1,"E") ; PRCA*4.5*321
 D AD2RPT^RCDPESP1(Y)
 Q
 ;
RPTFP ; Display First Party Parameters
 D AD2RPT^RCDPESP1($C(12)_"### First Party Parameters ###")
 ; .14:.15 - First Party
 F RCFLD=.14,.15 D
 . S Y=$$GET1^DID(342,RCFLD,,"TITLE")_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 . D AD2RPT^RCDPESP1(Y)
 Q
 ;
RPTAA ; Display Auto-Audit Parameters
 D AD2RPT^RCDPESP1($C(12)_"### Auto-Audit Site Parameters ###")
 ; 7.05:7.09 - Auto Audit
 F RCFLD=7.05,7.06,7.07,7.08,7.09 D  ; EFT and ERA days unmatched  - PRCA*4.5*321
 . I RCTYPE="P",(RCFLD=7.05)!(RCFLD=7.07)!(RCFLD=7.09) Q  ; PRCA*4.5*349 Exclude TRICARE
 . I RCTYPE="M",(RCFLD=7.06)!(RCFLD=7.08)!(RCFLD=7.09) Q  ; PRCA*4.5*349 Exclude TRICARE
 . I RCTYPE="T",RCFLD>7.04,RCFLD<7.09 Q  ; PRCA*4.5*349 Line Added TRICARE
 . S Y=$$GET1^DID(342,RCFLD,,"TITLE")_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 . I RCFLD=7.05 D AD2RPT^RCDPESP1(" ")
 . I (RCFLD=7.06)&(RCTYPE="P") D AD2RPT^RCDPESP1(" ")
 . I (RCFLD=7.09),(RCTYPE="T") D AD2RPT^RCDPESP1(" ")
 . D AD2RPT^RCDPESP1(Y)
 Q
 ;
RPTAP ; Display Auto-Post Parameters
 D AD2RPT^RCDPESP1($C(12)_"### Auto-Post Parameters ###")
 I (RCTYPE="M")!(RCTYPE="A") D
 . D AD2RPT^RCDPESP1("*** Medical Auto-Post Parameters ***")
 . D MEDAUTOP^RCDPESP1(.RCPARM)  ; Display Medical Claim parameters
 ;
 I (RCTYPE="P")!(RCTYPE="A") D
 . D AD2RPT^RCDPESP1("*** Pharmacy Auto-Post Parameters ***")
 . D RXAUTOP^RCDPESP1(.RCPARM) ; Display Rx parameters 
 ;
 I (RCTYPE="T")!(RCTYPE="A") D
 . D AD2RPT^RCDPESP1("*** TRICARE Auto-Post Parameters ***")
 . D TRIAUTOP^RCDPESP1(.RCPARM)  ; Display TRICARE parameters
 Q
 ;
RPTAD ; Auto-Decrease Parameteers
 D AD2RPT^RCDPESP1($C(12)_"### Auto-Decrease Parameters ###")
 I (RCTYPE="M")!(RCTYPE="A") D
 . D AD2RPT^RCDPESP1("*** Medical Auto-Decrease Parameters ***")
 . I '$$AUTOPON(0) D  Q
 . . D AD2RPT^RCDPESP1(" ")
 . . D AD2RPT^RCDPESP1("NOTICE: Medical Auto-Decrease unavailable because Auto-Posting of Medical Claims is currently disabled")
 . . D AD2RPT^RCDPESP1(" ")
 . D MEDAUTOD^RCDPESP1(.RCPARM,RCTYPE)  ; Display Medical Claim parameters
 ;
 I (RCTYPE="P")!(RCTYPE="A") D
 . D AD2RPT^RCDPESP1("*** Pharmacy Auto-Decrease Parameters ***")
 . I '$$AUTOPON(1) D  Q
 . . D AD2RPT^RCDPESP1(" ")
 . . D AD2RPT^RCDPESP1("NOTICE: Pharmacy Auto-Decrease unavailable because Auto-Posting of Pharmacy Claims is currently disabled")
 . . D AD2RPT^RCDPESP1(" ")
 . D RXAUTOD^RCDPESP1(.RCPARM,RCTYPE) ; Display Rx parameters 
 ;
 I (RCTYPE="T")!(RCTYPE="A") D
 . D AD2RPT^RCDPESP1("*** TRICARE Auto-Decrease Parameters ***")
 . I '$$AUTOPON(2) D  Q
 . . D AD2RPT^RCDPESP1(" ")
 . . D AD2RPT^RCDPESP1("NOTICE: TRICARE Auto-Decrease unavailable because Auto-Posting of TRICARE Claims is currently disabled")
 . . D AD2RPT^RCDPESP1(" ")
 . D TRIAUTOD^RCDPESP1(.RCPARM,RCTYPE)  ; Display TRICARE parameters ; RCDPE PARAMETER file (#344.61)
 Q
 ;
RPTLK ; Display EFT Lock-Out Parameters
 D AD2RPT^RCDPESP1($C(12)_"### EFT Lock-Out Parameters ###")
 ;  ^DD(344.61,.06,0) > "MEDICAL EFT POST PREVENT DAYS"
 ;  ^DD(344.61,.07,0) > "PHARMACY EFT POST PREVENT DAYS"
 ;  ^DD(344.61,.13,0) > "TRICARE EFT POST PREVENT DAYS"
 F RCFLD=.06,.07,.13 D 
 . Q:(RCFLD=.06)&'((RCTYPE="M")!(RCTYPE="A"))  ; Don't display if not showing Medical parameters
 . Q:(RCFLD=.07)&'((RCTYPE="P")!(RCTYPE="A"))   ; Don't display if not showing Rx parameters
 . Q:(RCFLD=.13)&'((RCTYPE="T")!(RCTYPE="A"))  ; PRCA*4.5*349 - Don't display if not showing TRICARE params
 . S Y=$$GET1^DID(344.61,RCFLD,,"TITLE")_" "_@RCGLB(344.61)@(344.61,"1,",RCFLD,"E")
 . D AD2RPT^RCDPESP1(Y)
 Q
 ;
SRTCATS(CATS) ; If user selected both Auto-Post and Auto-Decrease, ensure AD displays after AP
 N ADL,APL,I
 F I=1:1:NUMCATS D
 . I $P(CATS,U,I)="AP" S APL=I Q
 . I $P(CATS,U,I)="AD" S ADL=I
 I $G(APL),$G(ADL),APL>ADL D
 . S APL=$F(CATS,"AP")
 . S CATS=$E(CATS,1,APL-4)_$E(CATS,APL,$L(CATS))
 . S $P(CATS,U,ADL)="AP;AD"
 . S CATS=$TR(CATS,";",U)
 Q CATS
 ;
 ; PRCA*4.5*349 - Added new subroutine to present parameters by category
ENCATS ; EP from RCDPESP
 ; Filter questions by category
 ; Input: CATS - List of categories to display
 ;
 ; Call below answers:
 ; NUMBER OF DAYS EFT UNMATCHED
 ; NUMBER OF DAYS ERA UNMATCHED
 ; # OF DAYS ENTRY CAN REMAIN IN SUSP
 N I,LN,NUMCATS,RCQUIT
 S RCQUIT=0,(APL,ADL)=0,NUMCATS=$L(CATS,U)
 ; If user selected both Auto-Post and Auto-Decrease, ensure AD will display after AP
 S CATS=$$SRTCATS(CATS)
 ; Display categories in order selected
 F I=1:1:NUMCATS D  Q:RCQUIT
 . S LN=$P(CATS,U,I) D @LN
 D EXIT^RCDPESP
 Q
 ;
GN ; Ask General EDI Lockbox Site Questions
 W #,"### General EDI Lockbox Site Parameters ###",!
 S Y=$$GEN  ; General EDI Lockbox Site parameters
 I Y S RCQUIT=1
 Q
 ;
FP ; Ask First Party Questions
 W #,"### First Party Parameters ###",!
 S RCQUIT=$$FIRSTP  ; First party parameters
 Q
 ;
 ; PRCA*4.5*304 - Enable/disable auto-auditing of paper bills
AA ; Ask Auto-Audit Questions
 W #,"### Auto-Audit Site Parameters ###",!
 S RCQUIT=$$AUDIT^RCDPESP5  ; Auto-Audit site parameters
 ;
 Q
 ;
 ;
AP ; Ask Auto-Post Questions
 W #,"### Auto-Post Parameters ###",!
 W !,"*** Medical Auto-Post Parameters ***",!
 S RCQUIT=$$MAUTOP^RCDPESP
 I '$G(RCQUIT) D
 . W !!,"*** Pharmacy Auto-Post Parameters ***",!
 . S RCQUIT=$$RXAUTOP^RCDPESP
 I '$G(RCQUIT) D
 . W !!,"*** TRICARE Auto-Post Parameters ***",!
 . S RCQUIT=$$TAUTOP^RCDPESP
 W !
 Q
 ;
 ;
AD ; Ask Auto-Decrease Questions
 W #,"### Auto-Decrease Parameters ###",!
 W !,"*** Medical Auto-Decrease Parameters ***"
 S RCQUIT=$$MAUTOD
 I '$G(RCQUIT) D
 . W !!,"*** Pharmacy Auto-Decrease Parameters ***"
 . S RCQUIT=$$RXAUTOD
 I '$G(RCQUIT) D
 . W !!,"*** TRICARE Auto-Decrease Parameters ***"
 . S RCQUIT=$$TAUTOD
 W !
 Q
 ;
LK ; Ask EFT Lock-Out Questions
 W #,"### EFT Lock-Out Parameters ###",!
 S RCQUIT=$$EFTLK^RCDPESP  ; Set EFT lock-out paramters
 Q
 ;
 ; PRCA*4.5*349 - Added to provide one place to get list of categories
LSTCATS(CATS,SHORT) ; Return list of categories
 S SHORT=+$G(SHORT)
 S CATS("GN")="General EDI Lockbox Site"_$S('SHORT:" Parameters",1:"")
 S CATS("AA")="Auto-Audit Site"_$S('SHORT:" Parameters",1:"")
 S CATS("FP")="First Party"_$S('SHORT:" Parameters",1:"")
 S CATS("AP")="Auto-Post"_$S('SHORT:" Parameters",1:"")
 S CATS("AD")="Auto-Decrease"_$S('SHORT:" Parameters",1:"")
 S CATS("LK")="EFT Lock-Out"_$S('SHORT:" Parameters",1:"")
 Q
 ; 
 ; PRCA*4.5*349 - New function to prompt for categories
CATS() ; Get categories to display
 N CATS,CTLST,DIR
 S CTLST=""
 D LSTCATS(.CATS)
 S DIR(0)="SO^"_$$BLDCATS("")_"AL:All",DIR("B")="All"
 D ^DIR
 I Y="AL" S CTLST=Y G QCATS
 F  Q:$D(DIRUT)  S CTLST=$S($L(CTLST):CTLST_U,1:"")_Y D
 . K DIR
 . S DIR(0)="SO^"_$$BLDCATS(CTLST)
 . D ^DIR
 S:Y=U CTLST=""
QCATS Q CTLST
 ;
 ; PRCA*4.5*349 - New function to support CATS()
BLDCATS(CUR) ; Build set of code string for categories question
 N I,OUT
 S OUT=""
 S I="" F  S I=$O(CATS(I)) Q:I=""  D
 . S:CUR'[(I) OUT=OUT_I_":"_CATS(I)_";"
 Q OUT
 ;
 ; PRCA*4.5*349 - New function to display "general" questions (including bulletin day)
 ;                as separate from First Party questions
GEN() ; General Questions
 N RSLT S RSLT=""
 I '$D(^RC(342,1,0)) D BEG^RCMSITE
 S:'$D(^RC(342,1,0)) RSLT="^no site defined"  ; can't continue
 ;
 Q:RSLT]"" RSLT
 N DA,DR,DIE,Y
 S RSLT=0
 S DA=1,DR="7.02:7.04",DIE="^RC(342,"
 D ^DIE
 S RSLT=$S($D(Y):1,1:0)
 I 'RSLT Q $$BULLDAY^RCDPESP
 Q RSLT
 ;
 ; PRCA*4.5*349 - New function to ask First Party questions as their own category
FIRSTP() ; First Party questions
 N RSLT S RSLT=""
 I '$D(^RC(342,1,0)) D BEG^RCMSITE
 S:'$D(^RC(342,1,0)) RSLT="^no site defined"  ; can't continue
 ;
 Q:RSLT]"" RSLT
 N DA,DIE,DR,Y
 S DA=1,DR="[RCDPE FIRST PARTY]",DIE="^RC(342," D ^DIE
 S RSLT=$S($D(Y):"^user aborted",1:1)  ; if Y remains from ^DIE call
 Q 'RSLT
 ;
 ; PRCA*4.5*349 - New function to ask only Medical Auto-Decrease questions if Auto-Post enabled
MAUTOD() ; Medical Claims Auto-Decrease Questions
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N ONOFF,RCQUIT
 S RCQUIT=0
 S ONOFF=$$GET1^DIQ(344.61,"1,",.02,"I")
 ; Do not display Auto-Decrease questions when Auto-Post Disabled
 I ONOFF=0 D  Q 0
 . W !,"NOTICE: Medical Auto-Decrease unavailable because Auto-Posting of Medical Claims is currently disabled"
 ; Enable/disable Auto-Decrease of medical claims with payments
 S RCQUIT=$$PAID^RCDPESP7(0)  ; PRCA*4.5*345 - Added 0 parameter
 Q:RCQUIT=1 1
 Q:RCQUIT=2 0  ; Auto-Decrease of Med Claims w/Payments is OFF
 ;
 ; Enable/disable Auto-Decrease of Med Claims with/No Payments
 S RCQUIT=$$NOPAY^RCDPESP7(0)  ; PRCA*4.5*345 - Added 0 parameter
 I RCQUIT=1 Q 1
 ; Set/Reset payer exclusions for medical claim decrease
 D EXCLLIST^RCDPESP(2)  ; Display exclusion list
 S RCQUIT=$$SETEXCL^RCDPESP(2)
 Q:RCQUIT 1
 D EXCLLIST^RCDPESP(2)  ; Display exclusion list
 ;
 Q 0
 ;
 ; PRCA*4.5*349 - New function to ask only Pharmacy Auto-Decrease questions if Auto-Post enabled
RXAUTOD() ; Enable/disable Auto-Decrease of pharmacy claims with payments
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N ONOFF,RETURN
 S RETURN=0
 S ONOFF=$$GET1^DIQ(344.61,"1,",1.01,"I")
 ; Do not display Auto-Decrease questions when Auto-Post Disabled
 I ONOFF=0 D  Q 0
 . W !,"NOTICE: Pharmacy Auto-Decrease unavailable because Auto-Posting of Pharmacy Claims is currently disabled"
 ; Enable/disable Auto-Decrease of Rx claims with payments
 S RETURN=$$PAID^RCDPESP7(1)
 Q:RETURN=1 1
 Q:RETURN=2 0
 ;
 ; Set/Reset payer exclusions for pharmacy claim decrease
 D EXCLLIST^RCDPESP(4) ; Display the exclusion list
 Q:$$SETEXCL^RCDPESP(4) 1
 D EXCLLIST^RCDPESP(4) ; Display the exclusion list
 Q 0
 ;
 ; PRCA*4.5*349 - New function to ask only TRICARE Auto-Decrease questions if Auto-Post enabled
TAUTOD() ; Enable/disable Auto-Decrease of TRICARE claims with payments
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N ONOFF,RETURN
 S RETURN=0
 S ONOFF=$$GET1^DIQ(344.61,"1,",1.05,"I")
 ; Do not display Auto-Decrease questions when Auto-Post Disabled
 I ONOFF=0 D  Q 0
 . W !,"NOTICE: TRICARE Auto-Decrease unavailable because Auto-Posting of TRICARE Claims is currently disabled"
 ;
 ; Enable/disable Auto-Decrease of TRICARE claims with payments
 S RETURN=$$PAID^RCDPESP7(2)
 Q:RETURN=1 1
 Q:RETURN=2 0                      ; Auto-Decrease of TRICARE Claims w/Payments is OFF
 ;
 ; Enable/disable Auto-Decrease of TRICARE with/No Payments
 S RETURN=$$NOPAY^RCDPESP7(2)
 I RETURN=1 Q 1
 ;
 ; Set/Reset payer exclusions for TRICARE claim decrease
 D EXCLLIST^RCDPESP(6)                      ; Display the exclusion list
 Q:$$SETEXCL^RCDPESP(6) 1
 D EXCLLIST^RCDPESP(6)                      ; Display the exclusion list
 W !
 Q 0
 ;
 ; PRCA*4.5*349 - Added function
AUTOPON(WHICH) ; Is Auto-Post on for the selected parameters?
 ; Input: WHICH - 0 - Medical, 1 - Rx, 2 - TRICARE (defaults to 0 - Medical)
 ; Returns: 1 if Auto-Posting is turned on for the selected parameter type
 ;          0 if Auto-Posting is turned off for the selected parameter type
 S WHICH=+$G(WHICH)
 Q $$GET1^DIQ(344.61,"1,",$S(WHICH=0:.02,WHICH=1:1.01,1:1.05),"I")
 ;
MPARAMS(RCPARM) ; Display Medical Parameters for Report
 ; Input: RCPARM("AUTO-DECREASE") - 1 if Medical Auto-Posting is turned for claims w/Payments
 ; 0 otherwise
 ; RCPARM("AUTO-POST") - 1 if Medical Auto-Posting is Turned on, 0 otherwise
 ; @RCGLB(344.6) - LIST^DIC array of fields
 ; @RCGLB(344.61) - LIST^DIC array of fields
 ; PRCA*4.5*349 - Added method
 D AD2RPT^RCDPESP1("### Medical Claims Auto-Post/Auto-Decrease Parameters ###")
 D MEDAUTOP^RCDPESP1(.RCPARM)
 D AD2RPT^RCDPESP1(" ")
 D MEDAUTOD^RCDPESP1(.RCPARM,RCTYPE)
 ;
 Q
 ;
RXPARAMS(RCPARM) ; Display Rx Parameters for Report
 ; PRCA*4.5*349 - New method
 ; Input: RCPARM("RX AUTO-DECREASE") - 1 if Rx Auto-Posting is turned for claims w/Payments
 ; 0 otherwise
 ; RCPARM("RX AUTO-POST") - 1 if Rx Auto-Posting is Turned on, 0 otherwise
 ; @RCGLB(344.6) - LIST^DIC array of fields
 ; @RCGLB(344.61) - LIST^DIC array of fields
 D AD2RPT^RCDPESP1("### Pharmacy Auto-Post/Auto-Decrease Parameters ###")
 D RXAUTOP^RCDPESP1(.RCPARM)
 D AD2RPT^RCDPESP1(" ")
 D RXAUTOD^RCDPESP1(.RCPARM,RCTYPE)
 Q
 ;
TPARAMS(RCPARM) ; Display TRICARE Parameters for Report
 ; Input: RCPARM("TRI AUTO-DECREASE") - 1 if TRICARE Auto-Posting is turned for claims w/Payments
 ; 0 otherwise
 ; RCPARM("TRI AUTO-POST") - 1 if TRICARE Auto-Posting is Turned on, 0 otherwise
 ; @RCGLB(344.6) - LIST^DIC array of fields
 ; @RCGLB(344.61) - LIST^DIC array of fields
 ; PRCA*4.5*349 - Added method
 D AD2RPT^RCDPESP1("### TRICARE Auto-Post/Auto-Decrease Parameters ###")
 D TRIAUTOP^RCDPESP1(.RCPARM)
 D AD2RPT^RCDPESP1(" ")
 D TRIAUTOD^RCDPESP1(.RCPARM,RCTYPE)
 ;
LMHDR(HDR,RCTYPE,RCCATS) ; EP from RCDPESP1
 ; HDR passed by ref.
 ; PRCA*4.5*349 - New subroutine to build ListMan Header
 ; Inputs: RCTYPE - M - Medical, P - Pharmacy, T - TRICARE, A - ALL
 ;         RCCATS - GN - General EDI Lockbox Site
 ;                  AA - Auto-Audit Site
 ;                  FP - First Party
 ;                  AP - Auto-Post"
 ;                  AD - Auto-Decrease
 ;                  LK - EFT Lock-Out
 ; Outputs: HDR - Passed by reference
 ;
 N CNT,CUR,CTLST,P,X,Y
 S HDR("TITLE")="EDI LOCKBOX PARAMETERS REPORT "
 ;
 S X="Medical/Pharmacy/TRICARE: "
 S X=X_$S(RCTYPE="A":"ALL",RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",1:"")
 S HDR(1)="Site: "_$$GET1^DIQ(342,"1,",.01,"E")
 S HDR(1)=HDR(1)_$J(X,IOM-($L(HDR(1))+1))
 ; Add categories
 S Y="Categories: "
 S CNT=$L(RCCATS,U),CUR=""
 D LSTCATS^RCDPESPC(.CTLST,1)
 S CTLST("AL")="All"
 F I=1:1:CNT D
 . S X=$G(CTLST($P(RCCATS,U,I)))
 . I ($L(Y)+$L(X))>IOM D
 . . W !,Y
 . . S Y="               "
 . S Y=Y_X
 . I I<CNT S Y=Y_", "
 S HDR(2)=Y
 Q

RCDPRPLM ; WISC/RFJ-receipt profile List Manager main routine ;31 Oct 2018 09:14:14
 ;;4.5;Accounts Receivable;**114,148,149,173,196,220,217,321,326,332,375,367**;Mar 20, 1995;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; option: Receipt Processing [RCDP RECEIPT PROCESSING]
 N RCDPFXIT
 ;
RECTPROF ;EP from RECEIPT^RCDPLPL1
 ; Entry point called by link payment to prevent NEWing fast exit var RCDPFXIT
 N RCRECTDA
 ;
 F  D  Q:'RCRECTDA
 . W !! S RCRECTDA=$$SELRECT^RCDPUREC(1)  ; Allow adding new receipt
 . I RCRECTDA<1 S RCRECTDA=0 Q
 . D EN^VALM("RCDP RECEIPT PROFILE")
 . I $G(RCDPFXIT) S RCRECTDA=0  ; Fast exit
 Q
 ;
INIT ;EP from ListMan template RCDP RECEIPT PROFILE MENU
 ; EP from CUSTOMIZ^RCDPRPL2
 ; Initialization for list manager
 ; Input:   RCRECTDA    - IEN for the selected receipt (#344)
 N DATE,EFTFUND,FMSDOC,GECSDA1,GECSDATA,RCCANCEL,RCEFT,RCDPDATA,RCDPFCAN,RCLINE,RCTOTAL,RCTRDA
 N RCZ,RCZ0,RCZ1,RCZ2,X,XX,Z,Z0
 K ^TMP("RCDPRPLM",$J),^TMP("VALM VIDEO",$J)
 I $G(RCDPFXIT) S VALMQUIT=1 Q  ; Fast exit
 D DIQ344(RCRECTDA,".02:200")
 S RCLINE=0  ; list manager line #
 K ^TMP($J,"RCEFT")
 S EFTFUND=$S(DT<$$ADDPTEDT^PRCAACC():"5287.4/8NZZ ",1:"528704/8NZZ ")
 S RCEFT=+$O(^RCY(344.3,"ARDEP",+$P($G(^RCY(344,RCRECTDA,0)),U,6),0))
 I RCEFT D
 . S Z=0 F  S Z=$O(^RCY(344.31,"B",RCEFT,Z)) Q:'Z  D
 ..  S Z0=$G(^RCY(344.31,+Z,0))
 ..  I $P(Z0,U,14) S ^TMP($J,"RCEFT",$P(Z0,U,14))=Z_U_$E($P(Z0,U,2),1,12)
 ;
 S RCTRDA=0
 F  S RCTRDA=$O(^RCY(344,RCRECTDA,1,RCTRDA)) Q:'RCTRDA  D
 . D DIQ34401(RCRECTDA,RCTRDA)
 . S RCLINE=RCLINE+1 D SET("",RCLINE,1,80,.01)
 . ; Check for payment cancelled
 . S RCCANCEL=0
 . I $P($G(^RCY(344,RCRECTDA,1,RCTRDA,0)),"^",4)=0,$P($G(^(1)),"^")'="" D
 ..  S RCCANCEL=1,RCDPFCAN=1 D SET("**",RCLINE,5,6)
 . ; Account
 . I $G(RCDPDATA(344.01,RCTRDA,.03,"E"))="" D
 ..  S:RCEFT XX=EFTFUND_$P($G(^TMP($J,"RCEFT",RCTRDA)),U,2)
 ..  S:'RCEFT XX=$$GETUNAPP^RCXFMSCR(RCRECTDA,RCTRDA,0)
 ..  S RCDPDATA(344.01,RCTRDA,.03,"E")="[ "_XX_" ]"
 . D SET("",RCLINE,7,33,.03)
 . ; (#.06) DATE OF PAYMENT [6D]
 . S X=RCDPDATA(344.01,RCTRDA,.06,"I") D:X
 ..  S XX=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) D SET(XX,RCLINE,35,42)
 . ;( #.12) ENTERED BY [12P:200]
 . S X=RCDPDATA(344.01,RCTRDA,.12,"E") D:$L(X)
 ..  ; if POSTMASTER set to 'ar' else user's initials
 ..  S X=$S(RCDPDATA(344.01,RCTRDA,.12,"I")=.5:"ar",1:$E($P(X,",",2))_$E(X))
 ..  D SET(X,RCLINE,45,46)
 . ;(#.14) EDITED BY [14P:200]
 . S X=RCDPDATA(344.01,RCTRDA,.14,"E") D:$L(X)
 ..  S X=$E($P(X,",",2))_$E(X) D SET(X,RCLINE,54,55)
 . S:RCDPDATA(344.01,RCTRDA,.29,"I")="D" RCDPDATA(344.01,RCTRDA,.04,"E")=-RCDPDATA(344.01,RCTRDA,.04,"E") ; PRCA*4.5*375 - Use negative amounts when debit
 . D SET($J(RCDPDATA(344.01,RCTRDA,.04,"E"),8,2),RCLINE,62,70)  ; (#.04) PAYMENT AMOUNT [4N]
 . D SET($J(RCDPDATA(344.01,RCTRDA,.05,"E"),8,2),RCLINE,72,80)  ; (#.05) AMOUNT PROCESSED [5N]
 . ;
 . ; If not processed, show if amount > bill
 . S X=$$CHECKPAY^RCDPRPL3(RCRECTDA,RCTRDA) D:X
 ..  S XX="  WARNING: Pending Payments ($ "_$J($P(X,"^",3),0,2)_") exceed amount billed ($ "_$J($P(X,"^",2),0,2)_")"
 ..  S RCLINE=RCLINE+1 D SET(XX,RCLINE,1,80)
 . ; Show line 2 for check/credit payment
 . I $$OPTCK^RCDPRPL2("SHOWCHECK",2) D
 ..  ; Receipt type is check
 ..  I RCDPDATA(344,RCRECTDA,.04,"I")=4!(RCDPDATA(344,RCRECTDA,.04,"I")=12) D  Q
 ...   S RCLINE=RCLINE+1 D SET("      Check #",RCLINE,1,80,.07)
 ...   S X=RCDPDATA(344.01,RCTRDA,.1,"I") S:'X X="???????"
 ...   S XX="Date: "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) D SET(XX,RCLINE,32,80)
 ...   D SET("Bank #",RCLINE,47,80,.08)
 ..  ; Receipt type of payment is credit
 ..  I RCDPDATA(344,RCRECTDA,.04,"I")=7 D  Q
 ...   S RCLINE=RCLINE+1 D SET("      Card #",RCLINE,1,80,.11),SET("Confirmation #",RCLINE,35,80,.02)
 ..  ; type of payment is EDI LOCKBOX
 ..  I RCDPDATA(344,RCRECTDA,.04,"I")=14 D  Q
 ...   S RCLINE=RCLINE+1 D SET("      Trace #",RCLINE,1,80,.17)
 . ; line 3 for acct. lookup, batch #, sequence #
 . I $$OPTCK^RCDPRPL2("SHOWACCT",2) D
 ..  N TRNS  ; transaction info
 ..  S TRNS("acctLkup")=RCDPDATA(344.01,RCTRDA,.21,"E")  ; (#.21) ACCOUNT LOOKUP [1F]
 ..  S TRNS("btch#")=RCDPDATA(344.01,RCTRDA,.22,"E")  ; (#.22) BATCH NUMBER [2N]
 ..  S TRNS("sq#")=RCDPDATA(344.01,RCTRDA,.23,"E")  ; (#.23) SEQUENCE NUMBER [3N]
 ..  I TRNS("acctLkup")="",TRNS("btch#")="",TRNS("sq#")="" Q  ; No Account information, skip
 ..  S RCLINE=RCLINE+1
 ..  D SET("      AcctLU",RCLINE,1,80,.21),SET("Batch/Sequence: "_TRNS("btch#")_"/"_TRNS("sq#"),RCLINE,37,80)
 . ; Show if posting error
 . I $$OPTCK^RCDPRPL2("SHOWCOMMENTS",2),RCDPDATA(344.01,RCTRDA,1.01,"E")'="" D
 ..  S X=$S(RCCANCEL:"Cancel Data",1:"Posting Error")
 ..  S RCLINE=RCLINE+1 D SET("      "_X,RCLINE,1,80,1.01)
 . ; Show if comment
 . I $$OPTCK^RCDPRPL2("SHOWCOMMENTS",2),RCDPDATA(344.01,RCTRDA,1.02,"E")'="" D
 ..  S RCLINE=RCLINE+1 D SET("      Comment",RCLINE,1,80,1.02)
 . ; If EDI Lockbox pending adjustments, show it
 . I $P($G(^RCY(344,RCRECTDA,0)),U,18),$G(RCDPDATA(344.01,RCTRDA,.27,"E")) D
 ..  S RCZ=$P(^RCY(344,RCRECTDA,0),U,18),RCZ0=RCDPDATA(344.01,RCTRDA,.27,"E")
 ..  S RCZ1=0 F  S RCZ1=$O(^RCY(344.49,RCZ,1,RCZ0,1,RCZ1)) Q:'RCZ1  S RCZ2=$G(^(RCZ1,0)) D
 ...   I $P(RCZ2,U,5)'="","12"[$P(RCZ2,U,5),'$P(RCZ2,U,8) D
 ....    I $P(RCZ2,U,5)=1 D  Q
 .....     S RCLINE=RCLINE+1 D SET("      Pending decrease adjustment for "_$J($P(RCZ2,U,3),"",2),RCLINE,1,80)
 ....    I $$OPTCK^RCDPRPL2("SHOWCOMMENTS",2),$P(RCZ2,U,5)=2 D  Q
 .....     S RCLINE=RCLINE+1 D SET("      Comment: "_$P(RCZ2,U,9),RCLINE,1,80)
 . ; Calculate totals
 . S RCTOTAL(1)=$G(RCTOTAL(1))+RCDPDATA(344.01,RCTRDA,.04,"E")
 . S RCTOTAL(2)=$G(RCTOTAL(2))+RCDPDATA(344.01,RCTRDA,.05,"E")
 . ; cleanup
 . K RCDPDATA(344.01,RCTRDA)
 ;
 ; Show totals
 K ^TMP($J,"RCEFT")
 S RCLINE=RCLINE+1 D SET("",RCLINE,1,80),SET("--------  --------",RCLINE,62,80)
 S RCLINE=RCLINE+1 D SET("      TOTAL DOLLARS FOR RECEIPT",RCLINE,1,80)
 D SET($J($G(RCTOTAL(1)),8,2),RCLINE,62,70)
 D SET($J($G(RCTOTAL(2)),8,2),RCLINE,72,80)
 ;
 ; Show cancelled
 I $G(RCDPFCAN) S RCLINE=RCLINE+1 D SET("**indicates payment is CANCELLED",RCLINE,5,80)
 ;
 ; Show history
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 ;
 ; Start history on first line of a screen if it does not fit on current screen
 I (RCLINE#12)>8 F X=(RCLINE#12):1:12 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Receipt History",RCLINE,1,80,0,IOUON,IOUOFF)
 S DATE=RCDPDATA(344,RCRECTDA,.03,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 I RCDPDATA(344,RCRECTDA,.02,"I")=.5 S RCDPDATA(344,RCRECTDA,.02,"E")="accounts receivable"
 S XX=$E("   Opened By: "_RCDPDATA(344,RCRECTDA,.02,"E")_$$SP,1,39)_"Date/Time    Opened: "_DATE
 S RCLINE=RCLINE+1 D SET(XX,RCLINE,1,80)
 ; (#.12) DATE/TIME LAST EDIT [12D]
 S DATE=RCDPDATA(344,RCRECTDA,.12,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 S X=RCDPDATA(344,RCRECTDA,.11,"E") I RCDPDATA(344,RCRECTDA,.11,"I")=.5 S X="accounts receivable"
 S XX=$E("Last Edit By: "_X_$$SP,1,39)_"Date/Time Last Edit: "_DATE
 S RCLINE=RCLINE+1 D SET(XX,RCLINE,1,80)
 ; (#.08) DATE/TIME PROCESSED [8D]
 S DATE=RCDPDATA(344,RCRECTDA,.08,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 I RCDPDATA(344,RCRECTDA,.07,"I")=.5 S RCDPDATA(344,RCRECTDA,.07,"E")="accounts receivable"
 S XX=$E("Processed By: "_RCDPDATA(344,RCRECTDA,.07,"E")_$$SP,1,39)_"Date/Time Processed: "_DATE
 S RCLINE=RCLINE+1 D SET(XX,RCLINE,1,80)
 ;
 ; Show FMS code sheets if switch on in file 342.3
 I $$OPTCK^RCDPRPL2("SHOWFMS",2) D
 . S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 . S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 . S RCLINE=RCLINE+1 D SET("FMS Cash Receipt Document:",RCLINE,1,80,0,IOUON,IOUOFF)
 . D SET($P(FMSDOC,"^")_$S($P(FMSDOC,"^",3):"(on deposit)",1:""),RCLINE,28,80)
 . D SET("Status: "_$P(FMSDOC,"^",2),RCLINE,55,80)
 . D DATA^GECSSGET($P(FMSDOC,"^"),1)
 . I '$G(GECSDATA) Q
 . S GECSDA1=0 F  S GECSDA1=$O(GECSDATA(2100.1,GECSDATA,10,GECSDA1)) Q:'GECSDA1  D
 ..  S RCLINE=RCLINE+1 D SET(GECSDATA(2100.1,GECSDATA,10,GECSDA1),RCLINE,1,80)
 ;
 ; Show EEOB detail if switch on
 D SHEOB^RCDPRPL2
 ;
 ; # of lines in list
 S VALMCNT=RCLINE
 D HDR
 Q
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ; Sets a line into the body
 ; of the ListMan template
 ; Input:
 ; STRING - Label for the data being set
 ; LINE - line # being built
 ; COLBEG - Beginning column for the text
 ; COLEND - Ending column for the text
 ; FIELD - Field # for value being set, optional
 ;    NOTE: if FIELD is .17 trace # is retrieved from EFT record
 ; ON, OFF - for text characteristics
 ; RCDPDATA - array for receipt being processed
 ; RCTRDA - IEN in TRANSACTION sub-file (#344.01)
 N XX
 I $G(FIELD) D
 . I FIELD=.17 S XX=$$TRCNUM(RCRECTDA) Q  ; trace # from EFT record, PRCA*4.5*332
 . ; all other fields
 . S XX=$G(RCDPDATA(344.01,RCTRDA,FIELD,"E"))
 S:$G(FIELD) STRING=STRING_$S(STRING="":"",1:": ")_XX
 I STRING="",'$G(FIELD) D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)'=""!($G(OFF)'="") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q
 ;
TRCNUM(ARBPIEN) ; returns trace #, ARBPIEN is IEN in file #344 - PRCA*4.5*332
 N DEPIEN,PTR
 ; If receipt manually created then EFT number is in field .17
 S PTR=+$P($G(^RCY(344,ARBPIEN,0)),U,17)  ;(#.17) EFT RECORD [17P:344.31]
 ; Otherwise auto-posting created the receipt, get the EFT number
 D:'PTR
 . S DEPIEN=+$P($G(^RCY(344,ARBPIEN,0)),U,6)  ; (#.06) DEPOSIT TICKET [6P:344.1]
 . S PTR=+$O(^RCY(344.3,"ARDEP",DEPIEN,0))  ; use deposit IEN to get IEN in fil #344.3
 . S PTR=+$O(^RCY(344.31,"B",PTR,0))  ; Get the EFT Number
 ;
 Q $$GET1^DIQ(344.31,PTR_",",.04,"E")  ;(#.04) TRACE # [4F]
 ;
DIQ344(DA,DR) ; Retrieves data for fields in file #344
 ; Input:   DA          - IEN of the receipt to retrieve data from (#344)
 ;          DR          - List of fields to retrieve data for
 ; Output:  RCDPDATA    - Array of retrieved data
 N %I,D0,DIC,DIQ,YY
 K RCDPDATA(344,DA)
 S DIQ(0)="IE",DIC="^RCY(344,",DIQ="RCDPDATA"
 D EN^DIQ1
 Q
 ;
DIQ34401(DA,SUBDA) ; Retrieves data for fields in the transaction subfile (#344.01)
 ; of the receipt file (#344)
 ; Input:   DA          - IEN of the receipt to retrieve data from (#344)
 ;          SUBDA       - IEN of the sub-file record (#344.01)
 ; Output:  RCDPDATA    - Array of retrieved data
 N %I,D0,DIC,DIQ,DR
 K RCDPDATA(344.01,SUBDA)
 S DR=1,DR(344.01)=".01:1.02",DA(344.01)=SUBDA
 S DIQ(0)="IE",DIC="^RCY(344,",DIQ="RCDPDATA"
 D EN^DIQ1
 Q
 ;
HDR ;EP from ListMan Template RCDP RECEIPT PROFILE
 ; Header code for list manager display
 N DATE,DEPIEN,EFTIEN,ERAIEN,FMSDOC,FMSTTR,PAYER,RCDPDATA,RCEFT,RCHMP,RCTOT,XX,Z
 D DIQ344(RCRECTDA,".01;.04;.06;.08;.14;.17;.18;.22")
 ;
 ; PRCA*4.5*321 - Start of modified code block
 S XX=$E("   Receipt #: "_RCDPDATA(344,RCRECTDA,.01,"E")_$$SP,1,39)
 S XX=XX_"Type of Payment: "_RCDPDATA(344,RCRECTDA,.04,"E")
 S VALMHDR(1)=XX
 ;
 S Z=RCDPDATA(344,RCRECTDA,.06,"E")
 S DEPIEN=+$P($G(^RCY(344,RCRECTDA,0)),U,6)
 S RCEFT=+$O(^RCY(344.3,"ARDEP",DEPIEN,0))
 S EFTIEN=RCDPDATA(344,RCRECTDA,.17,"I")
 S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 S FMSTTR=$S($P(FMSDOC,"-",1)="TR":1,1:0)
 S RCHMP=$$ISCHMPVA^RCDPUREC(RCDPDATA(344,RCRECTDA,.04,"I")) ; PRCA*4.5*367 - Is this a CHAMPVA receipt
 S RCTOT=+RCDPDATA(344,RCRECTDA,.22,"E") ; PRCA*4.5*367 - Add Receipt Total to Header
 S XX="" D
 . ; PRCA*4.5*367 - If CHAMPVA receipt, display receipt total instead of receipt 
 . I RCHMP S XX="   Receipt Total: "_$FN(RCTOT,",",2) Q
 . I 'RCEFT&'EFTIEN S XX="   Deposit #: "_Z Q
 . I RCEFT S XX=" EFT Deposit: "_Z Q
 . ; PRCA*4.5*321 - Since EFT and ERA are now displayed on their own line, put TIN/Payer here 
 . N TIN
 . S PAYER=$$GET1^DIQ(344.31,EFTIEN_",",.02,"E")
 . S TIN=$$GET1^DIQ(344.31,EFTIEN_",",.03,"E")
 . S XX="   Payer: "_TIN_"/"_PAYER
 S XX=$E(XX_$$SP,1,39)_" Receipt Status: "_RCDPDATA(344,RCRECTDA,.14,"E")
 S VALMHDR(2)=XX
 ;
 S ERAIEN=RCDPDATA(344,RCRECTDA,.18,"I")
 S XX=""
 I FMSTTR!ERAIEN S XX="   ERA #: "_RCDPDATA(344,RCRECTDA,.18,"E")
 S XX=$E(XX_$$SP,1,21)
 I FMSTTR!ERAIEN S XX=XX_"ERA TTL: "_$J($$GET1^DIQ(344.4,ERAIEN_",",.05,"E"),9)
 S XX=$E(XX_$$SP,1,39)
 ;
 ; FMS document and status
 S XX=XX_" FMS Document: "_$TR($P(FMSDOC,"^")," ")_$S($P(FMSDOC,"^",3):"(on deposit)",1:"")
 S VALMHDR(3)=XX
 ;
 S XX=""
 I FMSTTR!EFTIEN D
 . S XX="   EFT #: "_$$GET1^DIQ(344.31,EFTIEN_",",.01,"I")_"."
 . S XX=XX_$$GET1^DIQ(344.31,EFTIEN_",",.14) ; PRCA*4.5*326
 S XX=$E(XX_$$SP,1,21)
 I FMSTTR!EFTIEN S XX=XX_"EFT TTL: "_$J($$GET1^DIQ(344.31,EFTIEN_",",.07,"E"),9)_" "
 S XX=$E(XX_$$SP,1,39)
 S XX=XX_" FMS Doc Status: "_$P(FMSDOC,"^",2)
 S VALMHDR(4)=XX
 ; PRCA*4.5*321 - End of modified code block
 ;
 I RCDPDATA(344,RCRECTDA,.08,"I") D
 . S VALMSG="Receipt processed on "_RCDPDATA(344,RCRECTDA,.08,"E")
 Q
 ;
EXIT ;EP from ListMan Template RCDP RECEIPT PROFILE
 ; Exit option/clean up
 K ^TMP("RCDPRPLM",$J)
 Q
 ;
SP() Q $J("",132)  ; extrinsic variable, 132 spaces
 ;

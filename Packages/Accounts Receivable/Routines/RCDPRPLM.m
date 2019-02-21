RCDPRPLM ;;WISC/RFJ-receipt profile listmanager top routine ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,149,173,196,220,217,321,326**;Mar 20, 1995;Build 26
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N RCDPFXIT
 ;
RECTPROF ;  entry point called by link payment to prevent newing
 ; fast exit var RCDPFXIT
 N RCRECTDA
 ;
 F  D  Q:'RCRECTDA
 . W !! S RCRECTDA=$$SELRECT^RCDPUREC(1)  ;allow adding new receipt
 . I RCRECTDA<1 S RCRECTDA=0 Q
 . D EN^VALM("RCDP RECEIPT PROFILE")
 . ; fast exit
 . I $G(RCDPFXIT) S RCRECTDA=0
 Q
 ;
 ;
INIT ; init for list manager
 N DATE,FMSDOC,GECSDA1,GECSDATA,RCCANCEL,RCDPDATA,RCDPFCAN,RCLINE,RCTOTAL,RCTRDA,SPACE,RCEFT,X,Z,Z0,RCZ,RCZ0,RCZ1,RCZ2,EFTFUND
 K ^TMP("RCDPRPLM",$J),^TMP("VALM VIDEO",$J)
 ;
 ; fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 ;
 D DIQ344(RCRECTDA,".02:200")
 ;
 ; set listmanager line #
 S RCLINE=0
 ;
 K ^TMP($J,"RCEFT")
 S EFTFUND=$S(DT<$$ADDPTEDT^PRCAACC():"5287.4/8NZZ ",1:"528704/8NZZ ")
 S RCEFT=+$O(^RCY(344.3,"ARDEP",+$P($G(^RCY(344,RCRECTDA,0)),U,6),0))
 I RCEFT D
 . S Z=0 F  S Z=$O(^RCY(344.31,"B",RCEFT,Z)) Q:'Z  S Z0=$G(^RCY(344.31,+Z,0)) I $P(Z0,U,14) S ^TMP($J,"RCEFT",$P(Z0,U,14))=Z_U_$E($P(Z0,U,2),1,12)
 S RCTRDA=0 F  S RCTRDA=$O(^RCY(344,RCRECTDA,1,RCTRDA)) Q:'RCTRDA  D
 . D DIQ34401(RCRECTDA,RCTRDA)
 . S RCLINE=RCLINE+1 D SET("",RCLINE,1,80,.01)
 . ;check for payment cancelled
 . S RCCANCEL=0
 . I $P($G(^RCY(344,RCRECTDA,1,RCTRDA,0)),"^",4)=0,$P($G(^(1)),"^")'="" D
 . . S RCCANCEL=1,RCDPFCAN=1
 . . D SET("**",RCLINE,5,6)
 . ;account
 . I $G(RCDPDATA(344.01,RCTRDA,.03,"E"))="" D
 . . S RCDPDATA(344.01,RCTRDA,.03,"E")="[ "_$S(RCEFT:EFTFUND_$P($G(^TMP($J,"RCEFT",RCTRDA)),U,2),1:"suspense"_$$GETUNAPP^RCXFMSCR(RCRECTDA,RCTRDA,0))_" ]"
 . D SET("",RCLINE,7,33,.03)
 . ;date of payment
 . I RCDPDATA(344.01,RCTRDA,.06,"I") D
 . . D SET($E(RCDPDATA(344.01,RCTRDA,.06,"I"),4,5)_"/"_$E(RCDPDATA(344.01,RCTRDA,.06,"I"),6,7)_"/"_$E(RCDPDATA(344.01,RCTRDA,.06,"I"),2,3),RCLINE,35,42)
 . ;entered by
 . I RCDPDATA(344.01,RCTRDA,.12,"E")'="" D
 . . S X=$E($P(RCDPDATA(344.01,RCTRDA,.12,"E"),",",2))_$E(RCDPDATA(344.01,RCTRDA,.12,"E"))
 . . I RCDPDATA(344.01,RCTRDA,.12,"I")=.5 S X="ar"
 . . D SET(X,RCLINE,45,46)
 . I RCDPDATA(344.01,RCTRDA,.14,"E")'="" D
 . . S X=$E($P(RCDPDATA(344.01,RCTRDA,.14,"E"),",",2))_$E(RCDPDATA(344.01,RCTRDA,.14,"E"))
 . . D SET(X,RCLINE,54,55)
 . D SET($J(RCDPDATA(344.01,RCTRDA,.04,"E"),8,2),RCLINE,62,70)
 . D SET($J(RCDPDATA(344.01,RCTRDA,.05,"E"),8,2),RCLINE,72,80)
 . ;
 . ;if not processed, show if amount > bill
 . S X=$$CHECKPAY^RCDPRPL3(RCRECTDA,RCTRDA) I X D
 . . S RCLINE=RCLINE+1
 . . D SET("  WARNING: Pending Payments ($ "_$J($P(X,"^",3),0,2)_") exceed amount billed ($ "_$J($P(X,"^",2),0,2)_")",RCLINE,1,80)
 . ;
 . ;show line 2 for check/credit payment
 . I $$OPTCK^RCDPRPL2("SHOWCHECK",2) D
 . . ;receipt type of payment is check
 . . I RCDPDATA(344,RCRECTDA,.04,"I")=4!(RCDPDATA(344,RCRECTDA,.04,"I")=12) D  Q
 . . . S RCLINE=RCLINE+1
 . . . D SET("      Check #",RCLINE,1,80,.07)
 . . . I 'RCDPDATA(344.01,RCTRDA,.1,"I") S RCDPDATA(344.01,RCTRDA,.1,"I")="???????"
 . . . D SET("Date: "_$E(RCDPDATA(344.01,RCTRDA,.1,"I"),4,5)_"/"_$E(RCDPDATA(344.01,RCTRDA,.1,"I"),6,7)_"/"_$E(RCDPDATA(344.01,RCTRDA,.1,"I"),2,3),RCLINE,32,80)
 . . . D SET("Bank #",RCLINE,47,80,.08)
 . . ;receipt type of payment is credit
 . . I RCDPDATA(344,RCRECTDA,.04,"I")=7 D
 . . . S RCLINE=RCLINE+1
 . . . D SET("      Card #",RCLINE,1,80,.11)
 . . . D SET("Confirmation #",RCLINE,35,80,.02)
 . ;
 . ;show line 3 for acct lookup, batch and seq #
 . I $$OPTCK^RCDPRPL2("SHOWACCT",2) D
 . . I RCDPDATA(344.01,RCTRDA,.21,"E")="",RCDPDATA(344.01,RCTRDA,.22,"E")="",RCDPDATA(344.01,RCTRDA,.23,"E")="" Q
 . . S RCLINE=RCLINE+1
 . . D SET("      AcctLU",RCLINE,1,80,.21)
 . . D SET("Batch/Sequence: "_RCDPDATA(344.01,RCTRDA,.22,"E")_"/"_RCDPDATA(344.01,RCTRDA,.23,"E"),RCLINE,37,80)
 . ;
 . ;show if posting error
 . I $$OPTCK^RCDPRPL2("SHOWCOMMENTS",2),RCDPDATA(344.01,RCTRDA,1.01,"E")'="" D
 . . S RCLINE=RCLINE+1
 . . S X="Posting Error"
 . . I RCCANCEL S X="Cancel Data"
 . . D SET("      "_X,RCLINE,1,80,1.01)
 . ;
 . ;show if comment
 . I $$OPTCK^RCDPRPL2("SHOWCOMMENTS",2),RCDPDATA(344.01,RCTRDA,1.02,"E")'="" D
 . . S RCLINE=RCLINE+1
 . . D SET("      Comment",RCLINE,1,80,1.02)
 . ;
 . ;if EDI Lockbox pending adjustments, show it
 . I $P($G(^RCY(344,RCRECTDA,0)),U,18),$G(RCDPDATA(344.01,RCTRDA,.27,"E")) D
 . . S RCZ=$P(^RCY(344,RCRECTDA,0),U,18),RCZ0=RCDPDATA(344.01,RCTRDA,.27,"E")
 . . S RCZ1=0 F  S RCZ1=$O(^RCY(344.49,RCZ,1,RCZ0,1,RCZ1)) Q:'RCZ1  S RCZ2=$G(^(RCZ1,0)) I $P(RCZ2,U,5)'="","12"[$P(RCZ2,U,5),'$P(RCZ2,U,8) D
 . . . I $P(RCZ2,U,5)=1 S RCLINE=RCLINE+1 D SET("      Pending decrease adjustment for "_$J($P(RCZ2,U,3),"",2),RCLINE,1,80) Q
 . . . I $$OPTCK^RCDPRPL2("SHOWCOMMENTS",2),$P(RCZ2,U,5)=2 S RCLINE=RCLINE+1 D SET("      Comment: "_$P(RCZ2,U,9),RCLINE,1,80) Q
 . ;
 . ;calculate totals
 . S RCTOTAL(1)=$G(RCTOTAL(1))+RCDPDATA(344.01,RCTRDA,.04,"E")
 . S RCTOTAL(2)=$G(RCTOTAL(2))+RCDPDATA(344.01,RCTRDA,.05,"E")
 . ;
 . ;kill local variable to prevent store errors
 . K RCDPDATA(344.01,RCTRDA)
 ;
 ; show totals
 K ^TMP($J,"RCEFT")
 S RCLINE=RCLINE+1 D SET("",RCLINE,1,80)
 D SET("--------  --------",RCLINE,62,80)
 S RCLINE=RCLINE+1
 D SET("      TOTAL DOLLARS FOR RECEIPT",RCLINE,1,80)
 D SET($J($G(RCTOTAL(1)),8,2),RCLINE,62,70)
 D SET($J($G(RCTOTAL(2)),8,2),RCLINE,72,80)
 ; show cancelled
 I $G(RCDPFCAN) D
 . S RCLINE=RCLINE+1
 . D SET("**indicates payment is CANCELLED",RCLINE,5,80)
 ;
 ; show history
 S RCLINE=RCLINE+1
 D SET(" ",RCLINE,1,80)
 ; start history on first line of a screen if it does not fit on
 ; current screen
 I (RCLINE#12)>8 F SPACE=(RCLINE#12):1:12 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1
 D SET("Receipt History",RCLINE,1,80,0,IOUON,IOUOFF)
 S DATE=RCDPDATA(344,RCRECTDA,.03,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 S RCLINE=RCLINE+1
 S SPACE="",$P(SPACE," ",80)=""
 I RCDPDATA(344,RCRECTDA,.02,"I")=.5 S RCDPDATA(344,RCRECTDA,.02,"E")="accounts receivable"
 D SET($E("   Opened By: "_RCDPDATA(344,RCRECTDA,.02,"E")_SPACE,1,39)_"Date/Time    Opened: "_DATE,RCLINE,1,80)
 S DATE=RCDPDATA(344,RCRECTDA,.12,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 S RCLINE=RCLINE+1
 I RCDPDATA(344,RCRECTDA,.11,"I")=.5 S RCDPDATA(344,RCRECTDA,.11,"E")="accounts receivable"
 D SET($E("Last Edit By: "_RCDPDATA(344,RCRECTDA,.11,"E")_SPACE,1,39)_"Date/Time Last Edit: "_DATE,RCLINE,1,80)
 S DATE=RCDPDATA(344,RCRECTDA,.08,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 S RCLINE=RCLINE+1
 I RCDPDATA(344,RCRECTDA,.07,"I")=.5 S RCDPDATA(344,RCRECTDA,.07,"E")="accounts receivable"
 D SET($E("Processed By: "_RCDPDATA(344,RCRECTDA,.07,"E")_SPACE,1,39)_"Date/Time Processed: "_DATE,RCLINE,1,80)
 ;
 ;show fms code sheets if switch on
 I $$OPTCK^RCDPRPL2("SHOWFMS",2) D
 . S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 . S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 . S RCLINE=RCLINE+1 D SET("FMS Cash Receipt Document:",RCLINE,1,80,0,IOUON,IOUOFF)
 . D SET($P(FMSDOC,"^")_$S($P(FMSDOC,"^",3):"(on deposit)",1:""),RCLINE,28,80)
 . D SET("Status: "_$P(FMSDOC,"^",2),RCLINE,55,80)
 . N DIQ2 D DATA^GECSSGET($P(FMSDOC,"^"),1)
 . I '$G(GECSDATA) Q
 . S GECSDA1=0 F  S GECSDA1=$O(GECSDATA(2100.1,GECSDATA,10,GECSDA1)) Q:'GECSDA1  D
 . . S RCLINE=RCLINE+1 D SET(GECSDATA(2100.1,GECSDATA,10,GECSDA1),RCLINE,1,80)
 ;
 ; show EEOB detail if switch on
 D SHEOB^RCDPRPL2
 ;
 ; set valmcnt to # of lines in list
 S VALMCNT=RCLINE
 D HDR
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_$S(STRING="":"",1:": ")_$G(RCDPDATA(344.01,RCTRDA,FIELD,"E"))
 I STRING="",'$G(FIELD) D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q
 ;
 ;
DIQ344(DA,DR) ; retrieves data for flds in file 344
 N %I,D0,DIC,DIQ,DIQ2,YY
 K RCDPDATA(344,DA)
 S DIQ(0)="IE",DIC="^RCY(344,",DIQ="RCDPDATA" D EN^DIQ1
 Q
 ;
 ;
DIQ34401(DA,SUBDA) ; retrieves data for flds in file 344
 ; da = receipt da
 N %I,D0,DIC,DIQ,DIQ2,DR
 K RCDPDATA(344.01,SUBDA)
 S DR=1,DR(344.01)=".01:1.02",DA(344.01)=SUBDA
 S DIQ(0)="IE",DIC="^RCY(344,",DIQ="RCDPDATA" D EN^DIQ1
 Q
 ;
 ;
HDR ; header code for list manager display
 N DATE,DEPIEN,EFTIEN,ERAIEN,FMSDOC,FMSTTR,PAYER,RCDPDATA,RCEFT,SPACE,XX,Z
 D DIQ344(RCRECTDA,".01;.04;.06;.08;.14;.17;.18;")
 S SPACE="",$P(SPACE," ",80)=""
 ;
 ; PRCA*4.5*321 - Start of modified code block
 S XX=$E("   Receipt #: "_RCDPDATA(344,RCRECTDA,.01,"E")_SPACE,1,39)
 S XX=XX_"Type of Payment: "_RCDPDATA(344,RCRECTDA,.04,"E")
 S VALMHDR(1)=XX
 ;
 S Z=RCDPDATA(344,RCRECTDA,.06,"E")
 S DEPIEN=+$P($G(^RCY(344,RCRECTDA,0)),U,6)
 S RCEFT=+$O(^RCY(344.3,"ARDEP",DEPIEN,0))
 S EFTIEN=RCDPDATA(344,RCRECTDA,.17,"I")
 S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 S FMSTTR=$S($P(FMSDOC,"-",1)="TR":1,1:0)
 S XX=""
 I 'RCEFT&'EFTIEN D  ;
 . S XX="   Deposit #: "_Z
 E  D  ;
 . I RCEFT D  ;
 . . S XX=" EFT Deposit: "_Z
 . E  D  ;
 . . ; PRCA*4.5*321 - Since EFT and ERA are now displayed on their own line, put TIN/Payer here 
 . . N TIN
 . . S PAYER=$$GET1^DIQ(344.31,EFTIEN_",",.02,"E")
 . . S TIN=$$GET1^DIQ(344.31,EFTIEN_",",.03,"E")
 . . S XX="   Payer: "_TIN_"/"_PAYER
 S XX=$E(XX_SPACE,1,39)
 S XX=XX_" Receipt Status: "_RCDPDATA(344,RCRECTDA,.14,"E")
 S VALMHDR(2)=XX
 ;
 S ERAIEN=RCDPDATA(344,RCRECTDA,.18,"I")
 S XX=""
 I FMSTTR!ERAIEN S XX="   ERA #: "_RCDPDATA(344,RCRECTDA,.18,"E")
 S XX=$E(XX_SPACE,1,21)
 I FMSTTR!ERAIEN S XX=XX_"ERA TTL: "_$J($$GET1^DIQ(344.4,ERAIEN_",",.05,"E"),9)
 S XX=$E(XX_SPACE,1,39)
 ; get fms document and status
 S XX=XX_" FMS Document: "_$TR($P(FMSDOC,"^")," ")_$S($P(FMSDOC,"^",3):"(on deposit)",1:"")
 S VALMHDR(3)=XX
 ;
 S XX=""
 I FMSTTR!EFTIEN S XX="   EFT #: "_$$GET1^DIQ(344.31,EFTIEN_",",.01,"I")_"."_$$GET1^DIQ(344.31,EFTIEN_",",.14) ; PRCA*4.5*326
 S XX=$E(XX_SPACE,1,21)
 I FMSTTR!EFTIEN S XX=XX_"EFT TTL: "_$J($$GET1^DIQ(344.31,EFTIEN_",",.07,"E"),9)_" "
 S XX=$E(XX_SPACE,1,39)
 S XX=XX_" FMS Doc Status: "_$P(FMSDOC,"^",2)
 S VALMHDR(4)=XX
 ; PRCA*4.5*321 - End of modified code block
 ;
 I RCDPDATA(344,RCRECTDA,.08,"I") S VALMSG="Receipt processed on "_RCDPDATA(344,RCRECTDA,.08,"E")
 Q
 ;
 ;
EXIT ; exit option/clean up
 K ^TMP("RCDPRPLM",$J)
 Q

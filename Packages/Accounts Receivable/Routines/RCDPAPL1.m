RCDPAPL1 ;WISC/RFJ-account profile listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,315**;Mar 20, 1995;Build 67
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
ACCOUNT ;  select a new account
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow you to select a new account."
 W ! S %=$$SELACCT^RCDPAPLM
 I %<1 Q
 S RCDEBTDA=%
 ;
 D INIT^RCDPAPLM
 Q
 ;
BILLTRAN ;  show transactions for a bill
 N RCBILLDA
 S VALMBCK="R"
 ;
 S RCBILLDA=$$SELBILL I 'RCBILLDA Q
 D EN^VALM("RCDP TRANSACTIONS LIST")
 ;
 D INIT^RCDPAPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
BILLPROF ;  bill profile
 N RCBILLDA
 S VALMBCK="R"
 ;
 S RCBILLDA=$$SELBILL I 'RCBILLDA Q
 D EN^VALM("RCDP BILL PROFILE")
 ;
 D INIT^RCDPAPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
SELBILL() ;  select bill from list
 N VALMBG,VALMLST,VALMY
 ;  if no bills, quit
 I '$O(^TMP("RCDPAPLM",$J,"IDX",0)) S VALMSG="There are NO bills to profile." Q 0
 ;
 ;  if only one bill, select that one automatically
 I '$O(^TMP("RCDPAPLM",$J,"IDX",1)) Q +$G(^TMP("RCDPAPLM",$J,"IDX",1,1))
 ;
 ;  select the entry from the list
 ;  if not on first screen, make sure selection begins with 1
 S VALMBG=1
 ;  if not on last screen, make sure selection ends with last
 S VALMLST=$O(^TMP("RCDPAPLM",$J,"IDX",999999999),-1)
 D EN^VALM2($G(XQORNOD(0)),"OS")
 Q +$G(^TMP("RCDPAPLM",$J,"IDX",+$O(VALMY(0)),+$O(VALMY(0))))
 ;
SELMULT(VALMY) ; select 0, 1, or more bills from the list
 ; Output VALMY array, pass by reference.  Return format is VALMY(#)=""
 ; The calling routine must then process any of the entries found in the VALMY array, one at a time.
 ;
 N VALMBG,VALMLST
 K VALMY
 ;
 ; if no bills in list, then update screen message and exit
 I '$O(@VALMAR@("IDX",0)) S VALMSG="There are no bills to select." G SELMX
 ;
 ; if there is only 1 bill in list then add that one into the VALMY array and quit
 I '$O(@VALMAR@("IDX",1)) S VALMY(1)="" G SELMX
 ;
 ; Multiple bills in list. Ask user to select 1 or more of them
 S VALMBG=1                                    ; first possible entry
 S VALMLST=$O(@VALMAR@("IDX",999999999),-1)    ; last possible entry
 ;
 ; call the selector API
 D EN^VALM2($G(XQORNOD(0)),"O")
 ;
SELMX ;
 Q
 ;
SUSPEND ;Suspend a Bill PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 D SELMULT(.VALMY) I '$O(VALMY(0)) G SUSPX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D 47^RCWROFF    ; Call into existing write-off routine for each bill selected
 . I $G(RCDPGQ) W " ... exiting Bill# loop" Q
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
SUSPX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
REESTAB ; Re-Establish a Bill - PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 D SELMULT(.VALMY) I '$O(VALMY(0)) G REESTX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D ENAP^PRCAWREA(RCBILLDA)     ; Call into existing Re-Establish bill routine for each bill selected
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
REESTX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
STOP ;Stop a Bill in Cross-servicing (Debtor) PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 D SELMULT(.VALMY) I '$O(VALMY(0)) G STOPX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D STOP^RCTCSPU  ;Call into existing TOP routine for each bill selected
 . I $G(RCDPGQ) W " ... exiting Bill# loop" Q
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
STOPX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
TERM ;Fiscal Officer Terminated PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 D SELMULT(.VALMY) I '$O(VALMY(0)) G TERMX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D 8^RCWROFF     ; Call into existing write-off routine for each bill selected
 . I $G(RCDPGQ) W " ... exiting Bill# loop" Q
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
TERMX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
RECALLB ;Recall a Bill PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 D SELMULT(.VALMY) I '$O(VALMY(0)) G RECALBX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D RCLLSETB^RCTCSPU    ; Call into existing recall code
 . I $G(RCDPGQ) W " ... exiting Bill# loop" Q
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
RECALBX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
RECALLD ;Recall a Debtor PRCA*4.5*315
 N GOTDEBT,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 S RCDEBTDA=+$G(RCDEBTDA)     ; RCDEBTDA is set by the ACCTPR^RCTCSWL - Account Profile action protocol
 I 'RCDEBTDA G RECALDX
 ;
 S GOTDEBT=1
 D RCLLSETD^RCTCSPU     ; Call into existing recall code for debtors
 D PAUSE^VALM1
 D INIT^RCDPAPLM        ; refresh the account profile list of bills
RECALDX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
INC ;Increase Transaction PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 ;
 ; check on security key - same one used in the menu system for AR option PRCAC TR ADJUSTMENT
 I '$D(^XUSEC("PRCADJ",DUZ)) D  G INCX
 . W *7,!!?3,"You must hold the PRCADJ security key in order to access this option.",!
 . D PAUSE^VALM1
 . Q
 ;
 D SELMULT(.VALMY) I '$O(VALMY(0)) G INCX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D INCREASE^RCBEADJ    ; Call into existing increase code
 . I $G(RCDPGQ) W " ... exiting Bill# loop" Q
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
INCX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
DEC ;Decrease Transaction PRCA*4.5*315
 N GOTBILL,VALMY,RCBILLDA,RCDPGN,RCDPGC,RCDPGT,RCDPGQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D FULL^VALM1
 ;
 ; check on security key - same one used in the menu system for AR option PRCAC TR ADJUSTMENT
 I '$D(^XUSEC("PRCADJ",DUZ)) D  G DECX
 . W *7,!!?3,"You must hold the PRCADJ security key in order to access this option.",!
 . D PAUSE^VALM1
 . Q
 ;
 D SELMULT(.VALMY) I '$O(VALMY(0)) G DECX
 ;
 ; count the number of selected entries and put into RCDPGT
 S RCDPGN=0 F RCDPGT=0:1 S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN
 ;
 W !
 S (RCDPGN,RCDPGC)=0 F  S RCDPGN=$O(VALMY(RCDPGN)) Q:'RCDPGN  D  Q:$G(RCDPFXIT)!$G(RCDPGQ)
 . S RCBILLDA=$G(@VALMAR@("IDX",RCDPGN,RCDPGN)) Q:'RCBILLDA
 . S RCDPGC=RCDPGC+1
 . W !,"  ======== Bill# ",$P($P($G(^PRCA(430,RCBILLDA,0)),U,1),"-",2)," (",RCDPGC," of ",RCDPGT," selected) ========",!
 . S GOTBILL=1
 . D DECREASE^RCBEADJ    ; Call into existing decrease code
 . I $G(RCDPGQ) W " ... exiting Bill# loop" Q
 . ;
 . ; special break in between each bill
 . W ! S DIR(0)="E" S DIR("A")="Type <Enter> to continue"
 . I (RCDPGT-RCDPGC)>0 S DIR("A")=DIR("A")_" or '^' to exit this Bill# loop"    ; if there are still more bills in loop
 . D ^DIR K DIR W !
 . I $D(DIRUT) S RCDPGQ=1
 . Q
 ;
 D INIT^RCDPAPLM   ; refresh the account profile list of bills
 ;
DECX ;
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;

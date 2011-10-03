RCDPDPL1 ;WISC/RFJ-deposit profile listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,172,173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EDITDEP ;  option: edit the deposit
 D FULL^VALM1
 S VALMBCK="R"
 ;
 I '$$LOCKDEP^RCDPDPLU(RCDEPTDA) Q
 ;
 W !
 D EDITDEP^RCDPUDEP(RCDEPTDA)
 L -^RCY(344.1,RCDEPTDA)
 ;
 ;  rebuild the header
 D INIT^RCDPDPLM
 D HDR^RCDPDPLM
 Q
 ;
 ;
CONFIRM ;  option: confirm deposit
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will confirm a deposit.  Once a deposit is confirmed, receipts"
 W !,"can no longer be added or changed on the deposit.  Before a deposit can be"
 W !,"confirmed all receipts must be processed and the cash receipt code sheets"
 W !,"accepted by FMS."
 ;
 N DATA,ERROR,FMSDOC,RECTDA,STATUS,X
 ;
 I '$$LOCKDEP^RCDPDPLU(RCDEPTDA) Q
 ;
 ;  check bank data
 S ERROR=$$CHEKBANK(RCDEPTDA)
 I ERROR D  Q:ERROR
 .   W ! D EDITDEP^RCDPUDEP(RCDEPTDA)
 .   S ERROR=$$CHEKBANK(RCDEPTDA)
 .   I 'ERROR Q
 .   S VALMSG="Deposit NOT Confirmed."
 .   W !,VALMSG,!,"Use the Edit Deposit option to enter missing bank data."
 .   W !!,"Press RETURN to continue: " R X:DTIME
 .   L -^RCY(344.1,RCDEPTDA)
 .   ;  rebuild the screen
 .   D INIT^RCDPDPLM
 .   D HDR^RCDPDPLM
 W " Done."
 ;
 ;  check receipts
 W !!,"Checking receipts on deposit ..."
 S RECTDA=0 F  S RECTDA=$O(^RCY(344,"AD",RCDEPTDA,RECTDA)) Q:'RECTDA  D
 .   S DATA=$G(^RCY(344,RECTDA,0)) I DATA="" Q
 .   ;  get status, error if receipt not closed
 .   S STATUS=$S($P(DATA,"^",14)'=0:"OPEN",1:"CLOSED")
 .   I STATUS'="CLOSED" S ERROR=1
 .   ;  get fms cr doc number and status, error if doc not accepted
 .   ;  returns fmsdocument ^ status ^ prelockbox flag
 .   S FMSDOC=$$FMSSTAT^RCDPUREC(RECTDA)
 .   ;  if status is closed and the fms document not sent (no dollars), allow confirm
 .   I STATUS="CLOSED",$P(FMSDOC,"^",2)="NOT ENTERED" Q
 .   ;
 .   I $P(FMSDOC,"^",2)'["ON LINE ENTRY",$P(FMSDOC,"^",2)'["ACCEPTED" S ERROR=1
 .   W !?5,$P(DATA,"^"),?15,STATUS,?30,$P(FMSDOC,"^"),?45,$P(FMSDOC,"^",2)
 ;
 I $G(ERROR) D  Q
 .   W !!,"Cannot confirm deposit until all receipts are closed and the cash"
 .   W !,"receipt documents have been accepted in FMS."
 .   W !!,"Press RETURN to continue: " R X:DTIME
 .   L -^RCY(344.1,RCDEPTDA)
 ;
 W !!,"All receipts are closed and accepted."
 I $$ASKCONFI=1 D CONFIRM^RCDPUDEP(RCDEPTDA),HDR^RCDPDPLM
 L -^RCY(344.1,RCDEPTDA)
 ;
 ;  rebuild the header
 D INIT^RCDPDPLM
 D HDR^RCDPDPLM
 Q
 ;
 ;
CHEKBANK(RCDEPTDA) ;  check the bank data for a deposit
 ;  return error of 1 if data is missing
 N DATA,ERROR
 W !!,"Checking the deposit bank data ..."
 S DATA=^RCY(344.1,RCDEPTDA,0)
 I $P(DATA,"^",13)="" S ERROR=1 W !?5,"BANK is missing."
 ;I $P(DATA,"^",5)="" S ERROR=1 W !?5,"BANK TRACE NUMBER is missing."
 I $P(DATA,"^",14)="" S ERROR=1 W !?5,"AGENCY LOCATION CODE is missing."
 I $P(DATA,"^",17)="" S ERROR=1 W !?5,"AGENCY TITLE is missing."
 Q +$G(ERROR)
 ;
 ;
ADDREC ;  add a new receipt
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCRECTDA
 W !
 S RCRECTDA=$$SELRECT^RCDPUREC(1,RCDEPTDA)
 I RCRECTDA<1 Q
 ;
 D EN^VALM("RCDP RECEIPT PROFILE")
 ;
 D INIT^RCDPDPLM
 S VALMBCK="R"
 Q
 ;
 ;
DICW ; Write identifiers for ERA lookup
 ; Assumes Y = ien of entry file 344.4
 N RC0
 S RC0=$G(^RCY(344.4,Y,0))
 W ?9,"From: ",$E($P(RC0,U,6),1,20),"  Trace: ",$E($P(RC0,U,2),1,10),"  Amt: ",$J(+$P(RC0,U,5),"",2)_"  on ",$$FMTE^XLFDT($P(RC0,U,4),2)
 Q
 ;
RECEIPTS ;  option: receipt profile/processing
 N INDEX,RCRECTDA,VALMBG,VALMLST,VALMY
 S VALMBCK="R"
 ;
 ;  if no receipts, quit
 I '$O(^TMP("RCDPDPLM",$J,"IDX",0)) S VALMSG="There are NO receipts to profile." Q
 ;
 ;  if only one receipt, select that one automatically
 I '$O(^TMP("RCDPDPLM",$J,"IDX",1)) S INDEX=1
 ;
 ;  select the entry from the list
 I '$G(INDEX) D   I 'INDEX Q
 .   ;  if not on first screen, make sure selection begins with 1
 .   S VALMBG=1
 .   ;  if not on last screen, make sure selection ends with last
 .   S VALMLST=$O(^TMP("RCDPDPLM",$J,"IDX",999999999),-1)
 .   D EN^VALM2($G(XQORNOD(0)),"OS")
 .   S INDEX=$O(VALMY(0))
 ;
 S RCRECTDA=+$G(^TMP("RCDPDPLM",$J,"IDX",INDEX,INDEX))
 D EN^VALM("RCDP RECEIPT PROFILE")
 ;
 D INIT^RCDPDPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
CUSTOMIZ ;  option: customize display
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow the user to customize the screen and options"
 W !,"used for deposit processing."
 ;
 ;  ask to show check/credit card data
 I $$ASKFMS=-1 Q
 ;
 D INIT^RCDPDPLM
 Q
 ;
 ;
ASKFMS() ;  ask if its okay to show fms cr documents
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to turn on the display of the FMS CR documents"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 S ^DISV(DUZ,"RCDPDPLM","SHOWFMS")=Y
 Q Y
 ;
ASKCONFI() ;  ask if its okay to confirm the deposit
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you sure you want to CONFIRM this deposit"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;

RCDPDPLM ;WISC/RFJ-deposit profile listmanager top routine ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,149**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N RCDEPTDA,RCDPFXIT
 ;
 F  D  Q:'RCDEPTDA
 .   W !! S RCDEPTDA=$$SELDEPT^RCDPUDEP(1)  ;  allow adding new deposit
 .   I RCDEPTDA<1 S RCDEPTDA=0 Q
 .   D EN^VALM("RCDP DEPOSIT PROFILE")
 .   ;  fast exit
 .   I $G(RCDPFXIT) S RCDEPTDA=0
 Q
 ;
 ;
INIT ;  initialization for list manager list
 N COMMDA,FMSDOC,RCDEPCNT,RCDEPTOT,RCDPDATA,RCLINE,RCRECTDA,STATUS
 K ^TMP("RCDPDPLM",$J),^TMP("VALM VIDEO",$J)
 ;
 ;  fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 ;
 ;  set the listmanager line number
 S RCLINE=0
 ;
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,"AD",RCDEPTDA,RCRECTDA)) Q:'RCRECTDA  D
 .   D DIQ344^RCDPRPLM(RCRECTDA,".01:999;")
 .   S RCLINE=RCLINE+1
 .   ;  create an index array for bill lookup in list
 .   S ^TMP("RCDPDPLM",$J,"IDX",RCLINE,RCLINE)=RCRECTDA
 .   D SET(RCLINE,RCLINE,1,80,0,IORVON,IORVOFF)
 .   ;  receipt
 .   D SET("",RCLINE,5,80,.01)
 .   ;  type of payment
 .   D SET("",RCLINE,17,80,.04)
 .   ;  date opened
 .   I RCDPDATA(344,RCRECTDA,.03,"I") D
 .   .   D SET($E(RCDPDATA(344,RCRECTDA,.03,"I"),4,5)_"/"_$E(RCDPDATA(344,RCRECTDA,.03,"I"),6,7)_"/"_$E(RCDPDATA(344,RCRECTDA,.03,"I"),2,3),RCLINE,35,42)
 .   ;  by (check for null before calling set)
 .   I RCDPDATA(344,RCRECTDA,.02,"E")'="" D
 .   .   S X=$E($P(RCDPDATA(344,RCRECTDA,.02,"E"),",",2))_$E(RCDPDATA(344,RCRECTDA,.02,"E"))
 .   .   I RCDPDATA(344,RCRECTDA,.02,"I")=.5 S X="ar"
 .   .   D SET(X,RCLINE,45,46)
 .   ;  date processed
 .   I RCDPDATA(344,RCRECTDA,.08,"I") D
 .   .   D SET($E(RCDPDATA(344,RCRECTDA,.08,"I"),4,5)_"/"_$E(RCDPDATA(344,RCRECTDA,.08,"I"),6,7)_"/"_$E(RCDPDATA(344,RCRECTDA,.08,"I"),2,3),RCLINE,49,56)
 .   ;  by (check for null before calling set)
 .   I RCDPDATA(344,RCRECTDA,.07,"E")'="" D
 .   .   S X=$E($P(RCDPDATA(344,RCRECTDA,.07,"E"),",",2))_$E(RCDPDATA(344,RCRECTDA,.07,"E"))
 .   .   I RCDPDATA(344,RCRECTDA,.07,"I")=.5 S X="ar"
 .   .   D SET(X,RCLINE,59,60)
 .   ;  number of transactions
 .   D SET($J(RCDPDATA(344,RCRECTDA,101,"E"),8),RCLINE,61,69)
 .   ;  total dollars
 .   D SET($J(RCDPDATA(344,RCRECTDA,.15,"E"),10,2),RCLINE,70,79)
 .   ;  calculate totals
 .   S RCDEPCNT=$G(RCDEPCNT)+RCDPDATA(344,RCRECTDA,101,"E")
 .   S RCDEPTOT=$G(RCDEPTOT)+RCDPDATA(344,RCRECTDA,.15,"E")
 .   K RCDPDATA
 ;
 I RCLINE=0 S RCLINE=RCLINE+1 D SET("  *** No RECEIPTS for this deposit ***",RCLINE,1,80)
 ;
 ;  show totals
 S RCLINE=RCLINE+1
 D SET("                                                            --------   --------",RCLINE,1,80)
 S RCLINE=RCLINE+1
 D SET("      TOTAL DOLLARS FOR DEPOSIT",RCLINE,1,80)
 D SET($J($G(RCDEPCNT),8),RCLINE,61,69)
 D SET($J($G(RCDEPTOT),10,2),RCLINE,70,79)
 ;
 ;  deposit data displayed on screen
 D DIQ3441(RCDEPTDA,".01:1")
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("                  Bank: "_RCDPDATA(344.1,RCDEPTDA,.13,"E"),RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("     Bank Trace Number: "_RCDPDATA(344.1,RCDEPTDA,.05,"E"),RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("  Agency Location Code: "_RCDPDATA(344.1,RCDEPTDA,.14,"E"),RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("          Agency Title: "_RCDPDATA(344.1,RCDEPTDA,.17,"E"),RCLINE,1,80)
 ;
 ;  display comments if there are any
 I $O(^RCY(344.1,RCDEPTDA,1,0)) D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET("Comments",RCLINE,1,80,0,IOUON,IOUOFF)
 .   S COMMDA=0 F  S COMMDA=$O(^RCY(344.1,RCDEPTDA,1,COMMDA)) Q:'COMMDA  D
 .   .   S RCLINE=RCLINE+1 D SET(^RCY(344.1,RCDEPTDA,1,COMMDA,0),RCLINE,1,80)
 ;
 ;  display FMS CR documents if turned on
 I $G(^DISV(DUZ,"RCDPDPLM","SHOWFMS")) D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET("FMS CR Documents",RCLINE,1,80,0,IOUON,IOUOFF)
 .   S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,"AD",RCDEPTDA,RCRECTDA)) Q:'RCRECTDA  D
 .   .   D DIQ344^RCDPRPLM(RCRECTDA,".01;.14;")
 .   .   S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 .   .   S RCLINE=RCLINE+1
 .   .   D SET("",RCLINE,5,80,.01)
 .   .   D SET("",RCLINE,17,80,.14)
 .   .   D SET($P(FMSDOC,"^"),RCLINE,25,80)
 .   .   D SET($P(FMSDOC,"^",2),RCLINE,40,80)
 .   .   K RCDPDATA
 ;
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_$S(STRING="":"",1:": ")_$G(RCDPDATA(344,RCRECTDA,FIELD,"E"))
 I STRING="",'$G(FIELD) D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q
 ;
 ;
DIQ3441(DA,DR) ;  diq call to retrieve data for dr fields in file 344.1
 N D0,DIC,DIQ,DIQ2,YY
 K RCDPDATA(344.1,DA)
 S DIQ(0)="IE",DIC="^RCY(344.1,",DIQ="RCDPDATA" D EN^DIQ1
 Q
 ;
 ;
HDR ;  header code for list manager display
 N DATE,RCDPDATA,SPACE
 D DIQ3441(RCDEPTDA,".01:1")
 S SPACE="",$P(SPACE," ",80)=""
 S VALMHDR(1)=$E("   Deposit #: "_RCDPDATA(344.1,RCDEPTDA,.01,"E")_SPACE,1,39)_"     Deposit Status: "_RCDPDATA(344.1,RCDEPTDA,.12,"E")
 S VALMHDR(2)=$E("Deposit Date: "_RCDPDATA(344.1,RCDEPTDA,.03,"E")_SPACE,1,39)
 S DATE=RCDPDATA(344.1,RCDEPTDA,.07,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 I RCDPDATA(344.1,RCDEPTDA,.06,"I")=.5 S RCDPDATA(344.1,RCDEPTDA,.06,"E")="accounts receivable"
 S VALMHDR(3)=$E("   Opened By: "_RCDPDATA(344.1,RCDEPTDA,.06,"E")_SPACE,1,39)_"Date/Time    Opened: "_DATE
 S DATE=RCDPDATA(344.1,RCDEPTDA,.11,"E"),DATE=$P(DATE,"@")_"  "_$P($P(DATE,"@",2),":",1,2)
 I RCDPDATA(344.1,RCDEPTDA,.1,"I")=.5 S RCDPDATA(344.1,RCDEPTDA,.1,"E")="accounts receivable"
 S VALMHDR(4)=$E("Confirmed By: "_RCDPDATA(344.1,RCDEPTDA,.1,"E")_SPACE,1,39)_"Date/Time Confirmed: "_DATE
 ;
 I RCDPDATA(344.1,RCDEPTDA,.11,"I") S VALMSG="Deposit confirmed on "_RCDPDATA(344.1,RCDEPTDA,.11,"E")
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCDPDPLM",$J)
 Q
 ;
 ;
FASTEXIT ;  this is called by the protocol file to exit any of the deposit
 ;  processing listmanager screens
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Exit option entirely"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I $G(DIRUT)!(Y) S RCDPFXIT=1
 Q

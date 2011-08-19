RCDPLPLM ;WISC/RFJ-link payments listmanager top routine ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N RCFCHECK,RCFTRACE,RCFCREDT,RCDPFXIT
 N %,%DT,%H,%I,RCDPPADT,X,Y
 S %DT("A")="Start with Payment Date (press RETURN for FIRST): ",%DT="AEP",%DT(0)=-DT
 D ^%DT I Y<0,X["^" Q
 ;  if user entered a date, go back one day
 I Y'<0 S RCDPPADT=$$FMADD^XLFDT(+Y,-1)
 ;
 D EN^VALM("RCDP LINK PAYMENTS TO ACCOUNTS")
 Q
 ;
INIT ;  initialization for list manager list
 ;  pass RCDPPADT to display payments after RCDPPADT date
 ;  pass RCFCHECK, RCFTRACE and RCFCREDT to search by
 ;        check/trace #/credit card #
 ;  fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 ;
 W !!,"please wait, building list of unlinked payments..."
 ;
 N DATE,FMSDOC,NUMBER,RCCOUNT,RCDATA,RCLINE,RCRECTDA,RCTOTAL,RCTRANDA,RECDATA,TYPE
 ;
 ;  set the listmanager line number
 S RCLINE=0
 ;  set the lookup payment number from list
 S RCCOUNT=0
 ;  get list of unlinked accounts
 K ^TMP("RCDPLPLM",$J)
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,"AN",RCRECTDA)) Q:'RCRECTDA  D
 .   S RECDATA=$G(^RCY(344,RCRECTDA,0))
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^RCY(344,"AN",RCRECTDA,RCTRANDA)) Q:'RCTRANDA  D
 .   .   S RCDATA=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 .   .   I '$P(RCDATA,"^",4) Q  ;no payment amount
 .   .   ;  fms doc id entered (field 26) to clear suspense
 .   .   I $P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",6)'="" Q
 .   .   ;  unlinked
 .   .   ;  get payment date
 .   .   S DATE=$P(RCDATA,"^",6)
 .   .   I 'DATE S DATE=$P(RCDATA,"^",10)
 .   .   I 'DATE S DATE=$P(RECDATA,"^",3)
 .   .   I 'DATE S DATE=0
 .   .   ;  before selected payment date
 .   .   I $G(RCDPPADT),DATE<RCDPPADT Q
 .   .   ;
 .   .   S RCLINE=RCLINE+1
 .   .   S RCCOUNT=RCCOUNT+1
 .   .   ;
 .   .   ;  create an index array for bill lookup in list
 .   .   S ^TMP("RCDPLPLM",$J,"IDX",RCCOUNT,RCCOUNT)=RCRECTDA_"^"_RCTRANDA
 .   .   ;
 .   .   D SET(RCCOUNT,RCLINE,1,80)
 .   .   ;  receipt number
 .   .   D SET($P(RECDATA,"^"),RCLINE,6,18)
 .   .   ;  transaction number
 .   .   D SET($J(RCTRANDA,5),RCLINE,18,24)
 .   .   ;  unapplied deposit number
 .   .   D SET($J($$GETUNAPP^RCXFMSCR(RCRECTDA,RCTRANDA,0),13),RCLINE,26,39)
 .   .   ;  receipt status
 .   .   D SET($E($S($P(RECDATA,"^",14):"OPEN",1:"CLOSED"),1,4),RCLINE,41,44)
 .   .   ;  payment date
 .   .   D SET($E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3),RCLINE,47,54)
 .   .   ;  get type of payment
 .   .   S TYPE=$S($P(RECDATA,U,18)&$P(RECDATA,U,17):"TRACE",1:"") ;EFT/ERA payment
 .   .   I TYPE="" D
 .   .   .   S TYPE=$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",4)
 .   .   .   S TYPE=$S(TYPE=1:"CASH",TYPE=2:"CHECK",TYPE=3:"CREDIT",1:"")
 .   .   I TYPE="" S TYPE=$P($G(^RC(341.1,+$P(RECDATA,"^",4),0)),"^")
 .   .   D SET(TYPE,RCLINE,57,60)
 .   .   ;  get check, trace, credit #, RCFCHECK RCFTRACE and RCFCREDT
 .   .   ;  can be used to match a specific check, trace or credit card #
 .   .   ;  the variable is in the form:
 .   .   ;  RCFCHECK=number^EXACT  or  number^CONTAINS
 .   .   I $G(RCFCHECK)'="",$E(TYPE,1,5)'="CHECK" Q
 .   .   I $G(RCFTRACE)'="",$E(TYPE,1,5)'="TRACE" Q
 .   .   I $G(RCFCREDT)'="",$E(TYPE,1,6)'="CREDIT" Q
 .   .   S NUMBER=""
 .   .   I $E(TYPE,1,5)="CHECK" D  Q:NUMBER=""
 .   .   .   S NUMBER=$P(RCDATA,"^",7)
 .   .   .   I $G(RCFCHECK)'="",NUMBER="" Q
 .   .   .   I $E($P($G(RCFCHECK),"^",2))="E",NUMBER'=$P(RCFCHECK,"^") S NUMBER="" Q
 .   .   .   I $E($P($G(RCFCHECK),"^",2))="C",NUMBER'[$P(RCFCHECK,"^") S NUMBER="" Q
 .   .   .   I NUMBER="" S NUMBER=" "
 .   .   I $E(TYPE,1,5)="TRACE" D  Q:NUMBER=""
 .   .   .   S NUMBER=$P($G(^RCY(344.4,+$P(RECDATA,U,18),0)),U,2)
 .   .   .   I $G(RCFTRACE)'="",NUMBER="" Q
 .   .   .   I $E($P($G(RCFTRACE),"^",2))="E",NUMBER'=$P(RCFTRACE,"^") S NUMBER="" Q
 .   .   .   I $E($P($G(RCFTRACE),"^",2))="C",NUMBER'[$P(RCFTRACE,"^") S NUMBER="" Q
 .   .   .   I NUMBER="" S NUMBER=" "
 .   .   I $E(TYPE,1,6)="CREDIT" D  Q:NUMBER=""
 .   .   .   S NUMBER=$P(RCDATA,"^",11)
 .   .   .   I $G(RCFCHECK)'="",NUMBER="" Q
 .   .   .   I $E($P($G(RCFCREDT),"^",2))="E",NUMBER'=$P(RCFCREDT,"^") S NUMBER="" Q
 .   .   .   I $E($P($G(RCFCREDT),"^",2))="C",NUMBER'[$P(RCFCREDT,"^") S NUMBER="" Q
 .   .   .   I NUMBER="" S NUMBER=" "
 .   .   I NUMBER="" S NUMBER=" "
 .   .   S %=$L(NUMBER) I %>8 S NUMBER=$E(NUMBER,%-7,%)
 .   .   ;  check/trace/credit# (last 8 chars)
 .   .   D SET(NUMBER,RCLINE,62,69)
 .   .   ;  amount paid
 .   .   D SET($J($P(RCDATA,"^",4),10,2),RCLINE,70,80)
 .   .   ;  since list manager adds spaces to line, make sure line is
 .   .   ;  80 characters so the print list looks okay
 .   .   S ^TMP("RCDPLPLM",$J,RCLINE,0)=$E(^TMP("RCDPLPLM",$J,RCLINE,0),1,80)
 .   .   S RCTOTAL=$G(RCTOTAL)+$P(RCDATA,"^",4)
 .   .   ;
 .   .   ;  show line 2
 .   .   ;  account lookup
 .   .   S RCLINE=RCLINE+1
 .   .   S %=$E("AcctLU: "_$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^")_"                        ",1,24)
 .   .   D SET("                 "_%,RCLINE,1,80)
 .   .   ;  fms cr document
 .   .   S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 .   .   D SET($E("CRdoc: "_$P(FMSDOC,"^")_"               ",1,22),RCLINE,41,80)
 .   .   ;  cr document status
 .   .   D SET($P(FMSDOC,"^",2),RCLINE,63,68)
 .   .   ;  make second line longer than 80 characters for printing
 .   .   ;  this will add an extra line after each entry
 .   .   D SET("    ",RCLINE,80,84)
 ;
 S RCLINE=RCLINE+1 D SET("----------",RCLINE,70,80)
 S RCLINE=RCLINE+1 D SET("TOTAL: "_$J($G(RCTOTAL),10,2),RCLINE,63,80)
 ;
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 D HDR
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND) ;  set array
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 Q
 ;
 ;
HDR ;  header code for list manager display
 S VALMHDR(1)="Transactions for ALL Unapplied Payments"
 I $G(RCDPPADT)>0 S Y=RCDPPADT D DD^%DT S VALMHDR(1)="Transactions for Unapplied Payments After "_Y
 S VALMHDR(2)=" "
 I $G(RCFCHECK)'="" S VALMHDR(2)="  List of Payments With Check Numbers "_$P(RCFCHECK,"^",2)_" "_$P(RCFCHECK,"^")
 I $G(RCFTRACE)'="" S VALMHDR(2)="  List of Payments With Trace Numbers "_$P(RCFTRACE,"^",2)_" "_$P(RCFTRACE,"^")
 I $G(RCFCREDT)'="" S VALMHDR(2)="  List of Payments With Credit Cards "_$P(RCFCREDT,"^",2)_" "_$P(RCFCREDT,"^")
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCDPLPLM",$J),^TMP("RCDPLPLMUNLINK",$J)
 Q

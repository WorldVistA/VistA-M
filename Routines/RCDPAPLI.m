RCDPAPLI ;WISC/RFJ-account profile top list manager init ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,141,241**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
INIT ;  init for list manager screen
 N DMCDATA,RCBILLDA,RCCOMM,RCDATA,RCDATE,RCLINE,RCSTATDA,RCTOTAL
 N TOP4,TOP6
 K ^TMP("RCDPAPLM",$J),^TMP("RCDPAPLMX",$J),^TMP("VALM VIDEO",$J)
 ;
 ;  fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 ;
 I '$G(RCDEBTDA) D  Q
 .   D SET("",1,1,80)
 .   D SET("*****  Select an ACCOUNT  *****",2,1,80)
 .   S VALMCNT=2
 .   D HDR^RCDPAPLM
 ;
 ;  get bills for a debtor
 D GETBILLS^RCDPAPST(RCDEBTDA)
 ;
 I '$O(^TMP("RCDPAPST",$J,0)) D  Q
 .   D SET("",1,1,80,IORVOFF,IORVOFF)
 .   D SET("  *****  Account does not have any bills *****",2,1,80)
 .   S VALMCNT=2
 .   S RCTOTAL(1)=0
 .   D HDR^RCDPAPLM
 ;
 ;  set the listmanager line number
 S RCLINE=0
 ;
 S RCDATE=9999999 F  S RCDATE=$O(^TMP("RCDPAPST",$J,RCDATE),-1) Q:'RCDATE  D
 .   S RCSTATDA=0 F  S RCSTATDA=$O(^TMP("RCDPAPST",$J,RCDATE,RCSTATDA)) Q:'RCSTATDA  D
 .   .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCDPAPST",$J,RCDATE,RCSTATDA,RCBILLDA)) Q:'RCBILLDA  D
 .   .   .   S RCDATA=^TMP("RCDPAPST",$J,RCDATE,RCSTATDA,RCBILLDA)
 .   .   .   ;  add up dollars owed by account (all bills)
 .   .   .   S RCTOTAL(1)=$G(RCTOTAL(1))+$P(RCDATA,"^")
 .   .   .   S RCTOTAL(2)=$G(RCTOTAL(2))+$P(RCDATA,"^",2)
 .   .   .   S RCTOTAL(3)=$G(RCTOTAL(3))+$P(RCDATA,"^",3)
 .   .   .   ;
 .   .   .   ;  if not a selected status, do not display
 .   .   .   I ("^"_$G(^DISV(DUZ,"RCDPAPLM","STATUS"))_"^")'[("^"_RCSTATDA_"^") Q
 .   .   .   ;
 .   .   .   ;  display the bill in listmanager if the status selected
 .   .   .   D SETBILL
 .   .   .   ;
 .   .   .   ;  add up dollars owed by account (bills displayed)
 .   .   .   S RCTOTAL(4)=$G(RCTOTAL(4))+$P(RCDATA,"^")
 .   .   .   S RCTOTAL(5)=$G(RCTOTAL(5))+$P(RCDATA,"^",2)
 .   .   .   S RCTOTAL(6)=$G(RCTOTAL(6))+$P(RCDATA,"^",3)
 ;
 ;  show totals of all bills displayed in listmanager
 S RCLINE=RCLINE+1
 D SET("                                                    --------- -------- --------",RCLINE,1,80)
 S RCLINE=RCLINE+1
 D SET("   TOTAL BALANCE OWED FOR ALL BILLS DISPLAYED",RCLINE,1,80)
 D SET($J($G(RCTOTAL(4)),9,2),RCLINE,53,62)
 D SET($J($G(RCTOTAL(5)),9,2),RCLINE,62,71)
 D SET($J($G(RCTOTAL(6)),9,2),RCLINE,71,80)
 ;
 ;  get the pending payments for the debtor
 S RCTOTAL("PP")=$$PENDPAY^RCDPURET($P(^RCD(340,RCDEBTDA,0),"^"))
 I $O(^TMP($J,"RCDPUREC","PP",0)) D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET("Pending Payments",RCLINE,1,80,0,IORVON,IORVOFF)
 .   N %,DATA,DATE,RECEIPT,RECTDA,TRANDA,TYPE
 .   S RECTDA=0 F  S RECTDA=$O(^TMP($J,"RCDPUREC","PP",RECTDA)) Q:'RECTDA  D
 .   .   S RECEIPT=$P($G(^RCY(344,RECTDA,0)),"^")
 .   .   S TYPE=$E($P($G(^RC(341.1,+$P(^RCY(344,RECTDA,0),"^",4),0)),"^"),1,14)
 .   .   S TRANDA=0 F  S TRANDA=$O(^TMP($J,"RCDPUREC","PP",RECTDA,TRANDA)) Q:'TRANDA  D
 .   .   .   S DATA=^TMP($J,"RCDPUREC","PP",RECTDA,TRANDA)
 .   .   .   S RCLINE=RCLINE+1
 .   .   .   D SET(RECEIPT_"/"_TRANDA,RCLINE,1,80)
 .   .   .   S DATE=$P(DATA,"^",6)
 .   .   .   S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 .   .   .   D SET(DATE,RCLINE,13,21)
 .   .   .   ;  build type of payment display
 .   .   .   S %=$E(TYPE_"              ",1,14)
 .   .   .   I $P(DATA,"^",7)'="" S %=%_"/"_$P(DATA,"^",7)  ;  check #
 .   .   .   I $P(DATA,"^",8)'="" S %=%_"/"_$P(DATA,"^",8)  ;  bank #
 .   .   .   I $P(DATA,"^",2)'="" S %=%_"/"_$P(DATA,"^",2)  ;  confirmation
 .   .   .   D SET(%,RCLINE,29,53)
 .   .   .   ;  show amount paid
 .   .   .   D SET($J($P(DATA,"^",4),9,2),RCLINE,53,62)
 .   S RCLINE=RCLINE+1
 .   D SET("                                                    ---------",RCLINE,1,80)
 .   S RCLINE=RCLINE+1
 .   D SET("   TOTAL PENDING PAYMENTS",RCLINE,1,80)
 .   D SET($J($G(RCTOTAL("PP")),9,2),RCLINE,53,62)
 .   K ^TMP($J,"RCDPUREC","PP")
 ;
 ;  dmc info
 I $D(^RCD(340,"DMC",1,+RCDEBTDA)) D
 .   S DMCDATA=$G(^RCD(340,+RCDEBTDA,3))
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1
 .   D SET("** Account forwarded to DMC: "_$S('$P(DMCDATA,"^",2):"",1:$$SLH^RCFN01($P(DMCDATA,"^",2))),RCLINE,1,80)
 .   D SET("Total DMC Amount: "_$J($P(DMCDATA,"^",5),9,2),RCLINE,50,80)
 .   I $P(DMCDATA,"^",9)'="" D
 .   .   S RCLINE=RCLINE+1
 .   .   D SET(" ",RCLINE,1,80)
 .   .   D SET("Lesser Amt to DMC: "_$J($P(DMCDATA,"^",9),9,2),RCLINE,49,80)
 ;   top info
 I $D(^RCD(340,"TOP",+RCDEBTDA)) D
 .   S TOP6=$G(^RCD(340,+RCDEBTDA,6)),TOP4=$G(^(4))
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1
 .   D SET("** Account forwarded to TOP: "_$S('$P(TOP6,"^"):"",1:$$SLH^RCFN01($P(TOP6,"^"))),RCLINE,1,80)
 .   D SET("Total TOP Amount: "_$J($P(TOP4,"^",3),13,2),RCLINE,45,80)
 .   I $P(TOP6,"^",6)'="" D
 .   .   S RCLINE=RCLINE+1
 .   .   D SET(" ",RCLINE,1,80)
 .   .   D SET("TOP Hold Date: "_$$SLH^RCFN01($P(TOP6,"^",6)),RCLINE,45,80)
 ;
 ;  show if hurricane katrina vet
 I $P(^RCD(340,+RCDEBTDA,0),U)["DPT(" S DFN=+^(0) D
 .   Q:$$EMGRES^DGUTL(DFN)'["K"
 .   S RCLINE=RCLINE+1
 .   D SET("EMERGENCY RESPONSE INDICATOR: HURRICANE KATRINA",RCLINE,1,80)
 ;
 ;  show comments if they exist
 I $O(^RCD(340,RCDEBTDA,2,0)) D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET("Comments",RCLINE,1,80,0,IOUON,IOUOFF)
 .   S RCCOMM=0 F  S RCCOMM=$O(^RCD(340,RCDEBTDA,2,RCCOMM)) Q:'RCCOMM  D
 .   .   S RCLINE=RCLINE+1 D SET(^RCD(340,RCDEBTDA,2,RCCOMM,0),RCLINE,1,80)
 ;
 K ^TMP("RCDPAPST",$J)
 ;
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 D HDR^RCDPAPLM
 Q
 ;
 ;
SETBILL ;  set a bill on the listmanager line
 N DATE,IBCNDATA,RCDPDATA,VALUE
 D DIQ430^RCDPBPLM(RCBILLDA,".01;2;3;8;60;")
 ;
 S RCLINE=RCLINE+1
 ;
 ;  create an index array for bill lookup in list
 S ^TMP("RCDPAPLM",$J,"IDX",RCLINE,RCLINE)=RCBILLDA
 ;
 ;  bill number
 D SET(RCLINE,RCLINE,1,80,0,IORVON,IORVOFF)
 D SET($E($P(RCDPDATA(430,RCBILLDA,.01,"E"),"-",2)_"       ",1,7),RCLINE,4,10,0)
 ;
 ;  get date of care
 D DIQ399^RCXFMSUR(RCBILLDA)
 S DATE=$G(IBCNDATA(399,RCBILLDA,151,"I"))
 I 'DATE S DATE=$G(RCDPDATA(430,RCBILLDA,60,"I"))
 S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 D SET(DATE,RCLINE,13,21,0)
 ;
 ;  status (field 8)
 D SET("",RCLINE,23,26,8)
 ;
 ;  type of care
 D SET("",RCLINE,29,71,2)
 ;
 ;  principle, interest, admin
 D SET($J($P(RCDATA,"^"),9,2),RCLINE,53,62,0)
 D SET($J($P(RCDATA,"^",2),9,2),RCLINE,62,71,0)
 D SET($J($P(RCDATA,"^",3),9,2),RCLINE,71,80,0)
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_$S(STRING="":"",1:": ")_$G(RCDPDATA(430,RCBILLDA,FIELD,"E"))
 I STRING="",'$G(FIELD) D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q

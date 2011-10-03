RCDPBPLM ;WISC/RFJ - bill profile ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,153,159,241**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;  called from menu option (19)
 ;
 N RCBILLDA,RCDPFXIT
 ;
 F  D  Q:'RCBILLDA
 .   W !! S RCBILLDA=$$SELBILL^RCDPBTLM
 .   I RCBILLDA<1 S RCBILLDA=0 Q
 .   D EN^VALM("RCDP BILL PROFILE")
 .   ;  fast exit
 .   I $G(RCDPFXIT) S RCBILLDA=0
 Q
 ;
 ;
INIT ;  initialization for list manager list
 ;  requires rcbillda
 N BILLED,COMMDA,DATA,PAID,RCDPDATA,RCFYDA,RCLINE,REPTYPE,X1,X2,RCDEBTOR,DFN
 K ^TMP("RCDPBPLM",$J),^TMP("VALM VIDEO",$J)
 ;
 ;  fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 ;
 D DIQ430(RCBILLDA,".01:300")
 ;
 ;  set the listmanager line number
 S RCLINE=0
 ;
 S DATA=$$ACCNTHDR^RCDPAPLM(RCDPDATA(430,RCBILLDA,9,"I"))
 S RCLINE=RCLINE+1 D SET("Account: "_$P(DATA,"^")_" "_$P(DATA,"^",2),RCLINE,1,80)
 D SET($P(DATA,"^",3),RCLINE,60,80)
 S %="" I $TR($P(DATA,"^",4,9),"^")'="" S %=$P(DATA,"^",4)_", "_$P(DATA,"^",7)_", "_$P(DATA,"^",8)_"  "_$P(DATA,"^",9)
 S RCLINE=RCLINE+1 D SET("   Addr: "_%,RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("  Phone: "_$P(DATA,"^",10),RCLINE,1,80)
 S RCDEBTOR=$P(^PRCA(430,RCBILLDA,0),U,9)
 I $P(^RCD(340,+RCDEBTOR,0),U)["DPT(" S DFN=+^(0) D
 .   Q:$$EMGRES^DGUTL(DFN)'["K"
 .   S RCLINE=RCLINE+1
 .   D SET("EMERGENCY RESPONSE INDICATOR: HURRICANE KATRINA",RCLINE,1,80)
 ;
 ;  bill descriptive data
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Bill Number",RCLINE,1,80,.01,IOUON,IOUOFF)
 D SET("Category",RCLINE,40,80,2)
 S RCLINE=RCLINE+1 D SET("Date  Prepared",RCLINE,1,80,10)
 D SET("Status",RCLINE,42,80,8)
 S RCLINE=RCLINE+1 D SET("Date Activated",RCLINE,1,80,60)
 S RCLINE=RCLINE+1 D SET("Date Status Up",RCLINE,1,80,14)
 D SET("By",RCLINE,46,80,17)
 ;display TP bills Division of Care
 I "T"=$P($G(^PRCA(430.2,+RCDPDATA(430,RCBILLDA,2,"I"),0)),"^",6) D
 .S RCDIV=$$DIV^IBJDF2(RCBILLDA) I +RCDIV D
 ..S RCDIV=$P($G(^DG(40.8,RCDIV,0)),U,1) I RCDIV="" Q
 ..S RCLINE=RCLINE+1 D SET("Division of Care: "_RCDIV,RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Resulting From",RCLINE,1,80,4.5)
 I RCDPDATA(430,RCBILLDA,15.1,"E")'="" D
 .   S RCLINE=RCLINE+1 D SET("  Type of Care",RCLINE,1,80,15.1)
 S RCLINE=RCLINE+1 D SET("        Remark",RCLINE,1,80,15)
 ;  display comments if there
 I $O(^PRCA(430,RCBILLDA,10,0)) D
 .   S RCLINE=RCLINE+1 D SET("Comments:",RCLINE,1,80)
 .   S COMMDA=0 F  S COMMDA=$O(^PRCA(430,RCBILLDA,10,COMMDA)) Q:'COMMDA  D
 .   .   S RCLINE=RCLINE+1 D SET("  "_$G(^PRCA(430,RCBILLDA,10,COMMDA,0)),RCLINE,1,80)
 ;
 ;  int/adm rate and date
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S DATA=$$INT^RCMSFN01(RCDPDATA(430,RCBILLDA,10,"I"))
 S Y=$P(DATA,"^",2) I Y D DD^%DT
 S RCLINE=RCLINE+1 D SET("Interest Effective Rate Date: "_Y,RCLINE,1,80)
 D SET(" Annual Rate: "_$P(DATA,"^"),RCLINE,55,80)
 S DATA=$$ADM^RCMSFN01(RCDPDATA(430,RCBILLDA,10,"I"))
 S Y=$P(DATA,"^",2) I Y D DD^%DT
 S RCLINE=RCLINE+1 D SET("   Admin Effective Rate Date: "_Y,RCLINE,1,80)
 D SET("Monthly Rate: "_$P(DATA,"^"),RCLINE,55,80)
 S RCLINE=RCLINE+1 D SET("  Last Int/Admin Charge Date",RCLINE,1,80,67)
 ;
 ;  put bill balances on first line of second screen
 F RCLINE=RCLINE+1:1:16 D SET(" ",RCLINE,1,80)
 ;
 ;  bill dollars
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Bill Balances           Billed          Paid",RCLINE,1,80,0,IOUON,IOUOFF)
 S RCLINE=RCLINE+1 D SET("     Principal: "_$J(RCDPDATA(430,RCBILLDA,71,"E"),14,2)_$J(RCDPDATA(430,RCBILLDA,77,"E"),14,2),RCLINE,1,80)
 D SET("       Original Amt: "_$J(RCDPDATA(430,RCBILLDA,3,"E"),11,2),RCLINE,48,80)
 S RCLINE=RCLINE+1 D SET("      Interest: "_$J(RCDPDATA(430,RCBILLDA,72,"E"),14,2)_$J(RCDPDATA(430,RCBILLDA,78,"E"),14,2),RCLINE,1,80)
 I $G(RCDPDATA(430,RCBILLDA,131,"E")) D SET("Medicare Contr  Adj: "_$J(RCDPDATA(430,RCBILLDA,131,"E"),11,2),RCLINE,48,80)
 I RCDPDATA(430,RCBILLDA,74,"E") D
 .   S RCLINE=RCLINE+1 D SET("  Marshall Fee: "_$J(RCDPDATA(430,RCBILLDA,74,"E"),14,2)_$J(RCDPDATA(430,RCBILLDA,79.1,"E"),14,2),RCLINE,1,80)
 I RCDPDATA(430,RCBILLDA,75,"E") D
 .   S RCLINE=RCLINE+1 D SET("    Court Cost: "_$J(RCDPDATA(430,RCBILLDA,75,"E"),14,2),RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Administrative: "_$J(RCDPDATA(430,RCBILLDA,73,"E"),14,2)_$J(RCDPDATA(430,RCBILLDA,79,"E"),14,2),RCLINE,1,80,0,IOUON,IOUOFF)
 I $G(RCDPDATA(430,RCBILLDA,132,"E")) D SET("Medicare Unreim Exp: "_$J(RCDPDATA(430,RCBILLDA,132,"E"),11,2),RCLINE,48,80)
 ;  compute totals
 S BILLED=0 F %=71,72,73,74,75 S BILLED=BILLED+RCDPDATA(430,RCBILLDA,%,"E")
 S PAID=0 F %=77,78,79,79.1 S PAID=PAID+RCDPDATA(430,RCBILLDA,%,"E")
 S RCLINE=RCLINE+1 D SET("       Current: "_$J(BILLED,14,2)_$J(PAID,14,2),RCLINE,1,80)
 ;
 ;  show refund if there
 I RCDPDATA(430,RCBILLDA,79.18,"E") D
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET("Refunded Amount",RCLINE,1,80,79.18)
 .   D SET("Date",RCLINE,27,80,79.19)
 .   D SET("By",RCLINE,50,80,79.21)
 ;
 ;  accounting data
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Accounting Data",RCLINE,1,80,0,IOUON,IOUOFF)
 ;  fiscal year multiple
 D SET("Fiscal Year",RCLINE,20,32,0,IOUON,IOUOFF)
 D SET("Approp Code",RCLINE,34,46,0,IOUON,IOUOFF)
 D SET("Amount",RCLINE,50,60,0,IOUON,IOUOFF)
 S RCFYDA=0 F  S RCFYDA=$O(^PRCA(430,RCBILLDA,2,RCFYDA)) Q:'RCFYDA  D
 .   S DATA=$G(^PRCA(430,RCBILLDA,2,RCFYDA,0))
 .   S RCLINE=RCLINE+1
 .   D SET($J($P(DATA,"^"),30),RCLINE,1,80)     ;fiscal year
 .   D SET($J(RCDPDATA(430,RCBILLDA,203,"E"),6),RCLINE,39,45) ;fund
 .   D SET($J($P(DATA,"^",2),8,2),RCLINE,48,80)   ;amount
 ;  determine which rsc to display
 S %=RCDPDATA(430,RCBILLDA,255.1,"E") I %="" S %=RCDPDATA(430,RCBILLDA,255,"E")
 S RCLINE=RCLINE+1 D SET("Rev Srce Code: "_%,RCLINE,1,80)
 ;
 ;  collection data
 S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 S RCLINE=RCLINE+1 D SET("Collection Follow up Data",RCLINE,1,80,0,IOUON,IOUOFF)
 S RCLINE=RCLINE+1 D SET("        Letter1",RCLINE,1,80,61)
 S RCLINE=RCLINE+1 D SET("        Letter2",RCLINE,1,80,62)
 S RCLINE=RCLINE+1 D SET("        Letter3",RCLINE,1,80,63)
 S RCLINE=RCLINE+1 D SET("        Letter4",RCLINE,1,80,68)
 I RCDPDATA(430,RCBILLDA,68.6,"I") D
 .   S RCLINE=RCLINE+1 D SET("     IRS Letter",RCLINE,1,80,68.6)
 .   D SET("Amount",RCLINE,65,80,68.93)
 I RCDPDATA(430,RCBILLDA,64,"I") D
 .   S RCLINE=RCLINE+1 D SET("DC/DOJ Ref Date",RCLINE,1,80,64)
 .   D SET("To",RCLINE,40,80,65)
 .   D SET("Amount",RCLINE,65,80,66)
 ;
 ;  repayment plan (show only if there)
 I RCDPDATA(430,RCBILLDA,41,"I") D REPAY^RCDPBPLI
 ;
 ;  irs data (show only if there)
 I RCDPDATA(430,RCBILLDA,68.7,"I") D IRS^RCDPBPLI
 ;
 ;  dmc data (show only if there)
 I RCDPDATA(430,RCBILLDA,121,"I") D DMC^RCDPBPLI
 ;
 ;  top data (show only if there)
 I $G(RCDPDATA(430,RCBILLDA,141,"I")) D TOP^RCDPBPLI
 ;
 ;  get the report type based on category.  if third party show
 ;  insurance data
 S REPTYPE=$P($G(^PRCA(430.2,+RCDPDATA(430,RCBILLDA,2,"I"),0)),"^",6)
 I REPTYPE="T" D INSUR^RCDPBPLI
 ;
 ;  report type for employee or vendor, show description field 106
 I REPTYPE="O"!(REPTYPE="V") D INIT^RCDPBPLI
 ;
 ;  show transactions and reasons
 D TRANINIT^RCDPBPLI
 ;
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 D HDR
 Q
 ;
 ;
HDR ;  header code for list manager display
 ;  requires rcbillda
 S VALMHDR(1)="***** ACCOUNTS RECEIVABLE BILL PROFILE FOR "_$P($G(^PRCA(430,RCBILLDA,0)),"^")_" *****"
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCDPBPLM",$J)
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_$S(STRING="":"",1:": ")_$G(RCDPDATA(430,RCBILLDA,FIELD,"E"))
 I STRING="",'$G(FIELD) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q
 ;
 ;
DIQ430(DA,DR) ;  diq call to retrieve data for dr fields in file 430
 N D0,DIC,DIQ,DIQ2
 K RCDPDATA(430,DA)
 S DIQ(0)="IE",DIC="^PRCA(430,",DIQ="RCDPDATA" D EN^DIQ1
 Q

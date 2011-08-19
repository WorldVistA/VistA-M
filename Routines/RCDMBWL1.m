RCDMBWL1 ;WISC/RFJ-diagnostic measures workload report (to clerk) ;1 Jan 01
 ;;4.5;Accounts Receivable;**167**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
REPORT ;  called by RCDMBWLR to generate the report
 N %,DATA,RCASSIGN,RCBALANC,RCBILLDA,RCCLERK,RCCOUNT,RCDATA,RCDATA0,RCDATE,RCDEBTDA,RCDESC,RCLINE,RCNAME,RCPREFIX,RCTMPDAT,RCTODAY,X,XMDUN,XMY,XMZ,Y
 D NOW^%DTC S Y=X D DD^%DT S RCTODAY=Y,RCTODAY=$$DOW^XLFDT(X)_" "_RCTODAY
 ;
 K ^TMP("RCDMBWL1",$J)  ;used for supervisor report
 ;
 ;  generate mailmessage with assignments for user
 S RCCLERK=0 F  S RCCLERK=$O(^TMP("RCDMBWLR",$J,RCCLERK)) Q:'RCCLERK  D
 .   ;  initialize counts for summary of all assignments for each clerk
 .   S RCCOUNT("clbills")=0
 .   S RCCOUNT("clbillstotal")=0
 .   S RCCOUNT("death")=0
 .   S RCCOUNT("deathtotal")=0
 .   S RCCOUNT("dmc")=0
 .   S RCCOUNT("dmctotal")=0
 .   S RCCOUNT("top")=0
 .   S RCCOUNT("toptotal")=0
 .   S RCCOUNT("repay")=0
 .   S RCCOUNT("repaytotal")=0
 .   S RCCOUNT("default")=0
 .   S RCCOUNT("defaulttotal")=0
 .   ;  show heading at top of mailman message
 .   K ^TMP($J,"RCRJRCORMM")
 .   S RCLINE=0
 .   D BUILDMM("The following mailman message is your Accounts Receivable assignment list.")
 .   D BUILDMM("                       "_RCTODAY_".")
 .   D BUILDMM(" ")
 .   ;
 .   S RCASSIGN=0 F  S RCASSIGN=$O(^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN)) Q:'RCASSIGN  D
 .   .   D BUILDMM(" ")
 .   .   ;  show the assignment number
 .   .   D BUILDMM("ASSIGNMENT #: "_$E(RCASSIGN_"     ",1,5))
 .   .   ;  show the condition of the assignment
 .   .   S RCDATA="   CONDITION: IF "
 .   .   ;  print conditions [condition 1][condition 2][...]
 .   .   S RCDESC=$G(^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"DESC"))
 .   .   F %=2:1 D  I DATA="" Q
 .   .   .   S DATA=$P($P(RCDESC,"[",%),"]")
 .   .   .   I DATA="" Q
 .   .   .   D BUILDMM($S(RCDATA'="":RCDATA,1:"             and ")_DATA)
 .   .   .   ;  do not show "condition: if" more than once
 .   .   .   S RCDATA=""
 .   .   ;
 .   .   ;  show header for bills
 .   .   D BUILDMM("ACCOUNT                 BILL#    CATEGORY         ACTIVATE          "_$J("BALANCE",10))
 .   .   D BUILDMM("------------------------------------------------------------------------------")
 .   .   ;
 .   .   ;  show the bills under the assignment
 .   .   ;  loop the debtor first
 .   .   S RCCOUNT("bills")=0
 .   .   S RCCOUNT("billstotal")=0
 .   .   S RCNAME="" F  S RCNAME=$O(^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF",RCNAME)) Q:RCNAME=""  D
 .   .   .   S RCDEBTDA="" F  S RCDEBTDA=$O(^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF",RCNAME,RCDEBTDA)) Q:'RCDEBTDA  D
 .   .   .   .   ;  start looping bills under the assignment
 .   .   .   .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF",RCNAME,RCDEBTDA,RCBILLDA)) Q:'RCBILLDA  D
 .   .   .   .   .   ;  get the data in tmp global
 .   .   .   .   .   ;    = ssn ^ 1 for death ^ bill balance
 .   .   .   .   .   S RCTMPDAT=^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF",RCNAME,RCDEBTDA,RCBILLDA)
 .   .   .   .   .   ;
 .   .   .   .   .   ;  generate prefix codes
 .   .   .   .   .   S RCPREFIX=""
 .   .   .   .   .   ;  test for account death
 .   .   .   .   .   I $P(RCTMPDAT,"^",2) S RCPREFIX="*"
 .   .   .   .   .   ;
 .   .   .   .   .   ;  test for bill sent to DMC
 .   .   .   .   .   I $G(^PRCA(430,RCBILLDA,12)) S RCPREFIX=RCPREFIX_"d"
 .   .   .   .   .   ;
 .   .   .   .   .   ;  test for bill sent to TOP
 .   .   .   .   .   I $G(^PRCA(430,RCBILLDA,14)) S RCPREFIX=RCPREFIX_"t"
 .   .   .   .   .   ;
 .   .   .   .   .   ;  test bill for repayment plan
 .   .   .   .   .   I $G(^PRCA(430,RCBILLDA,4)) S RCPREFIX=RCPREFIX_"r"
 .   .   .   .   .   ;  test for bill in default
 .   .   .   .   .   I RCPREFIX["r",$$REPAYDEF^RCBECHGA(RCBILLDA,DT) S RCPREFIX=$TR(RCPREFIX,"r","R")
 .   .   .   .   .   ;
 .   .   .   .   .   ;  start building line for mailman message
 .   .   .   .   .   S RCDATA0=$G(^PRCA(430,RCBILLDA,0))
 .   .   .   .   .   ;  prefix and account name
 .   .   .   .   .   S RCDATA=$E(RCPREFIX_$S(RCPREFIX'="":" ",1:"")_$S($P(RCTMPDAT,"^",4)'="":$E(RCNAME,1,8)_"/"_$E($P(RCTMPDAT,"^",4),1,7),1:RCNAME)_"                ",1,16)_"  "
 .   .   .   .   .   ;  account ssn (if applicable)
 .   .   .   .   .   S RCDATA=RCDATA_$P(RCTMPDAT,"^")_"  "
 .   .   .   .   .   ;  bill number
 .   .   .   .   .   S RCDATA=RCDATA_$E($P($P(RCDATA0,"^"),"-",2)_"       ",1,7)_"  "
 .   .   .   .   .   ;  category
 .   .   .   .   .   S RCDATA=RCDATA_$E($P($G(^PRCA(430.2,+$P(RCDATA0,"^",2),0)),"^")_"               ",1,15)_"  "
 .   .   .   .   .   ;  date bill activated
 .   .   .   .   .   S RCDATE=$P($G(^PRCA(430,RCBILLDA,6)),"^",21) I RCDATE="" S RCDATE="      "
 .   .   .   .   .   S RCDATA=RCDATA_$E(RCDATE,4,5)_"/"_$E(RCDATE,6,7)_"/"_$E(RCDATE,2,3)_"  "
 .   .   .   .   .   ;  bill balance
 .   .   .   .   .   S RCBALANC=$P(RCTMPDAT,"^",3)
 .   .   .   .   .   D BUILDMM(RCDATA_$J(RCBALANC,18,2))
 .   .   .   .   .   ;
 .   .   .   .   .   ;  calculate bill count totals for assignment
 .   .   .   .   .   S RCCOUNT("bills")=RCCOUNT("bills")+1
 .   .   .   .   .   S RCCOUNT("billstotal")=RCCOUNT("billstotal")+RCBALANC
 .   .   .   .   .   ;
 .   .   .   .   .   ;  death
 .   .   .   .   .   I RCPREFIX["*" D
 .   .   .   .   .   .   S RCCOUNT("death")=RCCOUNT("death")+1
 .   .   .   .   .   .   S RCCOUNT("deathtotal")=RCCOUNT("deathtotal")+RCBALANC
 .   .   .   .   .   ;
 .   .   .   .   .   ;  dmc
 .   .   .   .   .   I RCPREFIX["d" D
 .   .   .   .   .   .   S RCCOUNT("dmc")=RCCOUNT("dmc")+1
 .   .   .   .   .   .   S RCCOUNT("dmctotal")=RCCOUNT("dmctotal")+RCBALANC
 .   .   .   .   .   ;
 .   .   .   .   .   ;  top
 .   .   .   .   .   I RCPREFIX["t" D
 .   .   .   .   .   .   S RCCOUNT("top")=RCCOUNT("top")+1
 .   .   .   .   .   .   S RCCOUNT("toptotal")=RCCOUNT("toptotal")+RCBALANC
 .   .   .   .   .   ;
 .   .   .   .   .   ;  repayment plans
 .   .   .   .   .   I RCPREFIX["r" D
 .   .   .   .   .   .   S RCCOUNT("repay")=RCCOUNT("repay")+1
 .   .   .   .   .   .   S RCCOUNT("repaytotal")=RCCOUNT("repaytotal")+RCBALANC
 .   .   .   .   .   ;
 .   .   .   .   .   ;  default repayment plan
 .   .   .   .   .   I RCPREFIX["R" D
 .   .   .   .   .   .   S RCCOUNT("default")=RCCOUNT("default")+1
 .   .   .   .   .   .   S RCCOUNT("defaulttotal")=RCCOUNT("defaulttotal")+RCBALANC
 .   .   ;
 .   .   ;  show bill count
 .   .   D BUILDMM("    TOTAL BILL COUNT FOR ASSIGNMENT: "_$E(RCCOUNT("bills")_"          ",1,10)_$J(RCCOUNT("billstotal"),31,2))
 .   .   S RCCOUNT("clbills")=RCCOUNT("clbills")+RCCOUNT("bills")
 .   .   S RCCOUNT("clbillstotal")=RCCOUNT("clbillstotal")+RCCOUNT("billstotal")
 .   .   ;
 .   .   ;  build list for supervisor
 .   .   S RCCLERK("name")=$E($P($G(^VA(200,RCCLERK,0)),"^"),1,30) I RCCLERK("name")="" S RCCLERK("name")="[Not Specified]"
 .   .   S ^TMP("RCDMBWL1",$J,RCCLERK("name"),RCCLERK,RCASSIGN,"SUMM")=RCCOUNT("bills")_"^"_RCCOUNT("billstotal")
 .   .   S ^TMP("RCDMBWL1",$J,RCCLERK("name"),RCCLERK,RCASSIGN,"DESC")=RCDESC
 .   ;
 .   ;  summarize assignment list
 .   D BUILDMM(" ")
 .   D BUILDMM("SUMMARY OF ALL ASSIGNMENTS")
 .   D BUILDMM("--------------------------")
 .   D BUILDMM("ALL BILLS FOR ALL ASSIGNMENTS                COUNT: "_$J(RCCOUNT("clbills"),6)_"   TOTAL: "_$J(RCCOUNT("clbillstotal"),10,2))
 .   I RCCOUNT("death") D BUILDMM("*  indicates patient has expired             COUNT: "_$J(RCCOUNT("death"),6)_"   TOTAL: "_$J(RCCOUNT("deathtotal"),10,2))
 .   I RCCOUNT("dmc") D BUILDMM("d  indicates bill has been forwarded to DMC  COUNT: "_$J(RCCOUNT("dmc"),6)_"   TOTAL: "_$J(RCCOUNT("dmctotal"),10,2))
 .   I RCCOUNT("top") D BUILDMM("t  indicates bill has been forwarded to TOP  COUNT: "_$J(RCCOUNT("top"),6)_"   TOTAL: "_$J(RCCOUNT("toptotal"),10,2))
 .   I RCCOUNT("repay") D BUILDMM("r  indicates bill is under a repayment plan  COUNT: "_$J(RCCOUNT("repay"),6)_"   TOTAL: "_$J(RCCOUNT("repaytotal"),10,2))
 .   I RCCOUNT("default") D BUILDMM("R  indicates bill in default of repay plan   COUNT: "_$J(RCCOUNT("default"),6)_"   TOTAL: "_$J(RCCOUNT("defaulttotal"),10,2))
 .   ;
 .   ;  send mail message
 .   S XMY(RCCLERK)=""
 .   S XMZ=$$SENDMSG^RCRJRCOR("AR Assignment List for "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),.XMY)
 .   K ^TMP($J,"RCRJRCORMM")
 ;
 D REPORT^RCDMBWL2
 ;
 K ^TMP("RCDMBWL1",$J)
 Q
 ;
 ;
BUILDMM(DATA) ;  build mailman message
 S RCLINE=RCLINE+1
 S ^TMP($J,"RCRJRCORMM",RCLINE)=DATA
 Q

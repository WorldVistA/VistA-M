RCDMBWL2 ;WISC/RFJ-diagnostic measures workload report (to super) ;1 Jan 01
 ;;4.5;Accounts Receivable;**167,197**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
REPORT ;  called by RCDMBWLR to generate the report
 N %,DATA,RCASSIGN,RCCLERK,RCCOUNT,RCDATA,RCDESC,RCLINE,RCTMPDAT,RCTODAY,X,XMDUN,XMY,XMZ,Y,IBHOLDER
 D NOW^%DTC S Y=X D DD^%DT S RCTODAY=Y,RCTODAY=$$DOW^XLFDT(X)_" "_RCTODAY
 ;
 ;  initialize counts for summary of all assignments
 S RCCOUNT("allbills")=0
 S RCCOUNT("allbillstotal")=0
 ;
 ;  generate mailmessage to each supervisor
 ;  show heading at top of mailman message
 K ^TMP($J,"RCRJRCORMM")
 ;  don't send supervisor message if no to-do lists generated
 I '$D(^TMP("RCDMBWL1",$J)) Q
 S RCLINE=0
 D BUILDMM("The following mailman message is your Accounts Receivable supervisor list.")
 D BUILDMM("                       "_RCTODAY_".")
 D BUILDMM(" ")
 ;
 S RCCLERK("name")="" F  S RCCLERK("name")=$O(^TMP("RCDMBWL1",$J,RCCLERK("name"))) Q:RCCLERK("name")=""  D
 .   S RCCLERK=0 F  S RCCLERK=$O(^TMP("RCDMBWL1",$J,RCCLERK("name"),RCCLERK)) Q:'RCCLERK  D
 .   .   S RCASSIGN=0 F  S RCASSIGN=$O(^TMP("RCDMBWL1",$J,RCCLERK("name"),RCCLERK,RCASSIGN)) Q:'RCASSIGN  D
 .   .   .   S RCTMPDAT=^TMP("RCDMBWL1",$J,RCCLERK("name"),RCCLERK,RCASSIGN,"SUMM")
 .   .   .   D BUILDMM(" ")
 .   .   .   D BUILDMM("CLERK: "_$E(RCCLERK("name")_"                    ",1,20)_"  ASSIGN #: "_$E(RCASSIGN_"     ",1,5)_"COUNT: "_$J($P(RCTMPDAT,"^"),6)_"  TOTAL: "_$J($P(RCTMPDAT,"^",2),10,2))
 .   .   .   ;  show the condition of the assignment
 .   .   .   S RCDATA="   CONDITION: IF "
 .   .   .   ;  print conditions [condition 1][condition 2][...]
 .   .   .   S RCDESC=^TMP("RCDMBWL1",$J,RCCLERK("name"),RCCLERK,RCASSIGN,"DESC")
 .   .   .   F %=2:1 D  I DATA="" Q
 .   .   .   .   S DATA=$P($P(RCDESC,"[",%),"]")
 .   .   .   .   I DATA="" Q
 .   .   .   .   D BUILDMM($S(RCDATA'="":RCDATA,1:"             and ")_DATA)
 .   .   .   .   ;  do not show "condition: if" more than once
 .   .   .   .   S RCDATA=""
 .   .   .   ;
 .   .   .   ;  total all bills
 .   .   .   S RCCOUNT("allbills")=RCCOUNT("allbills")+$P(RCTMPDAT,"^")
 .   .   .   S RCCOUNT("allbillstotal")=RCCOUNT("allbillstotal")+$P(RCTMPDAT,"^",2)
 ;
 ;  show bill count for all clerks
 D BUILDMM(" ")
 D BUILDMM("TOTAL BILL COUNT   FOR ALL CLERKS: "_RCCOUNT("allbills"))
 D BUILDMM("TOTAL BILL DOLLARS FOR ALL CLERKS: "_$J(RCCOUNT("allbillstotal"),0,2))
 ;
 ;  send mail message ; extrinsic function needs to be outside the
 ;  dot structure so that only 1 mailman message is generated and
 ;  sent to all recipients of the IBJD Workload Assignment key.
 S IBHOLDER=0 F  S IBHOLDER=$O(^XUSEC("IBJD WORKLOAD ASSIGNMENT",IBHOLDER)) Q:'IBHOLDER  D
 .    S XMY(IBHOLDER)=""
 S XMZ=$$SENDMSG^RCRJRCOR("AR Supervisor List for "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),.XMY)
 K ^TMP($J,"RCRJRCORMM")
 Q
 ;
 ;
BUILDMM(DATA) ;  build mailman message
 S RCLINE=RCLINE+1
 S ^TMP($J,"RCRJRCORMM",RCLINE)=DATA
 Q

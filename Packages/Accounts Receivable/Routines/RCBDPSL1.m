RCBDPSL1 ;WISC/RFJ-patient statement top list manager routine ;1 Dec 00
 ;;4.5;Accounts Receivable;**162**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
INITCONT ;  continue building list
 ;
 ;  initialize line counter and transaction counter
 S (RCLINE,RCTRCNT)=0
 ;  initialize patient account totals
 S (RCTOTAL(1),RCTOTAL(2),RCTOTAL(3))=0
 ;
 ;  show transactions by statement date
 S RCSTATE=0 F  S RCSTATE=$O(^TMP("RCBDPSLMDATA",$J,RCDEBTDA,RCSTATE)) Q:'RCSTATE  D
 .   ;  display statement date on listmanager screen
 .   S RCLINE=RCLINE+1
 .   S RCSTDATE=RCSTATE I RCSTDATE=10000000 S RCSTDATE="NEW ACTIVITY"
 .   I RCSTDATE S RCSTDATE=RCSTDATE_"00000" S RCSTDATE=$E(RCSTDATE,4,5)_"/"_$E(RCSTDATE,6,7)_"/"_$E(RCSTDATE,2,3)_" @ "_$E(RCSTDATE,9,10)_":"_$E(RCSTDATE,11,12)
 .   D SET("Transactions for LAST Patient Statement as of Date: "_RCSTDATE,RCLINE,1,80,0,IORVON,IORVOFF)
 .   ;  initialize totals by statement date
 .   S (RCTOTAL(4),RCTOTAL(5),RCTOTAL(6))=0
 .   ;  initialize flag marking transactions incomplete
 .   S RCFINCOM=0
 .   ;
 .   S RCDATE=0 F  S RCDATE=$O(^TMP("RCBDPSLMDATA",$J,RCDEBTDA,RCSTATE,RCDATE)) Q:'RCDATE  D
 .   .   S RCTRANDA="" F  S RCTRANDA=$O(^TMP("RCBDPSLMDATA",$J,RCDEBTDA,RCSTATE,RCDATE,RCTRANDA)) Q:RCTRANDA=""  D
 .   .   .   S RCVALUE=^TMP("RCBDPSLMDATA",$J,RCDEBTDA,RCSTATE,RCDATE,RCTRANDA)
 .   .   .   ;
 .   .   .   I 'RCTRANDA D SETBILL
 .   .   .   I RCTRANDA D SETTRAN
 .   .   .   ;
 .   .   .   ;  compute totals by statement date
 .   .   .   S RCTOTAL(4)=RCTOTAL(4)+$P(RCVALUE,"^",2)
 .   .   .   S RCTOTAL(5)=RCTOTAL(5)+$P(RCVALUE,"^",3)
 .   .   .   S RCTOTAL(6)=RCTOTAL(6)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)+$P(RCVALUE,"^",6)
 .   .   .   ;
 .   .   .   ;  compute totals by patient account
 .   .   .   S RCTOTAL(1)=RCTOTAL(1)+$P(RCVALUE,"^",2)
 .   .   .   S RCTOTAL(2)=RCTOTAL(2)+$P(RCVALUE,"^",3)
 .   .   .   S RCTOTAL(3)=RCTOTAL(3)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)+$P(RCVALUE,"^",6)
 .   ;
 .   ;  if transaction was set incomplete on any transactions, show why
 .   I RCFINCOM D
 .   .   S RCLINE=RCLINE+1 D SET("                       * indicates transaction",RCLINE,1,80)
 .   .   S RCLINE=RCLINE+1 D SET("                       * is MARKed INCOMPLETE",RCLINE,1,80)
 .   ;
 .   ;  display totals by statement date
 .   S RCLINE=RCLINE+1
 .   D SET("                                                    --------- -------- --------",RCLINE,1,80)
 .   S RCLINE=RCLINE+1
 .   D SET("TOTAL BY LAST STATEMENT AS OF DATE: "_RCSTDATE,RCLINE,1,80)
 .   D SET($J(RCTOTAL(4),9,2),RCLINE,53,62)
 .   D SET($J(RCTOTAL(5),9,2),RCLINE,62,71)
 .   D SET($J(RCTOTAL(6),9,2),RCLINE,71,80)
 .   ;
 .   ;  if last statement date, check to see if it is equal to what is stored
 .   I RCSTATE=$P($P(RCEVENDA,"^"),".") D
 .   .   S RCOUTBAL=0
 .   .   I +RCTOTAL(4)'=+RCEVENT("PB") S RCOUTBAL=1
 .   .   I +RCTOTAL(5)'=+RCEVENT("IN") S RCOUTBAL=1
 .   .   I +RCTOTAL(6)'=(RCEVENT("AD")+RCEVENT("CC")+RCEVENT("MF")) S RCOUTBAL=1
 .   .   I RCOUTBAL D
 .   .   .   S RCLINE=RCLINE+1
 .   .   .   D SET("          ***** LAST PATIENT STATEMENT OUT OF BALANCE",RCLINE,1,80)
 .   .   .   D SET($J(RCEVENT("PB"),9,2),RCLINE,53,62)
 .   .   .   D SET($J(RCEVENT("IN"),9,2),RCLINE,62,71)
 .   .   .   D SET($J(RCEVENT("AD")+RCEVENT("CC")+RCEVENT("MF"),9,2),RCLINE,71,80)
 .   ;
 .   ;
 .   ;  add some extra lines
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET(" ",RCLINE,1,80)
 ;
 ;  show totals of all transactions displayed in listmanager
 S RCLINE=RCLINE+1
 D SET("                                                    --------- -------- --------",RCLINE,1,80)
 S RCLINE=RCLINE+1
 D SET("   TOTAL BALANCE FOR PATIENT ACCOUNT",RCLINE,1,80)
 D SET($J(RCTOTAL(1),9,2),RCLINE,53,62)
 D SET($J(RCTOTAL(2),9,2),RCLINE,62,71)
 D SET($J(RCTOTAL(3),9,2),RCLINE,71,80)
 ;
 ;  set valmcnt to number of lines in the list
 S VALMCNT=RCLINE
 D HDR^RCDPAPLM
 Q
 ;
 ;
SETTRAN ;  set a transaction on the listmanager line
 N DATE,RCDPDATA
 ;
 ;  get 433 data
 D DIQ433^RCDPTPLM(RCTRANDA,".01;.03;12;19;")
 ;
 ;  increment line number / transaction counter
 S RCLINE=RCLINE+1,RCTRCNT=RCTRCNT+1
 ;
 ;  bill number
 D SET(RCTRCNT,RCLINE,1,80,0,IORVON,IORVOFF)
 D SET($E($P(RCDPDATA(433,RCTRANDA,.03,"E"),"-",2)_"       ",1,7),RCLINE,6,12)
 ;
 ;  set transaction number
 D SET(RCTRANDA,RCLINE,14,23)
 ;
 ;  display transaction incomplete
 I $P($G(^PRCA(433,RCTRANDA,0)),"^",10) D SET("*",RCLINE,24,24) S RCFINCOM=1
 ;
 ;  set transaction date
 S DATE=$P($G(RCDPDATA(433,RCTRANDA,19,"I")),".") I 'DATE S DATE=" "
 I DATE S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 D SET(DATE,RCLINE,25,33)
 ;
 ;  set transaction type
 D SET($TR(RCDPDATA(433,RCTRANDA,12,"E"),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz"),RCLINE,35,52)
 D SET($J($P(RCVALUE,"^",2),9,2),RCLINE,53,62)
 D SET($J($P(RCVALUE,"^",3),9,2),RCLINE,62,71)
 ;  add marshal fee and court cost to create admin dollars
 D SET($J($P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)+$P(RCVALUE,"^",6),9,2),RCLINE,71,80)
 Q
 ;
 ;
SETBILL ;  set a bill original amount
 N DATE
 ;
 ;  increment line number
 S RCLINE=RCLINE+1
 ;
 ;  bill number
 D SET(" ",RCLINE,1,80)
 D SET($E($P($P($G(^PRCA(430,+$P(RCVALUE,"^"),0)),"^"),"-",2)_"       ",1,7),RCLINE,6,12)
 ;
 ;  set bill date
 S DATE=RCDATE I 'DATE S DATE=" "
 I DATE S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 D SET(DATE,RCLINE,25,33)
 ;
 ;  set transaction type
 D SET("Original Amount",RCLINE,35,52)
 D SET($J($P(RCVALUE,"^",2),9,2),RCLINE,53,62)
 D SET($J(0,9,2),RCLINE,62,71)
 ;  add marshal fee and court cost to create admin dollars
 D SET($J(0,9,2),RCLINE,71,80)
 Q
 ;
 ;
SET(STRING,LINE,COLBEG,COLEND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_$S(STRING="":"",1:": ")_$G(RCDPDATA(433,RCTRANDA,FIELD,"E"))
 I STRING="",'$G(FIELD) D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLBEG,COLEND-COLBEG+1))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLBEG,$L(STRING),ON,OFF)
 Q

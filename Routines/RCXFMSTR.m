RCXFMSTR ;WASH-ISC@ALTOONA,PA/CLH-TRI CARE EXTRACT ROUTINE ;1 Oct 97
 ;;4.5;Accounts Receivable;**90,148**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EN ;  creates report from TRI data in file 423.6
 N %,BILL,BILLDA,DATA,LINE,LINEDA,SUBJECT,TRICARDA,XMSUB,XMDUZ,XMY,XMZ,Y
 K ^TMP($J,"RCXFMSTR"),^TMP($J,"RCXFMSTRXMB")
 ;
 S SUBJECT="TRI-"
 F  S SUBJECT=$O(^PRCF(423.6,"B",SUBJECT)) Q:$E(SUBJECT,1,4)'="TRI-"  D
 .   S TRICARDA=$O(^PRCF(423.6,"B",SUBJECT,0)) Q:'TRICARDA
 .   ;
 .   ;  loop through the bills and set the line number
 .   S LINEDA=0 F  S LINEDA=$O(^PRCF(423.6,TRICARDA,1,LINEDA)) Q:'LINEDA  D
 .   .   S DATA=$G(^PRCF(423.6,TRICARDA,1,LINEDA,0)) I DATA="" Q
 .   .   I $E(DATA,1,3)'="TRI" Q
 .   .   S BILL=$E($P(DATA,"^",4),1,3)_"-"_$E($P(DATA,"^",4),4,10)
 .   .   S BILLDA=$O(^PRCA(430,"B",BILL,0))
 .   .   I 'BILLDA S ^TMP($J,"RCXFMSTR","NOTFOUND",BILL)=$P(DATA,"^",6) Q
 .   .   ;
 .   .   ;  store the line number
 .   .   S $P(^PRCA(430,BILLDA,11),"^",4)=$P(DATA,"^",5)
 .   .   S ^TMP($J,"RCXFMSTR","CONVERT",BILLDA)=BILL_"^"_$P(DATA,"^",6)
 ;
 ;  send report
 D NOW^%DTC S Y=% D DD^%DT
 S ^TMP($J,"RCXFMSTRXMB",1)="Date of Report: "_Y
 S ^TMP($J,"RCXFMSTRXMB",2)="NOTE: This report contains the records which FMS"
 S ^TMP($J,"RCXFMSTRXMB",3)="has moved to current fiscal year."
 S ^TMP($J,"RCXFMSTRXMB",4)=" "
 S ^TMP($J,"RCXFMSTRXMB",5)="No FMS data exists to report!"
 ;
 S LINE=4
 I $O(^TMP($J,"RCXFMSTR","NOTFOUND",""))'="" D
 .   D SET(" ")
 .   D SET("The following bills were not found in AR and could not be converted:")
 .   S BILL="" F  S BILL=$O(^TMP($J,"RCXFMSTR","NOTFOUND",BILL)) Q:BILL=""  D SET("  "_BILL_$J(^(BILL),20,2))
 ;
 I $O(^TMP($J,"RCXFMSTR","CONVERT",0)) D
 .   D SET(" ")
 .   D SET("The following bills were converted and moved to current fiscal year:")
 .   S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCXFMSTR","CONVERT",BILLDA)) Q:'BILLDA  D SET("  "_$P(^(BILLDA),"^")_$J($P(^(BILLDA),"^",2),20,2))
 ;
 S XMTEXT="^TMP($J,""RCXFMSTRXMB"","
 S XMSUB="FMS PRIOR YEAR RECEIVABLES"
 S XMDUZ="Accounts Receivable Package",XMY("G.FMS")="",XMY(DUZ)=""
 D ^XMD
 ;
 K ^TMP($J,"RCXFMSTR"),^TMP($J,"RCXFMSTRXMB")
 Q
 ;
 ;
SET(STRING) ;  set the line for the report
 S LINE=LINE+1,^TMP($J,"RCXFMSTRXMB",LINE)=STRING
 Q

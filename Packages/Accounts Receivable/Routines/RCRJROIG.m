RCRJROIG ;WISC/RFJ-send data for oig extract ;1 Jul 99
 ;;4.5;Accounts Receivable;**103,174,203,205,220,270**;Mar 20, 1995;Build 25
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
NONMCCF(DATEEND) ;  build the non-mccf bills for user report and submission to oig
 N BILLDA,DATE,DATA7,OTHER,PRINCPAL
 S BILLDA=0 F  S BILLDA=$O(^PRCA(430,BILLDA)) Q:'BILLDA  D
 .   ;  if already stored, then it is a current receivable
 .   I $D(^TMP($J,"RCRJROIG",BILLDA)) Q
 .   ;  calculate principal and other (int + admin) balance
 .   S DATA7=$G(^PRCA(430,BILLDA,7))
 .   S PRINCPAL=+$P(DATA7,"^")
 .   S OTHER=$P(DATA7,"^",2)+$P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5)
 .   ;  in some bills, the principal and other balance may cancel
 .   ;  each other.  for example principal .08 + interest -.08 = 0
 .   I (PRINCPAL+OTHER)'>0 Q
 .   ;  store the data for submission to oig
 .   S ^TMP($J,"RCRJROIG",BILLDA)=PRINCPAL_"^"_OTHER
 .   ;  store the data for the user report (only if bill activated)
 .   S DATE=+$P($P($G(^PRCA(430,BILLDA,6)),"^",21),".") I 'DATE Q
 .   S ^TMP($J,"RCRJRCOLREPORT",DATE,BILLDA)=PRINCPAL_"^"_OTHER
 Q
 ;
 ;
OIG(DATEEND) ;  send data to the OIG
 N BILLDA,COUNT,DATA,DATA0,FUND,FYQ,OIGDATA,SEQUENCE,SITE,TOTALAMT
 N TOTALCNT,TOTALMSG,X,X1
 ;
 ;  get previous fiscal year quarter for mail message header
 S FYQ=$E(DATEEND,4,5),FYQ=$S(FYQ<4:1,FYQ<7:2,FYQ<10:3,1:4)
 S SITE=$$SITE^RCMSITE()
 ;
 ;  calculate the number of messages to be sent
 S (X,X1)=0 F  S X=$O(^TMP($J,"RCRJROIG",X)) Q:'X  S X1=X1+1
 S TOTALMSG=X1\272 I X1#272 S TOTALMSG=TOTALMSG+1
        ;
 ;  build the extract for oig
 S COUNT=0     ;  used to count bills to be sent in a single mail msg
 S SEQUENCE=0  ;  used to count mail messages sent (in mail subject)
 S TOTALCNT=0  ;  used to count total bills sent all mail messages
 S TOTALAMT=0  ;  used to calculate total dollars all mail messages
 K ^TMP($J,"RCRJROIGMM")
 S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCRJROIG",BILLDA)) Q:'BILLDA  D
 .   S DATA=^TMP($J,"RCRJROIG",BILLDA)
 .   S DATA0=^PRCA(430,BILLDA,0)
 .   ;  bill number, position 1-11
 .   S OIGDATA=$E($$LJ^XLFSTR($P(DATA0,"^"),11),1,11)  ; WCJ;PRCA*4.5*270
 .   ;  category, position 12-36
 .   S OIGDATA=OIGDATA_$$LJ^XLFSTR($E($P($G(^PRCA(430.2,+$P(DATA0,"^",2),0)),"^"),1,25),25)
 .   ;  status, position 37-56
 .   S OIGDATA=OIGDATA_$$LJ^XLFSTR($E($P($G(^PRCA(430.3,+$P(DATA0,"^",8),0)),"^"),1,20),20)
 .   ;  principal balance, position 57-65 (example 000000110 for 1.10)
 .   S OIGDATA=OIGDATA_$TR($J($P(DATA,"^"),10,2)," .","0")
 .   ;  date status last updated, position 66-76 (example APR 08,1999)
 .   S OIGDATA=OIGDATA_$$DATE($P(DATA0,"^",14))
 .   ;  fms fund, position 77-82
 .   S FUND=$$GETFUNDB^RCXFMSUF(BILLDA,1)
 .   S FUND=$$ADJFUND^RCRJRCO(FUND) ; may delete this line after 10/1/03
 .   S OIGDATA=OIGDATA_$J(FUND,6)
 .   ;  revenue source code, position 83-86
 .   S OIGDATA=OIGDATA_$J($$GETRSC(BILLDA,FUND),4)
 .   ;  general ledger account number, position 87-90
 .   S OIGDATA=OIGDATA_$J($P(DATA,"^",3),4)
 .   ;  date bill entered, position 91-101 (example APR 08,1999)
 .   S OIGDATA=OIGDATA_$$DATE($P(DATA0,"^",10))
 .   ;  interest + admin balance, position 102-110
 .   S OIGDATA=OIGDATA_$TR($J($P(DATA,"^",2),10,2)," .","0")_"$"
 .   ;
 .   ;  total count and dollars for bills sent
 .   S TOTALCNT=TOTALCNT+1
 .   S TOTALAMT=TOTALAMT+$P(DATA,"^")
 .   ;
 .   ;  store data for transmission
 .   S COUNT=COUNT+1
 .   S ^TMP($J,"RCRJROIGMM",COUNT)=OIGDATA
 .   ;  only send message with 272 bills
 .   I COUNT'=272 Q
 .   ;  if there are no more bills, do not send message until the
 .   ;  totals are placed at the end
 .   I '$O(^TMP($J,"RCRJROIG",BILLDA)) Q
 .   ;
 .   ;  send current code sheets
 .   S SEQUENCE=SEQUENCE+1
 .   D MAILIT(SITE,FYQ,SEQUENCE)
 .   S COUNT=0
 .   K ^TMP($J,"RCRJROIGMM")
 ;
 ;  mail last message with totals at the end
 S COUNT=COUNT+1
 S ^TMP($J,"RCRJROIGMM",COUNT)="END OF TRANSMISSION FOR SITE# "_SITE_":  TOTAL RECORDS: "_TOTALCNT_"  TOTAL AMOUNT: "_TOTALAMT
 S SEQUENCE=SEQUENCE+1
 D MAILIT(SITE,FYQ,SEQUENCE)
 ;
 K ^TMP($J,"RCRJROIGMM")
 K ^TMP($J,"RCRJROIG")
 Q
 ;
 ;
MAILIT(SITE,FYQ,SEQUENCE) ;  send code sheets to oig
 N %,%H,%Z,X,XCNP,XMDUZ,XMSCR,XMSUB,XMY,XMZ,Y
 ;
 ;  set a header record in each file to be transmitted
 S ^TMP($J,"RCRJROIGMM",.5)="OH$"_$$RJ^XLFSTR(SEQUENCE,5,0)_"$"_$$RJ^XLFSTR(TOTALMSG,5,0)_"$|"
 ;
 I TOTALCNT=0 S XMY("G.RC AR DATA COLLECTOR")=""
 S XMY("XXX@Q-OIG.VA.GOV")=""
 S XMDUZ="AR PACKAGE"
 S %H=$H D YX^%DTC
 S XMSUB=SITE_"/BILL/"_FYQ_"/SEQ#: "_SEQUENCE_"/"_Y
 S XMTEXT="^TMP($J,""RCRJROIGMM"","
 D ^XMD
 Q
 ;
 ;
DATE(DATE) ;  format date
 ;  example input=2990408, output=APR 08,1999
 I DATE D
 .   S Y=DATE D DD^%DT
 .   S DATE=$E(Y,1,3)_" "_$E(DATE,6,7)_","_(1700+$E(DATE,1,3))
 Q $$LJ^XLFSTR(DATE,11)
 ;
 ;
GETRSC(BILLDA,FUND) ;  return the rsc for a bill
 I '$$PTACCT^PRCAACC(FUND),FUND'=4032 Q $P($G(^PRCA(430,BILLDA,11)),"^",6)
 ;  check missing patient for reimbursable health insurance
 I $P(^PRCA(430,BILLDA,0),"^",2)=9,'$P(^PRCA(430,BILLDA,0),"^",7) Q "    "
 Q $$CALCRSC^RCXFMSUR(BILLDA)

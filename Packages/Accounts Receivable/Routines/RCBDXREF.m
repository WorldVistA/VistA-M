RCBDXREF ;WISC/RFJ-fix cross references ;1 Jan 01
 ;;4.5;Accounts Receivable;**165**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
FIXATD ;  fix atd x-ref
 ;
 N DATE,DEBT,RCBILLDA,RCDATE,RCDEBTDA
 ;
 ;  loop current x-refs and see if any should be removed
 S RCDEBTDA=0 F  S RCDEBTDA=$O(^PRCA(430,"ATD",RCDEBTDA)) Q:'RCDEBTDA  D
 .   ;
 .   ;  not a first party account
 .   I $P($G(^RCD(340,RCDEBTDA,0)),"^")'["DPT(" D  Q
 .   .   W !,"Not a correct XREF.  KILL ^PRCA(430,""ATD"",",RCDEBTDA,")"
 .   .   K ^PRCA(430,"ATD",RCDEBTDA)
 .   ;
 .   S RCDATE=0 F  S RCDATE=$O(^PRCA(430,"ATD",RCDEBTDA,RCDATE)) Q:'RCDATE  D
 .   .   S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"ATD",RCDEBTDA,RCDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   .   S DATE=+$P($G(^PRCA(430,RCBILLDA,6)),"^",21)
 .   .   .   S DEBT=+$P($G(^PRCA(430,RCBILLDA,0)),"^",9)
 .   .   .   I RCDEBTDA'=DEBT!(RCDATE'=DATE) D
 .   .   .   .   W !,"Not a correct XREF.  KILL ^PRCA(430,""ATD"",",RCDEBTDA,",",RCDATE,",",RCBILLDA,")"
 .   .   .   .   K ^PRCA(430,"ATD",RCDEBTDA,RCDATE,RCBILLDA)
 ;
 ;  loop all bills and make sure x-ref is set
 S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,RCBILLDA)) Q:'RCBILLDA  D
 .   S RCDATE=+$P($G(^PRCA(430,RCBILLDA,6)),"^",21) I 'RCDATE Q
 .   S RCDEBTDA=+$P($G(^PRCA(430,RCBILLDA,0)),"^",9) I 'RCDEBTDA Q
 .   ;
 .   ;  not a first party account
 .   I $P($G(^RCD(340,RCDEBTDA,0)),"^")'["DPT(" Q
 .   ;
 .   I '$D(^PRCA(430,"ATD",RCDEBTDA,RCDATE,RCBILLDA)) D
 .   .   W !,"Missing XREF.  SET ^PRCA(430,""ATD"",",RCDEBTDA,",",RCDATE,",",RCBILLDA,")"
 .   .   S ^PRCA(430,"ATD",RCDEBTDA,RCDATE,RCBILLDA)=""
 Q

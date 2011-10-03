RCRJRCOU ;WISC/RFJ-ar data collector summary report ;1 Mar 97
 ;;4.5;Accounts Receivable;**103**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
USERREPT(DATEMOYR) ;  generate user detailed report
 ;  datemoyr is the dat which appears on message subject
 N BILLDA,DATA,DATE,RCLINE,RCSPACE,REPTDATA,Y
 ;
 K ^TMP($J,"RCRJRCOU")
 S RCSPACE="",$P(RCSPACE," ",81)=""
 S RCLINE=0
 S DATE="" F  S DATE=$O(^TMP($J,"RCRJRCOLREPORT",DATE)) Q:DATE=""  D
 .   S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCRJRCOLREPORT",DATE,BILLDA)) Q:'BILLDA  D
 .   .   S REPTDATA=^TMP($J,"RCRJRCOLREPORT",DATE,BILLDA)
 .   .   S DATA=$G(^PRCA(430,BILLDA,0))
 .   .   S RCLINE=RCLINE+1
 .   .   ;  bill number
 .   .   D SET($P($P(DATA,"^"),"-",2),1,8)
 .   .   ;  date activated
 .   .   S Y=$S('DATE:"00/00/00",1:$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3))
 .   .   D SET(Y,9,16)
 .   .   ;  category
 .   .   D SET($P($G(^PRCA(430.2,+$P(DATA,"^",2),0)),"^"),19,39)
 .   .   ;  status
 .   .   D SET($P($G(^PRCA(430.3,+$P(DATA,"^",8),0)),"^"),40,50)
 .   .   ;  fms report
 .   .   D SET($P(REPTDATA,"^",3),52,56)
 .   .   ;  principal
 .   .   D SET($J($P(REPTDATA,"^"),11,2),57,67)
 .   .   ;  total
 .   .   D SET($J($P(REPTDATA,"^")+$P(REPTDATA,"^",2),11,2),68,78)
 ;
 N %X,DIC,XCNP,XMDISPI,XMDUZ,XMTEXT,XMZ,ZTPAR
 S XMSUB="ARDC Detail Report For "_DATEMOYR
 S XMY("G.RC AR DATA COLLECTOR")=""
 S XMDUZ="AR PACKAGE"
 S XMTEXT="^TMP($J,""RCRJRCOU"","
 D ^XMD
 ;
 K ^TMP($J,"RCRJRCOU")
 Q
 ;
 ;
SET(DATA,COLSTRT,COLEND) ;  store report
 I '$G(COLSTRT) S ^TMP($J,"RCRJRCOU",RCLINE)=DATA Q
 N X
 S X=$G(^TMP($J,"RCRJRCOU",RCLINE))_RCSPACE
 S X=$E(X,1,COLSTRT-1)_$E(DATA,1,COLEND-COLSTRT+1)_$E(X,COLEND+1,79)
 S ^TMP($J,"RCRJRCOU",RCLINE)=$E(X,1,79)
 Q

RCCPCML1 ;ALB@ALTOONA,PA/LDB - Send CCPC transmission (cont.);8/25/00  4:16 PM
V ;;4.5;Accounts Receivable;**160**;Mar 20, 1995;
 ;
ERRML ;ERROR MESSAGES
 N CT,ERROR,LN,PT,SP,XMDUZ,XMTEXT,XMSUB,XMY
 K ^TMP($J,"ERRMSG")
 S (ERROR,LN)=0 F  S ERROR=$O(^TMP($J,"ERROR",ERROR)) Q:'ERROR  D
 .S LN=LN+1 S ^TMP($J,"ERRMSG",LN)=" "
 .S LN=LN+1 S ^TMP($J,"ERRMSG",LN)=$P($T(ERRMSG+ERROR),";;",2)
 .S LN=LN+1 S ^TMP($J,"ERRMSG",LN)=" "
 .S CT=0,PT="" F  S PT=$O(^TMP($J,"ERROR",ERROR,PT)) Q:PT=""  D
 ..S CT=CT+1,LN=LN+1
 ..I PT=0 S ^TMP($J,"ERRMSG",LN)=" " Q
 ..N Y I PT'=0 D 
 ...S PT(1)="" F  S PT(1)=$O(^TMP($J,"ERROR",ERROR,PT,PT(1))) Q:PT(1)=""  D 
 ....S ^TMP($J,"ERRMSG",LN)=$S($L(CT)<2:" "_CT,1:CT)_". "
 ....S SP="                              ",Y=PT,Y=PT_$E(SP,$L(PT),30)
 ....S ^TMP($J,"ERRMSG",LN)=^TMP($J,"ERRMSG",LN)_Y_PT(1)
 S XMDUZ="AR PACKAGE"
 I $O(^XMB(3.8,"B","RCCPC STATEMENTS",0)) S XMY("G.RCCPC STATEMENTS")=""
 E  S XMY($G(DUZ))=""
 S XMSUB="CCPC ERRORS FOUND DURING TRANSMISSION"
 S XMTEXT="^TMP($J,""ERRMSG"","
 D ^XMD
 K ^TMP($J,"ERRMSG")
 Q
 ;
ERRMSG  ;Error messages
1 ;;CCPC transmission process found no records or an incomplete file. Contact IRM.
2 ;;No CCPC transmission records transmitted. Check file 349. Contact IRM.
3 ;;Corrupted PH segment has been encountered for the following patient(s):
4 ;;No key field in CCPC file for the following patient(s):
5 ;;Mailman message creation aborted. Please contact IRM.
6 ;;No transmission sent. Define REMOTE DOMAIN in AR TRANSMISSION TYPE file (349.1).
7 ;;Print Acknowledgements exist. Transmission cannot be resent.
8 ;;Address information is missing for the following patient(s):
9 ;;Address is marked as ADDRESS UNKNOWN for the following patient(s):
10 ;;Corrupted Address. Re-enter address information for the following patient(s):

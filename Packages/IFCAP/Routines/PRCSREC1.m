PRCSREC1 ;WISC/KMB-SEND FMS 820 REPORT ;12/28/99  13:31
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N LINE2,XMTEXT,XMDUZ,XMSUB,WHAT,YY,DELIM,TEMP,XMY
 S DELIM="TRANS #: ,TRANSACTION DATE: ,AMOUNT: ,COST CENTER: ,FY: ,QUARTER: ,"
 F YY=1:1:6 S WHAT(YY)=$P(DELIM,",",YY)
 ;
 S XMSUB="FMS TRANSACTION NOTIFICATION",XMDUZ=.5
 S LINE2=1 F YY=18,22,20,11,4,5 S SENDIT(LINE2+3)=WHAT(LINE2)_$P($G(^PRCF(423.6,RDA,1,LINE,0)),"^",YY),LINE2=LINE2+1
 S TEMP=$P(SENDIT(5),": "),X=$P(SENDIT(5),": ",2),X=$E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2) K %DT D ^%DT,DD^%DT S SENDIT(5)=TEMP_": "_Y
 S Y=RDATE D DD^%DT
 S SENDIT(1)="DATE: "_Y,SENDIT(2)=" STATION: "_STATION_"    CP: "_FCP
 S (SENDIT(3),SENDIT(9))="" S:$D(INFORM) SENDIT(10)=INFORM
 I $D(ERROR) D REGRET Q
 ;
 S USER=0 F  S USER=$O(^PRC(420,STATION,1,+FCP,1,USER)) Q:USER=""  I $P($G(^(USER,2)),"^")="Y" S XMY(USER)=""
 I $D(XMY) S XMTEXT="SENDIT(",XMDUZ=.5 D ^XMD
 K SENDIT QUIT
REGRET ;send error message and data to app coord
 S SENDIT(10)=ERROR,XMDUN="820 RECONCILIATION",XMTEXT="SENDIT("
 S USER=$P($G(^PRC(411,+STATION,9)),"^") Q:USER=""
 S XMY(USER)="" D ^XMD K SENDIT Q
EXCEPT ;
 ;this code generates a report of FMS trans. for CPs not
 ;activated by the site
 N EXCEPT,DIC,L,LEN,FLDS,BY
 S EXCEPT="" D WRITE S DIC="^PRCS(417.1,",BY="30;""FISCAL YEAR"",4,21",FLDS="[PRCSEXCE]",L=0
 S DHD="W ?0 D WRITE2^PRCSREC1"
 D EN1^DIP W !,"End of report" Q
FMSRPT ;
 ; this code generates a report of all FMS trans. for a CP
 D WRITE
 D EN1^PRCSUT Q:'$D(PRC("SITE"))  Q:Y<0
 N P,PRCSZ,Z1 S P=0,(PRCSZ,Z(0))=Z
 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTDESC="FMS TRANSACTIONS REPORT",ZTRTN="BEGIN^PRCSFMS",ZTSAVE("Z*")="",ZTSAVE("P")="",ZTSAVE("PRCSZ")="",ZTSAVE("PRC*")="" D ^%ZTLOAD D ^%ZISC W !,"End of report." Q
 U IO D BEGIN^PRCSFMS D ^%ZISC W !,"End of report" Q
WRITE ;
 W !,"This report will generate a listing of FMS transactions",!
 I $D(EXCEPT) W "which are for control points not activated by your site.",!
 W !,"You may create the report for all entries,",!,"or for selected year and/or quarter.",!
 W !,"Enter fiscal year in the format '99'.",!
 Q
WRITE2 ;
 D DT^DICRW S Y=% D DD^%DT W !,"FMS EXCEPTIONS REPORT",?45,Y,!
 W !,?3,"REFERENCE",?40,"TRANS DATE",?55,"AMOUNT",!,"STATION",?9,"BFY",?15,"AO",?21,"FUND",?33,"FCP/PROJECT",?47,"PROGRAM",?58,"B. OBJ. CLASS",?74,"JOB"
 S LEN="",$P(LEN,"-",IOM)="-" W !,LEN S LEN="" Q
CLEAR ;clear 417.1 entries which are earlier than a selected date
 N REC,REC1,SDATE
 W !!,"This option will purge all FMS Exceptions File Entries earlier",!,"than the date which you select.",!!
 S DIR("A")="Enter date from which entries should be deleted",DIR("?")="To remove records earlier than a certain date, enter that date"
 S DIR(0)="D^^" D ^DIR Q:+Y<1  S SDATE=+Y W "   ",Y(0)
 W !!,"Beginning File 417.1 cleanup.."
 S REC="" F  S REC=$O(^PRCS(417.1,"B",REC)) Q:REC=""  D
 .S REC1=$O(^PRCS(417.1,"B",REC,0)) Q:REC1=""
 .I +$P($G(^PRCS(417.1,REC1,0)),"^",22)<SDATE S DIK="^PRCS(417.1,",DA=REC1 D ^DIK K DA,DIK
 W !!,"End of processing"
 Q

PRCPLO2 ;WISC/RFJ/dh/DWA/DAP-stock status report (option, whse) ; 2/23/07 5:00pm
 ;;5.1;IFCAP;**83,41,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;Copied from routine ^PRCPRSSR and modified for PRC*5.1*83 (CLRS)
 ;
ENT ;This report will be called from option PRCPLO CLO GIP OPTION with fixed
 ;input parameters and run for all stations and active inventory points
 ;on a given VistA system.
 L +^PRCP(446.7,"STATUS"):3 I $T=0 S PRCPMSG(1)="Error encountered when attempting to run CLO GIP Reports due to other",PRCPMSG(2)="CLRS extracts in progress, please try again later." D MAIL^PRCPLO3 Q
 K ^PRCP(446.7)
 S ^PRCP(446.7,0)="CLRS REPORT STORAGE^446.7^^"
 N CLRSFLAG
 S CLRSFLAG="SS" D GETIPT^PRCPLO1
 ;*83 This call links the Stock on Hand Report in a series of two
 ;consecutive report runs to be executed on the 1st of each month.
 L -^PRCP(446.7,"STATUS")
 D ENT^PRCPLO
 N PRCPMSG S PRCPMSG(1)="CLO GIP Reports completed on "_$$HTE^XLFDT($H) D MAIL^PRCPLO3
 Q
 ;
EN1 ;*83 Call coming in from PRCPLO1 with station number and inventory point
 ;
 N %,%DT,%H,%I,DATEINAC,DATESTRT,TODAY,X,X1,X2,Y,MNT,INARNG
 ;*83 The following was edited to always enter the previous month as the start date
 D NOW^%DTC S TODAY=X,Y=$E(X,1,3),MNT=$E(X,4,5)
 S MNT=MNT-1
 I MNT=0 S MNT=12,Y=Y-1
 I $L(MNT)=1 S MNT=0_MNT
 S DATESTRT=Y_MNT_"00"
 ;
 ;*83 The following was edited to always enter a 90 day previous to 
 ;current date default inactivity range if no other is indicated via the
 ;PRCPLO INACTIVITY RANGE parameter
 S INARNG=$$GET^XPAR("SYS","PRCPLO INACTIVITY RANGE",1,"Q")
 I INARNG="" S INARNG=90
 S X1=TODAY,X2=(INARNG*-1) D C^%DTC S DATEINAC=$E(X,1,5)_"00"
 S DT=TODAY
 ;
 ;*83 Build report with station and inventory point passed in from PRCPLO1 call
DQ ;  queue starts here
 N ACCT,ADJ,ADJN,AVERAGE,D,DA,DATE,DATELONG,DUEIN,DUEOUT,INACT,INACTN,INVVAL,ISS,ISSN,ITEMDA,LONG,LONGN,NONISS,NONISSN,ONHAND,OPEN,QTY,REC,RECN,TOTAL,TOTDAYS,TRANSNO,TYPE,VALUE
 ;*83 Added newing of variables
 N STA,INV,TOTOPEN,TOTREC,TOTISS,TOTADJ,TOTCLOS,RECNM,TOTN,DATRN,TOTINA,TOTIS1,TOTAD1,TOTIND,TOTLNG,TOTLND,DAYS,DATRN1,ODITEM,NODE1
 ;*98 Modified calculations to separate ODI and Standard Items
 K ^TMP($J)
 K OPEN
 ;
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S NODE1=1
 .   S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODITEM="Y" S NODE1=2
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   S ^TMP($J,NODE1,"CNT",ACCT)=$G(^TMP($J,NODE1,"CNT",ACCT))+1
 ; 
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.1,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S X=$$GETOPEN^PRCPUBAL(PRCP("I"),ITEMDA,$E(DATESTRT,1,5)) I X'="" D
 .   S NODE1=1
 .   S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODITEM="Y" S NODE1=2
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   S $P(^TMP($J,NODE1,"OPEN",ACCT),"^")=$P($G(^TMP($J,NODE1,"OPEN",ACCT)),"^")+$P(X,"^",2)+$P(X,"^",3)
 .   S $P(^TMP($J,NODE1,"OPEN",ACCT),"^",2)=$P($G(^TMP($J,NODE1,"OPEN",ACCT)),"^",2)+$P(X,"^",8)
 S DATE=DATESTRT F  S DATE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE)) Q:$E(DATE,1,5)'=$E(DATESTRT,1,5)  S TYPE="" F  S TYPE=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE)) Q:TYPE=""  D
 .   S DA=0 F  S DA=$O(^PRCP(445.2,"AX",PRCP("I"),DATE,TYPE,DA)) Q:'DA  D
 .   .   S D=$G(^PRCP(445.2,DA,0)) I '$P(D,"^",5) Q
 .   .   ;  non-issuable
 .   .   Q:$P(D,"^",11)="N"  ;count if not flagged as non-issueable
 .   .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1($P(D,"^",5)))
 .   .   S TRANSNO=$P(D,"^",19)
 .   .   S INVVAL=$P(D,"^",7)*$P(D,"^",8) I $P(D,"^",22)'="" S INVVAL=$P(D,"^",22)
 .   .   S NODE1=1
 .   .   I $$ODITEM^PRCPUX2(PRCP("I"),$P(D,"^",5))="Y" S NODE1=2
 .   .   ;  set transno temporary for primary and secondary to
 .   .   ;  indicate type of transaction
 .   .   I PRCP("DPTYPE")'="W" D
 .   .   .   I TYPE="R"!(TYPE="C")!(TYPE="E")!(TYPE="U")!(TYPE="S") S TRANSNO="--1" Q  ;issue
 .   .   .   I TYPE="RC" S TRANSNO=1 Q  ;receipt
 .   .   .   S TRANSNO="" ;adjustment
 .   .   ;  other adjustments
 .   .   I PRCP("DPTYPE")="W",$P(TRANSNO,"-",2)="" S ^TMP($J,NODE1,"ADJ",ACCT)=$G(^TMP($J,NODE1,"ADJ",ACCT))+INVVAL,^TMP($J,NODE1,"ADJN",ACCT)=$G(^TMP($J,NODE1,"ADJN",ACCT))+1 Q
 .   .   I TRANSNO="" S ^TMP($J,NODE1,"ADJ",ACCT)=$G(^TMP($J,NODE1,"ADJ",ACCT))+INVVAL,^TMP($J,NODE1,"ADJN",ACCT)=$G(^TMP($J,NODE1,"ADJN",ACCT))+1
 .   .   E  D
 .   .   .   ;  purchase order
 .   .   .   I $P(TRANSNO,"-",3)="" S ^TMP($J,NODE1,"REC",ACCT)=$G(^TMP($J,NODE1,"REC",ACCT))+INVVAL,^TMP($J,NODE1,"RECN",ACCT)=$G(^TMP($J,NODE1,"RECN",ACCT))+1 Q
 .   .   .   ;  usage
 .   .   .   S ^TMP($J,NODE1,"ISS",ACCT)=$G(^TMP($J,NODE1,"ISS",ACCT))+INVVAL,^TMP($J,NODE1,"ISSN",ACCT)=$G(^TMP($J,NODE1,"ISSN",ACCT))+1
 ;  calculate inactive, long supply, set non-issuable
 ;*98 modified long supply range to be 90 days instead of 270
 S X1=$E(DT,1,5)_"01",X2=-89 D C^%DTC S DATELONG=$E(X,1,5),X1=DT,X2=$E(X,1,5)_"00" D ^%DTC S TOTDAYS=X
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .   S ACCT=$$ACCT1^PRCPUX1($$FSC^PRCPUX1(ITEMDA))
 .   ;  value
 .   S NODE1=1
 .   S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODITEM="Y" S NODE1=2
 .   S ^TMP($J,NODE1,"VALUE",ACCT)=$G(^TMP($J,NODE1,"VALUE",ACCT))+$P(D,"^",27)
 .   S ^TMP($J,NODE1,"DUEIN",ACCT)=$G(^TMP($J,NODE1,"DUEIN",ACCT))+($$GETIN^PRCPUDUE(PRCP("I"),ITEMDA)*$P(D,"^",22))
 .   S ^TMP($J,NODE1,"DUEOUT",ACCT)=$G(^TMP($J,NODE1,"DUEOUT",ACCT))+($$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA)*$P(D,"^",22))
 .   ;  non-issuable
 .   I $P(D,"^",19) S ^TMP($J,NODE1,"NISS",ACCT)=$G(^TMP($J,NODE1,"NISS",ACCT))+($J($P(D,"^",19)*$P(D,"^",22),0,2)),^TMP($J,NODE1,"NISSN",ACCT)=$G(^TMP($J,NODE1,"NISSN",ACCT))+1
 .   ;  inactive
 .   ;  if reusable, quit
 .   I $$REUSABLE^PRCPU441(ITEMDA) Q
 .   S QTY=$P(D,"^",7)+$P(D,"^",19)
 .   I QTY,'$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,$E(DATEINAC,1,5)-.01)),'$O(^PRCP(445,PRCP("I"),1,ITEMDA,3,DATEINAC)) D
 . .  S ^TMP($J,NODE1,"INACT",ACCT)=$G(^TMP($J,NODE1,"INACT",ACCT))+$P(D,"^",27),^TMP($J,NODE1,"INACTN",ACCT)=$G(^TMP($J,NODE1,"INACTN",ACCT))+1
 .   ;  long supply
 .   S DATE=DATELONG-.01,TOTAL=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,DATE)) Q:'DATE  S TOTAL=TOTAL+$P($G(^(DATE,0)),"^",2)
 .   S AVERAGE=$J(TOTAL/TOTDAYS,0,2),TOTAL=$S('AVERAGE&(QTY):9999999,'AVERAGE:0,1:QTY/AVERAGE\1)
 .   I TOTAL>90 S ^TMP($J,NODE1,"LONG",ACCT)=$G(^TMP($J,NODE1,"LONG",ACCT))+$P(D,"^",27),^TMP($J,NODE1,"LONGN",ACCT)=$G(^TMP($J,NODE1,"LONGN",ACCT))+1
 ;
 ;*98 Create consolidated array of Standard and On-Demand Items
 N I,J,PRCPQ1,PRCPQ2,PRCPR1,PRCPR2,PRCPS1,PRCPS2,L,J,K,TEMPDATA
 F I=1:1:2 D
 .   S PRCPQ1="" F  S PRCPQ1=$O(^TMP($J,I,PRCPQ1)) Q:PRCPQ1=""  D
 ..  S PRCPQ2="" F  S PRCPQ2=$O(^TMP($J,I,PRCPQ1,PRCPQ2)) Q:PRCPQ2=""  D
 ... S TEMPDATA=^TMP($J,I,PRCPQ1,PRCPQ2)
 ... F L=1:1:2 S $P(^TMP($J,3,PRCPQ1,PRCPQ2),"^",L)=$P($G(^TMP($J,3,PRCPQ1,PRCPQ2)),"^",L)+$P(TEMPDATA,"^",L)
 ;
 F J=1:1:3 D
 .   S PRCPR1="" F  S PRCPR1=$O(^TMP($J,3,PRCPR1)) Q:PRCPR1=""  S ^TMP($J,J,PRCPR1,"TOTAL")=0
 ;
 F K=1:1:3 D
 .   S PRCPS1="" F  S PRCPS1=$O(^TMP($J,K,PRCPS1)) Q:PRCPS1=""  D
 ..  S PRCPS2="" F  S PRCPS2=$O(^TMP($J,K,PRCPS1,PRCPS2)) Q:+PRCPS2=0  D
 ... S ^TMP($J,K,PRCPS1,"TOTAL")=$G(^TMP($J,K,PRCPS1,"TOTAL"))+$G(^TMP($J,K,PRCPS1,PRCPS2))
 ;
 D ENT^PRCPLO2A
 ;
 Q

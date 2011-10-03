RCFMDRV1 ;WASH-ISC@ALTOONA,PA/RGY-Add FMS document ;8/18/94  11:36 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
OPEN(DOC,TYPE,ID,ENT,ERROR,BILL,EVN,BAT) ;Add event to FMS document file
 NEW DIC,D0,DIE,DA,X,DLAYGO,DR,DEBT,DIS,DINUM,RCOK
 S ERROR="",ENT=-1
 I $G(DOC)="" S ERROR="FMS Document number undefined" Q
 I $G(ID)]"",$D(^RC(347,"D",ID)) S ERROR="Duplicate Identifier requested" Q
 I '$D(^RC(347.1,+$G(TYPE),0)) S ERROR="Unknown type of document" Q
 I $G(BILL)]"",'$D(^PRCA(430,BILL,0)) S ERROR="Bill number does not exist" Q
 I $G(EVN)]"",'$D(^PRCA(433,EVN,0)) S ERROR="Event number does not exist" Q
 ;S:DOC["-" DOC=$P(DOC,"-")_$P(DOC,"-",2) ;CLH - to allowfull fms number to be entered
 F ENT=+$P(^RC(347,0),"^",3)+1:1 L +^RC(347,ENT):0 I $T S RCOK=0 D  L -^RC(347,ENT) Q:RCOK
   .I $D(^RC(347,ENT)) Q
   .S DINUM=ENT,DIC="^RC(347,",DIC(0)="L",DLAYGO=347,X=ENT
   .K DD,DO D FILE^DICN K DIC,DLAYGO,DO
   .I Y<0 S ERROR="Unable to add bill to bill file!" Q
   .S DIE="^RC(347,",DR="[RCFM OPEN DOCUMENT]",(ENT,DA)=+Y D ^DIE
   .S RCOK=1
   .Q
Q Q

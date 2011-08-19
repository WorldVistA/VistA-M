RCRCPRE  ;WASH-ISC@ALTOONA,PA/LDB-Pre-init for RC RC SERV ;9/23/98  9:07 AM
V ;;4.5;Accounts Receivable;**122,147**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry point to set SERVER ACTION field in RC RC SERV option
 N DIC,RCRC,X,Y
 S DIC="^DIC(19,",X="RC RC SERV",DIC(0)="MO" D ^DIC
 Q:Y=-1
 S RCRC=$P($G(^DIC(19,+Y,220)),"^",2) Q:RCRC=""
 S ^TMP("RCRCPRE",$J)=RCRC
 S $P(^DIC(19,+Y,220),"^",2)="N"
 Q
 ;
END ;Entry point to reset SERVER ACTION field in RC RC SERV OPTION
 N DIC,RCRC,X,Y
 S DIC="^DIC(19,",X="RC RC SERV",DIC(0)="MO" D ^DIC
 Q:Y=-1
 S RCRC=^TMP("RCRCPRE",$J) Q:RCRC=""
 Q:'$D(^DIC(19,+Y,220))
 S $P(^DIC(19,+Y,220),"^",2)=RCRC
 K ^TMP("RCRCPRE",$J)
 Q

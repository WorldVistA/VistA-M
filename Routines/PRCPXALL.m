PRCPXALL ;WISC/RFJ-purge all automatically by TaskManager           ; 2/19/07 1:19pm
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
DQ ;  TaskManager comes here to start the automatic purge of
 ;  inventory points.
 N %,%H,%I,INVPT,NOWDT,PRCP,PRCPZTSK,STOPDATE,TYPE,X,Y
 D NOW^%DTC S NOWDT=$E(X,1,5)_"01",X1=$E(X,1,5)_"15",X2=-395 D C^%DTC S (Y,STOPDATE)=$E(X,1,5)_"01"
 S PRCPZTSK=1
 S INVPT=0 F  S INVPT=$O(^PRCP(445,INVPT)) Q:'INVPT  I $P($G(^(INVPT,0)),"^",21)="Y" S TYPE=$P(^(0),"^",3) I TYPE'="" D
 .   S PRCP("I")=INVPT
 .   ;  distribution history (file 446)
 .   I TYPE'="S" D DQ^PRCPXDIS
 .   ;  receipts
 .   D DQ^PRCPXREC
 .   ;  transaction register
 .   D DQ^PRCPXTRA
 .   ;  usage/distribution totals
 .   D DQ^PRCPXUSE
 .   ;  on-demand item audits (PRC*5.1*98)
 .   I TYPE'="W" D DQ^PRCPXODI
 Q

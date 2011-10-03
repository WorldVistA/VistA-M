PRCPSFR0 ;WISC/RFJ-fms regenerate and retransmit document           ;28 Dec 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %DT,CURRDISP,DA,DATA,DATE,DATEDISP,GECSDATA,PRCPPBFY,PRCPPFCP,PRCPPSTA,PRCPWBFY,PRCPWFCP,PRCPWSTA,STACK,TRANDA,TRANDATE,TRANID,TRANNO,X,Y
 K X S X(1)="This option will regenerate and retransmit a rejected FMS document from the Generic Code Sheet Stack File." W ! D DISPLAY^PRCPUX2(40,79,.X)
 F  D  Q:'STACK
 .   S STACK=$$SELECT^GECSSTAA("IV^SV","","R","","Select Rejected IV or SV Document to Regenerate: ")
 .   I 'STACK Q
 .   D DATA^GECSSGET($P(STACK,"^",2),0)
 .   S TRANID=$G(GECSDATA(2100.1,+STACK,26,"E"))
 .   ;  for earlier code sheets lookup tranid on comment line
 .   I TRANID="" D
 .   .   I $E($P(STACK,"^",2),1,2)="SV" S TRANID=$TR($E($P(STACK,"^",2),7,12)," ") Q
 .   .   S TRANID=$E($P($G(GECSDATA(2100.1,+STACK,4,"E")),":",3),2,99)
 .   S DATA=""
 .   I TRANID'="" S DATA=$G(^PRCP(445.2,+$O(^PRCP(445.2,"T",PRCP("I"),TRANID,0)),0))
 .   I DATA="" K X S X(1)="ERROR: Unable to find the transaction register entry '"_TRANID_"'.  Unable to rebuild the FMS code sheets." D DISPLAY^PRCPUX2(5,75,.X) Q
 .   S (DATE,TRANDATE)=$P(DATA,"^",3),TRANNO=$P(DATA,"^",19) I TRANNO'="" S TRANDA=+$O(^PRCS(410,"B",TRANNO,0))
 .   ;  if transaction date does not equal current date, ask date
 .   I $E(DATE,1,5)'=$E(DT,1,5) F  D  Q:Y'=0
 .   .   S Y=DT D DD^%DT S CURRDISP=Y,Y=DATE D DD^%DT S DATEDISP=Y
 .   .   K X S X(1)="                        ***  W A R N I N G  ***" W ! D DISPLAY^PRCPUX2(5,75,.X)
 .   .   K X S X(1)="This transaction was processed in inventory on "_DATEDISP_".  Since this transaction was processed in a prior month-year, you have the option to process this transaction in FMS for "_DATEDISP_" or "_CURRDISP_". "
 .   .   S X(2)="If you select to process this transaction in FMS for "_CURRDISP_", reconciliation between inventory and FMS will be different for both months "_$E(DATEDISP,1,3)_$E(DATEDISP,8,12)_" and "_$E(CURRDISP,1,3)_$E(CURRDISP,8,12)_"."
 .   .   D DISPLAY^PRCPUX2(5,75,.X)
 .   .   S %DT="AEP",%DT("A")="Select FMS Accounting Date: ",%DT("B")=DATEDISP,%DT(0)=DATE D ^%DT I Y<0 S TRANDATE=0 Q
 .   .   I Y'=DT,Y'=DATE K X S X(1)="ERROR: Only the dates "_DATEDISP_" and "_CURRDISP_" are selectable." D DISPLAY^PRCPUX2(5,75,.X) S Y=0 Q
 .   .   S TRANDATE=Y D DD^%DT
 .   .   K X S X(1)="OKAY, I will use "_Y_" as the FMS accounting period."
 .   .   I TRANDATE'=DATE S X(2)=" Please make a note of this transaction since reconciliation between inventory and FMS will be different for the months "_$E(DATEDISP,1,3)_$E(DATEDISP,8,12)_" and "_$E(CURRDISP,1,3)_$E(CURRDISP,8,12)_"."
 .   .   W ! D DISPLAY^PRCPUX2(5,75,.X)
 .   ;
 .   I 'TRANDATE Q
 .   I $E(DATE,1,5)'=$E(TRANDATE,1,5) S XP="ARE YOU SURE",XH="Enter YES to rebuild this transaction for different month-years."
 .   E  S XP="READY TO REBUILD FMS CODE SHEET",XH="Enter YES to rebuild and retransmit the FMS code sheet."
 .   W ! I $$YN^PRCPUYN(2)'=1 Q
 .   ;  rebuild sv
 .   I $E($P(STACK,"^",2),1,2)="SV" D SVDATA^PRCPSFIU(PRCP("I")),SV^PRCPSFSV(PRCP("I"),TRANID,TRANDATE,+STACK) Q
 .   ;  rebuild iv
 .   D IVDATA^PRCPSFIU(TRANDA,PRCP("I"))
 .   D IV^PRCPSFIV(PRCP("I"),TRANID,TRANNO,TRANDATE,+STACK)
 Q

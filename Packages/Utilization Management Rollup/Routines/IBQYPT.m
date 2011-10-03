IBQYPT ;ALB/CPM - POST-INITIALIZATION FOR PATCH IBQ*1*1 ; 04-DEC-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**1**;Oct 01, 1995
 ;
 ;
EN ; Patch IBQ*1*1 post-initialization.
 ;
 D RECNVT ;  re-convert HR Acute Care Discharge Date to CT entries
 D COMP ;    post completed-installation message
 Q
 ;
 ;
RECNVT ; Perform re-conversion.
 ;
 W !!,">>> Re-converting data from file #356.1 to #356..."
 ;
 D DEL ; delete previous values from file #356
 D UPD ; re-run the #356.1 -> #356 conversion
 ;
 Q
 ;
 ;
DEL ; Delete data previously converted to file #356.
 ;
 W !," >> Deleting data previously converted to file #356..."
 ;
 S IBD=0 F  S IBD=$O(^IBT(356,"ADIS",IBD)) Q:'IBD  D
 .S IBT=0 F  S IBT=$O(^IBT(356,"ADIS",IBD,IBT)) Q:'IBT  D
 ..S DIE="^IBT(356,",DA=IBT,DR="1.09////@" D ^DIE K DA,DIE,DR
 ;
 W " done."
 K IBD,IBT
 Q
 ;
UPD ; Re-run the conversion of data from file #356.1 to file #356.
 ;
 W !," >> Re-running the conversion of data from file #356.1 to #356..."
 ;
 S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,IBTRV)) Q:'IBTRV  D
 .;
 .; - find the Acute Care Discharge Date
 .S IBQACDD=$P($G(^IBT(356.1,IBTRV,1)),"^",17)
 .Q:'IBQACDD
 .;
 .; - find the corresponding Claims Tracking entry
 .S IBTRN=$P($G(^IBT(356.1,IBTRV,0)),"^",2)
 .Q:'IBTRN  Q:'$G(^IBT(356,IBTRN,0))
 .;
 .; - update field #1.09 in file #356
 .S DIE="^IBT(356,",DA=IBTRN,DR="1.09////"_IBQACDD D ^DIE
 ;
 W " done."
 K DA,DR,DIE,IBQACDD,IBTRN,IBTRV
 Q
 ;
 ;
COMP ; Post installation completion message.
 ;
 D NOW^%DTC S IBQEDT=$H
 W !!,">>> Initialization Complete at " S Y=% D DT^DIQ
 I $D(IBQBDT) D
 .S IBQDAY=+IBQEDT-(+IBQBDT)*86400 ;additional seconds of over midnight
 .S X=IBQDAY+$P(IBQEDT,",",2)-$P(IBQBDT,",",2)
 .W !,"    Elapsed time for initialization was: ",X\3600," Hours,  ",X\60-(X\3600*60)," Minutes,  ",X#60," Seconds"
 ;
 W !!,"  *** You may now roll up your QM data for transmission ***"
 W !,"      Please note that you must roll up and transmit your data again if"
 W !,"      you had done so prior to installing this patch."
 ;
 K IBQBDT,IBQEDT,IBQDAY
 Q

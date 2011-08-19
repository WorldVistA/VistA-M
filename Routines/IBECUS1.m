IBECUS1 ;RLM/DVAMC - TRICARE PHARMACY BILLING ENGINES ; 14-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,88,240,274**;21-MAR-94
 ;
BILLS ; Tasked entry point:  Secondary Billing engine.
 ;
 I $D(^%ZOSF("TRAP")) S X="ERRS^IBECUS1",@^("TRAP")
 ;
 ; - main idling loop
 F  H 100 Q:'$P($G(^IBE(350.9,1,9)),"^",4)
 ;
 I $P($G(^IBE(350.9,1,9)),"^",10) S $P(^IBE(350.9,1,9),"^",5)="" G BILLQ
 ;
 ; - drop into Primary Billing task...
 ;
 ;
BILLP ; Tasked entry point:  Primary Billing engine.
 ;
 I $D(^%ZOSF("TRAP")) S X="ERRP^IBECUS1",@^("TRAP")
 ;
 ; - open the port
 D CALL^%ZISTCP(IBCHAN,IBBPORT) I POP G BILLC
 ;
 ; - start secondary job
 D SECB
 ;
 ; - send alert notifying that the billing engine has started
 D NOW^%DTC S $P(^IBE(350.9,1,9),"^",8)=%,Y=% X ^DD("DD")
 S XQA("G.IB CHAMP RX START")="",XQAMSG="IPS Billing Process Started "_Y
 D SETUP^XQALERT
 ;
 ; - main processing loop
 F  R IBX:50 D SND,UPD I $P($G(^IBE(350.9,1,9)),"^",10) Q
 ;
BILLC D CLOSE^%ZISTCP
 ;
 ; - delete the primary task
 S $P(^IBE(350.9,1,9),"^",4)=""
 ;
BILLQ Q
 ;
 ;
SND ; Process all prescriptions queued for billing.
 F  R *IBI:0 Q:IBI=-1  ; bleed queue
 S IBKEY="" F  S IBKEY=$O(^IBA(351.5,"APOST",IBKEY)) Q:'IBKEY  S IBKEYD=$G(^(IBKEY)),IBROU="^IBECUS"_$S(IBKEYD["REVERSE":3,1:2) D @IBROU
 Q
 ;
 ;
UPD ; Update the last run date/time.
 D NOW^%DTC
 S $P(^IBE(350.9,1,9),"^",9)=%
 Q
 ;
 ;
ERRP ; Primary billing task error trap
 D CLOSE^%ZISTCP
 S $P(^IBE(350.9,1,9),"^",4)=""
 G ^%ZTER
 ;
ERRS ; Secondary billing task error trap
 D SECB
 G ^%ZTER
 ;
SECB ; Start the secondary billing task.
 S ZTRTN="BILLS^IBECUS1",ZTDTH=$H,ZTIO=""
 S ZTDESC="IB - TRICARE Secondary Billing Task"
 I IBVOL]"" S ZTCPU=IBVOL
 F I="IBBPORT","IBCHAN","IBCHSET","IBPRESCR","IBVOL" S ZTSAVE(I)=""
 D ^%ZTLOAD
 ;
 S $P(^IBE(350.9,1,9),"^",5)=$G(ZTSK)
 ;
 K ZTRTN,ZTDTH,ZTIO,ZTSK,ZTCPU,ZTSAVE
 Q
 ;
 ;
 ;
AWPS ; Tasked entry point:  Secondary AWP Update engine.
 ;
 I $D(^%ZOSF("TRAP")) S X="ERRAS^IBECUS1",@^("TRAP")
 ;
 ; - main idling loop
 F  H 100 Q:'$P($G(^IBE(350.9,1,9)),"^",6)
 ;
 I $P($G(^IBE(350.9,1,9)),"^",10) S $P(^IBE(350.9,1,9),"^",7)="" G AWPPQ
 ;
 ; - drop into Primary AWP Update task...
 ;
 ;
AWPP ; Tasked Entry Point:  Primary AWP Update Engine
 ;
 I $D(^%ZOSF("TRAP")) S X="ERRAP^IBECUS1",@^("TRAP")
 ;
 ; - open the port
 D CALL^%ZISTCP(IBCHAN,IBAPORT) I POP G AWPPC
 ;
 ; - start secondary job
 D SECA
 ;
 ; - main processing loop
 S IBUPD=0 F  R IBX:30 D  I $P($G(^IBE(350.9,1,9)),"^",10) Q
 .;
 .; - if no response, sent alert if necessary
 .I IBX="" D:IBUPD  Q
 ..D NOW^%DTC S Y=% X ^DD("DD")
 ..S XQA("G.IB CHAMP RX START")=""
 ..S XQAMSG="AWP update completed on "_Y_".  "_IBUPD_" new rates were added."
 ..D SETUP^XQALERT
 ..S IBUPD=0
 .;
 .; - respond if record is not in the anticipated format
 .I IBX'?36N W "N" Q
 .I IBX?36"9" Q
 .;
 .; - pull data from the transmitted record
 .S IBNDCO=$E(IBX,1,11),IBNDCN=$E(IBX,12,22),IBAWP=$E(IBX,23,29)
 .S IBAWP=$E(IBAWP,1,3)_"."_$E(IBAWP,4,7)
 .S IBNDC=$S(IBNDCN:IBNDCN,1:IBNDCO)
 .S IBNDC=$E(IBNDC,1,5)_"-"_$E(IBNDC,6,9)_"-"_$E(IBNDC,10,11)
 .;
 .; - find/build billable item and file the new charge item
 .N DIQUIET S DIQUIET=1,IBG=0 D DT^DICRW
 .S IBITEM=+$$ADDBI^IBCREF("NDC",IBNDC)
 .I IBITEM,$$ADDCI^IBCREF(IBCHSET,IBITEM,DT,IBAWP) S IBG=1
 .;
 .; - respond and update the counter
 .W "Y",!
 .S:IBG IBUPD=IBUPD+1
 ;
AWPPC D CLOSE^%ZISTCP
 ;
 ; - delete the primary task
 S $P(^IBE(350.9,1,9),"^",6)=""
 ;
AWPPQ Q
 ;
 ;
SECA ; Start the secondary AWP Update task.
 S ZTRTN="AWPS^IBECUS1",ZTDTH=$H,ZTIO=""
 S ZTDESC="IB - TRICARE Secondary AWP Update Task"
 I IBVOL]"" S ZTCPU=IBVOL
 F I="IBAPORT","IBCHAN","IBCHSET","IBVOL" S ZTSAVE(I)=""
 D ^%ZTLOAD
 ;
 S $P(^IBE(350.9,1,9),"^",7)=$G(ZTSK)
 ;
 K ZTRTN,ZTDTH,ZTIO,ZTSK,ZTCPU,ZTSAVE
 Q
 ;
ERRAP ; Primary billing task error trap
 D CLOSE^%ZISTCP
 S $P(^IBE(350.9,1,9),"^",6)=""
 G ^%ZTER
 ;
ERRAS ; Secondary billing task error trap
 D SECA
 G ^%ZTER

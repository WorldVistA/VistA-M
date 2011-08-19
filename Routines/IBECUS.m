IBECUS ;RLM/DVAMC - TRICARE PHARMACY ENGINE OPTIONS ; 14-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240**;21-MAR-94
 ;
START ; Start the TRICARE Transaction and AWP Update engines.
 K IBERR D PAR
 ;
 ; - parameters are not set up completely
 I $O(IBERR(0)) D  G STARTQ
 .W !!,"The TRICARE Billing engines cannot be started!",*7
 .W ! S I=0 F  S I=$O(IBERR(I)) Q:'I  W !,IBERR(I)
 .I IBAPORT="" W !!," *** Note that the AWP Update port has also not been defined."
 ;
 ; - AWP and billing ports must be unique
 I IBBPORT=IBAPORT W !!,"The Billing Transaction and AWP Update ports cannot be the same!" G STARTQ
 ;
 ; - only start the billing job if the AWP port is not defined
 I IBAPORT="" W !!,"The AWP Update port has not been defined.  The AWP Update task will not start."
 ;
 I IBVOL]"" W !!,"Note that these jobs will be queued to run on ",IBVOL,"."
 ;
 ; - okay to queue these jobs?
 S DIR(0)="Y",DIR("A")="Is it okay to queue these jobs to run"
 S DIR("?",1)="Enter:  'Y'  if you wish to task off this job, or"
 S DIR("?")="        'N' or '^'  to quit this option."
 W ! D ^DIR
 I 'Y W !!,"The jobs have not been queued to run." G STARTQ
 ;
 ; - turn off the 'shutdown filer' flag
 S $P(^IBE(350.9,1,9),"^",10)=0
 ;
 ; - queue the primary billing task
 S ZTRTN="BILLP^IBECUS1",ZTDTH=$H,ZTIO=""
 S ZTDESC="IB - TRICARE Primary Billing Task"
 I IBVOL]"" S ZTCPU=IBVOL
 F I="IBBPORT","IBCHAN","IBCHSET","IBPRESCR","IBVOL" S ZTSAVE(I)=""
 D ^%ZTLOAD
 I '$D(ZTSK) W !!,"Unable to queue the billing task!" G STARTQ
 ;
 W !!,"The TRICARE billing engine has been queued as task# ",ZTSK,"."
 S DA=1,DIE="^IBE(350.9,",DR="9.04////"_ZTSK_";9.05////@" D ^DIE
 ;
 ; - the AWP port must be defined to start that job
 I IBAPORT="" G STARTQ
 ;
 ; - queue the primary AWP update task
 K ZTSAVE,ZTCPU,ZTSK
 S ZTRTN="AWPP^IBECUS1",ZTDTH=$H,ZTIO=""
 S ZTDESC="IB - TRICARE Primary AWP Update Task"
 I IBVOL]"" S ZTCPU=IBVOL
 F I="IBAPORT","IBCHAN","IBCHSET","IBVOL" S ZTSAVE(I)=""
 D ^%ZTLOAD S IBATASK=$G(ZTSK)
 I '$D(ZTSK) W !!,"Unable to queue the AWP Update task!" G STARTQ
 ;
 W !!,"The AWP Update engine has been queued as task# ",ZTSK,"."
 S DA=1,DIE="^IBE(350.9,",DR="9.06////"_ZTSK_";9.07////@" D ^DIE
 ;
STARTQ K DIROUT,DTOUT,DUOUT,IBERR,IBAPORT,IBBPORT,IBCHAN,IBVOL,ZTSK
 Q
 ;
 ;
STOP ; Shut down the TRICARE Transaction and AWP Update engines.
 I '$P($G(^IBE(350.9,1,9)),"^",4) W !!,"The primary billing task does not appear to be running."
 ;
 ; - okay to shut down these jobs?
 S DIR(0)="Y",DIR("A")="Are you sure you wish to shut down these jobs"
 S DIR("?",1)="Enter:  'Y'  if you wish to shut down these jobs, or"
 S DIR("?")="        'N' or '^'  to quit this option."
 W ! D ^DIR
 I 'Y W !!,"The jobs will not be shut down." G STOPQ
 ;
 ; - set the 'shutdown filer' flag
 S $P(^IBE(350.9,1,9),"^",10)=1
 ;
 W !!,"The TRICARE Billing and AWP Update engines will be shut down."
 ;
STOPQ K DIR,DUOUT,DTOUT,DIROUT,X,Y
 Q
 ;
 ;
PAR ; Retrieve the required engine parameters.
 N X,Y,ZTSK
 S X=$G(^IBE(350.9,1,9))
 S IBBPORT=$P(X,"^")
 I IBBPORT="" S IBERR(1)="The Billing transaction port has not been defined."
 S IBAPORT=$P(X,"^",2)
 S IBCHAN=$P(X,"^",3)
 I IBCHAN="" S IBERR(2)="The TCP/IP address has not been defined."
 S ZTSK=$P(X,"^",4)
 I ZTSK D
 .D STAT^%ZTLOAD
 .I ZTSK(1)=2 S IBERR(3)="This job appears to be running!  Check task #"_ZTSK_"." Q
 .S $P(^IBE(350.9,1,9),"^",4)=""
 S IBCHSET=+$P(X,"^",12)
 I $G(^IBE(363.1,IBCHSET,0))="" S IBERR(4)="You must define a Charge Set in the Charge Master so the drug AWP can be found."
 S IBPRESCR=$P(X,"^",13)
 I IBPRESCR="" S IBERR(5)="You must enter your Prescriber ID before this task can be started."
 S IBVOL=$P(X,"^",11)
 Q

PSXDQUEC ;BIR/HTW-Terminate Auto Processing ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;**23**;11 Apr 97
DQ ;
 G:'$D(^PSX(550,"ATC")) DQ1
 S REC=$O(^PSX(550,"ATC",""))
 S TASK=$P($G(^PSX(550,+PSXSYS,"T1",REC,0)),U,7)
DQ1 I '$D(TASK) W !,"There isn't an automatic job queued to run under this option.",! G EXIT
 S TIME=$$FMTE^XLFDT($P(^PSX(550,+PSXSYS,"T1",REC,0),U,2),"1P"),FREQ=$P(^(0),U,3),THRU=$P(^(0),U,8)
 S DIR(0)="Y",DIR("A",2)="Auto Transmissions are already scheduled.",DIR("A",3)="Current schedule began         :  "_TIME,DIR("A",4)="Number of days to transmit thru:  "_$S($G(THRU)>0:$G(THRU),$G(THRU)'>0:0,1:0)
 S DIR("A",5)="Next transmission scheduled for:  "_$$FMTE^XLFDT($P(^PSX(550,+PSXSYS,"T1",REC,0),"^",4),1),DIR("A",6)="Rescheduling Frequency         :  "_FREQ_$S(FREQ=1:" hour",FREQ>1:" hours",1:"")
 S DIR("A",1)="",DIR("A",7)=""
 S DIR("A")="Do you want to unschedule automatic processing ",DIR("B")="NO" D ^DIR K DIR G:Y=0!($D(DIRUT)) EXIT
 S ZTSK=TASK,PSXZTSK="" D STAT^%ZTLOAD
 I ZTSK(1)=2 W !,"This job is currently running, wait until the task has finished before stopping the job.",! Q
 I ZTSK(1)'=2 D KILL^%ZTLOAD
 I ZTSK(0)=0!(ZTSK(0)=1) L +^PSX(550,+PSXSYS,0):30 D  G:'$T EXIT
 .I '$T W !!,"The CMOP System file is in use, try later." Q
 .S DA=REC,DA(1)=+PSXSYS,DIE="^PSX(550,"_+PSXSYS_",""T1"",",DR=".01////2;6////@" D ^DIE L -^PSX(550,+PSXSYS,0) K DIE,DA,DR,PSXZTSK,REC,TREC,TASK W !,"Job Unscheduled.",!
 I ZTSK(0)<1 W !,"This task does not exist." G EXIT
MSG D NOW^%DTC S (PSXDATE,DTE)=%,SITE=$P($G(PSXSYS),U,3),NAME=$P($G(^VA(200,DUZ,0)),U,1),TIME=$$FMTE^XLFDT(DTE,"1")
 S XMDUZ=.5,XMSUB=("CMOP CS Auto-Transmission Terminated"),LCNT=5
 D XMZ^XMA2 G:XMZ<1 MSG
 S ^XMB(3.9,XMZ,2,1,0)="Cancellation of CS Auto-Transmission Schedule."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Facility           :  "_SITE
 S ^XMB(3.9,XMZ,2,4,0)="Initiating Official:  "_NAME
 S ^XMB(3.9,XMZ,2,5,0)="Date Cancelled     :  "_$P(TIME,":",1,2)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 K XMY S XMDUZ=.5 D GRP^PSXNOTE,ENT1^XMD
 S (PSXAUTO,PSXHOUR)=0 D SERV^PSXMISC
EXIT S PSXSTAT="H" D PSXSTAT^PSXRSYU
 K TIME,STDATE,NUM,X,Y,PSXTRANS,PSXFLAG,FREQ,PSXZTSK,START,ZTSK,%,DAY,DTE,LCNT,NAME,PSXAUTO,PSXDATE,PSXHOUR,SITE,XMDUN,XMDUZ,XMSUB,XMZ,PSXDUZ
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q

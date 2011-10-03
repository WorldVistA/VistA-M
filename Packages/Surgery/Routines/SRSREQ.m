SRSREQ ;BIR/MAM - MAKE REQUESTS ; [ 01/20/00  9:42 AM ]
 ;;3.0; Surgery ;**8,12,23,30,37,92,131,154**;24 Jun 93
LOOP ; break procedure if greater than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
CONCUR ; check for concurrent case
 S (SRSCC,SRSCON)=0 F  S SRSCC=$O(^SRF("AC",SRSDATE,SRSCC)) Q:'SRSCC  I ^(SRSCC)=SRSDPT,$D(^SRF(SRSCC,"REQ")),$P(^("REQ"),"^")=1 S SRSCON=1 Q
 Q:SRSCON=0
CC K SROPS,MM,MMM S SRCTN=SRSCC,SROPER=$P(^SRF(SRCTN,"OP"),"^") S:$L(SROPER)<70 SROPS(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S DFN=SRSDPT D DEM^VADPT W !!,VADM(1)_" has the following procedure already entered for this",!,"date: ",!!,"CASE #"_SRCTN_"  "_SROPS(1) I $D(SROPS(2)) W !,?9,SROPS(2) I $D(SROPS(3)) W !,?9,SROPS(3)
ASKCC K DIR W ! S DIR("A")="Will this be a concurrent procedure ",DIR("B")="NO",DIR(0)="Y",DIR("?",1)="If these procedures will be scheduled at the same time, in the same operating",DIR("?")="room, answer 'YES'."
 D ^DIR S SRSC=Y K DIR Q:$D(DUOUT)!$D(DTOUT)  I 'Y K SRCTN Q
 ;if concurrent and the case is locked
 I Y,$D(^XTMP("SRLOCK-"_SRCTN)) D MSG^SRSUPRQ S SRSC=0 K SRCTN Q
 S SRSCON(SRSCON,"OP")=$P(^SRF(SRCTN,"OP"),"^"),SRSCON(SRSCON,"DOC")=$P(^VA(200,$P(^SRF(SRCTN,.1),"^",4),0),"^"),SRSCON(SRSCON,"SS")=$P(^SRO(137.45,$P(^SRF(SRCTN,0),"^",4),0),"^"),SRSCON(SRSCON)=SRCTN
 Q
AVG ; update estimated case length
 S SRAVG="",SRSPEC=$P(^SRF(SRTN,0),"^",4),SRSCPT=$P(^SRF(SRTN,"OP"),"^",2) D ^SRSAVG S SRLNTH=$P($G(^SRF(SRTN,.4)),"^") I SRLNTH="" S SRLNTH=SRAVG
 W ! K DIR S DIR("A")="How long is this procedure ? (HOURS:MINUTES)  ",DIR("B")=SRLNTH,DIR(0)="130,37A" D ^DIR I $D(DUOUT)!$D(DTOUT) Q
 G:X["^" AVG I X="@" S Y="@"
 S SRLNTH1=Y,DR="37///"_SRLNTH1,DIE=130,DA=SRTN D ^DIE K DR
 Q
LATE ; check too see if it is too late to request
 I $D(^XUSEC("SR REQ OVERRIDE",DUZ)) Q
 N SRHOL,SRXDT S SRHOL="",(SRXDT,X)=SRSDATE D H^%DTC S SRDAY=%Y+1 S SRDL=$P($G(^SRO(133,SRSITE,2)),"^",SRDAY) S:SRDL="" SRDL=1
 I 'SRDL W !!,"Surgery requests not allowed for "_$S(SRDAY=1:"SUN",SRDAY=2:"MON",SRDAY=3:"TUES",SRDAY=4:"WEDNES",SRDAY=5:"THURS",SRDAY=6:"FRI",1:"SATUR")_"DAY !!",! D PRESS S SRLATE=1 Q
 K DIC S DIC=40.5,DIC(0)="XM",X=SRSDATE D ^DIC K DIC S SRHOL=$P(Y,"^") I SRHOL>0,'$D(^SRO(133,SRSITE,3,SRSDATE,0)) D  S SRLATE=1 D PRESS Q
 .S DIC=40.5,DR="2",DA=SRHOL,DIQ="SRY",DIQ(0)="E" D EN^DIQ1 K DA,DIC,DIQ,DR
 .W !!,"Surgery requests not allowed for "_SRY(40.5,SRHOL,2,"E")_" !!"
 I '$D(SRSITE("REQ")) Q
 F  S X1=SRXDT,X2=-SRDL D C^%DTC S SRDTL=X D  Q:SRHOL'>0!$D(^SRO(133,SRSITE,3,X,0))  D NEXT
 .K DIC S DIC=40.5,DIC(0)="XM" D ^DIC K DIC S SRHOL=$P(Y,"^")
 S SRTCHK=SRDTL_"."_SRSITE("REQ") D NOW^%DTC I %>SRTCHK S SRLATE=1
 I $D(SRLATE) D MESS
 Q
NEXT ; find request cutoff for previous day
 S X1=SRXDT,X2=-1 D C^%DTC S SRXDT=X D H^%DTC S SRDAY=%Y+1 S SRDL=$P($G(^SRO(133,SRSITE,2)),"^",SRDAY) S:SRDL="" SRDL=1 I SRDL=0 D NEXT
 Q
MESS ; print message
 W !!,"I'm sorry, but it is too late to make a request.  If this case must",!,"be entered, use the option 'Schedule Unrequested Operations' under",!,"the 'Schedule Operations Menu'.",!!
PRESS W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue  " D ^DIR K DIR
 Q

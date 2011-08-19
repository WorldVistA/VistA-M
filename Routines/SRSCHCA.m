SRSCHCA ;B'HAM ISC/ADM - ADD CONCURRENT CASE TO ALREADY SCHEDULED CASE ; 26 MAY 1992  4:20 PM
 ;;3.0; Surgery ;**114,100**;24 Jun 93
 D ^SRSTCH I SRSOUT W !!,"No concurrent case has been added.",! S SRSOUT=0 G END
 S SRSCON=2,SRCC=1,SRSDATE=$P(^SRF(SRTN,0),"^",9),SRSOR=$P(^SRF(SRTN,0),"^",2),SRSDT1=$P(^(31),"^",4),SRSDT2=$P(^(31),"^",5)
 S Y=SRSDATE D D^DIQ S (SREQDT,SRSDT)=$E(Y,1,12)
 S SRSCON(1)=SRTN,SRSCON(1,"OP")=$P(^SRF(SRTN,"OP"),"^"),SRSCON(1,"DOC")=$P(^VA(200,$P(^SRF(SRTN,.1),"^",4),0),"^"),SRSCON(1,"SS")=$P(^SRO(137.45,$P(^SRF(SRTN,0),"^",4),0),"^")
 D CON^SRSCHUN I SRSOUT  W !!,"No concurrent case has been added.",! S SRSOUT=0 G END
 I $$LOCK^SROUTL(SRTN) D ^SRSCHUN1,UNLOCK^SROUTL(SRTN)
DISP W @IOF,!,"The following cases have been entered."
 S CON=0 F  S CON=$O(SRSCON(CON)) Q:'CON  D LIST
 W !!!!,"1. Enter Information for Case #"_SRSCON(1),!,"2. Enter Information for Case #"_SRSCON(2),!
REQ K DIR S DIR("?")=" ",DIR("?",1)="Select the number corresponding to the case for which you want",DIR("?",2)="to enter information.  Enter '^' or RETURN to exit."
 S DIR(0)="NO^1:2",DIR("A")="Select Number" D ^DIR I Y=""!$D(DUOUT) S SRSOUT=1 G END
 S SRSCON=Y,(DA,SRTN)=SRSCON(SRSCON) I $$LOCK^SROUTL(SRTN) D SS^SRSCHUN1,UNLOCK^SROUTL(SRTN)
 G DISP
END I 'SRSOUT K DIR S DIR(0)="FOA",DIR("A")=" Press RETURN to continue. " D ^DIR
 K SRTN D ^SRSKILL W @IOF
 Q
LIST ; list stub info
 S SROPER=$P(^SRF(SRSCON(CON),"OP"),"^") K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!,CON_". ",?4,"Case # "_SRSCON(CON),?40,SRSDT,!,?4,"Surgeon: "_SRSCON(CON,"DOC"),?40,SRSCON(CON,"SS"),!,?4,"Procedure: ",?16,SROPS(1) I $D(SROPS(2)) W !,?16,SROPS(2) I $D(SROPS(3)) W !,?16,SROPS(3)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q

PSO283EN ;BIR/MFR-EXPIRATION DATE CLEAN UP - Environment Check ;05/03/07
 ;;7.0;OUTPATIENT PHARMACY;**283**;DEC 1997;Build 28
 ;
 N TIME,DIR
 S DIR("A",1)="This patch reads the entire PRESCRIPTION file (#52) and counts"
 S DIR("A",2)="prescriptions with expiration date problem."
 S DIR("A",3)=" "
 S DIR("A",4)="Please, refer to the patch description for more detailed information."
 S DIR("A",5)=" "
 S TIME=$P(^PSRX(0),"^",4)/1000000+.5*1.4\1
 S DIR("A",6)="ESTIMATED DURATION: "_$S(TIME=0:"LESS THAN 1 HOUR",TIME=1:"1 HOUR",1:TIME_" HOURS")
 S DIR("A",7)=" "
 S DIR("A",8)="To STOP, RESUME or VIEW the current status of the post-install,"
 S DIR("A",9)="run the following command in programmer mode:  >D ^PSO283PI"
 S DIR("A",10)=" "
 ;
 S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 ;
 Q

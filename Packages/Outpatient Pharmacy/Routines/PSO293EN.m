PSO293EN ;BIR/MFR-EXPIRATION DATE CLEAN UP - Environment Check ;05/03/07
 ;;7.0;OUTPATIENT PHARMACY;**293**;DEC 1997;Build 22
 ;
 N TIME,DIR
 S DIR("A",1)="This patch reads the entire PRESCRIPTION file (#52) and performs"
 S DIR("A",2)="the 3 updates below (IF NECESSARY):"
 S DIR("A",3)=" "
 S DIR("A",4)="   1. Set/Fix the Rx Expiration Date if not present or > 366 days"
 S DIR("A",5)="   2. Synchronize the Rx Status with CPRS for expired Rx's"
 S DIR("A",6)="   3. Synchronize the Rx Status with HDR for expired/deleted Rx's"
 S DIR("A",7)=" "
 S DIR("A",8)="*** Refer to the patch description for more detailed information ***"
 S DIR("A",9)=" "
 S TIME=$P(^PSRX(0),"^",4)/1000000+.5*1.4\1
 S DIR("A",10)="ESTIMATED DURATION: "_$S(TIME=0:"LESS THAN 1 HOUR",TIME=1:"1 HOUR",1:TIME_" HOURS")
 S DIR("A",11)=" "
 S DIR("A",12)="To STOP, RESUME or VIEW the current status of the clean up, run the"
 S DIR("A",13)="following command in programmer mode:  >D ^PSO293PI"
 S DIR("A",14)=" "
 ;
 S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 ;
 Q

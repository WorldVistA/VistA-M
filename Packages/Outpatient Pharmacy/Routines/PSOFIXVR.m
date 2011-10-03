PSOFIXVR ;BHAM ISC/RTR - CLEAN UP RX VERIFY FILE
 ;;6.0;OUTPATIENT PHARMACY;**34**;SEPTEMBER 1993
 K ^PS(52.4,"B") D WAIT^DICD
 W !,"Checking RX Verify File."
 F A=0:0 S A=$O(^PS(52.4,A)) Q:'A  S $P(^PS(52.4,A,0),"^")=A,$P(^(0),"^",4)="",^PS(52.4,"B",A,A)="" W "."
 W !!,"Finished",! K A Q

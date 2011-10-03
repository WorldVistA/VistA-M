PSOFIXSU ;BHAM ISC/RTR - DELETE BAD P NODES IN SUSPENSE FILE
 ;;6.0;OUTPATIENT PHARMACY;**51**;APRIL 1993
 W !!,"Checking suspense file  "
 F ZZ=0:0 S ZZ=$O(^PS(52.5,ZZ)) Q:'ZZ  I $D(^PS(52.5,ZZ,"P")),'$D(^PS(52.5,ZZ,0)) K ^PS(52.5,ZZ,"P") W "."
 W !!,"Finished!",! K ZZ Q

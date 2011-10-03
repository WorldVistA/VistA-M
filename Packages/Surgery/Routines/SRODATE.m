SRODATE ;B'HAM ISC/MAM - CLEAN UP X-REFS, DATE CHANGE ; 30 SEPT 1991  8:23 AM
 ;;3.0; Surgery ;;24 Jun 93
SCH ; update schedule
 I $D(SRNOREQ) Q
 I $D(^SRF(DA,31)),$P(^(31),"^",4) S MOE=$P(^(31),"^",4),SHEMP=$E(MOE,1,7) I SHEMP'=$E(X,1,7) K X
 I $D(X) Q
 S ROOM=$P(^SRF(DA,0),"^",2) I ROOM S ROOM=$P(^SRS(ROOM,0),"^"),ROOM=$P(^SC(ROOM,0),"^")
 W !!,"This case has already been scheduled on "_$E(SHEMP,4,5)_"/"_$E(SHEMP,6,7)_"/"_$E(SHEMP,2,3)_" in "_ROOM_".",!,"To update the date of operation, you must cancel the case"
 W !,"using the option 'Cancel Scheduled Operation', or reschedule",!,"the case using the option 'Reschedule or Update a Scheduled",!,"Operation'.  Both options are contained within the 'Schedule",!,"Operations' menu."
 S X=$P(^SRF(DA,0),"^",9) W !!,"Press RETURN to continue  " R CURLEY:DTIME
 K CURLEY,MOE,SHEMP,ROOM
 Q

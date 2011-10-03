PSXSTP ;BIR/BAB-Stop Interface ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 ;Called from PSXJOB
 Q
EN ;Enter here to set status to stopped (stop interface)
 ;K LOG,PSXONE S LOG(1)="STP Stopping the interface now!",$G(XCNT),ZCNT)=$G(DUZ)_" STOP INTERFACE DETECTED. ^"_$H,ZCNT=ZCNT+1 D LOG^PSXUTL
 K LOG,PSXONE S LOG(1)="STP Stopping the interface now!"
 ;Wait for PSXJOB to release lock
WAIT L +^PSX(553,1,"S"):3 E  W "." G WAIT
 S ^PSX(553,1,"S")="S" W !!,"Stopping the interface..." S ZTREQ="@"
 W "Done!"
 L -^PSX(553,1,"S")
 Q

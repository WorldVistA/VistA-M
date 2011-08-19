PSXJOB ;BIR/BAB,WPB-Interface Background Job ;[ 02/12/99  1:26 PM ]
 ;;2.0;CMOP;**17**;11 Apr 97
 ;Watches line for incoming data and the outgoing queue.
 ;Hands off control to the Master or Slave module.
EN ;Set E TIMER
 S PSXTRASH=0,PSXTME=$P($H,",",2)
READX ;Read one character, expecting ENQ
 G:^PSX(553,1,"S")="S" STOP
 I $P($G(^PSX(553,1,0)),"^")["LEAVENWORTH" G R1
 I $G(PSXQRY)=1 G ^PSXQRY
R1 R *X:$S($O(^PSX(552.1,"AQ",0)):0,1:5)
 ;if read timed out, check if timer E expired or queue has outgoing
 ;messages then goto master, otherwise reset params & continue idling
 E  D CHKE^PSXUTL G:PSXTMOUT!$D(^PSX(552.1,"AQ")) BID^PSXMST D SETPAR^PSXSTRT G READX
 ;If ENQ,TERM send ACK0 and goto slave(Rec'd bid for master)
 ;Else flush garbage from buffer and continue idling
 E  D TRASH
 G:PSXTRASH>300 EN^PSXSTP G READX
TRASH ;Trash received while idling!!
 S PSXTRASH=PSXTRASH+1 D FLUSH1^PSXUTL I '(PSXTRASH#5) D JOB1,LOG^PSXUTL
 Q
JOB1 K LOG
 S LOG(1)="JOB1 Unexpected character ("_X_") has been received ("_PSXTRASH_") times "
 S LOG(2)="while Idling. Check INTERFACE connection."
 Q
STOP K LOG S LOG(1)="JOB2 Stop interface request detected from DHCP."
 D LOG^PSXUTL
 G EN^PSXSTP
STRT ;Enter here when starting the interface
 ;Flush buffers
 D FLUSH1^PSXUTL
 W *EOT,*TERM
 K LOG S LOG(1)="JOB0 STARTING THE INTERFACE"
 D LOG^PSXUTL
 G EN

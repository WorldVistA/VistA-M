PSXMST ;BIR/BAB,WPB-Master Module to Transmit Messages ;[ 01/28/99  2:46 PM ]
 ;;2.0;CMOP;**17**;11 Apr 97
 Q
BID ;Set line bid retry counter
 S PSXTRY=0
BID1 G:^PSX(553,1,"S")="S" STOP^PSXJOB
 S PSXTME=$P($H,",",2)
 U IO
 W *ENQ,*TERM
BID2 R *X:PSXDLTA E  D MST6 G BAD
 I X=EOT R *X:PSXDLTA G:X=TERM BID2
 I X=ENQ R *X:PSXDLTA D:'$T!(X'=TERM) MST1 G:'$T!(X'=TERM) BAD S PSXTME=$P($H,",",2) S PSXTRY=PSXTRY+1 G:PSXTRY>PSXTRYM BAD D MST7,LOG^PSXUTL G BID2 ;ENQ received
 I X=NAK R *X:PSXDLTA D:'$T!(X'=TERM) MST2 G:'$T!(X'=TERM) BAD D MST5,LOG^PSXUTL G BAD
 I X=ACK R *X:PSXDLTA D:'$T!(X'=48) MST3 G:'$T!(X'=48) BAD R *X:PSXDLTA D:'$T!(X'=TERM) MST8 G:($G(X)=TERM) OKAY
 D MST4 ;if X wasn't ENQ or ACK or NAK then garbage
BAD S PSXTRY=PSXTRY+1 D FLUSH1^PSXUTL,LOG^PSXUTL G:PSXTRY'>PSXTRYM BID1
 ;STOP interface if bid fails more that M times
 ;S ^PSX(553,1,"S")="S" G STOP^PSXJOB
 D MST9,LOG^PSXUTL,SETPAR^PSXSTRT
 S PSXQUIT=1
 ;Hibernate awhile till CMOP comes on line,then try again
 H 45
 G ^PSXJOB
OKAY ;Bid for Master was succesful
 S PSXTME=$P($H,",",2)
 ;Quit if Status is Stopped
 G:^PSX(553,1,"S")="S" STOP^PSXJOB
 ;Check for transmission 'Queued'
 Q:$G(PSXQRY)=1
 I ('$D(^PSX(552.1,"AQ"))&('$D(^PSX(552.1,"APQ")))&($P($G(^PSX(553,1,0)),"^")["LEAVENWORTH")) W *EOT,*TERM G ^PSXJOB
 I ('$D(^PSX(552.1,"AQ"))&('$D(^PSX(552.1,"APQ")))) W *EOT,*TERM G ^PSXQRY
 I $G(PSXONE) S PSXB=PSXONE,PSXDA=$O(^PSX(552.1,"B",PSXB,"")) G SEND
 S QUE=$S($D(^PSX(552.1,"APQ")):"APQ",1:"AQ")
 S PSXDT=$O(^PSX(552.1,QUE,"")) G:'PSXDT EOT S PSXB=$O(^PSX(552.1,QUE,PSXDT,"")) G:'PSXB EOT S PSXDA=$O(^PSX(552.1,QUE,PSXDT,PSXB,"")) G:'PSXDA EOT
 ;Begin sending messages if any Qued
SEND I $D(^PSX(552.2,"AQ",PSXB)) G ^PSXSND
EOT S PSXTXT="BTS|",PSXLAST=1,PSXBLK=1 D XMIT^PSXSND,FILE^PSXSND
 S PSXBHS=0
 W *EOT,*TERM ;end of transmission, nothing to send
 K PSXDT,PSXB,PSXDA,AA,PSXBLK,PSXHEX,PSXLAST,PSXLEN,PSXMSA,PSXMSGID,PSXMSH,PSXQN,PSXSUM,PSXTS,PSXTXT,PSXTSTN,REC,CNT,PSXBHS,QUE
 G:$G(PSXONE) EN^PSXSTP
 G ^PSXJOB
MST1 K LOG S LOG(1)="MST1 ENQ received with no terminator while Bidding for Master status." Q
MST2 K LOG S LOG(1)="MST2 NAK received with no terminator while Bidding for Master status." Q
MST3 K LOG S LOG(1)="MST3 ACK without 0 received while Bidding for Master status." Q
MST4 K LOG S LOG(1)="MST4 Garbage received while Bidding for Master status." Q
MST5 K LOG S LOG(1)="MST5 NAK received while Bidding for Master status." Q
MST6 K LOG S LOG(1)="MST6 No response from CMOP while Bidding for Master status." Q
MST7 K LOG S LOG(1)="MST7 Simultaneous bid for Master status by CMOP and DHCP." Q
MST8 K LOG S LOG(1)="MST8 ACK received with no terminator while Bidding for Master status." Q
MST9 K LOG S LOG(1)="MST9 CMOP won't respond, waiting 45 seconds to try again" Q

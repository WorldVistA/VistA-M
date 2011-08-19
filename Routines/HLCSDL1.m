HLCSDL1 ;ALB/MTC/JC - X3.28 LOWER LAYER PROTOCOL 2.2 - 2/28/95 ;08/19/97
 ;;1.6;HEALTH LEVEL SEVEN;**2,34**;Oct 13, 1995
 ;
 ;This is an implemetation of the X3.28 LLP
 ;
START ;
 N HLIND0,HLIND1,HLNXST,HLTRANS,HLCHK,HLACKBLK,HLDOUT0,HLDOUT1,X,HLRETRY
 N HLNXST,HLLINE,HLXOR,HLTOUT,HLLINE,HLC1,HLC2
 N HLDLX,HLM
 ;S X=10 X ^%ZOSF("PRIORITY")
 S HLM=0,HLNXST=1
 ;-- enter loop for polling for i/o
 D POLL
 ;-- exit and clean-up
 D EXIT
 Q
 ;
 ;
POLL ;-- This function will check if any messages should be sent
 ;   then if anything is in the buffer to read in. If there is data
 ;   to write out then the system will bid for master status and if
 ;   successful x-mit the message. If the system receives a request to
 ;   receive data, then it will attemp to enter a slave mode and read
 ;   data in.
 ;
 N HLFLAG
 S HLFLAG=1
 D TRACE^HLCSDL2("Logging IO to ^XTMP('HL',N")
 ;-- enter loop
 F  D MONITOR^HLCSDR2("POLLING",5,HLDP) Q:'HLFLAG  D
 .; should we still be running
 . I '$$RUN^HLCSDL2 D MONITOR^HLCSDR2("SHUTDOWN",5,HLDP) S HLFLAG=0 Q
 .;-- check for data to read in
 . D TRACE^HLCSDL2("Slave Check"),SLAVE
 . I '$$RUN^HLCSDL2 D MONITOR^HLCSDR2("SHUTDOWN",5,HLDP) S HLFLAG=0 Q
 .;-- check for out going data
 . D TRACE^HLCSDL2("Master Check"),MASTER
 Q
 ;
SLAVE ;-- this function will check if anything is ready to read in from
 ;   the port. If nothing is ready then return to polling, else
 ;   start slave process.
 ;
 N HLX
 ;-- check if anything is ready to read in.
 D TRACE^HLCSDL2("Slave Request")
 ;-- read for enq (request for slave)
 I '$$READENQ^HLCSDL2 G SLAVEQ
 ;-- ack0
 D TRACE^HLCSDL2("Slave Ack0")
 D SENDACK^HLCSDL2(0)
 ;-- read data
 D TRACE^HLCSDL2("Slave Read Data")
 D READ
 ;-- exit and return to polling
SLAVEQ ;
 Q
 ;
READ ;-- This function will take the incoming data from the device and
 ;   store in file 870. After each read an ack will be sent to the
 ;   client application. Once an EOT has been received, return to
 ;   polling.
 ;
 N HLX,HLI,HLBK,HLETXB,HLLINE,HLDATA,BTERM
 ;-- prepare for incoming data
 S HLLINE=1,HLI=0
LOOP ;-- main loop for reading in message
 ;
 ;-- update status
 D MONITOR^HLCSDR2("READING",5,HLDP)
 ;-- read block of data
 S HLX=$$READBK^HLCSDL2("HLDATA",.HLLEN,.HLBK,.HLCK,.BTERM)
 ;-- check for TIMEOUT
 I $G(HLDATA)["TIMEOUT" G READQ
 ;-- check for EOT
 I $G(HLDATA)=HLEOT G READQ
 ;-- check if vaild data
 I '$$VALID^HLCSDL2("HLDATA",HLLINE#8,HLLEN,HLBK,HLCK,BTERM) D  G LOOP
 .;-- update status
 . D TRACE^HLCSDL2("Slave Write NAK")
 . D MONITOR^HLCSDR2("SEND NAK",5,HLDP)
 .;-- send nak
 . D SENDNAK^HLCSDL2
 ;
 ;-- write data to file 870
 S HLDOUT0=$$ENQUEUE^HLCSQUE(HLDP,"IN"),HLDOUT1=$P(HLDOUT0,U,2),HLDOUT0=+HLDOUT0
 D APPEND^HLCSUTL("HLDATA",HLDOUT0,HLDOUT1)
 S HLLINE=HLLINE+1
 ;
 ;-- If end of text set status
 I +BTERM=+HLETX D
 . D MONITOR^HLCSDR2("P",2,HLDOUT0,HLDOUT1,"IN")
 . D MONITOR^HLCSDR2("A",3,HLDOUT0,HLDOUT1,"IN")
 ;-- ack
 D SENDACK^HLCSDL2(HLBK)
 ;-- read next line of data
 G LOOP
 ;
READQ Q
 ;
MASTER ;-- if outgoing messages are present then establish m/s and begin
 ;   transmission of message.
 ;
 N HLBID,HLDOUT0,HLDOUT1
 ;-- check queue
 D TRACE^HLCSDL2("Master Check Queue")
 S HLDOUT0=$$DEQUEUE^HLCSQUE(HLDP,"OUT")
 ;-- nothing on queue quit
 I +HLDOUT0<0 D TRACE^HLCSDL2("*Out Queue Empty") G MASTERQ
 S HLDOUT1=$P(HLDOUT0,U,2),HLDOUT0=+HLDOUT0
 ;-- have item in queue to write, bid for master status
 S HLBID=$$BID(5)
 ;-- if attemp fails quit
 I 'HLBID D PUSH^HLCSQUE(HLDOUT0,HLDOUT1) G MASTERQ
 ;-- if successful goto write state
 I HLBID D
 . D WRITE(HLDOUT0,HLDOUT1)
 . D EOT^HLCSDL2
 ;
MASTERQ Q
 ;
BID(MAXTRY) ;-- This function will bid for Master status MAXTRY times
 ;  and return a 1 if succesful, 0 if fails
 ;  INPUT - MAXTRY - Maximum number of attemps before failing
 ; OUTPUT -  1 for ok; 0 fails
 ;
 N RESULT,HLTRIES,HLDLX
 S RESULT=0,HLTRIES=0
 ;-- update status
 D MONITOR^HLCSDR2("BIDDING",5,HLDP)
BIDRET ;-- bid for master status
 D TRACE^HLCSDL2("Master Bid")
 D ENQ^HLCSDL2
 ;-- update status
 D TRACE^HLCSDL2("Master Bid Wait Ack0")
 D MONITOR^HLCSDR2("WAIT ACK",5,HLDP)
 ;-- if read ack if block 0 OK else fail
 I $$READACK^HLCSDL2(0) S RESULT=1 G BIDQ
 ;-- if nak or timeout
 S HLTRIES=HLTRIES+1
 I HLTRIES>(MAXTRY-1) G BIDQ
 G BIDRET
BIDQ ;-- exit
 Q RESULT
 ;
WRITE(HLDOUT0,HLDOUT1) ;-- This function will take the message contained 
 ;  in file 870 specified by HLDOUT0 and HLDOUT1 and write the data out.
 ;  after each write the system will wait for an ack.
 ;  INPUT : HLDOUT0 - IEN of file #870
 ;          HLDOUT1 - IEN of out queue multiple
 ;
 N HLHEAD,HLTEXT1,HLFOOT,HLX1,HLX2,HLX3,HLTEMP
 ;-- loop to process message
 S HLX1="",HLX2="HLTEXT1"
 F HLI=1:1 K HLTEXT1 S HLX1=$$NEXTLINE^HLCSUTL(HLDOUT0,HLDOUT1,HLX1,HLX2,"OUT") Q:'HLX1  D  I '$$SEND(HLX2,HLHEAD,HLFOOT,5,HLI#8) Q
 . S HLX3=$$NEXTLINE^HLCSUTL(HLDOUT0,HLDOUT1,HLX1,"HLTEMP","OUT")
 . D BUILD^HLCSDL2(HLX2,HLI,$S(HLX3:HLETB,1:HLETX),.HLHEAD,.HLFOOT)
 ;
WRITEQ Q
 ;
SEND(HLTEXT,HLHEAD,HLFOOT,HLRETRY,HLBK) ;-- This function will write the X3.28 formatted
 ; string out the port and wait for an ack. If this function fails
 ; 0 will be returned, else 1.
 ;
 ; Input - HLTEXT - Array containing segment to send
 ;       - HLHEAD - Block header <STX><BLK><LEN>
 ;       - HLFOOT - Block footer <ETX or ETB><BCC><TERM>
 ;       - HLRETRY- Maximum retries before failure
 ;       - HLBK   - Current block 0-7
 ; Output- 0 Fails, 1 = OK
 ;
 N RESULT,HLTRY,X
 S RESULT=1,HLTRY=0
RETRY ;-- write data
 ;-- update status
 D TRACE^HLCSDL2("Master Write")
 D MONITOR^HLCSDR2("WRITING",5,HLDP)
 ;
 U IO
 ;-- write header
 W HLHEAD
 D LOG(HLHEAD,"WRITE: ")
 S X="" F  S X=$O(@HLTEXT@(X)) Q:'X  W @HLTEXT@(X) D LOG(@HLTEXT@(X),"Write: ")
 ;-- write footer
 W HLFOOT D LOG(HLFOOT,"WRITE: ")
 ;-- Wait for ack
 D TRACE^HLCSDL2("Master Wait for Ack"_HLBK)
 D MONITOR^HLCSDR2("WAITING ACK",5,HLDP)
 ;-- if ack
 I $$READACK^HLCSDL2(HLBK) S RESULT=1 D MONITOR^HLCSDR2("D",2,HLDP,HLDOUT1,"OUT") G SENDQ
 ;-- if nak then retry
 S HLTRY=HLTRY+1
 I HLTRY>(HLRETRY-1) S RESULT=0 G SENDQ
 G RETRY
SENDQ ;-- exit
 Q RESULT
 ;
EXIT ;-- Cleanup
 Q
 ;
LOG(ST1,OP) ;Log reads/writes (translates ctrls)
 ;ST1=string to file
 ;OP=operation "read" or "write"
 I $G(HLTRACE) D
 .N X S X=$G(^XTMP("HL",0)),$P(X,U)=DT+1,$P(X,U,2)=DT
 .S $P(X,U,3)="HL7 Debug Log",HLLOG=$P(X,U,4)
 .S HLN=$$TRANS(ST1)
 .S HLLOG=HLLOG+1,^XTMP("HL",HLLOG)=OP_HLN,$P(X,U,4)=HLLOG
 .S ^XTMP("HL",0)=X
 Q
TRANS(ST) ;Translate controls in string
 ;ST=String containing embedded x3.28 control characters
 S ST2="" F I=1:1:$L(ST) S J=$E(ST,I) D
 .I $D(HLCTRL($A(J))) S J=HLCTRL($A(J))
 .S ST2=$G(ST2)_J
 Q ST2

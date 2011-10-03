GECSSTTM ;WISC/RFJ-stacker file transmission (multi docs in a msg)  ;08 Dec 93
 ;;2.0;GCS;**4,5**;MAR 14, 1995
 Q
 ;
 ;
TRANSALL ;  transmit code sheets waiting for clock in stack file
 ;  check for another job transmitting stack code sheets
 N DA,GECSFQUE
 L +^GECS(2100.1,"ATRANSMIT"):10 I '$T Q
 S GECSFQUE=1
 K ^TMP($J,"GECSSTTR")
 S DA=0 F  S DA=$O(^GECS(2100.1,"AS","Q",DA)) Q:'DA  D BUILD(DA)
 D TRANSMIT^GECSSTTT
 K ^TMP($J,"GECSSTTR")
 L -^GECS(2100.1,"ATRANSMIT")
 S ZTREQ="@"
 Q
 ;
 ;
BUILD(DA) ;  build tmp global for stack entry da
 ;  $g(gecsfaut)=1 for immediate transmissions
 I '$D(^GECS(2100.1,DA,0)) Q
 L +^GECS(2100.1,DA):10 I '$T Q
 ;
 N %,BATCHDA,CHECKSUM,DA1,DATA,ENDOFCS,ENDOFMSG,FINDHOLD,GECSFLAG,GECSLPC,HOLDDATE,LINE,SEGMENT,SEQSIZE,SEQUENCE,STACSIZE,X,Y
 ;
 I $E($G(^GECS(2100.1,DA,10,1,0)),1,3)'="CTL" D SETSTAT^GECSSTAA(DA,"E"),ERROR^GECSSTTR(DA,"Control segment/first line of code sheet missing") L -^GECS(2100.1,DA) Q
 ;
 S SEGMENT=$P(^GECS(2100.1,DA,0),"^",5)
 I SEGMENT="" D SETSTAT^GECSSTAA(DA,"E"),ERROR^GECSSTTR(DA,"Segment not defined for entry") L -^GECS(2100.1,DA) Q
 S (ENDOFCS,ENDOFMSG)=""
 I $P(SEGMENT,":",2)="FMS" S ENDOFCS="{",ENDOFMSG="}"
 ;
 S BATCHDA=+$P($G(^GECS(2101.2,+$O(^GECS(2101.2,"B",SEGMENT,0)),0)),"^",4)
 I 'BATCHDA D SETSTAT^GECSSTAA(DA,"E"),ERROR^GECSSTTR(DA,"Batch type in file 2101.2 is incorrect") L -^GECS(2100.1,DA) Q
 ;
 S GECSLPC=$G(^%ZOSF("LPC")) I GECSLPC="" S GECSLPC="S Y="""""
 ;  for automatically created docs, check checksum and hold date
 I $P($G(^GECS(2100.1,DA,0)),"^",6)="A" D  I $G(GECSFLAG) L -^GECS(2100.1,DA) Q
 .   ;  check hold date greater than today
 .   S HOLDDATE=$P($G(^GECS(2100.1,DA,11)),"^",3)
 .   ;  for immediate transmissions, queue code sheet
 .   I HOLDDATE>DT D:$G(GECSFAUT) SETSTAT^GECSSTAA(DA,"Q") S GECSFLAG=1 Q
 .   ;  compute checksum and find hold date if not defined
 .   S CHECKSUM=""
 .   S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,10,DA1)) Q:'DA1  S DATA=$G(^(DA1,0)) D  Q:$G(GECSFLAG)
 .   .   I 'HOLDDATE I $E($P(DATA,"^"),3)=2!($P(DATA,"^")="AT1") S FINDHOLD=$$HOLDDATE^GECSSTTR(DATA) I FINDHOLD S $P(^GECS(2100.1,DA,11),"^",3)=FINDHOLD,GECSFLAG=1 Q
 .   .   S X=CHECKSUM_DATA X GECSLPC S CHECKSUM=Y
 .   ;  for immediate transmissions, queue code sheet
 .   I $G(GECSFLAG) D:$G(GECSFAUT) SETSTAT^GECSSTAA(DA,"Q") Q
 .   ;  compare checksums
 .   S X=$P($G(^GECS(2100.1,DA,11)),"^",2) I X="" Q
 .   I X'=CHECKSUM D SETSTAT^GECSSTAA(DA,"E"),ERROR^GECSSTTR(DA,"Code sheet has been altered since creation") S GECSFLAG=1
 ;
 ;  change transmission date on ctl segment
 S ^GECS(2100.1,DA,10,1,0)=$$CTLDATE^GECSSTTR(^GECS(2100.1,DA,10,1,0))
 ;
 ;  fit code sheet in a sequence number if possible
 S STACSIZE=$P($G(^GECS(2100.1,DA,11)),"^")
 I STACSIZE>30000 D MULTIPLE L -^GECS(2100.1,DA) Q
 S SEQUENCE=0 F  S SEQUENCE=$O(^TMP($J,"GECSSTTR","SIZE",SEQUENCE)) Q:'SEQUENCE  S SEQSIZE=^(SEQUENCE) I ($P(SEQSIZE,"^")+STACSIZE)<30000,^TMP($J,"GECSSTTR","BATCH",SEQUENCE)=BATCHDA Q
 ;  create a new sequence
 I 'SEQUENCE D SEQUENCE S SEQSIZE="0^0"
 ;
 ;  recompute checksum with new transmission date and time on ctl segment
 S LINE=$P(SEQSIZE,"^",2),CHECKSUM=""
 S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,10,DA1)) Q:'DA1  S DATA=$G(^(DA1,0)) I DATA'="" D
 .   S LINE=LINE+1,^TMP($J,"GECSSTTR","CS",SEQUENCE,LINE,0)=DATA
 .   S X=CHECKSUM_DATA X GECSLPC S CHECKSUM=Y
 .   ;  check for last code sheet in stack entry
 .   I '$O(^GECS(2100.1,DA,10,DA1)),$L($G(ENDOFCS)) D  Q
 .   .   I DATA'[ENDOFCS S DATA=DATA_ENDOFCS
 .   .   S ^TMP($J,"GECSSTTR","CS",SEQUENCE,LINE,0)=DATA
 ;
 ;  store new checksum
 S $P(^GECS(2100.1,DA,11),"^",2)=CHECKSUM
 ;
 D ENDSEQ($P(SEQSIZE,"^")+STACSIZE,LINE)
 L -^GECS(2100.1,DA)
 Q
 ;
 ;
MULTIPLE ;  code sheet is larger than 30k, create multiple msgs
 D SEQUENCE
 N %,COUNT,SIZE,STRTSEQ,MAILMSGS
 S STRTSEQ=SEQUENCE
 S MAILMSGS=1,(LINE,SIZE)=0,CHECKSUM=""
 S DA1=0 F  S DA1=$O(^GECS(2100.1,DA,10,DA1)) Q:'DA1  S DATA=$G(^(DA1,0)) I DATA'="" D
 .   S LINE=LINE+1,^TMP($J,"GECSSTTR","CS",SEQUENCE,LINE,0)=DATA
 .   S X=CHECKSUM_DATA X GECSLPC S CHECKSUM=Y
 .   ;  check for last code sheet in stack entry
 .   I '$O(^GECS(2100.1,DA,10,DA1)),$L($G(ENDOFCS)) D  Q
 .   .   I DATA'[ENDOFCS S DATA=DATA_ENDOFCS
 .   .   S ^TMP($J,"GECSSTTR","CS",SEQUENCE,LINE,0)=DATA
 .   S SIZE=SIZE+$L(DATA)
 .   I SIZE>30000 D
 .   .   I $L($G(ENDOFMSG)),DATA'[ENDOFMSG S ^TMP($J,"GECSSTTR","CS",SEQUENCE,LINE,0)=DATA_ENDOFMSG
 .   .   D ENDSEQ(SIZE,LINE),SEQUENCE S MAILMSGS=MAILMSGS+1,LINE=2,SIZE=0
 ;
 ;  store new checksum
 S $P(^GECS(2100.1,DA,11),"^",2)=CHECKSUM
 ;
 ;  modify sequence count
 S DATA=^GECS(2100.1,DA,10,1,0),$P(DATA,"^",13)=$E("000",$L(MAILMSGS)+1,3)_MAILMSGS
 S COUNT=1 F %=STRTSEQ:1 Q:'$D(^TMP($J,"GECSSTTR","CS",%))  S $P(DATA,"^",12)=$E("000",$L(COUNT)+1,3)_COUNT,^TMP($J,"GECSSTTR","CS",%,1,0)=DATA,COUNT=COUNT+1
 ;
 ;  send size=30001 to prevent other code sheets from being added
 D ENDSEQ(30001,LINE)
 Q
 ;
 ;
ENDSEQ(SIZE,LINE) ;  set end sequence control in tmp  
 ;  size=size of code sheet; line=last line of sequence
 N %
 S ^TMP($J,"GECSSTTR","SIZE",SEQUENCE)=SIZE_"^"_LINE
 S ^TMP($J,"GECSSTTR","LIST",SEQUENCE,DA)=""
 S ^TMP($J,"GECSSTTR","BATCH",SEQUENCE)=BATCHDA
 S %=$G(^TMP($J,"GECSSTTR","SEGS",SEQUENCE)) I %[$P(SEGMENT,":") Q
 S ^TMP($J,"GECSSTTR","SEGS",SEQUENCE)=%_$S(%="":"",1:",")_$P(SEGMENT,":")
 Q
 ;
 ;
SEQUENCE ;  return next sequence number
 S SEQUENCE=$G(^TMP($J,"GECSSTTR","SEQ"))+1,^TMP($J,"GECSSTTR","SEQ")=SEQUENCE
 Q

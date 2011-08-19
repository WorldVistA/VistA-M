KMPDHU02 ;OAK/RAK - CM Tools Compile & File HL7 Daily Stats ;2/17/04  08:58
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
DAILY(KMPDST,KMPDEN) ;-entry point
 ;-----------------------------------------------------------------------
 ; KMPDST... Start date in internal fileman format.
 ; KMPDEN... End date in internal fileman format.
 ;
 ; This API gathers HL7 data and stores it in file 8973.1 (CM HL7 DATA)
 ;
 ; Variables used:
 ; GBL...... Global where data is stored - for use with indirection
 ; GBL1..... globas where compiled data is stored before filing - 
 ;           used with indirection
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDST)
 Q:'$G(KMPDEN)
 ; make sure end date has hours
 S:'$P(KMPDEN,".",2) $P(KMPDEN,".",2)="99"
 S:'$G(DT) DT=$$DT^XLFDT
 ;
 N ERROR,GBL,GBL1,STR,X
 ;
 ; get data from hl7 api
 W:'$D(ZTQUEUED) !,"Gathering HL7 data..."
 ; global with 'raw' hl7 api data
 S GBL=$NA(^TMP("KMPDH",$J)) K @GBL
 ; set up global to get asynchronous data
 K ^TMP($J)
 S ^TMP($J,"HLUCM")="DEBUG GLOBAL"
 S X=$$CM2^HLUCM(KMPDST,KMPDEN,1,1,"KMPDH","EITHER",.ERROR)
 I 'X!($D(ERROR))!('$D(^TMP("KMPDH",$J))) D  Q
 .W:'$D(ZTQUEUED) " no data to report"
 ;
 ; global for storing compiled data before filing
 S GBL1=$NA(^TMP("KMPDH-1",$J)) K @GBL1
 ;
 W:'$D(ZTQUEUED) !,"Compiling synchronous HL7 data..."
 D SYNC
 ;
 W:'$D(ZTQUEUED) !,"Compiling asynchronous HL7 data..."
 D ASYNC
 ;
 K @GBL,@GBL1,^TMP($J),^TMP("KMPDHERRTIME",$J)
 W:'$D(ZTQUEUED) !,"Finished!"
 ;
 Q
 ;
 ;
ASYNC ;- asynchronous data
 Q:$G(GBL)=""
 Q:$G(GBL1)=""
 ;
 N COUNT,DATA,DATA1,DATA2,HOUR,I,IEN,IEN1,IEN2,J,LOCAL,MSG,NM,NODE
 N OF,PIECE,PR,PTNP,SD,STDT,TIME1,TIME2,UNIT
 ;
 ; local site name
 S LOCAL=$P($$SITE^VASITE,U,2) Q:LOCAL=""
 S IEN=0
 F  S IEN=$O(^TMP($J,"HLUCMSTORE","U",IEN)) Q:'IEN  S DATA=^(IEN) D 
 .; data = Protocol~Ien^Namespace
 .; message type
 .S MSG=$P(DATA,U,6)
 .; quit if not 'complete' message
 .Q:'$$ASYNCHK(MSG)
 .; protocol - check protocol fist, then inferred protocol
 .S PR=$S($P(DATA,U,7)]"":$P(DATA,U,7),$P(DATA,U,8)]"":$P(DATA,U,8),1:"") Q:PR=""
 .; namespace - check namespace first, then inferred namespace
 .S NM=$S($P(DATA,U,9)]"":$P(DATA,U,9),$P(DATA,U,10)]"":$P(DATA,U,10),1:"") Q:NM=""
 .; other facility
 .S OF=$P(DATA,U,11) S:OF["~" OF=$P(OF,"~",2) Q:OF=""
 .; quit if other facility is LOCAL
 .Q:OF[LOCAL
 .; start date/time
 .S STDT=$P(DATA,U,4) Q:'STDT
 .; date without time
 .S SD=$P(STDT,".") Q:'SD
 .S $P(@GBL1@(SD,PR,NM,OF,99.2),U,11)=$P($P(DATA,U,11),"~")
 .S $P(@GBL1@(SD,PR,NM,OF,99.2),U,12)=$P($P(DATA,U,11),"~",2)
 .S $P(@GBL1@(SD,PR,NM,OF,99.2),U,13)=$P($P(DATA,U,11),"~",3)
 .;
 .S (COUNT,HOUR,IEN1)=0 K UNIT
 .F  S IEN1=$O(^TMP($J,"HLUCMSTORE","U",IEN,IEN1)) Q:'IEN1  D 
 ..; data1 = piece 1 - Characters
 ..;         piece 2 - Messages
 ..;         piece 3 - Seconds
 ..;         piece 4 - Begining Time
 ..;         piece 5 - End Time
 ..;         piece 6 - Type: msg, ca, aa or ca
 ..;         piece 7 - Protocol~Ien
 ..;         piece 8 - Namespace
 ..S DATA1=$G(^TMP($J,"HLUCMSTORE","U",IEN,IEN1,"CCC")) Q:DATA1=""
 ..S COUNT=COUNT+1,UNIT(COUNT)=DATA1
 .;
 .; back to IEN level
 .; quit if unit() array is not complete
 .Q:'$$UNITS(MSG)
 .; hour of transaction
 .S HOUR=+$E($P(STDT,".",2),1,2),HOUR=HOUR+1
 .; prime time or non-prime time
 .S PTNP=$$PTNP^KMPDHU03(STDT) Q:'PTNP
 .; node: 5 - prime time
 .;       6 - non-prime time
 .S NODE=$S(PTNP=2:6,1:5)
 .;
 .; update msg unit count - prime time or non-prime time
 .S $P(@GBL1@(SD,PR,NM,OF,99.5),U,PTNP)=$P($G(@GBL1@(SD,PR,NM,OF,99.5)),U,PTNP)+1
 .;update msg unit count - both prime time & non-prime time
 .S $P(@GBL1@(SD,PR,NM,OF,99.5),U,3)=$P($G(@GBL1@(SD,PR,NM,OF,99.5)),U,3)+1
 .; totals
 .F J=0:0 S J=$O(UNIT(J)) Q:'J  F I=1:1:3 D 
 ..; total
 ..S $P(@GBL1@(SD,PR,NM,OF,99.2),U,I)=$P($G(@GBL1@(SD,PR,NM,OF,99.2)),U,I)+$P(UNIT(J),U,I)
 ..S $P(@GBL1@(SD,PR,NM,OF,99.3),U,(I+6))=$P($G(@GBL1@(SD,PR,NM,OF,99.3)),U,(I+6))+$P(UNIT(J),U,I)
 ..; prime time or non-prime time
 ..; ^ piece to set
 ..S PIECE=I+$S(PTNP=2:3,1:0)
 ..S $P(@GBL1@(SD,PR,NM,OF,99.3),U,PIECE)=$P($G(@GBL1@(SD,PR,NM,OF,99.3)),U,PIECE)+$P(UNIT(J),U,I)
 .;
 .; msg to ca - originating message to commit ack
 .; ^ piece: 1 - characters
 .;          2 - count
 .;          3 - seconds
 .F I=1:1:3 S $P(@GBL1@(SD,PR,NM,OF,NODE+(I*.1)),U,HOUR)=$P($G(@GBL1@(SD,PR,NM,OF,NODE+(I*.1))),U,HOUR)+($P(UNIT(1),U,I)+$P(UNIT(2),U,I))
 .;
 .; processing time (ca to aa) - commit ack ending time to application
 .;                              ack starting time
 .S TIME1=+$P(UNIT(3),U,4),TIME2=+$P(UNIT(2),U,5)
 .S $P(@GBL1@(SD,PR,NM,OF,(NODE+(.4))),U,HOUR)=$$TIMEADD^KMPDU($P($G(@GBL1@(SD,PR,NM,OF,(NODE+(.4)))),U,HOUR)+$$FMDIFF^XLFDT(TIME2,(+TIME1),3))
 .; processing time (ca to aa) - count
 .S $P(@GBL1@(SD,PR,NM,OF,(NODE+(.5))),U,HOUR)=$P($G(@GBL1@(SD,PR,NM,OF,(NODE+(.5)))),U,HOUR)+1
 .;
 .; aa to ca - application ack to commit ack
 .; ^ piece: 1 - characters
 .;          2 - count
 .;          3 - seconds
 .F I=1:1:3 S $P(@GBL1@(SD,PR,NM,OF,NODE+(I+6*.1)),U,HOUR)=$P($G(@GBL1@(SD,PR,NM,OF,NODE+(I+6*.1))),U,HOUR)+($P(UNIT(3),U,I)+$P(UNIT(4),U,I))
 ;
 D:$D(@GBL1) FILE^KMPDHU03(2)
 ;
 Q
 ;
ASYNCHK(KMPDMSG) ;-- extrinsic function - check for 'complete' message
 ;-----------------------------------------------------------------------
 ; KMPDMGS... message ack designations
 ;
 ; Return: 0 - not a complete message
 ;         1 - complete message
 ;-----------------------------------------------------------------------
 Q:$G(KMPDMSG)="" 0
 Q:MSG="MSG~CA~AA~CA" 1
 Q:MSG="MSG~CA~AR~CA" 1
 Q:MSG="MSG~AA" 1
 Q 0
 ;
UNITS(MSG) ;-- extrinsic function
 ;-----------------------------------------------------------------------
 ; MSG.... type of message: 'msg~aa', 'msg~ca~aa~ca', etc.
 ;
 ; Return: 0 - unit() array not complete
 ;         1 - unit() array is complete
 ;
 ; unit() array must be segmented into the following format:
 ;   unit(1) = msg
 ;   unit(2) = ca
 ;   unit(3) = aa
 ;   unit(4) = ca
 ; this data is then used to calculate characters, messages and seconds
 ;-----------------------------------------------------------------------
 Q:$G(MSG)="" 0
 ; all messages must have unit(2)
 Q:'$D(UNIT(2)) 0
 ; "msg~ca~aa~ca" & "msg~ca~ar~ca" messages must have unit(3) & unit(4)
 I MSG="MSG~CA~AA~CA"!(MSG="MSG~CA~AR~CA") Q:'$D(UNIT(3)) 0
 I MSG="MSG~CA~AA~CA"!(MSG="MSG~CA~AR~CA") Q:'$D(UNIT(4)) 0
 ; 'msg~aaa' messages contain only 2 unit() entries
 ; create 4 unit() entries for processing
 I MSG="MSG~AA" D 
 .S (UNIT(3),UNIT(4))=UNIT(2),UNIT(2)=UNIT(1)
 .S $P(UNIT(1),U,1,3)="0^0^0"
 .S $P(UNIT(4),U,1,3)="0^0^0"
 ; calculate seconds
 ; msg to ca
 S $P(UNIT(2),U,3)=$$FMDIFF^XLFDT($P(UNIT(2),U,5),$P(UNIT(1),U,4),2)
 S:$P(UNIT(2),U,3)<0 $P(UNIT(2),U,3)=0
 ; ca to aa
 S $P(UNIT(3),U,3)=$$FMDIFF^XLFDT($P(UNIT(3),U,5),$P(UNIT(2),U,5),2)
 S:$P(UNIT(3),U,3)<0 $P(UNIT(3),U,3)=0
 ; aa to ca
 S $P(UNIT(4),U,3)=$$FMDIFF^XLFDT($P(UNIT(4),U,5),$P(UNIT(3),U,5),2)
 S:$P(UNIT(4),U,3)<0 $P(UNIT(4),U,3)=0
 ;
 Q 1
 ;
SYNC ;- synchronous data
 ;-----------------------------------------------------------------------
 ; SS1...... subscript 1 - identifies data
 ;            HR   - hourly
 ;            NMSP - namespace
 ;            PROT - protocol
 ; SS2...... subscript 2 - identifies data sorted within SS1
 ;            IO   - incoming/outgoing messages
 ;            LR   - local/remote messages
 ;            PR   - protocol
 ;            TM   - type of transmission
 ;            
 ; SS3...... subcript 3 - which identifier for SS2 is being sorted
 ;            IO   - I - incoming
 ;                   O - outgoing
 ;                   U - unknown
 ;            LR   - L - local
 ;                   R - remote
 ;                   U - unknown
 ;            PR   - P - placeholder for consistent subscripting
 ;            TM   - M - mailman
 ;                   T - tcp
 ;                   U -unknown
 ; SS4...... subscript 4 - according to SS1
 ;            HR   - date.time
 ;            NMSP - namespace
 ;            PROT - protocal
 ; SS5...... subcript 5 - according to SS1
 ;            HR   - namespace
 ;            NMSP - date.tim
 ;            PROT - namespace
 ; SS6...... subscript 6 - according to SS1
 ;            HR   - protocol
 ;            NMSP - protocol
 ;            PROT - date.time
 ;-----------------------------------------------------------------------
 Q:$G(GBL)=""
 Q:$G(GBL1)=""
 N SS1,SS2,SS3,SS4,SS5,SS6
 S SS1=""
 F  S SS1=$O(@GBL@(SS1)) Q:SS1=""  I SS1'="RFAC" S SS2="" D 
 .F  S SS2=$O(@GBL@(SS1,SS2)) Q:SS2=""  S SS3="" D 
 ..F  S SS3=$O(@GBL@(SS1,SS2,SS3)) Q:SS3=""  S SS4="" D 
 ...F  S SS4=$O(@GBL@(SS1,SS2,SS3,SS4)) Q:SS4=""  S SS5="" D 
 ....Q:SS1="PROT"&(SS4="ZZZ")
 ....F  S SS5=$O(@GBL@(SS1,SS2,SS3,SS4,SS5)) Q:SS5=""  S SS6="" D 
 .....; if SS1="NMSP" or SS1="PROT" quit if SS4 and SS5 (protocol/
 .....;                             namespace pair) = ZZZ
 .....I SS1="NMSP"!(SS1="PROT") Q:SS4="ZZZ"&(SS5="ZZZ")
 .....F  S SS6=$O(@GBL@(SS1,SS2,SS3,SS4,SS5,SS6)) Q:SS6=""  D 
 ......Q:SS1="HR"&(SS6="ZZZ")
 ......Q:SS1="NMSP"&(SS6="ZZZ")
 ......; compile data into daily stats for file #8973.1 (CM HL7 DATA)
 ......D COMPILE^KMPDHU03
 ;
 D:$D(@GBL1) FILE^KMPDHU03(1)
 ;
 K @GBL1
 ;
 Q

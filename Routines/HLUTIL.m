HLUTIL ;SFISC/RJH- Utilities for HL7 TCP    ;06/03/2008  11:20
 ;;1.6;HEALTH LEVEL SEVEN;**36,19,57,64,66,109,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;For TCP only
MSGSTAT(X) ;message status
 ;input value:   X = message id
 ;return value: status^status updated^error msg.^error type pointer^
 ;queue position or # of retries^# open failed^ack timeout
 ;      status:
 ;               0 = message doesn't exist
 ;               1 = waiting in queue
 ;             1.5 = opening connection
 ;             1.7 = awaiting response, # of retries
 ;               2 = awaiting application ack
 ;               3 = successfully completed
 ;               4 = error
 ;               8 = being generated
 ;               9 = awaiting processing
 Q:$G(X)']"" 0
 N C,I,L,Y,Z
 S Y=$O(^HLMA("C",X,0)) Q:'Y 0
 ;lock node to flush disk buffers
 L +^HLMA(Y,"P"):3 S Z=$G(^HLMA(Y,"P"))
 S:'Z Z=0
 ;if pending, get queue position
 I +Z=1 D
 . ;get Logical Link, if msg. not in x-ref, then it is being sent
 . S L=+$P(^HLMA(Y,0),U,7) Q:'$D(^HLMA("AC","O",L,Y))
 . ;find position in queue, if greater than 2 - use 2
 . S I=Y F C=1:1:2 S I=$O(^HLMA("AC","O",L,I),-1) Q:'I
 . S $P(Z,U,5)=C
 L -^HLMA(Y,"P")
 Q Z
 ;
MSGACT(X,HLIENACT) ;outgoing message action
 ;input value:   X = message id
 ;               HLIENACT = 1-cancel; 2-requeue
 ;return value:  1 = action sucessful
 ;               0 = action failed
 Q:$G(X)']"" 0
 N HLIEN,HLIEN0,HLSTAT,HLTCP,Y,LINK
 S HLIEN=+$O(^HLMA("C",X,0)) Q:'HLIEN 0
 S HLIEN0=$G(^HLMA(HLIEN,0)) Q:'HLIEN0 0
 ;must be outgoing
 Q:$P(HLIEN0,U,3)'="O" 0
 F Y=1:1:3 L +^HLMA(HLIEN,"P"):1 Q:$T  H 1
 E  Q 0
 ;
 ;**109**
 S LINK=$P($G(^HLMA(HLIEN,0)),"^",7)
 ;
 S HLSTAT=1
 ;cancel
 I HLIENACT=1 D
 . ;HLTCP is set so that file 773 is updated
 . S HLTCP=""
 . D STATUS^HLTF0(HLIEN,3,,"Cancelled by application",1)
 .;
 .;**109**
 . D DEQUE^HLCSREP(LINK,"O",HLIEN)
 .;
 ;requeue
 I HLIENACT=2 D
 . N DA,DIK,HLJ
 . ;check for type=outgoing and logical link, need for "AC" x-ref
 . I $P(HLIEN0,U,3)'="O"!('$P(HLIEN0,U,7)) S HLSTAT=0 Q
 . ;set status=pend transmission
 . S Y=$NA(HLJ(773,HLIEN_",")),@Y@(20)=1
 . ;delete status update, error msg, error type, date processed
 . S (@Y@(21),@Y@(22),@Y@(23),@Y@(100))="@"
 . D FILE^HLDIE("","HLJ","","MSGACT","HLUTIL") ; HL*1.6*109
 . ;**109**
 . ;need to set "AC" x-ref
 .; S DA=HLIEN,DIK="^HLMA(",DIK(1)="7^AC"
 .; D EN1^DIK
 .;
 .;**109**
 . D ENQUE^HLCSREP(LINK,"O",HLIEN)
 ;
 L -^HLMA(HLIEN,"P")
 Q HLSTAT
 ;
CHKLL(X) ;check setup of Logical Link
 ;input value:   X = institution number or name
 ;return value:  1 = setup OK
 ;               0 = LL setup incorrect
 N HLF,HLRESLT
 S HLF=$S(X:"I",1:"")
 D LINK^HLUTIL3(X,.HLRESLT,HLF)
 S X=+$O(HLRESLT(0)) Q:'X 0
 Q $$LLOK^HLCSLM(X)
 ;
DONTPURG() ; set the DONT PURGE field to 1 in order to prevent the message
 ; from purging.
 ; return value :  1 for successfully set the field
 ;                -1 for failure
 Q $$SETPURG(1)
 ;
TOPURG() ; clear the DONT PURGE field to allow the message to be purged.
 ; return value :  0 for successfully clear the field
 ;                -1 for failure
 Q $$SETPURG(0)
 ;
SETPURG(STATUS) ; to set or to clear the DONT PURGE field
 ; HLMTIENS = ien in file 773 for this message
 ; input: 1 to set the DONT PURGE field
 ;        0 to clear the DONT PURGE field.
 ; return value: 1 means successfully set the DONT PURGE field
 ;               0 means successfully clear the DONT PURGE field
 ;              -1 means fail to set or to clear the field
 I (STATUS'=1),(STATUS'=0) Q -1
 I '$D(^HLMA(+$G(HLMTIENS),0)) Q -1
 ;
 L +^HLMA(HLMTIENS):30
 E  Q -1
 S $P(^HLMA(HLMTIENS,2),U)=STATUS
 L -^HLMA(HLMTIENS)
 Q STATUS
 ;
REPROC(IEN,RTN) ; reprocessing message
 ; IEN- the message IEN in file 773
 ; RTN- the routine, to be Xecuted for processing the message
 ; return value:  0 for success, -1 for failure
 N HLMTIEN,HLMTIENS,HLNEXT,HLNODE,HLQUIT,HLERR,HLRESLT,HLTCP
 N HL,HDR,FS,ECH,HLMSA,X,X1,X2
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 I '$D(^HLMA(+$G(IEN),0)) Q -1
 ;
 ; patch HL*1.6*142
 ; I $G(RTN)'["" Q -1
 I $G(RTN)']"" Q -1
 ;
 S (HLMTIENS,HLTCP)=+IEN,HLMTIEN=+^HLMA(HLMTIENS,0),HLMSA=$$MSA^HLTP3(HLMTIEN)
 M HDR=^HLMA(HLMTIENS,"MSH")
 D CHK^HLTPCK2(.HDR,.HL,.HLMSA)
 Q:HL'="" -1
 ;
 I RTN["D " X RTN
 I RTN'["D " D
 . I RTN["^" X "D "_RTN
 . I RTN'["^" X "D ^"_RTN
 S HLRESLT=0 S:($D(HLERR)) HLRESLT="9^"_$G(^HL(771.7,9,0))
 ; update the status
 D STATUS^HLTF0(HLMTIENS,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S($D(HLERR):HLERR,HLRESLT:$P(HLRESLT,"^",2),1:""),1)
 Q 0

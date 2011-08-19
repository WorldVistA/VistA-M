LA7UIO ;DALOI/JMC - Process Download Message for #62.48;May 21, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**66**;Sep 27, 1994;Build 30
 ;
 Q
 ;
EN ; Called from LA7UID
 ; Converts the information for each test in the load list
 ; into HL7 messages and hands them to the HL7 package for delivery.
 ; LRLL= IEN in 68.2 Load Worklist file, from field in 62.4
 ; LRINST= IEN IN 62.4 Auto Inst file
 ; LRAUTO= zero node of 62.4 entry
 ; LA76248= IEN in 62.48 Message Parameter file
 ;
 N LA76281,LA7,LA7CUP,LA7CUP1,LA7TRAY,LA7TRAY1
 ;
 ; Preparing automatic download.
 I $G(LA7ADL) D ADL Q
 ;
 S LA7=^LRO(68.2,LRLL,2)
 S LA7TRAY=$P(LA7,"^",2),LA7TRAY1=$P(LA7,"^",4)
 S LA7CUP=$P(LA7,"^",3),LA7CUP1=$P(LA7,"^",5)
 S:$G(LRTRAY1) LA7TRAY=LRTRAY1
 S:$G(LRCUP1) LA7CUP=LRCUP1
 ;
 ; Process each tray on load list
 S LA76821=LA7TRAY-1
 F  S LA76821=$O(^LRO(68.2,LRLL,1,LA76821)) Q:'LA76821!(LA76821>LA7TRAY1)   D
 . I '$D(ZTQUEUED) D
 . . W !!,"Building download record for:"
 . . I LRTYPE W " Tray: ",LA76821,!,"Cup: "
 . . E  W !,"Seq: "
 . D CUP
 D EXIT
 Q
 ;
 ;
CUP ; Process each cup on load list
 N LA76822,LA7QUIT
 ;
 S LA76822=LA7CUP-1,LA7QUIT=0
 F  S LA76822=$O(^LRO(68.2,LRLL,1,LA76821,1,LA76822))  Q:'LA76822  D  Q:LA7QUIT
 . I LA76821=LA7TRAY1,LA76822>LA7CUP1 S LA7QUIT=1 Q
 . ; Kill array of tests for this accession
 . K LA76249,LA7ACC
 . S LA7ACC=^LRO(68.2,LRLL,1,LA76821,1,LA76822,0)
 . ; Not requested loadlist profile.
 . I 'LRPROF,($P(LRPROF,"^",2)'=$P(LA7ACC,"^",4)) Q
 . ;
 . S LRAA=+LA7ACC,LRAD=$P(LA7ACC,"^",2),LRAN=$P(LA7ACC,"^",3)
 . S LA768=LRAA,LA76801=LRAD,LA76802=LRAN
 . S LA7ACC0=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,0),0)
 . ; Accession has been removed, skip.
 . I 'LA7ACC0 D  Q
 . . D CREATE^LA7LOG(24)
 . ;
 . D TEST
 . S LA7INST=LRINST D CHKTEST^LA7ADL
 . N LA7QUIT
 . I $O(LA7ACC(0)) D BUILD^LA7UIO1
 Q
 ;
 ;
TEST ;
 N LA7TST
 ;
 K LA7TREE
 ;
 S LA7TST=0
 F  S LA7TST=$O(^LRO(68.2,LRLL,1,LA76821,1,LA76822,1,LA7TST)) Q:'LA7TST  D
 . N LA7X,LA7PCNT
 . S LA7X=$G(^LRO(68.2,LRLL,1,LA76821,1,LA76822,1,LA7TST,0))
 . S LA7PCNT=0
 . D UNWIND^LA7ADL1(+LA7X,$P(LA7X,"^",2),0)
 Q
 ;
 ;
ADL ; Process/build messages for automatic download, no loadlist.
 ; Called from above by LA7ADL.
 ;
 S LRLL=0,LRAUTO=LA7AUTO(LA7INST)
 ; Set tray/cup to null.
 S (LA76821,LA76822)=""
 ;
 S LA768=LRAA,LA76801=LRAD,LA76802=LRAN
 ; Zeroth node of accession.
 ; Log error if accession has been removed, skip
 S LA7ACC0=$G(^LRO(68,LA768,1,LA76801,1,LA76802,0),0)
 I 'LA7ACC0 D  Q
 . D CREATE^LA7LOG(24)
 ;
 D BUILD^LA7UIO1
 D EXIT
 K LRAUTO,LRINST,LRLL
 Q
 ;
EXIT ;
 D KVAR^LRX
 K LA7,LA71,LA76249,LA768,LA76801,LA76802,LA76821,LA76822,LA7ACC,LA7ACC0
 K LA7CNT,LA7CODE,LA7DATA,LA7DTIM,LA7MSH,LA7NVAF,LA7OBR,LA7ORC,LA7PID,LA7PIDSN,LA7PV1,LA7TMP,LRINFW
 ;
 Q

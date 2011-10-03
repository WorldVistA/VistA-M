LA7VIN1 ;DALOI/JMC - Process Incoming UI Msgs, continued ; 01/14/99
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64**;Sep 27, 1994
 ; This routine is a continuation of LA7VIN and is only called from there.
 ; It is called with each message found in the incoming queue.  
 Q
 ;
NXTMSG ;
 N FDA,LA7ABORT,LA7CNT,LA7END,LA7ERR
 N LA7INDX,LA7QUIT,LA7SEG,LA7STYP
 ;
 S LA7ERR=""
 S (LA7ABORT,LA7CNT,LA7END,LA7INDX,LA7QUIT,LA7SEQ)=0
 S DT=$$DT^XLFDT
 S LA7ID="UNKNOWN-I-"
 ;
 ; Message built but no text.
 I '$O(^LAHM(62.49,LA76249,150,0)) D  Q
 . S (LA7ABORT,LA7ERR)=6
 . D CREATE^LA7LOG(LA7ERR)
 . D SETID^LA7VHLU1(LA76249,LA7ID,"UNKNOWN")
 ;
 ; Process message segments
 ; Lab currently does not accept segments beginning with the letter "Z"
 ; which are reserved for locally-defined messages. "Z" segments will be
 ; ignored by this software.
 F  S LA7END=$$GETSEG^LA7VHLU2(LA76249,.LA7INDX,.LA7SEG) Q:LA7END!(LA7ABORT)  D
 . S LA7STYP=$E(LA7SEG(0),1,3) ; Segment type
 . I $E(LA7STYP,1)="Z" Q
 . ; Not a valid segment type
 . I LA7STYP'?2U1UN D  Q
 . . S LA7ERR=34
 . . D CREATE^LA7LOG(LA7ERR)
 . ; Segment encoded wrong - field separator does not match
 . I "MSH^FSH^BHS^"'[(LA7STYP_"^"),$E(LA7SEG(0),4)'=LA7FS D  Q
 . . S LA7ERR=35
 . . D CREATE^LA7LOG(LA7ERR)
 . I $T(@LA7STYP)="" Q  ; No processing logic for this segment type
 . D @LA7STYP
 ;
 ; Set id if only MSH segment received.
 I LA7SEQ<5 D
 . D SETID^LA7VHLU1(LA76249,LA7ID,"UNKNOWN")
 ;
 ; Set status to purgeable if no errors.
 I $P($G(^LAHM(62.49,LA76249,0)),"^",3)'="E" D
 . S FDA(1,62.49,LA76249_",",2)="X"
 . D FILE^DIE("","FDA(1)","LA7ERR(1)")
 ;
 ; Store identifier's found in message.
 D UPID^LA7VHLU1(LA76249)
 ;
 ; Send new result alert for ORU messages if turned on.
 ; Currently only on LEDI (10) type interfaces.
 I $G(LA7MTYP)="ORU",$D(^LAHM(62.48,+$G(LA76248),20,"B",1)) D
 . I LA7INTYP=10,$D(^TMP("LA7-ORU",$J,LA76248)) D XQA^LA7UXQA(1,LA76248)
 ;
 ; Send new order alert for ORM messages if turned on.
 I $G(LA7MTYP)="ORM",$D(^LAHM(62.48,+$G(LA76248),20,"B",3)) D
 . N LA7ROOT
 . S LA7ROOT="^TMP(""LA7-ORM"",$J)"
 . F  S LA7ROOT=$Q(@LA7ROOT) Q:$QS(LA7ROOT,1)'="LA7-ORM"!($QS(LA7ROOT,2)'=$J)  D
 . . D XQA^LA7UXQA(3,$QS(LA7ROOT,3),"",$QS(LA7ROOT,4),"",$QS(LA7ROOT,5))
 ;
 ; Cleanup shipping config test info used to process orders
 I $G(LA7MTYP)="ORM" K ^TMP("LA7TC",$J)
 ;
 ; If amended results received then send bulletins
 I $D(^TMP("LA7 AMENDED RESULTS",$J)) D SENDARB^LA7VIN1A
 ;
 ; If cancelled orders received then send bulletins
 I $D(^TMP("LA7 ORDER STATUS",$J)) D SENDOSB^LA7VIN1A
 ;
 ; If units/normals changed then send bulletins
 I $D(^TMP("LA7 UNITS/NORMALS CHANGED",$J)) D SENDUNCB^LA7VIN1A
 ;
 ; If abnormal/critical results then send bulletins
 I $D(^TMP("LA7 ABNORMAL RESULTS",$J)) D SENDACB^LA7VIN1A
 ;
 D KILLMSH
 ;
 Q
 ;
 ;
MSA ;; Process MSA segment
 ;
 D KILLMSA
 ;
 D MSA^LA7VIN3
 ;
 ; Set sequence flag
 S LA7SEQ=5
 Q
 ;
 ;
BSH ;; Process various HL7 header segments
FSH ;;
MSH ;;
 D KILLMSH
 ;
 D MSH^LA7VIN2
 ;
 ; Set sequence flag
 S LA7SEQ=1
 Q
 ;
 ;
NTE ;; Process NTE segment
 ;
 I LA7SEQ<30 D  Q
 . ; Put code to log error - no OBR/OBX segment
 ;
 ; Flag set that there was problem with OBR segment,
 ; skip associated NTE segments that follow OBR/OBX segments
 I LA7QUIT=2 Q
 ;
 I LA7MTYP="ORU" D NTE^LA7VIN2
 I LA7MTYP="ORM" D NTE^LA7VIN2
 I LA7MTYP="ORR" D NTE^LA7VIN2
 ;
 Q
 ;
 ;
OBR ;; Process OBR segment
 ;
 D KILLOBR
 ;
 ; Clear flag to process this segment
 I LA7QUIT=2 S LA7QUIT=0
 ;
 ; If not UI interface and no PID segment
 I LA7INTYP'=1,LA7SEQ<10 D  Q
 . S (LA7ABORT,LA7ERR)=46
 . D CREATE^LA7LOG(LA7ERR)
 ;
 I LA7MTYP="ORR" D OBR^LA7VIN4
 I LA7MTYP="ORU" D OBR^LA7VIN4
 I LA7MTYP="ORM" D OBR^LA7VORM
 ;
 ; Set sequence flag
 S LA7SEQ=30
 Q
 ;
 ;
OBX ;; Process OBX segment
 ;
 D KILLOBX
 ;
 ; No OBR segment, can't process OBX
 I LA7SEQ<30 D  Q
 . S (LA7ABORT,LA7ERR)=9
 . D CREATE^LA7LOG(LA7ERR)
 ;
 ; Flag set that there was problem with OBR segment,
 ; skip associated OBX segments that follow OBR segment
 I LA7QUIT=2 Q
 ;
 ; Process result messages (ORU).
 I LA7MTYP="ORU" D
 . ; Process "CH" subscript results.
 . I $G(LA7SS)="CH" D
 . . I '$G(LA7ISQN) Q  ; No place to store results
 . . D OBX^LA7VIN5
 . ;
 . ; Process "AP" subscript results.
 . ;I $G(LA7SS)="AP",$L($T(OBX^LA7VIN6)) D OBX^LA7VIN6
 . ;
 . ; Process "MI" subscript results.
 . ;I $G(LA7SS)="MI" D OBX^LA7VIN7
 . ;
 . ; Process "BB" subscript results.
 . ;I $G(LA7SS)="BB",$L($T(OBX^LA7VIN8)) D OBX^LA7VIN8
 . ;
 . ; Update test status on manifest
 . I $G(LA7628),LA7UID'="",$G(LA7OTST) D UTS^LA7VHLU1(LA7628,LA7UID,LA7OTST)
 ;
 ; Process results that accompany orders
 I LA7MTYP="ORM" D OBX^LA7VIN5
 ;
 ; Set sequence flag
 S LA7SEQ=40
 Q
 ;
 ;
ORC ;; Process ORC segment
 ;
 D KILLORC
 ;
 ; If not UI interface and no PID segment
 I LA7INTYP'=1,LA7SEQ<10 D  Q
 . S (LA7ABORT,LA7ERR)=46
 . D CREATE^LA7LOG(LA7ERR)
 ;
 D ORC^LA7VIN2
 ;
 ; Set sequence flag
 S LA7SEQ=20
 Q
 ;
 ;
PID ;; Process PID segment
 ;
 D KILLPID
 ;
 ; no MSH segment
 I LA7SEQ<1 D  Q
 . S (LA7ABORT,LA7ERR)=7
 . D CREATE^LA7LOG(LA7ERR)
 ;
 ; Clear flag to process this segment
 I LA7QUIT=1 S LA7QUIT=0
 ;
 D PID^LA7VIN2
 ;
 ; Set sequence flag
 S LA7SEQ=10
 Q
 ;
 ;
PV1 ;; Process PV1 segment
 ;
 D KILLPV1
 ;
 ; no PID segment
 I LA7SEQ<10 D  Q
 . S (LA7ABORT,LA7ERR)=46
 . D CREATE^LA7LOG(LA7ERR)
 ;
 D PV1^LA7VIN2
 ;
 ; Set sequence flag
 S LA7SEQ=11
 Q
 ;
 ;
 ; The section below is designed to clean up variables that are created
 ; during the processing of a segment type and any created by processing
 ; of segments that are within the message definition.
 ;
KILLMSH ; Clean up variables used by MSH and following segments
 K LA7CSITE,LA7CS,LA7ECH,LA7FS,LA7HLV,LA7MEDT,LA7MID,LA7MTYP
 K LA7RAP,LA7RFAC,LA7SAP,LA7SEQ,LA7SFAC
 K ^TMP("LA7-ID",$J),^TMP("LA7-ORM",$J),^TMP("LA7-ORU",$J)
 ;
KILLMSA ; Clean up variables used by MSA and following segments
 K LA7MSATM
 ;
KILLPID ; Clean up variables used by PID and following segments
 K DFN
 K LA7DOB,LA7ICN,LA7PNM,LA7PRACE,LA7PTID2,LA7PTID3,LA7PTID4
 K LA7SEX,LA7SPID,LA7SSN
 K LRDFN,LRTDFN
 ;
KILLPV1 ; Clean up variables used by PV1 and following segments
 K LA7LOC,LA7SPV1
 ;
KILLORC ; Clean up variables used by ORC and following segments
 K LA7628,LA7629
 K LA7CSITE,LA7DUR,LA7DURU,LA7ODUR,LA7ODURU,LA7EOL,LA7OCR,LA7ORDT
 K LA7OTYPE,LA7OUR,LA7PEB,LA7PON,LA7POP,LA7PVB,LA7SM
 ;
KILLOBR ; Clean up variables used by OBR and following segments
 K LA70070,LA760,LA761,LA762,LA7624,LA7696
 K LA7AA,LA7AD,LA7ACC,LA7AN,LA7CDT,LA7FID,LA7ISQN,LA7LWL,LA7ONLT,LA7OTST
 K LA7POC,LA7SAC,LA7SID,LA7SOBR,LA7SPEC,LA7SPTY,LA7SS,LA7UID,LA7UR
 ;
KILLOBX ; Clean up variables used by OBX and following segments
 K LA7ORS,LA7RLNC,LA7RMK,LA7RNLT,LA7RO,LA7SOBX
 ;
KILLBLG ;Clean up variables used by BLG and following segments
 ;
 Q

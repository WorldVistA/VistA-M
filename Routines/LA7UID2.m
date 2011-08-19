LA7UID2 ;DALOI/JRR - Process Download Message for an entry in 62.48 ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,27,57**;Sep 27, 1994
 Q
 ;
BUILD ; Build one accession into an HL7 message
 ;
 ; HL7 package expects the HLSDATA array to contain the msg
 K HLSDATA
 ;
 ; Build segments
 D MSH
 Q:$D(LA7ERR)
 D ORC
 D PID
 D PV1
 D OBR
 ; Build entry in MESSAGE QUEUE file 62.49
 D Q6249
 S HLMTN="ORU"
 ; Send message
 D EN1^HLTRANS
 ;
 ; Set status to purgeable
 I $G(LA76249),$P($G(^LAHM(62.49,LA76249,0)),"^",3)'="E" D
 . N DIE,DA,DR
 . S DIE="^LAHM(62.49,",DA=LA76249,DR="2////X"
 . D ^DIE
 ;
 D KVAR^LRX
 Q
 ;
 ;
MSH ;requires LA7NDAP= IEN in 770 HL7 NON-DHCP APPLICATION file
 D KILL^HLTRANS ;kill HL variables
 S HLNDAP=LA7NDAP ;required variable before calling INIT^HLTRANS
 D INIT^HLTRANS ;set up required HL variables
 K LA7ERR
 I $D(HLERR) D CREATE^LA7LOG(4) S LA7ERR="" QUIT
 S HLSDATA(0)=$$MSH^HLFNC1("ORM")
 Q
ORC ;
 K LA7ORC
 S LA7ORC(1)="NW"
 S LA7ORC(3)=$G(^LRO(68,LA768,1,LA76801,1,LA76802,.1))
 S LA7ORC(12)=$P(LA7ACC0,"^",8) ;provider
 S:LA7ORC(12) LA7ORC(12)=$E(HLECH)_$$HLNAME^HLFNC($$GET1^DIQ(200,LA7ORC(12)_",",.01))
 F LA7=0:0 S LA7=$O(LA7ORC(LA7)) Q:'LA7  D
 . S $P(LA7ORC,HLFS,LA7)=LA7ORC(LA7)
 S HLSDATA(3)="ORC"_HLFS_LA7ORC
 Q
PID K LA7PID
 S LRDFN=+LA7ACC0 K LRDPF
 D DEM^LRX
 S LA7PID(3)=$$M11^HLFNC(LRDFN)
 S LA7PID(5)=$$HLNAME^HLFNC(PNM)
 I $L(SEX) S LA7PID(8)=$S("FM"[SEX:SEX,1:"U")
 I $L(SSN) S LA7PID(19)=SSN
 I DOB S LA7PID(7)=$$HLDATE^HLFNC(DOB,"DT")
 S LA7PID=""
 F LA7=0:0 S LA7=$O(LA7PID(LA7)) Q:'LA7  D
 . S $P(LA7PID,HLFS,LA7)=LA7PID(LA7)
 S HLSDATA(1)="PID"_HLFS_LA7PID
 Q
PV1 K LA7PV1
 S LA7PV1(3)=$P(LA7ACC0,"^",7)
 S LA7PV1=""
 F LA7=0:0 S LA7=$O(LA7PV1(LA7)) Q:'LA7  D
 . S $P(LA7PV1,HLFS,LA7)=LA7PV1(LA7)
 S HLSDATA(2)="PV1"_HLFS_LA7PV1
 Q
OBR ;
 I '$D(ZTQUEUED),$G(LRLL) W:$X+5>IOM !,$S($G(LRTYPE):"Cup",1:"Seq"),": " W LA76822,", "
 N LA760,LA7CDT,LA7CMT,LA7I,LA7SPEC
 K LA7OBR
 S LA7CNT=0
 ; Get infection warning if any.
 S LRINFW=$G(^LR(LRDFN,.091))
 ; Collection date/time node.
 S LA7=$G(^LRO(68,LA768,1,LA76801,1,LA76802,3))
 ; Draw time - If time invalid adjust to next lower valid time
 I LA7 D
 . N LA7X
 . S LA7X=$$CHKDT(+LA7)
 . S LA7CDT=$$HLDATE^HLFNC(LA7X,"TS")
 S LA7CMT=$TR($P(LA7,"^",6),"~") ; Specimen comment if any, strip "~".
 S LA7=+$G(^LRO(68,LA768,1,LA76801,1,LA76802,5,1,0)) ;specimen
 S LA7SPEC=$$GET1^DIQ(61,LA7_",","LEDI HL7:HL7 ABBR") ;HL7 code from Topography
 S LA7UID=$P($G(^LRO(68,LA768,1,LA76801,1,LA76802,.3)),"^") ;unique ID
 S LA7ACC=$P($G(^LRO(68,LA768,1,LA76801,1,LA76802,.2)),"^") ;accession
 S LA7I=0
 F  S LA7I=$O(LA7ACC(LA7I)) Q:'LA7I  D
 . K LA7OBR
 . S LA760=+LA7ACC(LA7I)
 . S LA7TMP=$G(^TMP("LA7",$J,LA7INST,LA7I))
 . Q:'LA7TMP
 . S LA7CODE=$P(LA7TMP,"^",6)
 . S LA7DATA=$P(LA7TMP,"^",7)
 . S LA7CNT=LA7CNT+1,LA7OBR(1)=LA7CNT
 . S LA7OBR(4)=LA7CODE_$E(HLECH)_$P(LA7TMP,"^",4)_$E(HLECH)_99001_$E(HLECH)_LA760_"X"_LA7DATA_$E(HLECH)_$P(^LAB(60,LA760,0),"^")_$E(HLECH)_99002
 . I $G(LA7CDT) S LA7OBR(7)=LA7CDT ; Draw time.
 . I $L(LRINFW) S LA7OBR(12)=$E(HLECH)_LRINFW ; Infection warning.
 . S LA7OBR(13)=LA7CMT ; Specimen comment
 . S LA7OBR(15)=LA7SPEC ;HL7 code from Topography
 . I LRDPF'=2 S $P(LA7OBR(15),$E(HLECH),3)=$S(LRDPF=62.3:"CONTROL",1:"")
 . S LRCADR="" S LRCADR=$O(^LAB(62.4,"B",$P(LRAUTO,"^"),LRCADR))
 . S LA7D0=+$G(LRCADR) ;KAT
 . S LRCADR=$P($G(^LAB(62.4,+LRCADR,9)),U,9)
 . S LA7OBR(18)=$P(LRAUTO,"^")_$E(HLECH)_LRCADR ;instrument name^card address
 . K LRCADR ;KAT added instrument address
 . S LA7OBR(19)=""
 . F LA7="LA76821","LA76822","LA768","LA76801","LA76802","LA7ACC","LA7UID" D
 . . I LA7="LA76821",'$G(LRFORCE),LA76821 N LA76821 S LA76821="" ; No tray if don't send tray/cup flag.
 . . I LA7="LA76822",'$G(LRFORCE),LA76822 N LA76822 S LA76822="" ; No cup if don't send tray/cup flag.
 . . S LA7OBR(19)=LA7OBR(19)_@LA7_$E(HLECH)
 . . ; LA7OBR(19)=tray^cup^lraa^lrad^lran^lracc^lruid
 . S LA7=+$P(LA7ACC(LA7I),"^",2) ; Test urgency.
 . S LA7=$P($G(^LAB(62.05,LA7,0)),"^",4) ; HL7 priority from Urgency file.
 . S $P(LA7OBR(27),$E(HLECH),6)=$S($L(LA7):LA7,1:"R") ; HL7 priority, default routine (R).
 . S LA7=$P($G(^LRO(68,LA768,.4)),"^",2)
 . ;KAT-Added using field .04 in Auto Instr file.
 . S LA7D0=+$P($G(^LAB(62.4,+LA7D0,9)),U,10)
 . S LA7OBR(2)=$S(LA7="L":LA7UID,1:$E("0000000000",1,LA7D0-$L(LA76802))_LA76802) ;long or short sample ID
 . K LA7D0
 . F LA7=0:0 S LA7=$O(LA7OBR(LA7)) Q:'LA7  D
 . . S $P(LA7OBR,HLFS,LA7)=LA7OBR(LA7)
 . S HLSDATA(3+LA7CNT)="OBR"_HLFS_LA7OBR
 Q
 ;
 ;
CHKDT(LA7X) ; Check validity of date/time
 ; Adjust invalid times to closest valid time - correct for lab problem
 ; that generated invalid FileMan date/times.
 ; If hours>24 then set to 24 with no minutes/seconds
 ; If minutes greater than 59 then set to 59
 ; If seconds greater than 59 then set to 59
 ;
 N I,LA7Y,X
 ;
 S LA7Y=$P(LA7X,".",2)
 ;
 ; If time present then check otherwise skip and return input.
 I $L(LA7Y) D
 . F I=1:2:5 D
 . . S LA7Y(I)=$E(LA7Y,I,I+1)
 . . I $L(LA7Y(I))=1 S LA7Y(I)=LA7Y(I)_"0"
 . . I LA7Y(I)>$S(I=1:24,1:59) S LA7Y(I)=$S(I=1:24,1:59)
 . . I I=1,LA7Y(1)=24 S LA7Y=24
 . S X="."_LA7Y(1)_LA7Y(3)_LA7Y(5),X=+X
 . S $P(LA7X,".",2)=$P(X,".",2)
 ;
 Q LA7X
 ;
 ;
Q6249 ; create an entry in the MESSAGE QUEUE file to store this message
 ;
 N DIC,DINUM,DLAYGO
 ;
 S LA7DTIM=$$NOW^XLFDT
 L +^LAHM(62.49,0):9999999
 F X=$P(^LAHM(62.49,0),"^",3):1 Q:'$D(^LAHM(62.49,X))
 S LA76249=X
 K DD,DO
 S DIC="^LAHM(62.49,",DIC(0)="LF",DLAYGO=62.49
 S DINUM=X
 S DIC("DR")="1////O;3////3;4////"_LA7DTIM_";.5////"_LA76248
 S DIC("DR")=DIC("DR")_";2////Q;5////"_$P(LRAUTO,"^",1)_"-O-"_LA7UID
 D FILE^DICN
 L -^LAHM(62.49,0)
 S LA7MSH=HLSDATA(0)
 I HLFS'="^" S LA7MSH=$TR(LA7MSH,"^"," "),LA7MSH=$TR(LA7MSH,HLFS,"^")
 S ^LAHM(62.49,LA76249,100)=LA7MSH
 S LA71=0,LA7=""
 F  S LA7=$O(HLSDATA(LA7)) Q:LA7=""  D
 . S LA71=LA7
 . S ^LAHM(62.49,LA76249,150,LA7+1,0)=HLSDATA(LA7)
 S ^LAHM(62.49,LA76249,150,0)="^^"_LA71_"^"_LA71_"^"_DT
 Q

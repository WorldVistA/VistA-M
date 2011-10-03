LA7UIIN1 ;DALOI/JRR - Process Incoming UI Msgs, continued ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,23,27,57,59**;Sep 27, 1994
 ; This routine is a continuation of LA7UIIN and is only
 ; called from there.  It is called with each message found
 ; in the incoming queue.  
 ;
 Q
 ;
NXTMSG ;
 N LA70070,LA7150,LA761,LA762,LA7624,LA762495
 N LA7AA,LA7AD,LA7ACC,LA7CNT,LA7CS,LA7CUP,LA7ECH,LA7ENTRY,LA7FS,LA7IDE,LA7LWL,LA7MSH,LA7OBR,LA7OBR3,LA7QUIT,LA7TRAY,LA7USID
 N CUP,IDE,IDENT,ISQN
 ;
 S (LA7CNT,LA7QUIT)=0
 S (LA7AN,LA7INST,LA7OBR,LA7UID)=""
 S DT=$$DT^XLFDT
 ; Message built but no text.
 I '$O(^LAHM(62.49,LA76249,150,0)) D  Q
 . D CREATE^LA7LOG(6)
 ;
MSH S LA7MSH=$G(^($O(^LAHM(62.49,LA76249,150,0)),0))
 ; Bad first line of message
 I $E(LA7MSH,1,3)'="MSH" D  Q
 . D CREATE^LA7LOG(7)
 S LA7FS=$E(LA7MSH,4)
 S LA7CS=$E(LA7MSH,5)
 S LA7ECH=$E(LA7MSH,5,8)
 ; No field or component seperator
 I LA7FS=""!(LA7CS="") D  Q
 . D CREATE^LA7LOG(8)
 ;
 ; Find the OBR segment
 S LA762495=0
OBR F  S LA762495=$O(^LAHM(62.49,LA76249,150,LA762495)) Q:'LA762495!($E($G(^(+LA762495,0)),1,3)="OBR")
 S DT=$$DT^XLFDT
 ;
 ; No more OBR's, found at least 1.
 I 'LA762495,$L($G(LA7OBR)) Q
 ;
 S LA7OBR=$G(^LAHM(62.49,LA76249,150,+LA762495,0))
 ;
 ; Should only be working on OBR
 I $E(LA7OBR,1,3)'="OBR" D  Q
 . D CREATE^LA7LOG(9)
 ;
 ; Extracting 1st piece
 S LA7INST=$P($P(LA7OBR,LA7FS,19),LA7CS,1)
 I LA7INST="" D  Q
 . D CREATE^LA7LOG(10)
 S LA7624=+$O(^LAB(62.4,"B",LA7INST,0))
 ; Instrument name not found in xref
 I 'LA7624 D  Q
 . D CREATE^LA7LOG(11)
 S LA7INST=$G(^LAB(62.4,LA7624,0))
 ; Instrument entry not found in file
 I LA7INST="" D  Q
 . D CREATE^LA7LOG(11)
 ;
 S LA7ENTRY=$P(LA7INST,"^",6) ;LOG,LLIST,IDENT or SEQN
 S:LA7ENTRY="" LA7ENTRY="LOG"
 ;
 ; Universal service id
 S LA7USID=$P(LA7OBR,LA7FS,4)
 ;
 S LA7TRAY=+$P($P(LA7OBR,LA7FS,20),LA7CS,1) ;Tray
 S LA7CUP=+$P($P(LA7OBR,LA7FS,20),LA7CS,2) ; Cup
 S LA7AA=+$P($P(LA7OBR,LA7FS,20),LA7CS,3) ;  Accession Area
 S LA7AD=+$P($P(LA7OBR,LA7FS,20),LA7CS,4) ;  Accession Date
 S LA7AN=+$P($P(LA7OBR,LA7FS,20),LA7CS,5) ;  Accession Entry
 S LA7ACC=$P($P(LA7OBR,LA7FS,20),LA7CS,6) ;  Accession
 S LA7UID=$P($P(LA7OBR,LA7FS,20),LA7CS,7) ;  Unique ID
 S LA7IDE=$P($P(LA7OBR,LA7FS,20),LA7CS,8) ;  Sequence Number
 S LA7LWL=$P(LA7INST,"^",4) ;  Load/Work List
 S LA7OBR3=$P(LA7OBR,LA7FS,3) ; Sample ID or Bar code
 S LA7OBR(15)=$P(LA7OBR,LA7FS,16) ; Specimen source
 ;
 ; UID might come as Sample ID
 I LA7UID="",LA7OBR3?10UN S LA7UID=LA7OBR3
 ;
 ; Try to figure out LRAA LRAD LRAN by using the unique ID (LRUID)
 ; accession may have rolled over, use UID to get current accession info.
 I LA7UID]"" D
 . N X
 . S X=$Q(^LRO(68,"C",LA7UID))
 . I $QS(X,3)'=LA7UID S LA7UID="" Q  ; UID not on file.
 . S LA7AA=+$QS(X,4),LA7AD=+$QS(X,5),LA7AN=+$QS(X,6)
 ; If still not known, compute from default date and accession area
 ; Calculate accession date based on accession transform.
 I '(LA7AA*LA7AD*LA7AN) D
 . N X
 . S DT=$$DT^XLFDT
 . S LA7AA=+$P(LA7INST,"^",11)
 . S X=$P($G(^LRO(68,LA7AA,0)),U,3)
 . S LA7AD=$S(X="D":DT,X="M":$E(DT,1,5)_"00",X="Y":$E(DT,1,3)_"0000",X="Q":$E(DT,1,3)_"0000"+(($E(DT,4,5)-1)\3*300+100),1:DT)
 . S LA7AN=+LA7OBR3
 ; Log but cont
 I LA7ENTRY="LOG",'$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)) D
 . D CREATE^LA7LOG(13)
 ; cup=sequence number
 I LA7ENTRY="LLIST" S:'LA7CUP LA7CUP=LA7IDE
 ;
 ; Create entry in ^LAH global
 D LAGEN
 ; Couldn't create entry in ^LAH
 I $G(LA7ISQN)="" D  Q
 . D CREATE^LA7LOG(14)
 ;
 ; specimen(topography), collection sample, HL7 specimen source
 S (LA761,LA762,LA70070)=""
 I $O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,0)) D
 . N X
 . S X=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,0))
 . ; specimen^collection sample
 . S X(0)=$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,X,0))
 . S LA761=$P(X(0),"^") ; specimen
 . S LA762=$P(X(0),"^",2) ; collection sample
 . ; HL7 code from Topography
 . I LA761 S LA70070=$$GET1^DIQ(61,LA761_",","LEDI HL7:HL7 ABBR")
 ;
 ; Log error when specimen source does not match accession's specimen
 I $L(LA70070),$L($P($P(LA7OBR(15),LA7CS),$E(LA7ECH,4))) D
 . ; Check if using HL7 table 0070
 . I $P($P(LA7OBR(15),LA7CS),$E(LA7ECH,4),3)'["0070" Q
 . ; Message matches accession
 . I LA70070=$P($P(LA7OBR(15),LA7CS),$E(LA7ECH,4)) Q
 . D CREATE^LA7LOG(22)
 . S LA7QUIT=1
 ;
 ; Something wrong, process next OBR
 I LA7QUIT S LA7QUIT=0 G OBR
 ;
 ; Zeroth node of acession area.
 S LA7AA(0)=$G(^LRO(68,+LA7AA,0))
 ;
 ; No subscript defined for this area.
 I $P(LA7AA(0),"^",2)="" G OBR
 ;
 ; Processing of this subscript not supported.
 I "CHMI"'[$P(LA7AA(0),"^",2) G OBR
 ;
 S LA7150=LA762495
 ; Process "CH" subscript results - NTE and OBX segments.
 I $P(LA7AA(0),"^",2)="CH" D NTE^LA7UIIN2
 ;
 ; Process "MI" subscript results.
 I $P(LA7AA(0),"^",2)="MI" D
 . N X
 . S X="LA7UIIN3" X ^%ZOSF("TEST") Q:'$T
 . D MI^LA7UIIN3
 ;
 ; No more segments to process, reached end of global array.
 I 'LA762495 Q
 ;
 ; Reset subscript variable.
 I LA762495>LA7150 S LA762495=LA762495-1
 ;
 ; Go back to find/process additional OBR segments.
 G OBR
 ;
 ;
LAGEN ; subroutine to set up variables for call to ^LAGEN, build entry in LAH
 ; requires LA7INST,LA7TRAY,LA7CUP,LA7AA,LA7AD,LA7AN,LA7LWL
 ; returns LA7ISQN=subscript to store results in ^LAH global
 ;
 K TRAY,CUP,LWL,WL,LROVER,METH,LOG,IDENT,ISQN
 K LADT,LAGEN,LA7ISQN
 ;
 S LA7ISQN=""
 S TRAY=+$G(LA7TRAY) S:'TRAY TRAY=1
 S CUP=+$G(LA7CUP) S:'CUP CUP=1
 S LWL=LA7LWL
 I '$D(^LRO(68.2,+LWL,0)) D  Q
 . D CREATE^LA7LOG(19)
 ;
 ; Set accession area to area of specimen, allow multiple areas on same instrument.
 S WL=LA7AA
 I '$D(^LRO(68,+WL,0)) D  Q
 . D CREATE^LA7LOG(20)
 ;
 S LROVER=$P(LA7INST,"^",12)
 S METH=$P(LA7INST,"^",10)
 S LOG=LA7AN
 ; Identity field
 S IDENT=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),"^",6)
 S IDE=+LA7IDE
 S LADT=LA7AD
 ;
 ; This disregards the CROSS LINK field in 62.4
 D @(LA7ENTRY_"^LAGEN")
 S LA7ISQN=$G(ISQN)
 ;
 Q

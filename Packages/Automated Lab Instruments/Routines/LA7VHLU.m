LA7VHLU ;DALOI/JMC - HL7 segment builder utility ;12/07/11  16:18
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,62,64,68,74**;Sep 27, 1994;Build 229
 ;
 ; Reference to PROTOCOL file (#101) supported by DBIA #872
 ;
STARTMSG(LA7EVNT,LA76249,LA7NOMSG) ; Create/initialize HL message
 ;
 ; Call with LA7EVNT = Lab event protocol in file (#101)
 ;           LA76249 = if entry already exists, do not create new entry
 ;          LA7NOMSG = flag to not store MSH segment in file #62.49
 ;
 N LA7MSH,X
 ;
 S LA76249=+$G(LA76249)
 D INITHL(LA7EVNT)
 I LA76249<1 S LA76249=$$INIT6249^LA7VHLU
 I $G(HL) D  Q
 . N LA7X
 . S LA7X(1)=LA76249,LA7X(2)=$TR(HL,"^","-")
 . D CREATE^LA7LOG(28)
 S X="MSH"_LA7FS_LA7ECH_LA7FS_HL("SAN")_LA7FS_HL("SAF")_LA7FS
 S $P(X,LA7FS,9)=HL("MTN")_$E(LA7ECH,1)_HL("ETN")
 S $P(X,LA7FS,11)=HL("PID")
 S $P(X,LA7FS,12)=HL("VER")
 S:$D(HL("ACAT")) $P(X,LA7FS,15)=HL("ACAT")
 S:$D(HL("APAT")) $P(X,LA7FS,16)=HL("APAT")
 S LA7MSH(0)=X
 I '$G(LA7NOMSG) D FILE6249^LA7VHLU(LA76249,.LA7MSH)
 ;
 Q
 ;
INITHL(LA7EVNT) ; Initialize HL environment
 ;
 ; Call with LA7EVNT = Lab event protocol in file (#101)
 ; HL7 v1.6 interface
 ; LA7101 - IEN of event protocol
 ; HL  - array of output parameters
 ; INT - DHCP-to-DHCP only
 ;
 K ^TMP("HLS",$J)
 K HL,HLCOMP,HLSUB,HLFS,HLERR,HLMID
 ;
 S LA7101=$O(^ORD(101,"B",LA7EVNT,0))
 D INIT^HLFNC2(LA7101,.HL,0)
 S (LA7FS,HLFS)=$G(HL("FS"))
 S (LA7ECH,HLECH)=$G(HL("ECH"))
 S HLCOMP=$E($G(HL("ECH")),1)
 S HLSUB=$E($G(HL("ECH")),4)
 Q
 ;
 ;
GEN ; Generate HL7 v1.6 message
 ; LA7101 - IEN of event protocol
 ; HLARYTYP - array type
 ; HLFORMAT - HLMA formatted/not formatted
 ; HLMTIEN - IEN in 772 (batch messages)
 ; HLRESLT = message ID^error code^error description
 ; HLP("CONTPTR") - continuation pointer field value
 ; HLP("PRIORITY") - priority field value
 ; HLP("NAMESPACE") - package namespace
 ;
 N HLEID,HLARYTYP,HLFORMAT,HLMTIEN,HLRESLT,I
 S HLEID=LA7101,HLARYTYP="GM",HLFORMAT=1,HLMTIEN="",HLRESLT=""
 S HLP("NAMESPACE")="LA"
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT,HLMTIEN,.HLP)
 K LA7MID M LA7MID=HLRESLT
 I $P(HLRESLT,"^",2)'="" D CREATE^LA7LOG(23)
 I $O(LA7MID(0)) D
 . S I=0
 . F  S I=$O(LA7MID(I)) Q:'I  I $L($P(LA7MID,"^",2)) S HLRESLT=LA7MID(I) D CREATE^LA7LOG(23)
 K HLP
 Q
 ;
 ;
BUILDSEG(LA7ARRAY,LA7DATA,LA7FS) ; Build HL segment
 ; Call with LA7ARRAY = array containing fields to build into a segment,
 ;                      passed by reference.
 ;            LA7DATA = array used to build segment, pass by reference
 ;                      used to return built segment.
 ;              LA7FS = HL field separator
 ;
 ; Returns         LA7DATA = array with segment built
 ;              LA7DATA(0) = if everything fits on one node
 ;         LA7DATA(0,1...) = multiple elements if >245 characters
 ;
 N LA7I,LA7J,LA7LAST,LA7SUB
 ;
 K LA7DATA
 ;
 S LA7FS=$G(LA7FS)
 ;
 ; Node to store data in array
 S LA7SUB=0
 ;
 ; Last element in array
 S LA7LAST=$O(LA7ARRAY(""),-1)
 ;
 F LA7I=0:1:LA7LAST D
 . I ($L($G(LA7DATA(LA7SUB)))+$L($G(LA7ARRAY(LA7I))))>245 S LA7SUB=LA7SUB+1
 . I LA7I>0 S LA7DATA(LA7SUB)=$G(LA7DATA(LA7SUB))_LA7FS
 . I $O(LA7ARRAY(LA7I,""))'="" D
 . . S LA7J=""
 . . F  S LA7J=$O(LA7ARRAY(LA7I,LA7J)) Q:LA7J=""  D
 . . . I ($L($G(LA7DATA(LA7SUB)))+$L($G(LA7ARRAY(LA7I,LA7J))))>245 S LA7SUB=LA7SUB+1
 . . . S LA7DATA(LA7SUB)=$G(LA7DATA(LA7SUB))_$G(LA7ARRAY(LA7I,LA7J))
 . S LA7DATA(LA7SUB)=$G(LA7DATA(LA7SUB))_$G(LA7ARRAY(LA7I))
 Q
 ;
 ;
FILESEG(LA7ROOT,LA7DATA) ; File HL segment in global
 ; Call with  LA7ROOT = global root used to store HL segment
 ;            LA7DATA = array with data to file (pass by reference)
 ;
 N LA7HLSN,LA7I
 I $G(LA7ROOT)="" Q  ; no global root passed.
 ;
 ; get next subscript number
 S LA7HLSN=($O(@(LA7ROOT)@(""),-1))+1
 ;
 ; store first 245 characters of segment
 S @LA7ROOT@(LA7HLSN)=$G(LA7DATA(0))
 ;
 ; if segment >245 characters then store rest of message
 S LA7I=0
 F  S LA7I=$O(LA7DATA(LA7I)) Q:LA7I=""  S @LA7ROOT@(LA7HLSN,LA7I)=LA7DATA(LA7I)
 ;
 Q
 ;
 ;
INIT6249() ; Create stub entry in file #62.49
 ; Returns ien of entry in #62.49 that was created
 ; NOTE: set lock on entry in #62.49, does not release it - calling process should release lock
 ;
 N LA7ERR,LA7FDA,ZERO
 ;
 ; Lock zeroth node of file.
 L +^LAHM(62.49,0):99999
 I '$T Q -1
 ;
 S ZERO=$G(^LAHM(62.49,0))
 F LA76249=$P(ZERO,"^",3):1 I '$D(^LAHM(62.49,LA76249)) D  Q
 . S $P(^LAHM(62.49,LA76249,0),"^")=LA76249,^LAHM(62.49,"B",LA76249,LA76249)=""
 . S $P(ZERO,"^",3)=LA76249,$P(ZERO,"^",4)=$P(ZERO,"^",4)+1,^LAHM(62.49,0)=ZERO
 ;
 ; Unlock zero node
 L -^LAHM(62.49,0)
 ;
 ; Lock entry in file 62.49 - Calling process is responsible for releasing lock when no longer needed.
 L +^LAHM(62.49,LA76249):99999
 I '$T L -^LAHM(62.49,0) Q -1
 ;
 S LA7FDA(1,62.49,LA76249_",",2)="B" ; status =(B)uilding
 S LA7FDA(1,62.49,LA76249_",",4)=$$NOW^XLFDT ; Date/time entered
 D FILE^DIE("","LA7FDA(1)","LA7ERR(1)")
 I $D(LA7ERR) S LA76249=-1
 ;
 Q LA76249
 ;
 ;
FILE6249(LA76249,LA7DATA) ; File HL segment in LAHM(62.49) global
 ; Call with  LA76249 = ien of entry in file # 62.49
 ;            LA7DATA = array with data to file (pass by reference)
 ;
 N LA7I,LA7J,LA7WP
 I '$G(LA76249) Q  ; no entry passed.
 ;
 ; move data in positive number subscripts
 S LA7I="",LA7J=0
 F  S LA7I=$O(LA7DATA(LA7I)) Q:LA7I=""  D
 . S LA7J=LA7J+1
 . S LA7WP(LA7J)=LA7DATA(LA7I)
 ;
 ; set blank line which separates each segment
 S LA7WP(LA7J+1)=""
 ;
 ; file data
 D WP^DIE(62.49,LA76249_",",150,"A","LA7WP")
 Q
 ;
 ;
P(LA7X,LA7P,LA7EC) ; get field LA7P from array (passed by ref.)
 ; Call with  LA7X = array to extract data from, pass by reference.
 ;            LA7P = field to extract
 ;           LA7EC = encoding character separator
 ;
 ; Returns LA7Y = value of requested piece
 ;
 N I,L,LA7Y,L1,Y
 S L=0,Y=1,LA7Y=""
 ;Y=begining piece of each node, L1=number of pieces in each node
 ;L=last piece in each node, quit when last piece is greater than LA7P
 F I=0:1 Q:'$D(LA7X(I))  S L1=$L(LA7X(I),LA7EC),L=L1+Y-1 D  Q:Y>LA7P
 . ;if LA7P is less than last piece, this node has field you want
 . S:LA7P'>L LA7Y=LA7Y_$P(LA7X(I),LA7EC,(LA7P-Y+1))
 . S Y=L
 Q LA7Y
 ;
 ;
PA(LA7X,LA7P,LA7EC,LA7Y) ; get field LA7P from array (passed by ref.)
 ; Call with  LA7X = array to extract data from, pass by reference.
 ;            LA7P = field to extract
 ;           LA7EC = encoding character separator
 ;
 ; Returns LA7Y = array value of requested piece (returned by reference)
 ;
 N I,L,L1,X,Y
 S (L,LA7Y)=0,Y=1
 ;Y=begining piece of each node, L1=number of pieces in each node
 ;L=last piece in each node, quit when last piece is greater than LA7P
 F I=0:1 Q:'$D(LA7X(I))  S L1=$L(LA7X(I),LA7EC),L=L1+Y-1 D  Q:Y>LA7P
 . ;if LA7P is less than last piece, this node has field you want
 . I LA7P'>L S X=$P(LA7X(I),LA7EC,(LA7P-Y+1)) S:X]"" LA7Y=LA7Y+1,LA7Y(LA7Y)=X
 . S Y=L
 Q
 ;
 ;
BLG(LA7ACTN,LA7CHGTY,LA7FS,LA7ECH) ; Build BLG segment -  billing information
 ; Call with  LA7ACTN = billing account Number
 ;           LA7CHGTY = charge type
 ;             LA7ECH = HL encoding characters
 ;
 ; Returns LA7Y
 ;
 ; Default to CO (contract) for charge type - table 0122
 S LA7CHGTY=$G(LA7CHGTY,"CO")
 S LA7Y="BLG"_LA7FS_LA7FS_LA7CHGTY_LA7FS_$$M11^HLFNC(LA7ACTN,LA7ECH)_LA7FS
 Q LA7Y
 ;
 ;
PTEXTID(LA74,LA7UID,LA7Y) ; Retrieve patient's id that was transmitted by other system.
 ; Used to build PID-2 when returning results to placer.
 ; Looks in file LAB PENDING ORDERS (#69.6) for info pertaining to placer's order.
 ; Call with  LA74 = ien of placer in INSTITUTION file (#4)
 ;          LA7UID = placer's specimen identifier (UID, etc.)
 ;
 ; Returns array LA7Y by reference
 ;               LA7Y("FS")  - original field separator
 ;               LA7Y("ECH") - original encoding characters used
 ;             LA7Y("PID-2") - original PID-2 sequence
 ;             LA7Y("PID-4") - original PID-4 sequence
 ;
 N LA7696,LA7X
 ;
 S LA74=$G(LA74),LA7UID=$G(LA7UID),LA7Y=""
 ;
 ; Return null if no values passed
 I LA74<1!(LA7UID="") Q
 ;
 S LA7696=$O(^LRO(69.6,"RST",LA74,LA7UID,0))
 I LA7696 D
 . S LA7X=$G(^LRO(69.6,LA7696,700))
 . S LA7Y("FS")=$E(LA7X,1)
 . S LA7Y("ECH")=$E(LA7X,2,5)
 . S LA7Y("PID-2")=$G(^LRO(69.6,LA7696,700.02))
 . S LA7Y("PID-4")=$G(^LRO(69.6,LA7696,700.04))
 Q
 ;
 ;
RETOBR(LA74,LA7UID,LA7NLT,LA7Y) ; Retrieve placer's various OBR's that were transmitted by other system.
 ; Used to build OBR-4/17/18 when returning results to placer.
 ; Looks in file LAB PENDING ORDERS (#69.6) for info pertaining to placer's order.
 ;
 ; Call with   LA74 = ien of placer in INSTITUTION file (#4)
 ;           LA7UID = placer's specimen identifier (UID, accession number, etc.)
 ;           LA7NLT = ordered NLT test code
 ;
 ; Returns array LA7Y by reference
 ;               LA7Y("FS")     - original field separator
 ;               LA7Y("ECH")    - original encoding characters used
 ;               LA7Y("OBR-4")  - original OBR-4 sequence
 ;               LA7Y("OBR-17)  - modified info from OBR-17
 ;               LA7Y("OBR-18") - original OBR-18 sequence
 ;               LA7Y("OBR-19") - original OBR-19 sequence
 ;
 N I,LA7696,LA76964,LA7X
 ;
 ; Initialize return array
 S LA74=$G(LA74),LA7UID=$G(LA7UID),LA7Y=""
 F I="FS","ECH","OBR-4","OBR-17","OBR-18","OBR-19" S LA7Y(I)=""
 ;
 ; Return null if no values passed
 I LA74<1!(LA7UID="")!(LA7NLT="") Q
 ;
 S LA7696=0
 F  S LA7696=$O(^LRO(69.6,"RST",LA74,LA7UID,LA7696)) I 'LA7696!($D(^LRO(69.6,+LA7696,2,"C",LA7NLT))) Q
 I LA7696<1 Q
 ;
 S LA7X=$G(^LRO(69.6,LA7696,700))
 S LA7Y("FS")=$E(LA7X,1)
 S LA7Y("ECH")=$E(LA7X,2,5)
 ;
 S LA76964=$O(^LRO(69.6,LA7696,2,"C",LA7NLT,0))
 I LA76964<1 Q
 ;
 S LA7Y("OBR-4")=$G(^LRO(69.6,LA7696,2,LA76964,700.04))
 S LA7Y("OBR-17")=$P($G(^LRO(69.6,LA7696,2,LA76964,1)),"^")
 S LA7Y("OBR-18")=$G(^LRO(69.6,LA7696,2,LA76964,700.18))
 S LA7Y("OBR-19")=$G(^LRO(69.6,LA7696,2,LA76964,700.19))
 ;
 Q

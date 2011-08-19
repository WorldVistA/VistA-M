LA7VIN3 ;DALOI/JMC - Process Incoming UI Msgs, continued ; 01/14/99
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64**;Sep 27, 1994
 ;This routine is a continuation of LA7VIN1 and is only called from there.
 Q
 ;
MSA ; Process MSA segment
 ; The incoming MSA is used to update the status of the message
 ; in the LA7 MESSAGE QUEUE (#62.49)
 ;
 ; and
 ;
 ; if acknowledging ORU message - the ORDERS PENDING (#69.6) file
 ; if acknowledging ORM message - the SHIPPING MANIFEST (#62.8) file
 ;
 N LA7696,LA76964,LA7I,LA7MSAID,LA7MSTAT,LA7ORT,LA7RUID,LA7ST,LA7SITE,LA7X,LA7Y
 S LA7MSTAT=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 S LA7MSAID=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 ;
 ; Extract text message from MSA-3
 S LA7X=$$P^LA7VHLU(.LA7SEG,4,LA7FS)
 S LA7MSATM=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 ;
 ; Extract error condition from MSA-6
 S LA7X=$$P^LA7VHLU(.LA7SEG,7,LA7FS)
 I LA7X'="" D
 . S LA7Y=""
 . I $P(LA7X,$E(LA7ECH),2)'="" S LA7Y=$$UNESC^LA7VHLU3($P(LA7X,$E(LA7ECH),2),LA7FS_LA7ECH)
 . I $P(LA7X,$E(LA7ECH))'="" D
 . . I LA7Y="" S LA7Y=$$UNESC^LA7VHLU3($P(LA7X,$E(LA7ECH)),LA7FS_LA7ECH) Q
 . . S LA7Y="["_$P(LA7X,$E(LA7ECH))_"] "_LA7Y
 . S LA7MSATM=$S(LA7MSATM'="":LA7MSATM_" ",1:"")_LA7Y
 I LA7MSAID="" Q
 ;
 D SETID^LA7VHLU1(LA76249,LA7ID,"ACK-"_LA7MSAID)
 ;
 S LA7ST=$$FIND1^DIC(64.061,"","MX","Results/data Received","","I $P(^(0),U,7)=""U""")
 ;
 ; Only look for messages id's that are outgoing messages, those that
 ; originated from this system. Other systems (incoming) messages can
 ; use a message id that is the same as a Vista message.
 ;
 N LA76249
 S LA76249=0
 F  S LA76249=$O(^LAHM(62.49,"ID",LA7MSAID,LA76249)) Q:'LA76249  D
 . I $P($G(^LAHM(62.49,LA76249,0)),"^",2)'="O" Q
 . D UPDF
 ;
 Q
 ;
UPDF ; Update respective files
 ;
 N FDA,I,LA7ERR,LA7MTYPE,X
 ;
 F I=63,100 S LA76249(I)=$G(^LAHM(62.49,LA76249,I))
 ;
 ; Update original message in #62.49
 S FDA(1,62.49,LA76249_",",2)="X"
 I LA7MSTAT'="AA",LA7MSTAT'="CA" D
 . S FDA(1,62.49,LA76249_",",2)="E"
 . S FDA(1,62.49,LA76249_",",160)=LA7MSTAT
 . I LA7MSATM'="" S FDA(1,62.49,LA76249_",",161)=LA7MSATM
 D FILE^DIE("","FDA(1)","LA7ERR(1)")
 ;
 ; Send alert that original message had error.
 I LA7MSTAT'="AA",LA7MSTAT'="CA" D
 . D CREATE^LA7LOG(48)
 ;
 ; Retrieve original message's type.
 S LA7MTYPE=$P(LA76249(100),"^",9)
 ;
 ; If original message was an ORM, then update collecting facility's shipping manifest.
 I LA7MTYPE="ORM" D  Q
 . ; Need to code this section - JMC 1/12/00
 . ; Need to figure out the shipping manifest which is being acknowledged
 . Q
 ;
 I LA7MTYPE'="ORU" Q
 ; Rest of this deals with updating order/test status in LAB PENDING ORDER file
 ; at host lab when collection facility is acknowledging receipt of ORU message.
 ;
 I LA76249(63)="" Q
 S LA7SITE=$P(LA76249(63),U,2),LA7RUID=$P(LA76249(63),U,3)
 S LA7696=$O(^LRO(69.6,"RST",LA7SITE,LA7RUID,0))
 I LA7696="" Q
 ;
 ; Update order status in 69.6
 S FDA(2,69.6,LA7696_",",6)=LA7ST
 D FILE^DIE("","FDA(2)","LA7ERR(2)")
 ;
 S LA7ORT=$P(LA76249(63),U,4),LA76964=0
 I LA7ORT'="" S LA76964=$O(^LRO(69.6,LA7696,2,"B",LA7ORT,0))
 I 'LA76964 D
 . S LA7ORT=$P(LA76249(63),U,5)
 . I LA7ORT'="" S LA76964=$O(^LRO(69.6,LA7696,2,"C",LA7ORT,0))
 I LA76964<1 Q
 ;
 ; Update test status in 69.6
 S FDA(3,69.64,LA76964_","_LA7696_",",5)=LA7ST
 D FILE^DIE("","FDA(3)","LA7ERR(3)")
 ;
 Q

LA7VORM3 ;DALOI/JMC - LAB ORM (Order) message builder cont'd ; 11-21-986
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64**;Sep 27, 1994
 ;
 ;
OBR ;Observation Request segment for Lab Order
 N LA760,LA764,LA7ALT,LA7DATA,LA7DUR,LA7DURU,LA7NLT,LA7X,LA7Y,LRACC,OBR,SPC
 ;
 S LA760=+$P(LA762801(0),"^",2)
 S LA764=+$P($G(^LAB(60,LA760,64)),"^")
 S LA7NLT=$P($G(^LAM(LA764,0)),"^",2)
 ;
 S OBR(0)="OBR"
 S OBR(1)=$$OBR1^LA7VOBR(.LA7OBRSN) ;initialize OBR segment
 ;
 ; Remote UID
 S OBR(2)=$$OBR2^LA7VOBR(LA7UID,LA7FS,LA7ECH)
 ;
 ; Universal service ID - check for non-VA code system
 S LA7X=""
 I $P(LA762801(5),"^")]"" S LA7X=$P(LA762801(5),"^",1)_"^"_$P(LA762801(5),"^",2)_"^"_$P(LA762801(5),"^",5)
 S OBR(4)=$$OBR4^LA7VOBR(LA7NLT,LA760,LA7X,LA7FS,LA7ECH)
 ;
 ; Collection date/time
 S OBR(7)=$$OBR7^LA7VOBR($P(LA76802(3),"^"))
 ;
 ; Collection end date/time
 I $P(LA762801(2),U,4)=1 D
 . S OBR(8)=$$OBR8^LA7VOBR($P(LA762801(2),U,5))
 ;
 ; Collection volume
 I $P(LA762801(2),U)=1 D
 . S OBR(9)=$$OBR9^LA7VOBR($P(LA762801(2),"^",2),$P(LA762801(2),"^",3),LA7FS,LA7ECH)
 ;
 ; Specimen action code
 S OBR(11)=$$OBR11^LA7VOBR("P")
 ;
 ; Infection warning - patient info
 S OBR(12)=$$OBR12^LA7VOBR(LRDFN,LA7FS,LA7ECH)
 ;
 ; Revelant clinical information
 I LA762801(.1)'="" S OBR(13)=$$OBR13^LA7VOBR(LA762801(.1),LA7FS,LA7ECH)
 ;
 ; Lab Arrival Time
 S OBR(14)=$$OBR14^LA7VOBR($P(LA76802(3),"^",3))
 ;
 ; Specimen source - handle non-HL7 coding system
 S LA7X=""
 I $P(LA762801(5),"^",3)'="" D
 . F I=3,4 S $P(LA7X,"^",I-2)=$P(LA762801(5),"^",I)
 . S $P(LA7X,"^",3)=$P(LA762801(5),"^",6)
 I $P(LA762801(5),"^",7)'="" F I=7,8,9 S $P(LA7X,"^",I-2)=$P(LA762801(5),"^",I)
 S OBR(15)=$$OBR15^LA7VOBR(+$P(LA762801(0),"^",3),+$P(LA76802(5),"^",2),LA7X,LA7FS,LA7ECH,$P(LA762801(0),"^",7))
 ;
 ; Ordering provider
 K LA7X
 S LA7X=$$FNDOLOC^LA7VHLU2(LA7UID)
 S OBR(16)=$$ORC12^LA7VORC($P(LA76802(0),"^",8),$P(LA7X,"^",3),LA7FS,LA7ECH)
 ;
 ; Placer's field #1 (HOST site)
 S OBR(18)="LA7V HOST "_SITE
 ;
 ; Placer's field #2
 K LA7X
 S LA7X(3)=LRAA,LA7X(4)=LRAD,LA7X(5)=LRAN,LA7X(6)=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,.2),U),LA7X(7)=LA7UID
 S OBR(19)=$$OBR19^LA7VOBR(.LA7X,LA7FS,LA7ECH)
 ;
 ; Test duration
 S (LA7DUR,LA7DURU)=""
 I $P(LA762801(2),"^",4) D
 . S LA7DUR=$P(LA762801(2),"^",6) ; collection duration
 . S LA7DURU=$P(LA762801(2),"^",7) ; duration units
 ;
 ; Test urgency
 S LA76205=+$$GET1^DIQ(68.04,LA760_","_LRAN_","_LRAD_","_LRAA_",",1,"I")
 S OBR(27)=$$OBR27^LA7VOBR(LA7DUR,LA7DURU,LA76205,LA7FS,LA7ECH)
 ;
 ; If sending to another VA then build OBR-34
 I 'LA7NVAF S $P(OBR(34),HLCOMP,7)=$P($G(LA7V("HOST")),U)
 ;
 D BUILDSEG^LA7VHLU(.OBR,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 Q
 ;
OBX ; Build OBX segments with required info if any.
 ;
 N LA74,LA7DUR,LA7DURU
 ;
 ; Collecting facility
 S LA74=$P(LA7629(0),"^",2)
 S LA7OBXSN=0
 ;
 ; Patient height
 I $P(LA762801(1),"^") D PTHT^LA7VORM2($P(LA762801(1),"^",2),$P(LA762801(1),"^",3),$P(LA762801(1),"^",7),LA74,.LA7OBXSN,.LRI,LA7FS,LA7ECH,LA76249)
 ;
 ; Patient weight
 I $P(LA762801(1),"^",4) D PTWT^LA7VORM2($P(LA762801(1),"^",5),$P(LA762801(1),"^",6),$P(LA762801(1),"^",8),LA74,.LA7OBXSN,.LRI,LA7FS,LA7ECH,LA76249)
 ;
 ; Collection duration
 S (LA7DUR,LA7DURU)=""
 I $P(LA762801(2),"^",4) D
 . S LA7DUR=$P(LA762801(2),"^",6) ; collection duration
 . S LA7DURU=$P(LA762801(2),"^",7) ; duration units
 . D SPDUR^LA7VORM2($P(LA762801(2),"^",6),$P(LA762801(2),"^",7),$P(LA762801(2),"^",12),LA74,.LA7OBXSN,.LRI,LA7FS,LA7ECH,LA76249)
 ;
 ; Collection volume
 I $P(LA762801(2),"^",2) D
 . D SPCV^LA7VORM2($P(LA762801(2),"^",2),$P(LA762801(2),"^",3),$P(LA762801(2),"^",11),LA74,.LA7OBXSN,.LRI,LA7FS,LA7ECH,LA76249)
 ;
 ; Specimen weight
 I $P(LA762801(2),"^",8) D SPWT^LA7VORM2($P(LA762801(2),"^",9),$P(LA762801(2),"^",10),LA7DUR_LA7DURU,$P(LA762801(2),"^",13),LA74,.LA7OBXSN,.LRI,LA7FS,LA7ECH,LA76249)
 ;
 ; Check for anatomic/surigal path subscripts
 I "SP^CY^AU^EM"[$P($G(^LRO(68,LRAA,0)),"^",2) D AP
 ;
 Q
 ;
 ;
AP ; Observation/Result segment for Lab AP Results sent with Order Message
 ;
 N LA7DATA,LA7IDT,LRIDT,LRSB,LRSS
 ;
 S LRSS=$P($G(^LRO(68,LRAA,0)),"^",2)
 S (LA7IDT,LRIDT)=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 D APORM^LA7VORU2
 Q

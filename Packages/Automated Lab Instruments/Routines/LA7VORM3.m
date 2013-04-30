LA7VORM3 ;DALOI/JMC - LAB ORM (Order) message builder cont'd ;Nov 21, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,74**;Sep 27, 1994;Build 229
 ;
 ;
OBR ;Observation Request segment for Lab Order
 N LA760,LA761,LA764,LA7ALT,LA7DATA,LA7DUR,LA7DURU,LA7I,LA7IDT,LA7NLT,LA7SNM,LA7X,LA7Y,LRACC,LRIDT,LRSB,LRSS,OBR,SPC
 ;
 S LA760=+$P(LA762801(0),"^",2)
 S LA764=+$P($G(^LAB(60,LA760,64)),"^")
 S LA7NLT=$P($G(^LAM(LA764,0)),"^",2)
 ;
 S LRSS=$P($G(^LRO(68,LRAA,0)),"^",2)
 S (LA7IDT,LRIDT)=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
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
 ; Collection D/T - only send date if d/t is inexact (2nd piece)
 K LA7X
 S LA7X=$P(LA76802(3),"^") S:$P(LA76802(3),"^",2) LA7X=$P(LA7X,".")
 S OBR(7)=$$OBR7^LA7VOBR(LA7X)
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
 S OBR(11)=$$OBR11^LA7VOBR($S(LA7NVAF=1:"I",1:"P"))
 ;
 ; Infection warning - patient info
 S OBR(12)=$$OBR12^LA7VOBR(LRDFN,LA7FS,LA7ECH)
 ;
 ; Relevant clinical information
 I LA762801(.1)'="" S OBR(13)=$$OBR13^LA7VOBR(LA762801(.1),LA7FS,LA7ECH)
 ;
 ; Lab Arrival Time
 S OBR(14)=$$OBR14^LA7VOBR($P(LA76802(3),"^",3))
 ;
 ; Specimen source - handle non-HL7 coding system
 S LA7X="",LA7SNM=1,LA761=+$P(LA762801(0),"^",3)
 ;
 ; Uncomment to have LEDI send old specimen codes (local CHCS codes) to CHCS for LDSI Phase I "CH" subscript tests 
 ;I LA7NVAF=1,$P($G(^LRO(68,LRAA,0)),"^",2)="CH" S LA7SNM=0
 ; Uncomment to have LEDI send old specimen codes to VistA. 
 I LA7NVAF=0 S LA7SNM=1.1
 ; Uncomment to send SMOMED CT codes only to other LEDI VA sites when they have SNOMED CT installed.
 ;I LA7NVAF=0 S LA7SNM=2
 ;
 ; If multiple different specimens then OBR-15 always indicates XXX for AP subscripts - specimen is communicated in OBX segments.
 I LRSS?1(1"SP",1"CY",1"EM") D
 . S LA7I=0
 . F  S LA7I=$O(^LR(LRDFN,LRSS,LRIDT,.1,LA7I)) Q:'LA7I   D  Q:'LA7I
 . . S LA7Y=$P(^LR(LRDFN,LRSS,LRIDT,.1,LA7I,0),"^",6)
 . . I 'LA761,LA7Y S LA761=LA7Y
 . . I LA761,LA7Y,(LA761'=LA7Y) S (LA761,LA7I)=0
 ;
 ; Non-HL7 specimen code system.
 I $P(LA762801(5),"^",3)'="" D
 . F I=3,4 S $P(LA7X,"^",I-2)=$P(LA762801(5),"^",I)
 . S $P(LA7X,"^",3)=$P(LA762801(5),"^",6)
 ;
 ; Collection sample code
 I $P(LA762801(5),"^",7)'="" F I=7,8,9 S $P(LA7X,"^",I-2)=$P(LA762801(5),"^",I)
 ;
 ; Check for alternate SNOMED CT codes on specimen and collection sample
 I LA762801("SCT")'="" F I=1,2 S $P(LA7X,"^",I+7)=$P(LA762801("SCT"),"^",I)
 ;
 S OBR(15)=$$OBR15^LA7VOBR(LA761,+$P(LA76802(5),"^",2),LA7X,LA7FS,LA7ECH,$S(LA7NVAF'=1:$P(LA762801(0),"^",7),1:""),LA7SNM)
 ;
 ; Ordering provider
 K LA7X
 S LA7X=$$FNDOLOC^LA7VHLU2(LA7UID)
 S OBR(16)=$$ORC12^LA7VORC($P(LA76802(0),"^",8),$P(LA7X,"^",3),LA7FS,LA7ECH,2)
 ;
 ; Placer's field #1 (HOST site)
 S OBR(18)="LA7V HOST "_SITE
 ;
 ; Placer's field #2
 K LA7X
 S LA7X(3)=LRAA,LA7X(4)=LRAD,LA7X(5)=LRAN,LA7X(6)=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,.2),U),LA7X(7)=LA7UID
 S LA7X(8)=$G(^TMP("LA7ITEM",$J,LA7UID,LA762801))
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
 ;
 ; Send specimen source as NTE comment to DoD
 I LA7NVAF=1,LRSS="MI" D NTE
 ;
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
 ; Check for anatomic/surgical path subscripts
 I "SPCYAUEM"[$P($G(^LRO(68,LRAA,0)),"^",2) D AP
 ;
 Q
 ;
 ;
AP ; Observation/Result segment for Lab AP Results sent with Order Message
 ;
 N LA7DATA,LA7IDT,LRIDT,LRSB,LRSS
 S LRSS=$P($G(^LRO(68,LRAA,0)),"^",2)
 S (LA7IDT,LRIDT)=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 D APORM^LA7VORU2
 Q
 ;
 ;
NTE ; Build NTE segment for MI subscript test with specimen source as comment
 ;
 N LA7CMTYP,LA7NTESN,LA7SOC,LA7TXT
 ;
 ; Source of comment - handle other system's special codes, i.e. DOD-CHCS
 S LA7SOC=$S($G(LA7NVAF)=1:"RQ",1:"L")
 ;
 S LA7NTESN=0,LA7CMTYP=""
 S LA7TXT="Specimen Source: "_$$GET1^DIQ(61,+$P(LA762801(0),"^",3)_",",.01)
 S LA7TXT=$$TRIM^XLFSTR(LA7TXT,"R"," ")
 D NTE^LA7VORU1
 Q

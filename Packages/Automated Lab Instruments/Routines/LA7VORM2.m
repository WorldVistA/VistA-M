LA7VORM2 ;DALOI/JMC - LAB ORM (Order) message builder cont'd ; 11-21-986
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46**;Sep 27, 1994
 ;
 ; Observation/Result segment for Lab Results sent with Order Message
 ; Build OBX segments for orders that have required info to be sent
 ; with order.
 ; e.g. patient height/weight, specimen weight
 ;
PTHT(LA7VAL,LA764061,LA7953,LA74,LA7OBXSN,LA7HLSN,LA7FS,LA7ECH,LA76249) ; Send patient height
 ; Call with    LA7VAL = patient height
 ;            LA764061 = IEN of units in file #64.061
 ;              LA7953 = LOINC code
 ;                LA74 = performing institution
 ;            LA7OBXSN = sequence id of this OBX segment
 ;             LA7HLSN = segment counter for message (pass by reference)
 ;               LA7FS = HL field separator
 ;              LA7ECH = HL encoding characters
 ;             LA76249 = IEN of entry in #62.49
 ;
 N LA7OBX
 S LA7OBX(2)=$$OBX2^LA7VOBX(62.801,1.11)
 S LA7OBX(3)=$$OBX3^LA7VOBX("",LA7953,"",LA7FS,LA7ECH) ; LOINC code
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH) ; height value
 S LA7OBX(6)=$$OBX6^LA7VOBX("",LA764061,LA7FS,LA7ECH) ; unit
 D GEN
 Q
 ;
PTWT(LA7VAL,LA764061,LA7953,LA74,LA7OBXSN,LA7HLSN,LA7FS,LA7ECH,LA76249) ; Send patient weight
 ; Call with    LA7VAL = patient weight
 ;            LA764061 = IEN of units in file #64.061
 ;              LA7953 = LOINC code
 ;                LA74 = performing institution
 ;            LA7OBXSN = sequence id of this OBX segment
 ;             LA7HLSN = segment counter for message (pass by reference)
 ;               LA7FS = HL field separator
 ;              LA7ECH = HL encoding characters
 ;             LA76249 = IEN of entry in #62.49
 ;
 N LA7OBX
 S LA7OBX(2)=$$OBX2^LA7VOBX(62.801,1.21)
 S LA7OBX(3)=$$OBX3^LA7VOBX("",LA7953,"",LA7FS,LA7ECH) ; LOINC code
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH) ; weight value
 S LA7OBX(6)=$$OBX6^LA7VOBX("",LA764061,LA7FS,LA7ECH) ; unit
 D GEN
 Q
 ;
SPWT(LA7VAL,LA764061,LA7DUR,LA7953,LA74,LA7OBXSN,LA7HLSN,LA7FS,LA7ECH,LA76249) ; Send specimen weight
 ; Call with    LA7VAL = specimen weight
 ;            LA764061 = IEN of units in file #64.061
 ;              LA7DUR = collection duration
 ;              LA7953 = LOINC code
 ;                LA74 = performing institution
 ;            LA7OBXSN = sequence id of this OBX segment (pass by reference)
 ;             LA7HLSN = segment counter for message (pass by reference)
 ;               LA7FS = HL field separator
 ;              LA7ECH = HL encoding characters
 ;             LA76249 = IEN of entry in #62.49
 ;
 N LA7LOINC,LA7OBX
 S LA7OBX(2)=$$OBX2^LA7VOBX(62.801,2.31)
 S LA7OBX(3)=$$OBX3^LA7VOBX("",LA7953,"",LA7FS,LA7ECH) ; LOINC code
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH) ; weight value
 S LA7OBX(6)=$$OBX6^LA7VOBX("",LA764061,LA7FS,LA7ECH) ; unit
 D GEN
 Q
 ;
 ;
SPCV(LA7VAL,LA764061,LA7953,LA74,LA7OBXSN,LA7HLSN,LA7FS,LA7ECH,LA76249) ; Specimen collection volume
 ; Call with    LA7VAL = collection volume
 ;            LA764061 = IEN of units in file #64.061
 ;              LA7953 = LOINC code
 ;                LA74 = performing institution
 ;            LA7OBXSN = sequence id of this OBX segment
 ;             LA7HLSN = segment counter for message (pass by reference)
 ;               LA7FS = HL field separator
 ;              LA7ECH = HL encoding characters
 ;             LA76249 = IEN of entry in #62.49
 ;
 N LA7OBX
 ;
 S LA7OBX(2)=$$OBX2^LA7VOBX(62.801,2.11)
 ; LOINC code
 S LA7OBX(3)=$$OBX3^LA7VOBX("",LA7953,"",LA7FS,LA7ECH)
 ; Collection volume
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 S LA7OBX(6)=$$OBX6^LA7VOBX("",LA764061,LA7FS,LA7ECH) ; unit
 D GEN
 Q
 ;
 ;
SPDUR(LA7VAL,LA764061,LA7953,LA74,LA7OBXSN,LA7HLSN,LA7FS,LA7ECH,LA76249) ; Specimen collection duration
 ; Call with    LA7VAL = collection duration
 ;            LA764061 = IEN of units in file #64.061
 ;              LA7953 = LOINC code
 ;                LA74 = performing institution
 ;            LA7OBXSN = sequence id of this OBX segment
 ;             LA7HLSN = segment counter for message (pass by reference)
 ;               LA7FS = HL field separator
 ;              LA7ECH = HL encoding characters
 ;             LA76249 = IEN of entry in #62.49
 ;
 N LA7OBX
 ;
 S LA7OBX(2)=$$OBX2^LA7VOBX(62.801,2.22)
 ; LOINC code
 S LA7OBX(3)=$$OBX3^LA7VOBX("",LA7953,"",LA7FS,LA7ECH)
 ; Collection duration
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 S LA7OBX(6)=$$OBX6^LA7VOBX("",LA764061,LA7FS,LA7ECH) ; unit
 D GEN
 Q
 ;
 ;
GEN ; Fields common to OBX segment
 ;
 N LA7DATA
 ;
 S LA7OBX(0)="OBX"
 ; OBX segment id
 S LA7OBX(1)=$$OBX1^LA7VOBX(.LA7OBXSN)
 S LA7OBX(11)="F"
 ; Facility that performed the testing
 S LA7OBX(15)=$$OBX15^LA7VOBX(LA74,LA7FS,LA7ECH)
 ;
 D BUILDSEG^LA7VHLU(.LA7OBX,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 Q

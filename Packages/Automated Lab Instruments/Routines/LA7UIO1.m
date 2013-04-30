LA7UIO1 ;DALOI/JMC - Process Download Message for an entry in 62.48 ;11/17/11  09:16
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**66,74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
BUILD ; Build one accession into an HL7 message
 ;
 N GBL,HL,LA760,LA761,LA7CDT,LA7CMT,LA7CS,LA7ERR,LA7FAC,LA7FS,LA7ECH,LA7HLP,LA7I,LA7ID,LA7LINK,LA7NVAF,LA7OBRSN,LA7PIDSN,LA7SCMT,LA7SID,LA7SPEC,LA7X,LA7Y
 S GBL="^TMP(""HLS"","_$J_")"
 ;
 I '$D(ZTQUEUED),$G(LRLL) W:$X+5>IOM !,$S($G(LRTYPE):"Cup",1:"Seq"),": " W LA76822,", "
 ;
 S LA7CNT=0
 F I=0,.1,.2,.3,3 S LA76802(I)=$G(^LRO(68,LA768,1,LA76801,1,LA76802,I))
 S LA7X=LA76802(3)
 ; Draw time
 S LA7CDT=+LA7X
 ;
 ; Specimen comment if any, strip "~"
 S LA7SCMT=$TR($P(LA7X,"^",6),"~")
 ;
 ; Specimen
 S LA761=+$G(^LRO(68,LA768,1,LA76801,1,LA76802,5,1,0))
 ; Accession/unique ID - Long (UID) or short (accession #) sample ID
 S LA7ACC=$P(LA76802(.2),"^"),LA7UID=$P(LA76802(.3),"^"),LA7X=$G(^LRO(68,LA768,.4))
 I $P(LA7X,"^",2)="S" S LA7SID=$$RJ^XLFSTR(LA76802,+$P(LA7X,"^",3),"0")
 E  S LA7SID=LA7UID
 ;
 ; Start message
 D INIT Q:$G(HL)
 ;
 ; Setup links and subscriber array for HL7 message generation
 S LA76248(0)=$G(^LAHM(62.48,LA76248,0)),LA7Y=$P(LA76248(0),"^")
 I $E(LA7Y,1,5)'="LA7UI"!($P(LA76248(0),"^",9)'=1) Q
 S LA7LINK="LA7UI ORM-O01 SUBS 2.2^"_LA7Y
 S LA7FAC=$P($$SITE^VASITE(DT),"^",3)
 S LA7HLP("SUBSCRIBER")="^^"_LA7FAC_"^"_LA7Y_"^"
 ; Following line used when debugging
 ;S $P(LA7HLP("SUBSCRIBER"),"^",8)="1-1-2"
 ;
 ; Build segments PID, PV1, and ORC/OBR segment for each test to be sent
 D PID,PV1
 S (LA7I,LA7OBRSN)=0
 F  S LA7I=$O(LA7ACC(LA7I)) Q:'LA7I  D ORC,OBR
 ; Build entry in MESSAGE QUEUE file 62.49
 D SENDMSG
 L -^LAHM(62.49,LA76249)
 D KVAR^LRX
 Q
 ;
 ;
INIT ; Create/initialize HL message
 ;
 K @GBL
 S (LA76249,LA7NVAF,LA7PIDSN)=0
 D STARTMSG^LA7VHLU("LA7UI ORM-O01 EVENT 2.2",.LA76249)
 S LA7ID=$P(LRAUTO,"^",1)_"-O-"_LA7UID
 ;
 K ^TMP("LA7-ID",$J)
 D SETID^LA7VHLU1(LA76249,"",LA7ID,1)
 D SETID^LA7VHLU1(LA76249,"",LA7UID,0)
 D SETID^LA7VHLU1(LA76249,"",LA7ACC,0)
 S LA7CS=$E(LA7ECH,1)
 I $G(HL) S LA7ERR=28 D UPDT6249^LA7VORM1
 Q
 ;
 ;
PID ; Build PID segment
 N LA7DATA,LA7FLAG,NAME,PID
 S LRDFN=+LA7ACC0,LRDPF=$P(^LR(LRDFN,0),"^",2),DFN=$P(^(0),"^",3)
 D DEM^LRX
 ;
 S PID(0)="PID"
 S PID(1)=1
 S PID(3)=$$M11^HLFNC(LRDFN)
 ;
 ; Pass patient and referral files through name standardization.
 ; Don't pass lab control and other file's "paient" names thru name standardization as it affects name order.
 I LRDPF?1(1"2",1"67",1"200") S NAME("FILE")=LRDPF,NAME("FIELD")=.01,NAME("IENS")=DFN,LA7FLAG="S"
 E  S NAME("FAMILY")=$P(PNM,","),NAME("GIVEN")=$P(PNM,",",2),LA7FLAG=""
 S PID(5)=$$HLNAME^XLFNAME(.NAME,LA7FLAG,LA7CS)
 ;
 ; Date of birth
 I DOB S PID(7)=$$FMTHL7^XLFDT(DOB)
 S PID(8)=$S(SEX'="":SEX,1:"U")
 ;
 ; Race
 D RACE
 ;
 ; Patient's SSN
 I SSN'="" S PID(19)=SSN
 ;
 D BUILDSEG^LA7VHLU(.PID,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 D SETID^LA7VHLU1(LA76249,"",PNM,0)
 Q
 ;
 ;
PV1 ; Build PV1 segment
 N LA7PV1,LA7X
 D PV1^LA7VPID(LRDFN,.LA7PV1,LA7FS,LA7ECH)
 ; If not inpatient use patient location from Accession
 I $P(LA7PV1(0),LA7FS,3)'="I" S LA7X=$P($G(LA76802(0)),"^",7) S LA7X=$$CHKDATA^LA7VHLU3(LA7X,LA7FS_LA7ECH) S $P(LA7PV1(0),LA7FS,4)=LA7X
 ;
 D FILESEG^LA7VHLU(GBL,.LA7PV1)
 D FILE6249^LA7VHLU(LA76249,.LA7PV1)
 Q
 ;
 ;
ORC ; Build ORC segment
 N LA7DATA,ORC
 S ORC(0)="ORC"
 S ORC(1)="NW"
 ;
 ; Placer/filler order number - sample ID
 S ORC(2)=$$ORC2^LA7VORC(LA7SID,LA7FS,LA7ECH)
 S ORC(3)=$$ORC3^LA7VORC(LA7SID,LA7FS,LA7ECH)
 ;
 ; Order/draw time - if no order date/time then try draw time
 I $P(LA76802(0),"^",4) S ORC(9)=$$ORC9^LA7VORC($P(LA76802(0),"^",4))
 I '$P(LA76802(0),"^",4),$P(LA76802(3),"^") S ORC(9)=$$ORC9^LA7VORC($P(LA76802(3),"^"))
 ;
 ; Provider
 S LA7X=$$FNDOLOC^LA7VHLU2(LA7UID)
 S ORC(12)=$$ORC12^LA7VORC($P(LA76802(0),"^",8),$P(LA7X,"^",3),LA7FS,LA7ECH,2)
 D BUILDSEG^LA7VHLU(.ORC,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 Q
 ;
 ;
OBR ; Build OBR segment
 N LA764,LA7ALT,LA7CADR,LA7NLT,LA7TCMT
 K OBR
 ;
 S LA760=+LA7ACC(LA7I)
 S LA764=+$P($G(^LAB(60,LA760,64)),"^")
 S LA7NLT=$P($G(^LAM(LA764,0)),"^",2)
 S LA7TMP=$G(^TMP("LA7",$J,LA7INST,LA7I))
 Q:'LA7TMP
 ;
 S LA7CODE=$P(LA7TMP,"^",6),LA7DATA=$P(LA7TMP,"^",7)
 S OBR(0)="OBR"
 S OBR(1)=$$OBR1^LA7VOBR(.LA7OBRSN)
 ; Placer/filler order number - sample ID
 S OBR(2)=$$OBR2^LA7VOBR(LA7SID,LA7FS,LA7ECH)
 S OBR(3)=$$OBR3^LA7VOBR(LA7SID,LA7FS,LA7ECH)
 ; Test order code
 S LA7ALT=LA7CODE_"^"_$$GET1^DIQ(60,LA760_",",.01)_"^"_"99001"
 S OBR(4)=$$OBR4^LA7VOBR(LA7NLT,LA760,LA7ALT,LA7FS,LA7ECH)
 ; Draw time.
 I $G(LA7CDT) S OBR(7)=$$OBR7^LA7VOBR(LA7CDT)
 ; Infection warning.
 S OBR(12)=$$OBR12^LA7VOBR(LRDFN,LA7FS,LA7ECH)
 ;
 ; Specimen comment
 ; If no specimen comment
 ;  then check order for test comments on test
 ;   or parent test if panel exploded
 I LA7SCMT'="" S OBR(13)=$$OBR13^LA7VOBR(LA7SCMT,LA7FS,LA7ECH)
 I LA7SCMT="" D
 . S LA7TCMT=$$TESTCMT(LA768,LA76801,LA76802,LA760)
 . I LA7TCMT="" D
 . . N LA760P
 . . S LA760P=$P(LA7ACC(LA7I),"^",3)
 . . I LA760P>0,LA760'=LA760P S LA7TCMT=$$TESTCMT(LA768,LA76801,LA76802,LA760P)
 . I LA7TCMT'="" S OBR(13)=$$OBR13^LA7VOBR(LA7TCMT,LA7FS,LA7ECH)
 ;
 ; Lab Arrival Time
 S OBR(14)=$$OBR14^LA7VOBR($P(LA76802(3),"^",3))
 ; HL7 code from Topography
 S LA7X=$S(LRDPF=62.3:"^^^CONTROL",1:"")
 S OBR(15)=$$OBR15^LA7VOBR(LA761,"",LA7X,LA7FS,LA7ECH)
 ; Ordering provider
 S LA7X=$$FNDOLOC^LA7VHLU2(LA7UID)
 S OBR(16)=$$ORC12^LA7VORC($P(LA76802(0),"^",8),$P(LA7X,"^",3),LA7FS,LA7ECH,2)
 ; Placer's field #1 - instrument name^card address
 K LA7X
 S LA7X(1)=$P(LRAUTO,"^")
 S LA7CADR=$P($G(^LAB(62.4,LRINST,9)),U,9)
 I LA7CADR'="" S LA7X(2)=LA7CADR
 S OBR(18)=$$OBR18^LA7VOBR(.LA7X,LA7FS,LA7ECH)
 ; Placer's field #2 - tray^cup^lraa^lrad^lran^lracc^lruid
 K LA7X
 ; No tray/cup if don't send tray/cup flag.
 I $G(LRFORCE) S:LA76821 LA7X(1)=LA76821 S:LA76822 LA7X(2)=LA76822
 S LA7X(3)=LA768,LA7X(4)=LA76801,LA7X(5)=LA76802,LA7X(6)=LA7ACC,LA7X(7)=LA7UID
 S OBR(19)=$$OBR19^LA7VOBR(.LA7X,LA7FS,LA7ECH)
 ;
 ; Test urgency
 S OBR(27)=$$OBR27^LA7VOBR("","",+$P(LA7ACC(LA7I),"^",2),LA7FS,LA7ECH)
 ;
 K LA7DATA
 D BUILDSEG^LA7VHLU(.OBR,.LA7DATA,LA7FS)
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 Q
 ;
 ;
SENDMSG ; Send the HL7 message.
 N HLL,HLP
 S HLL("LINKS",1)=LA7LINK
 I $D(LA7HLP) M HLP=LA7HLP
 D GEN^LA7VHLU,UPDT6249^LA7VORM1
 Q
 ;
 ;
TESTCMT(LA768,LA76801,LA76802,LA760) ; Check and build order test comments
 ;
 ; Call with LA768 = IEN of accesseion area
 ;         LA76801 = FM accession date
 ;         LA76802 = accession number
 ;           LA760 = IEN of file #60 test
 ;
 ; Returns  LA7CMT = comments in a single string (truncated to 300 characters per HL7 standard)
 ;
 N LA7CMT,LA7I,LA7QUIT,LA7X,LA7Y,LRIEN,LRODT,LRSN
 ;
 S LA7CMT="",LRIEN=0
 S LA7Y=$G(^LRO(68,LA768,1,LA76801,1,LA76802,0))
 S LRODT=+$P(LA7Y,"^",4),LRSN=+$P(LA7Y,"^",5)
 I LRODT>0,LRSN>0 S LRIEN=$O(^LRO(69,LRODT,1,LRSN,2,"B",LA760,0))
 ;
 I LRIEN D
 . S (LA7I,LA7QUIT)=0,LA7X=""
 . F  S LA7I=$O(^LRO(69,LRODT,1,LRSN,2,LRIEN,1,LA7I)) Q:LA7I<1  D  Q:LA7QUIT
 . . S LA7X=$G(^LRO(69,LRODT,1,LRSN,2,LRIEN,1,LA7I,0))
 . . I $E(LA7X,1,10)="~For Test:" Q
 . . I LA7X'="" S LA7X=$TR(LA7X,"~","")
 . . I LA7CMT'="" S LA7X=" "_LA7X
 . . S LA7CMT=LA7CMT_LA7X
 . . I $L(LA7CMT)>300 S LA7CMT=$E(LA7CMT,1,300),LA7QUIT=1
 ;
 Q LA7CMT
 ;
 ;
RACE ; Build RACE field in PID segment
 ;
 N CNT,IEN,LA7X,LA7Y,RACE,RACENUM,X,Y
 ;
 S PID(10)=""
 ;
 ; if from PATIENT file (#2) then check RACE array (VADM(12).
 I LRDPF=2,$G(VADM(12)) D  Q
 . ; Loop through all races (CNT is repetition location)
 . S RACENUM=0
 . F CNT=1:1 S RACENUM=+$O(VADM(12,RACENUM)) Q:'RACENUM  D
 . . ; Fabricate race value -> RACE-METHOD
 . . S RACE=$$PTR2CODE^DGUTL4(+VADM(12,RACENUM),1,2)
 . . S X=$$PTR2CODE^DGUTL4(+$G(VADM(12,RACENUM,1)),3,2)
 . . S:X="" X="UNK"
 . . S RACE=RACE_"-"_X
 . . ; First triplet
 . . S LA7Y(10,CNT,1)=RACE
 . . S LA7Y(10,CNT,2)=$P(VADM(12,RACENUM),"^",2)
 . . S LA7Y(10,CNT,3)="HL70005"
 . . ; Second triplet
 . . S X=$$PTR2CODE^DGUTL4(+VADM(12,RACENUM),1,3)
 . . S LA7Y(10,CNT,4)=X
 . . S LA7Y(10,CNT,5)=$P(VADM(12,RACENUM),"^",2)
 . . S LA7Y(10,CNT,6)="CDC"
 . S IEN=0
 . F  S IEN=$O(LA7Y(10,IEN)) Q:IEN=""  D
 . . S LA7X=""
 . . F CNT=1:1:6 I LA7Y(10,IEN,CNT)'="" S $P(LA7X,$E(LA7ECH,1),CNT)=LA7Y(10,IEN,CNT)
 . . I LA7X="" Q
 . . I PID(10)'="" S PID(10)=PID(10)_$E(LA7ECH,2)
 . . S PID(10)=PID(10)_LA7X
 ;
 ; if from REFERRAL PATIENT file (#67) then check RACE field.
 I LRDPF=67 D  Q
 . S LA7X=$$GET1^DIQ(67,DFN_",",.06,"I")
 . I LA7X<1 Q
 . S PID(10)=$$PTR2CODE^DGUTL4(LA7X,1,2)
 . S $P(PID(10),$E(LA7ECH,1),2)=$$PTR2TEXT^DGUTL4(LA7X,1)
 . S $P(PID(10),$E(LA7ECH,1),3)="HL70005"
 ;
 Q

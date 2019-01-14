MDHL7BH ; HOIFO/WAA,WOIFO/PMK -Bi-directional interface (HL7) routine ;15 Jun 2018 12:46 PM
 ;;1.0;CLINICAL PROCEDURES;**11,21,20,60**;Apr 01, 2004;Build 1
 ;
 ; This routine will build the HL7 Message and store that message.
 ; After the message has been created then it will call the
 ; The actual HL7package to start the processing of the message
 ;
 ; Reference DBIA #2056 [Supported] reference $$GET1^DIQ function call
 ; Reference DBIA #2161 [Supported] call to INIT^HLFCN2
 ; Reference DBIA #2164 [Supported] call to GENERATE^HLMA
 ; Reference DBIA #6932 [Private] call to CLINPROC^MAGDHLWP
 ; Reference DBIA #10061 [Supported] call to ADD^VADPT
 ; Reference DBIA #10103 [Supported] calls to $$NOW^XLFDT
 ; Reference DBIA #3062 [Supported] calls to $$HLNAME^XLFNAME
 ; Reference DBIA #2263 [Supported] calls to $$GET^XPAR
 ; Reference DBIA #3067 [Private] Read Consult Data with FM call.
 ; Reference DBIA #10035[Supported] Patient File Access
 ; Reference DBIA #10040[Supported] Access ^SC
 ; Reference DBIA #10056[Supported] Direct read STATE (5)
 Q
EN1 ;Main Entry point.
 N MDMSG,MD101,CNT,HLA,LINE,MDHL,DFN,MDLINK
 Q:RESULT<1  ; This tells the study is not a BDi
 S MDLINK=$$GET1^DIQ(702.09,DEVIEN,.18,"E")
 I MDLINK="" S RESULT=-1,MSG="No HL Logical Link has been defined." Q  ; No link has been defined
 S MDERROR="0"
 D INIT^HLFNC2("MCAR ORM SERVER",.MDMSG)
 I +$G(MDMSG)>0 S RESULT=-1,MSG="Unable to produce a message." Q  ; something is wrong and no MSH was created
 S DFN=$$GET1^DIQ(702,MDD702,.01,"I")
 S DEVNAME=$$GET1^DIQ(702.09,DEVIEN,.16,"I")
 S CNT=0
 D PID S CNT=CNT+1,HLA("HLS",CNT)=LINE
 D PV1 S CNT=CNT+1,HLA("HLS",CNT)=LINE
 D ORC S CNT=CNT+1,HLA("HLS",CNT)=LINE
 D OBR I LINE'="" S CNT=CNT+1,HLA("HLS",CNT)=LINE
 S HLP("SUBSCRIBER")="^^VISTA^^"_DEVNAME_"^M"
 S HLL("LINKS",1)="MCAR ORM CLIENT"_"^"_MDLINK
 ;
 ; MD*1.0*60 - 16 April 2018 - Peter Kuzmak, VistA Imaging
 ; VistA Imaging code to generate CPRS Consult Request Tracking
 ; HL7 message for the DICOM Text Gateway to put the CP study
 ; on the DICOM Modality Worklist.  This usually happens when
 ; the study is ordered, but is deferred for CP to check-in time.
 ; 
 ; This considerably improves interoperability between Clinical Procedure
 ; and VistA Imaging CPRS Consult Request Tracking DICOM.
 ; 
 ; If the CP - DICOM INTEROPERABILITY (field #.19) of the CP Instrument
 ; file (#702.09) is set to 2, then the VistA Imaging HL7 will replace
 ; the just-created CP HL7 in HLA("HLS"). The benefit for this is the
 ; VistA Imaging HL7 has much more data than does the CP HL7.  The VistA
 ; Imaging HL7 would be transmitted to the instrument identically the same
 ; as the CP HL7, using the 1.6 HL7 package software (i.e., not HLO).
 ; 
 I $T(CLINPROC^MAGDHOWP)'="" D CLINPROC^MAGDHOWP(MDD702,MDORFLG) ; invoke VistA Imaging to generate HL7
 ;
 D GENERATE^HLMA("MCAR ORM SERVER","LM",1,.MDHL,,.HLP)
 I $P(MDHL,U,2) S MDERROR=MDHL
 Q
OBR ; Send the procedure to the correct device
 S LINE="OBR|"
 S DEVIEN=$$GET1^DIQ(702,MDD702,.11,"I")
 S USC=$$GET1^DIQ(702.09,DEVIEN,.17,"I")
 I USC="" S LINE="" Q
 E  S USC=$TR(USC,"=","^")
 S $P(LINE,"|",5)=USC_"|"
 Q
PID ;get the patient information and build the PID
 ;PID|||SSN||Last^First||DOB|SEX|||||||||||SSN
 N MDSSN,NAME,DOB,ADDR,TMP,MDADD,VAPA,VAERR,VAROOT,MDPCOD
 S LINE="PID|",$P(LINE,"|",21)=""
 S MDSSN=$$GET1^DIQ(702,MDD702,.011) ; Get the ssn for the patient
 S NAME=$$GET1^DIQ(702,MDD702,.01,"E") ; get the patient name
 S NAME=$$HLNAME^XLFNAME($P(NAME,"^"),"",$E(HLECH,1))
 I $P(NAME,$E(HLECH,1),7)'="L" S $P(NAME,$E(HLECH,1),7)="L"
 S DOB=$$GET1^DIQ(2,DFN,.03,"I") S DOB=$$FTOHL7^MDHL7U2(DOB)
 S VAROOT="MDADD" D ADD^VADPT
 S ADDR=$G(MDADD(1))_"^" ; Address 1
 S TMP=$G(MDADD(2)) I TMP'="" S ADDR=ADDR_TMP ; Add 2
 S TMP=$G(MDADD(3)) I TMP'="" S ADDR=ADDR_" "_TMP ; Add 3
 S ADDR=ADDR_"^"_$G(MDADD(4)) ; City
 S MDPCOD=$P($G(MDADD(5)),"^",1) I MDPCOD'="" S MDPCOD=$P($G(^DIC(5,MDPCOD,0)),"^",2)
 ; ^^^^^^ Setting MDPCODE to Postal code Via direct supported lookup.
 S ADDR=ADDR_"^"_MDPCOD ; State Postal Code
 S ADDR=ADDR_"^"_$G(MDADD(6)) ; Zip
 K MDADD
 S $P(LINE,"|",2)="1"
 S $P(LINE,"|",4)=MDSSN
 S $P(LINE,"|",6)=NAME
 S $P(LINE,"|",8)=DOB
 S $P(LINE,"|",9)=$$GET1^DIQ(2,DFN,.02,"I")
 S $P(LINE,"|",12)=ADDR
 S $P(LINE,"|",20)=MDSSN
 Q
PV1 ;Get the ward location for PV1
 ;PV1||In or out|Ward location
 N CWARD,WARD,INOUT,CONSULT,REF,NREF,WARD1,WARD2,MDPR1,MDPNAM,MDSV
 S WARD=$$GET1^DIQ(2,DFN,.1,"E"),(WARD1,WARD2)=""
 S INOUT=$S(WARD'="":"I",1:"O")
 S:WARD'="" WARD=WARD_U_WARD
 S CONSULT=$$GET123^MDHL7U2(MDD702)
 S CWARD=$P($G(^MDD(702,+MDD702,0)),U,7),CWARD=$P(CWARD,";",3)
 S:+CWARD WARD2=$$GET1^DIQ(44,+CWARD_",",.01,"E")
 S MDPR1=$$GET1^DIQ(702,+MDD702_",",.04,"I")
 S:+MDPR1 WARD1=$$GET1^DIQ(702.01,+MDPR1_",",.05,"E")
 S MDPNAM=$$GET1^DIQ(702.09,DEVIEN,.06,"I")
 I INOUT="O" D
 .;S WARD=WARD1 S:WARD="" WARD=WARD2
 .S WARD=WARD2 S:WARD="" WARD=WARD1
 .I WARD="" S WARD=$$GET1^DIQ(123,CONSULT_",",.04,"E"),MDSV="A;"_$$NOW^XLFDT()_";"_$$GET1^DIQ(123,CONSULT_",",.04,"I"),$P(^MDD(702,+MDD702,0),U,7)=MDSV
 .I MDPNAM["Olympus" D
 ..S WARD1=$O(^SC("B",WARD,0)),CWARD=$P($G(^SC(+WARD1,0)),U,2)
 ..S WARD=$S(+$$GET^XPAR("SYS","MD OLYMPUS 7",1)>0:$E(WARD,1,7),1:$E(WARD,1,4))_"^"_CWARD
 I INOUT="I" D
 .S:WARD="" WARD=WARD2 S:WARD="" WARD=WARD1
 .S:WARD="" WARD=$$GET1^DIQ(123,CONSULT_",",.04,"E")
 .S WARD=WARD_"^"_$S($G(^DPT(2,.101))'="":$G(^DPT(2,.101)),1:"") Q
 ;V--- NEW CODE THis code is
 I $P($P(^MDD(702,+MDD702,0),U,7),";",3)="" D
 . I +MDPR1 Q:+$$GET1^DIQ(702.01,+MDPR1_",",.05,"I")
 . S MDSV="A;"_$$NOW^XLFDT()_";"_$$GET1^DIQ(123,CONSULT_",",.04,"I"),$P(^MDD(702,+MDD702,0),U,7)=MDSV
 . Q
 ;^--- NEW CODE
 S LINE="PV1||"_INOUT_"|"_WARD
 Q:CONSULT<1
 S NREF=$$GETREF^MDHL7U2(CONSULT) Q:NREF="-1"
 S $P(LINE,"|",9)=NREF
 Q
ORC ;get ORC onformation
 ;ORC|NA|Order Number|||||||date/time ordered
 N DATE,SDATE
 S DATE=$$GET1^DIQ(702,MDD702,.02,"I")
 S DATE=$$FTOHL7^MDHL7U2(DATE)
 S SDATE=$$GET1^DIQ(702,MDD702,.07,"I")
 I SDATE[";" S SDATE=$P(SDATE,";",2)
 I SDATE="" D NOW^%DTC S SDATE=% S $P(^MDD(702,MDD702,0),"^",7)=SDATE
 I SDATE<DT D NOW^%DTC S SDATE=%
 S SDATE=$$FTOHL7^MDHL7U2(SDATE)
 S LINE="ORC|"_$S(MDORFLG=1:"NW",MDORFLG=0:"CA",1:"")_"|"_MDIORD
 S $P(LINE,"|",6)=$S(MDORFLG=1:"NW",MDORFLG=0:"CA",1:"")
 S $P(LINE,"|",10)=DATE,$P(LINE,"|",16)=SDATE
 Q

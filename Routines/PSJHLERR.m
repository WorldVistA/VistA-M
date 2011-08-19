PSJHLERR ;BIR/LDT-PATIENT ID AND VISIT SEGMENTS FOR ERRORS ; 20 Apr 98 / 9:58 AM
 ;;5.0; INPATIENT MEDICATIONS ;**1,42**;16 DEC 97
 ;
 ;Only used for error messages to OE/RR where the Pharmacy order
 ;number is invalid.
EN1(PSJHLDFN,PSOC,RXORDER,PSREASON) ; start here
 ; passed in are PSJHLDFN (patient ien)
 ;               RXORDER (order number from OE/RR)
 ;               PSOC (order control code)
 ;               PSREASON (text reason)
START ;
 K ^TMP("PSJHLS",$J,"PS")
 N WARD,ROOMBED,FIELD,PSJI,CLERK,LIMIT,PSJHLSDT,PSJHINST,PSJHLMTN
 D INIT,PID,PV1,ORC
 D CALL^PSJHLU(PSJI)
 K PSJI,PSOC,PSJCLEAR,PSREASON,J,NEXT,RXORDER
 Q
 ;
INIT ; initialize HL7 variables, set master file identification segment
 ; PSJHLMTN = message type - ORR for messages sent as a response to
 ; an OE/RR event; ORM for "unsolicited" messages.
 S PSJI=0,PSJHLMTN="ORR"
 D INIT^PSJHLU
 S LIMIT=17 X PSJCLEAR
 S FIELD(0)="MSH",FIELD(1)="^~\&",FIELD(2)="PHARMACY",FIELD(3)=$G(PSJHINST),FIELD(8)=PSJHLMTN
 D NOW^%DTC S FIELD(4)="ORDER ENTRY",FIELD(5)=FIELD(3),FIELD(6)=$$HLDATE^HLFNC(%)
 D SEGMENT^PSJHLU(LIMIT),DISPLAY
 Q
 ;
PID ; get patient data, format PID SEGMENT
 S LIMIT=22 X PSJCLEAR
 S FIELD(0)="PID"
 S FIELD(3)=PSJHLDFN
 N DFN S DFN=PSJHLDFN D ^VADPT S FIELD(5)=VADM(1)
 D SEGMENT^PSJHLU(LIMIT),DISPLAY
 Q
 ;
PV1 ; get patient visit information, format PV1 segment
 S LIMIT=50 X PSJCLEAR
 S FIELD(0)="PV1"
 I PSJHLMTN="ORR" S FIELD(3)=LOC
 I PSJHLMTN="ORM" D
 .S LOC="",WARD=$G(^DPT(PSJHLDFN,.1)),LOC=$S($G(WARD)]"":$O(^SC("B",WARD,LOC)),1:LOC)
 .I $G(LOC)]"" S ROOMBED=$G(^DPT(PSJHLDFN,.101)),LOC=LOC_"^"_ROOMBED
 .S FIELD(3)=LOC
 S FIELD(2)=$S($G(CLASS)]"":CLASS,1:"I")
 I FIELD(2)="I" N DFN S DFN=PSJHLDFN D INP^VADPT S FIELD(19)=VAIN(1)
 D SEGMENT^PSJHLU(LIMIT),DISPLAY
 Q
 ;
ORC ; order control segment - modified for use with error messages.
 S LIMIT=18 X PSJCLEAR
 Q:'$D(RXORDER)!'$D(PSOC)
 S FIELD(0)="ORC"
 S FIELD(1)=PSOC
 S FIELD(2)=RXORDER_"^OR"
 S FIELD(3)=$S(PSOC="ZR":$G(RXON),1:"")_"^PS"
 S CLERK=$P($G(^VA(200,DUZ,0)),"^")
 S FIELD(10)=DUZ_"^"_CLERK_"^"_"99NP"
 ;Nature of Order is X - Rejected on error messages,unless the message
 ;is in response to a purge message.
 S FIELD(16)=$S(PSOC="ZR":U_U,1:"X"_U_"Rejected")_U_"99ORN"_U_U_$G(PSREASON)_U
 D SEGMENT^PSJHLU(LIMIT),DISPLAY
 Q
 ;
DISPLAY ; just for testing
 ;W ! F NEXT=0:1:LIMIT W FIELD(NEXT)_"|"
 Q

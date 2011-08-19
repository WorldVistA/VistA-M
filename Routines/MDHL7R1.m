MDHL7R1 ; HOIFO/WAA -Clinivision Resporatory ; 06/13/02
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Reference Supported DBIA #10035 PATIENT
 ; Reference Supported DBIA #10106 HL7
 ; IA# 10103 [Supported] Calls to XLFT
 ;     10090 [Supported] FM read of DIC(4
 ;
OBX ; Process OBX
 N MDATT,PROC,P,PNAM,AGE,DOB,DOBAGE,STATION
 I $G(STATION) S STATION=$$FIND1^DIC(4,"","MX",STATION)
 S:'$L($G(STATION)) STATION=$G(DUZ(2))
 S PNAM=$P(^DPT(DFN,0),U,1)
 S DOB=$P(^DPT(DFN,0),U,3)
 S DOB=$$FMTE^XLFDT(DOB,"1D")
 S AGE=$$GET1^DIQ(2,DFN,.033)
 S DOBAGE=DOB_" ("_AGE_")"
 K ^TMP($J,"MDHL7","TEXT")
 S P="|"
 D ATT^MDHL7U(DEVIEN,.MDATT) Q:MDATT<1
 S PROC=0
 F  S PROC=$O(MDATT(PROC)) Q:PROC<1  D
 . N PROCESS
 . S PROCESS=$P(MDATT(PROC),";",5)
 . I PROCESS="TEXT^MDHL7U2" D TXT
 . D @PROCESS
 . Q
 Q:'MDIEN
 D REX^MDHL7U1(MDIEN)
 D GENACK^MDHL7X
 Q
TXT ; Extract data and process it for the test fuinction
 N CNT,CNT2,LINE,LINE2
 S (CNT,CNT2)=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . S LINE=^TMP($J,"MDHL7A",CNT)
 . I $P(LINE,P,1)="PID" D  Q  ;HEADER
 .. N SPC
 .. S LINE2=$J("Report from: ",31)_$$GET1^DIQ(4,+STATION_",",.01,"E")_"    Station #"_$$GET1^DIQ(4,+STATION_",",99,"E")
 .. S CNT2=CNT2+1
 .. S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||"_LINE2
 .. S LINE2="Clinivision Report"
 .. S CNT2=CNT2+1
 .. S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||"_LINE2
 .. S LINE2=PNAM_"   "_$E(MDSSN,1,3)_"-"_$E(MDSSN,4,5)_"-"_$E(MDSSN,6,9)
 .. S SPC=77-$L(LINE2),LINE2=LINE2_$J(DOBAGE,SPC)
 .. S CNT2=CNT2+1
 .. S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||"_LINE2
 .. Q
 . I $P(LINE,P,1)="OBR" D  Q
 .. S LINE2=""
 .. S $P(LINE2,"=",79)=""
 .. S CNT2=CNT2+1
 .. S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||"_LINE2
 .. S LINE2=$$FMDATE^HLFNC($E($P(LINE,P,8),1,14))
 .. S LINE2=$$FMTE^XLFDT(LINE2,"1P")
 .. S LINE2="REPORT DATE: "_LINE2
 .. S CNT2=CNT2+1
 .. S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||"_LINE2
 .. Q
 . I $P(LINE,P,1)'="OBX" Q
 . I $P(LINE,P,3)'="ST" Q
 . S LINE2=$P($P(LINE,P,4),U,2)
 . I LINE2="Comment" D
 .. S LINE2=""
 .. S CNT2=CNT2+1
 .. S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||Comment:"
 .. Q
 . E  S LINE2=LINE2_": "
 . S LINE2=LINE2_$P(LINE,P,6)
 . S CNT2=CNT2+1
 . S ^TMP($J,"MDHL7","TEXT",CNT2)="OBX||TX|||"_LINE2
 . Q
 Q

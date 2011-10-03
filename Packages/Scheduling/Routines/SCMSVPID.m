SCMSVPID ;ALB/ESD HL7 PID Segment Validation ; 23 Oct 98  3:36 PM
 ;;5.3;Scheduling;**44,66,162,254,293,441**;Aug 13, 1993;Build 14
 ;
 ;
EN(PIDSEG,HLQ,HLFS,HLECH,VALERR,ENCDT,EVNTHL7) ;
 ; Entry point to return the HL7 PID (Patient ID) validation segment
 ;
 ;  Input:  PIDSEG  - Array containing PID segment (pass by ref)
 ;                    PIDSEG = First 245 characters
 ;                    PIDSEG(1..n) = Continuation nodes
 ;             HLQ  - HL7 null variable
 ;            HLFS  - HL7 field separator
 ;           HLECH  - HL7 encoding characters
 ;          VALERR  - The array name to put the errors in
 ;           ENCDT  - The date/time of the encounter.
 ;         EVNTHL7  - Event type ("A08" for add/edit, "A23" for delete)
 ;
 ; Output:  1 if PID passed validity check
 ;          Error message if PID failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in PID segment)
 ;
 ;Declare variables
 N MSG,SEQ,SD,PARSEG,SEG,I
 S PARSEG=$NA(^TMP("SCMSVPID",$J,"PARSEG"))
 K @PARSEG
 S MSG="-1^Element in PID segment failed validity check"
 ;-Set encoding chars to standard HL7 encoding chars if not passed in
 I '$D(HLQ) S HLQ=$C(34,34)
 S HLECH=$G(HLECH)
 S:HLECH="" HLECH="~|\&"
 ;-Create array of elements to validate
 F SEQ=3,5,7,8,10,11,16,17,19,22 S SD(SEQ)=""  ;Elements for 'add' or 'edit' transactions
 I $G(EVNTHL7)="A23" K SD F I=3,19 S SD(SEQ)=""  ;Elements for 'delete' transactions
 ;
 S SEG="PID"
 D VALIDATE^SCMSVUT0(SEG,$G(PIDSEG),"0006",VALERR,.CNT)
 I $D(@VALERR@(SEG)) G ENQ
 ;-Parse out fields
 D SEGPRSE^SCMSVUT5("PIDSEG",PARSEG,HLFS)
 ;-Remember DFN
 ;S DFN=$$CONVERT^SCMSVUT0($G(@PARSEG@(3)),$E(HLECH,1),HLQ)
 ;S DFN=+$P(DFN,$E(HLECH,1),1)
 ;-Validate segment name
 S CNT=1
 D VALIDATE^SCMSVUT0(SEG,$G(@PARSEG@(0)),$P($T(0),";",3),VALERR,.CNT)
 ;-Validate fields
 S SEQ=0
 F  S SEQ=+$O(SD(SEQ)) Q:'SEQ  D
 .I SEQ=11 D ADDRCHK(SEG,VALERR,.CNT) Q
 .I (SEQ=10)!(SEQ=22)!(SEQ=3) D  Q
 ..N PARSEQ,REP,COMP
 ..S PARSEQ=$NA(^TMP("SCMSVPID",$J,"PARSEQ"))
 ..K @PARSEQ
 ..D SEQPRSE^SCMSVUT5($NA(@PARSEG@(SEQ)),PARSEQ,HLECH)
 ..S REP=0
 ..F  S REP=+$O(@PARSEQ@(REP)) Q:'REP  D
 ...I SEQ=3,$G(@PARSEQ@(REP,5))'="PI" Q
 ...S DATA=$$CONVERT^SCMSVUT0($G(@PARSEQ@(REP,1)),$E(HLECH,4),HLQ)
 ...D VALIDATE^SCMSVUT0(SEG,$P(DATA,$E(HLECH,1),1),$P($T(@(SEQ)),";",3),VALERR,.CNT)
 ..K @PARSEQ
 .S DATA=$G(@PARSEG@(SEQ))
 .S DATA=$$CONVERT^SCMSVUT0(DATA,$E(HLECH,1),HLQ)
 .;S:SEQ=3 DATA=$P(DATA,$E(HLECH,1),1)
 .S:SEQ=5 DATA=$$FMNAME^HLFNC(DATA)
 .S:SEQ=7 DATA=$$FMDATE^HLFNC(DATA)
 .D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(SEQ)),";",3),VALERR,.CNT)
 ;
ENQ K @PARSEG
 Q $S($D(@VALERR@(SEG,1)):MSG,1:1)
 ;
 ;
ADDRCHK(SEG,VALERR,CNT) ;- Validity check for address (seq 11)
 ;
 ;Declare variables
 N PARSEQ,REP,COMP,DATA,TYPE,OFFSET,CODE,STATE,SKIP,FORIGN
 ;Parse sequence into repeated components
 S PARSEQ=$NA(^TMP("SCMSVPID",$J,"PARSEQ"))
 K @PARSEQ
 D SEQPRSE^SCMSVUT5($NA(@PARSEG@(11)),PARSEQ,HLECH)
 ;Validate
 S REP=0
 F  S REP=+$O(@PARSEQ@(REP)) Q:'REP  D
 .;Get address type
 .S TYPE=$$CONVERT^SCMSVUT0($G(@PARSEQ@(REP,7)),$E(HLECH,4),HLQ)
 .;Set foreign country flag
 .S FORIGN=$$FOR^DGADDUTL($$CONVERT^SCMSVUT0($G(@PARSEQ@(REP,6)),$E(HLECH,4),HLQ))
 .I (TYPE'["P")&(TYPE'["VAC") Q  ;validate permanent and confidential addresses
 .S:TYPE="" TYPE="P" S:TYPE'="P" TYPE="VACA"
 .;Calculate error code offset
 .S OFFSET=$S($E(TYPE,1,4)="VACA":200,TYPE="P":0,1:0)
 .;If it's a confidential address, everything is allowed to be empty
 .I $E(TYPE,1,4)="VACA" S SKIP=1 D  Q:SKIP
 ..F SEQ=1,2,3,4,5,8,9,12 D  Q:'SKIP
 ...S DATA=$$CONVERT^SCMSVUT0($G(@PARSEQ@(REP,SEQ)),$E(HLECH,4),HLQ)
 ...I SEQ=12 Q:DATA=$E(HLECH,4)  S SKIP=0 Q
 ...I DATA'="" S SKIP=0
 .;Validate components
 .S STATE=0
 .F SEQ=1,2,3,4,5,7,9,12 D
 ..I FORIGN,((SEQ=4)!(SEQ=5)!(SEQ=9)) Q  ;foreign addresses have no state/zip/county
 ..I TYPE="P" Q:((SEQ=7)!(SEQ=12))
 ..S DATA=$$CONVERT^SCMSVUT0($G(@PARSEQ@(REP,SEQ)),$E(HLECH,4),HLQ)
 ..I SEQ=12 Q:DATA=$E(HLECH,4)
 ..I SEQ=9 S STATE=$G(@PARSEQ@(REP,4)) I STATE'="" S STATE=+$O(^DIC(5,"C",STATE,""))
 ..S CODE=$S(SEQ<10:"110",1:"11")_SEQ
 ..S CODE=OFFSET+$P($T(@(CODE)),";",3)
 ..D VALIDATE^SCMSVUT0(SEG,DATA,CODE,VALERR,.CNT)
 K @PARSEQ
 Q
 ;
ERR ;;Invalid or missing patient ID data for encounter (HL7 PID data segment)
 ;
 ;
 ;- PID data elements validated
 ;
0 ;;0035;HL7 SEGMENT NAME
3 ;;2030;PATIENT ID (INTERNAL)
5 ;;2000;NAME
7 ;;2050;DATE OF BIRTH
8 ;;2100;SEX
10 ;;2150;RACE
1101 ;;2200;STREET ADDRESS 1
1102 ;;2210;STREET ADDRESS 2
1103 ;;2220;CITY
1104 ;;2230;STATE
1105 ;;2240;ZIP CODE
1107 ;;2270;ADDRESS TYPE
1109 ;;2250;COUNTY CODE
1112 ;;2280;ADDRESS START/STOP DATE
16 ;;2300;MARITAL STATUS
17 ;;2330;RELIGION
19 ;;2360;SSN
22 ;;2380;ETHNICITY

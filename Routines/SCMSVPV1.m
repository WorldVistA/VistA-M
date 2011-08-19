SCMSVPV1 ;ALB/ESD HL7 PV1 Segment Validation ; 23 Oct 98  3:45 PM
 ;;5.3;Scheduling;**44,55,91,66,162,387**;Aug 13, 1993
 ;
 ;
EN(PV1SEG,HLQ,HLFS,VALERR,NODE,EVNTHL7,ENCNDT) ;
 ; Entry point to return the HL7 PV1 (Patient Visit) validation segment
 ;
 ;  Input:  PV1SEG - PV1 Segment
 ;             HLQ - HL7 null variable
 ;            HLFS - HL7 field separator
 ;          VALERR - The array to put errors in
 ;         EVNTHL7 - Event type ("A08" for add/edit, "A23" for delete)
 ;          ENCNDT - Encounter date
 ;
 ; Output:  1 if PV1 passed validity check
 ;          Error message if PV1 failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in PV1 segment)
 ;
 ;NOTE:
 ;this routine uses the variable NODE which would contain the zero node
 ;of the encounter.  It is looking for the division in the 11th piece.
 ;this is for the check on the facility.
 ;
 N I,MSG,X,CNT,DATA,SEG,SD,XMTFLG
 ;
 ;-Create array of elements to validate
 F I=1,3,5,510,15,40,401,45,51 S SD(I)=""  ;Elements for 'add' or 'edit' transactions
 I $G(EVNTHL7)="A23" K SD F I=40,45,51 S SD(I)=""  ;Elements for 'delete' transactions
 ;
 S MSG="-1^Element in PV1 segment failed validity check",CNT=1
 S PV1SEG=$G(PV1SEG),SEG="PV1"
 D VALIDATE^SCMSVUT0(SEG,PV1SEG,"0008",VALERR,.CNT)
 I $D(@VALERR@(SEG)) G ENQ
 ;
 ;- Convert HLQ to null
 S PV1SEG=$$CONVERT^SCMSVUT0(PV1SEG,HLFS,HLQ)
 ;
 ;- Validate data elements
 F I=1,3,5,510,15,40,401,45,51 D
 . S DATA=$S(I=45:$$FMDATE^HLFNC($P(PV1SEG,HLFS,+I)),I=510:$P(PV1SEG,HLFS,+$E(I,1,1)),I=401:$P(PV1SEG,HLFS,+$E(I,1,2)),1:$P(PV1SEG,HLFS,+I))
 . I I=40!(I=401) N DIV S DIV=$S($D(NODE):$P(NODE,U,11),1:"")
 . I I=45 S XMTFLG=$S($P(PV1SEG,HLFS,3)="I":1,1:0)
 . D:$D(SD(I)) VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(I)),";",3),VALERR,.CNT)
 . Q
 ;if inpatient perform validation for NPCD closeout on encounter date
 I $P(PV1SEG,HLFS,3)="I" D
 .S XMTFLG=0
 .D VALIDATE^SCMSVUT0(SEG,ENCNDT,"4200",VALERR,.CNT)
 ;
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
 ;
ERR ;;Invalid or missing patient visit data for encounter (HL7 PV1 segment)
 ;
 ;
 ;- PV1 data elements validated
 ;
1 ;;0035;HL7 SEGMENT NAME 
3 ;;4000;PATIENT CLASS 
5 ;;4050;PURPOSE OF VISIT/APPT TYPE 
510 ;;Z000;Invalid Appointment Type (Computer Generated)
15 ;;4070;LOCATION OF VISIT
40 ;;4150;FACILITY NUMBER/SUFFIX
401 ;;4160;INACTIVE FACILITY
45 ;;4200;VISIT (ENCOUNTER) DATE/TIME 
51 ;;4100;UNIQUE IDENTIFIER (PCE) 

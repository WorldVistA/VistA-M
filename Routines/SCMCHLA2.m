SCMCHLA2 ;ALB/KCL - PCMM HL7 Error Code & ID File API'S ;25-JAN-2000
 ;;5.3;Scheduling;**210**;AUG 13, 1993
 ;
GETEC(SCIEN,SCEC) ;
 ; Description: Used to obtain a record from the PCMM HL7 ERROR CODE
 ; (#404.472) file and place it into the local SCECODE array.
 ;
 ;  Input :
 ;   SCIEN - IEN of a PCMM HL7 ERROR CODE record
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure.
 ;  SCECODE - if succes, the name of local array containing the record,
 ;            passed by reference.
 ;
 ;     subscript      field name
 ;     ---------      ----------
 ;     "CODE"         Error Code
 ;     "SEG"          Segment
 ;     "FLD"          Field
 ;     "SHORT"        Short Description
 ;
 N NODE
 ;
 I '$G(SCIEN) Q 0
 I '$D(^SCPT(404.472,SCIEN,0)) Q 0
 ;
 K SCECODE S SCECODE=""
 S NODE=$G(^SCPT(404.472,SCIEN,0))
 S SCEC("CODE")=$P(NODE,"^")
 S SCEC("SEG")=$P(NODE,"^",2)
 S SCEC("FLD")=$P(NODE,"^",3)
 S SCEC("SHORT")=$P(NODE,"^",4)
 Q 1
 ;
 ;
GETHL7ID(SCIEN,SCHLID) ;
 ; Description: Used to obtain a record from the PCMM HL7 ID
 ; file and place it into the local SCHLID array.
 ;
 ;  Input :
 ;   SCIEN - IEN of a PCMM HL7 ID record
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure.
 ;  SCHID - if succes, the name of local array containing the record,
 ;          passed by reference.
 ;
 ;     subscript      field name
 ;     ---------      ----------
 ;     "HL7ID"        Name
 ;     "INTID"        Integration ID
 ;    
 N SUB,NODE
 ;
 I '$G(SCIEN) Q 0
 I '$D(^SCPT(404.49,SCIEN,0)) Q 0
 K SCHLID S SCHLID=""
 S NODE=$G(^SCPT(404.49,SCIEN,0))
 S SCHLID("HL7ID")=$P(NODE,"^")
 S SCHLID("INTID")=$P(NODE,"^",2)
 Q 1

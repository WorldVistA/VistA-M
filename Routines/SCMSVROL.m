SCMSVROL ;BP/JRP - HL7 ROL Segment Validation;6-MAR-1998
 ;;5.3;Scheduling;**142,245**;Aug 13, 1993
 ;
 ;
EN(ROLARRY,HLQ,HLFS,HLECH,VALERR) ;Entry point to validate all HL7 ROL
 ; (Role) segments built for message
 ;
 ;Input : ROLARRY - Array of ROL Segments
 ;        HLQ - HL7 null designation
 ;        HLFS - HL7 field separator
 ;        HLECH - HL7 encouding characters
 ;        VALERR - Array to return error list in (full global reference)
 ;
 ;Output:  1 - All ROL segments passed validity checks
 ;        -1^Text - One/many/all ROL segments failed validity checks
 ;        List of errors returned as follows:
 ;          VALERR("ROL",x) = Error Code
 ;Notes : Initialization of VALERR() is the reponsibility of the
 ;        calling program
 ;      : Existance/validity of input is assumed
 ;
 ;Declare variables
 N LOOP1,CNT,MSG,PRIMECNT,TMP,SCMSVROL,PRIME
 S MSG="-1^Element in ROL segment failed validity check"
 S PRIMECNT=0
 ;Loop through array of ROL segments
 S LOOP1=0
 F  S LOOP1=+$O(@ROLARRY@(LOOP1)) Q:('LOOP1)  D
 .;Validate individual segment
 .S TMP=$$EN1($NA(@ROLARRY@(LOOP1)),HLQ,HLFS,HLECH,VALERR,.PRIME)
 .;Track total number of primary providers designated
 .I PRIME S PRIMECNT=PRIMECNT+1
 ;Make logic in D050 only allow the number 1
 S SCMSVROL=1
 ;Validate number of primary providers designated (must be 1)
 S CNT=1+$O(@VALERR@("ROL",""),-1)
 D VALIDATE^SCMSVUT0("ROL",PRIMECNT,"D050",VALERR,.CNT)
ENQ Q $S($D(@VALERR@("ROL")):MSG,1:1)
 ;
EN1(ROLSEG,HLQ,HLFS,HLECH,VALERR,PRIME) ;Entry point to validate the HL7 ROL
 ; (Role) segment
 ;
 ;Input : ROLSEG - Array containing ROL Segment (full global reference)
 ;                 ROLSEG = First 245 characters
 ;                 ROLSEG(x) = Continuation nodes
 ;        HLQ - HL7 null designation
 ;        HLFS - HL7 field separator
 ;        HLECH - HL7 encoding characters
 ;        VALERR - Array to return error list in (full global reference)
 ;        PRIME - Output variable (pass by reference)
 ;
 ;Output:  1 - ROL segment passed validity checks
 ;        -1^Text - ROL segment failed validity checks
 ;        List of errors returned as follows:
 ;          VALERR("ROL",x) = Error Code
 ;        PRIME = 1 if primary encounter provider
 ;        PRIME = 0 if not primary encounter provider
 ;Notes : Initialization of VALERR() is the reponsibility of the
 ;        calling program
 ;      : Existance/validity of input is assumed
 ;
 ;Declare variables
 N SEG,MSG,CNT,TMP,PARSEG,OLDCNT,CMPSEP,SCMSVROL,LOOP,CODE,CHECK
 S MSG="-1^Element in ROL segment failed validity check"
 S (OLDCNT,CNT)=1+$O(@VALERR@("ROL",""),-1)
 S PRIME=0
 ;Parse out fields
 S TMP("FS")=HLFS,TMP("ECH")=HLECH,TMP("Q")=HLQ
 D PARSEG^SCMSVUT4(ROLSEG,"PARSEG",.TMP,0,1)
 I PARSEG(0)'="ROL" D VALIDATE^SCMSVUT0("ROL","","0370",VALERR,.CNT) G EN1Q
 ;Remember component separator
 S CMPSEP=$E(HLECH,1)
 ;Primary care provider ?
 S DATA=$G(PARSEG(3,1))
 S:($P(DATA,CMPSEP,4)=1) PRIME=1
 ;Make logic in D050 allow numbers 0 and 1
 S SCMSVROL=0
 ;Validate
 S CODE=""
 F LOOP=1:1 D  Q:CODE=""
 .S DATA=$T(ERRORS+LOOP)
 .S CODE=$P(DATA,";",3)
 .Q:(CODE="")
 .S CHECK=$P(DATA,";",1)
 .S DATA=$G(PARSEG(+$E(CHECK,1,2),+$E(CHECK,3,4)))
 .S DATA=$P(DATA,CMPSEP,+$E(CHECK,5,6),+$E(CHECK,7,8))
 .D VALIDATE^SCMSVUT0("ROL",DATA,CODE,VALERR,.CNT)
EN1Q Q $S(CNT'=OLDCNT:MSG,1:1)
 ;
 ;Line tag format is SSRRBCEC
 ;  SS=sequence, RR=repetition
 ;  BC=begining component, EC=ending component
ERRORS ;Data elements validated
01010101  ;;D150;ROLE INSTANCE ID
03010101  ;;D000;PROVIDER TYPE CODE
03010404  ;;D050;PRIMARY ENCOUNTER PROVIDER DESIGNATION
04010101  ;;D070;INVALID PROVIDER ID
04010207        ;;D130;PROVIDER NAME
04020101        ;;D140;PROVIDER SSN
 ;;
 ;;

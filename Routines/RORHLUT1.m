RORHLUT1 ;HCIOFO/SG - HL7 UTILITIES (HIGH LEVEL) ; 8/24/05 1:55pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS A REASON WHY THE PATIENT HAS BEEN ADDED
 ;
 ; RORIENS       IENS of Patient Record in Registry File
 ;
 ; CS            HL7 component separator
 ;
ADREASON(RORIENS,CS) ;
 N CODE,ICD9,LAB,NAME,NODE,IEN,RORMSG,TMP
 S (CODE,ICD9,LAB)=0
 S NODE=$$ROOT^DILFD(798.01,","_RORIENS,1)
 Q:NODE="" ""
 ;--- Check the names of selection rules
 S IEN=0
 F  S IEN=$O(@NODE@("B",IEN))  Q:IEN'>0  D
 . S NAME=$$GET1^DIQ(798.2,IEN_",",.01,,,"RORMSG")
 . I $G(DIERR)  D  Q
 . . D DBS^RORERR("RORMSG",-9,,,798.2,IEN_",")
 . Q:$E(NAME,1,2)'="VA"
 . I NAME?1.E1" LAB"             S LAB=1   Q
 . I NAME?1.E1" PROBLEM"         S ICD9=1  Q
 . I NAME?1.E1" PTF".1" HIST"    S ICD9=1  Q
 . I NAME?1.E1" VISIT".1" HIST"  S ICD9=1  Q
 . I NAME?1.E1" VPOV"            S ICD9=1  Q
 ;--- Check if the patient has been added automatically
 S NAME="Automatically Added - "
 I ICD9  S CODE=7,NAME=NAME_"ICD9"
 I LAB  S CODE=8  D:ICD9  S NAME=NAME_"Lab"
 . S CODE=9,NAME=NAME_" and "
 ;---
 Q $S(CODE:CODE_CS_$$ESCAPE^RORHL7(NAME)_CS_"99VA799_1",1:"")
 ;
 ;***** RETURNS THE HL7 VALUE FOR THE DIVISION FIELD
 ;
 ; IEN44         IEN in the HOSPITAL LOCATION file (#44)
 ;
 ; [CS]          Component separator ("^", by default))
 ;
 ; Return Values:
 ;       ""  Error
 ;     '=""  Value of the HL7 field
 ;
DIV44(IEN44,CS) ;
 N DIV,IENS4,NAME,RORBUF,RORMSG,STN,TMP
 S:$G(CS)="" CS="^"
 S DIV=$$SITE^RORUTL03(CS)
 Q:IEN44'>0 DIV
 ;--- Get the pointer to the INSTITUTION file
 S IENS4=+$$GET1^DIQ(44,IEN44_",",3,"I",,"RORMSG")_","
 I $G(DIERR)  D  Q DIV
 . D DBS^RORERR("RORMSG",-9,,,44,IEN44_",")
 Q:IENS4'>0 DIV
 ;--- Load the station name and number
 D GETS^DIQ(4,IENS4,".01;99",,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q DIV
 . D DBS^RORERR("RORMSG",-9,,,4,IENS4)
 S STN=$E($G(ROROUT(4,IENS4,99)),1,3)
 Q:STN="" DIV
 ;--- Construct the HL7 value
 S NAME=$$ESCAPE^RORHL7($G(RORBUF(4,IENS4,.01)))
 Q STN_CS_NAME_CS_"99VA4"
 ;
 ;***** STORES THE MULTILINE TEXT IN THE OBX SEGMENT
 ;
 ; NODE          Closed root of the text
 ; OBX3          Segment identifier
 ;
SETOBXWP(NODE,OBX3) ;
 N BR,CNT,I,I1,RORSEG,TMP
 S BR=$E(HLECH,3)_".br"_$E(HLECH,3)
 Q:$D(@NODE)<10
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 - Observation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 - Observation Value
 S I=$O(@NODE@(0)),CNT=0
 F  Q:I'>0  S I1=$O(@NODE@(I))  D  S I=I1
 . S TMP=$$ESCAPE^RORHL7(@NODE@(I))
 . S CNT=CNT+1,RORSEG(5,CNT)=$S(I1>0:TMP_BR,1:TMP)
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;--- Store the segment
 D:$D(RORSEG(5)) ADDSEG^RORHL7(.RORSEG)
 Q

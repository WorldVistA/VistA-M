RORHLUT1 ;HCIOFO/SG - HL7 UTILITIES (HIGH LEVEL) ;8/24/05 1:55pm
 ;;1.5;CLINICAL CASE REGISTRIES;**19**;Feb 17, 2006;Build 43
 ;
 ; This routine uses the following IAs:
 ; #5747     $$CSI^ICDEX (controlled)
 ; #5747     $$SNAM^ICDEX (controlled)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ; --- ROUTINE MODIFICATION LOG ---
 ; 
 ;PKG/PATCH   DATE       DEVELOPER   MODIFICATION
 ;----------- ---------- ----------- ----------------------------------------
 ;ROR*1.5*19  MAY 2012   K GUPTA     Support for ICD-10 Coding System.
 ;
 ;******************************************************************************
 ;******************************************************************************
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
 N CODE,ICD,LAB,NAME,NODE,IEN,RORMSG,TMP,RORCODSYS,RORRULEIEN
 S (CODE,ICD,LAB)=0
 S NODE=$$ROOT^DILFD(798.01,","_RORIENS,1)
 Q:NODE="" ""
 ;--- Check the names of selection rules
 S IEN=0
 F  S IEN=$O(@NODE@("B",IEN))  Q:IEN'>0  D
 . S NAME=$$GET1^DIQ(798.2,IEN_",",.01,,,"RORMSG")
 . I $G(DIERR)  D  Q
 . . D DBS^RORERR("RORMSG",-9,,,798.2,IEN_",")
 . Q:$E(NAME,1,2)'="VA"
 . I NAME?1.E1" LAB"                       S LAB=1  Q
 . I NAME?1.E1" PROBLEM".1" (ICD10)"       S ICD=1,RORRULEIEN=IEN  Q
 . I NAME?1.E1" PTF".1" HIST".1" (ICD10)"  S ICD=1,RORRULEIEN=IEN  Q
 . I NAME?1.E1" VISIT".1" HIST"            S ICD=1,RORRULEIEN=IEN  Q
 . I NAME?1.E1" VPOV".1" (ICD10)"          S ICD=1,RORRULEIEN=IEN  Q
 ;--- Check if the patient has been added automatically
 S NAME="Automatically Added - "
 I ICD D
 . S RORCODSYS=+$$GET1^DIQ(798.2,RORRULEIEN_",",7,"I")
 . S CODE=$S(RORCODSYS=30:10,1:7)
 . S NAME=NAME_$S(RORCODSYS=30:"ICD10",1:"ICD9")
 I LAB D
 . S CODE=8
 . I ICD D
 . . S CODE=$S(RORCODSYS=30:11,1:9)
 . . S NAME=NAME_" and "
 . S NAME=NAME_"Lab"
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
 ;
 ;***** RETURNS THE CODING SYSTEM NAME FOR A ICD OR PROCEDURE CODE
 ;
 ; RORFILE       FILE #80 or #80.1
 ; RORICDIEN     IEN of the #80 or #80.1
 ;
 ; Return Values:
 ;  "" if error Or not found
 ;  coding system name
 ;
CSNAME(RORFILE,RORICDIEN) ;
 Q:$G(RORICDIEN)="" ""
 N RORICDSNAM,RORICDSYS
 S RORICDSYS=$$CSI^ICDEX(RORFILE,RORICDIEN)
 S RORICDSNAM=$$SNAM^ICDEX(RORICDSYS)
 S:RORICDSNAM=-1 RORICDSNAM=""
 Q RORICDSNAM

VAFHLRO3 ;BP/JRP - OUTPATIENT HL7 ROLE SEGMENT UTILITIES;12/16/1997 ; 6/14/01 12:54pm
 ;;5.3;Registration;**160,215,389**;Aug 13, 1993
 ;
ROLE(PTR200,ARRAY,NULL,DATE) ;Build HL7 Role using info from Person Class
 ; file (#8932.1)
 ;
 ;Input  : PTR200 - Pointer to entry in New Person file (#200)
 ;         ARRAY - Array to store info in (full global reference)
 ;         NULL - HL7 null designation
 ;         DATE - (optional) "as of" date to obtain person role
 ;Output : ARRAY(comp#) = Value
 ;         ARRAY(comp#,sub#) = Value
 ;         Comp 1: Role ID
 ;         Comp 2: 3 Sub-components
 ;                 Sub 1: Profession
 ;                 Sub 2: Specialty
 ;                 Sub 3: Sub-specialty
 ;         Comp 3: VA8932.1 (literal)
 ;Notes  : Existance and validity of input is assumed
 ;       : Initializtion (i.e. KILLing) of ARRAY() must be done by the
 ;         calling program
 ;       : ARRAY() will not be set if role can not be calculated
 ;
 ;Declare variables
 N CLASSINF,STRING
 ;Set up role date
 S DATE=$G(DATE)\1 S:(DATE'?7N)!(DATE>DT) DATE=DT
 ;Get class info from Person Class file (#8932.1)
 S CLASSINF=$$GET^XUA4A72(PTR200,DATE)
 Q:(CLASSINF<0)
 ;Person Class Code (comp #1)
 S STRING=$P(CLASSINF,"^",7)
 Q:(STRING="") NULL
 S @ARRAY@(1)=STRING
 ;Build component #2
 ;Profession (comp #2 - sub #1)
 S STRING=$P(CLASSINF,"^",2)
 S:(STRING="") STRING=NULL
 S @ARRAY@(2,1)=STRING
 ;Specialty (comp #2 - sub #2)
 S STRING=$P(CLASSINF,"^",3)
 S:(STRING="") STRING=NULL
 S @ARRAY@(2,2)=STRING
 ;Sub-specialty (comp #2 - sub #3)
 S STRING=$P(CLASSINF,"^",4)
 S:(STRING="") STRING=NULL
 S @ARRAY@(2,3)=STRING
 ;Table identifier (comp #3)
 S @ARRAY@(3)="VA8932.1"
 ;Done
 Q
 ;
PERSON(PTR200,ARRAY,NULL) ;Build HL7 Role Person using info from New
 ; Person file (#200)
 ;
 ;Input  : PTR200 - Pointer to entry in New Person file (#200)
 ;         ARRAY - Array to store info in (full global reference)
 ;         NULL - HL7 null designation
 ;Output : ARRAY(1,comp#) = Value
 ;         ARRAY(1,comp#,sub#) = Value
 ;         Comp 1: 2 Sub-components
 ;                 Sub 1: DUZ
 ;                 Sub 2: Facility number
 ;         Comp 2 - 7: Name in HL7 format
 ;         Comp 8: VA200 (literal)
 ;         ARRAY(2,comp#) = Value
 ;         Comp 1: Provider SSN 
 ;         Comp 9: Social Security Administration (literal) 
 ;Notes  : Existance and validity of input is assumed
 ;       : Initializtion (i.e. KILLing) of ARRAY() must be done by the
 ;         calling program
 ;       : ARRAY() will not be set if role can not be calculated
 ;
 ;Declare variables
 N STRING,SUBSTR,TMP,DGNAME
 ;Build component #1
 ;DUZ (comp #1 - sub #1)
 S @ARRAY@(1,1,1)=PTR200
 ;Facility number (comp #1 - sub #2)
 S STRING=+$P($$SITE^VASITE(),"^",3)
 I ('STRING) K @ARRAY@(1,1,1) Q
 S @ARRAY@(1,1,2)=STRING
 ;Build components #2 - 7
 ;Get name from New Person file
 S TMP=$G(^VA(200,PTR200,0))
 S SUBSTR=$P(TMP,"^",1)
 ;Convert to HL7 format
 S DGNAME("FILE")=200,DGNAME("IENS")=PTR200,DGNAME("FIELD")=.01
 S STRING=$$HLNAME^XLFNAME(.DGNAME,"S","~")
 F TMP=1:1:6 D
 .S SUBSTR=$P(STRING,"~",TMP)
 .S:(SUBSTR="") SUBSTR=NULL
 .S @ARRAY@(1,TMP+1)=SUBSTR
 ;Table identifier (comp #8)
 S @ARRAY@(1,8)="VA200"
 ; repeat seq #4 (Patch DG*5.3*389)
 ; get SSN (comp #1)
 S STRING=$P($G(^VA(200,PTR200,1)),"^",9)
 S:(STRING'?9N) STRING=NULL
 S @ARRAY@(2,1)=STRING
 F TMP=1:1:7 S @ARRAY@(2,TMP+1)=NULL
 ; Assigning authority (comp #9) - Social Security Administration
 S @ARRAY@(2,9)="SSA"
 ;Done
 Q

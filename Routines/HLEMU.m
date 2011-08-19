HLEMU ;ALB/CJM  Utility Routines ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
STATNUM(IEN) ;
 ;Description:  Given an ien to the Institution file, returns as the function value the station number.  If IEN is NOT passed in, it assumes the local site.  Returns "" on failure.
 ;
 N STATION,RETURN
 S RETURN=""
 I $G(IEN) D
 .Q:'$D(^DIC(4,IEN,0))
 .S STATION=$P($$NNT^XUAF4(IEN),"^",2)
 .S RETURN=$S(+STATION:STATION,1:"")
 E  D
 .S RETURN=$P($$SITE^VASITE(),"^",3)
 Q RETURN
INSTIEN(STATION) ;
 ;Given the station number, this returns a pointer to the Institution file
 Q $$LKUP^XUAF4(STATION)
 ;
UPD(FILE,HLDA,DATA,ERROR) ;File data into an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   HLDA - New name for traditional DA array, with same meaning.
 ;            Pass by reference.
 ;   DATA - Data array to file (pass by reference)
 ;          Format: DATA(<field #>)=<value>
 ;
 ; Output:
 ;  Function Value -     0=error and 1=no error
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To update a record in subfile 2.0361 in record with ien=353,
 ;          subrecord ien=68, with the field .01 value = 21:
 ;    S DATA(.01)=21,HLDA=68,HLDA(1)=353 I $$UPD^HLEMU(2.0361,.HLDA,.DATA,.ERROR) W !,"DONE"
 ;
 N FDA,FIELD,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(HLDA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q 0
 S IENS=$$IENS^DILF(.HLDA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 D FILE^HLDIE(,"FDA","ERRORS(1)","UPD","HLEMU")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 I $S(+$G(DIERR):0,1:1) D CLEAN^DILF Q 1
 E  D CLEAN^DILF Q 0
 ;
GETFIELD(FILE,FIELD,HLDA,ERROR,EXT) ;Get field value from an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   HLDA - New name for traditional DA array, with same meaning.
 ;            Pass by reference.
 ;   FIELD - Field for which value is needed
 ;   EXT - (optional) If $G(EXT) then returns the external display form of the value
 ; Output:
 ;  Function Value -  field value in internal format,"" if an error was encountered
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 N FDA,IENS,ERRORS,VALUE
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(HLDA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q ""
 S IENS=$$IENS^DILF(.HLDA)
 S VALUE=$$GET1^DIQ(FILE,IENS,FIELD,$S($G(EXT):"",1:"I"),,"ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 I $S(+$G(DIERR):0,1:1) D CLEAN^DILF Q VALUE
 E  D CLEAN^DILF Q ""
 ;
DELETE(FILE,DA,ERROR) ;Delete an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional DA array, with same meaning.
 ;           ** Pass by reference**
 ;
 ; Output:
 ;  Function Value -     0=error and 1=no error
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To delete a record in subfile 2.0361 in record with ien=353,
 ;          subrecord ien=68:
 ;    S DA=68,DA(1)=353 I $$DELETE^HLEMU(2.0361,.DA,.ERROR) W !,"DONE"
 ;
 N DATA
 S DATA(.01)="@"
 Q $$UPD^HLEMU(FILE,.DA,.DATA,.ERROR)
 Q
 ;
ADD(FILE,HLDA,DATA,ERROR,IEN) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   HLDA - New name for traditional FileMan DA array with same
 ;            meaning. Pass by reference.  Only needed if adding to a
 ;            subfile.
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;   IEN - internal entry number to use (optional)
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;  HLDA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: Adding a record in subfile 2.0361 in the record with ien=353
 ;          with the field .01 value = 21:
 ;  S DATA(.01)=21,HLDA(1)=353 I $$ADD^HLEMU(2.0361,.HLDA,.DATA) W !,"DONE"
 ;
 ; Example: Creating a record NOT in a subfile:
 ;          S DATA(.01)=21 I $$ADD^HLEMU(867,,.DATA) W !,"DONE"
 ;
 N FDA,FIELD,IENA,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Numebr Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S HLDA="+1"
 S IENS=$$IENS^DILF(.HLDA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 .S IEN=""
 E  D
 .S IEN=IENA(1)
 .S ERROR=""
 D CLEAN^DILF
 S HLDA=IEN
 Q IEN
 ;
TESTVAL(FILE,FIELD,VALUE) ;
 ;Description: returns 1 if VALUE is a valid value for FIELD in FILE
 ;
 Q:(('$G(FILE))!('$G(FIELD))) 0
 ;
 N DISPLAY,VALID,RESULT
 S VALID=1
 ;
 ;if there is no external value then it is not valid
 S DISPLAY=$$EXTERNAL^DILFD(FILE,FIELD,"F",VALUE)
 I (DISPLAY="") S VALID=0
 ; 
 I VALID,$$GET1^DID(FILE,FIELD,"","TYPE")'["POINTER" D
 .D CHK^DIE(FILE,FIELD,,VALUE,.RESULT) I RESULT="^" S VALID=0 Q
 Q VALID
 ;
GETLINK(INSTIEN) ;
 ;Description:  Returns name of logical link for institition, given the institution ien.  Returns "" if a logical link name not found.
 ;
 Q:'$G(INSTIEN) ""
 ;
 N LINK,I,LINKNAME
 S LINKNAME=""
 D
 .D LINK^HLUTIL3(INSTIEN,.LINK)
 .S I=$O(LINK(0))
 .I I,$L(LINK(I)) S LINKNAME=LINK(I)
 Q LINKNAME
 ;
ASKYESNO(PROMPT,DEFAULT) ;
 ;Description: Displays PROMPT, appending '?'.  Expects a YES NO response.
 ;Input:
 ;   PROMPT - text to display as prompt.  Appends '?'
 ;   DEFAULT - (optional) YES or NO.  If not passed, defaults to YES
 ;Output:
 ;  Function value: 1 if yes, 0 if no, "" if '^' entered or timeout
 ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=PROMPT
 S DIR("B")=$S($G(DEFAULT)="NO":"NO",1:"YES")
 D ^DIR
 Q:$D(DIRUT) ""
 Q Y
 ;
MSGIEN(MSGID) ;
 ;Given the message id, returns the ien from file 773, or 0 on failure.
 Q:'$L($G(MSGID)) 0
 Q $O(^HLMA("C",MSGID,0))
 ;
LINK(MSGIEN) ;
 ;Given the message ien from file 773, returns the HL Logical Link in the format <link ien>^<link name>
 Q:'$G(MSGIEN) ""
 N LINKIEN
 S LINKIEN=$P($G(^HLMA(MSGIEN,0)),"^",7)
 Q:'LINKIEN 0
 Q LINKIEN_"^"_$P(^HLCS(870,LINKIEN,0),"^")
 ;
HL7EVENT(MSGIEN) ;
 ;Given the message ien from file 773, returns the 3 character HL7 event type
 Q:'$G(MSGIEN) ""
 N EVENT
 S EVENT=$P($G(^HLMA(MSGIEN,0)),"^",14)
 Q:'EVENT ""
 Q $P(^HL(779.001,EVENT,0),"^")
 ;
MSGTYPE(MSGIEN) ;
 ;Given the message ien from file 773, returns the 3 character HL7 message type
 Q:'$G(MSGIEN) ""
 N MSG
 S MSG=$P($G(^HLMA(MSGIEN,0)),"^",13)
 Q:'MSG ""
 Q $P(^HL(771.2,MSG,0),"^")
 ;
APP(MSGIEN) ;
 ;Given the message ien from file 773, returns the name of the sending application from file 771
 ;
 Q:'$G(MSGIEN)
 N APPIEN
 S APPIEN=$P($G(^HLMA(MSGIEN,0)),"^",11)
 Q $$APPNAME(APPIEN)
 ;
APPNAME(APPIEN) ;
 ;Given an ien to the HL7 Application Parameter file (#771), it returns the NAME (field .01)
 Q $S('APPIEN:"",1:$P($G(^HL(771,APPIEN,0)),"^"))
 ;
PROMPT(FILE,FIELD,DEFAULT,RESPONSE,REQUIRE) ;
 ;Description: requests user to enter a single field value.
 ;Input:
 ;  FILE - the file #
 ;  FIELD - the field #
 ;  DEFAULT - default value, internal form
 ;  REQUIRE - a flag, (+value)'=0 means to require a value to be
 ;            entered and to return failure otherwise (optional)
 ;Output:
 ;  Function Value - 0 on failure, 1 on success
 ;  RESPONSE - value entered by user, pass by reference
 ;
 Q:(('$G(FILE))!('$G(FIELD))) 0
 S REQUIRE=$G(REQUIRE)
 N DIR,DA,QUIT,AGAIN
 ;
 S DIR(0)=FILE_","_FIELD_$S($G(REQUIRE):"",1:"O")_"AO"
 S:$G(DEFAULT)'="" DIR("A")=$$GET1^DID(FILE,FIELD,"","LABEL")_": "_$$EXTERNAL^DILFD(FILE,FIELD,"F",DEFAULT)_"// "
 S QUIT=0
 F  D  Q:QUIT
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 . I X="@" D  Q:AGAIN
 . . S AGAIN=0
 . . I 'REQUIRE,"Yy"'[$E($$ASKYESNO("  Are you sure")_"X") S AGAIN=1 Q
 . . S RESPONSE="" ; This might trigger the "required" message below.
 . E  I X="" S RESPONSE=$G(DEFAULT)
 . E  S RESPONSE=$P(Y,"^")
 . ;
 . ; quit this loop if the user entered value OR value not required
 . I RESPONSE'="" S QUIT=1 Q
 . I 'REQUIRE S QUIT=1 Q
 . W !,"This is a required response. Enter '^' to exit"
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q 1
I(VAR,N) ;This funtion increments the local or global variable by the amount N
 ;Input:
 ;  VAR - a string representing the name of a local or global variable to be referenced by indirection
 ;  N - a number to increment @VAR by.  If not passed it is set to 1
 ;OUTPUT
 ;    @VAR is incremented by the amount N and also returned as the function value
 ;
 N X
 I VAR["^" L +VAR:1
 I '$G(N) S N=1
 S X=$G(@VAR)+N
 S @VAR=X
 I VAR["^" L -VAR
 Q X
 ;
INC(VAR,N) ;This funtion increments the local variable by the amount N
 ;Input:
 ;  VAR - a local or global variable passed by reference
 ;  N - a number to increment VAR by.  If not passed or =0 it is set to 1
 ;OUTPUT
 ;    VAR is incremented by the amount N and also returned as the function value
 ;
 I '$G(N) S N=1
 S VAR=$G(VAR)+N
 Q VAR

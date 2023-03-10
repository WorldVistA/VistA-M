DGENDBS ;ALB/RMO/CJM,JAM - Database Server Utilities; [ 03/23/95  11:08 AM ]
 ;;5.3;Registration;**122,147,182,1040**;08/13/93;Build 15
 ;
UPD(FILE,DGENDA,DATA,ERROR) ;File data into an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DGENDA - New name for traditional DA array, with same meaning.
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
 ;    S DATA(.01)=21,DGENDA=68,DGENDA(1)=353 I $$UPD^DGENDBS(2.0361,.DGENDA,.DATA,.ERROR) W !,"DONE"
 ;
 ; DG*5,3*1040;jam; Add New of DTOUT to protect it from FILE^DIE which will kill this variable. 
 N FDA,FIELD,IENS,ERRORS,DTOUT
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(DGENDA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q 0
 S IENS=$$IENS^DILF(.DGENDA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 D FILE^DIE("K","FDA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 I $S(+$G(DIERR):0,1:1) D CLEAN^DILF Q 1
 E  D CLEAN^DILF Q 0
 ;
ADD(FILE,DGENDA,DATA,ERROR,IEN) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DGENDA - New name for traditional FileMan DA array with same
 ;            meaning. Pass by reference.  Only needed if adding to a
 ;            subfile.
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;   IEN - internal entry number to use (optional)
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;  DGENDA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To add a record in subfile 2.0361 in the record with ien=353
 ;          with the field .01 value = 21:
 ;  S DATA(.01)=21,DGENDA(1)=353 I $$ADD^DGENDBS(2.0361,.DGENDA,.DATA) W !,"DONE"
 ;
 ; Example: If creating a record not in a subfile, would look like this:
 ;          S DATA(.01)=21 I $$ADD^DGENDBS(867,,.DATA) W !,"DONE"
 ;
 N FDA,FIELD,IENA,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Numebr Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S DGENDA="+1"
 S IENS=$$IENS^DILF(.DGENDA)
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
 S DGENDA=IEN
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

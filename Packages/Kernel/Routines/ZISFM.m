ZISFM ;IRMFO-ALB/CJM - DEVICE HANDLER ;10/25/2011
 ;;8.0;KERNEL;**585**;JUL 10, 9;Build 22
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
UPD(FILE,DA,DATA,ERROR) ;File data into an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional DA array, with same meaning.
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
 ;    S DATA(.01)=21,DA=68,DA(1)=353 I $$UPD(2.0361,.DA,.DATA,.ERROR) W !,"DONE"
 ;
 N FDA,FIELD,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(DA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q 0
 S IENS=$$IENS^DILF(.DA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 D FILE^DIE("","FDA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 D CLEAN^DILF
 Q $S(+$G(DIERR):0,1:1)
 ;
ADD(FILE,DA,DATA,ERROR,IEN) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional FileMan DA array with same
 ;            meaning. Pass by reference.  Only needed if adding to a
 ;            subfile.
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;   IEN - internal entry number to use (optional)
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;  DA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To add a record in subfile 2.0361 in the record with ien=353
 ;          with the field .01 value = 21:
 ;  S DATA(.01)=21,DA(1)=353 I $$ADD(2.0361,.DA,.DATA) W !,"DONE"
 ;
 ; Example: If creating a record not in a subfile, would look like this:
 ;          S DATA(.01)=21 I $$ADD(867,,.DATA) W !,"DONE"
 ;
 N FDA,FIELD,IENA,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Number Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S DA="+1"
 S IENS=$$IENS^DILF(.DA)
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
 S DA=IEN
 Q IEN
 ;
DELETE(FILE,DA,ERROR)   ;Delete an existing record.
 N DATA
 S DATA(.01)="@"
 Q $$UPD(FILE,.DA,.DATA,.ERROR)
 Q
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;

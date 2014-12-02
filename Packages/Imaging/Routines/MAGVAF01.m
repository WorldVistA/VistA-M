MAGVAF01 ;WOIFO/NST/DAC - Utilities for RPC calls ; 28 Feb 2013 9:58 AM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
IDF2FM(IDFDT) ; converts date time in format YYYYMMDD.HHMMSS to FileMan format CYYMMDD.HHMMSS
 I IDFDT="" Q ""
 N MAGTIME
 S MAGTIME=$P(IDFDT,".",2)
 Q (IDFDT\1-17000000)_"."_MAGTIME
 ;
FM2IDF(FMDT) ; converts date time in FileMan format CYYMMDD.HHMMSS to YYYYMMDD.HHMMSS
 I FMDT="" Q ""
 N MAGTIME
 S MAGTIME=$P(FMDT,".",2)
 Q (FMDT\1+17000000)_"."_MAGTIME
 ;
 ;
 ; Input parameters
 ; ================
 ;   FILE = FileMan file number (e.g. 2006.917)
GETFILNM(FILE) ; Returns file name
 Q $$GET1^DID(FILE,"","","NAME")
 ;
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
GETFILGL(FILE) ; Get Global root of the file
 Q $$ROOT^DILFD(FILE)
 ; 
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
 ;  FNAME - Field name
GETFLDID(FILE,FNAME) ; Returns a field number
 Q $$FLDNUM^DILFD(FILE,FNAME)
 ;
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
 ;  FLDID - Field Number
GETFLDNM(FILE,FLDID) ; Returns a field name
 Q $$GET1^DID(FILE,FLDID,"","LABEL")
 ;
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
 ;  FLDID - Field Number
ISFLDDT(FILE,FLDID) ; Returns true(1) or false(0) if a field is from DATE/TIME type 
 Q $$GET1^DID(FILE,FLDID,"","TYPE")="DATE/TIME"
 ;
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
 ;  FLDID - Field Number
 ;  
 ;  Return Values
 ;  =============
 ; TYPEDEF = Type of Word-Processing field
ISFLDWP(TYPEDEF,FILE,FLDID) ; Returns true(1) or false(0) if a field is from Word-Processing type 
 N WPFILE
 S TYPEDEF=""
 Q:$$GET1^DID(FILE,FLDID,"","TYPE")'="WORD-PROCESSING" 0
 S WPFILE=$$GET1^DID(FILE,FLDID,"","SPECIFIER")
 S TYPEDEF=$$GET1^DID(WPFILE,.01,"","SPECIFIER")
 Q 1
 ;
 ;
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
 ;  FLDID - Field Number
 ;  
 ;  Return Values
 ;  =============
 ; TYPEDEF = Type of field
ISFLDSUB(TYPEDEF,FILE,FLDID) ; Returns true(1) or false(0) if a field is from Word-Processing type or Multiple
 N FILESUB
 S TYPEDEF=""
 Q:'$$GET1^DID(FILE,FLDID,"","MULTIPLE-VALUED") 0
 S FILESUB=$$GET1^DID(FILE,FLDID,"","SPECIFIER")
 S TYPEDEF=$$GET1^DID(FILESUB,.01,"","SPECIFIER")
 Q 1
 ;
GETFLDS(MAGRY,MAGRYW,FILE,FLAGS) ; Returns array with all fields in a file
 ; 
 ; Input Parameters
 ; ================
 ; FILE = FileMan file number
 ; FLAGS = I - add I(internal) to the field numbers in Result e.g .01I;2I;3I
 ; 
 ; Return Values
 ; =============
 ; 
 ; Result=n1;n2;n3 (e.g. .01;2;3) - no multiple or word-processing fields
 ; 
 ; MAGRY(n)=nth field name
 ; MAGRY(n,"TYPE")=type of the field (e.g. RP2006.916, 2006.9183, RD, RN, etc.)
 ; 
 ; MAGRYW(n)=nth Word-Processing field name
 ; MAGRY(n,"TYPE")=type of the field (e.g. RP2006.916, 2006.9183, RD, RN, etc.)
 ;
 N I,FLDID,FLDS,DEL
 N WPTYPE,IVAL
 K MAGRY,MAGRYW
 S IVAL=$S($G(FLAGS)["I":"I",1:"")
 S I=""
 S FLDS=""
 F  S I=$O(^DD(FILE,"B",I)) Q:I=""  D       ; IA #5551
 . S FLDID=$O(^DD(FILE,"B",I,""))
 . I $$ISFLDSUB^MAGVAF01(.WPTYPE,FILE,FLDID) D
 . . S MAGRYW(FLDID)=I
 . . S MAGRYW(FLDID,"TYPE")=WPTYPE
 . . Q
 . E  D
 . . S MAGRY(FLDID)=I
 . . S MAGRY(FLDID,"TYPE")=$$GET1^DID(FILE,FLDID,"","SPECIFIER")
 . . Q
 . Q
 S I="",DEL=""
 F  S I=$O(MAGRY(I)) Q:I=""  D
 . ; Skip multiple and word-processing fields GETS^DIQ cannot handle Word-Processing field
 . I $$ISFLDSUB^MAGVAF01(.WPTYPE,FILE,I) Q
 . S FLDS=FLDS_DEL_I_IVAL
 . S DEL=";"
 . Q
 Q FLDS
 ;
GETSUBFL(FILE,FIELD) ; Returns sub-file of a multiple field
 Q $$GET1^DID(FILE,FIELD,"","SPECIFIER")
 ;
VALIDFLD(FILE,FIELD,VALUE,MESSAGE) ; call to validate value for field in a FM file.
 ; Function is boolean.  Returns:
 ;        0   -  Invalid 
 ;        1   -  Valid 
 ; FILE  : File Number
 ; FIELD  : Field Number
 ; VALUE  : (sent by reference) data value of field
 ; MESSAGE (sent by reference) Result message
 ; 
 N MAGR,MAGMSG,MAGSP,MAGRESA,MAGPT
 ; Get the Field number
 I +FIELD'=FIELD S FIELD=$$GETFLDID^MAGVAF01(FILE,FIELD)
 ;if a BAD field number
 I '$$VFIELD^DILFD(FILE,FIELD) D  Q 0
 . S MESSAGE="The field number: "_FIELD_", in File: "_FILE_", is invalid."
 D FIELD^DID(FILE,FIELD,"","SPECIFIER","MAGSP")
 ; If it is a pointer field 
 ; If an  integer - We assume it is a pointer and validate that and Quit.
 ; If not integer - We assume it is external value, proceed to let CHK do validate
 I (MAGSP("SPECIFIER")["P"),(+VALUE=VALUE) D  Q MAGPT
 . I $$EXTERNAL^DILFD(FILE,FIELD,"",VALUE)'="" S MAGPT=1 Q
 . S MAGPT=0,MESSAGE="The value: "_VALUE_" for field: "_FIELD_" in File: "_FILE_" is an invalid Pointer."
 . Q
 ;
 D CHK^DIE(FILE,FIELD,"",VALUE,.MAGR,"MAGMSG")
 ; If success, Quit. We changed External to Internal. Internal is in MAGR
 I MAGR'="^" Q 1
 ;  If not success Get the error text and Quit 0
 D MSG^DIALOG("A",.MAGRESA,245,5,"MAGMSG")
 S MESSAGE=MAGRESA(1)
 Q 0
 ;
 ;+++++ Check if all required  fields are sent
 ; 
 ; 
 ; Input parameters
 ; ================
 ; 
 ;  FILE    = file number
 ;  FLDSVAL = array with fields values. Index of the array is fields names
 ;  FLDSARR = array with fields definition. Index is field's numbers
 ;  FLGWP   = this is Word-processing fields
 ;  
 ;  Result Values
 ;  =============
 ;  
 ; if failure MAGRY = Failure status ^ Error message
 ; if success MAGRY = Success status 
 ;  
REQFLDS(MAGRY,FILE,FLDSVAL,FLDSARR,FLGWP) ; 
 N FLDNAME,MSG,ERR
 N TFLDSARR
 N WP
 M TFLDSARR=FLDSARR
 S FLDNAME=""
 S ERR=0
 F  S FLDNAME=$O(FLDSVAL(FLDNAME)) Q:FLDNAME=""  D  Q:ERR
 . I 'FLGWP Q:FLDSVAL(FLDNAME)=""  ; value is empty, so get next one
 . I FLGWP M WP=FLDSVAL(FLDNAME) Q:$$WPEMPTY^MAGVAF01(.WP)  ; quit if WP field is blank
 . S FIELD=$$GETFLDID^MAGVAF01(FILE,FLDNAME)
 . I FIELD="" D  Q
 . . S MSG="Field """_FLDNAME_""" is not found in file #"_FILE
 . . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_MSG
 . . S ERR=1
 . . Q
 . K TFLDSARR(FIELD)  ; delete the field from the list; will use it in the check for check required fields
 . Q
 I ERR Q
 ; Check if we set all required fields
 S FIELD=""
 F  S FIELD=$O(TFLDSARR(FIELD)) Q:FIELD=""  D  Q:ERR
 . I TFLDSARR(FIELD,"TYPE")["R" D  Q
 . . S MSG="Field """_TFLDSARR(FIELD)_""" is required in file #"_FILE
 . . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_MSG
 . . S ERR=1
 . . Q
 . Q
 Q:ERR
 ;
 S MAGRY=$$OK^MAGVAF02()
 Q
 ;
 ; Return WP field value as a string
 ; WP = Word-Processing field values
 ; e.g. WP(1)=Line 1
 ;      WP(2)=Line 2
 ;      
STRWP(WP) ; Return WP field value as a string
 N I,RESULT
 S I=""
 S RESULT=""
 F  S I=$O(WP(I)) Q:I=""  D 
 . S RESULT=RESULT_WP(I)
 . Q
 Q RESULT
 ;
 ; WP field value is blank
 ; Return 1 - WP field value is blank
 ;        0
 ; WP = Word-Processing field values
 ; e.g. WP(1)=Line 1
 ;      WP(2)=Line 2
 ;      
WPEMPTY(WP) ; Return 1 when WP field value is blank
 N I,RESULT
 S I=""
 S RESULT=1
 F  S I=$O(WP(I)) Q:I=""!'RESULT  D 
 . S RESULT=$L(WP(I))=0
 . Q
 Q RESULT
 ;
 ; Add a new record 
 ; 
 ; Input parameters
 ; ================
 ; 
 ; FILE - file number
 ; FLDSVAL - array with index field name and value
 ; FLDSVALW - array with first index WP field name and the second values 
 ;  e.g FLDSVALW("URL",1)="Line1
 ;      FLDSVALW("URL",2)="Line 2"
 ; 
 ; Result values
 ; ===============
 ; if failed MAGRY = Failure status ^ Error message
 ; if success MAGRY = Success status ^  ^ IEN
 ; 
 ; 
ADDRCD(MAGRY,FILE,FLDSVAL,FLDSVALW) ; Add a new record to a file
 N IENS,FLDNAME,FIELD,WPFLD
 N MAGDA,MAGNFDA,MAGNIEN,MAGNXE
 N MESSAGE,ERR
 N X,FLDSARR,FLDSARRW
 ;
 S X=$$GETFLDS^MAGVAF01(.FLDSARR,.FLDSARRW,FILE,"")  ; Get all fields
 ; Check if we set all required fields
 D REQFLDS^MAGVAF01(.MAGRY,FILE,.FLDSVAL,.FLDSARR,0) ; 
 I '$$ISOK^MAGVAF02(MAGRY) Q
 ;
 ; Check for WP required fields
 D REQFLDS^MAGVAF01(.MAGRY,FILE,.FLDSVALW,.FLDSARRW,1) ; 
 I '$$ISOK^MAGVAF02(MAGRY) Q
 ;
 ; Set FDA array and check for valid values
 S IENS="+1,"
 S FLDNAME=""
 S ERR=0
 F  S FLDNAME=$O(FLDSVAL(FLDNAME)) Q:FLDNAME=""  D  Q:ERR
 . Q:FLDSVAL(FLDNAME)=""
 . S FIELD=$$GETFLDID^MAGVAF01(FILE,FLDNAME)
 . K FLDSARR(FIELD)  ; delete the field from the list; will use it in the check for check required fields
 . S MAGNFDA(FILE,IENS,FIELD)=FLDSVAL(FLDNAME)
 . S ERR='$$VALIDFLD^MAGVAF01(FILE,FIELD,FLDSVAL(FLDNAME),.MESSAGE)
 . Q
 I ERR S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_MESSAGE Q
 ;    
 ; Add the regular field first
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error adding a new record" Q
 S MAGDA=MAGNIEN(1)  ; IEN of the new record
 ;
 ; Now store the Word-Processing fields
 S IENS=MAGDA_","
 S FLDNAME=""
 F  S FLDNAME=$O(FLDSVALW(FLDNAME)) Q:FLDNAME=""  D  Q:ERR
 . K MAGNXE
 . S WPFLD=$$GETFLDID^MAGVAF01(FILE,FLDNAME) ; FileMan number of WP field
 . D WP^DIE(FILE,IENS,WPFLD,"A","FLDSVALW(FLDNAME)","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) D  Q  ; clean up newly created record
 . . S ERR=1
 . . N DA,DIK
 . . S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error adding new """_FLDNAME_""" data."
 . . ; clean up data
 . . S DIK=$$GETFILGL^MAGVAF01(FILE)
 . . S DA=MAGDA
 . . D ^DIK
 . . Q
 . Q
 Q:ERR  ; MAGRY is already set
 ;
 S MAGRY=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_MAGDA
 Q
 ;
 ; Update a record 
 ; 
 ; Input parameters
 ; ================
 ; 
 ; FILE - file number
 ; FLDSVAL - FDA array
 ; 
 ; Output parameter
 ; ===============
 ; MAGRY
 ;
 ; if failed MAGRY = Failure status ^ Error message
 ; if success MAGRY = Success status 
 ; 
UPDRCD(MAGRY,FILE,FLDSVAL) ; Update a record to a file
 N IENS,FLDNAME,FIELD
 N MAGNFDA,MAGNIEN,MAGNXE
 N MESSAGE,ERR
 I '$G(FLDSVAL("PK")) S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Missing Primary Key (IEN)" Q
 S IENS=FLDSVAL("PK")_","
 S FLDNAME=""
 S ERR=0
 F  S FLDNAME=$O(FLDSVAL(FLDNAME)) Q:FLDNAME=""  D  Q:ERR
 . Q:FLDNAME="PK"   ; skip primary key record (IEN)
 . S FIELD=$$GETFLDID^MAGVAF01(FILE,FLDNAME)
 . S MAGNFDA(FILE,IENS,FIELD)=FLDSVAL(FLDNAME)
 . S ERR='$$VALIDFLD^MAGVAF01(FILE,FIELD,FLDSVAL(FLDNAME),.MESSAGE)
 . Q
 I ERR S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_MESSAGE Q
 ;
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error updating a record in file #"_FILE
 E  S MAGRY=$$OK^MAGVAF02()
 Q

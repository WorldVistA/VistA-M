MAGUTL04 ;WOIFO/SG - FIELD AUDIT UTILITIES ; 3/9/09 12:53pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;##### RETRIEVES VALUE OF THE SINGLE FIELD
 ;
 ; FILE          File number
 ;
 ; IENS          Standard IENS indicating internal entry numbers
 ;
 ; FIELD         Field number. Neither field names nor extended
 ;               pointer relational syntax (i.e. POINTER:FIELD)
 ;               are supported.
 ;
 ; [FLAGS]       Flags to control processing (can be combined):
 ;
 ;                 I  Return the internal value (by default,
 ;                    external value is returned).
 ;
 ;                 Z  Zero node included for word processing fields
 ;                    on target array.
 ;
 ; [MAG8BUF]     The root of an array into which word processing
 ;               text is copied.
 ;
 ; [MAG8MSG]     Closed root into which the error messages are put.
 ;               If this parameter is not passed, the messages are
 ;               put into nodes descendent from ^TMP.
 ;
 ; [ADT]         Date/time (internal FileMan value) for retrieving
 ;               the previous value. By default ($G(ADT)'>0), audit
 ;               checks are not performed and the current value is
 ;               returned.
 ;
 ; Return Values
 ; =============
 ;             - Field value (internal or external, depending
 ;               on the flags)
 ;
 ;             - If data exists for a word processing field, then
 ;               this function returns the resolved TARGET_ROOT.
 ;               Otherwise, null is returned.
 ; 
 ; Notes
 ; =====
 ;
 ; See the FileMan Programmer Manual for more details.
 ;
GET1(FILE,IENS,FIELD,FLAGS,MAG8BUF,MAG8MSG,ADT) ;
 N VAL
 ;--- Get the current value
 S VAL=$$GET1^DIQ(FILE,IENS,FIELD,$G(FLAGS),$G(MAG8BUF),$G(MAG8MSG))
 I $G(ADT)>0  D:'$G(DIERR)
 . N MAG8AUDIT,MAGMSG,NODE,OLDVAL,SUBFILE,TMP
 . D INIT(.MAG8AUDIT)
 . ;--- Check if the file is audited
 . S SUBFILE=+$G(MAG8AUDIT(FILE))  Q:SUBFILE'>0
 . ;--- Check for the previous value
 . S NODE=$$ROOT^DILFD(SUBFILE,","_IENS,1)
 . Q:'$$GETPFV(.OLDVAL,NODE,FIELD,ADT)
 . ;--- Return the old value in requested format
 . S VAL=$S($G(FLAGS)["I":OLDVAL,1:OLDVAL("E"))
 . Q
 ;---
 Q VAL
 ;
 ;+++++ GETS THE PREVIOUS FIELD VALUE (FROM THE AUDIT MULTIPLE)
 ;
 ; .VAL(         Reference to a local variable where the internal
 ;               value is returned. 
 ;
 ;   "E")        External value
 ;
 ; NODE          Closed root of the audit multiple that stores
 ;               previous values of the fields of this record.
 ;
 ; FIELD         Field number
 ;
 ; ADT           Date/time for the previous value
 ;
 ; Return Values
 ; =============
 ;            0  No previous value (the VAL parameter is unchanged)
 ;            1  The previous value is returned in the VAL parameter
 ; 
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from outside
 ; of this routine.
 ;
GETPFV(VAL,NODE,FIELD,ADT) ;
 N UIEN,UTS
 S UTS=$O(@NODE@("FD",FIELD,+ADT))  Q:UTS="" 0
 S UIEN=$O(@NODE@("FD",FIELD,UTS,""))  Q:UIEN="" 0
 Q:'$D(@NODE@(UIEN)) 0
 S VAL=$G(@NODE@(UIEN,1)),VAL("E")=$G(@NODE@(UIEN,2))
 ;--- If there is no external value, then it is the same as the
 ;--- internal one (see the AUDIT^MAGUXRF for more details)
 S:VAL("E")="" VAL("E")=VAL
 Q 1
 ;
 ;##### RETRIEVES VALUES OF ONE OR MORE FIELDS
 ;
 ; FILE          File number
 ;
 ; IENS          Standard IENS indicating internal entry numbers
 ;
 ; FLDLST        Field number(s). Can be one of the following:
 ;                 -  A single field number
 ;                 -  A list of field numbers, separated by semicolons
 ;                 -  A range of field numbers, in the form M:N, where
 ;                    M and N are the end points of the inclusive
 ;                    range. All field numbers within this range are
 ;                    retrieved.
 ;                 -  * for all fields at the top level
 ;                    (no sub-multiple record).
 ;                 -  ** for all fields including all fields and data 
 ;                    in sub-multiple fields.
 ;                 -  Field number of a multiple followed by an *
 ;                    to indicate all fields and records in the
 ;                    sub-multiple for that field.
 ;
 ; [FLAGS]       Flags to control processing (can be combined):
 ;
 ;                 E  Returns external values in nodes ending
 ;                    with "E".
 ;
 ;                 I  Returns internal values in nodes ending with
 ;                    "I". By default, external are returned.
 ;
 ;                 Z  Word processing fields include zero nodes.
 ;
 ; [MAG8BUF]     The closed root of the output array.
 ;
 ; [MAG8MSG]     Closed root into which the error messages are put.
 ;               If this parameter is not passed, the messages are
 ;               put into nodes descendent from ^TMP.
 ;
 ; [ADT]         Date/time (internal FileMan value) for retrieving
 ;               previous values of the fields. By default
 ;               ($G(ADT)'>0), audit checks are not performed and
 ;               the current values are returned.
 ; 
 ; Notes
 ; =====
 ;
 ; See the FileMan Programmer Manual for more details.
 ;
GETS(FILE,IENS,FLDLST,FLAGS,MAG8BUF,MAG8MSG,ADT) ;
 ;--- Flags N and R are not supported since the code needs
 ;--- numbers of all requested fields in the output array
 S FLAGS=$TR($G(FLAGS),"NR")
 ;--- Get current values
 D GETS^DIQ(FILE,IENS,FLDLST,$G(FLAGS),MAG8BUF,$G(MAG8MSG))
 I $G(ADT)>0  D:'$G(DIERR)
 . N FLD,MAG8AUDIT,MAGMSG,NODE,SUBFILE,TMP
 . D INIT(.MAG8AUDIT)
 . ;--- Check if the file is audited
 . S SUBFILE=+$G(MAG8AUDIT(FILE))  Q:SUBFILE'>0
 . ;--- Check for previous values
 . S FLAGS=$G(FLAGS)
 . S NODE=$$ROOT^DILFD(SUBFILE,","_IENS,1)
 . S FLD=""
 . F  S FLD=$O(@MAG8BUF@(FILE,IENS,FLD))  Q:FLD=""  D
 . . Q:'$$GETPFV(.OLDVAL,NODE,FLD,ADT)
 . . I FLAGS'["E",FLAGS'["I"  D  Q
 . . . S @MAG8BUF@(FILE,IENS,FLD)=OLDVAL("E")
 . . S:FLAGS["E" @MAG8BUF@(FILE,IENS,FLD,"E")=OLDVAL("E")
 . . S:FLAGS["I" @MAG8BUF@(FILE,IENS,FLD,"I")=OLDVAL
 . . Q
 . Q
 ;---
 Q
 ;
 ;+++++ INITIALIZES AUDIT PARAMETERS
INIT(AUDIT) ;
 S AUDIT(2005)=2005.099
 S AUDIT(2005.1)=2005.199
 Q
 ;
 ;##### RETURNS THE LAST AUDIT RECORD FOR THE IMAGE RECORD FIELD
 ;
 ; MAGFILE       Image file number (2005 or 2005.1)
 ;
 ; IENS          Standard IENS indicating internal entry number
 ;
 ; FIELD         Field number
 ;
 ; Return Values
 ; =============
 ;           ""  Invalid parameter(s) or an error
 ;
 ;            0  Record creation info (field value has not changed)
 ;                 ^01: 0
 ;                 ^02: Value of the DATE/TIME IMAGE SAVED field (7)
 ;                 ^03: Value of the IMAGE SAVE BY field (8)
 ;                
 ;           >0  Last audit record for the field
 ;                 ^01: IEN of the audit record
 ;                 ^02: Date/time (FileMan)
 ;                 ^03: User IEN (DUZ)
 ;
LASTAUDT(MAGFILE,IENS,FIELD) ;
 Q:$G(IENS)'>0 ""
 N BUF,FDT,IEN,NODE
 S NODE=$NA(^MAG(MAGFILE,+IENS))
 ;
 ;--- Get the last audit record for the field
 D
 . S FDT=$O(@NODE@(99,"FD",FIELD,""),-1)      Q:FDT=""
 . S IEN=$O(@NODE@(99,"FD",FIELD,FDT,""),-1)  Q:IEN=""
 . S BUF=$G(@NODE@(99,IEN,0))
 . Q
 Q:$G(BUF)'="" IEN_U_$P(BUF,U)_U_$P(BUF,U,3)
 ;
 ;--- If the field has not been updated, return record creation info
 S BUF=$G(@NODE@(2))
 Q "0"_U_$P(BUF,U)_U_$P(BUF,U,2)

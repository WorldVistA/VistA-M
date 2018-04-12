MAGNU001 ;WOIFO/NST - Utilities for RPC calls ; 25 Apr 2017 4:16 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;
FM2IDF(FMDT) ; converts date time in FileMan format CYYMMDD.HHMMSS to YYYYMMDD.HHMMSS
 I FMDT="" Q ""
 N MAGTIME
 S MAGTIME=$P(FMDT,".",2)
 Q (FMDT\1+17000000)_"."_MAGTIME
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
 . I $$ISFLDSUB^MAGNU001(.WPTYPE,FILE,FLDID) D
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
 . I $$ISFLDSUB^MAGNU001(.WPTYPE,FILE,I) Q
 . S FLDS=FLDS_DEL_I_IVAL
 . S DEL=";"
 . Q
 Q FLDS
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
 S TYPEDEF=$$GET1^DID(+FILESUB,.01,"","SPECIFIER")
 Q 1
 ;
 ; Input parameters
 ; ================
 ;  FILE  - FileMan file
 ;  FLDID - Field Number
ISFLDDT(FILE,FLDID) ; Returns true(1) or false(0) if a field is from DATE/TIME type 
 Q $$GET1^DID(FILE,FLDID,"","TYPE")="DATE/TIME"
 ;
 ; Return WP field value as a string
 ; WP = Word-Processing field values
 ; e.g. WP(1)=Line 1
 ;      WP(2)=Line 2
 ;
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
GSUBFILE(FILE,FIELD) ; Returns sub-file of a multiple field
 Q +$$GET1^DID(FILE,FIELD,"","SPECIFIER")
 ;
GSUBROOT(FILE,FIELD,D0) ; Return open root of multiple field
 N ROOT,NODE
 S NODE=$$GET1^DID(FILE,FIELD,"","GLOBAL SUBSCRIPT LOCATION")
 S NODE=$P(NODE,";")
 S ROOT=$$GETFILGL(FILE)
 Q ROOT_D0_","_NODE_","

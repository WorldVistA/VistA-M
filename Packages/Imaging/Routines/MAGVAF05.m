MAGVAF05 ;WOIFO/NST - Utilities for RPC calls ; 14 Sep 2011 1:55 PM
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
 ; +++++ Return IEN of the record with .01 field equals VALUE
 ;       If record is not found a new record will be added if a add flag is set to true
 ; 
 ; Input parameters
 ; ================
 ;   FILE  = FileMan file number (e.g. 2006.9193)
 ;   VALUE = External or internal value of .01 field
 ;   ADD   = Add a new record if the VALUE is not found (e.g. 0/1)
GETIEN(FILE,VALUE,ADD) ; Return IEN of the record with .01 field equals VALUE
 N MAGNFDA,MAGNIEN,MAGNXE,IEN,MAGRY
 I (VALUE=0)!(VALUE<0) Q $$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Unexpected value of #"_FILE_".01 :"_VALUE ; Error
 ; Do we have IEN?
 I +VALUE=VALUE D SETOKVAL^MAGVAF02(.MAGRY,VALUE) Q MAGRY
 ; Find the IEN by VALUE
 S IEN=$$FIND1^DIC(FILE,"","BX",VALUE,"","","MAGNXE") ; Find the IEN for VALUE
 I $D(MAGNXE("DIERR")) Q $$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_$G(MAGNXE("DIERR",1,"TEXT",1))
 I IEN>0 D SETOKVAL^MAGVAF02(.MAGRY,IEN) Q MAGRY
 ; Return error if we don't need to add a new record
 I 'ADD Q $$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Record "_VALUE_" is not found in file #"_FILE
 ; Add a new record to FILE and return IEN of the new record
 S MAGNFDA(FILE,"+1,",.01)=VALUE
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) Q $$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_$G(MAGNXE("DIERR",1,"TEXT",1))
 D SETOKVAL^MAGVAF02(.MAGRY,MAGNIEN(1))
 Q MAGRY
 ;
 ; Input parameters
 ; ================
 ;   FILE = FileMan file number (e.g. 2006.916)
 ;   FIELD = Field number or name (e.g. "CREATING APPLICATION" or 6)
 ;   
GETFILEP(FILE,FIELD)  ; Returns the file that a FIELD in file FILE points to
 Q $P($$GET1^DID(FILE,FIELD,"","SPECIFIER"),"P",2)

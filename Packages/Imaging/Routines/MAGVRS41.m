MAGVRS41 ;WOIFO/DAC,MLH,NST - Utilities for RPC calls for DICOM file processing ; 29 Feb 2012 10:41 AM
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
INPUTSEP() ; Name value separator for input data  ie. NAME`TESTPATIENT
 Q "`"
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and Result separator ie. -3``No record IEN  
 Q "`"
UPDATE(OUT,FILE,ATTS,OVERRIDE) ; Update Attributes
 N FDA,IEN,DATETIME,UIEN,UFILE,FIELDERR
 ; If File is out of range quit with error
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 I (FILE<2005.6)!(FILE>2005.65) S OUT(1)="-1"_SSEP_"File is not in the 2005.6 to 2005.65 range" Q
 ; If first attribute is not the update record's IEN quit with error
 I $P($G(ATTS(1)),ISEP,1)'["IEN" S OUT(1)="-2"_SSEP_"No record IEN" Q
 S IEN=$P(ATTS(1),ISEP,2) K ATTS(1)
 I (IEN<1)!(IEN>($O(^MAGV(FILE," "),-1))) S OUT(1)="-6"_SSEP_"Invalid IEN" Q
 I FILE'=2005.6 D  Q:$D(OUT(1))  ; logic for files with parents only!
 . I '$G(OVERRIDE) D  Q:$D(OUT(1))
 . . I $P($G(ATTS(2)),ISEP,1)'["REFERENCE" S OUT(1)="-2"_SSEP_"No record IEN" Q
 . . S PIEN=$P(ATTS(2),ISEP,2)
 . . Q
 . I '$G(IEN) S OUT(1)="-1"_SSEP_"No IEN" Q
 . I '$G(OVERRIDE),'$$PARENT(FILE,IEN,PIEN) S OUT(1)="-9"_SSEP_"Parent Record not verified" Q
 . ; Check for STATUS INACCESSIBLE 
 . I $G(PIEN),((FILE=2005.63)!(FILE=2005.64)) D  Q:$D(OUT(1))
 . . N PFILE,STATUS
 . . I FILE=2005.63 S PFILE=2005.62
 . . I FILE=2005.64 S PFILE=2005.63
 . . S STATUS=$$GET1^DIQ(PFILE,PIEN,"STATUS","I")
 . . I STATUS="I" S OUT(1)="-100"_SSEP_"Parent status is Inaccessible."
 . . Q
 . Q
 S ATTS($O(ATTS(" "),-1)+1)="STATUS"_ISEP_"A" ; update always (re)activates
 D SETFDA^MAGVRS44(FILE,.ATTS,IEN_",",.FDA,.FIELDERR,1)
 D FILE^DIE("","FDA","ERR")
 I $D(ERR("DIERR")) S OUT(1)="-6"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 I $D(ERR("DIERR")) Q
 K FDA,ERR
 I FILE=2005.65,$G(PIEN)'="" D AOFSET(PIEN)
 ;Update last update for record and parents
 S DATETIME=$$NOW^XLFDT
 S UIEN=IEN,UFILE=FILE
 F UFILE=UFILE:-.01:2005.62 Q:'UIEN  D
 . I FILE'=2005.65 D
 . . S FDA(UFILE,UIEN_",",$$GETFIELD(UFILE,"LAST UPDATE DATE/TIME"))=DATETIME
 . . D FILE^DIE("","FDA","ERR")
 . . I $D(ERR("DIERR")) S OUT(1)="-3"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 . . I $D(ERR("DIERR")) Q
 . . K FDA,ERR
 . . Q
 . I UIEN S PIEN=+$G(^MAGV(UFILE,UIEN,6))
 . Q
 S OUT(1)="0"_SSEP_$G(FIELDERR)_SSEP_IEN
 Q
ATTACH(OUT,FILE,ATTS) ; Create record; attach to parent record if applicable
 ; Input Variables: 
 ;                 FILE - File number of record
 ;                 ATTS - Array of name value pairs separated by an input separator
 ; Output Variables:
 ;                 OUT  - Returns success and new record IEN or error and error message 
 N FDA,OSEP,ISEP,SSEP,NAM,VAL,ATTNAMS,KEYFLD,UATT,IEN,STATUS,NEWATTS,I
 N PIEN,PPIEN,PFILE,ERR,CIEN,UID,UIEN,DATETIME,KEYNAM,FIELDERR,DFN,DEVFDA,DEVICE
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 ; If file out of range quit with error
 I (FILE<2005.6)!(FILE>2005.65) S OUT(1)="-4"_SSEP_"File is not in the 2005.6 to 2005.65 range" Q 
 ; If atts not defined quit with error
 S I=0
 F  S I=$O(ATTS(I)) Q:'I  D  Q:$D(OUT(1))
 . S NAM=$P(ATTS(I),ISEP,1),VAL=$P(ATTS(I),ISEP,2)
 . I NAM="" S OUT(1)="-64"_SSEP_"Attribute name(s) missing from attribute array" Q
 . S ATTNAMS(NAM)=VAL
 . Q
 Q:$D(OUT(1))
 S KEYNAM=$$GET1^DID(FILE,.01,,"LABEL"),(UATT,KEYFLD(.01))=$G(ATTNAMS(KEYNAM))
 S KEYFLD(.01,"GSL")=$$GET1^DID(FILE,.01,,"GLOBAL SUBSCRIPT LOCATION")
 ; Set PIEN (parent IEN)
 I FILE=2005.61 S PIEN=$G(ATTNAMS("PATIENT REFERENCE")),PFILE=2005.6
 I FILE=2005.62 S PIEN=$G(ATTNAMS("PROCEDURE REFERENCE")),PFILE=2005.61
 I FILE=2005.63 S PIEN=$G(ATTNAMS("STUDY REFERENCE")),PFILE=2005.62
 I FILE=2005.64 S PIEN=$G(ATTNAMS("SERIES REFERENCE")),PFILE=2005.63
 I FILE=2005.65 S PIEN=$G(ATTNAMS("SOP INSTANCE REFERENCE")),PFILE=2005.64
 ; Check for STATUS INACCESSIBLE 
 I (FILE=2005.63)!(FILE=2005.64) D  Q:$D(OUT(1))
 . S STATUS=$$GET1^DIQ(PFILE,PIEN,"STATUS","I")
 . I STATUS="I" S OUT(1)="-100"_SSEP_"Parent status is Inaccessible."
 . Q
 ; File DEVICE MANUFACTURER and DEVICE MODEL as ACQUISITION DEVICE in file 2005.63
 I FILE=2005.63 D
 . ; Remove parentheses from DEVICE MANUFACTOR and DEVICE MODEL and concatenate DEVICE and place model in parentheses
 . S DEVMAN=$G(ATTNAMS("DEVICE MANUFACTURER"))
 . S DEVMODEL=$G(ATTNAMS("DEVICE MODEL"))
 . S DEVICE=DEVMAN_" ("_DEVMODEL_")"
 . ; If the device is not in 2006.04 add device
 . I '$D(^MAG(2006.04,"B",DEVICE)) D
 . . S DEVFDA(2006.04,"+1,",.01)=DEVICE
 . . D UPDATE^DIE("","DEVFDA","","DEVERR")
 . . Q
 . ; If the device is in 2006.04 get IEN of entry
 . S DEVIEN=$O(^MAG(2006.04,"B",DEVICE,""))
 . S ATTS($O(ATTS(" "),-1)+1)="DEVICE"_ISEP_DEVIEN
 . K ATTNAMS("DEVICE MANUFACTURER"),ATTNAMS("DEVICE MODEL")
 . Q
 D:('$D(ATTNAMS("ARTIFACT ON FILE")))&(FILE'=2005.65)
 . S ATTNAMS("ARTIFACT ON FILE")=0
 . S ATTS($O(ATTS(" "),-1)+1)="ARTIFACT ON FILE"_ISEP_0
 . Q
 I $G(UATT)="" S OUT(1)="-5"_SSEP_"Unique identifier not provided" Q
 ; If a patient ID is assigned by the VA set the PATIENT pointer
 I FILE=2005.6,$G(ATTNAMS("ASSIGNING AUTHORITY"))="V" D
 . S DFN=$G(ATTNAMS("ENTERPRISE PATIENT ID"))
 . I DFN'="" S ATTS($O(ATTS(" "),-1)+1)="PATIENT FILE REFERENCE"_ISEP_DFN
 . Q
 ;
 ; Quit with error if no assigning authority provided for a Procedure Reference
 I FILE=2005.61,$G(ATTNAMS("ASSIGNING AUTHORITY"))="" S OUT(1)="-5"_SSEP_"No ASSIGNING AUTHORITY provided." Q
 ;
 ; If entry exists for Patient or Procedure then it is an update
 D  Q:$G(IEN)  Q:$D(OUT(1))  ; Patient or procedure update?
 . ; Add multi-key (already checked .01)
 . I (FILE=2005.6)!(FILE=2005.61) D ADDMKEYS^MAGVRS46(.OUT,FILE,.ATTNAMS,.KEYFLD) Q:$D(OUT(1))
 . ;
 . S IEN=$$MATCH^MAGVRS46(FILE,UATT,$G(PIEN),.KEYFLD) ; Find match by keys
 . Q:'IEN  ; no exact match, create new
 . ;
 . S STATUS=$$GET1^DIQ(FILE,IEN,"STATUS","I")
 . I (FILE>2005.6),(PIEN'=+$G(^MAGV(FILE,IEN,6))) D  Q
 . . I STATUS="A" S OUT(1)="-66"_SSEP_"Parent IEN does not match parent IEN of record on file"
 . . E  S IEN=""   ; STATUS="I"  INACCESSIBLE
 . . Q
 . I STATUS'="I" S OUT(1)="-63"_SSEP_"Active reference with same unique ID already exists" Q
 . S NEWATTS(1)="IEN"_ISEP_IEN
 . F I=1:1 Q:'$D(ATTS(I))  S NEWATTS(I+1)=ATTS(I)
 . S NEWATTS($O(NEWATTS(" "),-1)+1)="STATUS"_ISEP_"A"
 . D UPDATE(.OUT,FILE,.NEWATTS,1)
 . Q
 Q:$D(OUT(1))
 I FILE>2005.6 D  Q:$G(OUT(1))'=""  ; verify that parent IEN is set
 . I PIEN="" S OUT(1)="-1"_SSEP_"No parent record IEN" Q
 . I (PIEN<1)!(PIEN>($O(^MAGV(FILE-.01," "),-1))) S OUT(1)="-6"_SSEP_"Invalid parent IEN" Q
 . Q
 ; If a series and a consult, get the current TIU note for the study (parent IEN)
 I FILE=2005.63 D  Q:$G(OUT(1))<0
 . D TIUCHK^MAGVRS43(.OUT,PIEN) Q:$G(OUT(1))<0  ; bail out if fatal exception raised
 . I $P(OUT(1),SSEP,1)=0 S ATTS($O(ATTS(" "),-1)+1)="TIU NOTE REFERENCE"_ISEP_$P(OUT(1),SSEP,3)
 . K OUT
 . Q
 S ATTS($O(ATTS(" "),-1)+1)="STATUS"_ISEP_"A"
 D SETFDA^MAGVRS44(FILE,.ATTS,"+1,",.FDA,.FIELDERR)
 S UID=$G(FDA(FILE,"+1,",.01))
 I UID="" S OUT(1)="-2"_SSEP_"No UID" Q
 ; Attach record
 D UPDATE^DIE("","FDA","","ERR")
 K FDA
 S CIEN=$O(^MAGV(FILE,"B",UID,""),-1) ; New Record IEN
 S OUT(1)="0"_SSEP_$G(FIELDERR)_SSEP_CIEN ; Set return output to IEN of new record
 I $D(ERR("DIERR")) S OUT(1)="-3"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 I $D(ERR("DIERR")) Q
 K ERR
 ; Update Number of SOP and SERIES Number fields in the Study and Series files
 I (FILE=2005.63)!(FILE=2005.64) S PFILE=FILE-.01,FDA(PFILE,PIEN_",",7)=+$G(^MAGV(PFILE,PIEN,4))+1
 I FILE=2005.64 S PFILE=2005.62 S PPIEN=+$G(^MAGV(2005.63,PIEN,6)),FDA(2005.62,PPIEN_",",20)=$P($G(^MAGV(2005.62,PPIEN,4)),U,2)+1
 D FILE^DIE("","FDA","ERR")
 K FDA
 I FILE=2005.65 D AOFSET(PIEN)
 I FILE>2005.6 D  Q:$G(OUT(1))'=""  ;Update last update for record and parents
 . S DATETIME=$$NOW^XLFDT
 . S UIEN=CIEN
 . F UFILE=FILE:-.01:2005.62 Q:'UIEN  D
 . . I UFILE'=2005.65 D
 . . . S FDA(UFILE,UIEN_",",$$GETFIELD(UFILE,"LAST UPDATE DATE/TIME"))=DATETIME
 . . . S:$G(ERR)'="" OUT(1)=ERR
 . . . K ERR
 . . . D FILE^DIE("","FDA","ERR")
 . . . I $D(ERR("DIERR")) S OUT(1)="-5"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 . . . K FDA,ERR
 . . . Q
 . . I UIEN S UIEN=+$G(^MAGV(UFILE,UIEN,6))
 . . Q
 . Q
 Q
REFRESH(OUT,FILE,IEN,PIEN,OVERRIDE) ; Retrieve specified file data attributes
 N OUTI,FIELD,MULTOUT,FDA,ERR,OSEP,ISEP,SSEP,MULTIPLE,DATETIME,UIEN,UFILE,FORMAT,SUBFILE,SUBIEN,FILEMULT,DD
 N DEVIEN,DEVNAME,DEVMAN,DEVMODEL,VALUE
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP K OUT
 I $G(FILE)="" S OUT(1)="-9"_SSEP_"Missing file specification" Q
 I '$D(^MAGV(FILE)),'$D(^MAGD(FILE)) S OUT(1)="-10"_SSEP_"Invalid file specification ("_$G(FILE)_")" Q
 I '$G(IEN) S OUT(1)="-1"_SSEP_"No record IEN" Q
 I '$G(OVERRIDE),'$G(PIEN) S OUT(1)="-2"_SSEP_"No parent record IEN" Q
 I FILE'=2005.61,'$G(OVERRIDE),'$$PARENT(FILE,IEN,PIEN) S OUT(1)="-3"_SSEP_"Parent Record not verified" Q
 I FILE'=2006.575,'$D(^MAGV(FILE,IEN)) S OUT(1)="-4"_SSEP_"IEN does not exist in "_FILE Q
 I FILE=2006.575,'$D(^MAGD(FILE,IEN)) S OUT(1)="-5"_SSEP_"IEN does not exist in "_FILE Q
 S FIELD=$$GETFIELD(FILE,"STATUS") I FIELD D  Q:$D(OUT)
 . S STATUS=$$GET1^DIQ(FILE,IEN,FIELD,"I")
 . S:STATUS="I" OUT(1)="-11"_SSEP_"No accessible entry for UID found in file "_FILE
 . Q
 S FIELD="",OUTI=2,FNUM=""
 D GETS^DIQ(FILE,IEN_",","**","I","DD")
 ; Process all non-multiple fields
 F  D  Q:FNUM="" 
 . S FNUM=$O(DD(FILE,IEN_",",FNUM)) Q:FNUM=""
 . I FILE=2005.63,FNUM=18 D  Q  ; DEVICE returns DEVICE MANUFACTURER and DEVICE MODEL from the ACQUISITION DEVICE file NAME (.01) field
 . . S DEVIEN=$G(DD("2005.63",IEN_",","18","I"))
 . . Q:$G(DEVIEN)=""
 . . S DEVNAME=$P($G(^MAG(2006.04,DEVIEN,0)),U,1)
 . . S DEVMAN=$P(DEVNAME," (",1)
 . . S DEVMODEL=$TR($P(DEVNAME," (",2),")")
 . . S OUT(OUTI)="DEVICE MANUFACTURER"_OSEP_DEVMAN_SSEP
 . . S OUT(OUTI+1)="DEVICE MODEL"_OSEP_DEVMODEL_SSEP
 . . S OUTI=OUTI+2
 . . Q
 . S FIELD=$$GET1^DID(FILE,FNUM,,"LABEL")
 . S FORMAT=$S((FIELD["INDEX")!(FIELD="SOP CLASS UID")!(FIELD="PHOTOMETRIC INTERPRETATION"):"E",1:"I") ; return internal formats except for index terms and SOP CLASS UID
 . I (FIELD["REFERENCE") S FORMAT="I" ; If the field is an IEN pointer return the internal format rather than the UID string 
 . S VALUE=$$GET1^DIQ(FILE,IEN,FIELD,$G(FORMAT))
 . I $$DATETIME(FILE,FIELD) S VALUE=$$FM2IDF^MAGVAF01(VALUE)
 . I FILE=2005.63,FIELD="ACQUISITION LOCATION",VALUE'="" S VALUE=$$GETSINST(VALUE)
 . I ((FILE=2005.6)!(FILE=2005.61))&(FIELD="SERVICE INSTITUTION REFERENCE"),VALUE'="" S VALUE=$$GETSINST(VALUE),FIELD="CREATING ENTITY"
 . S OUT(OUTI)=FIELD_OSEP_VALUE_SSEP
 . S OUTI=OUTI+1
 . Q
 ; Process multiple fields
 S FILEMULT=FILE
 F  D  Q:FILEMULT=""
 . S FILEMULT=$O(DD(FILEMULT)) Q:FILEMULT=""
 . S FNUM=$E(FILEMULT,$L(FILE)+1,$L(FILEMULT))
 . D GETS^DIQ(FILE,IEN_",",FNUM_"*","","MULTOUT")
 . I '$D(MULTOUT) Q 
 . S FIELD=$$GET1^DID(FILE,FNUM,,"LABEL")
 . S SUBFILE=$O(MULTOUT("")),SUBIEN=""
 . F  D  Q:$O(MULTOUT(SUBFILE,SUBIEN))=""
 . . S SUBIEN=$O(MULTOUT(SUBFILE,SUBIEN))
 . . S OUT(OUTI)=FIELD_OSEP_MULTOUT(SUBFILE,SUBIEN,.01)_SSEP
 . . S OUTI=OUTI+1
 . . Q
 . Q
 S OUT(1)="0"_SSEP ; Look up successful
 ; Update last access date time for study
 S DATETIME=$$NOW^XLFDT
 S UIEN=IEN
 F UFILE=FILE:-.01:2005.62 Q:'UIEN  D
 . I UFILE=2005.62 D
 . . S FDA(UFILE,UIEN_",",$$GETFIELD(UFILE,"LAST ACCESS DATE/TIME"))=DATETIME
 . . K ERR
 . . D FILE^DIE("","FDA","ERR")
 . . S:$G(ERR("DIERR"))'="" OUT(1)="-7"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 . . K FDA,ERR
 . . Q
 . I UIEN S UIEN=+$G(^MAGV(UFILE,UIEN,6))
 . Q
 Q
MULTIPLE(FILE,FIELD) ; Process multiple DB entries
 N DATATYPE,MULTIPLE,FNUM
 S MULTIPLE=$$GET1^DID(FILE,FIELD,,"MULTIPLE-VALUED")
 Q +MULTIPLE
NUMERIC(FILE,FIELD) ; Determine if field is numeric
 N DATATYPE,NUMERIC
 S NUMERIC=0
 I $$GET1^DID(FILE,FIELD,"","TYPE")="NUMERIC" S NUMERIC=1
 Q NUMERIC
DATETIME(FILE,FIELD) ; Determine if field is date time
 N DATATYPE,DATETIME
 S DATETIME=0
 I $$GET1^DID(FILE,FIELD,"","TYPE")="DATE/TIME" S DATETIME=1
 Q DATETIME
GETFIELD(FILE,FNAME) ; Returns a field number given a field name
 Q $$FLDNUM^DILFD(FILE,FNAME)
PARENT(FILE,IEN,PIEN) ; Check if provided parent IEN is linked to current record
 I PIEN'=+$G(^MAGV(FILE,IEN,6)) Q 0
 Q 1
AOFSET(PIEN) ; Set artifact on file to 1 for all parent nodes of file instance
 N AOFFILE,FIELD,FDA,ERR
 F AOFFILE=2005.64,2005.63,2005.62,2005.61,2005.6 D
 . S FIELD=$$GETFIELD(AOFFILE,"ARTIFACT ON FILE")
 . I $G(FIELD)="" Q
 . S FDA(AOFFILE,PIEN_",",FIELD)=1
 . D FILE^DIE("","FDA")
 . K FDA,ERR
 . I AOFFILE>2005.6 S PIEN=+$G(^MAGV(AOFFILE,PIEN,6))
 Q
INACTIVT(OUT,FILE,IEN,PIEN,OVERRIDE,REASON) ; Marks the entry indicated by file # and IEN as deleted
 N OSEP,ISEP,SSEP,STATUS,PFILE,ERR,FDA,AOF,FIELD,AOFIEN
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 I $G(FILE)="" S OUT(1)="-23"_SSEP_"No file number provided" Q
 I $G(IEN)="" S OUT(1)="-20"_SSEP_"No IEN provided" Q
 I '$G(PIEN)="" S OUT(1)="-21"_SSEP_"No parent IEN provided" Q
 I '$D(OVERRIDE) S OUT(1)="-22"_SSEP_"No OVERRIDE flag provided" Q
 I '$D(^MAGV(FILE,IEN,0)) S OUT(1)="-1"_SSEP_"Record IEN not found in file" Q
 I '$D(REASON) S OUT(1)="-4"_SSEP_"No deletion reason provided" Q
 ; If record status is already INACCESIBLE quit with error
 S FIELD=$$GETFIELD(FILE,"STATUS")
 S STATUS=$$GET1^DIQ(FILE,IEN,FIELD,"E")
 I STATUS="INACCESSIBLE" S OUT(1)="2"_SSEP_"Record is already inaccessible" Q
 ; Call INACT to delete identified record and all children
 D INACT^MAGVRS44(.OUT,FILE,IEN,$G(PIEN),$G(OVERRIDE),$G(REASON))
 I $D(OUT(1)) Q
 ; Set parent records artifact on file to false if no active child records
 S AOFIEN=IEN,AOF=""
 F FILE=FILE:2005.61:-.01 Q:AOF'=""  D
 . F  S AOFIEN=+$G(^MAGV(FILE,"C",PIEN,AOFIEN)) Q:(AOF'="")!(AOFIEN="")  D 
 . . S FIELD=$$GETFIELD(FILE,"ARTIFACT ON FILE")
 . . S AOF=$$GET1^DIQ(FILE,AOFIEN,FIELD)
 . Q
 . ;If no child records are on file then set parent to artifact not on file
 . I AOF="" D
 . . S PFILE=FILE-.01
 . . S FIELD=$$GETFIELD(FILE,"ARTIFACT ON FILE")
 . . S FDA(PFILE,PIEN_",",FIELD)=""
 . . D FILE^DIE("","FDA")
 . . K FDA,ERR
 . . Q
 . Q 
 I '$D(OUT(1)) S OUT(1)="0"_SSEP_SSEP_IEN
 Q 
FINDBUID(OUT,FILE,UID) ;Find SOP or series by UID
 N STATUS,IEN,OSEP,ISEP,SSEP
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 I $G(FILE)="" S OUT="-3"_SSEP_"No file specified" Q
 I "^2005.62^2005.63^2005.64^"'[("^"_FILE_"^") S OUT="-4"_SSEP_"Invalid file specified ("_FILE_")" Q
 I $G(UID)="" S OUT="-5"_SSEP_"No UID specified" Q
 S IEN=$O(^MAGV(FILE,"B",UID,""))
 S FIELD=$$GETFIELD(FILE,"STATUS")
 S STATUS=$$GET1^DIQ(FILE,IEN,FIELD,"I")
 I IEN'="",STATUS'="I" S OUT="0"_SSEP_SSEP_IEN Q
 I IEN="" S OUT="-1"_SSEP_"UID not found in file "_FILE Q
 I STATUS="I" S OUT="-2"_SSEP_"No active entry for UID found in file "_FILE Q
 Q
GETSINST(VALUE) ; Get the service institution value
 N IEN,FILE,SITE,X
 S SITE="Error - unknown service institution"
 S X=$G(^MAGV(2005.8,$G(VALUE),0))
 S IEN=$P(X,";",1),FILE=$P(X,";",2)
 I FILE="DIC(4," S SITE=$P($$NS^XUAF4(IEN),U,2) ; IA #2171 Get Station Number
 Q SITE

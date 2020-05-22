MAGVRS44 ;WOIFO/DAC,MLH - Utilities for RPC calls for DICOM file processing ; 09 Sep 2019 1:59 PM
 ;;3.0;IMAGING;**118,239**;Mar 19, 2002;Build 18
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
INACT(OUT,FILE,IEN,PIEN,OVERRIDE,REASON) ; Marks the entry indicated by file # and IEN as deleted
 N FDA,ERR,DELAPP,DIEN,UID,AOFUNSET,PPIEN,PFILE,RESULT,STATUS,SSEP,OSEP,ISEP,TOKEN,MAGRY
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 S OUT(1)=0
 I $G(IEN)="" S OUT(1)="-1"_SSEP_"No IEN" Q
 I $G(FILE)="" S OUT(1)="-2"_SSEP_"No FILE number provided" Q
 I '$D(OVERRIDE) S OUT(1)="-7"_SSEP_"Override flag not passed" Q
 I $G(REASON)="" S REASON="Not provided"
 I IEN'=+IEN S OUT(1)="-6"_SSEP_"Invalid IEN format" Q
 I FILE'=2005.6,'OVERRIDE,'$$PARENT^MAGVRS41(FILE,IEN,PIEN) S OUT(1)="-2"_SSEP_"Parent Record not verified" Q
 ; can only invalidate PATIENT REF and PROCEDURE REF entries w/o children
 I ((FILE=2005.6)!(FILE=2005.61)),$D(^MAGV(FILE+.01,"C",IEN)) D  Q
 . S OUT(1)="-6"_SSEP_"Cannot inactivate "
 . S:FILE=2005.6 OUT(1)=OUT(1)_"PATIENT REF"
 . S:FILE=2005.61 OUT(1)=OUT(1)_"PROCEDURE REF"
 . S OUT(1)=OUT(1)_" entry with children"
 . Q
 I '$D(^MAGV(FILE,IEN,0)) S OUT(1)="-3"_SSEP_"No record for file # and IEN provided." Q
 ; Delete main record and then delete all related child records
 S FIELD=$$GETFIELD^MAGVRS41(FILE,"STATUS")
 ; If record is already INACTIVE quit
 S STATUS=$$GET1^DIQ(FILE,IEN,FIELD,"I")
 I STATUS="I" Q 
 S FDA(FILE,IEN_",",FIELD)="I" ; Set Status to Inactive
 I FILE=2005.65 D
 . S FDA(2005.65,IEN_",",9)=$$NOW^XLFDT
 . S FDA(2005.65,IEN_",",10)=DUZ
 . S FDA(2005.65,IEN_",",12)=REASON
 . S TOKEN=$P(^MAGV(2005.65,IEN,0),U,1)
 . S DELAPP="MAG SYS DELETE"
 . D DELAFACT^MAGVAD02(.MAGRY,TOKEN,DELAPP)
 . S MAGRY=$TR(MAGRY,$$RESDEL^MAGVAF02,ISEP)
 . I MAGRY'=0 S OUT(1)=MAGRY
 . Q
 I FILE'=2005.65 D
 . S FIELD=$$GETFIELD^MAGVRS41(FILE,"ARTIFACT ON FILE")
 . I FIELD'="" S FDA(FILE,IEN_",",FIELD)=0 ; Set Artifact on File to false
 . Q
 D FILE^DIE("","FDA","ERR")
 I FILE'=2005.65 D DELLOG^MAGVRS61(.RESULT,IEN,FILE) I +RESULT<0 S OUT(1)=RESULT
 I $D(ERR("DIERR")) S OUT(1)="-3"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 K ERR,FDA
 ; 
 ; Update Number of SOP and SERIES Number fields in the Study and Series files
 I (FILE=2005.63)!(FILE=2005.64) S PFILE=FILE-.01,FDA(PFILE,PIEN_",",7)=+$G(^MAGV(PFILE,PIEN,4))-1
 I FILE=2005.64 S PFILE=2005.62 S PPIEN=+$G(^MAGV(2005.63,PIEN,4)),FDA(2005.62,PPIEN_",",20)=$P($G(^MAGV(2005.62,PPIEN,4)),U,2)-1
 I (FILE=2005.63)!(FILE=2005.64) D FILE^DIE("","FDA","ERR") K FDA
 S DIEN=""
 F  S DIEN=$O(^MAGV(FILE+.01,"C",IEN,DIEN)) Q:DIEN=""  D
 . D INACT(.OUT,FILE+.01,DIEN,IEN,1,REASON)
 . Q
 Q
SETFDA(FILE,ATTS,IENS,FDA,FIELDERR,UPDATE,FDB) ; Set the FDA array for updates and new attachments
 N FIELDVAL,VALUE,FIELD,I,IX,J,MIEN,MFILE,MSFILE,MULT,MVALUE,VALID,VALUE,DIC,ISEP,OSEP,TYPEFDA,TYPEIEN,SOPIEN,SOPFDA,X,Y,FNUM
 N SIVAL,SIFLD,ERROR,CLASSIEN
 S FIELDVAL="",IX="",MIEN=2,ISEP=$$INPUTSEP^MAGVRS41
 F  D  Q:IX=""  Q:$D(ERROR)
 . S IX=$O(ATTS(IX)) Q:IX=""
 . S FIELDVAL=ATTS(IX)
 . S FIELD=$P(FIELDVAL,ISEP,1)
 . ; Kill DEVICE MANUFACTURER and DEVICE MODEL
 . I (FIELD="DEVICE MANUFACTURER")!(FIELD="DEVICE MODEL") K ATTS(IX) Q
 . I FIELD["OVERRIDE" Q
 . S VALUE=$P(FIELDVAL,ISEP,2)
 . S VALUE=$TR(VALUE,"^","~")
 . ; Set ACQUISITION LOCATION and SERVICE INSTITUTION REFERENCE
 . I (FIELD="CREATING ENTITY")!(FIELD="ACQUISITION LOCATION") D  Q:$D(FIELDERR)
 . . D SERVINST(VALUE,.SIVAL)
 . . I ($G(SIVAL)<0) D SERVERR(.FIELDERR,FIELD,VALUE) S:FIELDERR["Error" ERROR=1 Q
 . . S FIELD=$S(FIELD="CREATING ENTITY":"SERVICE INSTITUTION REFERENCE",1:FIELD)
 . . S VALUE=SIVAL
 . . Q
 . ; Handle SOP CLASS UID
 . I FIELD="SOP CLASS UID",$G(VALUE)'="" D
 . . I '$D(^MAG(2006.532,"B",VALUE)) D
 . . . S SOPFDA(2006.532,"+1,",.01)=VALUE
 . . . D UPDATE^DIE("","SOPFDA","","SOPERR")
 . . . Q
 . . ; If the device is in 2006.04 get IEN of entry
 . . S SOPIEN=$O(^MAG(2006.532,"B",VALUE,""))
 . . S VALUE=SOPIEN
 . . Q
 . I FIELD="TYPE INDEX",$G(VALUE)'="" D
 . . I '$D(^MAG(2005.83,"B",VALUE)) D
 . . . S TYPEFDA(2005.83,"+1,",.01)=VALUE
 . . . D UPDATE^DIE("","TYPEFDA","","TYPEERR")
 . . . Q
 . . ; If the device is in 2005.83 get IEN of entry
 . . S TYPEIEN=$O(^MAG(2005.83,"B",VALUE,""))
 . . S VALUE=TYPEIEN
 . . Q
 . ; P239 DAC - Class Index was storing as free text, changed to pointer value (#2005.82)
 . I FIELD="CLASS INDEX",$G(VALUE)'="" D
 . . I '$D(^MAG(2005.82,"B",VALUE)) S VALUE=""
 . . I VALUE="" S FIELDERR="Warning - Invalid field: "_FIELD Q
 . . S CLASSIEN=$O(^MAG(2005.82,"B",VALUE,""))
 . . S VALUE=CLASSIEN
 . . Q
 . I FIELD="PHOTOMETRIC INTERPRETATION",$G(VALUE)'="" D
 . . S VALUE=$$PHOTOIN(VALUE)
 . . I VALUE="" S FIELDERR="Warning - Invalid field: "_FIELD Q
 . . Q
 . I ((FIELD="TYPE INDEX")!(FIELD="SOP CLASS UID"))&(VALUE="") Q
 . S FNUM=$$GETFIELD^MAGVRS41(FILE,FIELD)
 . I FNUM=0 S FIELDERR="Warning - Invalid field: "_FIELD Q
 . I $$NUMERIC^MAGVRS41(FILE,FIELD) S VALUE=$TR(VALUE,"")
 . I $$DATETIME^MAGVRS41(FILE,FIELD) S VALUE=$$IDF2FM^MAGVAF01(VALUE)
 . ; Do not validate for internal values or LAYGO fields
 . I (VALUE'=""),$$GET1^DID(FILE,FNUM,"","TYPE")'="POINTER" D CHK^DIE(FILE,FNUM,"E",VALUE,.VALID) I VALID="^" S FIELDERR="Warning - Invalid data:"_VALUE_" Field:"_FIELD Q
 . S FDA(FILE,IENS,FNUM)=VALUE
 . Q
 Q
PHOTOIN(VALUE) ; Return the enumerated code for a photometric interpretation
 N CODE,CODEVAL,I,RES
 S CODE=""
 D FIELD^DID(2005.64,21,"","POINTER","RES")
 F I=1:1:$L(RES("POINTER"),";") S CODEVAL=$P(RES("POINTER"),";",I) Q:CODE'=""  D
 . I $P(CODEVAL,":",2)=$G(VALUE) S CODE=$P(CODEVAL,":",1)
 . Q
 Q CODE
 ; 
 ;***** Returns and stores Service Institution 
 ;
 ; Input Parameters
 ; ================
 ; VALUE=Site IEN
 ; 
 ; Return Values
 ; =============
 ; SIVAL=IEN of entry in the Imaging Service Institution file (#2005.8)
 ; 
SERVINST(VALUE,SIVAL) ;
 N DIC,DLAYGO,X,Y
 S (DIC,DLAYGO)=2005.8,DIC(0)="LX",X=$G(VALUE) D ^DIC S SIVAL=$P(Y,"^",1)
 Q
SERVERR(FIELDERR,FIELD,VALUE) ; Sets field error with field and value
 I FIELD="ACQUISITION LOCATION" S FIELDERR="Warning - "_$G(FIELD)_" ("_$G(VALUE)_") "_" not found in IMAGING SERVICE INSTITUTION file (#2005.8)."
 I FIELD="CREATING ENTITY" S FIELDERR="Error - "_$G(FIELD)_" ("_$G(VALUE)_") "_" not found in IMAGING SERVICE INSTITUTION file (#2005.8)."
 Q

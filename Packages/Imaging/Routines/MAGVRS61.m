MAGVRS61 ;WOIFO/DAC - RPC calls for DICOM file processing ; 20 Nov 2015 11:20 AM
 ;;3.0;IMAGING;**118,162**;Mar 19, 2002;Build 22;Nov 20, 2015
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
DUPUID(OUT,ACCESSION,DFN,TYPE,UID,STUDUID,SERUID) ; Check for duplicate UIDs in the new structure
 ; OUT - Duplicate message output
 ; ACCESSION - Accession #  ; DFN - Patient DFN
 ; TYPE - Type of UID check - "STUDY", "SERIES", or "SOP"
 ; UID - Unique Identifier
 ; if accession number does not match then it's a duplicate UID
 ; OUT:
 ;
 ; -1 - Exception with error message
 ; 
 ; 0 - Not a duplicate UID - Non duplicates are either have no entries in the 2005.6x files
 ;                           or they match on UID, DFN, Accession, and parent UIDs
 ; 1 - Duplicate UID       - Duplicates have an entry in a 2005.6x file, but does not match
 ;                           on UID, DFN, Accession, and/or parent UID
 ; 2 - Record exist        - A record exists with a matching DFN, Accession, Study UID, Series UID,
 ;                           and SOP UID already
 N SOPOUT,SOPLINK
 I TYPE'="STUDY",TYPE'="SERIES",TYPE'="SOP" S OUT="-1~TYPE is not Study, Series, or SOP" Q
 S OUT=0
 ; If the UID and the accession are already being used and the UID is not linked to the
 ; procedure REF with the same accession then the UID is a duplicate
 I TYPE="STUDY",$D(^MAGV(2005.62,"B",UID)) D
 . I $$LINKED(ACCESSION,DFN,UID,"STUDY") Q
 . S OUT=1
 . Q
 I TYPE="SERIES",$D(^MAGV(2005.63,"B",UID)) D
 . I $$LINKED(ACCESSION,DFN,UID,"SERIES",STUDUID) Q
 . S OUT=1
 . Q
 I TYPE="SOP",$D(^MAGV(2005.64,"B",UID)) D
 . S SOPLINK=$$LINKED(ACCESSION,DFN,UID,"SOP",STUDUID,SERUID)
 . I SOPLINK=2 S OUT=0 Q
 . I SOPLINK="NOT AOF" S OUT=0 Q  ; P162 DAC - Check AOF before checking if duplicate
 . I SOPLINK=1 S OUT=2 Q
 . S OUT=1
 . Q
 Q OUT
DUPSTUD(DFN,ACCESSION,UID)  ; Check for duplicate Study UID
 S TYPE="STUDY"
 I $G(ACCESSION)="" Q "-1~No accession number provided"
 I $G(DFN)="" Q "-1~No patient DFN provided"
 D DUPUID(.OUT,ACCESSION,DFN,TYPE,UID)
 Q OUT
DUPSER(DFN,ACCESSION,STUDUID,UID)  ; Check for duplicate Series UID
 S TYPE="SERIES"
 I $G(ACCESSION)="" Q "-1~No accession number provided"
 I $G(DFN)="" Q "-1~No patient DFN provided"
 D DUPUID(.OUT,ACCESSION,DFN,TYPE,UID,STUDUID)
 Q OUT
DUPSOP(DFN,ACCESSION,STUDUID,SERUID,UID)  ; Check for duplicate SOP UID
 S TYPE="SOP"
 I $G(ACCESSION)="" Q "-1~No accession number provided"
 I $G(DFN)="" Q "-1~No patient DFN provided"
 D DUPUID(.OUT,ACCESSION,DFN,TYPE,UID,STUDUID,SERUID)
 Q OUT
LINKED(ACCESSION,DFN,UID,UIDTYPE,STUDUIDA,SERUIDA) ; Check if duplicate UID is linked to the same procedure, patient, and parent Study, Series, SOP IENS
 N LINK,IEN,PROCIEN,STUDYIEN,SERIESIEN,SOPIEN,PROCCASE,PRIEN,PRDFN,STATUS,STUDUIDB,SOPUIDB,PATPROC,SERUIDB,AOF
 S LINK=0
 I UIDTYPE="STUDY" D
 . ; Check if the Study IEN is linked to the procedure IEN with the Accession #
 . S STUDYIEN=""
 . F  S STUDYIEN=$O(^MAGV(2005.62,"B",UID,STUDYIEN)) Q:STUDYIEN=""  D  Q:STATUS="A"
 . . S STATUS=$P($G(^MAGV(2005.62,STUDYIEN,5)),U,2)
 . . Q:STATUS="I"
 . . S PATPROC=$G(^MAGV(2005.62,STUDYIEN,6))
 . . S PROCIEN=$P(PATPROC,U,1)
 . . S PRIEN=$P(PATPROC,U,3)
 . . Q
 . Q
 I UIDTYPE="SERIES" D
 . ; Check if the Series IEN is linked to the procedure IEN with the Accession # 
 . S SERIESIEN=""
 . F  S SERIESIEN=$O(^MAGV(2005.63,"B",UID,SERIESIEN)) Q:SERIESIEN=""  D  Q:STATUS="A"
 . . S STATUS=$G(^MAGV(2005.63,SERIESIEN,9))
 . . Q:STATUS="I"
 . . S STUDYIEN=$P($G(^MAGV(2005.63,SERIESIEN,6)),U,1)
 . . S STUDUIDB=$P($G(^MAGV(2005.62,STUDYIEN,0)),U,1)
 . . S PATPROC=$G(^MAGV(2005.62,STUDYIEN,6))
 . . S PROCIEN=$P(PATPROC,U,1)
 . . S PRIEN=$P(PATPROC,U,3)
 . . Q
 . Q
 I UIDTYPE="SOP" D
 . ; Check if the SOP IEN is linked to the procedure IEN with the Accession #
 . S SOPIEN=""
 . F  S SOPIEN=$O(^MAGV(2005.64,"B",UID,SOPIEN)) Q:SOPIEN=""  D  Q:STATUS="A"
 . . S STATUS=$G(^MAGV(2005.64,SOPIEN,11))
 . . Q:STATUS="I"
 . . S AOF=$P($G(^MAGV(2005.64,SOPIEN,6)),U,2)
 . . S SERIESIEN=$P($G(^MAGV(2005.64,SOPIEN,6)),U,1)
 . . S SERUIDB=$P($G(^MAGV(2005.63,SERIESIEN,0)),U,1)
 . . S STUDYIEN=$P($G(^MAGV(2005.63,SERIESIEN,6)),U,1)
 . . S STUDUIDB=$P($G(^MAGV(2005.62,STUDYIEN,0)),U,1)
 . . S PATPROC=$G(^MAGV(2005.62,STUDYIEN,6))
 . . S PROCIEN=$P(PATPROC,U,1)
 . . S PRIEN=$P(PATPROC,U,3)
 . . Q
 . Q
 I $G(PROCIEN)="" Q LINK  ; Not linked to a procedure ref
 I $G(PRIEN)="" Q LINK  ; Not linked to a procedure ref
 S PROCCASE=$P(^MAGV(2005.61,PROCIEN,0),U,1)
 S PRDFN=$P($G(^MAGV(2005.6,PRIEN,0)),U,1)
 I PRDFN=DFN,ACCESSION=PROCCASE S LINK=1
 I TYPE="SERIES",LINK,STUDUIDA'=STUDUIDB S LINK=0
 I TYPE="SOP",LINK,((STUDUIDA'=STUDUIDB)!(SERUIDA'=SERUIDB)) S LINK=0
 I LINK=1,TYPE="SOP",AOF'=1 S LINK="NOT AOF" Q LINK
 I $G(STATUS)="I" Q 2  ; P162 DAC - Check Status after AOF check. No accessible record found.
 Q LINK
LOGDUP(ORIGUID,NEWUID,ACCESSION,DFN,TYPE,STUDYUID,SERUID)  ; Log duplicate UIDs
 N FDA,FILE,ONEWUID,SOCTYPE
 S ONEWUID=NEWUID ; Store original generated NEWUID with postfix 
 I TYPE="SERIES",STUDYUID="" S NEWUID="-1~No Study UID provided" Q
 I TYPE="SOP",STUDYUID="" S NEWUID="-1~No Study UID provided" Q
 I TYPE="SOP",SERUID="" S NEWUID="-1~No Series UID provided" Q
 L +^MAGV(2005.66,"C",ONEWUID):1E9 ; Lock generated UID
 I TYPE="STUDY" S SOCTYPE=1
 I TYPE="SERIES" S SOCTYPE=2
 I TYPE="SOP" S SOCTYPE=3
 S FILE=2005.66
 D LOGLOOK(.NEWUID)
 S FDA(FILE,"+1,",.01)=ORIGUID
 S FDA(FILE,"+1,",2)=NEWUID
 S FDA(FILE,"+1,",3)=ACCESSION
 S FDA(FILE,"+1,",4)=DFN
 S FDA(FILE,"+1,",5)=SOCTYPE
 I $G(STUDYUID)'="" S FDA(FILE,"+1,",6)=STUDYUID
 I $G(SERUID)'="" S FDA(FILE,"+1,",7)=SERUID
 D UPDATE^DIE("","FDA")
 L -^MAGV(2005.66,"C",ONEWUID) ; Unlock original generated UID
 I NEWUID'=ONEWUID L -^MAGV(2005.66,"C",NEWUID) ; Unlock new generated UID with postfix
 K FDA
 Q
LOGLOOK(NEWUID) ; Look for UID in duplicate log and generate a new UID if there is a duplicate
 N POSTFIX
 I '$$UIDCHECK(NEWUID) F POSTFIX=1:1 Q:$$UIDCHECK(NEWUID_"."_POSTFIX)
 I $G(POSTFIX)'="" D
 . S NEWUID=NEWUID_"."_POSTFIX
 . L +^MAGV(2005.66,"C",NEWUID):1E9
 . Q
 Q
UIDCHECK(POSTUID) ; Check if newly generated UID exists in UID database indexes
 ; If UID is found return 0, if UID is not found return 1
 N UNIQUE
 S UNIQUE=1
 D  ; Check file indexes for UID 
 . ; Check for duplicate in new UID log
 . I $D(^MAGV(2005.66,"C",POSTUID)) S UNIQUE=0 Q
 . ; Check for duplicate Study and SOP in 2005
 . I $D(^MAG(2005,"P",POSTUID)) S UNIQUE=0 Q
 . ; Check for duplicate Series in 2005
 . I $D(^MAG(2005,"SERIESUID",POSTUID)) S UNIQUE=0 Q
 . ; Check for duplicate Study in 2005.62
 . I $D(^MAGV(2005.62,"B",POSTUID)) S UNIQUE=0 Q
 . ; Check for duplicate Series in 2005.63
 . I $D(^MAGV(2005.63,"B",POSTUID)) S UNIQUE=0 Q
 . ; Check for duplicate SOP in 2005.64
 . I $D(^MAGV(2005.64,"B",POSTUID)) S UNIQUE=0 Q
 . Q
 Q UNIQUE
UIDLOOK(UID,DFN,ACC,TYPE,STUDYUID,SERUID) ; Look to see if Original UID exists and if entry matches DFN and ACC provided. If so, return New UID. Otherwise, 0.
 N OUT,IEN,ENTRY,ENTRY2,STYPE
 S OUT=0
 I (UID="")!($G(DFN)="")!($G(ACC)="")!($G(TYPE)="") Q OUT
 I '$D(^MAGV(2005.66,"B",UID)) Q OUT
 I TYPE="SERIES",$G(STUDYUID)="" Q OUT
 I TYPE="SOP",($G(SERUID)="")!($G(STUDYUID)="") Q OUT
 I TYPE="SERIES" I '$D(^MAGV(2005.66,"D",UID,$G(STUDYUID))) Q OUT
 I TYPE="SOP" I '$D(^MAGV(2005.66,"E",UID,$G(SERUID))) Q OUT
 S IEN=""
 F  S IEN=$O(^MAGV(2005.66,"B",UID,IEN)) Q:(IEN="")!(OUT'=0)  D
 . S ENTRY=$G(^MAGV(2005.66,IEN,0))
 . S ENTRY2=$G(^MAGV(2005.66,IEN,1))
 . S STYPE=$P($$GET1^DIQ(2005.66,IEN,5)," ",1)
 . I DFN=$P(ENTRY,U,4),ACC=$P(ENTRY,U,3),TYPE=STYPE D
 . . I TYPE="STUDY",$G(UID)=$P(ENTRY,U,1) S OUT=$P(ENTRY,U,2) Q
 . . I TYPE="SERIES",$G(STUDYUID)=$P(ENTRY2,U,1),$G(UID)=$P(ENTRY,U,1) S OUT=$P(ENTRY,U,2) Q
 . . I TYPE="SOP",$G(STUDYUID)=$P(ENTRY2,U,1),$G(SERUID)=$P(ENTRY2,U,2),$G(UID)=$P(ENTRY,U,1) S OUT=$P(ENTRY,U,2) Q
 Q OUT
DELLOG(OUT,IEN,FILE) ; Remove inactivated entries from the duplicate log
 N DUPIEN,PIEN,ACC,DFN,SOPUID,SERUID,STUDUID,TYPE,ERR,UID,PATIEN,SSEP,PROCIEN,PATID,DUPDATA1,DUPDATA2
 N DUPACC,DUPPATID,DSERUID,IENS,FDA,DSTDUID,STUDDATA,DELETE
 ;
 S OUT="0"
 S SSEP=$$STATSEP^MAGVRS41
 I (FILE'=2005.64)&(FILE'=2005.63)&(FILE'=2005.62) S OUT="-1"_SSEP_"Invalid file number" Q
 I IEN="" S OUT="-7"_SSEP_"No IEN provided" Q
 I FILE=2005.64 D 
 . S (SOPUID,UID)=$P($G(^MAGV(2005.64,IEN,0)),U,1)
 . S IEN=$P($G(^MAGV(2005.64,IEN,6)),U,1)
 . Q 
 I IEN="" S OUT="-8"_SSEP_"No Parent Record" Q
 I FILE>=2005.63 D
 . I FILE=2005.64 S SERUID=$P($G(^MAGV(2005.63,IEN,0)),U,2)
 . I FILE=2005.63 S SERUID=$P($G(^MAGV(2005.63,IEN,0)),U,1)
 . I '$D(UID) S UID=SERUID
 . S IEN=$P($G(^MAGV(2005.63,IEN,6)),U,1)
 . Q
 I IEN="" S OUT="-8"_SSEP_"No Parent Record" Q
 I FILE>=2005.62 D
 . I FILE=2005.62 S STUDUID=$P($G(^MAGV(2005.62,IEN,0)),U,1)
 . I FILE'=2005.62 S STUDUID=$P($G(^MAGV(2005.62,IEN,0)),U,2)
 . I '$D(UID) S UID=STUDUID
 . S STUDDATA=$G(^MAGV(2005.62,IEN,6))
 . S PATIEN=$P(STUDDATA,U,3)
 . S PROCIEN=$P(STUDDATA,U,1)
 . I (PROCIEN="")!(PATIEN="") Q
 . S ACC=$P($G(^MAGV(2005.61,PROCIEN,0)),U,1)
 . S PATID=$P($G(^MAGV(2005.6,PATIEN,0)),U,1)
 . Q
 I PATIEN="" S OUT="-9"_SSEP_"No Patient Record" Q
 I PROCIEN="" S OUT="-10"_SSEP_"No Procedure Record" Q
 S DUPIEN=""
 F DUPIEN=$O(^MAGV(2005.66,"C",UID,DUPIEN)) Q:DUPIEN=""  D
 . S DUPDATA1=$G(^MAGV(2005.66,DUPIEN,0))
 . S DUPDATA2=$G(^MAGV(2005.66,DUPIEN,1))
 . S DUPACC=$P(DUPDATA1,U,3),DUPPATID=$P(DUPDATA1,U,4)
 . S DSTDUID=$P(DUPDATA2,U,1),DSERUID=$P(DUPDATA2,U,2)
 . S DELETE=0
 . I FILE=2005.64,ACC=DUPACC,PATID=DUPPATID,((STUDUID=DSTDUID)!('DSTDUID)),(($G(SERUID)=DSERUID)!('DSERUID)) S DELETE=1 ; SOP Check
 . I FILE=2005.63,ACC=DUPACC,PATID=DUPPATID,((STUDUID=DSTDUID)!('DSTDUID)) S DELETE=1 ; Series Check
 . I FILE=2005.62,ACC=DUPACC,PATID=DUPPATID S DELETE=1 ; Study Check
 . I DELETE D
 . . ; Delete matching duplicate entries
 . . S IENS=DUPIEN_","
 . . S FDA(2005.66,IENS,.01)="@"
 . . D FILE^DIE("","FDA","ERR")
 . . S OUT="0"
 . . I $D(ERR("DIERR")) S OUT="-11"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 . . Q
 . Q
 Q
 ;

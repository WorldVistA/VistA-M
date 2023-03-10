MAGDRPC4 ;WOIFO/EDM,DAC - Imaging RPCs ; Feb 15, 2022@10:29:19
 ;;3.0;IMAGING;**11,30,51,50,54,49,138,156,180,305**;Mar 19, 2002;Build 3
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
LOOKUP(OUT,NUMBER) ; RPC = MAG DICOM LOOKUP STUDY
 ; Look Up for Radiology, Consults, and Lab (anatomic pathology)
 N ACNUMB ;--- Accession Number
 N CPTCODE ;-- CPT code for the procedure
 N CPTNAME ;-- CPT name for the procedure
 N DFN ;------ Patient pointer
 N EXAMSTS ;-- Exam status (don't post images to CANCELLED exams)
 N EXAMTYPE ;- Type of exam (Rad,Con, or Lab)
 N GMRCIEN ;-- Pointer for GMRC
 N INFO ;----- return array from $$ACCRPT^RAAPI()
 N PROCIEN ;-- Radiology procedure IEN in ^RAMIS(71)
 N RAA ;------ Radiology array (for $$ACCFIND)
 N RAIX ;----- cross reference subscript for case number lookup
 N RADFN ;---- first level subscript in ^RADPT
 N RADTI ;---- second level subscript in ^RADPT (after "DT")
 N RACNI ;---- third level subscript in ^RADPT (after "P")
 N RARPT ;---- Radiology Report pointer
 N I,LIST,NOUT,X,Y,Z
 ;
 K OUT S NOUT=1
 I $G(NUMBER)="" S OUT(1)="-1,No Case or Consult Number Specified" Q
 I $E(NUMBER,2)="`" D  Q
 . ; lookup the image by the IEN
 . D IENLOOK^MAGDRPC9
 . Q
 ;
 S EXAMTYPE=$E(NUMBER,1)
 I "RCL"[EXAMTYPE S NUMBER=$E(NUMBER,2,$L(NUMBER))
 E  S OUT(1)="-2,Need to specify Radiology, Consults, or Lab" Q
 K DFN
 I EXAMTYPE="R" D
 . D RADLKUP(.NOUT,.OUT,.ACNUMB,NUMBER) ; radiology lookup
 . Q
 E  I EXAMTYPE="C" D
 . D CONLKUP(.NOUT,.OUT,.ACNUMB,NUMBER) ; CPRS consult/procedure lookup
 . Q
 E  D
 . D LABLKUP(.NOUT,.OUT,.ACNUMB,NUMBER) ; anatomic pathology lab lookup
 . Q
 ;
 D NEWLKUP^MAGDRPCD(.NOUT,.OUT,ACNUMB) ; check if there are any DICOM objects in the new SOP Class database
 ;
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q
 ;
RADLKUP(NOUT,OUT,ACNUMB,NUMBER) ; Radiology lookup
 S ACNUMB=""
 S RACNI=0 ; must get this value to find study
 I NUMBER?1N.N D  I 'RACNI S OUT(1)="-14,Radiology case number not on file" Q
 . ; Look for the patient/study in ^RADPT using the Radiology Case Number
 . N RAIX ;----- cross reference subscript for case number lookup 
 . S RAIX=$S($D(^RADPT("C")):"C",1:"AE") ; for Radiology Patch RA*5*7
 . S RAIX=$S(NUMBER["-":"ADC",1:RAIX) ; select the cross-reference
 . S RADFN=$O(^RADPT(RAIX,NUMBER,"")) Q:'RADFN
 . S RADTI=$O(^RADPT(RAIX,NUMBER,RADFN,""))
 . S RACNI=$O(^RADPT(RAIX,NUMBER,RADFN,RADTI,""))
 . Q
 E  D  I 'RACNI S OUT(1)="-15,Radiology accession number not on file" Q
 . ; lookup using Radiololgy Package API 
 . S X=$$ACCFIND^RAAPI(NUMBER,.RAA)
 . I X<0 Q
 . S Y=RAA(1)
 . S RADFN=$P(Y,"^",1),RADTI=$P(Y,"^",2),RACNI=$P(Y,"^",3)
 . Q
 I '$D(^RADPT(RADFN,0)) S OUT(1)="-12,No patient demographics file pointer" Q
 S DFN=$P(^RADPT(RADFN,0),"^",1)
 I '$G(DFN) S OUT(1)="-13,Radiology exam not on file" Q
 S EXAMSTS=$P($G(^RADPT(DFN,"DT",RADTI,"P",RACNI,0)),"^",3)
 I 'EXAMSTS S OUT(1)="-16,Radiology EXAM STATUS field not present" Q
 I $$GET1^DIQ(72,EXAMSTS,3)=0  S OUT(1)="-17,Radiology exam cancelled" Q
 D:$D(^RADPT(DFN,"DT",RADTI,0))  ; p305 PMK 03/30/2021
 . S RARPT=$P($G(^RADPT(DFN,"DT",RADTI,"P",RACNI,0)),"^",17) Q:'RARPT
 . S X=$$ACCRPT^RAAPI(RARPT,.INFO)
 . I X<0 S OUT(1)="-11,Radiology Problem: "_X Q
 . S ACNUMB=INFO(1)
 . S I=0 F  S I=$O(^RARPT(RARPT,2005,I)) Q:'I  D
 . . S X="74^"_RARPT_"^"_$P($G(^RARPT(RARPT,2005,I,0)),"^",1)_"^"_ACNUMB
 . . S NOUT=NOUT+1,OUT(NOUT)=X
 . . Q
 . Q
 Q
 ;
CONLKUP(NOUT,OUT,ACNUMB,NUMBER) ; CPRS Consult/Procedure study lookup
 N MAGIEN,MAGPTR,REPORTF,REPORTI,TIUIEN,TIUPTR,TIUXIEN,X
 S X=$$GMRCIEN^MAGDFCNV(NUMBER) S GMRCIEN=$S(X:X,1:NUMBER)
 S ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN)
 D
 . S DFN=$$GET1^DIQ(123,GMRCIEN,.02,"I") Q:'DFN
 . S EXAMSTS=$$GET1^DIQ(123,GMRCIEN,8,"I") ; check acceptable status
 . ; EXAMSTS=2 for COMPLETE, 5=PENDING, 6=ACTIVE, 8=SCHEDULED, STATUS=9 for PARTIAL RESULTS
 . I EXAMSTS'=2,EXAMSTS'=5,EXAMSTS'=6,EXAMSTS'=8,EXAMSTS'=9 D  Q
 . . S EXAMSTS=$$GET1^DIQ(123,GMRCIEN,8,"E") ; get name of status
 . . S OUT(1)="-4,Consult is "_EXAMSTS Q
 . . Q
 . Q
 I $D(OUT(1)) Q  ; bad EXAMSTS
 I '$G(DFN) S OUT(1)="-5,Consult/procedure not on file" Q
 ; Find the images - they can be linked to TIU or imaging file 2006.5839
 S MAGPTR=0 ; find in ^MAG(2006.5839) - may not be in ^TIU yet
 F  S MAGPTR=$O(^MAG(2006.5839,"C",123,GMRCIEN,MAGPTR)) Q:'MAGPTR  D
 . S X=^MAG(2006.5839,MAGPTR,0)
 . S X=$P(X,"^",1)_"^"_$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_ACNUMB
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 ; also try to find images in ^TIU
 N I,RESULT,X
 D TIUALL^MAGDGMRC(GMRCIEN,.RESULT)
 S I="" F  S I=$O(RESULT(I)) Q:I=""  D
 . S X="8925^"_$P(RESULT(I),"^",1)_"^"_$P(RESULT(I),"^",3)_"^"_$P(RESULT(I),"^",2)
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 Q
 ;
LABLKUP(NOUT,OUT,ACNUMB,NUMBER) ; Lab (Anatomic Pathology) study lookup
 N DFN,FILEDATA,LRDFN,LRI,LRSS,MAGIEN,MAGPTR,PARENTFILE,TIUIEN,TIUXIEN,X
 S ACNUMB=NUMBER D LABLKUP^MAGDIR8A
 I '$G(DFN) S OUT(1)="-6,Anatomic Pathology case not on file" Q
 D SUBFILES^MAGDIR9F(LRSS)
 ; Find the images - they can be linked to TIU or imaging file 2006.5838
 S MAGPTR=$O(^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,0))
 I MAGPTR D  Q  ; Found it in ^MAG(2006.5838) - not in ^TIU yet
 . S X=^MAG(2006.5838,MAGPTR,0)
 . ; separate the two subscripts that point to the study with a comma
 . S X=$P(X,"^",1)_"^"_$P(X,"^",2)_","_$P(X,"^",3)_"^"_$P(X,"^",4)_"^"_ACNUMB
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 D  ; Otherwise find images in ^TIU
 . S TIUIEN=$$TIUIEN^MAGT7MA(LRSS,LRDFN,LRI)
 . I TIUIEN D
 . . S TIUXIEN=$O(^TIU(8925.91,"B",TIUIEN,""))
 . . I TIUXIEN D
 . . . S MAGIEN=$$GET1^DIQ(8925.91,TIUXIEN,.02,"I")
 . . . S X="8925^"_TIUIEN_"^"_MAGIEN_"^"_ACNUMB
 . . . S NOUT=NOUT+1,OUT(NOUT)=X
 . . . Q
 . . Q
 . Q
 Q
 ;
NEXTIMG(OUT,FROMS,ONLYCHECK,SENT) ; RPC = MAG DICOM GET NEXT QUEUE ENTRY
 ; Get next file to be DICOM transmitted
 N D0,D1,F1,F2,F3,FAILTIME,FROM,GROUP,I,JBTOHD,LOC,N,PRIORITY,SITE,STATE,TYPE,X,XMITTIME
 N ARTIFACTIX,ARTIFACTINSTIX,DFN,DISKVOLUME,FILEPATH,PHYSICALREF,STUDYIX
 S X=$G(FROMS) S:X FROM(X)=1
 S I="" F  S I=$O(FROMS(I)) Q:I=""  S X=$P($G(FROMS(I)),"^",1) S:X FROM(X)=1
 I '$O(FROM("")) S OUT(1)="-1,No Origin Specified" Q
 ;
 L +^MAGDOUTP(2006.574):1E9 ; P305 PMK 09/23/2021 - Lock entire global, RPC MUST wait
 ;
 ; First clean up transmitted queue entries
 S I="" F  S I=$O(SENT(I)) Q:I=""  D CLEAN
 S SITE=$O(^MAG(2006.1,"B",DUZ(2),"")) ; parameters are defined for the sending site
 S XMITTIME=$$GET1^DIQ(2006.1,SITE,208)
 S FAILTIME=$$GET1^DIQ(2006.1,SITE,209)
 S H=$$SECOND($H)
 ;
 ; ONLYCHECK=1 for batch export (^MAGDIWBE) but 0 for a transmission process (^MAGDIWB2)
 I 'ONLYCHECK D  ; do only when called from a transmission process, not batch export
 . ; check for DICOM objects stuck in XMIT state or that previously failed to be transmitted
 . S FROM="" F  S FROM=$O(FROM(FROM)) Q:FROM=""  D
 . . S PRIORITY="" F  S PRIORITY=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY)) Q:PRIORITY=""  D
 . . . D RETRYXMT(FROM,PRIORITY,"XMIT",XMITTIME,0) ; XMIT is disabled by default
 . . . D RETRYXMT(FROM,PRIORITY,"FAIL",FAILTIME,300) ; default for FAIL is 5 minutes
 . . . Q
 . . Q
 . Q
 ;
 ; Find the highest priority among the selected FROM locations
 S FROM="" F  S FROM=$O(FROM(FROM)) Q:FROM=""  D
 . S PRIORITY="" F  S PRIORITY=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY)) Q:PRIORITY=""  D
 . . S X=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,"WAITING","")) S:X PRIORITY(PRIORITY,FROM)=""
 . . Q
 . Q
 K OUT S OUT(1)="",PRIORITY=$O(PRIORITY(""),-1) D:PRIORITY'=""
 . S FROM=$O(PRIORITY(PRIORITY,""))
 . S D0="" F  S D0=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,"WAITING",D0)) Q:D0=""  D  Q:OUT(1)'=""
 . . S D1="" F  S D1=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,"WAITING",D0,D1)) Q:D1=""  D  Q:OUT(1)'=""
 . . . ; ONLYCHECK=1 for batch export; ONLYCHECK=0 for a transmission process 
 . . . I 'ONLYCHECK D  ; do only when called from a transmission process, not batch export
 . . . . S $P(^MAGDOUTP(2006.574,D0,1,D1,0),"^",2,3)="XMIT^"_$H
 . . . . K ^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,"WAITING",D0,D1)
 . . . . S ^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,"XMIT",D0,D1)=""
 . . . . Q
 . . . S OUT(1)=1
 . . . S OUT(2)=D0
 . . . S OUT(3)=D1
 . . . S X=$G(^MAGDOUTP(2006.574,D0,0))
 . . . S OUT(4)=$P(X,"^",1) ; Application
 . . . S (OUT(5),GROUP)=$P(X,"^",2) ; Group
 . . . S (ACNUMB,OUT(6))=$P(X,"^",3) ; Accession Number
 . . . S JBTOHD=+$P(X,"^",6)
 . . . S OUT(7)=$P(^MAGDOUTP(2006.574,D0,1,D1,0),"^",1) ; Image IEN or Artifact IEN
 . . . I GROUP="New SOP Class DB" D
 . . . . S ARTIFACTIX=OUT(7) ; ARTIFACT file (#2006.916) IEN
 . . . . S OUT(8)=GROUP ; no legacy Object Type (2005 field 3)
 . . . . ; get DFN from IMAGE STUDY file (#2005.62) and IMAGING PATIENT REFERENCE file (#2005.61)
 . . . . S STUDYIX=$O(^MAGV(2005.62,"D",ACNUMB,"")) ; get IMAGE STUDY pointer
 . . . . S DFN=$$GET1^DIQ(2005.62,STUDYIX,13,"E") ; get IMAGING PATIENT REFERENCE (DFN)
 . . . . ; there may be multiple artifact instances - use the first one
 . . . . ; could check the NETWORK LOCATION file (2005.2) STORAGE TYPE = "TIER 1"
 . . . . S ARTIFACTINSTIX=$O(^MAGV(2006.918,"B",ARTIFACTIX,"")) ; get first Artifact Instance pointer
 . . . . S F1=$$UP^MAGDFCNV($$GET1^DIQ(2006.918,ARTIFACTINSTIX,6)) ; FILEREF (filename)
 . . . . S DISKVOLUME=$$GET1^DIQ(2006.918,ARTIFACTINSTIX,7,"I") ; DISK VOLUME
 . . . . S PHYSICALREF=$$GET1^DIQ(2005.2,DISKVOLUME,1) ; PHYSICAL REFERENCE
 . . . . S FILEPATH=$$GET1^DIQ(2006.918,ARTIFACTINSTIX,8) ; FILEPATH
 . . . . S (F2,F3)=PHYSICALREF_FILEPATH_F1
 . . . . Q
 . . . E  D
 . . . . S IMAGEIEN=OUT(7)
 . . . . S OUT(8)=$P($G(^MAG(2005,IMAGEIEN,0)),"^",6) ; Object Type
 . . . . S TYPE=$S($G(^MAG(2005,IMAGEIEN,"FBIG"))'="":"BIG",1:"FULL")
 . . . . ; 3rd parameter set to 1 to allow retrieval from jukebox
 . . . . D FILEFIND^MAGDFB(IMAGEIEN,TYPE,1,0,.F1,.F2)
 . . . . S DFN=$P($G(^MAG(2005,+OUT(7),0)),"^",7) ; P156 DAC - get DFN from image (not group)
 . . . . ; get path for *.TXT, always the same as the FULL file
 . . . . D FILEFIND^MAGDFB(IMAGEIEN,"FULL",JBTOHD,0,.F1,.F3)
 . . . . Q
 . . . S OUT(9)=F1 ; file name
 . . . S OUT(10)=F2 ; full file path
 . . . S OUT(11)=DFN
 . . . S OUT(12)=F3 ; full file path
 . . . S X=$G(^MAGDOUTP(2006.574,D0,1,0))
 . . . S OUT(13)=$P(X,"^",4) ; Object count
 . . . Q
 . . Q
 . Q
 I OUT(1)="" D
 . S OUT(1)="-2,Nothing to be transmitted."
 . D CLEANUP
 . Q
 L -^MAGDOUTP(2006.574) ; P180 DAC - Unlock global
 Q
 ;
RETRYXMT(FROM,PRIORITY,OLDSTATE,TIMEOUT,DEFAULTTIMEOUT) ; retry transmission
 ; move images from XMIT or FAIL state to WAITING state
 N D0,D1,H,X
 ;
 I TIMEOUT="" S TIMEOUT=DEFAULTTIMEOUT ; XMIT/FAIL timeout not defined
 ;
 I TIMEOUT=0 Q  ; retransmission is disabled
 ;
 S H=$$SECOND($H)
 S D0="" F  S D0=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,OLDSTATE,D0)) Q:D0=""  D
 . S D1="" F  S D1=$O(^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,OLDSTATE,D0,D1)) Q:D1=""  D
 . . S X=$$SECOND($P($G(^MAGDOUTP(2006.574,D0,1,D1,0),"^^"_$H),"^",3))
 . . Q:H-X<TIMEOUT
 . . S $P(^MAGDOUTP(2006.574,D0,1,D1,0),"^",2)="WAITING"
 . . K ^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,OLDSTATE,D0,D1)
 . . S ^MAGDOUTP(2006.574,"STATE",FROM,PRIORITY,"WAITING",D0,D1)=""
 . . Q
 . Q
 Q
 ;
CLEANUP ; remove old studies
 N D0,D1,I,REQUESTDATETIME,SENT
 S REQUESTDATETIME=$$FMADD^XLFDT($$NOW^XLFDT,-15,0,0,0) ; delete anything 15 days older or older
 F  S REQUESTDATETIME=$O(^MAGDOUTP(2006.574,"C",REQUESTDATETIME),-1) Q:REQUESTDATETIME=""  D
 . S D0="" F  S D0=$O(^MAGDOUTP(2006.574,"C",REQUESTDATETIME,D0)) Q:D0=""  D
 . . S D1=0 F  S D1=$O(^MAGDOUTP(2006.574,D0,1,D1)) Q:D1=""  D
 . . . S I=1,SENT(1)=D0_"^"_D1_"^" D CLEAN ; STATE=<null>
 . . . Q
 . . Q
 . Q
 Q
 ;
CLEAN ; remove one image entry from the queue
 N D0,D1,REQUESTDATETIME,STUID,PRIORITY,STATE,NEWSTATE ; P305 PMK 09/29/2021
 S D0=$P(SENT(I),"^",1),D1=$P(SENT(I),"^",2),NEWSTATE=$P(SENT(I),"^",3)
 Q:'$D(^MAGDOUTP(2006.574,D0,1,D1))
 ;
 S X=$G(^MAGDOUTP(2006.574,D0,0)),LOC=$P(X,"^",4),PRIORITY=+$P(X,"^",5)
 S REQUESTDATETIME=$P(X,"^",7)
 S STATE=$P($G(^MAGDOUTP(2006.574,D0,1,D1,0)),"^",2)
 ;
 I NEWSTATE'="" D  Q  ; just update the status and get out
 . S $P(^MAGDOUTP(2006.574,D0,1,D1,0),"^",2)=NEWSTATE,$P(^(0),"^",3)=$H
 . ; remove the old xref before setting the new one - P305 PMK 09/29/2021
 . I LOC'="",PRIORITY'="",STATE'="" K ^MAGDOUTP(2006.574,"STATE",LOC,PRIORITY,STATE,D0,D1)
 . I LOC'="",PRIORITY'="" S ^MAGDOUTP(2006.574,"STATE",LOC,PRIORITY,NEWSTATE,D0,D1)=""
 . Q
 ;
 K ^MAGDOUTP(2006.574,D0,1,D1)
 I LOC'="",PRIORITY'="",STATE'="" K ^MAGDOUTP(2006.574,"STATE",LOC,PRIORITY,STATE,D0,D1)
 S X=$G(^MAGDOUTP(2006.574,D0,1,0))
 S $P(X,"^",4)=$P(X,"^",4)-1
 S ^MAGDOUTP(2006.574,D0,1,0)=X
 ;
 Q:$O(^MAGDOUTP(2006.574,D0,1,0))  ; don't delete the study node yet
 ;
 S STUID=$G(^MAGDOUTP(2006.574,D0,2))
 K ^MAGDOUTP(2006.574,D0)
 K:REQUESTDATETIME'="" ^MAGDOUTP(2006.574,"C",REQUESTDATETIME,D0)
 K:STUID'="" ^MAGDOUTP(2006.574,"STUDY",STUID)
 S X=$G(^MAGDOUTP(2006.574,0))
 S $P(X,"^",4)=$P(X,"^",4)-1
 S ^MAGDOUTP(2006.574,0)=X
 Q
 ;
FIND(DATE,CASE,NUM) ;
 ; Use the ADC x-reference in the radiology patient file
 N NDATE
 S NDATE=$$FMADD^XLFDT(DATE,NUM) Q:NDATE<1 0
 Q $O(^RADPT("ADC",$$MMDDYY(NDATE)_"-"_CASE,""))
 ;
MMDDYY(DAY) ; Convert Fileman date to mmddyy
 I DAY'?7N Q 0
 Q $E(DAY,4,7)_$E(DAY,2,3)
 ;
SECOND(H) Q H*86400+$P(H,",",2)
 ;

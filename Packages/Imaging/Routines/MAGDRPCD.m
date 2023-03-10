MAGDRPCD ;WOIFO/PMK - Imaging RPCs ; Apr 20, 2022@12:51:24
 ;;3.0;IMAGING;**305**;Mar 19, 2002;Build 3
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
 ; New SOP Class database reference routine: MAGNVQ03
 ;
 ; Called by QUEUE^MAGDRPC3 for exporting objects from the new SOP Class database
 ; QUEUE^MAGDRPC3 is invoked by RPC = MAG DICOM QUEUE IMAGE
 ;
QUEUE(OUT,IMAGE,APPNAM,LOCATION,ACNUMB,REASON,EMAIL,PRIORITY,JBTOHD) ; Called by QUEUE^MAGDRPC3
 ; Add the DICOM study send image request to the queue
 N ARTIFACTIX,COUNT,D0,D1,DFN,LOG,OK,PROBLEM,PROCIX,REQUESTDATETIME,STUDYIX,STUDYUID,TYPE,X
 N NSCRATCH,SCRATCH ; temporary scratch array
 ;
 I $G(APPNAM)="" S OUT="-2,No Destination specified" Q
 I '$G(LOCATION) S OUT="-3,No Origin specified" Q
 I $G(ACNUMB)="" S OUT="-4,No Accession Number - Required for new SOP Class objects" Q
 ;
 Q:$D(OUT)  ; problem with accesion number lookup
 ;
 S PRIORITY=+$G(PRIORITY) S:'PRIORITY PRIORITY=500
 S JBTOHD=$S($G(JBTOHD):1,1:0)
 ;
 S NSCRATCH=1
 ;
 D NEWLKUP(.NSCRATCH,.SCRATCH,ACNUMB) ; get procedure variables from new SOP Class database
 S PROCIX=$P($G(SCRATCH(2)),"^",2)
 I PROCIX="" S OUT="-5,No new SOP Class Procedure Index" Q
 ;
 D NEWSOPAI(.NSCRATCH,.SCRATCH,PROCIX) ; get study & series variables from new SOP Class database
 S STUDYIX=$P($G(SCRATCH(3)),"^",2)
 I STUDYIX="" S OUT="-6,No new SOP Class Study Indes" Q
 ;
 S STUDYUID=$P($G(^MAGV(2005.62,STUDYIX,0),"?"),"^",1)
 ;
 L +^MAGDOUTP(2006.574):1E9 ; P180 DAC - Lock global, background process MUST wait
 S OK=0,D0="" F  S D0=$O(^MAGDOUTP(2006.574,"STUDY",STUDYUID,"NEW",D0)) Q:'D0  D  Q:OK
 . Q:'$D(^MAGDOUTP(2006.574,"STATE",LOCATION,PRIORITY,"WAITING",D0))
 . Q:$P($G(^MAGDOUTP(2006.574,D0,0)),"^",1)'=APPNAM
 . S OK=D0
 . Q
 S D0=OK
 ;
 I D0 S OUT=D0 ; return the existing pointer to the DICOM OBJECT EXPORT (file #2006.574) queue
 E  D  ; get the next pointer to the queue
 . S X=$G(^MAGDOUTP(2006.574,0))
 . S $P(X,"^",1,2)="DICOM OBJECT EXPORT^2006.574"
 . S D0=$O(^MAGDOUTP(2006.574," "),-1)+1 ; Next number
 . S $P(X,"^",3)=D0
 . S $P(X,"^",4)=$P(X,"^",4)+1 ; Total count
 . S ^MAGDOUTP(2006.574,0)=X
 . ;
 . S REQUESTDATETIME=$$NOW^XLFDT
 . S ^MAGDOUTP(2006.574,D0,0)=APPNAM_"^New SOP Class DB^"_ACNUMB_"^"_LOCATION_"^"_PRIORITY_"^"_JBTOHD_"^"_REQUESTDATETIME_"^NEW"
 . S ^MAGDOUTP(2006.574,"C",REQUESTDATETIME,D0)="" ; cross reference to delete old studies
 . S ^MAGDOUTP(2006.574,D0,2)=STUDYUID
 . S ^MAGDOUTP(2006.574,"STUDY",STUDYUID,"NEW",D0)=""
 . S ^MAGDOUTP(2006.574,"D",ACNUMB,D0)="" ; P305 PMK 03/22/2021
 . ;
 . S OUT=D0 ; return a pointer to the DICOM OBJECT EXPORT (file #2006.574) queue
 . ;
 . Q
 L -^MAGDOUTP(2006.574)
 ;
 S COUNT=0,PROBLEM=3
 ; 
 ; Process all the DICOM objects
 ; 
 S D1=0 F  S D1=$O(SCRATCH(D1)) Q:'D1  D
 . S X=SCRATCH(D1),FILENUMBER=$P(X,"^",1)
 . I FILENUMBER=2005.61 D  Q
 . . S DFN=$P(X,"^",5) ; get DFN from the 2005.61 record
 . . Q
 . I FILENUMBER'=2005.65 Q  ; not an image node
 . S ARTIFACTIX=$P(X,"^",4) ; pointer to ARTIFACT file (#2006.916)
 . S COUNT=COUNT+$$ENQUEUE^MAGDRPC3(ARTIFACTIX,D0,PRIORITY,1) ; ARG-4 NEWSOPCLASS=1
 . Q
 ;
 S LOG="DICOM transmit to "_APPNAM_" for reason "_REASON
 ; 3rd argument is the new SOP Class database accession number
 D:COUNT ENTRY^MAGLOG($C(REASON+64),DUZ,"New SOP Class DB: "_ACNUMB,"DICOM Gateway",DFN,COUNT,LOG)
 D:PROBLEM>3
 . N XMERR,XMID,XMSUB,XMY,XMZ
 . S PROBLEM(1)="Error while queueing image for Transmission:"
 . S PROBLEM(2)=LOG
 . S PROBLEM(3)=" "
 . ; --- send MailMan message...
 . S XMID=$G(DUZ) S:'XMID XMID=.5
 . S XMY(XMID)=""
 . S:$G(EMAIL)'="" XMY(EMAIL)=""
 . S XMSUB=$E("Cannot transmit image(s) to "_APPNAM,1,63)
 . D SENDMSG^XMXAPI(XMID,XMSUB,"PROBLEM",.XMY,,.XMZ,)
 . Q:'$G(XMERR)
 . M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 . Q
 Q
 ;
NEWLKUP(NOUT,OUT,ACNUMB) ; lookup study in P34 database for the new SOP Classes
 ; Invoked from MAGDRPC4 for RPC = MAG DICOM LOOKUP STUDY
 ; Rules:
 ; 1) the Attribute On File field is not checked at all.
 ; 2) for the Procedure Reference file (#2005.61), there has to be a pointer to the Patient
 ;    Reference file (#2005.6) and the patient id type in file #2005.6 needs to be "DFN".
 ; Rules 1 and 2 are from the logic in ADD1STD^MAGDQR74
 ;  
 N DFN,PROCREFDATA6,PATREFIX,PROCIX,MAGD0,X
 I $G(ACNUMB)="" Q  ; invoked without an accession number
 ;
 S PROCIX="" ; procedure level indexed by accession number
 F  S PROCIX=$O(^MAGV(2005.61,"B",ACNUMB,PROCIX)) Q:'PROCIX  D
 . I $$PROBLEM61^MAGDSTA8(PROCIX) Q  ; patient not available - quit
 . S PROCREFDATA6=$G(^MAGV(2005.61,PROCIX,6))
 . S PATREFIX=$P(PROCREFDATA6,"^",1)
 . S PATREFDATA=$G(^MAGV(2005.6,PATREFIX,0))
 . S DFN=$P(PATREFDATA,"^",1)
 . S X="2005.61^"_PROCIX_"^New SOP Class DB^"_ACNUMB_"^"_DFN ; 3rd piece is a flag
 . S X=X_"^"_$$GET1^DIQ(2005.61,PROCIX,1) ; get procedure date/time
 . S X=X_"^"_$$GET1^DIQ(2005.61,PROCIX,40) ; get package index
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 Q
 ;
NEWSOPAI(NOUT,OUT,PROCIX) ; get artifact instances
 ; Rules:
 ; 1) for the Image Study file (#2005.62), the study must be "accessible"
 ; 2) for the Image Series file (#2006.63), the series must be  "accessible"
 ; 3) for the SOP Instance file ("2006.64), the SOP instance must be "accessible"
 ;
 ; Rules 3 is from the logic in ADD1STD^MAGDQR74
 ; Rules 2 and 3 are from the logic in STYSERKT^MAGVD010
 ;
 N ARTIFACTIX,DELETED,IMAGEIX,INACCESSIBLE
 N STATUS,STUDYIX,SERIESIX,SOPIX,TOKEN,X
 S STUDYIX="" ; study level
 F  S STUDYIX=$O(^MAGV(2005.62,"C",PROCIX,STUDYIX)) Q:'STUDYIX  D
 . I $$PROBLEM62^MAGDSTA8(STUDYIX) Q  ; study not available - quit
 . S X="2005.62^"_STUDYIX_"^"_$$GET1^DIQ(2005.62,STUDYIX,14) ; description
 . S X=X_"^"_$$GET1^DIQ(2005.62,STUDYIX,7) ; number of series
 . S X=X_"^"_$$GET1^DIQ(2005.62,STUDYIX,20) ; number of SOP instances
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . S SERIESIX="" ; series level
 . F  S SERIESIX=$O(^MAGV(2005.63,"C",STUDYIX,SERIESIX)) Q:'SERIESIX  D
 . . I $$PROBLEM63^MAGDSTA8(SERIESIX) ; series not available - quit
 . . S X="2005.63^"_SERIESIX_"^"_$$GET1^DIQ(2005.63,SERIESIX,3) ; modality
 . . S X=X_"^"_$$GET1^DIQ(2005.63,SERIESIX,31) ; acquisition location 
 . . S X=X_"^"_$$GET1^DIQ(2005.63,SERIESIX,14) ; series description
 . . S X=X_"^"_$$GET1^DIQ(2005.63,SERIESIX,20) ; laterality
 . . S X=X_"^"_$$GET1^DIQ(2005.63,SERIESIX,18) ; acquisition device
 . . S X=X_"^"_$$GET1^DIQ(2005.63,SERIESIX,7) ; number of SOP instances
 . . S NOUT=NOUT+1,OUT(NOUT)=X
 . . S SOPIX="" ; sop instance level
 . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIESIX,SOPIX)) Q:'SOPIX  D
 . . . I $$PROBLEM64^MAGDSTA8(SOPIX) Q  ; sop instance not available - quit
 . . . S IMAGEIX=""
 . . . F  S IMAGEIX=$O(^MAGV(2005.65,"C",SOPIX,IMAGEIX)) Q:'IMAGEIX  D
 . . . . I $$PROBLEM65^MAGDSTA8(IMAGEIX) Q  ; image not available - quit
 . . . . S X=$G(^MAGV(2005.65,IMAGEIX,0))
 . . . . S ARTIFACTIX=$P(X,"^",2)
 . . . . S X="2005.65^"_SOPIX_"^"_IMAGEIX_"^"_ARTIFACTIX
 . . . . S NOUT=NOUT+1,OUT(NOUT)=X
 . . . . Q
 . . . Q
 . . Q
 . Q
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q
 ;
 ;
 ;
NEWSOPDB(OUT,PROCIX) ; RPC = MAG DICOM NEW SOP DB LOOKUP
 N NOUT
 K OUT S NOUT=1
 D NEWSOPAI(.NOUT,.OUT,PROCIX)
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q

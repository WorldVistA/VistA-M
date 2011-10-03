MAGDRPC3 ;WOIFO/EdM - Imaging RPCs ; 05/18/2007 11:23
 ;;3.0;IMAGING;**11,30,51,50,85,54**;03-July-2009;;Build 1424
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
RADLKUP(OUT,CASENUMB,STUDYDAT) ; RPC = MAG DICOM LOOKUP RAD STUDY
 ; Radiology patient/study lookup
 N ACCNUM ;--- Accession Number
 N CPTCODE ;-- CPT code for the procedure
 N CPTNAME ;-- CPT name for the procedure
 N DATETIME ;- Timestamp
 N EXAMSTS ;-- Exam status (don't post images to CANCELLED exams)
 N PROCDESC ;- Procedure description
 N PROCIEN ;-- radiology procedure ien in ^RAMIS(71)
 N RAIX ;----- cross reference subscript for case number lookup
 N RADPT1 ;--- first level subscript in ^RADPT
 N RADPT2 ;--- second level subscript in ^RADPT (after "DT")
 N RADPT3 ;--- third level subscript in ^RADPT (after "P")
 N D1,I,LIST,X,Z
 ;
 ; find the patient/study in ^RADPT using the Radiology Case Number
 K OUT
 D
 . I $G(CASENUMB)="" S OUT(1)="-1,No Case Number Specified" Q
 . S RAIX=$S($D(^RADPT("C")):"C",1:"AE") ; for Radiology Patch RA*5*7
 . S RAIX=$S(CASENUMB["-":"ADC",1:RAIX) ; select the cross-reference
 . S RADPT1=$O(^RADPT(RAIX,CASENUMB,"")) I 'RADPT1 D  Q:'RADPT1
 . . I '$G(STUDYDAT) S OUT(1)="-2,No Study Date Specified",RADPT1=0 Q
 . . ;
 . . ; Search 1-3 days prior the study date OR a day in advance but only
 . . ; if the study date is not equal to today or greater than today.
 . . ; Has to be long case number or must have an image study date
 . . ;
 . . N II,RCASE,SDATE,TODAY,X,Y
 . . ;
 . . S RCASE=$S(CASENUMB["-":$P(CASENUMB,"-",2),1:CASENUMB)
 . . I 'RCASE S RADPT1=0 Q
 . . ;
 . . S TODAY=$$NOW^XLFDT()\1
 . . S X=$P(STUDYDAT,"."),SDATE=$E(X,1,4)-1700_$E(X,5,8) ; FileMan date
 . . ;
 . . ; 1-3 days prior study date
 . . F II=1:1:3 S RADPT1=$$FIND(SDATE,RCASE,-II) Q:RADPT1
 . . Q:RADPT1
 . . ;
 . . ; Wild goose chase, but check for today's case
 . . S RADPT1=$O(^RADPT("ADC",$$MMDDYY(TODAY)_"-"_RCASE,"")) Q:RADPT1
 . . ;
 . . I SDATE'<TODAY S RADPT1=0 Q
 . . ;
 . . ; One day in advance?
 . . S RADPT1=$$FIND(SDATE,RCASE,1) Q:RADPT1
 . . ;
 . . ; Finally just check the "C" or "AE" x-reference for the case number
 . . S X=$S($O(^RADPT("C","")):"C",1:"AE") ; RA*5*7 patch
 . . S RADPT1=$O(^RADPT(X,RCASE,""))
 . . Q
 . S RADPT2=$O(^RADPT(RAIX,CASENUMB,RADPT1,"")) Q:'RADPT2
 . S RADPT3=$O(^RADPT(RAIX,CASENUMB,RADPT1,RADPT2,"")) Q:'RADPT3
 . Q:'$D(^RADPT(RADPT1,0))  ; no patient demographics file pointer
 . ; get patient demographics file pointer
 . S DFN=$P(^RADPT(RADPT1,0),"^",1)
 . Q:'$D(^RADPT(RADPT1,"DT",RADPT2,0))  ; no datetime level
 . ; get date and time of examination
 . S DATETIME=$P($G(^RADPT(RADPT1,"DT",RADPT2,0)),"^",1)
 . ; get case info
 . S X=$G(^RADPT(RADPT1,"DT",RADPT2,"P",RADPT3,0))
 . S Z=$P(X,"^",17) I Z S Z=$P($G(^RARPT(Z,0)),"^",1) S:Z'="" ACCNUM=Z
 . S PROCIEN=$P(X,"^",2),EXAMSTS=$P(X,"^",3)
 . S:EXAMSTS EXAMSTS=$$GET1^DIQ(72,EXAMSTS,.01)
 . S (PROCDESC,CPTNAME,CPTCODE)=""
 . Q:'PROCIEN  ; need PROCIEN to do lookup in ^RAMIS
 . S Z=$G(^RAMIS(71,PROCIEN,0))
 . S PROCDESC=$P(Z,"^",1),CPTCODE=$P(Z,"^",9)
 . S CPTNAME=$P($$CPT^ICPTCOD(+CPTCODE),"^",3) ; IA 1995
 . S:CPTNAME="" CPTNAME=PROCDESC
 . Q
 S OUT(2)=$G(RADPT1)
 S OUT(3)=$G(RADPT2)
 S OUT(4)=$G(RADPT3)
 S OUT(5)=$G(PROCIEN)
 S OUT(6)=$G(CPTCODE)
 S OUT(7)=$G(CPTNAME)
 S OUT(8)=$G(Z)
 S OUT(9)=$G(EXAMSTS)
 S OUT(10)=$G(DFN)
 S OUT(11)=$G(DATETIME)
 S OUT(12)=$G(PROCDESC)
 S X=""
 I $G(PROCIEN) S D1=0 F  S D1=$O(^RAMIS(71,PROCIEN,"MDL",D1)) Q:'D1  D
 . S Z=+$P($G(^RAMIS(71,PROCIEN,"MDL",D1,0)),"^",1) Q:'Z
 . S Z=$P($G(^RAMIS(73.1,Z,0)),"^",1) Q:Z=""
 . S:X'="" X=X_"," S X=X_Z
 . Q
 S OUT(13)=X ; List of Modality-codes
 S X="" I $G(RADPT1),$G(RADPT2) S X=$G(^RADPT(RADPT1,"DT",RADPT2,0))
 S OUT(14)=$P(X,"^",3) ; Site
 ; Patient's pregnancy status at the time of the exam
 S X="" I $G(DFN),$G(RADPT2),$G(RADPT3) S X=$G(^RADPT(DFN,"DT",RADPT2,"P",RADPT3,0))
 S OUT(15)=$P($G(^RAO(75.1,+$P(X,"^",11),0)),"^",13)
 S OUT(16)=$G(ACCNUM)
 S OUT(1)=1 ; OK
 Q
 ;
QUEUE(OUT,IMAGE,APPNAM,LOCATION,ACCNUM,REASON,EMAIL,PRIOR,JBTOHD) ; RPC = MAG DICOM QUEUE IMAGE
 ; Add the DICOM study send image request to the queue
 N COUNT,D0,D1,DFN,LOG,OK,PROBLEM,TYPE,X
 ;
 I '$G(IMAGE) S OUT="-1,No Image specified" Q
 I $G(APPNAM)="" S OUT="-2,No Destination specified" Q
 I '$G(LOCATION) S OUT="-3,No Origin specified" Q
 S PRIOR=+$G(PRIOR) S:'PRIOR PRIOR=500
 S JBTOHD=$S($G(JBTOHD):1,1:0)
 ;
 S X=$G(^MAG(2005,IMAGE,0))
 S TYPE=+$P(X,"^",6),DFN=$P(X,"^",7)
 I " 0 11 3 100 "'[(" "_TYPE_" ") D  Q
 . S OUT="-4,Cannot Queue Image Object Type """_TYPE_"""."
 . Q
 ;
 L +^MAGDOUTP(2006.574,0):1E9 ; Background process MUST wait
 S P=$P($G(^MAG(2005,IMAGE,0)),"^",10),P=$S(P:P,1:IMAGE)
 S STUID=$P($G(^MAG(2005,P,"PACS")),"^",1) S:STUID="" STUID="?"
 S OK=0,D0="" F  S D0=$O(^MAGDOUTP(2006.574,"STUDY",STUID,D0)) Q:'D0  D  Q:OK
 . Q:'$D(^MAGDOUTP(2006.574,"STS",LOCATION,PRIOR,"WAITING",D0))
 . Q:$P($G(^MAGDOUTP(2006.574,D0,0)),"^",1)'=APPNAM
 . S OK=D0
 . Q
 S D0=OK D:'D0
 . S X=$G(^MAGDOUTP(2006.574,0))
 . S $P(X,"^",1,2)="DICOM IMAGE OUTPUT FILE^2006.574"
 . S D0=$O(^MAGDOUTP(2006.574," "),-1)+1 ; Next number
 . S $P(X,"^",3)=D0
 . S $P(X,"^",4)=$P(X,"^",4)+1 ; Total count
 . S ^MAGDOUTP(2006.574,0)=X
 . ;
 . S ^MAGDOUTP(2006.574,D0,0)=APPNAM_"^"_P_"^"_$G(ACCNUM)_"^"_LOCATION_"^"_PRIOR_"^"_JBTOHD
 . S ^MAGDOUTP(2006.574,D0,2)=STUID
 . S ^MAGDOUTP(2006.574,"STUDY",STUID,D0)=""
 . Q
 L -^MAGDOUTP(2006.574,0)
 ;
 S COUNT=0,PROBLEM=3
 I (TYPE=3)!(TYPE=100) D  ; Single XRAY or DICOM image
 . S COUNT=COUNT+$$ENQUEUE(IMAGE,D0,PRIOR)
 . Q
 I TYPE=11 D  ; Process all the images in an XRAY group
 . S D1=0 F  S D1=$O(^MAG(2005,IMAGE,1,D1)) Q:'D1  D
 . . S COUNT=COUNT+$$ENQUEUE($P($G(^MAG(2005,IMAGE,1,D1,0)),"^",1),D0,PRIOR)
 . . Q
 . Q
 ;
 S LOG="DICOM transmit to "_APPNAM_" for reason "_REASON
 D:COUNT ENTRY^MAGLOG($C(REASON+64),DUZ,IMAGE,"DICOM Gateway",DFN,COUNT,LOG)
 D:PROBLEM>3
 . N XMERR,XMID,XMSUB,XMY
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
 S OUT=1
 Q
 ;
ENQUEUE(IMAGE,D0,PRIOR) ; Add an image to the DICOM send image request queue sub-file
 Q:'IMAGE 0
 N D1,I,OLD,X
 D CHK^MAGGSQI(.X,IMAGE) I +$G(X(0))'=1 D  Q 0
 . S PROBLEM=PROBLEM+1,PROBLEM(PROBLEM)=" "
 . S PROBLEM=PROBLEM+1,PROBLEM(PROBLEM)="Image # "_IMAGE_":"
 . S I="" F  S I=$O(X(I)) Q:I=""  S PROBLEM=PROBLEM+1,PROBLEM(PROBLEM)=X(I)
 . Q
 ;
 ; Enter each image at most once in each transmission request
 S (D1,OLD)=0 F  S D1=$O(^MAGDOUTP(2006.574,D0,1,D1)) Q:'D1  D  Q:OLD
 . S:$P($G(^MAGDOUTP(2006.574,D0,1,D1,0)),"^",1)=IMAGE OLD=1
 . Q
 Q:OLD 1
 ;
 L +^MAGDOUTP(2006.574,D0,1,0):1E9 ; Background Process MUST wait
 S X=$G(^MAGDOUTP(2006.574,D0,1,0))
 S $P(X,"^",1,2)="^2006.5744"
 S D1=$O(^MAGDOUTP(2006.574,D0,1," "),-1)+1,$P(X,"^",3)=D1
 S $P(X,"^",4)=$P(X,"^",4)+1,OUT=$P(X,"^",4)
 S ^MAGDOUTP(2006.574,D0,1,0)=X
 S ^MAGDOUTP(2006.574,D0,1,D1,0)=IMAGE_"^WAITING^"_$H
 S ^MAGDOUTP(2006.574,"STS",LOCATION,PRIOR,"WAITING",D0,D1)=""
 L -^MAGDOUTP(2006.574,D0,1,0)
 Q 1
 ;
FIND(DATE,CASE,NUM) ; ADC x-reference (Radiology patient file)
 N X
 Q:'$G(DATE) 0
 S X=DATE S:$G(NUM) X=$$FMADD^XLFDT(DATE,NUM) Q:X<1 0
 Q $O(^RADPT("ADC",$$MMDDYY(X)_"-"_CASE,""))
 ;
MMDDYY(DAY) ; YYYMMDD --> MMDDYY
 I DAY'?7N Q 0
 Q $E(DAY,4,7)_$E(DAY,2,3)
 ;

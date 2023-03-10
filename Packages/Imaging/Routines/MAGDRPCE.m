MAGDRPCE ;WOIFO/PMK - Imaging RPCs ; Dec 06, 2021@10:54:46
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
 ; Called by SERVICES^MAGDIWBG to get the DICOM-enabled consult services
 ;
SERVICES(OUT) ; RPC = MAG DICOM GET CON SERVICES
 N ALPHA,NOUT,SERVICE,SERVICENAME
 K OUT
 S SERVICE="" ; alpha sort services
 F  S SERVICE=$O(^MAG(2006.5831,"B",SERVICE)) Q:'SERVICE  D
 . S SERVICENAME=$$GET1^DIQ(123.5,SERVICE,.01,"E")
 . S ALPHA(SERVICENAME)=SERVICE
 . Q
 S SERVICENAME="" ; put sorted services into OUT
 F NOUT=1:1 S SERVICENAME=$O(ALPHA(SERVICENAME)) Q:SERVICENAME=""  D
 . S SERVICE=ALPHA(SERVICENAME)
 . S OUT(NOUT)=SERVICENAME_"^"_SERVICE
 . Q
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q
 ;
GMRCDATE(OUT,SORTORDER,SERVICE,STATUS,DATE,GMRCIEN) ; RPC = MAG DICOM GET CON BY DATE
 N DIRECTION,SERVICES
 K OUT
 I '$D(SORTORDER) S OUT="-1,SORTORDER required" Q
 I SORTORDER="ASCENDING" S DIRECTION=1
 E  I SORTORDER="DESCENDING" S DIRECTION=-1
 E  S OUT="-2,SORTORDER must be either ASCENDING or DESCENDING, not """_SORTORDER_"""" Q
 I '$D(SERVICE) S OUT="-3,SERVICE required" Q
 ; STATUS=2 for COMPLETE, 5=PENDING, 6=ACTIVE, 8=SCHEDULED, STATUS=9 for PARTIAL RESULTS
 I '$D(STATUS) S OUT="-4,STATUS (2, 5, 6, 8 or 9) required" Q
 I STATUS'=2,STATUS'=5,STATUS'=6,STATUS'=8,STATUS'=9 D  Q
 . S OUT="-5,STATUS (2, 5, 6, 8 or 9) required, not """_STATUS_""""
 . Q 
 I '$D(DATE) S OUT="-6,DATE required (may be null)" Q
 I DATE S DATE=$$DATEGMRC(DATE) ; convert to reverse date
 I '$D(GMRCIEN) D  Q
 . S DATE=$O(^GMR(123,"AE",SERVICE,STATUS,DATE),-DIRECTION) ; reverse date
 . S OUT=$$DATEGMRC(DATE) ; convert back to regular Fileman date
 . Q
 F  S GMRCIEN=$O(^GMR(123,"AE",SERVICE,STATUS,DATE,GMRCIEN)) Q:GMRCIEN=""  D  Q:OUT  ; normal direction
 . S SERVICES(SERVICE)=1
 . S OUT=$$CHKIMAGE(GMRCIEN,.SERVICES) ; only return consults with images
 . Q
 S OUT=GMRCIEN
 Q
 ;
GMRCPAT(OUT,SORTORDER,DFN,DATE,GMRCIEN,SERVICES) ; RPC = MAG DICOM GET CON BY PATIENT
 N DIRECTION
 K OUT
 I '$D(SORTORDER) S OUT="-1,SORTORDER required" Q
 I SORTORDER="ASCENDING" S DIRECTION=1
 E  I SORTORDER="DESCENDING" S DIRECTION=-1
 E  S OUT="-2,SORTORDER must be either ASCENDING or DESCENDING, not """_SORTORDER_"""" Q
 I '$G(DFN) S OUT="-3,DFN required and may not be null" Q
 I '$D(DATE) S OUT="-4,DATE required and may not be null" Q
 ;
 I DATE=0 S DATE=""
 E  S DATE=$$DATEGMRC(DATE) ; convert to reverse date
 ;
 I '$D(GMRCIEN) D  ; $O DATE
 . S OUT=$O(^GMR(123,"AD",DFN,DATE),-DIRECTION) ; reverse date
 . I OUT S OUT=$$DATEGMRC(OUT) ; convert back to regular Fileman date
 . Q
 E  D  ; $O GMRCIEN to find next consult for the service for this patient
 . N HIT,TOSERVICE
 . I '$D(SERVICES) S OUT="-4,SERVICES is required" Q
 . I GMRCIEN=0 S GMRCIEN=""
 . S HIT=0
 . F  S GMRCIEN=$O(^GMR(123,"AD",DFN,DATE,GMRCIEN),DIRECTION) Q:'GMRCIEN  D  Q:HIT
 . . S TOSERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . . I $D(SERVICES(+TOSERVICE)) S HIT=1 ; found a consult for a requested TO SERVICE
 . . S HIT=$$CHKIMAGE(GMRCIEN,.SERVICES)
 . . Q
 . S OUT=GMRCIEN
 . Q
 Q
 ;
GMRCIEN(OUT,DIRECTION,GMRCIEN,SERVICES) ; RPC = MAG DICOM GET CON BY GMRCIEN
 K OUT
 I '$D(DIRECTION) S OUT="-1,DIRECTION required" Q
 I DIRECTION="ASCENDING" S DIRECTION=1
 E  I DIRECTION="DESCENDING" S DIRECTION=-1
 E  S OUT="-2,DIRECTION must be either ASCENDING or DESCENDING, not """_DIRECTION_"""" Q
 I '$D(GMRCIEN) S OUT="-3,GMRCIEN is required (may be null)" Q
 I '$D(SERVICES) S OUT="-4,SERVICES is required" Q
 ; find the next consult/procedure for the services
 S OUT=0
 F  S GMRCIEN=$O(^GMR(123,GMRCIEN),DIRECTION)  Q:'GMRCIEN  D  Q:OUT
 . S OUT=$$CHKIMAGE(GMRCIEN,.SERVICES)
 . Q
 Q
 ;
DATEGMRC(GMRCDATE) ; convert a GMRC date to a FM date and vice versa
 Q 9999999.999999-GMRCDATE ; unlike radiology which uses 9999999.9999
 ;
CHKIMAGE(GMRCIEN,SERVICES) ; check to see if there are images
 N HIT,STATUS,TIUIEN,TOSERVICE
 S HIT=0
 ;
 ; STATUS=2 for COMPLETE, 5=PENDING, 6=ACTIVE, 8=SCHEDULED, STATUS=9 for PARTIAL RESULTS
 S STATUS=$$GET1^DIQ(123,GMRCIEN,8,"I")
 I STATUS'=2,STATUS'=5,STATUS'=6,STATUS'=8,STATUS'=9 Q HIT
 ;
 S TOSERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 I $D(SERVICES(+TOSERVICE)) D  ; consult has a requested TO SERVICE
 . ; images can be assocated with the TIU External Data file (#8925.91),
 . ; or DICOM GMRC TEMP LIST file (#2006.5839), or stored in the new
 . ; SOP Class database IMAGE STUDY file (#2005.62) -- check all three
 . S TIUIEN=$$GET1^DIQ(123,GMRCIEN,16,"I")
 . I TIUIEN,$D(^TIU(8925.91,"B",TIUIEN)) S HIT=GMRCIEN
 . I $D(^MAG(2006.5839,"C",123,GMRCIEN)) S HIT=GMRCIEN
 . I $D(^MAGV(2005.62,"D",$$GMRCACN^MAGDFCNV(GMRCIEN))) S HIT=GMRCIEN
 Q HIT
 ;
GMRCDATA(OUT,GMRCIEN,FIELD,FORMAT) ; RPC = MAG DICOM GET CON DATA
 I '$D(GMRCIEN) S OUT="-1,GMRCIEN required" Q
 I '$D(FIELD) S OUT="-2,FIELD required" Q
 I $G(FORMAT)="" S FORMAT="E"
 S OUT=$$GET1^DIQ(123,GMRCIEN,FIELD,FORMAT)
 Q
 ;
 ;
GMRCMAG(OUT,GMRCIEN) ; RPC = MAG DICOM GET CON IMAGES
 ; return the image groups, if there are any
 N I,MAG20065839IEN,MAGIEN,TIU892591IEN,MAG20065839ZERO,TIU892591ZERO,TIUIEN,RETURN
 K OUT S I=1
 S TIUIEN=$$GET1^DIQ(123,GMRCIEN,16,"I")
 I TIUIEN,$D(^TIU(8925.91,"B",TIUIEN)) D
 . S TIU892591IEN=""
 . F  S TIU892591IEN=$O(^TIU(8925.91,"B",TIUIEN,TIU892591IEN)) Q:TIU892591IEN=""  D
 . . S TIU892591ZERO=$G(^TIU(8925.91,TIU892591IEN,0))
 . . S MAGIEN=$P(TIU892591ZERO,"^",2)
 . . S I=I+1,OUT(I)=MAGIEN
 . . Q
 . Q
 I $D(^MAG(2006.5839,"C",123,GMRCIEN)) D
 . S MAG20065839IEN=""
 . F  S MAG20065839IEN=$O(^MAG(2006.5839,"C",123,GMRCIEN,MAG20065839IEN)) Q:MAG20065839IEN=""  D
 . . S MAG20065839ZERO=$G(^MAG(2006.5839,MAG20065839IEN,0))
 . . S MAGIEN=$P(MAG20065839ZERO,"^",3)
 . . S I=I+1,OUT(I)=MAGIEN
 . . Q
 . Q
 I $D(^MAGV(2005.62,"D",$$GMRCACN^MAGDFCNV(GMRCIEN))) D
 . S I=I+1,OUT(I)="New SOP Class DB"
 . Q
 S OUT(1)=I-1
 Q

MAGVCAE ;;WOIFO/MAT - DICOM Storage Commit RPCs  ;  23 Oct 2012  3:01 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; Adapted from MAGVRS52 [RPC: MAG DICOM CHECK AE TITLE]
 ;
 ;##### GET DICOM AE SECURITY MATRIX (#2006.9192) Data for input AE TITLE
 ;      RPC: MAG DICOM GET AE ENTRY
 ;
AENAME(OUT,APPNAME,LOCATION) ;
 ; Returns AE Title and Security Matrix information for a given AE Title and Location
 N AEIEN,AEINST,MATCH,MSEP,I,LOCIEN,OSEP,STATION,SERVTYPE
 I $G(APPNAME)="" S OUT(1)="-1,No Application Name specified" Q
 I $G(LOCATION)="" S OUT(1)="-3,No Location specified" Q
 S AEIEN=0,MATCH=0,I=1,OSEP="`",MSEP="|",SERVTYPE="^"
 ; Loop through all entries - match on AE Instance name and Location 
 F  S AEIEN=$O(^MAGV(2006.9192,AEIEN)) Q:(AEIEN="")!(+AEIEN=0)  D
 . S AEINST=$G(^MAGV(2006.9192,AEIEN,0))
 . S LOCIEN=$P(AEINST,U,3) ; Pointer to INSTITUTION file (#4)
 . Q:LOCIEN=""  S STATION=$$STA^XUAF4(LOCIEN) ; IA #2171
 . I (LOCATION=STATION)&(($P(AEINST,U,1))=APPNAME) D
 . . ; If 1st match write all AE Instance info and Service Role
 . . I MATCH=0 D AEINST^MAGVRS52(.OUT,AEIEN,AEINST,LOCATION) S OUT(1)=OUT(1)_"SERVICE MESSAGE="
 . . S I=I+1
 . . S MATCH=MATCH+1
 . . ; Add Services and Roles to output
 . . D AESECMX^MAGVRS52(.OUT,AEIEN)
 . . ;--- Add N-Response Delay (#13) in seconds, N-Response Retries (#14) *79.
 . . S OUT(1)=OUT(1)_OSEP_(60*$$GET1^DIQ(2006.9192,AEIEN,13,"I"))
 . . S OUT(1)=OUT(1)_OSEP_$$GET1^DIQ(2006.9192,AEIEN,14,"I")
 . Q
 I MATCH=0 S OUT(1)="-2,No entry for Application Name """_APPNAME_""" at location """_LOCATION_"""."
 Q
AENTRYLC(OUT,SERVICE,ROLE,LOCATION) ; RPC = MAG DICOM GET AE ENTRY LOC
 ; The RPC will return the AE SEC MX Entry with matching provided service, role, and location fields 
 N DROLE,DSERVICE,IEN,DSRIEN,DSR,AEDATA,OSEP
 S OSEP=$$OUTSEP,IEN=0,OUT(1)=""
 I $G(LOCATION)="" S OUT(1)="-2"_OSEP_"No LOCATION provided." Q
 I $G(SERVICE)="" S OUT(1)="-2"_OSEP_"No SERVICE provided." Q
 I $G(ROLE)="" S OUT(1)="-2"_OSEP_"No ROLE provided." Q
 F  S IEN=$O(^MAGV(2006.9192,IEN)) Q:(+IEN=0)!(IEN="")!(OUT(1)'="")  D
 . S AEDATA=$G(^MAGV(2006.9192,IEN,0))
 . I LOCATION'=$P(AEDATA,U,3) Q
 . N IENS
 . S DSRIEN=0
 . F  S DSRIEN=$O(^MAGV(2006.9192,IEN,3,DSRIEN)) Q:(+DSRIEN=0)!(DSRIEN="")!(OUT(1)'="")  D
 . . S IENS=DSRIEN_","_IEN_","
 . . S DSERVICE=$$GET1^DIQ(2006.919212,IENS,.01)
 . . S DROLE=$$GET1^DIQ(2006.919212,IENS,1)
 . . I (SERVICE=DSERVICE)&(ROLE=DROLE) D AENTRYLD(IEN)
 . . Q
 . Q
 S:OUT(1)="" OUT(1)="-1"_OSEP_"No title for """_SERVICE_""", """_ROLE_""" at location """_LOCATION_"""."
 Q
 ;
 ;+++++ Entry point from above, which has chosen the entry to process.
 ;
AENTRYLD(AEIEN) ;
 S AEINST=$G(^MAGV(2006.9192,AEIEN,0))
 D AEINST^MAGVRS52(.OUT,AEIEN,AEINST,LOCATION) S OUT(1)=OUT(1)_"SERVICE MESSAGE="
 ; Add Services and Roles to output
 D AESECMX^MAGVRS52(.OUT,AEIEN)
 ;--- Add N-Response Delay (#13) in seconds, N-Response Retries (#14) *79.
 S OUT(1)=OUT(1)_OSEP_(60*$$GET1^DIQ(2006.9192,AEIEN,13,"I"))
 S OUT(1)=OUT(1)_OSEP_$$GET1^DIQ(2006.9192,AEIEN,14,"I")
 Q
 ;--- Set separator values.
 ;
OUTSEP() ; Separator for output data ie. NAME`DOB
 Q "`"
MULTISEP() ; Name value separator for multiple values ie. REJECT=1|WARNING=1 
 Q "|"
SRSEP() ; Service and Role Separator ie. C-Store^SCU^C-Move^SCP
 Q "^"
 ;
 ; MAGVCAE

MAGVRS52 ;WOIFO/EdM/DAC/NST/JSL - Imaging RPCs ,156for Query/Retrieve ; 30 Jan 2015 3:05 PM
 ;;3.0;IMAGING;**118,145,138,156**;Mar 19, 2002;Build 10;Jan 3, 2015
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
OUTSEP() ; Separator for output data ie. NAME`DOB
 Q "`"
MULTISEP() ; Name value separator for multiple values ie. REJECT=1|WARNING=1 
 Q "|"
SRSEP() ; Service and Role Separator ie. C-Store^SCU^C-Move^SCP
 Q "^"
 ;
AETITLE(OUT,RTITLE,LOCATION) ; MAG DICOM CHECK AE TITLE RPC
 ; Returns AE Title and Security Matrix information for a given AE Title and Location
 N AEIEN,AEINST,MATCH,MSEP,I,LOCIEN,OSEP,STATION,SERVTYPE
 I $G(RTITLE)="" S OUT(1)="-1,No AE Title specified" Q
 I $G(LOCATION)="" S OUT(1)="-3,No Location specified" Q
 S AEIEN=0,MATCH=0,I=1,OSEP="`",MSEP="|",SERVTYPE="^"
 ; Loop through all entries - match on AE Instance name and Location 
 F  S AEIEN=$O(^MAGV(2006.9192,AEIEN)) Q:(AEIEN="")!(+AEIEN=0)  D
 . S AEINST=$G(^MAGV(2006.9192,AEIEN,0))
 . S LOCIEN=$P(AEINST,U,3)
 . Q:LOCIEN=""
 . S STATION=$$STA^XUAF4(LOCIEN) ; P145 DAC
 . ; Perform case-insensitive DICOM AE Title check
 . S AEINST=$$UP^XLFSTR(AEINST) ; IA #10104
 . S RTITLE=$$UP^XLFSTR(RTITLE) ; IA #10104
 . I (LOCATION=STATION)&(($P(AEINST,U,6))=RTITLE) D  ; P145 DAC
 . . ; If 1st match write all AE Instance info and Service Role
 . . I MATCH=0 D AEINST(.OUT,AEIEN,AEINST,LOCATION) S OUT(1)=OUT(1)_"SERVICE MESSAGE="
 . . S I=I+1
 . . S MATCH=MATCH+1
 . . ; Add Services and Roles to output
 . . D AESECMX(.OUT,AEIEN)
 . . ;--- Add N-Response Delay (#13) in seconds, N-Response Retries (#14) *79.
 . . S OUT(1)=OUT(1)_OSEP_(60*$$GET1^DIQ(2006.9192,AEIEN,13,"I"))
 . . S OUT(1)=OUT(1)_OSEP_(1*$$GET1^DIQ(2006.9192,AEIEN,14,"I"))
 . . Q
 . Q
 I MATCH=0 S OUT(1)="-2,No entry for AE Title """_RTITLE_""" at location """_LOCATION_"""."
 Q
AEINST(OUT,AEIEN,AEINST,LOCATION) ; Retrieve AE Instance information
 N AENAME,AETITLE,FLAGDATA,IP,LABEL,PORT,OSEP,MSEP,MULTOUT,SUBIEN,SUBFILE,FIELD,FLAG,FORCER,ORIGIX,VALUE
 I $G(AEIEN)="" S OUT(1)="-4,DICOM AE Security Matrix IEN not defined" Q
 I $G(AEINST)="" S OUT(1)="-5,AE Instance data not defined" Q
 I $G(LOCATION)="" S OUT(1)="-6,LOCATION not defined" Q
 I $G(^MAGV(2006.9192,AEIEN,0))="" S OUT(1)="-7,DICOM AE Security Matrix entry not found" Q
 S OSEP=$$OUTSEP,MSEP=$$MULTISEP
 S AENAME=$P(AEINST,U,1)
 S AETITLE=$P(AEINST,U,2)
 S RTITLE=$P(AEINST,U,6)
 S IP=$P(AEINST,U,4)
 S PORT=$P(AEINST,U,5)
 S FORCER=$P(AEINST,U,8)
 S ORIGIX=$P(AEINST,U,9)
 S OUT(1)="0,"_AENAME_OSEP_RTITLE_OSEP_AETITLE_OSEP_LOCATION_OSEP_IP_OSEP_PORT_OSEP_FORCER_OSEP_ORIGIX_OSEP
 S FLAGDATA=$G(^MAGV(2006.9192,AEIEN,2))
 S FLAG=""
 F FIELD=6:1:11 D
 . S LABEL=$$GET1^DID(2006.9192,FIELD,,"LABEL")
 . S VALUE=$$GET1^DIQ(2006.9192,AEIEN,FIELD,"I")
 . I VALUE'="",FLAG'="" S FLAG=FLAG_MSEP
 . I VALUE'="" S FLAG=FLAG_LABEL_"="_VALUE
 . Q
 I FLAG'="" S OUT(1)=OUT(1)_FLAG
 S OUT(1)=OUT(1)_OSEP
 Q
AESECMX(OUT,AEIEN) ; Retrieve Security Matrix information  
 N SERVICE,ROLE,SRSEP,SRIEN,SRDATA,IENS
 S SRSEP=$$SRSEP
 I $G(AEIEN)="" S OUT(1)="-4,DICOM AE Security Matrix IEN not defined" Q
 I $G(^MAGV(2006.9192,AEIEN,0))="" S OUT(1)="-7,DICOM AE Security Matrix entry not found" Q
 S SRIEN=0
 F  S SRIEN=$O(^MAGV(2006.9192,AEIEN,3,SRIEN)) Q:(SRIEN="")!(+SRIEN=0)  D 
 . S IENS=SRIEN_","_AEIEN_","
 . S SERVICE=$$GET1^DIQ(2006.919212,IENS,.01)
 . S ROLE=$$GET1^DIQ(2006.919212,IENS,1)
 . S SRDATA=$G(SRDATA)_SERVICE_SRSEP_ROLE_SRSEP
 . Q
 S OUT(1)=OUT(1)_$G(SRDATA)
 Q
VATITLE(OUT,SERVICE,ROLE,LOCATION) ; RPC = MAG DICOM VISTA AE TITLE
 ; The RPC will return the first AE Title with matching provided service, role, and location fields 
 N DROLE,DSERVICE,IEN,DSRIEN,DSR,AEDATA,OSEP
 S OSEP=$$OUTSEP,IEN=0,OUT=""
 I $G(LOCATION)="" S OUT="-2"_OSEP_"No LOCATION provided." Q
 I $G(SERVICE)="" S OUT="-2"_OSEP_"No SERVICE provided." Q
 I $G(ROLE)="" S OUT="-2"_OSEP_"No ROLE provided." Q
 F  S IEN=$O(^MAGV(2006.9192,IEN)) Q:(+IEN=0)!(IEN="")!(OUT'="")  D
 . S AEDATA=$G(^MAGV(2006.9192,IEN,0))
 . I LOCATION'=$P(AEDATA,U,3) Q
 . S DSRIEN=0
 . F  S DSRIEN=$O(^MAGV(2006.9192,IEN,3,DSRIEN)) Q:(+DSRIEN=0)!(DSRIEN="")!(OUT'="")  D
 . . S IENS=DSRIEN_","_IEN_","
 . . S DSERVICE=$$GET1^DIQ(2006.919212,IENS,.01)
 . . S DROLE=$$GET1^DIQ(2006.919212,IENS,1)
 . . I (SERVICE=DSERVICE)&(ROLE=DROLE) S OUT=0_OSEP_$P(AEDATA,U,6)
 . . Q
 . Q
 S:OUT="" OUT="-1"_OSEP_"No title for """_SERVICE_""", """_ROLE_""" at location """_LOCATION_"""."
 Q
 ;

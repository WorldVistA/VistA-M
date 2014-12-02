MAGVRD02 ;WOIFO/DAC - Radiation Dosage - Attach Instance ; 06 August 2013 2:01 PM
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
INPUTSEP() ; Name value separator for input data  ie. NAME`TESTPATIENT
 Q "`"
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and Result separator ie. -3``No record IEN  
 Q "`"
 ;
 ; Input Variables:
 ;                ATTNAMS - Array of name value pairs separated by an input separator  
 ;                SERUID  - Series UID
 ;                IIUID   - Irradiation Instance
 ; Output Variable:
 ;                OUT - Returns success and new record IEN or error and error message
 ;
CT(OUT,ATTNAMS,SERUID,IIUID) ; Create CT dosage instance
 N IENS,ERR,ID,FDA,SSEP
 S IENS="+1,"
 L +^MAGV(2005.632,0):1E9
 S ID=$P($G(^MAGV(2005.632,0)),U,4)+1
 S SSEP=$$STATSEP
 S FDA(2005.632,IENS,.01)=ID
 S FDA(2005.632,IENS,1)=$G(ATTNAMS("IRRADIATION INSTANCE UID"))
 S FDA(2005.632,IENS,2)=$G(ATTNAMS("TARGET REGION"))
 S FDA(2005.632,IENS,4)=$G(ATTNAMS("CTDIVOL"))
 S FDA(2005.632,IENS,7)=$G(ATTNAMS("DLP"))
 S FDA(2005.632,IENS,11)=$G(SERUID)
 D UPDATE^DIE("E","FDA","","ERR")
 L -^MAGV(2005.632,0)
 I $D(ERR("DIERR")) S OUT="-99"_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q
 S OUT=0_SSEP_SSEP_ID
 Q
 ;
 ; Input Variables:
 ;                ATTNAMS - Array of name value pairs separated by an input separator
 ;                SERUID  - Series Instance UID
 ;                IIUID   - Irradiation Instance
 ; Output Variable:
 ;                OUT - Returns success and new record IEN or error and error message
 ;                
FLUORO(OUT,ATTNAMS,SERIUD,IIUID) ; Create fluoroscopy dosage instance
 N IENS,ERR,FDA,SSEP
 S IENS="+1,"
 L +^MAGV(2005.633,0):1E9
 S ID=$P($G(^MAGV(2005.633,0)),U,4)+1
 S SSEP=$$STATSEP
 S FDA(2005.633,IENS,.01)=ID
 S FDA(2005.633,IENS,1)=$G(ATTNAMS("ESTIMATE"))
 S FDA(2005.633,IENS,2)=$G(ATTNAMS("TOTAL TIME IN FLUOROSCOPY"))
 S FDA(2005.633,IENS,6)=$G(ATTNAMS("DOSE AREA PRODUCTS"))
 S FDA(2005.633,IENS,8)=$G(SERUID)
 S FDA(2005.633,IENS,9)=$G(ATTNAMS("DOSE (RP) TOTAL (AKE)"))
 S FDA(2005.633,IENS,10)=$G(ATTNAMS("FLUORO DOSE (RP) TOTAL"))
 S FDA(2005.633,IENS,11)=$G(ATTNAMS("FLUORO DOSE AREA PRODUCT TOTAL"))
 S FDA(2005.633,IENS,12)=$G(ATTNAMS("CINE DOSE (RP) TOTAL"))
 S FDA(2005.633,IENS,13)=$G(ATTNAMS("CINE DOSE AREA PRODUCT TOTAL"))
 S FDA(2005.633,IENS,14)=$G(ATTNAMS("CINE TIME"))
 D UPDATE^DIE("E","FDA","","ERR")
 L -^MAGV(2005.633,0)
 I $D(ERR("DIERR")) S OUT="-99"_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q
 S OUT=0_SSEP_SSEP_ID
 Q

MAGDGMRC ;WOIFO/PMK,EdM,MLH,DAC - Read a DICOM image file ; Nov 08, 2019@10:50:30
 ;;3.0;IMAGING;**10,51,50,85,118,138,239**;Mar 19, 2002;Build 18;May 19, 2019
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
 ; This is the set of GMRC APIs that are use by the VistA Imaging
 ; DICOM Gateway
 ;
ANYREQ(DFN) ; check if any GMRC requests are present for the patient
 N ADFN ; ---- array of DFNs to look up
 N WRK ; ----- work array for our results
 N IX ; ------ results lookup index
 N FHIT ; ---- flag - any results for the pt?
 ;
 ; ask for requests for the patient
 S WRK=$NA(^TMP("MAG",$J,$T(+0))) K @WRK
 S ADFN(1)=DFN
 D FIND^DIC(123,,"@;.02I","QX",.ADFN,,"F",,,WRK,WRK)
 ;
 ; check returns to see if any are actually for this patient (see note
 ; on SEARCH below)
 S IX=0
 F  S IX=$O(@WRK@("DILIST","ID",IX)) Q:'IX  D  Q:$G(FHIT)
 . I $G(@WRK@("DILIST","ID",IX,.02))=DFN S FHIT=1
 . Q
 K @WRK
 Q +$G(FHIT)
 ;
TIULAST(GMRCIEN) ; find the ien of the most recent TIU note for this request
 N TIUIEN
 N WRK ; root of work global
 S TIUIEN=0
 I GMRCIEN D  ; look for the most recent TIU note for this request
 . ; set up the array to look through
 . S WRK=$NA(^TMP("MAG",$J,$T(+0))) K @WRK
 . D LIST^DIC(123.03,","_GMRCIEN_",",".01I",,,,,,,,WRK,WRK)
 . ; traverse the array
 . N TIUPTR
 . S TIUPTR=" " ; setup for reverse $o from space (" ")
 . F  S TIUPTR=$O(@WRK@("DILIST","ID",TIUPTR),-1) Q:'TIUPTR  D  Q:TIUIEN
 . . S TIUIEN=$P($G(@WRK@("DILIST","ID",TIUPTR,.01)),"^",1)
 . . I $P(TIUIEN,";",2)'="TIU(8925," S TIUIEN=0 ; not a TIU document
 . . Q
 . Q
 K @WRK
 Q +TIUIEN
 ;
TIUALL(GMRCIEN,RESULT) ; find all IENs for the TIU notes for this request
 N MAGIEN,TIUIEN,TIUPTR,TIUXIEN,Y
 N WRK ; root of work global
 K RESULT
 ; set up the array to look through
 S WRK=$NA(^TMP("MAG",$J,$T(+0))) K @WRK
 D LIST^DIC(123.03,","_GMRCIEN_",",".01I",,,,,,,,WRK,WRK)
 ; traverse the array
 S (RESULT,TIUPTR)=0
 F  S TIUPTR=$O(@WRK@("DILIST","ID",TIUPTR)) Q:'TIUPTR  D
 . S TIUIEN=$P($G(@WRK@("DILIST","ID",TIUPTR,.01)),"^",1)
 . I $P(TIUIEN,";",2)'="TIU(8925," Q  ; not a TIU document
 . S TIUIEN=+TIUIEN ; strip off variable pointer stuff
 . S TIUXIEN=""
 . F  S TIUXIEN=$O(^TIU(8925.91,"B",TIUIEN,TIUXIEN)) Q:'TIUXIEN  D
 . . S Y=$G(^TIU(8925.91,TIUXIEN,0)) Q:'Y
 . . S MAGIEN=$P(Y,"^",2)
 . . S RESULT=RESULT+1
 . . S RESULT(RESULT)=TIUIEN_"^"_$$GMRCACN^MAGDFCNV(GMRCIEN)_"^"_MAGIEN
 . . Q
 . ; new database structure
 . S TIUXIEN=""
 . ; P239 DAC - Changed/(fixed) next three global references to ^MAGV instead of ^MAG
 . F  S TIUXIEN=$O(^MAGV(2005.61,"B",TIUIEN,TIUXIEN)) Q:'TIUXIEN  D
 . . S Y=$G(^MAGV(2005.61,TIUXIEN,0)) Q:$P(Y,"^",3)'="TIU"
 . . S MAGIEN=""
 . . F  S MAGIEN=$O(^MAGV(2005.62,"C",TIUXIEN,MAGIEN)) Q:'MAGIEN  D
 . . . S RESULT=RESULT+1
 . . . S RESULT(RESULT)=TIUIEN_"^"_$$GMRCACN^MAGDFCNV(GMRCIEN)_"^N"_MAGIEN
 . . . Q
 . . Q
 . Q
 K @WRK
 Q
 ;
FWDFROM(GMRCIEN) ; for a forwarded request, determine the FORWARD FROM service
 N FWDFROM,I
 N WRK ; root of work global
 ; set up the array to look through
 S WRK=$NA(^TMP("MAG",$J,$T(+0))) K @WRK
 D LIST^DIC(123.02,","_GMRCIEN_",",".01I;6I",,,,,,,,WRK,WRK)
 ; traverse the array
 S FWDFROM=0
 I GMRCIEN D
 . S I=$O(@WRK@("DILIST","ID"," "),-1)
 . I I D  ; get the FORWARDED FROM service
 . . S FWDFROM=$G(@WRK@("DILIST","ID",I,6))
 . . Q
 . Q
 K @WRK
 Q +FWDFROM
 ;
UNSIGNED(GMRCIEN) ; check if there are any unsigned TIU notes for the request
 N TIUPTR,NRESULTS,TIUSTAT,UNSIGNED,X
 N WRK ; root of work global
 ; set up the array to look through
 S WRK=$NA(^TMP("MAG",$J,$T(+0))) K @WRK
 D LIST^DIC(123.03,","_GMRCIEN_",",".01I",,,,,,,,WRK,WRK)
 S UNSIGNED=0,TIUPTR=""
 ; traverse the array, check all associated results, bail if any unsigned
 F  S TIUPTR=$O(@WRK@("DILIST","ID",TIUPTR)) Q:'TIUPTR  D  Q:UNSIGNED
 . S X=$P($G(@WRK@("DILIST","ID",TIUPTR,.01)),"^",1)
 . ; if TIU note, check if unsigned
 . I X?.N1";TIU(8925," D  ; check status of TIU note for completion
 . . ; status in ^TIU(8925.6) - use first 5 "UNs" per Margy McClenanhan
 . . S TIUSTAT=$$GET1^DIQ(8925,+X,.05,"I")
 . . I TIUSTAT,TIUSTAT<6 S UNSIGNED=1 ; got one!
 . . Q
 . Q
 K @WRK
 Q UNSIGNED

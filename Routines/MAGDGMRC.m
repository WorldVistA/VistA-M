MAGDGMRC ;WOIFO/PMK - Read a DICOM image file ; 12/15/2006 13:50
 ;;3.0;IMAGING;**10,51,50,85**;16-March-2007;;Build 1039
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
 . . S RESULT(RESULT)=TIUIEN_"^GMRC-"_GMRCIEN_"^"_MAGIEN
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
 ;
SEARCH(DFN,CUTOFF,CLINIC,REQUEST) ; search for requests for a given clinic
 ;
 ; It is a bit of a trick to determine if a given appointment is for
 ; an existing GMRC request.  This determination is performed by using
 ; an association between the SERVICE for the request and the CLINIC
 ; where the request is to be performed.
 ;
 ; This subroutine passes all of the (recent) requests for a patient and
 ; builds a list of those that can be performed in the designated clinic.
 ;
 ; Maybe the replacement for Appointment Management and future versions
 ; of CPRS Order Entry and Consult Request Tracking will capable of
 ; correctly maintaining this essential association.
 ;
 N GMRIDX,GMRC0,GMRCDATE,GMRCIEN,SERVICE,STATUS
 N WRK ; --- root of results global
 N ADFN ; -- array for DFNs to look up
 K REQUEST S REQUEST=0
 I 'DFN Q  ; no patient number provided
 ; build the array of results
 ; Note the use of the "Q[uick]" flag to allow lookup by *internal* DFN.
 ; However, even though we define ADFN(1) to force lookup on the *first*
 ; level subscript of the F index only, FileMan also looks up on the IEN
 ; directly (because there is a .001 field defined in the DD of File
 ; #123).  So we grab the DFN in the .02 field for later double-
 ; checking.
 ;
 S ADFN(1)=DFN
 S WRK=$NA(^TMP("MAG",$J,$T(+0))) K @WRK
 D FIND^DIC(123,,"@;.02I;1I;3I;5I;8I","QX",.ADFN,,"F",,,WRK,WRK)
 ; traverse the results
 S GMRIDX=""
 F  S GMRIDX=$O(@WRK@("DILIST","ID",GMRIDX)) Q:'GMRIDX  D
 . S GMRCIEN=+$G(@WRK@("DILIST",2,GMRIDX))
 . I $G(@WRK@("DILIST","ID",GMRIDX,.02))'=DFN Q  ; not for this patient!
 . I $G(@WRK@("DILIST","ID",GMRIDX,3))<CUTOFF Q  ; too far back
 . S SERVICE=$G(@WRK@("DILIST","ID",GMRIDX,1)) Q:SERVICE=""
 . I '$$ISCLINIC^MAGDGMRC(SERVICE,CLINIC) Q  ; not a service or clinic
 . S STATUS=$G(@WRK@("DILIST","ID",GMRIDX,8)) ; CPRS status
 . I STATUS S STATUS=$$GET1^DIQ(100.01,STATUS,.1) ; CPRS status abbrev
 . S REQUEST=$G(REQUEST)+1
 . S REQUEST(REQUEST)=GMRCIEN_"^"_SERVICE_"^"_STATUS
 . Q
 K @WRK
 Q
 ;
ISCLINIC(SERVICE,CLINIC) ; is a particular clinic defined for a given service?
 ; this entry point is called by ^MAGDGMRC as well as below
 N ISCLINIC
 S ISCLINIC=0
 I SERVICE,CLINIC,$D(^MAG(2006.5831,SERVICE,1,"B",CLINIC)) S ISCLINIC=1
 Q ISCLINIC
 ;

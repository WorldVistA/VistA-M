MAGDHLI ;WOIFO/MLH/PMK - IHE-based ADT interface for PACS ;22 Mar 2017 8:07 AM
 ;;3.0;IMAGING;**49,183**;05-October-2009;Build 11;Build 1463
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
ADT ; MAIN ENTRY POINT - Generate the appropriate ADT message.
 N STAT ; status of HL7 message generation
 N OCCURRED ; date/time the event occurred (from DGPMA)
 ;
 I DGPMT=1 D  Q  ; admission
 . S OCCURRED=$P($G(DGPMA),"^",1)
 . S STAT=$S(OCCURRED:$$A01^MAGDHLT(DFN,OCCURRED),1:$$A11^MAGDHLT(DFN,DGNOW))
 . Q
 I DGPMT=2 D  Q  ; transfer
 . S OCCURRED=$P($G(DGPMA),"^",1)
 . S STAT=$S(OCCURRED:$$A02^MAGDHLT(DFN,OCCURRED),1:$$A12^MAGDHLT(DFN,DGNOW))
 . Q
 I DGPMT=3 D  Q  ; discharge
 . S OCCURRED=$P($G(DGPMA),"^",1)
 . S STAT=$S(OCCURRED:$$A03^MAGDHLT(DFN,OCCURRED),1:$$A13^MAGDHLT(DFN,DGNOW))
 . Q
 I DGPMT=8 D  Q  ; patient information update - P183 PMK 3/9/17
 . S STAT=$$A08^MAGDHLT(DFN)
 . Q
 I DGPMT=47 D  Q  ; change patient identifier list - P183 PMK 3/9/17
 . N DATETIME,NEWSSN,OLDSSN
 . ; send the last SSN change for VAFC ADT-A08 SERVER event, or
 . ; all SSN changes for a call from the SENDA08 API entry point
 . S DATETIME=""
 . F  S DATETIME=$O(SSNCHANGES(DATETIME)) Q:DATETIME=""  D
 . . S NEWSSN=SSNCHANGES(DATETIME,"NEW")
 . . S OLDSSN=SSNCHANGES(DATETIME,"OLD")
 . . S STAT=$$A47^MAGDHLT(DFN,OLDSSN,NEWSSN,DATETIME)
 . . Q
 . ; finally, send A08 to change the PID-19 SSN
 . S STAT=$$A08^MAGDHLT(DFN,NEWSSN,DATETIME)
 . Q
 Q

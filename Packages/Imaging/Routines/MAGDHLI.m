MAGDHLI ;WOIFO/MLH - IHE-based ADT interface for PACS ; 01 Jun 2009 2:32 PM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
 Q

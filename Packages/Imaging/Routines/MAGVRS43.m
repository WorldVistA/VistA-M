MAGVRS43 ;WOIFO/MLH - RPC calls for DICOM file processing ; 03 Apr 2012 2:44 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
TIUCHK(OUT,STYIEN) ; is this image study attached to a consult with a TIU note?
 N TIUIEN,PROCIEN,CONIEN,TIUPATIEN,DFN,PATIEN,PATID,PATREFDTA,STYDFN,TIUDFN,X
 S STYIEN=$G(STYIEN)
 I STYIEN'?1N.E S OUT(1)="-1`Study IEN must be numeric" Q
 I STYIEN'>0 S OUT(1)="-2`Study IEN must be a positive integer" Q
 I '$D(^MAGV(2005.62,STYIEN)) S OUT(1)="-3`No entry on file for Study IEN "_STYIEN Q
 I $P($G(^MAGV(2005.62,STYIEN,5)),"^",2)="I" S OUT(1)="4`Study is inaccessible" Q
 S PROCIEN=$P($G(^MAGV(2005.62,STYIEN,6)),"^",1)
 I PROCIEN="" S OUT(1)="-4`No associated Procedure Reference IEN" Q
 I '$D(^MAGV(2005.61,PROCIEN)) S OUT(1)="-5`No entry on file for associated Procedure Reference IEN "_PROCIEN Q
 I $P($G(^MAGV(2005.61,PROCIEN,0)),"^",3)'="CON" S OUT(1)="1`Associated procedure is not a consult" Q
 ; find DFN of patient associated with procedure
 S PATIEN=$P($G(^MAGV(2005.61,PROCIEN,6)),"^",1)
 I PATIEN="" S OUT(1)="-6`Missing Patient Reference IEN" Q
 I '$D(^MAGV(2005.6,PATIEN)) S OUT(1)="-7`No entry on file for associated Patient Reference IEN" Q
 S PATREFDTA=$G(^MAGV(2005.6,PATIEN,0))
 I $P(PATREFDTA,"^",2)'="V" S OUT(1)="2`Study is not associated with a VA patient" Q
 I $P(PATREFDTA,"^",3)'="D" S OUT(1)="3`Study is not associated with a local DFN" Q
 S STYDFN=$P(PATREFDTA,"^",1)
 ; find DFN of patient associated with consult
 S CONIEN=$P($G(^MAGV(2005.61,PROCIEN,0)),"^",1)
 S X=$$GMRCIEN^MAGDFCNV(CONIEN) I X S CONIEN=X
 S TIUIEN=$$TIULAST^MAGDGMRC(CONIEN)
 I "0"[TIUIEN S OUT(1)="5`No associated TIU note for associated consult "_CONIEN Q
 S TIUDFN=$$GET1^DIQ(8925,TIUIEN,.02,"I") ; entry on VA patient file
 I "0"[TIUDFN S OUT(1)="-8`No DFN on file for TIU note "_TIUIEN Q
 ; compare the two DFNs
 I TIUDFN'=STYDFN S OUT(1)="-9`VA Patient IEN associated with TIU Document does not match Patient IEN associated with Study" Q
 S OUT(1)="0``"_TIUIEN
 Q

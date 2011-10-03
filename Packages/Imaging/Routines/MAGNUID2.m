MAGNUID2 ;WOIFO/NST - Checks for duplicates UIDs ; 11 Oct 2010 3:42 AM
 ;;3.0;IMAGING;**106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
 ;*****  Check for duplicate DICOM UIDs
 ;       in IMAGE file (#2005)
 ;       
 ; RPC: N/A
 ; 
 ; Input Parameters
 ; ================
 ;   MAGTYPE = Type UID - "STUDY", "SERIES", "SOP"
 ;   UID     = DICOM UID
 ;
 ; Return Values
 ; =============
 ; If no duplicate UID found returns 0
 ; If duplicate found returns 1
 ;                              
ISDUP(MAGTYPE,UID) ;
 I UID="" Q 0
 I MAGTYPE="STUDY" Q:'$D(^MAG(2005,"P",UID)) 0 Q 1
 I MAGTYPE="SERIES" Q:'$D(^MAG(2005,"SERIESUID",UID)) 0 Q 1
 I MAGTYPE="SOP" Q:'$D(^MAG(2005,"P",UID)) 0 Q 1
 Q 0  ; nothing to check

MAGVRS15 ;WOIFO/MLH - RPC calls for DICOM file processing ; 31 Aug 2011 3:28 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
FNDBYTIU(OUT,TIUREF) ; RPC - MAGV FIND SERIES BY TIU REFERENCE
 ; Looks up for Series by TIU Note Reference.
 ; Returns null if no Series found corresponding to a TIU Note, else
 ;  returns one or a list of Series Handles.
 ;  Note: one TIU Note can point to multiple Series.
 ; Generates exception on invalid input.
 ;
 ; Find reference IEN based on UID
 ; Look for IEN in Series
 N I,IEN,STATUS,FIELD,OSEP,ISEP,SSEP
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 I TIUREF="" S OUT(1)="-2"_SSEP_"UID has no value" Q
 S FIELD=$$GETFIELD^MAGVRS41(2005.63,"STATUS")
 S I=1,IEN=""
 F  S IEN=$O(^MAGV(2005.63,"ATIU",TIUREF,IEN))  Q:IEN=""  D
 . S STATUS=$$GET1^DIQ(2005.63,IEN,FIELD)
 . I STATUS'="INACTIVE" S OUT(I)="0"_SSEP_SSEP_IEN,I=I+1
 . Q
 I $G(OUT(1))="" S OUT(1)="-1"_SSEP_"TIU note reference not found"
 Q

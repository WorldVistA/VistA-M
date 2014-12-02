MAGVRS14 ;WOIFO/DAC,MLH - RPC calls for DICOM file processing ; 26 Jan 2012 11:01 PM
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
GETSER(OUT,STUDYIEN,SERIEN,OVERRIDE) ;RPC - MAGV GET SERIES
 D REFRESH^MAGVRS41(.OUT,2005.63,$G(SERIEN),$G(STUDYIEN),$G(OVERRIDE))
 Q
INSERIES(OUT,SERIEN,STUDYIEN,OVERRIDE) ; RPC - MAGV INACTIVATE SERIES
 D INACTIVT^MAGVRS41(.OUT,2005.63,$G(SERIEN),$G(STUDYIEN),$G(OVERRIDE))
 Q
FINDBYRF(OUT,REFUID) ; RPC - MAGV FIND SERIES BY UID
 ; Looks up for Series by Reference UID only.
 ; Returns null if no such Series found, else returns one or a list of Series Handles. Note: one Reference UID can point to multiple series.
 ; Generates exception on invalid input.
 ;
 ; Find reference IEN based on UID
 ; Look for IEN in Series
 N FILENO,I,IEN,STATUS,FIELD,OSEP,ISEP,SSEP
 S FILENO=2005.63
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 I $G(REFUID)="" S OUT(1)="-2"_SSEP_"UID has no value" Q
 S I=1,IEN=""
 F  D  Q:IEN=""  S I=I+1
 . S IEN=$O(^MAGV(FILENO,"B",REFUID,IEN))
 . Q:'IEN
 . S FIELD=$$GETFIELD^MAGVRS41(FILENO,"STATUS")
 . S STATUS=$$GET1^DIQ(FILENO,IEN,FIELD,"I")
 . I IEN'="",STATUS'="I" S OUT(I)="0"_SSEP_SSEP_IEN
 . Q
 I $G(OUT(1))="" S OUT(1)="-1"_SSEP_"Series reference UID not found"
 Q

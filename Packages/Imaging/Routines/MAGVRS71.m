MAGVRS71 ;WOIFO/MLH - RPC calls for DICOM file processing ; 20 Oct 2011 5:44 PM
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
GETSILST(OUT) ; RPC - MAGV GET SERVICE INST LIST
 ; 
 N OSEP,ISEP,SSEP,FILE,SIIX,SIDTA
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 S FILE=2005.8 ; IMAGING SERVICE INSTITUTION file
 S OUT(1)="",SIIX=0
 F  S SIIX=$O(^MAGV(FILE,SIIX)) Q:'SIIX  D
 . S SIDTA=$$GET1^DIQ(FILE,SIIX,.01,"I")_OSEP_$$GET1^DIQ(FILE,SIIX,.01)
 . S OUT($O(OUT(""),-1)+1)=0_SSEP_SIDTA
 . Q
 S OUT(1)=$O(OUT(""),-1)-1
 Q

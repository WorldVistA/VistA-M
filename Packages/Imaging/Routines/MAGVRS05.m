MAGVRS05 ;WOIFO/MLH,DAC - RPC calls for DICOM file processing ; Apr 27, 2022@11:45:06
 ;;3.0;IMAGING;**118,278**;Mar 19, 2002;Build 138
 ;; Per VA Directive 6402, this routine should not be modified.
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
ATSTUDY(OUT,STUDYATTS) ;RPC - create a new study
 L +^MAGV(2005.62):60 E  D  ; P278 DAC - Lock Image Study file to prevent duplicates
 . S OUT(1)="-99"_$$STATSEP^MAGVRS41_"Image Study file is locked"
 Q:$D(OUT(1))
 D ATTACH^MAGVRS41(.OUT,2005.62,.STUDYATTS)
 L -^MAGV(2005.62)
 Q
UPDPROC(OUT,PROCATTS,OVERRIDE) ;RPC - update procedure
 D UPDATE^MAGVRS41(.OUT,2005.61,.PROCATTS,$G(OVERRIDE))
 Q
FINDSTDY(OUT,STUDYUID) ; RPC - find study by UID
 D FINDBUID^MAGVRS41(.OUT,2005.62,STUDYUID)
 Q 

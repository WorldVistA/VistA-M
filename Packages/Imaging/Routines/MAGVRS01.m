MAGVRS01 ;WOIFO/DAC - RPC calls for DICOM file processing ; Apr 27, 2022@11:45:31
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
ATSERIES(OUT,SERIESATTS) ;RPC - MAGV ATTACH SERIES
 L +^MAGV(2005.63):60 E  D  ; P278 DAC - Lock Image Series file to prevent duplicates
 . S OUT(1)="-99"_$$STATSEP^MAGVRS41_"Image Series file is locked"
 Q:$D(OUT(1))
 D ATTACH^MAGVRS41(.OUT,2005.63,.SERIESATTS)
 L -^MAGV(2005.63)
 Q
UPDSTUDY(OUT,STUDATTS,OVERRIDE) ;RPC - MAGV UPDATE STUDY
 D UPDATE^MAGVRS41(.OUT,2005.62,.STUDATTS,$G(OVERRIDE))
 Q

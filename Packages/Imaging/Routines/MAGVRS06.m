MAGVRS06 ;WOIFO/MLH,DAC - RPC calls for DICOM file processing ; Mar 31, 2021@09:48:26
 ;;3.0;IMAGING;**118,257,278**;Mar 19, 2002;Build 138
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
ATPROC(OUT,PROCATTS) ;RPC - create a new procedure reference
 L +^MAGV(2005.61):60 E  D  ; P257 DAC - Lock Procedure Reference file to prevent duplicates
 . S OUT(1)="-99"_$$STATSEP^MAGVRS41_"Procedure Reference file is locked"
 Q:$D(OUT(1))
 D ATTACH^MAGVRS41(.OUT,2005.61,.PROCATTS)
 L -^MAGV(2005.61)
 Q
CREPAT(OUT,PATATTS) ;RPC - create a new patient reference
 L +^MAGV(2005.6):60 E  D  ; P257 DAC - Lock Patient Reference file to prevent duplicates  
 . S OUT(1)="-99"_$$STATSEP^MAGVRS41_"Patient Reference file is locked"
 Q:$D(OUT(1))
 D ATTACH^MAGVRS41(.OUT,2005.6,.PATATTS)
 L -^MAGV(2005.6)
 Q
UPDPAT(OUT,PATATTS,OVERRIDE) ;RPC - update patient
 D UPDATE^MAGVRS41(.OUT,2005.6,.PATATTS,$G(OVERRIDE))
 Q
FINDPAT(OUT,PATATTS) ; RPC - find patient by attributes
 D STATUS^MAGVRS07(.PATATTS)
 D FINDBYAT^MAGVRS42(.OUT,2005.6,.PATATTS)
 Q
INPAT(OUT,PATIEN) ; RPC - inactivate patient
 D INACTIVT^MAGVRS41(.OUT,2005.6,$G(PATIEN),0,0)
 Q

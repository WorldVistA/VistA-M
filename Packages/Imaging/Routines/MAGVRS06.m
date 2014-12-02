MAGVRS06 ;WOIFO/MLH,DAC - RPC calls for DICOM file processing ; 13 Apr 2010 5:23 PM
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
ATPROC(OUT,PROCATTS) ;RPC - create a new procedure reference
 D ATTACH^MAGVRS41(.OUT,2005.61,.PROCATTS)
 Q
CREPAT(OUT,PATATTS) ;RPC - create a new patient reference
 D ATTACH^MAGVRS41(.OUT,2005.6,.PATATTS)
 Q
UPDPAT(OUT,PATATTS,OVERRIDE) ;RPC - update patient
 D UPDATE^MAGVRS41(.OUT,2005.6,.PATATTS,$G(OVERRIDE))
 Q
FINDPAT(OUT,PATATTS) ; RPC - find patient by attributes
 D FINDBYAT^MAGVRS42(.OUT,2005.6,.PATATTS)
 Q
INPAT(OUT,PATIEN) ; RPC - inactivate patient
 D INACTIVT^MAGVRS41(.OUT,2005.6,$G(PATIEN),0,0)
 Q

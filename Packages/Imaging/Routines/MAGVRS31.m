MAGVRS31 ;WOIFO/DAC - RPC calls for DICOM file processing ; 12 Jan 2012 1:39 AM
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
UPDFILE(OUT,FILEATTS,OVERRIDE) ;RPC - MAGV UPDATE IMAGE FILE
 D UPDATE^MAGVRS41(.OUT,2005.65,.FILEATTS,$G(OVERRIDE))
 Q
GETFILE(OUT,SOPIEN,FILEIEN,OVERRIDE) ;RPC - MAGV GET IMAGE FILE
 D REFRESH^MAGVRS41(.OUT,2005.65,$G(FILEIEN),$G(SOPIEN),$G(OVERRIDE))
 Q
INFILE(OUT,FILEIEN,SOPIEN,OVERRIDE) ; RPC - MAGV INACTIVATE INSTANCE FILE
 D INACTIVT^MAGVRS41(.OUT,2005.65,$G(FILEIEN),$G(SOPIEN),$G(OVERRIDE))
 Q

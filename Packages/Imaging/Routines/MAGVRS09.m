MAGVRS09 ;WOIFO/MLH - RPC calls for DICOM file processing ; 12 Jan 2012 5:14 PM
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
 ;
TRAVPROC(OUT,IEN,DIR,CHILDIEN) ; RPC - MAGV TRAVERSE PROC REF
 D TRAVERSE^MAGVRS45(.OUT,2005.6,$G(IEN),$G(DIR),$G(CHILDIEN))
 Q
TRAVSTDY(OUT,IEN,DIR,CHILDIEN) ; RPC - MAGV TRAVERSE STUDY
 D TRAVERSE^MAGVRS45(.OUT,2005.61,$G(IEN),$G(DIR),$G(CHILDIEN))
 Q
TRAVSERS(OUT,IEN,DIR,CHILDIEN) ; RPC - MAGV TRAVERSE SERIES
 D TRAVERSE^MAGVRS45(.OUT,2005.62,$G(IEN),$G(DIR),$G(CHILDIEN))
 Q
TRAVSOP(OUT,IEN,DIR,CHILDIEN) ; RPC - MAGV TRAVERSE SOP
 D TRAVERSE^MAGVRS45(.OUT,2005.63,$G(IEN),$G(DIR),$G(CHILDIEN))
 Q
TRAVIMG(OUT,IEN,DIR,CHILDIEN) ; RPC - MAGV TRAVERSE IMAGE FILE
 D TRAVERSE^MAGVRS45(.OUT,2005.64,$G(IEN),$G(DIR),$G(CHILDIEN))
 Q

MAGSDEL4 ;WOIFO/GEK - Find DA for Image delete function ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**8**;Sep 15, 2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
GETDA(PPTR,DA1,MAGDA,DA) ; DA must be passed by reference.  
 ; The Calling routine checks DA to see if a valid DA was found
 ; for the MAGDA (Image IEN) sent.
 N MAGX
 D FILE^DID(PPTR,"","GLOBAL NAME","MAGRT")
 Q:'$D(MAGRT("GLOBAL NAME"))
 S MAGX=$G(MAGRT("GLOBAL NAME"))_DA1_",2005,""B"","_MAGDA_",0)"
 S DA=$O(@MAGX)
 Q

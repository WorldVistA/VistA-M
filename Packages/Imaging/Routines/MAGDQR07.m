MAGDQR07 ;WOIFO/EdM,MLH,BT - Imaging RPCs for Query/Retrieve ; 10 May 2012 11:55 AM
 ;;3.0;IMAGING;**54,118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; -- overflow from MAGDQR02
 ;
ACCNUM(REQ,T,ACC,ANY) ; TAG = 0008,0050  R  Accession Number
 N P
 S P="" F  S P=$O(REQ(T,P)) Q:(P="")  D:(REQ(T,P)'="")&((REQ(T,P))'="GMRC-")
 . S ANY=1
 . D ACCNEW^MAGDQR71(.REQ,T,P,.ACC) ; first look in the new database structure
 . D ACCRAD^MAGDQR72(.REQ,T,P,.ACC) ; then look for old radiology images
 . D ACCCON^MAGDQR73(.REQ,T,P,.ACC) ; finally look for old consult images
 . Q
 Q

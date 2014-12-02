MAGVUID1 ;WOIFO/RRB - DICOM UID Generator ; 19 Sep 2011 6:10 PM
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
 ;
STUDY(UID,SITE,ID) ; generate a Study uid
 N TYPE
 S UID=$$UID(4,SITE,ID)
 Q
 ;
SERIES(UID,SITE,ID) ; generate a Series uid
 N TYPE
 S UID=$$UID(7,SITE,ID)
 Q
 ;
SOP(UID,SITE,ID) ; generate a SOP uid
 N TYPE
 S UID=$$UID(8,SITE,ID)
 Q
 ;
 ;
UID(TYPE,SITE,NUMBER) ; generate a UID
 N X,I,UID
 S X=""
 F I=1:1:$L(SITE) S X=X_$S($E(SITE,I)?1N:$E(SITE,I),1:$A(SITE,I))
 S UID=$G(^MAGD(2006.15,1,"UID ROOT"))_".1."_TYPE_"."_X
 I $D(NUMBER) S UID=UID_"."_NUMBER
 ; Remove leading 0s from UID components
 F I=1:1:$L(UID,".") S $P(UID,".",I)=+$P(UID,".",I)
 I $L(UID)>64 S UID="-3~Generated UID > 64 Characters"  ; fatal error
 ;
 Q UID
 ;

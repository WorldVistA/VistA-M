MAGDQR73 ;WOIFO/MLH - Imaging RPCs for Query/Retrieve - acc# scan for consult recs (old DB) ; 07 Mar 2013 10:18 AM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; called from MAGDQR07
 ;
ACCCON(REQ,T,P,ACC) ; scan old structure for Consult Related Images
 N TMPQ,ACCNUM,GMRCIEN,I,D0,MAGDFN,IMAGE,X,RESULT
 S TMPQ=$NA(^TMP("MAG",$J,"QR")) K @TMPQ@(5)
 S (ACCNUM,GMRCIEN)=REQ(T,P)
 S X=$$GMRCIEN^MAGDFCNV(ACCNUM) I X S GMRCIEN=X
 ; For the time being, we can only do this:
 S:GMRCIEN @TMPQ@(5,GMRCIEN)=""
 S I=$$MATCHD^MAGDQR03(GMRCIEN,"^GMR(123,LOOP)","@TMPQ@(5,LOOP)")
 S D0="" F  S D0=$O(^TMP("MAG",$J,"QR",5,D0)) Q:D0=""  D
 . S MAGDFN=$$GET1^DIQ(123,D0,.02,"I") Q:'MAGDFN  ; No Patient IEN
 . Q:$$GET1^DIQ(123,D0,8)="CANCELLED"
 . I $O(^MAG(2006.5839,"C",123,D0,0)) D  Q  ; 1+ studies assoc w/consult
 . . S IMAGE=0
 . . F  S IMAGE=$O(^MAG(2006.5839,"C",123,D0,IMAGE)) Q:'IMAGE  D
 . . . S X=$G(^MAG(2006.5839,IMAGE,0)) Q:X=""
 . . . S X=MAGDFN_"^"_$P(X,"^",1)_"^"_$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_GMRCIEN
 . . . S @TMPQ@(6,"C^"_X)="",ACC=1
 . . . Q
 . . Q
 . D  ; Otherwise find images in ^TIU
 . . D TIUALL^MAGDGMRC(D0,.RESULT)
 . . S I="" F  S I=$O(RESULT(I)) Q:I=""  D
 . . . S X=MAGDFN_"^8925^"_$P(RESULT(I),"^",1)_"^"_$P(RESULT(I),"^",3)_"^"_$P(RESULT(I),"^",2)
 . . . S @TMPQ@(6,"C^"_X)="",ACC=1
 . . . Q
 . . Q
 . Q
 Q

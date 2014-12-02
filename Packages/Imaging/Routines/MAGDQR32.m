MAGDQR32 ;WOIFO/MLH - UID query return logic for C-FIND ; 30 Dec 2011 4:09 PM
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
UIDOLD(IMAGE,REQ,RESULT,MAGDUZ,PAT,SSN,ACC,SID,UID,FD,LD) ; Generate response data to pat name / SSN query - called from MAGDQR02
 N X,P,V,MAGD0,MAGD1,MAGD2
 I $G(MAGDUZ)="" D ERR^MAGDQRUE("No Imaging user defined for this query"),ERRSAV^MAGDQRUE Q
 I $G(RESULT)="" D ERR^MAGDQRUE("No results set to save to"),ERRSAV^MAGDQRUE Q
 I '$G(IMAGE) D ERR^MAGDQRUE("Invalid IMAGE file pointer: '"_$G(IMAGE)_"'"),ERRSAV^MAGDQRUE Q
 S X=$G(^MAG(2005,IMAGE,0)),P=+$P(X,"^",7)
 I $G(PAT)+$G(SSN),P,'$D(^TMP("MAG",$J,"QR",11,P)) Q
 S X=$G(^MAG(2005,IMAGE,2))
 S V=$P(X,"^",5),FD=$G(FD),LD=$G(LD) I V,(FD&(V<FD))!(LD&(V>LD)) Q  ; UNIT TEST!!
 S V=$P(X,"^",6)
 ; Radiology Image
 I V=74 D  Q  ; Radiology Image
 . S X=$G(^RARPT(+$P(X,"^",7),0)) ; IA # 1171
 . S MAGD0=$P(X,"^",2),MAGD1=9999999.9999-$P(X,"^",3),V=$P(X,"^",4)
 . S MAGD2=$O(^RADPT(MAGD0,"DT",MAGD1,"P","B",V,"")) ; IA # 1172
 . I $G(ACC)+$G(SID),'$D(^TMP("MAG",$J,"QR",12,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)) Q  ; UNIT TEST!!
 . D RESULT^MAGDQR03("R",.REQ,RESULT,IMAGE,MAGDUZ,MAGD0,MAGD1,MAGD2)
 . Q
 ; Consult Image
 I (V=8925)!(V=2006.5839) D RESULT^MAGDQR03("C",.REQ,RESULT,IMAGE,MAGDUZ,P,0,0) Q
 Q

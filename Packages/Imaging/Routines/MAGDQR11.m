MAGDQR11 ;WOIFO/MLH - UID logic for C-FIND - process rad entries from old DB structure ; 25 Jan 2012 11:43 AM
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
ACCSIDRA(IARRAY,P,PAT,SSN,UID,MAGD0,MAGD1,MAGD2) ; Radiology images (old DB structure) case - called from ACCSID^MAGDQR10
 N OK,V,P1,P2,P3,P4
 S MAGD0=$P(P,"^",2),MAGD1=$P(P,"^",3),MAGD2=$P(P,"^",4)
 I PAT+SSN,'$D(^TMP("MAG",$J,"QR",11,MAGD0)) Q
 S OK=0 D  Q:'OK
 . S V=$P($G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0)),"^",17) Q:'V  ; IA # 1172
 . S P1=0 F  S P1=$O(^RARPT(V,2005,P1)) Q:'P1  D  Q:OK  ; IA # 1171
 . . S P2=+$G(^RARPT(V,2005,P1,0)) Q:'P2  ; IA # 1171
 . . I UID,$D(^TMP("MAG",$J,"QR",8,P2)) S OK=1,IARRAY(P2)="" Q
 . . ; don't set 'OK' flag next line, allow mult. studies per acc#
 . . I 'UID S IARRAY(P2)="" Q
 . . S P3=0 F  S P3=$O(^MAG(2005,P2,1,P3)) Q:'P3  D  Q:OK
 . . . S P4=$P($G(^MAG(2005,P2,1,P3,0)),"^",1) Q:'P4
 . . . I UID,$D(^TMP("MAG",$J,"QR",8,P4)) S OK=1,IARRAY(P4)="" Q
 . . . ; don't set 'OK' flag next line, allow mult. studies / acc# (?? - EdM comment)
 . . . I 'UID S OK=1,IARRAY(P4)="" Q
 . . . Q
 . . Q
 . Q
 Q

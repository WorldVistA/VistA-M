MAGDQR23 ;WOIFO/EdM,MLH - UID logic for C-FIND - return results for rad studies in old DB structure ; 25 Jan 2012 11:47 AM
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
PATSSNOL(IMAGE,REQ,RESULT,MAGDUZ,FD,LD,ERROR,FATAL) ; Radiology images (old DB structure) case - called from PATSSN^MAGDQR02
 N X,V,MAGD0,MAGD1,MAGD2
 Q:$P($G(^MAG(2005,IMAGE,0)),"^",10)
 S X=$G(^MAG(2005,IMAGE,2))
 S V=$P(X,"^",5) I V,(V<FD)!(V>LD) Q  ; study out of date range
 S V=$P(X,"^",6)
 I V=74 D  Q  ; Radiology Image
 . S V=$P(X,"^",5) I V,(V<FD)!(V>LD) Q
 . S X=$G(^RARPT(+$P(X,"^",7),0)) ; IA # 1171
 . S MAGD0=$P(X,"^",2),MAGD1=9999999.9999-$P(X,"^",3),V=$P(X,"^",4)
 . S MAGD2=$O(^RADPT(MAGD0,"DT",MAGD1,"P","B",V,"")) ; IA # 1172
 . D RESULT^MAGDQR03("R",.REQ,RESULT,IMAGE,MAGDUZ,MAGD0,MAGD1,MAGD2,.ERROR,.FATAL)
 . Q
 I (V=8925)!(V=2006.5839) D  Q  ; Consult Image
 . S MAGD0=+$P($G(^MAG(2005,IMAGE,0)),"^",7)
 . D RESULT^MAGDQR03("C",.REQ,RESULT,IMAGE,MAGDUZ,MAGD0,0,0,.ERROR,.FATAL)
 . Q
 Q

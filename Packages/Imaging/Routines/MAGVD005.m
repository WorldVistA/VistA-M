MAGVD005 ;WOIFO/MLH - Delete study by accession number - collect study summary info ; 03-Feb-12 04:39 PM
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
GETSTDY(IARRAY,P,MAGD0,MAGD1,MAGD2,PROC) ; Get summary data for Radiology images (old DB structure)
 N V,P1,MAGIEN
 S MAGD0=$P(P,"^",2),MAGD1=$P(P,"^",3),MAGD2=$P(P,"^",4)
 I MAGD0'="",MAGD1'="",MAGD2'="" D
 . S V=$P($G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0)),"^",17) Q:'V  ; IA # 1172
 . S P1=0 F  S P1=$O(^RARPT(V,2005,P1)) Q:'P1  D  ; IA # 1171
 . . S MAGIEN=+$G(^RARPT(V,2005,P1,0)) ; IA # 1171
 . . S:MAGIEN IARRAY(MAGIEN)=""
 . . Q
 . S PROC=$$GET1^DIQ(70.03,MAGD2_","_MAGD1_","_MAGD0,2)
 . Q
 Q

MAGDHWR ;WOIFO/EdM - RPCs for ADT ; 31 Aug 2010 2:19 PM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
GETPAT(OUT,DFN) ; RPC = MAG DICOM GET PATIENT VITALS
 N GMRVSTR,IDX,N,REVDAT,T,UNITS,VIEN,X
 K OUT
 I '$G(DFN) S OUT(1)="-1,No DFN specified" Q
 I $$GET1^DIQ(2,DFN,.01)="" S OUT(1)="-2,No Patient has DFN """_DFN_"""." Q
 ;
 K ^UTILITY($J,"GMRVD") ; refresh the return array
 S GMRVSTR="HT;WT"
 S GMRVSTR(0)="^^1" ; one occurrence each of height and weight
 D EN1^GMRVUT0 ; IA # 14 (currently retired, though)
 S N=0
 ;
 S UNITS("HT")="HEIGHT^^m^meter"
 S UNITS("WT")="WEIGHT^^kg^kilogram"
 ;
 ; Height and Weight
 F IDX="HT","WT" D:$D(^UTILITY($J,"GMRVD",IDX))
 . S REVDAT=$O(^UTILITY($J,"GMRVD",IDX,0)) Q:'REVDAT
 . S VIEN=$O(^UTILITY($J,"GMRVD",IDX,REVDAT,"")) Q:'VIEN
 . ; if a measurement exists, populate the message array
 . S X=UNITS(IDX)
 . S T=$P($G(^UTILITY($J,"GMRVD",IDX,REVDAT,VIEN)),U,13)
 . ; Height is provided in centimeters, should be returned in meters
 . S:IDX="HT" T=T/100
 . S $P(X,"^",2)=T
 . S N=N+1,OUT(N)=X
 . Q
 ;
 ; VIP Indicator
 ;E - Patient is a VA employee
 ;S - Patient record is sensitive
 ;ES - Patient is a VA employee and patient record is sensitive
 S X=$S($$EMPL^DGSEC4(DFN)=1:"E",1:"") ; IA # 3646
 S X=X_$S($P($G(^DGSL(38.1,DFN,0)),"^",2)=1:"S",1:"") ; IA # 767
 S N=N+1,OUT(N)="VIP^"_X
 Q

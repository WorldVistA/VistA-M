MAGDQR22 ;WOIFO/EdM,MLH - Pt ID / SSN logic for C-FIND - find matching rad studies in new DB structure ; 23 Dec 2011 12:55 AM
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
PATSSNNU(P,REQ,RESULT,MAGDUZ,PAT,SSN,UID,FD,LD,ERROR,FATAL) ; Generate response data to pt ID / SSN query from new DB structure - called from PATSSN^MAGDQR20
 N PATIX,PATREC,PATDFN,PROCIX,STYIX,STYDATE,SERIX,SOPIX,SOPQUIT,SERQUIT
 S FD=$G(FD),LD=$G(LD)
 S PATIX="" F  S PATIX=$O(^MAGV(2005.6,"B",P,PATIX)) Q:'PATIX  D
 . S PATREC=$G(^MAGV(2005.6,PATIX,0)) Q:PATREC=""  Q:$P(PATREC,"^",3)'="D"
 . S PATDFN=$P(PATREC,"^",1)
 . S PROCIX="" F  S PROCIX=$O(^MAGV(2005.61,"C",PATIX,PROCIX)) Q:'PROCIX  D
 . . Q:$P($G(^MAGV(2005.61,PROCIX,0)),"^",5)'="A"  ; not active
 . . S STYIX="" F  S STYIX=$O(^MAGV(2005.62,"C",PROCIX,STYIX)) Q:'STYIX  D
 . . . S STYDATE=$P($G(^MAGV(2005.62,STYIX,2)),"^",1)
 . . . I STYDATE Q:FD&(STYDATE<FD)  Q:LD&(STYDATE>LD)  ; study out of date range (if specified)
 . . . Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . . S SERIX="" F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D  Q:$G(SERQUIT)
 . . . . S SOPIX="" F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D  Q:$G(SOPQUIT)
 . . . . . D RESULT^MAGDQR03("N",.REQ,RESULT,SOPIX,MAGDUZ,PATDFN,0,0,.ERROR,.FATAL)
 . . . . . S SOPQUIT=1 ; always true for study & series level query - adjust later for SOP level 
 . . . . . Q
 . . . . S SERQUIT=1 ; always true for study level query - adjust later for series, SOP level
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q

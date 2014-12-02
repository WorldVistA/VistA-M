MAGDQR31 ;WOIFO/MLH - UID query return logic for C-FIND - new DB ; 25 Jan 2012 11:47 AM
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
UIDNEW(P,REQ,RESULT,MAGDUZ,PAT,SSN,UID,FD,LD) ; Generate response data from new DB to pat name / SSN query - called from MAGDQR02
 N STYIX,PROCIX,PATIX,PATREC,PATDFN,SERIX,SOPIX,SERQUIT,SOPQUIT
 I $G(MAGDUZ)="" D ERR^MAGDQRUE("No Imaging user defined for this query"),ERRSAV^MAGDQRUE Q
 I $G(RESULT)="" D ERR^MAGDQRUE("No results set to save to"),ERRSAV^MAGDQRUE Q
 S P=$G(P),STYIX=$E(P,2,$L(P))
 I STYIX="" D ERR^MAGDQRUE("Null image pointer in results set"),ERRSAV^MAGDQRUE Q
 Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)="I"  ; inaccessible
 S PROCIX=$P($G(^MAGV(2005.62,STYIX,6)),"^",1) Q:'PROCIX
 S PATIX=$P($G(^MAGV(2005.61,PROCIX,6)),"^",1) Q:'PATIX
 S PATREC=$G(^MAGV(2005.6,PATIX,0)) Q:PATREC=""
 S:$P(PATREC,"^",3)="D" PATDFN=$P(PATREC,"^",1) Q:$G(PATDFN)=""
 I $G(PAT)+$G(SSN),'$D(^TMP("MAG",$J,"QR",11,P)) Q
 S SERIX="" F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D  Q:$G(SERQUIT)
 . S SOPIX="" F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D  Q:$G(SOPQUIT)
 . . D RESULT^MAGDQR03("N",.REQ,RESULT,SOPIX,MAGDUZ,PATDFN,0,0)
 . . S SOPQUIT=1 ; always true for study & series level query - adjust later for SOP level 
 . . Q
 . S SERQUIT=1 ; always true for study level query - adjust later for series, SOP level
 . Q
 Q

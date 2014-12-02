MAGUE004 ;WOIFO/MLH - database encapsulation - find study instance IEN for an image instance (new DB) ; 24 Feb 2012 10:10 PM
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
STUDYIX(MAGIEN) ; Find study instance IEN for an image instance (new DB)
 N SERIESIX,STUDYIX
 S STUDYIX=""
 D:MAGIEN
 . S SERIESIX=$P($G(^MAGV(2005.64,MAGIEN,6)),"^",1) Q:'SERIESIX
 . S STUDYIX=$P($G(^MAGV(2005.63,SERIESIX,6)),"^",1) Q:'STUDYIX
 . Q
 Q $G(STUDYIX)

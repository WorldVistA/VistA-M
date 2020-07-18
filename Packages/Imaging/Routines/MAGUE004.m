MAGUE004 ;WOIFO/MLH,DAC - database encapsulation - find study instance IEN for an image instance (new DB) ; May 27, 2020@09:36:15
 ;;3.0;IMAGING;**118,263**;Mar 19, 2002;Build 17
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
STUDYIX(IEN,IENTYPE) ; Find study instance IEN for an image instance (new DB)
 N SERIESIX,STUDYIX,SOPIX
 S STUDYIX=""
 D:IEN
 . ; P263 DAC - Default IEN parameter is SOP (#2005.64) file IEN
 . S SOPIX=IEN
 . ; P263 DAC - If IEN type is IMAGE then find SOP IEN from Image(#2005.65) file enrty
 . I $G(IENTYPE)="IMAGE" S SOPIX=$P($G(^MAGV(2005.65,IEN,6)),"^",1) Q:'SOPIX
 . ; P263 DAC - Fixed lookup to use Series IEN instead of Image IEN
 . S SERIESIX=$P($G(^MAGV(2005.64,SOPIX,6)),"^",1) Q:'SERIESIX
 . S STUDYIX=$P($G(^MAGV(2005.63,SERIESIX,6)),"^",1) Q:'STUDYIX
 . Q
 Q $G(STUDYIX)

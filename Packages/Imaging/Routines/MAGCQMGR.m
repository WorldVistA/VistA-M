MAGCQMGR ;HIE/ZEB - Precache Queue Manager ; 15 APR 2025@08:09
 ;;3.0;IMAGING;**365**;April 15, 2025;Build 19
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
TASK ;Option: MAG PRECACHE QUEUE MANAGER
 N TYPEIEN,NEWSTS,STNNUM,CUTOFFDT,UPDDT,WIIEN
 S TYPEIEN=$O(^MAGV(2006.9412,"B","PRECACHE",""))
 Q:TYPEIEN=""  ;Precache type doesn't exist; abort
 S NEWSTS=$O(^MAGV(2006.9413,"B","New",""))
 Q:NEWSTS=""  ;New status doesn't exist; abort
 S CUTOFFDT=$$FMADD^XLFDT($$NOW^XLFDT(),-7) ;7 days ago
 ;C x-ref is by TYPE, then STATUS, then STATION NUMBER, then UPDATE DATE/TIME, then finally Work Item IEN
 ;Find PRECACHE work items that are still in New status and at least 7 days old
 S STNNUM=""
 F  S STNNUM=$O(^MAGV(2006.941,"C",TYPEIEN,NEWSTS,STNNUM)) Q:STNNUM=""  D
 . S UPDDT=CUTOFFDT
 . F  S UPDDT=$O(^MAGV(2006.941,"C",TYPEIEN,NEWSTS,STNNUM,UPDDT),-1) Q:UPDDT=""  D
 .. S WIIEN=""
 .. F  S WIIEN=$O(^MAGV(2006.941,"C",TYPEIEN,NEWSTS,STNNUM,UPDDT,WIIEN)) Q:WIIEN=""  D
 ... D UPDITEM^MAGVIM01("",WIIEN,"New","CancelledStaging","","","PRECACHE")
 Q
 ;

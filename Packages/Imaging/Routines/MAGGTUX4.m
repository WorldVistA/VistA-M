MAGGTUX4 ;WIOFO/NST - Imaging utility to run in post install ; 06 Dec 2010 9:27 AM
 ;;3.0;IMAGING;**117**;Mar 19, 2002;Build 2238;Jul 15, 2011
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
UPD20051() ; Updates IMAGE AUDIT file (#2005.1)
 ; Returns 0 for success 
 ; and -39^Taskman has not scheduled the task for failure 
 N MAGDESC,MOTH,MAGRES,MSG,MAGRC
 S MAGDESC="Patch 117: Update of STATUS field (#113) in IMAGE AUDIT file (#2005.1)"
 S MOTH("ZTDTH")=$H
 S MAGRES=$$NODEV^XUTMDEVQ("UPD11312^MAGGTUX4",MAGDESC,"MAGDESC",.MOTH)
 I MAGRES<0 S MAGRC=$$ERROR^MAGUERR(-39) Q MAGRC  ; return
 ;--- Display the confirmation message
 K MSG
 S MSG(1)="It will update STATUS field (#113) in IMAGE AUDIT file (#2005.1)."
 D BMES^MAGKIDS("Task #"_MAGRES_" has been executed.",.MSG)
 Q 0
 ;
UPD2005() ; Updates IMAGE file (#2005) 
 ; Returns 0 for success 
 ; and -39^Taskman has not scheduled the task for failure 
 N MAGDESC,MOTH,MAGRES,MSG,MAGRC
 S MAGDESC="Patch 117: Update of STATUS field (#113) in IMAGE file (#2005)"
 S MOTH("ZTDTH")=$H
 S MAGRES=$$NODEV^XUTMDEVQ("UPD1131^MAGGTUX4",MAGDESC,"MAGDESC",.MOTH)
 I MAGRES<0 S MAGRC=$$ERROR^MAGUERR(-39) Q MAGRC
 ;--- Display the confirmation message
 K MSG
 S MSG(1)="It will update STATUS field (#113) in IMAGE file (#2005)."
 D BMES^MAGKIDS("Task #"_MAGRES_" has been executed.",.MSG)
 Q 0
 ;
UPD11312 ; Update STATUS field (#113) in IMAGE AUDIT file (#2005.1) to 12 (Deleted) 
 N MAGIEN
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2005.1,MAGIEN)) Q:'MAGIEN  D
 . ; Fix STATUS field (#113) data in IMAGE AUDIT file (#2005.1)
 . S:$D(^MAG(2005.1,MAGIEN,100)) $P(^MAG(2005.1,MAGIEN,100),U,8)=12
 . Q
 D PRD^MAGKIDS(2005.1,117,"A")  ; It won't process 2005.1 with every KIDS build
 Q
 ;
UPD1131 ; Update STATUS field (#113) in IMAGE file (#2005) to 1 (Viewable)
 ; when the value is blank
 N MAGIEN
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2005,MAGIEN)) Q:'MAGIEN  D
 . ; Set STATUS (113) to Viewable
 . I $D(^MAG(2005,MAGIEN,100)) S:$P(^MAG(2005,MAGIEN,100),U,8)="" $P(^MAG(2005,MAGIEN,100),U,8)=1
 . Q
 D PRD^MAGKIDS(2005,117,"A")  ; It won't process 2005 with every KIDS build
 ;
 Q

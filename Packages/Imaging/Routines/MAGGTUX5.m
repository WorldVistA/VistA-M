MAGGTUX5 ;WIOFO/BT - Imaging utility to run in post install ; 01 Mar 2012 4:05 pM
 ;;3.0;IMAGING;**119**;Mar 19, 2002;Build 4396;Apr 19, 2013
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
UPD20051() ; Updates IMAGE AUDIT file (#2005.1)
 ; Returns 0 for success 
 ; and -39^Taskman has not scheduled the task for failure 
 N MAGDESC,MOTH,MAGRES,MSG,MAGRC
 S MAGDESC="Patch 119: Build ""P"" Index in IMAGE AUDIT file (#2005.1)"
 S MOTH("ZTDTH")=$H
 S MAGRES=$$NODEV^XUTMDEVQ("NDXCP^MAGGTUX5",MAGDESC,"MAGDESC",.MOTH)
 I MAGRES<0 S MAGRC=$$ERROR^MAGUERR(-39) Q MAGRC  ; return
 ;--- Display the confirmation message
 K MSG
 S MSG(1)="It will build ""P"" Index in IMAGE AUDIT file (#2005.1)"
 D BMES^MAGKIDS("Task #"_MAGRES_" has been executed.",.MSG)
 Q 0
 ;
NDXCP ;BUILDS NEW INDEX IN FILE #2005.1  - ^MAG(2005.1,"P",PACSUID,D0)
 N MAGFILE
 N PACSUID
 N MAGIEN
 ;
 S MAGFILE=2005.1
 ;--- Process the file
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(MAGFILE,MAGIEN)) Q:'MAGIEN  D
 . S PACSUID=$P($G(^MAG(MAGFILE,MAGIEN,"PACS")),U)
 . Q:PACSUID=""
 . S ^MAG(MAGFILE,"P",PACSUID,MAGIEN)=""
 . Q
 Q

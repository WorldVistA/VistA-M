MAGTP005 ;WOIFO/FG/PMK/DAC - TELEPATHOLOGY RPCS ;30 Jun 2017 10:18 AM
 ;;3.0;IMAGING;**138,166,183**;Mar 19, 2002;Build 11;Sep 03, 2013
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
 Q  ;
 ;
 ; +++++ ADD A NEW ENTRY IN FILE (#2005.42) WHEN
 ;       GENERATING A NEW CASE FROM FILEMAN
 ;
 ; LRAC          Accession Code
 ;
ADD(LRAC) ;
 Q:$$TELEPATH()'="YES"  ; only add studies if switch is enabled - P183 PMK 5/19/17
 Q:'$$ISLRSSOK(LRSS)  ; check for supported anatomic pathology sections - P166 DAC localized AP check function
 ;
 N MAGFDA,MAGERR,NOW
 S NOW=$$NOW^XLFDT
 S MAGFDA(2005.42,"+1,",.01)=LRAC              ; Accession Number
 S MAGFDA(2005.42,"+1,",.02)=0                 ; Priority (0:ROUTINE, 1:HIGH, 2:STAT)
 S MAGFDA(2005.42,"+1,",.03)=0                 ; Slide available? (0:No, 1:Yes)
 S MAGFDA(2005.42,"+1,",.04)=0                 ; Method (0:TRADITIONAL, 1:ROBOTICS, 2:WSI)
 S MAGFDA(2005.42,"+1,",.05)="U"               ; Status (U:Unread, R:Read, C:Cancelled)
 S MAGFDA(2005.42,"+1,",.06)=NOW               ; Start
 S MAGFDA(2005.42,"+1,",.07)=NOW               ; Last Activity
 S MAGFDA(2005.42,"+1,",.08)=0                 ; Number of Images
 S MAGFDA(2005.42,"+1,",1)=0                   ; Reservation (0:Not Reserved, 1:Reserved)
 S MAGFDA(2005.42,"+1,",2)=0                   ; Second  Lock (Accession) (0:Unlocked, 1:Locked)
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 Q
 ;
STATUPDT(LRAC,STATUS) ; update the state of the case
 N IENS,MAGFDA,MAGERR,NOW
 ;
 Q:$G(LRAC)=""  Q:$G(STATUS)=""
 S STATUS=$E(STATUS) Q:"URC"'[STATUS
 ;
 S IENS=$O(^MAG(2005.42,"B",LRAC,"")) Q:'IENS
 ;
 ; update the entry
 S IENS=IENS_","
 S NOW=$$NOW^XLFDT
 S MAGFDA(2005.42,IENS,.05)=STATUS            ; Status (U:Unread, R:Read)
 S MAGFDA(2005.42,IENS,.07)=NOW               ; Last Activity
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 Q
 ;
CANCEL(LRAC) ; case cancelled - remove it from the file
 N DA,DIK,DA
 ;
 Q:$G(LRAC)=""
 S DA=$O(^MAG(2005.42,"B",LRAC,"")) Q:'DA
 ;
 ; delete the entry
 S DIK="^MAG(2005.42,"
 D ^DIK
 Q
 ;
IMAGECNT(LRAC,COUNT) ; update the number of images of the case
 N IENS,MAGFDA,MAGERR,NOW,NIMAGES,TOTAL
 ;
 Q:$G(LRAC)=""
 S COUNT=$G(COUNT,1)
 ;
 S IENS=$O(^MAG(2005.42,"B",LRAC,"")) Q:'IENS
 S IENS=IENS_","
 S NIMAGES=$$GET1^DIQ(2005.42,IENS,.08)
 S TOTAL=NIMAGES+COUNT
 ;
 ; update the entry
 S NOW=$$NOW^XLFDT
 S MAGFDA(2005.42,IENS,.07)=NOW               ; Last Activity
 S MAGFDA(2005.42,IENS,.08)=TOTAL             ; Number of Images
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 Q
 ;
TELEPATH() ; P183 PMK 5/19/17 - Get value of ENABLE TELEPATH WORKLIST switch
 N IENS
 S IENS=$O(^MAG(2006.1,"B",DUZ(2),""))_","
 Q $$GET1^DIQ(2006.1,IENS,205)
 ;
ISLRSSOK(LRSS) ; Check for supported anatomic pathology sections - P166 DAC moved AP check from MAGT7MA to MAGTP005
 ; So far we support only  CY, EM, or SP
 ; Return 1 - supported
 ;        0 - not supported
 Q LRSS?1(1"SP",1"CY",1"EM")

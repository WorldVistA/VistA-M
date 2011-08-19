MAGDTRLU ;WOIFO/OHH/PMK - Report discrepancies between files #2006.5849 & #123 and correct them ; 10/11/2006 08:53
 ;;3.0;IMAGING;**46**;16-February-2007;;Build 1023
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
 ; This routine automatically checks the data in file telereader
 ; read/unread list (file 2006.5849)and compares it with the
 ; request/consultation (file #123). If a telereader study is locked
 ; or unread and in the request/consult file it is completed or
 ; cancelled, then it updates the status of the study in the telereader
 ; read/unread list file, the "D" cross reference, and the reading
 ; start field is updated.
 Q
 ;
REPORT ; report problems with the Unread List
 D PASS("REPORT")
 Q
 ;
REPAIR ; repair problems with the Unread List
 D PASS("REPAIR")
 Q
 ;
PASS(MODE) ; report/repair problems for LOCKED and UNREAD studies
 N MSG
 S (MSG(1),MSG(3))=""
 ;
 ; PASS 1 - search for LOCKED cases that are completed/cancelled.
 S MSG(2)="Check for completed studies that have LOCKED status"
 I MODE="REPAIR" S MSG(2)=MSG(2)_" and correct them"
 W !! D HEADING^MAGDTRDX(.MSG)
 D SEARCH("LOCKED",MODE)
 ;
 ; PASS 2 - search for UNREAD cases that are completed/cancelled.
 S MSG(2)="Now check for completed studies that have UNREAD status"
 I MODE="REPAIR" S MSG(2)=MSG(2)_" and correct them"
 W !! D HEADING^MAGDTRDX(.MSG)
 D SEARCH("UNREAD",MODE)
 Q
 ;
SEARCH(STATUS,MODE) ; go through studies for each site, specialty and procedure
 N ACQSITE ; -- acquisition division number
 N ISPECIDX ; - image index for specialty
 N IPROCIDX ; - image index for procedure
 N UNREAD ; --- IEN of file telereader read/undread file #2006.5849
 N XREF ; ----- "D" cross reference: "L" for locked, "U" for unread
 N I
 ;
 S XREF=$E(STATUS)
 S ACQSITE=""
 F  S ACQSITE=$O(^MAG(2006.5849,"D",ACQSITE)) Q:ACQSITE=""  D
 . W !!,$$W("Acquisition Site:"),$$GET1^DIQ(4,ACQSITE,.01)
 . S ISPECIDX=""
 . F  S ISPECIDX=$O(^MAG(2006.5849,"D",ACQSITE,ISPECIDX)) Q:ISPECIDX=""  D
 . . W !,$$W("Specialty:"),$$GET1^DIQ(2005.84,ISPECIDX,.01)
 . . S IPROCIDX=""
 . . F  S IPROCIDX=$O(^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX)) Q:IPROCIDX=""  D
 . . . N COUNT ; -- array of counts of problems
 . . . W !,$$W("Procedure:"),$$GET1^DIQ(2005.85,IPROCIDX,.01) D
 . . . S UNREAD=""
 . . . F  S UNREAD=$O(^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,XREF,UNREAD)) Q:UNREAD=""  D CHECK
 . . . I '$D(COUNT) D  Q
 . . . . W !,$$W(""),"No inconsistencies were found.",!
 . . . . Q
 . . . S I="" F  S I=$O(COUNT(I)) Q:I=""  D
 . . . . W !,$$W($S(MODE="REPORT":"Problem:",1:"Repaired:"))
 . . . . W "Number of consults that have ",I," status in CPRS: ",COUNT(I)
 . . . . W !
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
CHECK ;check Unread List entry against that in CPRS Consult Requst Tracking
 N GMRCIEN ; -- IEN of file request/consultation (file #123)
 N GMRCSTS ; -- status of consult request - from ^ORD(100.01)
 ;
 S GMRCIEN=$P(^MAG(2006.5849,UNREAD,0),"^",1)
 S GMRCSTS=$$GET1^DIQ(123,GMRCIEN,8) ; cprs status
 I "^COMPLETE^CANCELLED^DISCONTINUED^DISCONTINUED/EDIT^EXPIRED^"[("^"_GMRCSTS_"^") D
 . S COUNT(GMRCSTS)=$G(COUNT(GMRCSTS))+1
 . I MODE="REPORT" D
 . . W !,$$W(""),"Consult # ",GMRCIEN," has the status of ",GMRCSTS," in CPRS"
 . . Q
 . E  I MODE="REPAIR" D  ; correct the entry
 . . W !,$$W("Fix:"),"Consult # ",GMRCIEN," which has the status of ",GMRCSTS," in CPRS"
 . . ; Note: The variable & value MODE="REPAIR" are used in ^MAGDTR03
 . . I GMRCSTS="COMPLETE" D
 . . . D COMPLETE^MAGDTR03
 . . . Q
 . . E  D CANCEL^MAGDTR03
 . . Q
 . Q
 Q
 ;
W(PROMPT) ; output prompt
 Q $J(PROMPT,16)_" "

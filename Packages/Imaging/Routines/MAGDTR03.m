MAGDTR03 ;WOIFO/PMK - Read a DICOM image file ; 30 Oct 2008 3:21 PM
 ;;3.0;IMAGING;**46,54**;03-July-2009;;Build 1424
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
 ;
ADD(OUT,GMRCIEN,EVENT,IMAGECNT) ; add an entry to the read/unread list
 N ACQSITE ;-- the site where the images were acquired
 N IFCIEN ;--- the IEN of the IFC consult at the reading site
 N IFCSITE ;-- 0 if not IFC
 N ISPECIDX ;- index to specialties - read/unread list sort key
 N IPROCIDX ;- index to procedures - read/unread list sort key (may be null)
 N STATUS ;--- status of unread list entry (Unread or Waiting)
 N TIMESTMP ;- FM date/time
 N TRIGGER ;-- create unread list trigger: Forward, Image, or Order
 N UNREAD ;-- pointer to entry in unread list
 N X
 ; should this consult be added to the Unread List?
 S OUT=0 ; return variable
 Q:$G(EVENT)=""  ; nope, an event F, I, or O must be specified
 Q:$$FINDLIST^MAGDTR01(GMRCIEN,.ISPECIDX,.IPROCIDX,.ACQSITE,.TRIGGER)<1
 S IMAGECNT=+$G(IMAGECNT) ; count of images
 ;
 S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN)
 I UNREAD="",EVENT'[TRIGGER Q  ; nope, don't create it now
 ;
 ; get IFC information
 S IFCSITE=$$GET1^DIQ(123,GMRCIEN,.07,"I") ; Routing Facility
 S IFCIEN=$$GET1^DIQ(123,GMRCIEN,.06,"I") ; remote consult file entry
 ;
 I UNREAD="" D  ; add record to the unread list
 . N X
 . L +^MAG(2006.5849,0):1E9 ; serial generation
 . S UNREAD=$O(^MAG(2006.5849," "),-1)+1 ; get next IEN
 . L +^MAG(2006.5849,UNREAD):1E9
 . S X=$G(^MAG(2006.5849,0))
 . S X="TELEREADER READ/UNREAD LIST^2006.5849^"_UNREAD_"^"_($P(X,"^",4)+1)
 . S ^MAG(2006.5849,0)=X
 . S ^MAG(2006.5849,UNREAD,0)=GMRCIEN_"^"_ACQSITE_"^"_ISPECIDX_"^"_IPROCIDX
 . L -^MAG(2006.5849,0) ; end serial generation
 . S TIMESTMP=$$TIMESTMP^MAGDTR02(UNREAD)
 . S $P(^MAG(2006.5849,UNREAD,0),"^",7)=TIMESTMP ; acquisition start d/t
 . S ^MAG(2006.5849,"B",GMRCIEN,UNREAD)=""
 . ;
 . ; set status -- if unpaired IFC, status="Waiting", otherwise "Unread"
 . S STATUS=$S(IFCSITE&'IFCIEN:"W",1:"U")
 . S $P(^MAG(2006.5849,UNREAD,0),"^",11)=STATUS
 . S ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,STATUS,UNREAD)=""
 . L -^MAG(2006.5849,UNREAD)
 . Q
 E  D
 . S TIMESTMP=$$TIMESTMP^MAGDTR02(UNREAD) ; update d/t piece of last activity
 . Q
 ;
 I IFCSITE D  ; record the IFC remote site times, if they are not set
 . ; save time the entry is added to the unread list, if not set
 . I $P($G(^MAG(2006.5849,UNREAD,0)),"^",5)="" S $P(^(0),"^",5)=TIMESTMP
 . I IFCIEN D
 . . ; IFC remote consult already created - save same time, if not set
 . . I $P($G(^MAG(2006.5849,UNREAD,0)),"^",6)="" S $P(^(0),"^",6)=TIMESTMP
 . . Q
 . Q
 ;
 I IMAGECNT D
 . S $P(^MAG(2006.5849,UNREAD,0),"^",8)=TIMESTMP ; last acquisition d/t
 . S $P(^(0),"^",10)=$P(^MAG(2006.5849,UNREAD,0),"^",10)+IMAGECNT
 . Q
 ;
 S OUT=UNREAD
 Q
 ;
COMPLETE ; entry point from ^MAGDTR01 & ^MAGDTRLU for COMPLETED consults
 N LOCATION,MAGPTR,TIMESTMP,UNREAD
 S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN)
 S TIMESTMP=$$STATUPDT^MAGDTR02(UNREAD,"R")
 I TIMESTMP D  ; changed status to Resulted
 . D FINISH ; record who updated the consult
 . ; check if there is an image
 . S MAGPTR=$O(^MAG(2006.5839,"C",123,GMRCIEN,0))
 . I MAGPTR,'$$TIULAST^MAGDGMRC(GMRCIEN) D
 . . ; there is an image but no TIU note
 . . D TIUNOTE ; create a TIU note for the image
 . . Q
 . Q
 Q
 ;
CANCEL ; entry point from ^MAGDTR01 & ^MAGDTRLU for CANCELLED consults
 N TIMESTMP,UNREAD
 S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN)
 S TIMESTMP=$$STATUPDT^MAGDTR02(UNREAD,"C")
 I TIMESTMP D  ; changed status to Cancelled
 . ; remove any old data about the reading activities
 . S $P(^MAG(2006.5849,UNREAD,0),"^",12,16)="^^^^"
 . D FINISH ; record who cancelled the consult
 . Q
 Q
 ;
FINISH ; finalize resulted or cancelled consult
 N DUZACQ,FULLNAME,INITIALS,LOCKNAME,X
 ; record who resulted or cancelled the consult
 ;
 I $G(MODE)="REPAIR" G REPAIR ; set in ^MAGDTRLU
 ;
 ; process the transaction
 I $D(HLNEXT) D  ; IFC - data comes from HL7 message
 . D GETHL7B^MAGDTR01(.FULLNAME,.LOCATION)
 . ; if resulter is not the person who locked the study, update name
 . S LOCKNAME=$P(^MAG(2006.5849,UNREAD,0),"^",12)
 . I LOCKNAME'=FULLNAME,FULLNAME'="" D  ; not the same person, update
 . . ; look up resulter in file 200 - check for >1 people with same name
 . . S DUZACQ=$$FIND1^DIC(200,"","BX",FULLNAME) ; IA # 10060
 . . S INITIALS=$$GET1^DIQ(200,DUZACQ,1) ; initial
 . . ; DUZread (piece 4) is not known - set to null
 . . S X=FULLNAME_"^"_INITIALS_"^"_DUZACQ_"^^"_LOCATION
 . . S $P(^MAG(2006.5849,UNREAD,0),"^",12,16)=X ; reader identification
 . . Q
 . Q
 E  D  ; local consult - FULLNAME array is for IFCs only
 . ; record the id of the resulter - DUZ comes from RPC session
 . ; assumes that the results were entered directly, not via IFC/HL7
 . S FULLNAME=$$GET1^DIQ(200,DUZ,.01)
 . S INITIALS=$$GET1^DIQ(200,DUZ,1) ; initial
 . S X=FULLNAME_"^"_INITIALS_"^"_DUZ_"^"_DUZ_"^"_DUZ(2) ; DUZacq=DUZread
 . S $P(^MAG(2006.5849,UNREAD,0),"^",12,16)=X ; reader identification
 . Q
 ;
 D EXREF(UNREAD,TIMESTMP) ; set "E" cross-reference
 Q
 ;
EXREF(UNREAD,TIMESTMP) ; set cancellation or reading stop date/time and "E" cross-reference
 N ACQSITE ;-- acquisition site
 N LISTDATA ;- read/unread list data
 Q:UNREAD=""  Q:TIMESTMP=""
 S LISTDATA=^MAG(2006.5849,UNREAD,0)
 S ACQSITE=$P(LISTDATA,"^",2) Q:ACQSITE=""
 S $P(^MAG(2006.5849,UNREAD,0),"^",18)=TIMESTMP
 S ^MAG(2006.5849,"E",ACQSITE,TIMESTMP\1,UNREAD)=""
 Q
 ;
REPAIR ; code to repair a defective unread list entry
 N ACTIVITY,DUZACQ,FULLNAME,HIT,I,IFCSITE,INITIALS,LOCATION,SUBFILE,TIMESTMP
 S IFCSITE=$$GET1^DIQ(123,GMRCIEN,.07,"I") ; routing facility
 ;
 ; first find the consult request tracking "completion" activity in cprs 
 S HIT=0 F I=1:1 D  Q:HIT  Q:ACTIVITY=""
 . S SUBFILE=I_","_GMRCIEN ; format: <subfile ien>,<gmrc ien>
 . S ACTIVITY=$$GET1^DIQ(123.02,SUBFILE,1) ; activity - from ^GMR(123.1)
 . I ACTIVITY="COMPLETE/UPDATE" S HIT=1
 . E  I ACTIVITY="CANCELLED" S HIT=2
 . E  I ACTIVITY="DISCONTINUED" S HIT=3
 . Q
 I 'HIT S SUBFILE=(I-1)_","_GMRCIEN ; use the last entry
 ;
 ; now make the corrections
 S TIMESTMP=$$GET1^DIQ(123.02,SUBFILE,2,"I") ; date/time of actual activity
 S DUZACQ=$$GET1^DIQ(123.02,SUBFILE,3,"I") ; who's responsible for activity
 I DUZACQ D  ; action was perfomed locally
 . S FULLNAME=$$GET1^DIQ(200,DUZACQ,.01) ; name
 . S INITIALS=$$GET1^DIQ(200,DUZACQ,1) ; initials
 . S LOCATION=ACQSITE
 . S X=FULLNAME_"^"_INITIALS_"^"_DUZACQ_"^"_DUZACQ_"^"_ACQSITE ; DUZacq=DUZread
 . Q
 E  I IFCSITE D  ; remotely completed IFC
 . S FULLNAME=$$GET1^DIQ(123.02,SUBFILE,.22) ; remote responsible person
 . ; look up resulter in file 200 - check for >1 people with same name
 . S DUZACQ=$$FIND1^DIC(200,"","BX",FULLNAME) ; IA # 10060
 . S INITIALS=$$GET1^DIQ(200,DUZACQ,1) ; initials
 . ; DUZread (piece 4) is not known - set to null
 . S X=FULLNAME_"^"_INITIALS_"^"_DUZACQ_"^^"_IFCSITE
 . Q
 E  S X="^^^^" ; problem with cprs consult
 S $P(^MAG(2006.5849,UNREAD,0),"^",12,16)=X ; reader identification
 S $P(^MAG(2006.5849,UNREAD,0),"^",19)=$$NOW^XLFDT() ; Record Repair TimeStamp in piece 19 Field #18
 D EXREF(UNREAD,TIMESTMP) ; set "E" cross-reference
 Q
 ;
TIUNOTE ; create a TIU result note, if one is not present
 N DUZ ; this is called by the HL7 - DUZ and DUZ(2) are not set
 N MAGDFN,MAGTEXT,MAGTITLE,UNREAD,XECUTE,ZZ
 Q:'$D(HLNEXT)  ; only create TIU result note for IFCs
 Q:'$$FINDLIST^MAGDTR01(GMRCIEN,,,,,.MAGTITLE)
 S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN) Q:'UNREAD
 S MAGTEXT(1)="Please refer to Inter-facility Consult for results."
 S MAGTEXT(2)=""
 S MAGTEXT(3)="Automatically generated note - signature not required."
 S DUZ=$P(^MAG(2006.5849,UNREAD,0),"^",14) Q:'DUZ  ; get DUZacq
 S DUZ(0)="@",DUZ(2)=LOCATION ; get reading site ien
 S MAGDFN=$$GET1^DIQ(123,GMRCIEN,.02,"I")
 D NEW^MAGGNTI1(.ZZ,MAGDFN,MAGTITLE,1,"E",,DUZ,,,GMRCIEN,.MAGTEXT)
 Q
 ;

MAGDTR02 ;WOIFO/PMK - Unread List for Consult/Procedure Request ; 05/18/2007 11:23
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
FORWARD ; entry point from ^MAGDT01 for a FORWARD request
 N FWDFROM ;-- forwarded from service
 N ISPECIDX ;- index to specialties - read/unread list sort key
 N IPROCIDX ;- index to procedures - read/unread list sort key (may be null)
 N LISTDATA ;- read/unread list data
 N UNREAD ;--- pointer to an entry in the read/unread list
 N OUNREAD,NUNREAD ; old and new unread list dictionary pointers
 N OACQSITE,NACQSITE ; old and new unread list acquisition sites
 N OPROCIDX,NPROCIDX ; old and new unread list procedure indexes
 N OSPECIDX,NSPECIDX ; old and new unread list specialty indexes
 N NEWENTRY ; - pointer to new entry in unread list
 N I,X
 ;
 ; get previous service from REQUEST PROCESSING ACTIVITY
 S FWDFROM=$$FWDFROM^MAGDGMRC(GMRCIEN) ; FORWARDED FROM service
 S OUNREAD=$$FINDLIST^MAGDTR01(GMRCIEN,.OSPECIDX,.OPROCIDX,.OACQSITE,,,FWDFROM)
 S NUNREAD=$$FINDLIST^MAGDTR01(GMRCIEN,.NSPECIDX,.NPROCIDX,.NACQSITE)
 ;
 I 'OUNREAD,'NUNREAD Q  ; neither old nor new TO SERVICE have unread lists
 ;
 I 'OUNREAD,NUNREAD D  Q  ; only new TO SERVICE has an unread list
 . N D0,IMAGECNT,MAGIEN,TRIGGER
 . S IMAGECNT=0
 . ; count the number of images, if any
 . S D0="" F  S D0=$O(^MAG(2006.5839,"C",123,GMRCIEN,D0)) Q:'D0  D
 . . S MAGIEN=$P($G(^MAG(2006.5839,D0,0)),"^",3)
 . . I MAGIEN D  ; make sure you got a good group pointer
 . . . ; get #images from Object Group file (2005.04)
 . . . S IMAGECNT=IMAGECNT+$P($G(^MAG(2005,MAGIEN,1,0)),"^",4)
 . . . Q
 . . Q
 . S TRIGGER=$S(IMAGECNT:"I",1:"")_"OF"
 . ; create the new unread list entry
 . D ADD^MAGDTR03(.NEWENTRY,GMRCIEN,TRIGGER,IMAGECNT)
 . Q
 ;
 I OUNREAD,'NUNREAD D  Q  ; only old TO SERVICE has an unread list
 . S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN)
 . S X=$$STATUPDT^MAGDTR02(UNREAD,"D") ; set status of old entry to DELETE
 . Q
 ;
 ; both the old TO SERVICE and the new TO SERVICE have unread lists
 ; 
 ; are the old and new unread lists the same?
 ;
 S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN)
 I OACQSITE=NACQSITE,OSPECIDX=NSPECIDX,OPROCIDX=NPROCIDX D  Q
 . ; exactly the same unread lists for old and new TO SERVICES
 . I UNREAD S X=$$TIMESTMP^MAGDTR02(UNREAD) ; update the timestamp
 . Q
 ;
 ; different unread lists for old and new TO SERVICES
 ;
 ; is there an old unread list?
 S LISTDATA=$S(UNREAD:$G(^MAG(2006.5849,UNREAD,0)),1:"")
 I LISTDATA="" D  Q  ; no old unread list
 . D ADD^MAGDTR03(.NEWENTRY,GMRCIEN,"OF") ; create the new unread list entry
 . Q
 ;
 ; there is an old unread list entry
 ; create the new unread list and copy the data from the old unread list entry
 S X=$$STATUPDT^MAGDTR02(UNREAD,"D")
 D ADD^MAGDTR03(.NEWENTRY,GMRCIEN,"IOF") Q:'NEWENTRY  ; create the new unread list entry
 F I=7,8,10 D  ; copy acquisition start, next acquisition, and number of images
 . S $P(^MAG(2006.5849,NEWENTRY,0),"^",I)=$P(^MAG(2006.5849,UNREAD,0),"^",I)
 . Q
 Q
 ;
 ;
 ; common functions
 ;
UNREAD(GMRCIEN) ; look up unread list internal entry number
 N HIT,LISTDATA,UNREAD,STATUS
 Q:'$G(GMRCIEN) ""
 S UNREAD="",HIT=0
 F  S UNREAD=$O(^MAG(2006.5849,"B",GMRCIEN,UNREAD)) Q:'UNREAD  D  Q:HIT
 . S LISTDATA=$G(^MAG(2006.5849,UNREAD,0))
 . S STATUS=$P(LISTDATA,"^",11)
 . I STATUS'="D" S HIT=1 ; ignore deleted entries
 . Q
 Q UNREAD
 ;
STATUPDT(UNREAD,STATUS) ; update the status
 N ACQSITE,IPROCIDX,ISPECIDX,OSTATUS,LISTDATA,TIMESTMP
 S TIMESTMP=0
 I $G(UNREAD),$G(STATUS)'="",$D(^MAG(2006.5849,UNREAD,0)) D
 . S LISTDATA=$G(^MAG(2006.5849,UNREAD,0))
 . S ACQSITE=$P(LISTDATA,"^",2) Q:ACQSITE=""
 . S ISPECIDX=$P(LISTDATA,"^",3) Q:ISPECIDX=""
 . S IPROCIDX=$P(LISTDATA,"^",4) Q:IPROCIDX=""
 . S OSTATUS=$P(LISTDATA,"^",11) Q:OSTATUS=""
 . K ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,OSTATUS,UNREAD)
 . S $P(^MAG(2006.5849,UNREAD,0),"^",11)=STATUS
 . S ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,STATUS,UNREAD)=""
 . S TIMESTMP=$$TIMESTMP^MAGDTR02(UNREAD) ; update time stamp piece of last activity
 . Q
 Q TIMESTMP
 ; 
TIMESTMP(UNREAD) ; update the transaction's timestamp and cross-reference
 N ACQSITE ;-- acquisition site
 N NEWTIME ;-- time stamp of the current transaction
 N OLDTIME ;-- time stamp of the previous transaction
 N LISTDATA ;- read/unread list data
 N ISPECIDX ;- index to specialties - read/unread list sort key
 N IPROCIDX ;- index to procedures - read/unread list sort key (may be null)
 Q:'$G(UNREAD) ""
 S NEWTIME=$$NOW^XLFDT()
 L +^MAG(2006.5849,UNREAD):1E9
 S LISTDATA=^MAG(2006.5849,UNREAD,0)
 S ACQSITE=$P(LISTDATA,"^",2) I ACQSITE="" Q 0
 S ISPECIDX=$P(LISTDATA,"^",3) I ISPECIDX="" Q 0
 S IPROCIDX=$P(LISTDATA,"^",4) I IPROCIDX="" Q 0
 S OLDTIME=$P(LISTDATA,"^",9)
 I ACQSITE'="",ISPECIDX'="",IPROCIDX'="" D
 . K:OLDTIME ^MAG(2006.5849,"AC",ACQSITE,ISPECIDX,IPROCIDX,OLDTIME,UNREAD)
 . S ^MAG(2006.5849,"AC",ACQSITE,ISPECIDX,IPROCIDX,NEWTIME,UNREAD)=""
 . Q
 S $P(^MAG(2006.5849,UNREAD,0),"^",9)=NEWTIME
 L -^MAG(2006.5849,UNREAD)
 Q NEWTIME

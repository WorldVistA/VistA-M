MAGDTR04 ;WOIFO/PMK - Read a DICOM image file ; 13 Feb 2007  11:36 AM
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
LOCK(RETURN,UNREAD,LOCKFLAG,FULLNAME,INITIALS,DUZACQ,DUZREAD,DUZREAD2) ; RPC = MAG DICOM CON UNREADLIST LOCK
 N ACQSITE,LISTDATA,IPROCIDX,ISPECIDX,STATUS,X
 S DUZACQ=DUZ ; DUZ at the acquisition site is the DUZ for the RPC
 S STATUS=""
 ;
 I '$G(UNREAD) D
 . S RETURN="-1|No UNREAD parameter set"
 . Q
 ;
 E  I '$D(^MAG(2006.5849,UNREAD,0)) D
 . S RETURN="-2|UNREAD parameter wrong -- ^MAG(2006.5849,"_UNREAD_",0) is undefined"
 . Q
 ;
 E  D  ; try to lock or unlock the study
 . S LISTDATA=^MAG(2006.5849,UNREAD,0)
 . S ACQSITE=$P(LISTDATA,"^",2),ISPECIDX=$P(LISTDATA,"^",3)
 . S IPROCIDX=$P(LISTDATA,"^",4),STATUS=$P(LISTDATA,"^",11)
 . I $G(LOCKFLAG) D  ; try to lock the study
 . . I STATUS="U" D
 . . . S (STATUS,$P(^MAG(2006.5849,UNREAD,0),"^",11))="L"
 . . . K ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"U",UNREAD)
 . . . S ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"L",UNREAD)=""
 . . . S X=FULLNAME_"^"_INITIALS_"^"_DUZACQ_"^"_DUZREAD_"^"_DUZREAD2
 . . . S $P(^MAG(2006.5849,UNREAD,0),"^",12,16)=X ; reader identification
 . . . S X=$$TIMESTMP^MAGDTR02(UNREAD) ; update time stamp piece of last activity
 . . . S $P(^MAG(2006.5849,UNREAD,0),"^",17,18)=X_"^" ; start reading timestamp
 . . . S RETURN="0|Successful Lock"
 . . . Q
 . . E  I STATUS="L" D
 . . . I $P(^MAG(2006.5849,UNREAD,0),"^",12)=FULLNAME D
 . . . . S RETURN="1|Already locked by same user"
 . . . . Q
 . . . E  D
 . . . . S RETURN="-3|Already locked by a different user"
 . . . . Q
 . . . Q
 . . E  I STATUS?1"R".E D
 . . . S RETURN="-4|Already resulted and can't be locked"
 . . . Q
 . . E  I STATUS?1"C".E D
 . . . S RETURN="-5|Already cancelled and can't be locked"
 . . . Q
 . . E  I STATUS?1"W".E D
 . . . S RETURN="-6|Waiting and can't be locked"
 . . . Q
 . . E  D
 . . . S RETURN="-7|Can't be locked because of Unknown Status"
 . . . Q
 . . Q
 . ;
 . E  D  ; try to unlock the study
 . . I STATUS="L" D
 . . . I $P(^MAG(2006.5849,UNREAD,0),"^",12)=FULLNAME D
 . . . . D UNLOCK(UNREAD,.STATUS)
 . . . . S RETURN="0|Successful Unlock"
 . . . . Q
 . . . E  D
 . . . . S RETURN="-8|Locked by different user, can't be unlocked"
 . . . . Q
 . . . Q
 . . E  I STATUS="U" D
 . . . S RETURN="2|Already unlocked"
 . . . Q
 . . E  I STATUS?1"R".E D
 . . . S RETURN="-9|Already resulted and can't be unlocked"
 . . . Q
 . . E  I STATUS?1"C".E D
 . . . S RETURN="-10|Already cancelled and can't be unlocked"
 . . . Q
 . . E  I STATUS?1"W".E D
 . . . S RETURN="-11|Waiting and can't be unlocked"
 . . . Q
 . . E  D
 . . . S RETURN="-12|Can't be unlocked because of Unknown Status"
 . . . Q
 . . Q
 . Q
 S RETURN=RETURN_"|"_STATUS
 Q
 ;
UNLOCK(UNREAD,STATUS) ; unlock the study - called by ^MAGDTR06
 N ACQSITE,LISTDATA,IPROCIDX,ISPECIDX,X
 S LISTDATA=^MAG(2006.5849,UNREAD,0)
 S ACQSITE=$P(LISTDATA,"^",2),ISPECIDX=$P(LISTDATA,"^",3)
 S IPROCIDX=$P(LISTDATA,"^",4)
 S (STATUS,$P(^MAG(2006.5849,UNREAD,0),"^",11))="U"
 K ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"L",UNREAD)
 S ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"U",UNREAD)=""
 S X=$$TIMESTMP^MAGDTR02(UNREAD) ; update time stamp piece of last activity
 S $P(^MAG(2006.5849,UNREAD,0),"^",12,18)="^^^^^^"
 Q

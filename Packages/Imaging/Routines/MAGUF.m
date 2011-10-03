MAGUF ;WOIFO/MLH - file utility routine ; 31 Dec 2009 5:53 PM
 ;;3.0;IMAGING;**98**;Mar 19, 2002;Build 1849;Sep 22, 2010
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
NEARFMT(IMAGE,EXT) ; FUNCTION - return code for the format that's nearest
 ; This function lets the user know whether the nearest accessible version
 ; of the file associated with this image IEN is the magnetic or WORM
 ; version, or whether the image is stored offline.
 ;
 ; input:  IMAGE     file name or internal entry number on IMAGE File (#2005)
 ;         EXT       what file type is desired (ABS, BIG, FULL, or TXT)
 ;
 ; function return:  code for nearest accessible version
 ;                     M = magnetic
 ;                     W = WORM
 ;                     O = offline
 ;                     I = invalid image number / no record found
 ;                     A = Image has been deleted / in archive file (#2005.1)
 ;
 N NEARCOD ; -- function return code for the nearest accessible version
 N IEN,TYPE,FILNAM,EXT,REC0,RECBIG
 ;
 S IEN="",NEARCOD="I" ; assume not valid
 I IMAGE'?1N.N D  Q:('IEN)!(NEARCOD="A") NEARCOD
 . S FILNAM=$P(IMAGE,".") Q:FILNAM=""
 . I $D(^MAG(2005.1,"F",FILNAM)) S NEARCOD="A" Q 
 . Q:'$D(^MAG(2005,"F",FILNAM))
 . S IEN=$O(^MAG(2005,"F",FILNAM,""))
 . Q
 E  S IEN=IMAGE
 I $D(^MAG(2005.1,IEN)) S NEARCOD="A" Q NEARCOD
 S EXT=$S($D(EXT):EXT,$P($G(IMAGE),".",2):$P($G(IMAGE),".",2),1:"FULL")
 I $$PATCH^XPDUTL("MAG*3.0*39") S TYPE=$$FTYPE^MAGQBPRG(EXT,IEN) ;post P39
 E  S TYPE=$$FTYPE^MAGQBPRG(EXT) ;pre P39
 D  ;find applicable case, if any, and break
 . ; is the file on the OFFLINE IMAGES File?
 . N FNFULL ; -- full file name
 . S FNFULL=$P($G(^MAG(2005,IEN,0)),"^",2)
 . I FNFULL'="",$D(^MAGQUEUE(2006.033,"B",FNFULL)) S NEARCOD="O" Q
 . ; no, search for network location by file extension
 . I TYPE="ABS" D  Q  ;ABS has no independent worm reference
 . . S REC0=$G(^MAG(2005,IEN,0))
 . . I REC0="" S NEARCOD="I" Q
 . . I $P($G(^MAG(2005.2,+$P(REC0,"^",4),0)),"^",6) S NEARCOD="M" Q
 . . I $P($G(^MAG(2005.2,+$P(REC0,"^",5),0)),"^",6) S NEARCOD="W" Q
 . . S NEARCOD="O" Q
 . I (TYPE="FULL")!(TYPE="TXT") D  Q  ;txt has no independent reference
 . . S REC0=$G(^MAG(2005,IEN,0))
 . . I REC0="" S NEARCOD="I" Q
 . . I $P($G(^MAG(2005.2,+$P(REC0,"^",3),0)),"^",6) S NEARCOD="M" Q
 . . I $P($G(^MAG(2005.2,+$P(REC0,"^",5),0)),"^",6) S NEARCOD="W" Q
 . . S NEARCOD="O" Q
 . I TYPE="BIG" D  Q
 . . S RECBIG=$G(^MAG(2005,IEN,"FBIG"))
 . . I RECBIG="" S NEARCOD="I" Q
 . . I $P($G(^MAG(2005.2,+$P(RECBIG,"^",1),0)),"^",6) S NEARCOD="M" Q
 . . I $P($G(^MAG(2005.2,+$P(RECBIG,"^",2),0)),"^",6) S NEARCOD="W" Q
 . . S NEARCOD="O" Q
 . Q
 Q NEARCOD

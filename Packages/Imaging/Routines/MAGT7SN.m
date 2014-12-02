MAGT7SN ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - NTE ; 17 Jul 2013 11:53 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
NTESEGC(SEGELTS,FILE,IENSX,ACNUMB,IX) ;create a NTE segment for comments
 N FLDSETID S FLDSETID=1 ; set ID field number
 N FLDCMTSRC S FLDCMTSRC=2 ; source of comment field number
 N FLDCMTTEXT S FLDCMTTEXT=3 ; comment field number
 N FLDCMTTYPE S FLDCMTTYPE=4 ; comment type field number
 N SETID ; --- counters used for message segments
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"NTE",0) ; segment type
 D  ; set up fields, check exit flag after each
 . S SETID=$G(SETID("NTE"))+1,SETID("NTE")=SETID
 . D  Q:ERRSTAT  ; NTE-1-set ID
 . . D SET^HLOAPI(.SEGELTS,SETID,FLDSETID)
 . . Q
 . D  Q:ERRSTAT  ; NTE-2-source of comment
 . . D SET^HLOAPI(.SEGELTS,"L",FLDCMTSRC)
 . . Q
 . D  Q:ERRSTAT  ; NTE-3-comment
 . . N COMMENT
 . . S COMMENT=$G(@LABDATA@(FILE("COMMENT"),IENSX,.01,"I"))
 . . D SET^HLOAPI(.SEGELTS,COMMENT,FLDCMTTEXT)
 . . Q
 . D  Q:ERRSTAT  ; NTE-4-comment type
 . . D SET^HLOAPI(.SEGELTS,"I",FLDCMTTYPE,1)
 . . Q
 . Q
 ;
 Q ERRSTAT
 ;
NTESEGT(SEGELTS,TEXT) ; create a NTE segment for text objects
 N FLDSETID S FLDSETID=1 ; set ID field number
 N FLDCMTSRC S FLDCMTSRC=2 ; source of comment field number
 N FLDCMTTEXT S FLDCMTTEXT=3 ; comment field number
 N FLDCMTTYPE S FLDCMTTYPE=4 ; comment type field number
 N SETID ; --- counters used for message segments
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"NTE",0) ; segment type
 D  ; set up fields, check exit flag after each
 . S SETID=$G(SETID("NTE"))+1,SETID("NTE")=SETID
 . D  Q:ERRSTAT  ; NTE-1-set ID
 . . D SET^HLOAPI(.SEGELTS,SETID,FLDSETID)
 . . Q
 . D  Q:ERRSTAT  ; NTE-2-source of comment
 . . D SET^HLOAPI(.SEGELTS,"L",FLDCMTSRC)
 . . Q
 . D  Q:ERRSTAT  ; NTE-3-comment
 . . D SET^HLOAPI(.SEGELTS,TEXT,FLDCMTTEXT)
 . . Q
 . D  Q:ERRSTAT  ; NTE-4-comment type
 . . D SET^HLOAPI(.SEGELTS,"I",FLDCMTTYPE,1)
 . . Q
 . Q
 ;
 Q ERRSTAT

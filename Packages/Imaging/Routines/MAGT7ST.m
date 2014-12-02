MAGT7ST ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - TQ1 ; 17 Jul 2013 12:07 PM
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
TQ1SEG(SEGELTS,DFN) ; FUNCTION - main entry point - create a TQ1 segment
 N SETID S SETID=1 ; set ID value for TQ1 segment
 N FLDSETID S FLDSETID=1 ; set ID field in TQ1 segment
 N PRIO S PRIO="R" ; priority code - always "R"
 N FLDPRIO S FLDPRIO=9 ; priority field in TQ1 segment
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"TQ1",0) ; segment type
 D  ; set field values - check abort flag after every field is set
 . D  Q:ERRSTAT  ; TQ1-1-set ID
 . . D SET^HLOAPI(.SEGELTS,SETID,FLDSETID)
 . . Q
 . D  Q:ERRSTAT  ; TQ1-9-priority
 . . D SET^HLOAPI(.SEGELTS,PRIO,FLDPRIO)
 . . Q
 . Q
 ;
 Q ERRSTAT

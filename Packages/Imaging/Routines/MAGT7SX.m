MAGT7SX ;WOIFO/MLH,PMK,NST - telepathology - create HL7 message to DPS - segment build - OBX ; 19 Jul 2013 3:00 PM
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
OBXSEG(MSG,KEY,VALTYP,VALUE,DATETIME) ; FUNCTION - main entry point - create OBX key-value pairs
 N PARAM ; parameter
 N SEGELTS ; array for segment elements
 N FLDSETID S FLDSETID=1 ; set ID field number
 N FLDVALTYP S FLDVALTYP=2 ; value type field number
 N FLDOBSTYP S FLDOBSTYP=3 ; observation type field number
 N FLDVALUE S FLDVALUE=5 ; observation value field number
 N FLDSTATUS S FLDSTATUS=11 ; observation status field number
 N FLDDTTM S FLDDTTM=14 ; date/time of the observation
 ;
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 D  Q:ERRSTAT ERRSTAT ; validate input
 . F PARAM="KEY","VALTYP","VALUE" D  Q:ERRSTAT
 . . I '$D(@PARAM) S ERRSTAT="-1001`Undefined parameter "_PARAM
 . . Q
 . Q
 D  ; set up fields, check exit flag after each
 . D SET^HLOAPI(.SEGELTS,"OBX",0) ; segment type
 . D  Q:ERRSTAT  ; OBX-1-set ID
 . . S SETID=$G(SETID("OBX"))+1,SETID("OBX")=SETID
 . . D SET^HLOAPI(.SEGELTS,SETID,FLDSETID)
 . . Q
 . D  Q:ERRSTAT  ; OBX-2-value type
 . . D SET^HLOAPI(.SEGELTS,VALTYP,FLDVALTYP)
 . . Q
 . D  Q:ERRSTAT  ; OBX-3-observation type
 . . S KEY("TEXT")=KEY
 . . D SETCE^HLOAPI4(.SEGELTS,.KEY,FLDOBSTYP)
 . . Q
 . D  Q:ERRSTAT  ; OBX-5-observation value
 . . I (VALTYP="NM")!(VALTYP="ST") D  Q  ; number or string
 . . . D SET^HLOAPI(.SEGELTS,$G(VALUE),FLDVALUE)
 . . . Q
 . . I VALTYP="CWE" D  Q  ; coded with exceptions
 . . . D SETCE^HLOAPI4(.SEGELTS,.VALUE,FLDVALUE)
 . . . Q
 . . I VALTYP="DTM" D  Q  ; date/time
 . . . D SETTS^HLOAPI4(.SEGELTS,VALUE,FLDVALUE)
 . . . Q
 . . Q
 . D  Q:ERRSTAT  ; OBX-11-observation result status
 . . D SET^HLOAPI(.SEGELTS,"O",FLDSTATUS)
 . . Q
 . D:$G(DATETIME)  Q:ERRSTAT  ;OBR-14-date/time of the observation
 . . D SETTS^HLOAPI4(.SEGELTS,DATETIME,FLDDTTM)
 . . Q
 . Q
 D:'ERRSTAT  ; send the segment
 . N ERRMSG
 . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . Q
 . Q
 ;
 Q ERRSTAT

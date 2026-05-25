MAGIP376 ;OIT/ZEB - Post-install for MAG*3.0*376 ; DEC 3, 2024@9:22AM
 ;;3.0;IMAGING;**376**;Dec 03, 2024;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
POST ;Post install for MAG*3.0*376
 N START,STOP
 ;after cleaning up old data, make sure Enterprise Site Report is queued up to run again
 D INGSTFIX^MAGCFIX("","@")
 D RESTASK^MAGQE4
 ;make sure the missed months' data is sent
 ;November
 S START=3241101,STOP=3241130 D AHISU^MAGQE2(START,STOP)
 ;December
 S START=3241201,STOP=3241231 D AHISU^MAGQE2(START,STOP)
 Q

MAG7RSO ;WOIFO/PMK,MLH - copy radiology message from HLSDATA to ^MAGDHL7 - update diag codes in OBX segs ; 07 Jul 2003  12:30 PM
 ;;3.0;IMAGING;**11**;14-April-2004
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
 ;
OBXUPD ; SUBROUTINE - called by ADDDTA^MAGDHL7
 ; Update OBX diagnosis code info on radiology ORU messages.
 ; DICOM requires a numeric code in its triplet.
 ;
 N IXOBX ; ---------------- index to OBX segments in MAG7WRK array
 N DIAGCSTR ; ------------- diagnostic code string
 N TESTSTR ; -------------- substring to test with
 N TESTIX ; --------------- index of entries to test against
 N DIAGCIX ; -------------- diagnostic code index in 78.3
 ;
 ; Look for DIAGNOSTIC CODE in each OBX segment.  When that string is found,
 ; try to pick up the numeric diagnosis code from the Radiology DIAGNOSTIC
 ; CODES File (#78.3).
 S IXOBX=""
 F  S IXOBX=$O(MAG7WRK("B","OBX",IXOBX)) Q:'IXOBX  D
 . I $G(MAG7WRK(IXOBX,3,1,2,1))="DIAGNOSTIC CODE",$G(MAG7WRK(IXOBX,2,1,1,1))="ST" D
 . . S DIAGCSTR=$G(MAG7WRK(IXOBX,5,1,1,1))
 . . K DIAGCIX
 . . I DIAGCSTR]"" D
 . . . S TESTSTR=$E(DIAGCSTR,1,30),TESTIX=""
 . . . F  S TESTIX=$O(^RA(78.3,"B",TESTSTR,TESTIX)) Q:'TESTIX  D  Q:$G(DIAGCIX)
 . . . . I $P($G(^RA(78.3,TESTIX,0)),U)=DIAGCSTR S DIAGCIX=TESTIX
 . . . . Q
 . . . Q
 . . I '$G(DIAGCIX) S DIAGCIX=9999 ; 'no code found' flag
 . . S MAG7WRK(IXOBX,2,1,1,1)="CE"
 . . S MAG7WRK(IXOBX,5,1,1,1)=DIAGCIX
 . . S MAG7WRK(IXOBX,5,1,2,1)=DIAGCSTR
 . . S MAG7WRK(IXOBX,5,1,3,1)="VISTA78.3"
 . . Q
 . Q
 Q

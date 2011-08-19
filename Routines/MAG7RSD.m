MAG7RSD ;WOIFO/PMK,MLH - copy radiology message from HLSDATA to ^MAGDHL7 - add admitting diagnosis data ; 07 Jul 2003  12:43 PM
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
DG1DGADM ; SUBROUTINE - called by PV1ADD
 ; Add admitting diagnosis to ADT and ORM messages.
 ; Expects:  MAG7WRK()     HL7 message array
 ;
 N IXSEG ; ---------- segment index
 N IXPRED,IXSUCC ; -- indices to segments to be inserted between
 N IXDG1 ; ---------- index of DG1 segment on MAG7WRK()
 ;
 ; are there already diagnosis segments out there?
 I $D(MAG7WRK("B","DG1")) D
 . ; yes, add another DG1 after the last DG1 we find
 . S IXPRED=$O(MAG7WRK("B","DG1"," "),-1)
 . S IX=$O(MAG7WRK(IXPRED)),IXDG1=$S(IX:IXPRED+IX/2,1:IXPRED+1)
 . ; fill in set ID (must follow in lockstep sequence)
 . S MAG7WRK(IXDG1,1,1,1,1)=$G(MAG7WRK(IXPRED,1,1,1,1))+1
 . Q
 E  D DG1DGAD1 ; no, find a place to insert a DG1 into the message
 I $G(IXDG1) D  ; we found a place - insert
 . S MAG7WRK(IXDG1,3,1,2,1)=VAIN(9),MAG7WRK(IXDG1,6,1,1,1)="A"
 . S MAG7WRK("B","DG1",IXDG1)="",MAG7WRK(IXDG1,0)="DG1"
 . Q
 Q
 ;
DG1DGAD1 ; SUBROUTINE - called by DG1DGADM
 ; Find optional segments between the required PV1 and where we will insert
 ; a DG1.  If message structure is corrupt (i.e., no PV1 segment in an ADT
 ; message) don't try to insert a DG1 segment.  If we don't recognize the
 ; message type, don't try to insert a DG1 segment.
 ;
 ; Expects:  MAG7WRK()     HL7 message array
 ; 
 ; Returns:  IXDG1         index of the DG1 segment to be inserted into
 ; 
 N IXSEG ; ---------- segment index
 N IXPRED,IXSUCC ; -- indices to segments to be inserted between
 N DG1SETID ; ------- set ID for DG1
 ;
 ; are there any DG1 segments on file?
 I $D(MAG7WRK("B","DG1")) D  ; yes, get index and set ID of the last one
 . S IXPRED=$O(MAG7WRK("B","DG1"," "),-1)
 . S DG1SETID=MAG7WRK(IXPRED,1,1,1,1)
 . Q
 E  D  ; no, find a place to insert, and initialize the set ID
 . I $G(MAG7WRK(1,9,1,1,1))="ADT" D
 . . S (IXSEG,IXPRED)=$O(MAG7WRK("B","PV1","")) Q:'IXSEG
 . . F  S IXSEG=$O(MAG7WRK(IXSEG)) Q:'IXSEG  Q:"^PV2^ROL^DB1^OBX^AL1^"'[("^"_$G(MAG7WRK(IXSEG,0))_"^")  S IXPRED=IXSEG
 . . Q
 . E  I $G(MAG7WRK(1,9,1,1,1))="ORM" D
 . . S (IXSEG,IXPRED)=$O(MAG7WRK("B","OBR","")) Q:'IXSEG
 . . F  S IXSEG=$O(MAG7WRK(IXSEG)) Q:'IXSEG  Q:"^NTE^CTD^"'[("^"_$G(MAG7WRK(IXSEG,0))_"^")  S IXPRED=IXSEG
 . . Q
 . S DG1SETID=0
 . Q
 ; now compute the index of the DG1 segment, and fill in the Set ID
 S IXSUCC=$O(MAG7WRK(IXPRED)),IXDG1=$S(IXSUCC:IXPRED+IXSUCC/2,1:IXPRED+1)
 S MAG7WRK(IXDG1,1,1,1,1)=DG1SETID+1 ; set ID always begins at 1
 Q

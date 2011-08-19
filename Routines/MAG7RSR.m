MAG7RSR ;WOIFO/PMK,MLH - copy radiology message from HLSDATA to ^MAGDHL7 - add ROL segment data ; 18 Dec 2003  3:56 PM
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
ROLADD(XPHY,XROL) ; SUBROUTINE - called by PV1ADD
 ; Add role information for the attending or referring physician
 ; to the ADT message.
 ;
 ; Expects:  MAG7WRK()     HL7 message array
 ; 
 ; Input:    XPHY()    array containing PV1 info for attending or
 ;                       referring DR
 ;           XROL      the role being populated:
 ;                     AT = attending, RP = referring
 ;
 N IXROL ; ---------- role segment index
 N IXSEG ; ---------- segment index
 N IXPRED,IXSUCC ; -- indices to segments to be inserted between
 N RLINSTID ; ------- role instance ID
 N FPHN ; ----------- phone number fetch flag (discarded)
 ;
 ; already a ROL segment on file?
 I $D(MAG7WRK("B","ROL")) D  ; yes, add another one
 . S (IXSEG,IXPRED)=$O(MAG7WRK("B","ROL"," "),-1)
 . S RLINSTID=MAG7WRK(IXSEG,1,1,1,1)
 . Q
 E  D  ; no, add the first one
 . S (IXSEG,IXPRED)=$O(MAG7WRK("B","PV1","")) Q:'IXSEG
 . F  S IXSEG=$O(MAG7WRK(IXSEG)) Q:'IXSEG  Q:"^PV1^PV2^ROL^"'[("^"_$G(MAG7WRK(IXSEG,0))_"^")  S IXPRED=IXSEG
 . S RLINSTID=0
 . Q
 ; now compute the index of the ROL segment, and fill in
 S IXSUCC=$O(MAG7WRK(IXPRED)),IXROL=$S(IXSUCC:IXPRED+IXSUCC/2,1:IXPRED+1)
 S MAG7WRK(IXROL,0)="ROL",MAG7WRK("B","ROL",IXROL)=""
 S MAG7WRK(IXROL,1,1,1,1)=RLINSTID+1 ; instance ID always begins at 1
 S MAG7WRK(IXROL,2,1,1,1)="UC" ; unchanged
 S MAG7WRK(IXROL,3,1,1,1)=XROL
 M MAG7WRK(IXROL,4,1)=@XPHY
 S FPHN=$$NPFON^MAG7UFO($NA(MAG7WRK(IXROL,12)),MAG7WRK(IXROL,4,1,1,1))
 Q

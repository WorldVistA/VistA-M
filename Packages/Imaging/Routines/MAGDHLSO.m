MAGDHLSO ;WOIFO/MLH - IHE-based ADT interface for PACS - OBX segments ; 12 Jun 2006  3:05 PM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
OBXADT ; GOTO entry point from MAGDHLS - patient height/weight - NOT FOR DIRECT ENTRY
 ; input:  XDFN      internal entry number of the patient on global ^DPT
 ;         XYMSG     name of array to which to add message elts
 ; output: @XYMSG    input array plus new subtree containing EVN elts
 ;         function return   0 (success) always
 ;
 N DFN ; ----- internal entry number on ^DPT
 N VTYPIX ; -- vitals type index on ^UTILITY($J)
 N RDTIX ; --- reverse date/time index on ^UTILITY($J)
 N SEGIX ; --- segment index on @XYMSG
 N SETID ; --- set ID element for HL7 segments
 N VDTM ; ---- date/time of vitals data
 N VIEN ; ---- vitals IEN for measurement
 N VDTA ; ---- vitals data
 N UNITS ; --- labels for units of measure
 ;
 K ^UTILITY($J,"GMRVD") ; refresh the return array
 S DFN=XDFN,GMRVSTR="HT;WT"
 S GMRVSTR(0)="^^1" ; one occurrence each of height and weight
 D EN1^GMRVUT0
 S SETID=0
 S UNITS("HT")="HEIGHT|m|meter"
 S UNITS("WT")="WEIGHT|kg|kilogram"
 ;
 F VTYPIX="HT","WT" I $D(^UTILITY($J,"GMRVD",VTYPIX)) D
 . S RDTIX=$O(^UTILITY($J,"GMRVD",VTYPIX,0))
 . I RDTIX D
 . . S VDTM=9999999-RDTIX
 . . S VIEN=$O(^UTILITY($J,"GMRVD",VTYPIX,RDTIX,0))
 . . ; if a measurement exists, populate the message array
 . . I VIEN D OBXAHW(UNITS(VTYPIX))
 . . Q
 . Q
 Q 0
 ;
OBXAHW(XUNITS) ; SUBROUTINE - called by OBXADT - NOT FOR DIRECT ENTRY
 ; if a measurement exists, populate the message array
 ; INPUT:  XUNITS      labels for units of measure
 ;                     format:  MEASUREMENT|abbrev|unit
 ;                     
 S SEGIX=$O(@XYMSG@(" "),-1)+1
 S @XYMSG@(SEGIX,0)="OBX"
 S SETID=SETID+1,@XYMSG@(SEGIX,1,1,1,1)=SETID
 S @XYMSG@(SEGIX,2,1,1,1)="ST"
 S @XYMSG@(SEGIX,3,1,2,1)=$P(XUNITS,"|",1)
 S @XYMSG@(SEGIX,5,1,1,1)=$J($P($G(^UTILITY($J,"GMRVD",VTYPIX,RDTIX,VIEN)),U,13)/$S($P(XUNITS,"|",2)="m":100,1:1),0,2)
 S @XYMSG@(SEGIX,6,1,1,1)=$P(XUNITS,"|",2)
 S @XYMSG@(SEGIX,6,1,2,1)=$P(XUNITS,"|",3)
 S @XYMSG@(SEGIX,6,1,3,1)="ISO+"
 S @XYMSG@(SEGIX,11,1,1,1)="F"
 Q

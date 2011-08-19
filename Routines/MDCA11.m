MDCA11 ;HINES OIFO/DP/BJ - HL7 Build Cancel Admit/Visit Notice (A11) Message;21-JUN-2007
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
VALID ;;VDEF HL7 MESSAGE BUILDER
 Q
 ;
EN(EVIEN,KEY,VFLAG,OUT,MSHP) ;
 ;
 ; Inputs: EVIEN = IEN of message in file 577
 ;         KEY - IEN of file to create message from
 ;         VFLAG - "V" for VistA HL7 destination
 ;         OUT - target array, passed by reference
 ;         MSHP - Piece 4 contains message subtype
 ;
 ; Output: Two part string with parts separated by "^"
 ;         Part 1: "LM" - output in local array passed in "OUT" parameter
 ;                 "GM" - output in ^TMP("HLS",$J)
 ;         Part 2: No longer used        ;
 ;
 ;
 Q $$BLDMSG^MDCADT(EVIEN,KEY,VFLAG,.OUT,MSHP,"A11")
 ;

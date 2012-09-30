MDCA13 ;HINES OIFO/DP/BJ/TJ - HL7 Build Cancel Discharge/Visit End (A13) Message;21-JUN-2007
 ;;1.0;CLINICAL PROCEDURES;**16,12**;Apr 01, 2004;Build 318
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
VALID ;;VDEF HL7 MESSAGE BUILDER
 Q
 ;
EN(KEY,VFLAG,OUT,MSHP) ;
 ;
 ; Inputs:
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
 Q $$BLDMSG^MDCADT(KEY,VFLAG,.OUT,MSHP,"A13")
 ;

MAGNVIC  ;WOIFO/NST - Utilities for Image Import API ; 09 Mar 2010 4:14 PM
 ;;3.0;IMAGING;**108**;Mar 19, 2002;Build 1738;May 20, 2010
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
 ;
 ;***** RPC TO CHECKS IF PHOTO IMAGE EXISTS FOR A PATIENT
 ;
 ; MAGDFN   Patient DFN
 ;
 ; Return Values
 ; =============
 ;  MAGRY = 0 Photo doesn't exist
 ;          Date.Timestamp - Photo on file (date timestamp of the most recent photo)
 ;
RPHASPHT(MAGRY,MAGDFN) ;RPC [MAGN PATIENT HAS PHOTO]
 K MAGRY
 N EXIST
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 S EXIST=$$HASPHOTO(+MAGDFN)
 S MAGRY=EXIST
 Q
 ;
 ;##### CHECKS IF PHOTO IMAGE EXISTS FOR A PATIENT MAGDFN
 ;
 ; MAGDFN   Patient DFN
 ;
 ; Return Values
 ; =============
 ;            0              - Photo doesn't exist
 ;            Date.Timestamp - Photo on file (date timestamp of the most recent photo)
 ;
HASPHOTO(MAGDFN) ;
 N RDT,IEN,RESULT
 S RDT=""
 S RESULT=0
 F  Q:RESULT  S RDT=$O(^MAG(2005,"APPXDT",MAGDFN,"PHOTO ID",RDT)) Q:RDT=""  D
 . S IEN=""
 . F  Q:RESULT  S IEN=$O(^MAG(2005,"APPXDT",MAGDFN,"PHOTO ID",RDT,IEN)) Q:IEN=""  D
 . . Q:$$ISDEL^MAGGI11(IEN)             ; Deleted image
 . . S RESULT=9999999.9999-RDT   ; need to reverse the date
 . . Q
 . Q 
 Q RESULT

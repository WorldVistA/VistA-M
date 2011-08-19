MAGGI11 ;WOIFO/GEK/SG - IMAGE FILE API (LOW LEVEL) ; 1/16/09 10:04am
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ; Unless stated otherwise, error descriptors returned to the ERR
 ; parameter of entry points in this routine are NOT stored regardless
 ; of the mode set by the CLEAR^MAGUERR. If you need to store them
 ; (e.g. to return from an RPC), then you have to do this in your
 ; code using the STORE^MAGUERR.
 ;
 Q
 ;
 ;##### CHECKS IF THE CURRENT USER CAN DELETE THE IMAGE
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  Allow deletion regardless of security keys
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;            0  Image cannot be deleted or there was an error;
 ;               check the value of the ERR parameter.
 ;            1  User can delete the image
 ;
CANDEL(IMGIEN,FLAGS,ERR) ;
 S FLAGS=$G(FLAGS)
 I $TR(FLAGS,"S")'=""  S ERR=$$IPVE^MAGUERR("FLAGS")  Q 0
 ;--- Validate IEN and check if the image is already deleted
 I $$ISDEL(IMGIEN,.ERR)  S ERR=$$ERROR^MAGUERR(-37,,"Deleted")  Q 0
 Q:ERR<0 0
 ;--- Check the security key if necessary
 I FLAGS'["S",'$D(^XUSEC("MAG DELETE",DUZ))  D  Q 0
 . S ERR=$$ERROR^MAGUERR(-36)
 . Q
 ;--- User can delete the image
 Q 1
 ;
 ;##### CHECKS IF THE IMAGE CAN BE VIEWED
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;            0  Image cannot be viewed or there was an error;
 ;               check the value of the ERR parameter.
 ;            1  Image is viewable
 ;
CANVIEW(IMGIEN,ERR) ;
 N STATUS
 S STATUS=$$IMGST(IMGIEN,.ERR)
 I STATUS'<10  S ERR=$$ERROR^MAGUERR("-33S",,$P(STATUS,U,2))  Q 0
 Q (ERR'<0)
 ;
 ;##### RETURNS NUMBER OF THE FILE THAT STORES THE IMAGE RECORD
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;           ""  Invalid IEN or there is no such record
 ;           >0  Image file number (2005 or 2005.1)
 ;
FILE(IMGIEN,ERR) ;
 S ERR=""
 ;--- Validate the IMGIEN parameter
 I (IMGIEN'>0)!(+IMGIEN'=IMGIEN)  D  Q ""
 . S ERR=$$ERROR^MAGUERR("-3S",,"IMGIEN",IMGIEN)
 . Q
 ;--- Check if the image data exists
 Q:$D(^MAG(2005,IMGIEN)) 2005
 ;~~~ Delete this comment and the following line of code when
 ;~~~ the IMAGE AUDIT file (#2005.1) is completely eliminated.
 Q:$D(^MAG(2005.1,IMGIEN)) 2005.1
 ;--- There is no such record
 S ERR=$$ERROR^MAGUERR("-22S",,2005,IMGIEN_",")
 Q ""
 ;
 ;***** RETURNS THE IMAGE STATUS
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;           ""  Status is not defined or there was an error;
 ;               check the value of the ERR parameter.
 ;           >0  Image status
 ;                 ^01: Status code (internal value)
 ;                 ^02: Description (external value)
 ;
IMGST(IMGIEN,ERR) ;
 N MAGMSG,NODE,STCODE
 S NODE=$$NODE(IMGIEN,.ERR)  Q:NODE="" ""
 ;--- Get the internal value of the STATUS field (113)
 S STCODE=+$P($G(@NODE@(100)),U,8)  Q:'STCODE ""
 ;--- Return the status
 Q STCODE_U_$$IMGSTDSC(STCODE)
 ;
 ;##### RETURNS THE DESCRIPTION FOR THE IMAGE STATUS CODE
 ;
 ; STCODE        Internal value of the STATUS field (113)
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;               Description of the image status (usually, the
 ;               external value of the STATUS field)
 ;
IMGSTDSC(STCODE,ERR) ;
 Q:'STCODE ""
 N MAGMSG,STDESCR
 ;--- Get the external value of the STATUS field
 S STDESCR=$$EXTERNAL^DILFD(2005,113,,STCODE,"MAGMSG")
 S:$G(DIERR) ERR=$$ERROR^MAGUERR("-38S",,STCODE)
 ;--- Return the description
 Q $S(STDESCR'="":STDESCR,1:"<Status: "_STCODE_">")
 ;
 ;##### CHECKS IF THE IMAGE IS MARKED AS DELETED
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;            0  Image is not marked as deleted or there was an error;
 ;               check the value of the ERR parameter.
 ;            1  IMGIEN references a deleted image
 ;
ISDEL(IMGIEN,ERR) ;
 ;~~~ Delete this comment and the following lines of code when
 ;~~~ the IMAGE AUDIT file (#2005.1) is completely eliminated.
 S ERR=""
 I $D(^MAG(2005.1,IMGIEN))  Q:'$D(^MAG(2005,IMGIEN)) 1  D  Q 0
 . S ERR=$$ERROR^MAGUERR("-43S",,IMGIEN)
 . Q
 ;---
 Q (+$$IMGST(IMGIEN,.ERR)=12)
 ;
 ;##### CHECKS IF THE IEN IS INVALID OR THE IMAGE IS DELETED
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;            0  IEN is valid and the image is not deleted
 ;            1  Invalid IEN or the image is marked as delete;
 ;               check the value of the ERR parameter for details.
 ;
ISDELINV(IMGIEN,ERR) ;
 Q $S($$ISDEL(IMGIEN,.ERR):1,1:ERR<0)
 ;
 ;##### CHECKS IF THE IMGIEN REFERENCES A GROUP PARENT
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;            0  Image is not a group parent or there was an error;
 ;               check the value of the ERR parameter.
 ;            1  IMGIEN references a group parent
 ;
ISGRP(IMGIEN,ERR) ;
 N NODE,OBJTYPE
 S NODE=$$NODE(IMGIEN,.ERR)  Q:NODE="" 0
 S OBJTYPE=$P($G(@NODE@(0)),U,6)  ; OBJECT TYPE (3)
 Q (OBJTYPE=11)!(OBJTYPE=16)
 ;
 ;##### CHECKS IF THE PARAMETER VALUE IS A VALID IMAGE IEN
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;            0  Parameter value is not a valid image IEN;
 ;               check the value of the ERR parameter.
 ;            1  Valid image IEN
 ;
ISVALID(IMGIEN,ERR) ;
 Q $$NODE(IMGIEN,.ERR)'=""
 ;
 ;##### RETURNS THE CLOSED REFERENCE TO THE IMAGE RECORD
 ;
 ; IMGIEN        Internal Entry Number of the image record
 ;
 ; [.ERR]        Reference to a local variable where the error
 ;               descriptor (see the $$ERROR^MAGUERR) is returned to.
 ;
 ; Return Values
 ; =============
 ;           ""  Invalid IEN or there is no such record
 ;  "^MAG(...)"  Closed reference to the image data node
 ;
NODE(IMGIEN,ERR) ;
 S ERR=""
 ;--- Validate the IMGIEN parameter
 I (IMGIEN'>0)!(+IMGIEN'=IMGIEN)  D  Q ""
 . S ERR=$$ERROR^MAGUERR("-3S",,"IMGIEN",IMGIEN)
 . Q
 ;--- Check if the image data exists
 Q:$D(^MAG(2005,IMGIEN)) $NA(^(IMGIEN))
 ;~~~ Delete this comment and the following line of code when
 ;~~~ the IMAGE AUDIT file (#2005.1) is completely eliminated.
 Q:$D(^MAG(2005.1,IMGIEN)) $NA(^(IMGIEN))
 ;--- There is no such record
 S ERR=$$ERROR^MAGUERR("-22S",,2005,IMGIEN_",")
 Q ""

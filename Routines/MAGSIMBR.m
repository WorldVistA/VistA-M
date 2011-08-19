MAGSIMBR ;WOIFO/SEB - Image Business Rules ;
 ;;3.0;IMAGING;**8**;Sep 15, 2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; Business rules for deletion of images
DELETE(RY,MAGIEN,SYSDEL) N DELOK,MAGRY,MAG2,TIUDA
 ; Check user privileges for delete key
 S RY(0)="1^This image is allowed to be deleted."
 I 'SYSDEL I '$D(^XUSEC("MAG DELETE",DUZ)) D
 . S RY(0)="0^User doesn't have delete privilege."
 . Q
 I +RY(0)=0 Q
 ; Check if we are allowed to delete this image
 ; (Node 101 - Placeholder for future status field)
 S DELOK=1 ;I $P($G(^MAG(2005,MAGIEN,101)),"^")=0 S DELOK=0
 I DELOK=0 S RY(0)="0^This image cannot be deleted."
 I +RY(0)=0 Q
 ; If this image is linked to a TIU note, check to see that the TIU note is not signed.
 S MAG2=$G(^MAG(2005,MAGIEN,2)) I $P(MAG2,"^",6)=8925 D
 . S TIUDA=$P(MAG2,"^",7) D DATA(.MAGRY,TIUDA)
 . ;I $P(MAGRY,"^",4)="COMPLETED" S RY(0)="0^The TIU note has been signed. Cannot delete this image."
 . Q
 I +RY(0)=0 Q
 Q
 ;
DATA(MAGRY,TIUDA) ;RPC Call to get TIU data from the TIUDA
 ; Return = TIUDA^Document Type^Document Date^Document Status
 ;
 S MAGRY=TIUDA_U_$$GET1^DIQ(8925,TIUDA,".01","E")_U_$$GET1^DIQ(8925,TIUDA,"1201","I")_U_$$GET1^DIQ(8925,TIUDA,".05","E")
 Q

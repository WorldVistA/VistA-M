MAGGA04 ;WOIFO/SG - REMOTE PROCEDURES: IMAGE LOCK/UNLOCK ; 3/9/09 12:51pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
 ;
 ;***** LOCKS THE IMAGE(S)
 ; RPC: MAGG IMAGE LOCK
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [FLAGS]       reserved
 ;
 ; .IMGLST(      Reference to the List of images to lock
 ;
 ;   i)          Image reference
 ;                 ^01: Image IEN
 ;
 ; Return Values
 ; =============
 ;     
 ; Zero value of the 1st '^'-piece of the RESULTS(0) indicates an
 ; error during execution of the procedure. In this case, the array
 ; is formatted as described in the comments to the RPCERRS^MAGUERR1.
 ;
 ; If the error descriptor in the RESULTS(1) has the error code -21,
 ; this means that the RPC could not lock the image(s). A message
 ; that explains who/what locked the image(s) and when this happened
 ; is attached to this error as additional information.
 ;
 ; In case of successful lock, "1^Ok" is returned in the RESULTS(0).
 ;
 ; Notes
 ; =====
 ;
 ; See description of the MAGG IMAGE LOCK remote procedure for more
 ; details.
 ;
LOCKIMG(RESULTS,FLAGS,IMGLST) ;
 N LOCKS,RC
 K RESULTS  S RESULTS(0)=0
 D CLEAR^MAGUERR(1)
 ;--- Prepare the list of objects to be locked
 S RC=$$LOCKLST(.IMGLST,.LOCKS)
 I RC<0  D RPCERRS^MAGUERR1(.RESULTS,RC)  Q
 ;--- Lock the objects
 S RC=$$LOCKFM^MAGUTL07(.LOCKS)
 I RC<0  D RPCERRS^MAGUERR1(.RESULTS,RC)  Q
 I RC>0  D  Q
 . S RC=$$ERROR^MAGUERR(-21,$$TEXT^MAGUTL07(RC),"image")
 . D RPCERRS^MAGUERR1(.RESULTS,RC)
 . Q
 ;--- Success
 S RESULTS(0)="1^Ok"
 Q
 ;
 ;+++++ CONVERTS THE LIST OF IMAGES TO THE LOCK/UNLOCK PARAMETERS
LOCKLST(IMGLST,LOCKS) ;
 N I,IMGFILE,IMGIEN,TMP,RC
 S RC=0
 ;---
 S I=""
 F  S I=$O(IMGLST(I))  Q:I=""  D  Q:RC<0
 . S TMP=$TR(IMGLST(I)," ")
 . S IMGIEN=$P(TMP,U)
 . I IMGIEN'>0  S RC=$$IPVE^MAGUERR($NA(IMGLST(I)))  Q
 . ;--- Get the number of the file that stores the image
 . S IMGFILE=$$FILE^MAGGI11(IMGIEN,.TMP)
 . I IMGFILE'>0  S RC=TMP  D STORE^MAGUERR(RC)  Q
 . ;--- Store the reference
 . S LOCKS(IMGFILE,IMGIEN_",")=""
 . Q
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** UNLOCKS THE IMAGE(S)
 ; RPC: MAGG IMAGE UNLOCK
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; FLAGS         reserved
 ;
 ; .IMGLST(      Reference to the list of images to unlock
 ;
 ;   i)          Image reference
 ;                 ^01: Image IEN
 ;
 ; Return Values
 ; =============
 ;     
 ; Zero value of the 1st '^'-piece of the RESULTS(0) indicates an
 ; error during execution of the procedure. In this case, the array
 ; is formatted as described in the comments to the RPCERRS^MAGUERR1.
 ;
 ; Otherwise, "1^Ok" is returned in the RESULTS(0).
 ;
UNLOCKIM(RESULTS,FLAGS,IMGLST) ;
 N LOCKS,RC
 K RESULTS  S RESULTS(0)=0
 D CLEAR^MAGUERR(1)
 ;--- Prepare the list of objects to be unlocked
 S RC=$$LOCKLST(.IMGLST,.LOCKS)
 I RC<0  D RPCERRS^MAGUERR1(.RESULTS,RC)  Q
 ;--- Unlock the objects
 S RC=$$UNLOCKFM^MAGUTL07(.LOCKS)
 I RC<0  D RPCERRS^MAGUERR1(.RESULTS,RC)  Q
 ;--- Success
 S RESULTS(0)="1^Ok"
 Q

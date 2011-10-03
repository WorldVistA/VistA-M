RAMAG04 ;HCIOFO/SG - ORDERS/EXAMS API (ORDER CANCEL/HOLD) ; 1/25/08 1:17pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### CANCELS/HOLDS THE ORDER
 ;
 ; .RAPARAMS       Reference to the API descriptor
 ;                 (see the ^RA01 routine for details)
 ;
 ; RAOIFN          IEN of the order in the file #75.1
 ;
 ; RAREASON        Cancel/Hold reason: either IEN of a record of
 ;                 the RAD/NUC MED REASON file (#75.2) or a valid
 ;                 synonym (see SYNONYM field (3) of that file).
 ;
 ;                 The referenced record must have appropriate type
 ;                 (see TYPE OF REASON field (2) of the file #75.2):
 ;
 ;                 * If the reason record has the CANCEL REQUEST (1)
 ;                   type, then the RAMISC("HOLDESC") is ignored and
 ;                   the order is canceled.
 ;
 ;                 * If the reason record is of the HOLD REQUEST (3)
 ;                   type, then the order is put on hold. If the
 ;                   RAMISC("HOLDESC") is defined, the text is stored
 ;                   into the HOLD DESCRIPTION field.
 ;
 ;                 * If the record is of the GENERAL REQUEST type (9),
 ;                   then the new order status is determined by the
 ;                   RAMISC("HOLDESC"). If it is defined, then the
 ;                   order is put on hold; otherwise, the order is
 ;                   canceled.
 ;
 ; [.RAMISC]       Reference to a local array containing miscellaneous
 ;                 parameters.
 ; RAMISC(
 ;
 ;   "HOLDESC",    Text for the HOLD DESCRIPTION field (25)
 ;     Seq#)       of the file #75.1.
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ; NOTE: If there are active cases in the RAD/NUC MED PATIENT
 ;       file (#70) associated with an order, this function does
 ;       not cancel/hold the order and returns the error code -42.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
ORDCANC(RAPARAMS,RAOIFN,RAREASON,RAMISC) ;
 N ACTION,PNODE,RALOCK,RARC,RSNIEN,STATUS,TMP
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("$$ORDCANC^RAMAG04","!!")
 . D VARS^RAMAGU11("RAOIFN,RAREASON")
 . D ZW^RAUTL22("RAMISC")
 ;
 ;--- Validate parameters
 S RARC=$$CHKREQ^RAUTL22("RAOIFN,RAREASON")  Q:RARC<0 RARC
 S RAOIFN=+RAOIFN
 ;
 ;--- Determine whether to hold or cancel
 S RSNIEN=$$RARSNIEN^RAMAGU13(RAREASON,.TMP)  Q:RSNIEN<0 RSNIEN
 S TMP=+TMP  ; Internal value of the TYPE OF REASON field
 S ACTION=$S(TMP=1:1,TMP=3:3,$D(RAMISC("HOLDESC"))>1:3,1:1)
 ;
 ;--- Lock the order record
 K TMP  S TMP(75.1,RAOIFN_",")=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"order")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP
 . ;--- Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;
 . ;--- Check the current status
 . S STATUS=$$ORDSTAT^RAMAGU02(RAOIFN)
 . I STATUS<0  S RARC=STATUS  Q
 . Q:+STATUS=1  ; Already canceled
 . ;
 . ;--- Check if all related examinations in file #70 are canceled
 . I $D(^RADPT("AO",RAOIFN))>1  S RARC=0  D  Q:RARC<0
 . . N FOUND,RAFLT,RAFLTL,RANODE
 . . S RANODE=$NA(^RADPT("AO",RAOIFN))
 . . S RAFLTL=$L(RANODE)-1,RAFLT=$E(RANODE,1,RAFLTL)
 . . S FOUND=0
 . . F  S RANODE=$Q(@RANODE)  Q:$E(RANODE,1,RAFLTL)'=RAFLT  D  Q:FOUND
 . . . S TMP=$QS(RANODE,3)_U_$QS(RANODE,4)_U_$QS(RANODE,5)
 . . . S TMP=$$EXMSTAT^RAMAGU05(TMP)  S:$P(TMP,U,3) FOUND=1
 . . S:FOUND RARC=$$ERROR^RAERR(-42)
 . ;
 . ;--- Update status
 . S RARC=$$UPDORDST^RAMAGU02(RAOIFN,ACTION,RSNIEN)  Q:RARC'>0
 . ;
 . ;--- Populate the HOLD DESCRIPTION field
 . I ACTION=3,$D(RAMISC("HOLDESC"))>1  S RARC=0  D  Q:RARC<0
 . . N IENS,RAFDA,RAMSG
 . . S RAFDA(75.1,RAOIFN_",",25)=$NA(RAMISC("HOLDESC"))
 . . D FILE^DIE(,"RAFDA","RAMSG")
 . . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,75.1,RAOIFN_",")
 ;
 ;--- Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:0)

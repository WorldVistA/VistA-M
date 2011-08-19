RAMAG05 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM CANCEL) ; 2/1/08 10:01am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### CANCELS THE EXAM(S)
 ;
 ; .RAPARAMS       Reference to the API descriptor
 ;                 (see the ^RA01 routine for details)
 ; 
 ; RACASE          Exam/case identifiers:
 ;                   ^01: IEN of the patient in the file #70   (RADFN)
 ;                   ^02: IEN in the REGISTERED EXAMS multiple (RADTI)
 ;                   ^03: IEN in the EXAMINATIONS multiple     (RACNI)
 ;
 ; RAREASON        Reason for cancelation: either IEN of a record of
 ;                 the RAD/NUC MED REASON file (#75.2) or a valid
 ;                 synonym (see SYNONYM field (3) of the file #75.2).
 ;                 The referenced record must have 'CANCEL REQUEST'
 ;                 or 'GENERAL REQUEST' type (see TYPE OF REASON
 ;                 field (2) of the file #75.2).
 ;
 ; [RAFLAGS]       Flags that control execution (can be combined):
 ;
 ;                   A  Cancel all related exams/cases (those that
 ;                      reference the same order).
 ;
 ;                   O  Cancel/hold the related order after successful
 ;                      exam(s) cancelation.
 ;
 ;                      The order will be canceled or put on hold only
 ;                      if there are no more active cases associated
 ;                      with it.
 ;
 ;                      Otherwise, error code -42 will be returned.
 ;                      Use the "A" flag to cancel all related exams
 ;                      and guarantee the order cancelation.
 ;
 ; [.RAMISC]       Reference to a local array containing miscellaneous
 ;                 parameters.
 ;
 ;                 See the ^RAMAG routine for additional important
 ;                 details regarding this parameter.
 ;
 ; RAMISC(
 ;
 ;   "HOLDESC",    Text for the HOLD DESCRIPTION field (25) of the
 ;     Seq#)       order associated with the exam (in file #75.1).
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "ORDRSN")     Cancel/Hold reason for the order associated
 ;                 with the exam(s): either IEN of a record of
 ;                 the RAD/NUC MED REASON file (#75.2) or a valid
 ;                 synonym (see SYNONYM field (3) of that file).
 ;                 Required: No
 ;                 Default:  Value of the RAREASON parameter
 ;
 ; If the RAFLAGS parameter contains the "O" flag, the "ORDRSN" and
 ; "HOLDESC" parameters determine whether the related order is
 ; canceled or put on hold. Otherwise, they are ignored.
 ;
 ; * If the reason record referenced by the "ORDRSN" node has the
 ;   CANCEL REQUEST (1) type, then the "HOLDESC" node is ignored and
 ;   the order is canceled.
 ;
 ; * If the record referenced by the "ORDRSN" node is of the HOLD
 ;   REQUEST (3) type, then the order is put on hold. If the "HOLDESC"
 ;   node is defined, the text is stored into the HOLD DESCRIPTION
 ;   field.
 ;
 ; * If the record referenced by the "ORDRSN" node is of the GENERAL
 ;   REQUEST type (9), then the action performed on the order is
 ;   determined by the "HOLDESC" node. If it is defined, then the
 ;   order is put on hold; otherwise, the order is canceled.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR).
 ;        0  Exam has been canceled
 ;
EXAMCANC(RAPARAMS,RACASE,RAREASON,RAFLAGS,RAMISC) ;
 N CASE,EXAMLST,LOCKTMP,RACNI,RADFN,RADTI,RALOCK,RAMSG,RAOIFN,RARC,RSNIEN,STATUS,TMP
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("$$EXAMCANC^RAMAG05","!!")
 . D VARS^RAMAGU11("RACASE,RAREASON,RAFLAGS")
 . D ZW^RAUTL22("RAMISC")
 ;
 ;=== Validate parameters
 S RARC=$$CHKREQ^RAUTL22("RACASE,RAREASON")  Q:RARC<0 RARC
 S RACASE=$P(RACASE,U,1,3),RAFLAGS=$G(RAFLAGS)
 S RARC=$$CHKEXMID^RAMAGU04(RACASE)  Q:RARC<0 RARC
 S RADFN=$P(RACASE,U)
 ;
 ;=== Find the IEN of the synonym
 S RSNIEN=$$RARSNIEN^RAMAGU13(RAREASON)  Q:RSNIEN<0 RSNIEN
 ;
 ;=== Get IEN of the order (only if necessary)
 I $TR(RAFLAGS,"AO")'=RAFLAGS  S RARC=0  D  Q:RARC<0 RARC
 . S TMP=$$EXAMIENS^RAMAGU04(RACASE)
 . S RAOIFN=+$$GET1^DIQ(70.03,TMP,11,"I",,"RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,70.03,TMP)  Q
 . S LOCKTMP(75.1,RAOIFN_",")=""
 ;
 ;=== Prepare the list of exams
 S EXAMLST(RACASE)=""
 S LOCKTMP(70.03,$$EXAMIENS^RAMAGU04(RACASE))=""
 I RAFLAGS["A"  D
 . N RAFLT,RAFLTL,RANODE
 . S RANODE=$NA(^RADPT("AO",RAOIFN))
 . S RAFLTL=$L(RANODE)-1,RAFLT=$E(RANODE,1,RAFLTL)
 . F  S RANODE=$Q(@RANODE)  Q:$E(RANODE,1,RAFLTL)'=RAFLT  D
 . . S CASE=$QS(RANODE,3)_U_$QS(RANODE,4)_U_$QS(RANODE,5)
 . . S EXAMLST(CASE)=""
 . . S LOCKTMP(70.03,$$EXAMIENS^RAMAGU04(CASE))=""
 ;
 ;=== Lock affected objects
 S RARC=$$LOCKFM^RALOCK(.LOCKTMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"examination(s)")
 M RALOCK=LOCKTMP
 ;
 D
 . N $ESTACK,$ETRAP,BUF
 . ;=== Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;
 . ;=== Cancel the exam(s)
 . S CASE=""
 . F  S CASE=$O(EXAMLST(CASE))  Q:CASE=""  D  Q:RARC<0
 . . S STATUS=$$EXMSTAT^RAMAGU05(CASE)
 . . I STATUS<0  S RARC=STATUS  Q
 . . S RADTI=$P(CASE,U,2),RACNI=$P(CASE,U,3)
 . . S EXAMLST(CASE)=STATUS
 . . ;--- Check if the case has already been canceled
 . . I '$P(STATUS,U,3)  K EXAMLST(CASE)  Q
 . . ;--- Check the ALLOW CANCELLING? field
 . . S TMP=$$GET1^DIQ(72,+STATUS,6,"I",,"RAMSG")
 . . Q:$$UP^XLFSTR(TMP)'="Y"
 . . ;--- Update exam status
 . . S RARC=$$UPDEXMST^RAMAGU05(CASE,"^^0",,RSNIEN)  Q:RARC<0
 . . K EXAMLST(CASE)
 . . ;--- Send notifications
 . . D CANCEL^RAHLRPC
 . Q:RARC<0
 . ;
 . ;=== Check if all exams have been canceled
 . I $D(EXAMLST)>1  D  Q
 . . N I  K RAMSG
 . . F I=1:1  S CASE=$O(EXAMLST(CASE))  Q:CASE=""  D
 . . . S TMP="Exam IENS='"_$$EXAMIENS^RAMAGU04(CASE)_"'"
 . . . S RAMSG(I)=TMP_", Status='"_$P(EXAMLST(CASE),U,2)_"'"
 . . S RARC=$$ERROR^RAERR(-51,.RAMSG)
 . ;
 . ;=== Cancel the order
 . I RAFLAGS["O"  D  Q:RARC<0
 . . S TMP=$G(RAMISC("ORDRSN"))
 . . I TMP'?." "  D  I RSNIEN<0  S RARC=RSNIEN  Q
 . . . S RSNIEN=$$RARSNIEN^RAMAGU13(TMP)
 . . S RARC=$$ORDCANC^RAMAG04(.RAPARAMS,RAOIFN,RSNIEN,.RAMISC)
 ;
 ;=== Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:0)

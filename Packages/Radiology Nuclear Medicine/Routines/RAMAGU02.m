RAMAGU02 ;HCIOFO/SG - ORDERS/EXAMS API (ORDER UTILITIES) ; 1/24/08 5:37pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### RETURNS ORDER STATUS
 ;
 ; RAOIFN        IEN of the exam order in the RAD/NUC MED ORDERS
 ;               file (#75.1)
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;      ...  Internal and external values of the order status
 ;           separated by "^"
 ;
ORDSTAT(RAOIFN) ;
 N IENS,RABUF,RAMSG
 Q:$G(RAOIFN)'>0 $$IPVE^RAERR("RAOIFN")
 S IENS=(+RAOIFN)_","
 D GETS^DIQ(75.1,IENS,"5","EI","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,75.1,IENS)
 Q $G(RABUF(75.1,IENS,5,"I"))_U_$G(RABUF(75.1,IENS,5,"E"))
 ;
 ;***** PERFORMS ORDER STATUS 'ROLLBACK"
 ;
 ; RAOIFN        IEN of the exam order in the RAD/NUC MED ORDERS
 ;               file (#75.1)
 ;
 ; STATUS        Internal status value (see the REQUEST STATUS field
 ;               (5) of the file #75.1 and the NEW STATUS field (2)
 ;               of the sub-file #75.12).
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
OSTRLBCK(RAOIFN,STATUS) ;
 N RALOCK,RANODE,RARC,TMP
 Q:$G(RAOIFN)'>0 $$IPVE^RAERR("RAOIFN")
 Q:$G(STATUS)="" $$IPVE^RAERR("STATUS")
 S RAOIFN=+RAOIFN,RANODE=$$ROOT^DILFD(75.12,","_RAOIFN_",",1)
 S RARC=0
 ;
 ;--- Lock the order record
 K TMP  S TMP(75.1,RAOIFN_",")=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"order")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP,DA,DIK,IENS,RAFDA,RAIEN,RAIENRS,RAMSG
 . ;--- Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;--- Find the latest record with requested status
 . S RAIENRS=" "
 . F  S RAIENRS=$O(@RANODE@(RAIENRS),-1)  Q:RAIENRS'>0  D  Q:TMP
 . . S TMP=RAIENRS_","_RAOIFN_","
 . . S TMP=($$GET1^DIQ(75.12,TMP,2,"I",,"RAMSG")=STATUS)
 . ;--- If the requested status is not found in the multiple,
 . ;--- use the regular status update function to fix it.
 . I RAIENRS'>0  S RARC=$$UPDORDST(RAOIFN,STATUS)  Q
 . ;--- Delete record(s) from the multiple
 . S DIK=$$OREF^DILF(RANODE),RAIEN=" "
 . F  S RAIEN=$O(@RANODE@(RAIEN),-1)  Q:RAIEN'>RAIENRS  D
 . . S DA(1)=RAOIFN,DA=RAIEN  D ^DIK
 . ;--- Update status and cancel/hold reason
 . S IENS=RAOIFN_","
 . S RAFDA(75.1,IENS,5)=STATUS
 . S TMP=$$GET1^DIQ(75.12,RAIENRS_","_IENS,4,"I",,"RAMSG")
 . S RAFDA(75.1,IENS,10)=$S('$G(DIERR):TMP,1:"")
 . D FILE^DIE(,"RAFDA","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,75.12,RAIENRS_",")
 ;
 ;--- Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:0)
 ;
 ;***** UPDATES THE ORDER/REQUEST STATUS
 ;
 ; RAOIFN        IEN of the exam order in the RAD/NUC MED ORDERS
 ;               file (#75.1)
 ;
 ; STATUS        Internal status value (see the REQUEST STATUS field
 ;               (5) of the file #75.1 and the NEW STATUS field (2)
 ;               of the sub-file #75.12).
 ;
 ; [REASON]      Cancel/Hold reason: either IEN of a record of
 ;               the RAD/NUC MED REASON file (#75.2) or a valid
 ;               synonym (see SYNONYM field (3) of that file).
 ;
 ;               This parameter is required if STATUS=1 or STATUS=3.
 ;
 ;               The referenced record must have the appropriate
 ;               type of reason (see TYPE OF REASON field (2) of
 ;               the file #75.2): CANCEL REQUEST (1) if STATUS=1,
 ;               HOLD REQUEST (3) if STATUS=3, or GENERAL REQUEST (9)
 ;               in both cases.
 ;
 ; [SCDT]        Internal date value (FileMan) for the STATUS CHANGE
 ;               DATE/TIME field (.01) of the sub-file #75.12. If
 ;               this parameter is not defined or not greater than 0, 
 ;               then the current date/time is used.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Order already has the requested status
 ;       >0  IEN of the new status sub-record in sub-file #75.12
 ;
UPDORDST(RAOIFN,STATUS,REASON,SCDT) ;
 N IENS,RAFDA,RAIENS,RALOCK,RAMSG,RAOSTS,RARC,RTYPE,SCEDT,TMP
 Q:$G(RAOIFN)'>0 $$IPVE^RAERR("RAOIFN")
 Q:$G(STATUS)="" $$IPVE^RAERR("STATUS")
 S RARC=0,RAOIFN=+RAOIFN
 ;
 ;=== Check the Cancel/Hold reason
 I (STATUS=1)!(STATUS=3)  D  Q:RARC<0 RARC
 . ;--- Variable for the EN^RABUL, which is called from the
 . ;    input transform of the REQUEST STATUS field (5) of
 . ;--- the RAD/NUC MED ORDERS file (#75.1)
 . S RAOSTS=STATUS
 . ;--- Check if it has a value
 . I $G(REASON)=""  S RARC=$$ERROR^RAERR(-8,,"REASON")  Q
 . ;--- Get the IEN and type of the reason
 . S RARC=$$RARSNIEN^RAMAGU13(REASON,.RTYPE)  Q:RARC<0
 . S REASON="`"_(+RARC)  ; Pseudo-external value
 . ;--- Check the type of reason
 . S TMP=+RTYPE
 . I TMP'=STATUS,TMP'=9  D  Q
 . . S RARC=$$ERROR^RAERR(-16,,+RTYPE,STATUS)
 E  S REASON=""
 ;
 ;=== Check the date/time
 I $G(SCDT)>0  D  Q:RARC<0 RARC
 . S TMP=+$E(SCDT,1,12),SCEDT=$$FMTE^XLFDT(TMP)
 . S:(SCEDT=TMP)!(SCEDT="") RARC=$$IPVE^RAERR("SCDT")
 E  S SCEDT="NOW"
 ;
 ;=== Prepare the data
 S IENS=RAOIFN_","
 S RAFDA(75.1,IENS,5)=STATUS               ; REQUEST STATUS
 S RAFDA(75.1,IENS,10)=REASON              ; REASON
 S RAFDA(75.1,IENS,18)="NOW"               ; LAST ACTIVITY DATE/TIME
 S:STATUS'=3 RAFDA(75.1,IENS,25)="@"       ; HOLD DESCRIPTION
 S IENS="+1,"_IENS
 S RAFDA(75.12,IENS,.01)=SCEDT             ; REQUEST STATUS TIMES
 S RAFDA(75.12,IENS,2)=STATUS              ; NEW STATUS
 S RAFDA(75.12,IENS,3)="`"_(+DUZ)          ; COMPUTER USER
 S RAFDA(75.12,IENS,4)=REASON              ; REASON
 ;
 ;=== Lock the order record
 K TMP  S TMP(75.1,RAOIFN_",")=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"order")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP
 . ;=== Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;
 . ;=== Check if the order currently has the same status
 . S TMP=$$GET1^DIQ(75.1,RAOIFN_",",5,"I",,"RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,75.1,RAOIFN_",")  Q
 . I STATUS=TMP  S RARC=0  D  Q:RARC
 . . ;--- Check if the last record of the REQUEST STATUS TIMES
 . . ;--- multiple indicates the same status as the requested one
 . . S IENS=+$O(^RAO(75.1,RAOIFN,"T"," "),-1)  Q:IENS'>0
 . . S IENS=IENS_","_RAOIFN_","
 . . S TMP=$$GET1^DIQ(75.12,IENS,2,"I",,"RAMSG")
 . . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,75.12,IENS)  Q
 . . S RARC=(TMP=STATUS)
 . ;
 . ;=== Update the record
 . D UPDATE^DIE("E","RAFDA","RAIENS","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,75.12,IENS)
 ;
 ;=== Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:+$G(RAIENS(1)))

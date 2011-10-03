RAMAGU08 ;HCIOFO/SG - ORDERS/EXAMS API (RAMISC VALID. #70) ; 3/6/09 4:16pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** VALIDATES RAMISC PARAMETERS RELATED TO THE FILE #70
 ;
 ; RAIENS        IENS of the exam/case (subfile #70.03)
 ;
 ; RASTIEN       IEN of the requested exam status
 ;
 ; .RACTION      Reference to a local variable that indicates the
 ;               actions (can be combined):
 ;                 E  Examined (procedure has been performed)
 ;                 C  Complete
 ;
 ;               After exiting the function, this parameter contains
 ;               only those actions that actually have to be performed
 ;               in order to reach the requested status. For example, 
 ;               if "EC" is passed and the procedure has already been 
 ;               performed, then "E" will be removed.
 ;
 ;               If this parameter is empty after the call, then the
 ;               exam already has requested status.
 ;
 ; .RAMISC       Reference to a local array containing miscellaneous
 ;               request parameters.
 ;
 ; .RAFDA(       Reference to a local array where field values will
 ;               be prepared for storage (FileMan FDA array).
 ;
 ;   "RACNT")    This is an additional node that stores counter for
 ;               the IENS placeholders. Do not forget to remove this
 ;               node before passing the array into a FileMan API.
 ;
 ;   "RAIENS")   This is an additional node that stores IENS of the
 ;               record being processed. Do not forget to remove this 
 ;               node before passing the array into a FileMan API.
 ;
 ; [RAFDACNT]    New value for the placeholder counter for the RAFDA. 
 ;               If this parameter is greater than zero, it replaces
 ;               the value stored in the RAFDA("RACNT").
 ;
 ; Input variables:
 ;   RACN, RADTE, RAIMGTYI, RAMSPSDEFS
 ;
 ; Output variables:
 ;   RAMSPSDEFS, RAPROCIEN
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
VAL70(RAIENS,RASTIEN,RACTION,RAMISC,RAFDA,RAFDACNT) ;
 N ERRCNT,EXMST,PNODE,RABUF,RACAT,RAI,RAMSG,RAPROC,RC,TMP
 ;
 ;=== Check required parameters and variables
 S RC=$$CHKREQ^RAUTL22("RACTION,RAIENS")  Q:RC<0 RC
 S RC=$$CHKREQ^RAUTL22("RACN,RADTE,RAIMGTYI","V")
 Q:RC<0 RC
 Q:$TR(RACTION,"EC")'="" $$IPVE^RAERR("RACTION")
 ;
 ;=== Initialize variables
 S RAFDA("RAIENS")=RAIENS
 S:$G(RAFDACNT)>0 RAFDA("RACNT")=+RAFDACNT
 S (ERRCNT,RC)=0
 ;
 ;=== Data from the EXAMINATIONS multiple
 D GETS^DIQ(70.03,RAIENS,"2;3;4","I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 ;
 ;=== Check the current exam status
 S TMP=+$G(RABUF(70.03,RAIENS,3,"I"))
 S EXMST=$$EXMSTINF^RAMAGU06(TMP)  Q:EXMST<0 EXMST
 ;--- Already COMPLETE
 I $P(EXMST,U,3)=9  S RACTION=""  Q 0
 ;--- Already "EXAMINED"
 I $P(EXMST,U,3)>1  D  Q:RC<0 RC
 . S RC=$$GETEXMND^RAMAGU06(+EXMST)
 . ;--- Cannot find the "EXAMINED" status
 . S:'RC RACTION=$TR(RACTION,"E")
 Q:RACTION="" 0
 ;
 ;=== Detailed/series procedure and modifiers
 S PNODE=$NA(RAMISC("RAPROC"))
 S RAI=$O(@PNODE@(0))
 I RAI>0  S RAPROC=@PNODE@(RAI)  D         ; Update procedure
 . I $O(@PNODE@(RAI))>0  D ERROR^RAERR(-49)  S ERRCNT=ERRCNT+1
 E  S RAPROC=$G(RABUF(70.03,RAIENS,2,"I")) ; Current procedure
 ;--- Validate the procedure and modifiers
 S TMP=$$CHKPROC^RAMAGU03(RAPROC,RAIMGTYI,RADTE,"DS")
 S:TMP<0 ERRCNT=ERRCNT+1
 S RAPROCIEN=$S('TMP:+RAPROC,1:"")
 ;
 ;=== Get the exam status requirements
 S TMP=$$EXMSTREQ^RAMAGU06(RASTIEN,RAPROCIEN)  Q:TMP<0 TMP
 ;--- The "EF" report status means outside work. In this case,
 ;    cancel requirements for anything except (possibly) the
 ;--- diagnostic code. See the HELP1^RASTREQ for more details.
 I $G(RAMISC("RPTSTATUS"))'="EF"  S RAMSPSDEFS("R")=TMP
 E  S RAMSPSDEFS("R")="",$P(RAMSPSDEFS("R"),U,5)=$P(TMP,U,5)
 ;
 ;=== Category of exam
 S PNODE=$NA(RAMISC("EXAMCAT"))
 I $D(@PNODE)#10  S RACAT=@PNODE  D        ; Update category
 . S:$$CHECKFLD^RAMAGU09(PNODE,RACAT,70.03,4,RAIENS,1)<0 ERRCNT=ERRCNT+1
 E  S RACAT=$G(RABUF(70.03,RAIENS,4,"I"))  ; Current category
 ;
 ;=== Parameters specific to the exam category
 S:$$VALECPRM^RAMAGU09(RACAT)<0 ERRCNT=ERRCNT+1
 ;
 ;=== Technologist comment
 S:$$VALPRM^RAMAGU09("TECHCOMM")<0 ERRCNT=ERRCNT+1
 ;
 ;=== Validate parameters specific to different exam statuses
 I $TR(RACTION,"EC")'=RACTION  D  S:TMP<0 ERRCNT=ERRCNT+1
 . S TMP=$$VEXAMND(RAIENS,RACTION,.RAMISC,.RAFDA)
 I RACTION["C"  D  S:TMP<0 ERRCNT=ERRCNT+1
 . S TMP=$$VCOMPLT(RAIENS,RACTION,.RAMISC,.RAFDA)
 ;
 ;=== Error handling and cleanup
 K RAFDA(70.07) ; Do not modify the activity log directly
 Q $S(ERRCNT>0:-11,1:0)
 ;
 ;+++++ VALIDATES 'COMPLETE' PARAMETERS
VCOMPLT(RAIENS,RACTION,RAMISC,RAFDA) ;
 N ERRCNT,PNODE,TMP
 S ERRCNT=0
 ;
 ;=== Error handling and cleanup
 Q $S(ERRCNT>0:-11,1:0)
 ;
 ;+++++ VALIDATES 'EXAMINED' PARAMETERS
VEXAMND(RAIENS,RACTION,RAMISC,RAFDA) ;
 N ECNT,NAME,PI,PNODE,RAI,RC,TMP
 S ECNT=0
 ;
 ;=== Contrast media used
 S RC=$$VALPRM^RAMAGU09("CMUSED",,RAIENS)
 I RC>0  D
 . ;--- Clear the CONTMEDIA list if necessary
 . S TMP=$G(RAFDA(70.03,RAIENS,10))
 . I TMP'="Y"  K RAMISC("CONTMEDIA")  S RAMISC("CONTMEDIA")=""
 E  S:RC<0 ECNT=ECNT+1
 ;
 ;=== Contrast media
 S NAME="CONTMEDIA"
 S RC=$$VALPRM^RAMAGU09(NAME)
 I RC>0  D
 . S RAI=0
 . F  S RAI=$O(RAMISC(NAME,RAI))  Q:RAI'>0  D
 . . S:$$VALPRM^RAMAGU09(NAME,RAI)<0 ECNT=ECNT+1
 . ;--- Make the value of the CONTRAST MEDIA USED consistent
 . S TMP=$D(RAFDA(70.3225))
 . S:TMP RAFDA(70.03,RAIENS,10)=$S(TMP>1:"Y",1:"N")
 E  S:RC<0 ECNT=ECNT+1
 ;
 ;=== Complication
 S NAME="COMPLICAT"
 S RC=$$VALPRM^RAMAGU09(NAME,,RAIENS)
 I RC>0  D
 . S PNODE=$NA(RAMISC(NAME))
 . ;--- COMPLICATION TEXT
 . S TMP=$P($G(@PNODE),U,2)
 . S:$$CHECKFLD^RAMAGU09(PNODE,TMP,70.03,16.5,RAIENS)<0 ECNT=ECNT+1
 E  S:RC<0 ECNT=ECNT+1
 ;
 ;=== CPT Modifiers
 S NAME="CPTMODS"
 S RC=$$VALPRM^RAMAGU09(NAME)
 I RC>0  D
 . S RAI=0
 . F  S RAI=$O(RAMISC(NAME,RAI))  Q:RAI'>0  D
 . . S:$$VALPRM^RAMAGU09(NAME,RAI)<0 ECNT=ECNT+1
 E  S:RC<0 ECNT=ECNT+1
 ;
 ;=== Film size
 S NAME="FILMSIZE"
 S RC=$$VALPRM^RAMAGU09(NAME)
 I RC>0  D
 . S RAI=0
 . F  S RAI=$O(RAMISC(NAME,RAI))  Q:RAI'>0  D
 . . S PI=$NA(RAMISC(NAME,RAI))  K IENS
 . . ;--- FILM SIZE
 . . S:$$VALPRM^RAMAGU09(NAME,RAI,.IENS)<0 ECNT=ECNT+1
 . . ;--- AMOUNT
 . . S TMP=$P($G(@PI),U,2)
 . . S:$$CHECKFLD^RAMAGU09(PI,TMP,70.04,2,IENS)<0 ECNT=ECNT+1
 E  S:RC<0 ECNT=ECNT+1
 ;
 ;=== Primary camera/equipment/room
 S:$$VALPRM^RAMAGU09("PRIMCAM",,RAIENS)<0 ECNT=ECNT+1
 ;
 ;=== Technologist
 S NAME="TECH"
 S RC=$$VALPRM^RAMAGU09(NAME)
 I RC>0  D
 . S RAI=0
 . F  S RAI=$O(RAMISC(NAME,RAI))  Q:RAI'>0  D
 . . S:$$VALPRM^RAMAGU09(NAME,RAI)<0 ECNT=ECNT+1
 E  S:RC<0 ECNT=ECNT+1
 ;
 ;=== Primary diagnostic code
 S:$$VALPRM^RAMAGU09("PRIMDXCODE",,RAIENS)<0 ECNT=ECNT+1
 ;
 ;=== Primary interpreting resident and staff
 S RC=0
 F NAME="PRIMINTRES","PRIMINTSTF"  D
 . ;--- Check the parameter but does not record errors
 . S TMP=$$VALPRM^RAMAGU09(NAME,,RAIENS,,"C")
 . ;--- Handle defined/not defined cases
 . I TMP'<0  S RC=RC+1  Q
 . I +TMP=-8  S RC=RC-1  Q
 . ;--- Otherwise, call again to record the error(s)
 . S TMP=$$VALPRM^RAMAGU09(NAME,,RAIENS),ECNT=ECNT+1
 . ;--- Prevent the code below from recording additional errors
 . S RC=3
 ;--- If neither of the two parameters is defined but one of
 ;--- them is required, record the error.
 I RC<0  D  S ECNT=ECNT+1
 . S TMP=$NA(RAMISC("PRIMINTRES"))_", "_$NA(RAMISC("PRIMINTSTF"))
 . D ERROR^RAERR(-13,TMP)
 ;
 ;=== Error handling and cleanup
 Q $S(ECNT>0:-11,1:0)

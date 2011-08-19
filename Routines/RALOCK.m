RALOCK ;HCIOFO/SG - FILE/RECORD/FIELD LOCK ; 5/21/08 12:44pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; Entry points of this routine use the ^XTMP("RALOCK",...) global
 ; nodes to store lock descriptors:
 ;
 ; ^XTMP("RALOCK",
 ;   0)                  Standard node descriptor
 ;                         ^1: Purge date  (FileMan)
 ;                         ^2: Create date (FileMan)
 ;                         ^3: Description
 ;
 ;   NodeNdx)            Internal lock descriptor
 ;                         ^01: Date/Time (FileMan)
 ;                         ^02: User/Process name
 ;                         ^03: User IEN (DUZ)
 ;                         ^04: $JOB
 ;                         ^05: Task number
 ;                         ^06: Lock counter
 ;
 ; The NodeNdx is calculated by the $$XLNDX^RALOCK01 as the name
 ; reference to the locked node without the closing parenthesis.
 ;
 Q
 ;
 ;***** LOCKS THE (SUB)FILE, RECORD OR FIELD NODE
 ;
 ; [.]FILE       File/subfile number
 ; [IENS]        IENS of the record or subfile
 ; [FIELD]       Field number
 ;
 ;               If just the FILE has a value, then the whole file is
 ;               locked. If the FILE references a subfile, then the
 ;               subfile IENS (the 1st ","-piece is empty) should be
 ;               passed in the IENS parameter.
 ; 
 ;               If the IENS references a record of a file/subfile
 ;               (the 1st ","-piece is not empty), then this record
 ;               is locked.
 ;
 ;               If the IENS references a record and the FIELD is
 ;               also defined, then only the node that stores this
 ;               field is locked.
 ;
 ;               In addition (or instead) to the main locked object
 ;               defined by the FILE, IENS, and FIELD, you can define 
 ;               several additional objects using subscripts of the
 ;               FILE parameter:
 ;
 ;                  ;--- Lock the whole file #72
 ;                  S FILE(72)=""
 ;                  ;--- Lock the EXAMINATIONS multiple
 ;                  S FILE(70.02,",6928784.9143,398,")=""
 ;                  ;--- Lock 2 exams
 ;                  S FILE(70.03,"1,6828784.9143,398,")=""
 ;                  S FILE(70.03,"3,6828784.9143,398,")=""
 ;                  ;--- Lock just the "BA" node of the order
 ;                  S FILE(75.1,"123,",91)=""
 ;                  ;--- Lock the objects
 ;                  S RC=$$LOCKFM^RALOCK(.FILE)
 ;
 ;               All these objects are locked at the same time. If
 ;               even one of them cannot be locked, then nothing
 ;               is locked.
 ;
 ; [TO]          Timeout (value of DILOCKTM, by default)
 ;
 ; [NAME]        Process name. If this parameter is defined and not
 ;               empty, then its value will be returned in the lock
 ;               descriptor instead of the user name.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 D  Do not actually lock the node(s); just create
 ;                    the lock descriptor(s).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok (the objects have been locked)
 ;       >0  The object is locked by another user or task and
 ;           a lock descriptor is returned.
 ;             ^01: Date/Time (FileMan)
 ;             ^02: User/Process name
 ;             ^03: User IEN (DUZ)
 ;             ^04: $JOB
 ;             ^05: Task number
 ;
 ; If the third piece is empty then check the 2nd one for the
 ; custom process name.
 ;
LOCKFM(FILE,IENS,FIELD,TO,NAME,FLAGS) ;
 N DESCR,NDX,NODELIST,NODE,PI,RC,TMP
 S:$G(TO,-1)<0 TO=$G(DILOCKTM,3)
 S FLAGS=$G(FLAGS)
 ;--- Update the ^XTMP("RALOCK",0) once per session
 I '$D(RAPARAMS("XTMPLOCK"))  D  S RAPARAMS("XTMPLOCK")=""
 . D XTMPHDR^RAUTL22("RALOCK",30,"Radiology LOCK Descriptors")
 ;--- Check if a single object should be locked
 I $D(FILE)<10  S RC=0  D:$G(FILE)>0  Q RC
 . S RC=$$LOCK1^RALOCK01(FILE,$G(IENS),$G(FIELD),TO,$G(NAME),FLAGS)
 ;--- Compile the list of global nodes
 S RC=$$NODELIST^RALOCK01(.NODELIST,.FILE,$G(IENS),$G(FIELD))
 Q:RC<0 RC  Q:NODELIST="" 0
 ;--- Try to lock the object(s)
 I FLAGS'["D"  D  X TMP  E  Q $$LDSC^RALOCK01(.NODELIST)
 . S TMP="L +("_NODELIST_"):"_TO
 ;--- Create the lock descriptor(s)
 S DESCR=$$NOW^XLFDT_U_$G(NAME)_U_U_$JOB_U_$G(ZTSK)
 S:$G(NAME)="" $P(DESCR,U,3)=$G(DUZ)
 S NODE=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . S NDX=$$XLNDX^RALOCK01(NODE)
 . ;--- Calculate the lock counter
 . S TMP=$G(^XTMP("RALOCK",NDX))
 . S $P(DESCR,U,6)=$S($P(TMP,U,4)=$JOB:$P(TMP,U,6)+1,1:1)
 . ;--- Store the descriptor
 . S ^XTMP("RALOCK",NDX)=DESCR
 Q 0
 ;
 ;***** GENERATES A TEXT DESCRIPTION FROM THE LOCK DESCRIPTOR
 ;
 ; LDSC          Lock descriptor returned by the $$LOCKFM^RALOCK
 ;
 ; Return Values:
 ;       ""  If the 1st "^"-piece is not greater than 0,
 ;           then an empty string is returned.
 ;      ...  Otherwise, a text describing who/what and when
 ;           locked the object according to the descriptor
 ;
TEXT(LDSC) ;
 Q:LDSC'>0 ""
 N LTEXT,PARAMS,RABUF
 S PARAMS("LDT")=$$FMTE^XLFDT(+LDSC)  ; Lock date/time
 S PARAMS("NAME")=$P(LDSC,U,2)        ; User/process name
 S PARAMS("JOB")=$P(LDSC,U,4)         ; Job number
 S PARAMS("TASK")=$P(LDSC,U,5)        ; Task number
 D BLD^DIALOG(700005.002,.PARAMS,,"RABUF","S")
 Q RABUF(1)_$S(PARAMS("TASK")'="":$G(RABUF(2)),1:"")
 ;
 ;***** UNLOCKS THE (SUB)FILE, RECORD OR FIELD NODE
 ;
 ; [.]FILE       File/subfile number
 ; [IENS]        IENS of the record or subfile
 ; [FIELD]       Field number
 ;
 ;               See description of the LOCKFM^RALOCK for details
 ;               about the FILE, IENS, and FIELD parameters.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D UNLOCKFM^RALOCK(...) if you do not need its return value.
 ;
UNLOCKFM(FILE,IENS,FIELD) ;
 N DESCR,NDX,NODELIST,NODE,PI,RC
 I $D(FILE)<10  S RC=0  D:$G(FILE)>0  Q:$QUIT RC  Q
 . S RC=$$UNLOCK1^RALOCK01(FILE,$G(IENS),$G(FIELD))
 ;--- Compile the list of global nodes
 S RC=$$NODELIST^RALOCK01(.NODELIST,.FILE,$G(IENS),$G(FIELD))
 I RC<0  Q:$QUIT RC  Q
 I NODELIST=""  Q:$QUIT 0  Q
 ;--- Remove the lock descriptor(s)
 S NODE=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . S NDX=$$XLNDX^RALOCK01(NODE),DESCR=$G(^XTMP("RALOCK",NDX))
 . Q:$P(DESCR,U,4)'=$JOB
 . I $P(DESCR,U,6)>1  D
 . . S $P(^XTMP("RALOCK",NDX),U,6)=$P(DESCR,U,6)-1
 . E  K ^XTMP("RALOCK",NDX)
 ;--- Unlock the object(s)
 X "L -("_NODELIST_")"
 Q:$QUIT 0  Q

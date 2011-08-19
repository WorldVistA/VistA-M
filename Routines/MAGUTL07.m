MAGUTL07 ;WOIFO/SG - FILE/RECORD/FIELD LOCK ; 3/9/09 12:53pm
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
 ; Entry points of this routine use the ^XTMP("MAGLOCK",...) global
 ; nodes to store lock descriptors:
 ;
 ; ^XTMP("MAGLOCK",
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
 ; The NodeNdx is calculated by the $$XLNDX^MAGUTL08 as the name
 ; reference to the locked node without the closing parenthesis.
 ;
 ; This routine uses the following ICRs:
 ;
 ; #2054         Get value of the DILOCKTM variable
 ;
 Q
 ;
 ;##### LOCKS THE (SUB)FILE, RECORD OR FIELD NODE
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
 ;                 ;--- Lock the whole file #2005
 ;                 S FILE(2005)=""
 ;                 ;--- Lock the OBJECT GROUP multiple (4)
 ;                 S FILE(2005.04,",398,")=""
 ;                 ;--- Lock 2 images
 ;                 S FILE(2005,"454,")=""
 ;                 S FILE(2005,"455,")=""
 ;                 ;--- Lock just the node "40" of the image entry
 ;                 S FILE(2005,"123,",42)=""
 ;                 ;--- Lock the objects
 ;                 S RC=$$LOCKFM^MAGUTL07(.FILE)
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
 ; Input Variables
 ; ===============
 ;   MAGJOB("XTMPLOCK")
 ;
 ; Output Variables
 ; ================
 ;   MAGJOB("XTMPLOCK")
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok (the objects have been locked)
 ;           >0  The object is locked by another user or task and
 ;               a lock descriptor is returned.
 ;                 ^01: Date/Time (FileMan)
 ;                 ^02: User/Process name
 ;                 ^03: User IEN (DUZ). If this piece is empty, then
 ;                      check the 2nd piece for custom process name.
 ;                 ^04: $JOB
 ;                 ^05: Task number
 ;
LOCKFM(FILE,IENS,FIELD,TO,NAME,FLAGS) ;
 N DESCR,NDX,NODELIST,NODE,PI,RC,TMP
 S:$G(TO,-1)<0 TO=$G(DILOCKTM,3)
 S FLAGS=$G(FLAGS)
 ;
 ;=== Update the ^XTMP("MAGLOCK",0) once per session
 I '$D(MAGJOB("XTMPLOCK"))  D  S MAGJOB("XTMPLOCK")=""
 . D XTMPHDR^MAGUTL05("MAGLOCK",30,"Imaging LOCK Descriptors")
 . Q
 ;
 ;=== Check if a single object should be locked
 I $D(FILE)<10  S RC=0  D:$G(FILE)>0  Q RC
 . S RC=$$LOCK1^MAGUTL08(FILE,$G(IENS),$G(FIELD),TO,$G(NAME),FLAGS)
 . Q
 ;
 ;=== Compile the list of global nodes
 S RC=$$NODELIST^MAGUTL08(.NODELIST,.FILE,$G(IENS),$G(FIELD))
 Q:RC<0 RC  Q:NODELIST="" 0
 ;
 ;=== Try to lock the object(s)
 I FLAGS'["D"  D  X TMP  E  Q $$LDSC^MAGUTL08(.NODELIST)
 . S TMP="L +("_NODELIST_"):"_TO
 . Q
 ;
 ;=== Create the lock descriptor(s)
 S DESCR=$$NOW^XLFDT_U_$G(NAME)_U_U_$JOB_U_$G(ZTSK)
 S:$G(NAME)="" $P(DESCR,U,3)=$G(DUZ)
 S NODE=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . S NDX=$$XLNDX^MAGUTL08(NODE)
 . ;--- Calculate the lock counter
 . S TMP=$G(^XTMP("MAGLOCK",NDX))
 . S $P(DESCR,U,6)=$S($P(TMP,U,4)=$JOB:$P(TMP,U,6)+1,1:1)
 . ;--- Store the descriptor
 . S ^XTMP("MAGLOCK",NDX)=DESCR
 . Q
 ;===
 Q 0
 ;
 ;##### GENERATES A TEXT DESCRIPTION FROM THE LOCK DESCRIPTOR
 ;
 ; LDSC          Lock descriptor returned by the $$LOCKFM^MAGUTL07
 ;
 ; Return Values:
 ;       ""  If the 1st "^"-piece of the LDSC is not greater than 0,
 ;           then an empty string is returned.
 ;      ...  Otherwise, a text describing who/what and when
 ;           locked the object according to the descriptor
 ;
TEXT(LDSC) ;
 Q:LDSC'>0 ""
 N TEXT,TMP
 S TEXT="Locked by "_$P(LDSC,U,2)_" about "_$$FMTE^XLFDT(+LDSC)
 S TEXT=TEXT_"; Job #"_$P(LDSC,U,4)
 S TMP=$P(LDSC,U,5)  S:TMP'="" TEXT=TEXT_"; Task #"_TMP
 Q TEXT
 ;
 ;##### UNLOCKS THE (SUB)FILE, RECORD OR FIELD NODE
 ;
 ; [.]FILE       File/subfile number
 ; [IENS]        IENS of the record or subfile
 ; [FIELD]       Field number
 ;
 ;               See description of the LOCKFM^MAGUTL07 for details
 ;               about the FILE, IENS, and FIELD parameters.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok
 ;
 ; Notes
 ; =====
 ;
 ; This entry point can also be called as a procedure:
 ; D UNLOCKFM^MAGUTL07(...) if you do not need its return value.
 ;
UNLOCKFM(FILE,IENS,FIELD) ;
 N DESCR,NDX,NODELIST,NODE,PI,RC
 ;
 ;=== Check if a single object should be unlocked
 I $D(FILE)<10  S RC=0  D:$G(FILE)>0  Q:$QUIT RC  Q
 . S RC=$$UNLOCK1^MAGUTL08(FILE,$G(IENS),$G(FIELD))
 . Q
 ;
 ;=== Compile the list of global nodes
 S RC=$$NODELIST^MAGUTL08(.NODELIST,.FILE,$G(IENS),$G(FIELD))
 I RC<0  Q:$QUIT RC  Q
 I NODELIST=""  Q:$QUIT 0  Q
 ;
 ;=== Remove the lock descriptor(s)
 S NODE=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . S NDX=$$XLNDX^MAGUTL08(NODE),DESCR=$G(^XTMP("MAGLOCK",NDX))
 . Q:$P(DESCR,U,4)'=$JOB
 . I $P(DESCR,U,6)>1  D
 . . S $P(^XTMP("MAGLOCK",NDX),U,6)=$P(DESCR,U,6)-1
 . . Q
 . E  K ^XTMP("MAGLOCK",NDX)
 . Q
 ;
 ;=== Unlock the object(s)
 X "L -("_NODELIST_")"
 Q:$QUIT 0  Q

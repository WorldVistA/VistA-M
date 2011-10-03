RORLOCK ;HCIOFO/SG - LOCKS AND TRANSACTIONS ; 11/17/06 11:37am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** FINDS THE LOCK DESCRIPTOR FOR THE GLOBAL NODE
LDSC(NODELIST) ;
 N DESCR,IENS,L,NDX,NODE,RORMSG,SP,TMP
 S:$D(NODELIST)<10 NODELIST(NODELIST)=""
 S (DESCR,NODE)=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . ;--- The Node itself
 . S SP=$$XLNDX(NODE),TMP=$G(^XTMP("RORLOCK",SP))
 . S:TMP>DESCR DESCR=TMP
 . ;--- Left Siblings and Ancestors
 . S NDX=SP
 . F  S NDX=$O(^XTMP("RORLOCK",NDX),-1),L=$L(NDX)  Q:(NDX="")!(NDX'=$E(SP,1,L))  D
 . . S TMP=$G(^XTMP("RORLOCK",NDX))  S:TMP>DESCR DESCR=TMP
 . ;--- Right Siblings and Descendants
 . S NDX=SP,L=$L(SP)
 . F  S NDX=$O(^XTMP("RORLOCK",NDX))  Q:(NDX="")!($E(NDX,1,L)'=SP)  D
 . . S TMP=$G(^XTMP("RORLOCK",NDX))  S:TMP>DESCR DESCR=TMP
 ;--- Prepare the lock descriptor
 S:'DESCR $P(DESCR,U)=$$NOW^XLFDT
 D:$P(DESCR,U,3)>0
 . S IENS=+$P(DESCR,U,3)_","
 . S $P(DESCR,U,2)=$$GET1^DIQ(200,IENS,.01,,,"RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,200,IENS)
 S:$P(DESCR,U,2)="" $P(DESCR,U,2)="UNKNOWN USER"
 Q $P(DESCR,U,1,5)
 ;
 ;***** LOCKS THE (SUB)FILE, RECORD OR FIELD NODE
 ;
 ; FILE          File/subfile number
 ; [IENS]        IENS of the record or subfile
 ; [FIELD]       Field number
 ; [TO]          Timeout (1 sec, by default)
 ; [NAME]        Process name
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok (the object has been locked)
 ;       >0  The object is locked by another user. A lock descriptor
 ;           is returned in this case:
 ;             ^01: Date/Time (FileMan)
 ;             ^02: User/Process name
 ;             ^03: User IEN (DUZ)
 ;             ^04: $JOB
 ;             ^05: Task number
 ;
 ; If the third field is empty then the object is locked by a
 ; registry background process (see the name in the 2nd field).
 ;
LOCK(FILE,IENS,FIELD,TO,NAME) ;
 N DESCR,NDX,NODELIST,NODE,PI,RC,TMP
 I $D(FILE)<10  S RC=0  D:$G(FILE)>0  Q RC
 . S RC=$$LOCK1(FILE,$G(IENS),$G(FIELD),$G(TO),$G(NAME))
 ;--- Compile the list of global nodes
 S RC=$$NODELIST(.NODELIST,.FILE,$G(IENS),$G(FIELD))
 Q:RC<0 RC  Q:NODELIST="" 0
 ;--- Try to lock the object(s)
 X "L +("_NODELIST_"):"_$S($G(TO)>0:TO,1:3)  E  Q $$LDSC(.NODELIST)
 ;--- Create the lock descriptor(s)
 S DESCR=$$NOW^XLFDT_U_$G(NAME)_U_U_$JOB_U_$G(ZTSK)
 S:$G(NAME)="" $P(DESCR,U,3)=$G(DUZ)
 S NODE=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . S NDX=$$XLNDX(NODE)
 . ;--- Calculate the lock counter
 . S TMP=$G(^XTMP("RORLOCK",NDX))
 . S $P(DESCR,U,6)=$S($P(TMP,U,4)=$JOB:$P(TMP,U,6)+1,1:1)
 . ;--- Store the descriptor
 . S ^XTMP("RORLOCK",NDX)=DESCR
 Q 0
 ;
LOCK1(FILE,IENS,FIELD,TO,NAME) ;
 N DESCR,NDX,NODE,TMP
 S NODE=$$NODE(FILE,$G(IENS),$G(FIELD))
 Q:NODE<0 NODE
 ;--- Try to lock the object
 L +@NODE:$S($G(TO)>0:TO,1:3)  E  Q $$LDSC(NODE)
 ;--- Create the lock descriptor
 S DESCR=$$NOW^XLFDT_U_$G(NAME)_U_U_$JOB_U_$G(ZTSK)
 S:$G(NAME)="" $P(DESCR,U,3)=$G(DUZ)
 ;--- Calculate the lock counter
 S NDX=$$XLNDX(NODE),TMP=$G(^XTMP("RORLOCK",NDX))
 S $P(DESCR,U,6)=$S($P(TMP,U,4)=$JOB:$P(TMP,U,6)+1,1:1)
 ;--- Store the descriptor
 S ^XTMP("RORLOCK",NDX)=DESCR
 Q 0
 ;
 ;***** RETURNS THE GLOBAL NODE OF THE OBJECT
 ;
 ; FILE          File/subfile number
 ; IENS          IENS of the record or subfile
 ; FIELD         Field number
 ;
 ; Return Values:
 ;       <0  Error code
 ;           Closed root
 ;
NODE(FILE,IENS,FIELD) ;
 N FGL,IEN,NODE,RC
 S IEN=+IENS  S:IEN $P(IENS,",")=""
 ;--- Closed root of the (sub)file
 S NODE=$$ROOT^DILFD(FILE,IENS,1)
 I NODE=""  D  Q RC
 . S RC=$$ERROR^RORERR(-98,,,,FILE,IENS)
 Q:'IEN NODE
 ;--- The record node
 S NODE=$NA(@NODE@(IEN))
 Q:'FIELD NODE
 ;--- Field node
 S FGL=$$GET1^DID(FILE,FIELD,,"GLOBAL SUBSCRIPT LOCATION",,"RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,FILE)
 S:$P(FGL,";")'="" NODE=$NA(@NODE@($P(FGL,";")))
 Q NODE
 ;
 ;***** COMPILES THE LIST OF GLOBAL NODES
NODELIST(NODELIST,FILE,IENS,FIELD) ;
 N NODE,PI,RC  K NODELIST
 S NODELIST="",RC=0
 ;--- Main object
 I $G(FILE)>0  D  Q:RC<0 RC
 . S NODE=$$NODE(FILE,IENS,FIELD)
 . I NODE<0  S RC=+NODE  Q
 . S NODELIST=NODELIST_","_NODE
 . S NODELIST(NODE)=""
 ;--- Linked objects
 S PI="FILE"
 F  S PI=$Q(@PI)  Q:PI=""  D  Q:RC<0
 . S NODE=$$NODE($QS(PI,1),$QS(PI,2),$QS(PI,3))
 . I NODE<0  S RC=+NODE  Q
 . S NODELIST=NODELIST_","_NODE
 . S NODELIST(NODE)=""
 Q:RC<0 RC
 ;---
 S NODELIST=$P(NODELIST,",",2,999)
 Q RC
 ;
 ;***** GENERATES A TEXT DESCRIPTION FROM THE LOCK DESCRIPTOR
 ;
 ; LDSC          Lock descriptor returned by the $$LOCK^RORLOCK
 ;
TEXT(LDSC) ;
 N LTEXT
 S LTEXT=$P(LDSC,U,2)_" about "_$$FMTE^XLFDT(+LDSC)
 S:$P(LDSC,U,4) LTEXT=LTEXT_"; Job #"_$P(LDSC,U,4)
 S:$P(LDSC,U,5) LTEXT=LTEXT_"; Task #"_$P(LDSC,U,5)
 Q LTEXT
 ;
 ;***** UNLOCKS THE (SUB)FILE, RECORD OR FIELD NODE
 ;
 ; FILE          File/subfile number
 ; [IENS]        IENS of the record or subfile
 ; [FIELD]       Field number
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D UNLOCK^RORLOCK(...) if you do not need its return value.
 ;
UNLOCK(FILE,IENS,FIELD) ;
 N DESCR,NDX,NODELIST,NODE,PI,RC
 I $D(FILE)<10  S RC=0  D:$G(FILE)>0  Q:$QUIT RC  Q
 . S RC=$$UNLOCK1(FILE,$G(IENS),$G(FIELD))
 ;--- Compile the list of global nodes
 S RC=$$NODELIST(.NODELIST,.FILE,$G(IENS),$G(FIELD))
 I RC<0  Q:$QUIT RC  Q
 I NODELIST=""  Q:$QUIT 0  Q
 ;--- Remove the lock descriptor(s)
 S NODE=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . S NDX=$$XLNDX(NODE),DESCR=$G(^XTMP("RORLOCK",NDX))
 . Q:$P(DESCR,U,4)'=$JOB
 . I $P(DESCR,U,6)>1  D
 . . S $P(^XTMP("RORLOCK",NDX),U,6)=$P(DESCR,U,6)-1
 . E  K ^XTMP("RORLOCK",NDX)
 ;--- Unlock the object(s)
 X "L -("_NODELIST_")"
 Q:$QUIT 0  Q
 ;
UNLOCK1(FILE,IENS,FIELD) ;
 N DESCR,NDX,NODE
 S NODE=$$NODE(FILE,$G(IENS),$G(FIELD))
 Q:NODE<0 NODE
 ;--- Remove the lock descriptor
 S NDX=$$XLNDX(NODE),DESCR=$G(^XTMP("RORLOCK",NDX))
 D:$P(DESCR,U,4)=$JOB
 . I $P(DESCR,U,6)>1  D
 . . S $P(^XTMP("RORLOCK",NDX),U,6)=$P(DESCR,U,6)-1
 . E  K ^XTMP("RORLOCK",NDX)
 ;--- Unlock the object
 L -@NODE
 Q 0
 ;
 ;***** RETURNS SUBSCRIPT OF THE NODE IN THE DESCRIPTOR TABLE
XLNDX(NODE) ;
 N L  S L=$L(NODE)
 Q $S($E(NODE,L)=")":$E(NODE,1,L-1),1:NODE)

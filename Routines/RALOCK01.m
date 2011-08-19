RALOCK01 ;HCIOFO/SG - INTERNAL LOCK UTILITIES ; 5/14/08 3:22pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; Entry points of this routine use the ^XTMP("RALOCK",...) global
 ; nodes to store lock descriptors (see ^RALOCK routine for details).
 ;
 Q
 ;
 ;***** DELETES STRAY LOCK DESCRIPTORS
 ;
 ; NOTE: This is a service procedure. Do not call it from
 ;       regular applications!
 ;
PURGE() ;
 N NDX,NODE
 S NDX=0
 F  S NDX=$O(^XTMP("RALOCK",NDX))  Q:$E(NDX,1)'="^"  D
 . S NODE=$S(NDX["(":NDX_")",1:NDX)
 . D LOCK^DILF(NODE)  E  Q
 . K ^XTMP("RALOCK",NDX)  L -@NODE
 Q
 ;
 ;+++++ FINDS THE LOCK DESCRIPTOR FOR THE GLOBAL NODE(S)
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       any routines except RALOCK and RALOCK01
 ;
LDSC(NODELIST) ;
 N DESCR,IENS,L,NDX,NODE,RAMSG,SP,TMP
 S:$D(NODELIST)<10 NODELIST(NODELIST)=""
 S (DESCR,NODE)=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . ;--- The Node itself
 . S SP=$$XLNDX(NODE),TMP=$G(^XTMP("RALOCK",SP))
 . S:TMP>DESCR DESCR=TMP
 . ;--- Left Siblings and Ancestors
 . S NDX=SP
 . F  S NDX=$O(^XTMP("RALOCK",NDX),-1),L=$L(NDX)  Q:(NDX="")!(NDX'=$E(SP,1,L))  D
 . . S TMP=$G(^XTMP("RALOCK",NDX))  S:TMP>DESCR DESCR=TMP
 . ;--- Right Siblings and Descendants
 . S NDX=SP,L=$L(SP)
 . F  S NDX=$O(^XTMP("RALOCK",NDX))  Q:(NDX="")!($E(NDX,1,L)'=SP)  D
 . . S TMP=$G(^XTMP("RALOCK",NDX))  S:TMP>DESCR DESCR=TMP
 ;--- Prepare the lock descriptor
 S:'DESCR $P(DESCR,U)=$$NOW^XLFDT
 D:$P(DESCR,U,3)>0
 . S IENS=+$P(DESCR,U,3)_","
 . S $P(DESCR,U,2)=$$GET1^DIQ(200,IENS,.01,,,"RAMSG")  ; User Name
 S:$P(DESCR,U,2)="" $P(DESCR,U,2)="UNKNOWN"
 Q $P(DESCR,U,1,5)
 ;
 ;+++++ LOCKS THE SINGLE NODE
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       any routines except RALOCK and RALOCK01
 ;
LOCK1(FILE,IENS,FIELD,TO,NAME,FLAGS) ;
 N DESCR,NDX,NODE,TMP
 S NODE=$$NODE(FILE,IENS,FIELD)
 Q:NODE<0 NODE
 ;--- Try to lock the object
 I FLAGS'["D"  L +@NODE:TO  E  Q $$LDSC(NODE)
 ;--- Create the lock descriptor
 S DESCR=$$NOW^XLFDT_U_NAME_U_U_$JOB_U_$G(ZTSK)
 S:NAME="" $P(DESCR,U,3)=$G(DUZ)
 ;--- Calculate the lock counter
 S NDX=$$XLNDX(NODE),TMP=$G(^XTMP("RALOCK",NDX))
 S $P(DESCR,U,6)=$S($P(TMP,U,4)=$JOB:$P(TMP,U,6)+1,1:1)
 ;--- Store the descriptor
 S ^XTMP("RALOCK",NDX)=DESCR
 Q 0
 ;
 ;+++++ RETURNS THE GLOBAL NODE OF THE OBJECT
 ;
 ; FILE          File/subfile number
 ; IENS          IENS of the record or subfile
 ; FIELD         Field number
 ;
 ; Return Values:
 ;       <0  Error code
 ;           Closed root
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       any routines except RALOCK and RALOCK01
 ;
NODE(FILE,IENS,FIELD) ;
 N FGL,IEN,NODE,RAMSG,RC
 I IENS'=""  Q:'$$VALIENS^RAUTL22(IENS,"S") $$IPVE^RAERR("IENS")
 S IEN=+IENS
 I IEN  S $P(IENS,",")=""  S:IENS="," IENS=""
 ;--- Closed root of the (sub)file
 S NODE=$$ROOT^DILFD(FILE,IENS,1)
 I NODE=""  D  Q RC
 . S RC=$$ERROR^RAERR(-50,,FILE,IENS)
 Q:'IEN NODE
 ;--- The record node
 S NODE=$NA(@NODE@(IEN))
 Q:'FIELD NODE
 ;--- Field node
 S FGL=$$GET1^DID(FILE,FIELD,,"GLOBAL SUBSCRIPT LOCATION",,"RAMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RAERR("RAMSG",-9,FILE)
 S:$P(FGL,";")'="" NODE=$NA(@NODE@($P(FGL,";")))
 Q NODE
 ;
 ;+++++ COMPILES THE LIST OF GLOBAL NODES
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       any routines except RALOCK and RALOCK01
 ;
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
 ;+++++ UNLOCKS THE SINGLE NODE
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       any routines except RALOCK and RALOCK01
 ;
UNLOCK1(FILE,IENS,FIELD) ;
 N DESCR,NDX,NODE
 S NODE=$$NODE(FILE,IENS,FIELD)
 Q:NODE<0 NODE
 ;--- Remove the lock descriptor
 S NDX=$$XLNDX(NODE),DESCR=$G(^XTMP("RALOCK",NDX))
 D:$P(DESCR,U,4)=$JOB
 . I $P(DESCR,U,6)>1  D
 . . S $P(^XTMP("RALOCK",NDX),U,6)=$P(DESCR,U,6)-1
 . E  K ^XTMP("RALOCK",NDX)
 ;--- Unlock the object
 L -@NODE
 Q 0
 ;
 ;+++++ RETURNS SUBSCRIPT OF THE NODE IN THE DESCRIPTOR TABLE
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       any routines except RALOCK and RALOCK01
 ;
XLNDX(NODE) ;
 N L  S L=$L(NODE)
 Q $S($E(NODE,L)=")":$E(NODE,1,L-1),1:NODE)

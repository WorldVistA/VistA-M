MAGUTL08 ;WOIFO/SG - INTERNAL LOCK UTILITIES ; 3/9/09 12:54pm
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
 ; nodes to store lock descriptors (see the MAGUTL07 routine for
 ; details).
 ;
 ; This routine uses the following ICRs:
 ;
 ; #10060        Read file #200 (supported)
 ;
 Q
 ;
 ;##### DELETES STRAY LOCK DESCRIPTORS
 ;
 ; This is a service procedure. Do not call it from regular
 ; applications!
 ;
PURGE() ;
 N NDX,NODE
 S NDX=0
 F  S NDX=$O(^XTMP("MAGLOCK",NDX))  Q:$E(NDX,1)'="^"  D
 . S NODE=$S(NDX["(":NDX_")",1:NDX)
 . D LOCK^DILF(NODE)  E  Q
 . K ^XTMP("MAGLOCK",NDX)  L -@NODE
 . Q
 Q
 ;
 ;+++++ RETURNS THE LOCK DESCRIPTOR FOR THE GLOBAL NODE(S)
 ;
 ; This is an internal entry point. Do not call it from any routines
 ; except MAGUTL07 and MAGUTL08.
 ;
LDSC(NODELIST) ;
 N DESCR,IENS,L,MAGMSG,NDX,NODE,SP,TMP
 S:$D(NODELIST)<10 NODELIST(NODELIST)=""
 ;
 ;=== Search for the most appropriate descriptor
 S (DESCR,NODE)=""
 F  S NODE=$O(NODELIST(NODE))  Q:NODE=""  D
 . ;--- The node itself
 . S SP=$$XLNDX(NODE),TMP=$G(^XTMP("MAGLOCK",SP))
 . S:TMP>DESCR DESCR=TMP
 . ;--- Left siblings and ancestors
 . S NDX=SP
 . F  S NDX=$O(^XTMP("MAGLOCK",NDX),-1),L=$L(NDX)  Q:(NDX="")!(NDX'=$E(SP,1,L))  D
 . . S TMP=$G(^XTMP("MAGLOCK",NDX))  S:TMP>DESCR DESCR=TMP
 . . Q
 . ;--- Right siblings and descendants
 . S NDX=SP,L=$L(SP)
 . F  S NDX=$O(^XTMP("MAGLOCK",NDX))  Q:(NDX="")!($E(NDX,1,L)'=SP)  D
 . . S TMP=$G(^XTMP("MAGLOCK",NDX))  S:TMP>DESCR DESCR=TMP
 . . Q
 . Q
 ;
 ;=== Populate as many fields of the descriptor as possible
 S:'DESCR $P(DESCR,U)=$$NOW^XLFDT
 ;--- Get the user name if the DUZ is available
 D:$P(DESCR,U,3)>0
 . S IENS=+$P(DESCR,U,3)_","
 . S $P(DESCR,U,2)=$$GET1^DIQ(200,IENS,.01,,,"MAGMSG")
 . Q
 ;--- If the originator of the lock is unknown, indicate this fact
 S:$P(DESCR,U,2)="" $P(DESCR,U,2)="UNKNOWN"
 ;
 ;=== Return the lock descriptor
 Q $P(DESCR,U,1,5)
 ;
 ;+++++ LOCKS THE SINGLE NODE
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok
 ;           >0  Lock descriptor
 ;
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from any routines
 ; except MAGUTL07 and MAGUTL08.
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
 S NDX=$$XLNDX(NODE),TMP=$G(^XTMP("MAGLOCK",NDX))
 S $P(DESCR,U,6)=$S($P(TMP,U,4)=$JOB:$P(TMP,U,6)+1,1:1)
 ;--- Store the descriptor
 S ^XTMP("MAGLOCK",NDX)=DESCR
 Q 0
 ;
 ;+++++ RETURNS THE GLOBAL NODE OF THE OBJECT
 ;
 ; FILE          File/subfile number
 ; IENS          IENS of the record or subfile
 ; FIELD         Field number
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;          ...  Closed root
 ;
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from any routines
 ; except MAGUTL07 and MAGUTL08.
 ;
NODE(FILE,IENS,FIELD) ;
 N FGL,IEN,MAGMSG,NODE,RC
 I IENS'=""  Q:'$$VALIENS^MAGUTL05(IENS,"S") $$IPVE^MAGUERR("IENS")
 S IEN=+IENS
 I IEN  S $P(IENS,",")=""  S:IENS="," IENS=""
 ;--- Closed root of the (sub)file
 S NODE=$$ROOT^DILFD(FILE,IENS,1)
 Q:NODE="" $$ERROR^MAGUERR(-48,,FILE,IENS)
 Q:'IEN NODE
 ;--- The record node
 S NODE=$NA(@NODE@(IEN))
 Q:'FIELD NODE
 ;--- Field node
 S FGL=$$GET1^DID(FILE,FIELD,,"GLOBAL SUBSCRIPT LOCATION",,"MAGMSG")
 Q:$G(DIERR) $$DBS^MAGUERR("MAGMSG",FILE)
 S:$P(FGL,";")'="" NODE=$NA(@NODE@($P(FGL,";")))
 Q NODE
 ;
 ;+++++ COMPILES THE LIST OF GLOBAL NODES
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok
 ;
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from any routines
 ; except MAGUTL07 and MAGUTL08.
 ;
NODELIST(NODELIST,FILE,IENS,FIELD) ;
 N NODE,PI,RC  K NODELIST
 S NODELIST="",RC=0
 ;--- Main object
 I $G(FILE)>0  D  Q:RC<0 RC
 . S NODE=$$NODE(FILE,IENS,FIELD)
 . I NODE<0  S RC=NODE  Q
 . S NODELIST=NODELIST_","_NODE
 . S NODELIST(NODE)=""
 . Q
 ;--- Linked objects
 S PI="FILE"
 F  S PI=$Q(@PI)  Q:PI=""  D  Q:RC<0
 . S NODE=$$NODE($QS(PI,1),$QS(PI,2),$QS(PI,3))
 . I NODE<0  S RC=NODE  Q
 . S NODELIST=NODELIST_","_NODE
 . S NODELIST(NODE)=""
 . Q
 Q:RC<0 RC
 ;---
 S NODELIST=$P(NODELIST,",",2,999)
 Q RC
 ;
 ;+++++ UNLOCKS THE SINGLE NODE
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Ok
 ;
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from any routines
 ; except MAGUTL07 and MAGUTL08.
 ;
UNLOCK1(FILE,IENS,FIELD) ;
 N DESCR,NDX,NODE
 S NODE=$$NODE(FILE,IENS,FIELD)
 Q:NODE<0 NODE
 ;--- Remove the lock descriptor
 S NDX=$$XLNDX(NODE),DESCR=$G(^XTMP("MAGLOCK",NDX))
 D:$P(DESCR,U,4)=$JOB
 . I $P(DESCR,U,6)>1  D
 . . S $P(^XTMP("MAGLOCK",NDX),U,6)=$P(DESCR,U,6)-1
 . . Q
 . E  K ^XTMP("MAGLOCK",NDX)
 . Q
 ;--- Unlock the object
 L -@NODE
 Q 0
 ;
 ;+++++ RETURNS SUBSCRIPT OF THE NODE IN THE DESCRIPTOR TABLE
 ;
 ; This is an internal entry point. Do not call it from any routines
 ; except MAGUTL07 and MAGUTL08.
 ;
XLNDX(NODE) ;
 N L  S L=$L(NODE)
 Q $S($E(NODE,L)=")":$E(NODE,1,L-1),1:NODE)

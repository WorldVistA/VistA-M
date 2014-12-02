MAGTP003 ;WOIFO/FG,MLH,JSL - TELEPATHOLOGY RPCS ; 25 Jul 2013 5:38 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q  ;
 ;
 ;***** SET/UNSET A LOGICAL LOCK ON A RECORD FOR CASE RESERVATION
 ; RPC: MAGTP RESERVE CASE
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LFLAG         Flag that controls whether to lock or unlock
 ;               (0:Unlocked, 1:Locked)
 ;
 ; LRSS          AP Section
 ;
 ; YEAR          Accession Year (Two figures)
 ;
 ; LRAN          Accession Number
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is < 0, then an error
 ; occurred during execution of the procedure: <code>^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 0
 ;                ^02: 0 if case record is unlocked, 1 if case record is locked
 ;                ^03: "Reservation ended" if case record is unlocked
 ;                     "Case reserved" if case record is locked
 ;
LOCKR(MAGRY,LFLAG,LRSS,YEAR,LRAN) ; RPC [MAGTP RESERVE CASE]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGUTERR"
 D  Q:$G(MAGRY(0))  ; validate inputs
 . I $G(LRSS)="" S MAGRY(0)="-2^^ERROR: AP subsection not specified" Q
 . I $G(YEAR)="" S MAGRY(0)="-3^^ERROR: Year not specified" Q
 . I $G(LRAN)="" S MAGRY(0)="-4^^ERROR: Accession index not specified" Q
 . Q
 N INPUT
 D  Q:$G(MAGRY(0))  ; validate context
 . N OUT
 . S INPUT=$$CONTEXT^MAGTP006(.OUT,LRSS,YEAR,LRAN)
 . D:'$G(OUT(0))  ; context not OK
 . . S MAGRY(0)="-5^^ERROR: Invalid context - "
 . . S MAGRY(0)=MAGRY(0)_$P(OUT(0),"^",3)
 . . Q
 . Q
 N MAGFDA,MAGERR
 N LRSF,IEN,LRAC,REC,ISLOCK
 N LDT,LDUZ,LUSER,TEXT,LRAA,YR
 S LRSF=$P(INPUT,","),IEN=$P(INPUT,",",2,4)
 S LRAC=$$GET1^DIQ(LRSF,IEN,.06)               ; Accession code
 D:LRAC=""   ;try new style (LEDI)
 . S LRAA=$O(^LRO(68,"B",LRSS,0)) ;new style cases
 . S YR=$S($L(YEAR)=2:300+YEAR*10000,1:YEAR) ;try 2000 
 . I +$P($G(^LRO(68,LRAA,1,YR,1,LRAN,0)),"^",1) S LRAC=$G(^LRO(68,LRAA,1,YR,1,LRAN,.2)) Q:LRAC]""
 . S YR=$S($L(YEAR)=2:200+YEAR*10000,1:YEAR) ;try 1900
 . I +$P($G(^LRO(68,LRAA,1,YR,1,LRAN,0)),"^",1) S LRAC=$G(^LRO(68,LRAA,1,YR,1,LRAN,.2))
 . Q
 I LRAC="" S MAGRY(0)="-6^^ERROR: No Accession Code for this case " Q
 S REC=$O(^MAG(2005.42,"B",LRAC,""))_","       ; Record number
 ;
 ; Update lock record with present user's data (or clear lock)
 ;
 S MAGFDA(2005.42,REC,1)=LFLAG
 S MAGFDA(2005.42,REC,1.1)=$S(LFLAG:$$NOW^XLFDT,1:"")
 S MAGFDA(2005.42,REC,1.2)=$S(LFLAG:DUZ,1:"")
 D UPDATE^DIE("","MAGFDA","","MAGERR")         ; Update lock record
 I $D(MAGERR) S MAGRY(0)="-7^^ERROR: Update error - "_MAGERR("DIERR",1,"TEXT",1) Q
 ;
 S TEXT=$S(LFLAG:"1^Case reserved",1:"0^Reservation ended")
 S MAGRY(0)="0^"_TEXT
 Q  ;

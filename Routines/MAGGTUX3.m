MAGGTUX3 ;WIOFO/GEK Imaging utility to validate INDEX values.
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 Q
 ; VALTUX1 and VALTUX2 : 
 ; Copied VALINDEX from MAGGSIV1 and modified for use with IEN's as input
 ; for the TYPE SPEC PROC parameters.  Running time of utility is 
 ; reduced 10 fold.
 ; VALTUX2 called from CHECK and FIX in MAGGTUX.
 ;    it sets ^XTMP global for later review.
 ; VALTUX1 called From REVIEW, to produce the Readable Output.
 ;
VALTUX1(MAGRY,TYPE,SPEC,PROC) ; Validate the interdependency of Index Terms.
 ; MAGRY is the return array 
 ; MAGRY(0)="1^Okay"  or   "0^error message"
 ; MAGRY(1..n)  Information about the Type,Spec and Proc
 ; 
 ; - Validate the Procedure/Event <-> Specialty/SubSpecialty interdependency
 ; - Assure the TYPE is a Clinical TYPE.
 ; - Assure all are Active.
 ; 
 N CLS,ARR,TYX,PRX,SPX,OK
 K MAGRY
 S TYPE=$G(TYPE),PROC=$G(PROC),SPEC=$G(SPEC)
 I ((PROC]"")!(SPEC]"")) I TYPE="" S MAGRY(0)="0^Type is required." Q 0
 ;
 I TYPE D  I 'OK S MAGRY(0)=OK Q 0
 . S OK=1,TYX=TYPE_","
 . K ARR D GETS^DIQ(2005.83,TYX,".01;1;2","EI","ARR")
 . S MAGRY(1)="Type - Class          : "_ARR(2005.83,TYX,.01,"E")_" - "_ARR(2005.83,TYX,1,"E")
 . I $L(ARR(2005.83,TYX,2,"E")) S MAGRY(1)=MAGRY(1)_" - "_ARR(2005.83,TYX,2,"E")
 . I ARR(2005.83,TYX,2,"I")="I" S OK="0^Type is Inactive"
 . Q
 ;
 I SPEC D  I 'OK S MAGRY(0)=OK Q 0
 . S OK=1,SPX=SPEC_","
 . K ARR D GETS^DIQ(2005.84,SPX,".01;2;4","EI","ARR")
 . S MAGRY(2)="Specialty/SubSpecialty: "_ARR(2005.84,SPX,.01,"E")
 . I $L(ARR(2005.84,SPX,4,"E")) S MAGRY(2)=MAGRY(2)_" - "_ARR(2005.84,SPX,4,"E")
 . I $L(ARR(2005.84,SPX,2,"E")) S MAGRY(2)=MAGRY(2)_" <"_ARR(2005.84,SPX,2,"E")_">"
 . I ARR(2005.84,SPX,4,"I")="I" S OK="0^Specialty is Inactive"
 . Q
 ;
 I PROC D  I 'OK S MAGRY(0)=OK Q 0
 . S OK=1,PRX=PROC_","
 . K ARR D GETS^DIQ(2005.85,PRX,".01;4","EI","ARR")
 . S MAGRY(4)="Procedure/Event       : "_$$GET1^DIQ(2005.85,PROC,.01)
 . I $L(ARR(2005.85,PRX,4,"E")) S MAGRY(4)=MAGRY(4)_" - "_ARR(2005.85,PRX,4,"E")
 . I ARR(2005.85,PRX,4,"I")="I" S OK="0^Procedure is Inactive"
 . Q
 ;
 ; If PROC and SPEC are "", then Quit, any TYPE by itself is valid
 I (PROC=""),(SPEC="") S MAGRY(0)="1^Okay" Q 1
 ; Here, TYPE has to be Clin.
 S CLS=$$GET1^DIQ(2005.83,TYPE,1,"","MAGTAR") I $E(CLS,1,5)="ADMIN" D  Q 0
 . S MAGRY(0)="0^The Type Index is Administrative, it has to be Clinical."
 I (PROC="")!(SPEC="") S MAGRY(0)="1^Okay" Q 1
 ; we get here, we have to validate the interdependency of SPEC <-> PROC.
 I '$O(^MAG(2005.85,PROC,1,0)) S MAGRY(0)="1^Okay" Q 1
 I '$D(^MAG(2005.85,PROC,1,"B",SPEC)) D  Q 0
 . S MAGRY(0)="0^Invalid Association between Spec/SubSpec and Proc/Event"
 . Q
 S MAGRY(0)="1^Okay"
 Q 1
VALTUX2(MAGRY,TYPE,SPEC,PROC) ; Validate the interdependency of Index Terms.
 ; MAGRY is the return array 
 ; MAGRY(0)="1^Okay"  or   "0^error message"
 ; MAGRY(1..n)  Information about the Type,Spec and Proc
 ; 
 ; - Validate the Procedure/Event <-> Specialty/SubSpecialty interdependency
 ; - Assure the TYPE is a Clinical TYPE.
 ; - Assure all are Active.
 K MAGRY
 S TYPE=$G(TYPE),PROC=$G(PROC),SPEC=$G(SPEC)
 I ((PROC]"")!(SPEC]"")) I TYPE="" S MAGRY(0)="0^Type is required." Q 0
 ; TYPE is required, but not enforcing yet.  All vendors are not sending
 I TYPE I $P(^MAG(2005.83,TYPE,0),"^",3)="I" S MAGRY(0)="0^Type is Inactive" Q 0
 ;
 I SPEC I $P(^MAG(2005.84,SPEC,0),"^",4)="I" S MAGRY(0)="0^Specialty is Inactive" Q 0
 ;
 I PROC I $P(^MAG(2005.85,PROC,0),"^",3)="I" S MAGRY(0)="0^Procedure is Inactive" Q 0
 ;
 ; If PROC and SPEC are "", then Quit, any TYPE by itself is valid
 I (PROC=""),(SPEC="") S MAGRY(0)="1^Okay" Q 1
 ; Here, TYPE has to be Clin.
 I $P(^MAG(2005.83,TYPE,0),"^",2)>7 S MAGRY(0)="0^The Type Index is Administrative, it has to be Clinical." Q 0
 I (PROC="")!(SPEC="") S MAGRY(0)="1^Okay" Q 1
 ; we get here, we have to validate the interdependency of SPEC <-> PROC.
 ; 
 ; if PROC is not pointing to any SPEC's, then it is okay for all
 I '$O(^MAG(2005.85,PROC,1,0)) S MAGRY(0)="1^Okay" Q 1
 ; if PROC doesn't point to SPEC - it is Invalid.
 I '$D(^MAG(2005.85,PROC,1,"B",SPEC)) D  Q 0
 . S MAGRY(0)="0^Invalid Association between Spec/SubSpec and Proc/Event"
 . Q
 S MAGRY(0)="1^Okay"
 Q 1

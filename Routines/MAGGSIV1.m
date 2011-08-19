MAGGSIV1 ;WOIFO/GEK - Imaging Validate Data ; [ 08/15/2004 08:57 ]
 ;;3.0;IMAGING;**8,20,59**;Nov 27, 2007;Build 20
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
VALID(MAGF,MAGL,MAGD,MAGRES) ; call to validate value for field in a FM file.
 ; Function is boolean.  Returns:
 ;        0   -  Invalid 
 ;        1   -  Valid 
 ;        ""  -  Error
 ; Call this function before you set the FDA Array.
 ; MAGD - sent by reference because it could be Internal or External
 ;        and if it is external and valid, it is changed to Internal.
 ;        
 ; MAGF  : File Number
 ; MAGL  : Field Number
 ; MAGD  : (sent by reference) data value of field
 ; MAGRES: (sent by reference) Result message
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 N MAGR,MAGMSG,MAGSP,MAGRESA,MAGE,MAGPT
 ;if a BAD field number
 I '$$VFIELD^DILFD(MAGF,MAGL) D  Q 0
 . S MAGRES="The field number: "_MAGL_", in File: "_MAGF_", is invalid."
 D FIELD^DID(MAGF,MAGL,"","SPECIFIER","MAGSP")
 ; If it is a pointer field 
 ; If an  integer - We assume it is a pointer and validate that and Quit.
 ; If not integer - We assume it is external value, proceed to let CHK do validate
 I (MAGSP("SPECIFIER")["P"),(+MAGD=MAGD) D  Q MAGPT
 . I $$EXTERNAL^DILFD(MAGF,MAGL,"",MAGD)'="" S MAGPT=1,MAGRES="Valid pointer" Q
 . S MAGPT=0,MAGRES="The value: "_MAGD_" for field: "_MAGL_" in File: "_MAGF_" is an invalid Pointer."
 . Q
 ;
 D CHK^DIE(MAGF,MAGL,"E",MAGD,.MAGR,"MAGMSG")
 ; If success, Quit. We changed External to Internal. Internal is in MAGR
 I MAGR'="^" S MAGD=MAGR Q 1
 ;  If not success Get the error text and Quit 0
 D MSG^DIALOG("A",.MAGRESA,245,5,"MAGMSG")
 S MAGRES=MAGRESA(1)
 Q 0
VALINDEX(MAGRY,TYPE,SPEC,PROC) ; Validate the interdependency of Index Terms.
 ; MAGRY is the return array 
 ; MAGRY(0)="1^Okay"  or   "0^error message"
 ; MAGRY(1..n)  Information about the Type,Spec and Proc
 ; 
 ; Validate the Procedure/Event <-> Specialty/SubSpecialty interdependency
 ; Assure the TYPE is a Clinical TYPE.
 ; Assure all are Active.
 N CLS,RES,ARR,TYX,PRX,SPX,OK
 K MAGRY
 S TYPE=$G(TYPE),PROC=$G(PROC),SPEC=$G(SPEC)
 I TYPE=0 S TYPE=""
 I PROC=0 S PROC=""
 I SPEC=0 S SPEC=""
 I ((PROC]"")!(SPEC]"")) I TYPE="" S MAGRY(0)="0^Type is required." Q 0
 ; TYPE is required, but not enforcing yet.  All vendors are not sending
 ; index values.
 ; VALID will accept External or Internal and return Internal if Valid
 I $L(TYPE) I '$$VALID(2005,42,.TYPE,.RES) S MAGRY(0)="0^"_RES Q 0
 I $L(PROC) I '$$VALID(2005,43,.PROC,.RES) S MAGRY(0)="0^"_RES Q 0
 I $L(SPEC) I '$$VALID(2005,44,.SPEC,.RES) S MAGRY(0)="0^"_RES Q 0
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
ERR ;
 N ERR
 S ERR=$$EC^%ZOSV
 S MAGRES="0^Error during data validation: "_ERR
 D LOGERR^MAGGTERR(ERR)
 D @^%ZOSF("ERRTN")
 D CLEAN^DILF
 Q

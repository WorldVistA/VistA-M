ORRHCU ; SLC/KCM - CPRS Query Tools - Utilities ; [8/6/03 1:27Pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153,174**;Dec 17, 1997
 ;
NXT() ; Increment ILST
 S ILST=ILST+1
 Q ILST
 ;
RNG2FM(RNG)     ; convert a relative date range to Fileman dates
 N FMRNG
 I $E(RNG,1)="Y" D
 . N YR,TYP,QTR
 . S YR=$E(DT,1,3),TYP=$E(RNG,2) I (TYP="F"),(+$E(DT,4,5)>9) S YR=YR+1
 . S YR=YR+$E(RNG,3,999)
 . I (RNG["Q"),($P(RNG,"Q",2)="") S RNG=RNG_$$CURQTR($E(RNG,2)="F")
 . I $P(RNG,"Q",2)="" D  Q
 . . I TYP="C" S FMRNG=YR_"0101:"_YR_"1231"
 . . I TYP="F" S FMRNG=(YR-1)_"1001:"_YR_"0930"
 . S QTR=+$P(RNG,"Q",2)
 . I TYP="F" S:QTR=1 YR=YR-1 S QTR=QTR-1 S:QTR=0 QTR=4
 . S FMRNG=YR_$P("0101^0401^0701^1001",U,QTR)_":"_YR
 . S FMRNG=FMRNG_$P("0331^0630^0930^1231",U,QTR)
 E  D
 . N BDT,EDT,%DT,X,Y
 . S BDT=$P(RNG,":",1),EDT=$P(RNG,":",2)
 . I $L(BDT) S X=BDT D ^%DT S BDT=Y
 . I $L(EDT) S X=EDT D ^%DT S EDT=Y
 . I '$L(BDT) S BDT=0
 . I '$L(EDT) S EDT=9999999
 . S FMRNG=BDT_":"_EDT
 Q FMRNG
CURQTR(ISFY)    ; return the current fiscal or calendar quarter
 N QTR
 S QTR=$P(($E(DT,4,5)-1)/3,".")+1
 I ISFY S QTR=QTR+1 S:QTR=5 QTR=1
 Q QTR
ID2EXT(LST,FN,IDLST)     ; Return the external values for a set if IENs
 N I
 S I=0 F  S I=$O(IDLST(I)) Q:'I  D
 . I +IDLST(I)=0 S LST(I)=IDLST(I) Q
 . S LST(I)=IDLST(I)_U_$$GET1^DIQ(FN,IDLST(I),.01)
 Q
BYREG(LST,NAM,MOD)      ; List patients from registry
 N ILST,RC,ITR,PATID S ILST=0
 I $$PATITER^RORAPI01(.ITR,NAM,MOD)<0 Q
 F  S RC=$$NEXTPAT^RORAPI01(.ITR)  Q:RC'>0  D
 . S PATID=$P(RC,U)
 . S LST($$NXT)=PATID_U_$P(^DPT(PATID,0),U)
 Q
REGLST(LST)     ; List available local registries
 S LST(1)="VA HEPC^Local HepC Registry"
 Q
REGNAM(VAL,ID)  ; Return the full name of a registry
 S VAL="Unknown Registry"
 I ID="VA HEPC" S VAL="Local HepC Registry"
 Q
NMVAL(NM,VAL)   ; Set a name=value pair
 Q:NM=""  Q:VAL=""
 S LST($$NXT)=NM_"="_VAL
 Q
DFLDS(LST,TYP)  ; List display fields
 N I,J,ILST,X0 S ILST=0
 S TYP=$$DFLDTRAN(TYP) ; consults, orders return same fields
 S I=0 F  S I=$O(^ORD(102.24,I)) Q:'I  D
 . S X0=^ORD(102.24,I,0)
 . Q:TYP'[$E(X0)  ; 1st char of name corresponds to type
 . ; S LST($$NXT)=X0
 . D NMVAL("DisplayName",$P(X0,U,2))  ; must be first
 . D NMVAL("InternalName",$P(X0,U))
 . D NMVAL("HeaderName",$P(X0,U,3))
 . D NMVAL("SortType",$P(X0,U,4))
 . S J=0 F  S J=$O(^ORD(102.24,I,1,J)) Q:'J  D
 . . D NMVAL("SampleData",$G(^ORD(102.24,I,1,J,0)))
 Q
COLTYP(LST,SRC) ; List the column types
 N I,IEN
 S I=0 F  S I=$O(SRC(I)) Q:'I  D
 . S IEN=$O(^ORD(102.24,"B",SRC(I),0))
 . I 'IEN S LST(I)=SRC(I)_"^0"
 . E  S LST(I)=SRC(I)_U_$P($G(^ORD(102.24,IEN,0)),U,4)
 Q
 ;
DFLDMAP(LST)    ; Returns a mapping of constraint types to display field types
 N FLDLIST S FLDLIST=$$GETFLDLS
 N TRANSLST S TRANSLST=$$DFLDTRAN(FLDLIST)
 N I S I=0
 F  S I=I+1 Q:I>$L(FLDLIST)  D
 .S LST(I)=$E(FLDLIST,I)_"="_$E(TRANSLST,I)
 Q
 ;
DFLDTRAN(FLD)   ;Translates the constraint types to the display field types
 Q $TR(FLD,"C","O")
 ;
GETFLDLS()      ;Returns a list of defined display fields
 N LIST
 S LIST="PODVC"
 Q LIST
 ;

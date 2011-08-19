IBCEF73 ;WOIFO/SS - FORMATTER AND EXTRACTOR SPECIFIC BILL FUNCTIONS ;8/6/03 10:56am
 ;;2.0;INTEGRATED BILLING;**232,320,358,349,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;check qualifier
 ;IBFRM 0-both, 1=UB,2=1500
 ;IBPROV - function in #399 (1-referring, 2-operating,etc)
 ;IBTYPE - "C"-current insurance, "O"-other insurance
 ;IBVAL - value to check
CHCKSEC(IBFRM,IBPROV,IBTYPE,IBVAL) ;
 I IBFRM=0 Q:$$CHSEC(1,IBPROV,IBTYPE,IBVAL) 1  Q $$CHSEC(2,IBPROV,IBTYPE,IBVAL)
 Q $$CHSEC(IBFRM,IBPROV,IBTYPE,IBVAL)
 ;
CHSEC(IBFRM,IBPROV,IBTYPE,IBVAL) ;
 N IBSTR S IBSTR=""
 ;referring
 I IBPROV=1 S IBSTR=$S(IBTYPE="C":$$OPR5(IBFRM),IBTYPE="O":$$OP4(IBFRM),1:"")
 ;operating
 I IBPROV=2 S IBSTR=$S(IBTYPE="C":$$OPR3(IBFRM),IBTYPE="O":$$OP2(IBFRM),1:"")
 ;rendering
 I IBPROV=3 S IBSTR=$S(IBTYPE="C":$$OPR2(IBFRM),IBTYPE="O":$$OP1(IBFRM),1:"")
 ;attending
 I IBPROV=4 S IBSTR=$S(IBTYPE="C":$$OPR2(IBFRM),IBTYPE="O":$$OP1(IBFRM),1:"")
 ;supervising
 I IBPROV=5 S IBSTR=$S(IBTYPE="C":$$OPR8(IBFRM),IBTYPE="O":$$OP8(IBFRM),1:"")
 ;other
 I IBPROV=9 S IBSTR=$S(IBTYPE="C":$$OPR4(IBFRM),IBTYPE="O":$$OP9(IBFRM),1:"")
 Q:IBPROV=0!(IBSTR="") 1  ;if "" or facility id always return 1
 Q IBSTR[("^"_IBVAL_"^")
 ;
 ;Filter invalid qualifier entries for records SUB1,SUB2,OP6,OP7,OP3
 ; Rebuild the IBXSAVE("PROVINF" or IBXSAVE("PROVINF_FAC" array with
 ;  only ids that have valid qualifiers
 ;IBFRM 0-both, 1=UB,2=1500
 ;IBREC record ID whose ids are being filtered (SUB1,SUB2,etc)
 ;IBFAC - 1 if facility check, 0 if attending/rendering check
 ;IBTYPE - "C"-current insurance, "O"-other insurance
 ;IBXSAVE - the array of provider ids extracted, returned filtered -
 ;   passed by reference
CHCKSUB(IBFRM,IBREC,IBFAC,IBTYPE,IBXSAVE) ;
 N Z,Z0,Z1,Z2,CT,IBSAVE
 S Z="PROVINF"_$P("^_FAC",U,$G(IBFAC)+1)
 I '$G(IBXSAVE(Z,IBXIEN)) D
 . D F^IBCEF("N-ALL "_$S($G(IBFAC):"OUTSIDE FAC PROVIDER INF",1:"CUR/OTH PROVIDER INFO"))
 M IBSAVE(Z,IBXIEN,IBTYPE)=IBXSAVE(Z,IBXIEN,IBTYPE) K IBXSAVE(Z,IBXIEN,IBTYPE)
 S Z0=0 F  S Z0=$O(IBSAVE(Z,IBXIEN,IBTYPE,Z0)) Q:'Z0  S Z1="" F  S Z1=$O(IBSAVE(Z,IBXIEN,IBTYPE,Z0,Z1)) Q:Z1=""  S (Z2,CT)=0 F  S Z2=$O(IBSAVE(Z,IBXIEN,IBTYPE,Z0,Z1,Z2)) Q:'Z2  D
 . N IBVAL
 . S IBVAL=$P(IBSAVE(Z,IBXIEN,IBTYPE,Z0,Z1,Z2),U,3)
 . I IBFRM=0 D  Q
 .. I $S($$CHSUB(1,IBREC,IBVAL):1,1:$$CHSUB(2,IBPROV,IBTYPE,IBVAL)) D
 ... S CT=CT+1,IBXSAVE(Z,IBXIEN,IBTYPE,Z0,Z1,CT)=IBSAVE(Z,IBXIEN,IBTYPE,Z0,Z1,Z2)
 ... I $G(IBXSAVE(Z,IBXIEN,IBTYPE,Z0))="",$G(IBSAVE(Z,IBXIEN,IBTYPE,Z0))'="" S IBXSAVE(Z,IBXIEN,IBTYPE,Z0)=IBSAVE(Z,IBXIEN,IBTYPE,Z0)
 . I $$CHSUB(IBFRM,IBREC,IBVAL) D
 .. S CT=CT+1,IBXSAVE(Z,IBXIEN,IBTYPE,Z0,Z1,CT)=IBSAVE(Z,IBXIEN,IBTYPE,Z0,Z1,Z2)
 .. I $G(IBXSAVE(Z,IBXIEN,IBTYPE,Z0))="",$G(IBSAVE(Z,IBXIEN,IBTYPE,Z0))'="" S IBXSAVE(Z,IBXIEN,IBTYPE,Z0)=IBSAVE(Z,IBXIEN,IBTYPE,Z0)
 Q
 ;
 ; Check if valid qualifier
 ;IBFRM 0-both, 1=UB,2=1500
 ;IBREC record ID whose ids are being filtered (SUB1,SUB2,etc)
 ;IBVAL - value to check
CHSUB(IBFRM,IBREC,IBVAL) ;
 N IBSTR
 I IBREC="SUB1" S IBSTR=$$SUB1(IBFRM)
 I IBREC="SUB2" S IBSTR=$$SUB2(IBFRM)
 I IBREC="OP7" S IBSTR=$$OP7(IBFRM)
 I IBREC="OP3" S IBSTR=$$OP3(IBFRM)
 I IBREC="OP6" S IBSTR=$$OP6(IBFRM)
 Q:$G(IBSTR)="" 1  ;if "" always return 1
 Q IBSTR[("^"_IBVAL_"^")
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OPR2(IBFRM) ;
 Q:IBFRM=1 "^0B^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q:IBFRM=2 "^0B^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP1(IBFRM) ;
 Q:IBFRM=1 "^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^"
 Q:IBFRM=2 "^1B^1C^1D^EI^G2^LU^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OPR3(IBFRM) ;
 Q:IBFRM=1 "^0B^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP2(IBFRM) ;
 Q:IBFRM=1 "^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
SUB1(IBFRM) ;
 Q:IBFRM=1 "^0B^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q:IBFRM=2 "^0B^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^U3^SY^X5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OPR4(IBFRM) ;
 Q:IBFRM=1 "^0B^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP9(IBFRM) ;
 Q:IBFRM=1 "^1A^1B^1C^1D^1G^1H^EI^G2^LU^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
SUB2(IBFRM) ;
 Q:IBFRM=1 "^0B^1A^1B^1C^1G^1H^1J^EI^FH^G2^G5^LU^N5^X5^TJ^B3^BQ^SY^U3^"
 Q:IBFRM=2 "^0B^X4^1A^1B^1C^1G^1H^G2^LU^X5^TJ^B3^BQ^SY^U3^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP3(IBFRM) ;
 Q:IBFRM=1 "^1B^1C^EI^G2^LU^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OPR5(IBFRM) ;
 Q:IBFRM=2 "^0B^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OPR8(IBFRM) ;
 Q:IBFRM=2 "^0B^1B^1C^1D^1G^1H^EI^G2^LU^N5^SY^X5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP4(IBFRM) ;
 Q:IBFRM=2 "^1B^1C^1D^EI^G2^LU^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP8(IBFRM) ;
 Q:IBFRM=2 "^1B^1C^1D^EI^G2^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP6(IBFRM) ;
 Q:IBFRM=2 "^1A^1B^1C^G2^LU^N5^"
 Q ""
 ;
 ;IBFRM 0-both, 1=UB,2=1500
OP7(IBFRM) ;
 Q:IBFRM=2 "^1A^1B^1C^G2^LU^N5^"
 Q ""
 ;
 ;check qualifier for PRV1
 ;IBFRM 0-both, 1=UB,2=1500
 ;IBVAL - value to check
CHCKPRV1(IBFRM,IBVAL) ;
 I IBFRM=0 Q:$$CHPRV1(1,IBVAL) 1  Q $$CHPRV1(2,IBVAL)
 Q $$CHPRV1(IBFRM,IBVAL)
 ;IBFRM 0-both, 1=UB,2=1500
CHPRV1(IBFRM,IBVAL) ;
 N IBSTR S IBSTR=""
 S IBSTR=$$PRV1(IBFRM)
 Q:IBSTR="" 1
 Q IBSTR[("^"_IBVAL_"^")
 ;
PRV1(IBFRM) ;
 Q:IBFRM=1 "^1A^1C^1D^1G^1H^1J^B3^BQ^EI^FH^G2^G5^LU^SY^X5^"
 Q:IBFRM=2 "^1B^1C^1D^1G^1H^1J^B3^BQ^EI^FH^G2^G5^LU^U3^SY^X5^"
 Q ""
 ;
PTSELF ;This tag is for the CI2 segment. If the IBXSAVE("IADR") is empty
 ;check to see if the relationship to pt is 18 (self) if so pull info
 ;from PT1 calls
 ;See if relationship to insured is 18 if not or if "" quit
 N IBZ
 D F^IBCEF("N-ALL INSURED PT RELATION","IBZ",,IBXIEN)
 S IBZ=$G(IBZ(+$$COBN^IBCEF(IBXIEN)))
 S IBZ=$$PRELCNV^IBCNSP1(IBZ,1)
 I IBZ'="18" S IBXDATA="" Q
 N IBZ D F^IBCEF("N-PATIENT STREET ADDRESS 1-3","IBZ",,IBXIEN)
 S IBXDATA="18"
 Q
 ;
NOPUNCT(X,SPACE,EXC) ; Strip punctuation from data in X
 ; SPACE = flag if 1 strip SPACES
 ; EXC = list of punct not to strip
 ;
 N PUNCT,Z
 S PUNCT=".,-+(){}[]\/><:;?|=_*&%$#@!~`^'"""
 I $G(SPACE) S PUNCT=PUNCT_" "
 I $G(EXC)'="" S PUNCT=$TR(PUNCT,EXC)
 N L S L=""
 F  S L=$O(X(L)) Q:L=""  D
 . S X(L)=$TR(X(L),PUNCT)
 I $G(X)'="" D
 . S X=$TR(X,PUNCT)
 Q
 ;
PROVID(IBXIEN) ;This modified version of prov id call is to acquire the SSN
 ;first, if the ssn is not available then we need to get the tax id.
 ;we also need to provide the modifier for which value it is
 Q:+$G(IBXIEN)=0 ""
 S IBXSAVE("ID")=""
 S IBXSAVE=""
 S IBXSAVE=$$PROVSSN^IBCEF7(IBXIEN)
 N I
 F I=1:1:9 D
 . I $P(IBXSAVE,"^",I)]"" S $P(IBXSAVE("ID"),U,I)="34"
 ;If no ibxdata go look in 355.97 for 24 
 N IBRETVAL S IBRETVAL=""
 N IBPTR,IBFT
 F IBFT=1:1:9 D
 . Q:$P(IBXSAVE,U,IBFT)]""
 . S IBPTR=$$PROVPTR^IBCEF7(IBXIEN,IBFT)
 . S $P(IBRETVAL,"^",IBFT)=$$TAX3559(IBPTR)
 . I $P(IBRETVAL,U,IBFT)]"" D
 . . S $P(IBXSAVE,U,IBFT)=$P(IBRETVAL,U,IBFT)
 . . S $P(IBXSAVE("ID"),U,IBFT)="24"
 Q IBXSAVE
 ;
TAX3559(IBPROV) ;
 I $P(IBPROV,";",2)'["IBA(355.9" Q ""
 N IB2,IB3559,IBIDTYP,IBID,IBQFL
 S (IB3559,IBQFL)=0
 S IBID=""
 Q:+$G(IBPROV)=0 ""
 F IB2=1:1 S IB3559=$O(^IBA(355.9,"B",IBPROV,IB3559)) Q:IB3559=""!IBQFL  D
 . S IBIDTYP=+$P($G(^IBA(355.9,IB3559,0)),"^",6) ;provider ID type, ptr to #355.97
 . S IBIDTYP=$P($G(^IBE(355.97,IBIDTYP,0)),"^",3)
 . S:IBIDTYP="EI" IBID=$P($G(^IBA(355.9,IB3559,0)),"^",7),IBQFL=1
 ; if nothing found yet, look in file 355.93 for Facility Default ID
 I IBID="",IBPROV["IBA(355.93" D
 .N IB0,IBFID,IBQ
 .S IB0=$G(^IBA(355.93,+IBPROV,0)) Q:IB0=""!($P(IB0,U,2)'=1)  ; not a facility - bail out
 .S IBFID=$P(IB0,U,9) Q:IBFID=""  ; no default id on file - bail out
 .S IBQ=$P(IB0,U,13) I +IBQ>0,$P($G(^IBE(355.97,IBQ,0)),U,3)=24 S IBID=IBFID
 .Q
 Q $$NOPUNCT^IBCEF(IBID)
 ;
 ;IBFULL-full name
 ;IBEL - Name element : "FAMILY","GIVEN","MIDDLE","SUFFIX"
 ;
SSN200(IBPTR)   ;
 I $P(IBPTR,";",2)'="VA(200," Q ""
 Q $$NOPUNCT^IBCEF($$GET1^DIQ(200,+$P(IBPTR,";")_",",9))
 ;
 ;Input:
 ; IBIEN399 - ien in #399
 ;Output:
 ; returns a string with "^" delimiters that contains SSNs (if any)
 ; in the position that equal to FUNCTION number
 ; i.e. if RENDERING function # is 3 then SSN will be
 ; in $P(return value,"^",3), etc.
 ;
SSN3559(IBPROV) ;
 N IB2,IB3559,IBIDTYP,IBID,IBQFL
 S (IB3559,IBQFL)=0
 S IBID=""
 Q:+$G(IBPROV)=0 ""
 F IB2=1:1 S IB3559=$O(^IBA(355.9,"B",IBPROV,IB3559)) Q:IB3559=""!IBQFL  D
 . S IBIDTYP=+$P($G(^IBA(355.9,IB3559,0)),"^",6)
 . S IBIDTYP=$P($G(^IBE(355.97,IBIDTYP,0)),"^",3)
 . S:IBIDTYP="SY" IBID=$P($G(^IBA(355.9,IB3559,0)),"^",7),IBQFL=1
 Q $$NOPUNCT^IBCEF(IBID)
 ;
 ;IBIDTYP-provider ID type, ptr to #355.97
 ;IBFULL-full name
 ;IBEL - Name element : "FAMILY","GIVEN","MIDDLE","SUFFIX"
 ;
PRV1FMT(P) ;FORMAT CODE FOR PRV1 SEGMENT THAT WON'T FIT ON LINE
 K IBXDATA
 S:'$D(IBXSAVE("BIL-PROV-SEC")) IBXSAVE("BIL-PROV-SEC")=$$PRV1^IBCEF7(IBXIEN)
 S IBXDATA=$P($G(IBXSAVE("BIL-PROV-SEC")),"^",P)
 I $G(IBXDATA)'="" S IBXDATA=$$NOPUNCT^IBCEF(IBXDATA,1)
 Q
 ;

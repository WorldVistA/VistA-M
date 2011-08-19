IBCEF71 ;WOIFO/SS - FORMATTER AND EXTRACTOR SPECIFIC BILL FUNCTIONS ;31-JUL-03
 ;;2.0;INTEGRATED BILLING;**232,155,288,320,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;---------
 ;OTHPAYC - from FORMAT code for OP1,OP2 ...
 ;Input:
 ;IBXIEN - ien #399
 ;IBSAVE - "in" array (i.e. IBXSAVE)
 ;IBDATA - "out" array (i.e. IBXDATA)
 ;IBFUNC - FUNCTION from #399 (1-refering,2-operating,etc)
 ;IBVAL - output value
 ;Output:
 ; IBDATA with formatted output
OTHPAYC(IBXIEN,IBSAVE,IBDATA,IBFUNC,IBVAL) ;
 N IB1,IB2,IBINS,IBFL
 S IBFL=$S(IBFUNC=3!(IBFUNC=4):1,1:0)
 F IB1=1,2 D
 . Q:'$$ISINSUR($G(IBSAVE("PROVINF",IBXIEN,"O",IB1)),IBXIEN)  ;don't create anything if no such insurance
 . I IBFL S IBFUNC=$S($O(IBSAVE("PROVINF",IBXIEN,"O",IB1,3,0)):3,1:4)
 . S:$O(IBSAVE("PROVINF",IBXIEN,"O",IB1,IBFUNC,0)) IBDATA(IB1)=IBVAL
 Q
 ;----
 ;OTHPAYV - called from FORMAT code for OP1,OP2 ...
 ;Input:
 ;IBXIEN - ien #399
 ;IBSAVE - "in" array (i.e. IBXSAVE)
 ;IBDATA - "out" array (i.e. IBXDATA)
 ;IBFUNC - FUNCTION from #399 (1-refering, 2-operating, etc)
 ;IBSEQN - seq # of ID/QUAL
 ;IBFLDTYP
 ; "I" - ID  "Q" - ID QUAL
 ;Output:
 ; IBDATA with formatted output
OTHPAYV(IBXIEN,IBSAVE,IBDATA,IBFUNC,IBFLDTYP,IBSEQN) ;
 N IB1,IB2,IBPIECE,IBINS,IBFL
 S IBFL=$S(IBFUNC=3!(IBFUNC=4):1,1:0)
 S IBPIECE=$S(IBFLDTYP="I":4,IBFLDTYP="Q":3,1:3)
 F IB1=1,2 D
 . Q:'$$ISINSUR($G(IBSAVE("PROVINF",IBXIEN,"O",IB1)),IBXIEN)  ;don't create anything if there is no such insurance
 . I IBFL S IBFUNC=$S($O(IBSAVE("PROVINF",IBXIEN,"O",IB1,3,0)):3,1:4),IBFL=0
 . S IBDATA(IB1)=$P($G(IBSAVE("PROVINF",IBXIEN,"O",IB1,IBFUNC,IBSEQN)),"^",IBPIECE)
 Q
 ;
 ;chk for ins
 ;Input:
 ; IBINS = "P","S","T"
 ; IBXIEN - ien file #399
 ;Output:
 ; returns 1-exists , 0-doesn't
ISINSUR(IBINS,IBXIEN) ;
 N IBINSNOD
 S IBINSNOD=$S(IBINS="P":"I1",IBINS="S":"I2",IBINS="T":"I3",1:"")
 I IBINSNOD="" Q 0
 Q $D(^DGCR(399,IBXIEN,IBINSNOD))
 ;
 ;---PRACT----
 ;Get list of all 355.9 or 355.93 records for prov
 ;Input: 
 ;IB399INS - ins co for bill to match PRACTIONER from 355.9
 ;IB399FRM - form type (0=unknwn/both,1=UB,2=1500) to 
 ;   match PRACTIONER from 355.9
 ;IB399CAR - BILL CARE (0=unknwn or both inp/outp,1=inpatient,
 ;   2=outpatient/3=Rx) to match PROV from 355.9
 ;    OR   - DIVISION PTR to file 40.8 for entries in file 355.92
 ;IBPROV - VARIABLE PTR VA prov
 ;IBARR - array by reference for result
 ;IBPROVTP- function (2-operating, 3-RENDERING,etc 0-facility)
 ;IBINSTP - "C" -current ins , "O"-other
 ;IBFILE - 355.92 for facility ids or 355.9 (default) for provider ids
 ;IBINS - 1 if to include ids for the ins co for all provs
 ;Ouput:
 ;IBARR - array by ref for result
 ; prov var ptr^ins ptr^X12 id cd^ID^form typ^care typ or division ptr^st ptr^id rec ptr^id type ptr
PRACT(IB399INS,IB399FRM,IB399CAR,IBPROV,IBARR,IBPROVTP,IBINSTP,IBFILE,IBINS) ;
 N IB1,IB2,IBDAT,IBF,IBFX,IB3559,IBINSCO,IBFRMTYP,IBIDTYP,IBID,IBIDT,IBDIV,IBQ,IBS1,IBS2,IBARRX,Z,Z1,Z2,IBCARE
 I $G(IBFILE)="" S IBFILE=355.9
 S IBINS=$G(IBINS)
 S (IBARR,IB3559,IB1)=0
 F IBF="",1 Q:IBF=1&$S(IBFILE'=355.9:1,1:'IBINS)  S IBFX=IBFILE_IBF F IB2=1:1 S IB3559=$O(^IBA(IBFX,"B",$S(IBFILE=355.9&(IBF=""):IBPROV,1:IB399INS),IB3559)) Q:IB3559=""  D
 . S IBINSCO=$P($G(^IBA(IBFX,IB3559,0)),"^",$S(IBFILE=355.9&(IBF=""):2,1:1)) ;ins co. ptr
 . I IBINSCO'="" I IBINSCO'=IB399INS Q  ;exclude if different ins
 . S:IBINSCO="" IBINSCO="NONE" ;NONE will be included in the array
 . S IBFRMTYP=+$P($G(^IBA(IBFX,IB3559,0)),"^",4) ;form type (0=both,1=UB,2=1500)
 . I '(IBFRMTYP=0!(IB399FRM=0)) Q:IBFRMTYP'=IB399FRM  ;exclude if not "both" and different
 . S IBCARE=+$P($G(^IBA(IBFX,IB3559,0)),"^",5) ;0=both(inp and outp),1=inp,2=outp,3=prescr  -- OR -- division ptr
 . I $S(IBFILE=355.92:0,1:IBCARE=3) I IB399CAR'=3 Q  ; Id is only for Rx
 . I $S(IBFILE=355.92:0,1:IBCARE=1!(IBCARE=2)) I IB399CAR=1!(IB399CAR=2) Q:IBCARE'=IB399CAR  ;both is OK
 . I IBFILE=355.92,IBCARE Q:IB399CAR'=IBCARE  ; Division doesn't match
 . S IBIDTYP=+$P($G(^IBA(IBFX,IB3559,0)),"^",6) ;prov ID type
 . I IBFILE=355.9,IBIDTYP=$$TAXID^IBCEP8(),$S(IBPROV["VA(200":1,1:$P($G(^IBA(355.93,+IBPROV,0)),U,2)=2) Q  ; Don't extract tax id # id for indiv prov
 . S IBIDT=IBIDTYP
 . S IBIDTYP=$P($G(^IBE(355.97,IBIDTYP,0)),"^",3)
 . Q:$P($G(^IBE(355.97,+IBIDT,1)),U,9)
 . Q:IBFILE=355.9&(IBIDTYP="X4")  ;exclude CLIA #
 . S IBID=$P($G(^IBA(IBFX,IB3559,0)),"^",7) ;prov ID value
 . I $G(IBPROVTP)'="",$G(IBINSTP)'="",IBPROVTP'=0 I '$$CHCKSEC^IBCEF73(IB399FRM,IBPROVTP,IBINSTP,IBIDTYP) Q  ; No qualifier chk for fac
 . I IBID'="" S IBDAT=IBPROV_"^"_IBINSCO_"^"_IBIDTYP_"^"_IBID_"^"_IBFRMTYP_"^"_IBCARE_"^"_"^"_IB3559_U_IBIDT,IBS2=$S(IBFX'=355.91:"",1:"INS DEF^")_IB3559
 . I IBFILE'=355.92,IBID'="",IB399CAR=3 S IBQ=0 D  Q:IBQ
 .. I $G(IBARRX(IBIDT))!(IBCARE=1) S IBQ=1 Q
 .. I IBCARE=3&(IB399CAR=3) S IBARRX(IBIDT)=1 Q  ; Rx match
 .. I IBCARE=0!(IBCARE=2) S IBARRX(IBIDT,IBINSCO,IBS2)=IBDAT,IBQ=1 Q
 . I IBID'="" S IBARR(IBINSCO,IBS2)=IBDAT
 ;
 I IB399CAR=3 S Z=0 F  S Z=$O(IBARRX(Z)) Q:'Z  I '$G(IBARRX(Z)) D
 . S Z1="" F  S Z1=$O(IBARRX(Z,Z1)) Q:Z1=""  S Z2="" F  S Z2=$O(IBARRX(Z,Z1,Z2)) Q:Z2=""  S IBARR(Z1,Z2)=IBARRX(Z,Z1,Z2)
 ;
 I IBPROV["VA(200," D  ; Get lic #s from file 2 for VA providers
 . N Z,IBLIC
 . S IBLIC=+IBPROV,IBLIC=$$GETLIC^IBCEP5D(.IBLIC)
 . S IBIDTYP=$P($G(^IBE(355.97,+$$STLIC^IBCEP8(),0)),U,3)
 . S Z=0 F  S Z=$O(IBLIC(Z)) Q:'Z  S:$$CHCKSEC^IBCEF73(IB399FRM,IBPROVTP,IBINSTP,IBIDTYP) IBARR("NONE","LIC"_Z_"^"_IBPROV)=IBPROV_U_"NONE"_U_IBIDTYP_U_IBLIC(Z)_U_"0"_U_"0"_U_Z_U_U_+$$STLIC^IBCEP8()
 I IBPROV["IBA(355.93" D
 . Q:$P($G(^IBA(355.93,+IBPROV,0)),U,12)=""
 . S IBIDTYP=$P($G(^IBE(355.97,+$$STLIC^IBCEP8(),0)),U,3)
 . I $$CHCKSEC^IBCEF73(IB399FRM,IBPROVTP,IBINSTP,IBIDTYP) D
 . . S IBARR("NONE","LIC"_$P($G(^DIC(5,+$P(^IBA(355.93,+IBPROV,0),U,7),0)),U,2)_"^"_IBPROV)=IBPROV_U_"NONE"_U_IBIDTYP_U_$P(^IBA(355.93,+IBPROV,0),U,12)_U_"0"_U_"0"_U_$P(^IBA(355.93,+IBPROV,0),U,7)_U_U_+IBPROV
 Q
 ;
ALLPRFAC(IBXIEN,IBXSAVE) ; Return all non-VA/outside facility prov ids
 ; and all VA alternate prov ids
 ; IBXIEN = ien file 399
 ; IBXSAVE = subscripted array returned
 N IBPROV,IBFRMTYP,IBCARE,IBRETARR,IBRET1,IBCOBN,Z,Z0,Z1,ZZ
 K IBXSAVE("PROVINF_FAC",IBXIEN) ; Always rebuild this
 S IBCOBN=+$$COBN^IBCEF(IBXIEN)
 S IBFRMTYP=$$FT^IBCEF(IBXIEN),IBFRMTYP=$S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0)
 S IBPROV=$P($G(^DGCR(399,IBXIEN,"U2")),U,10)
 ; IB patch 320 - Build IBPROV variable better when a non-VA facility exists
 I IBPROV S IBPROV=IBPROV_";IBA(355.93,"
 I 'IBPROV S IBCARE=$P($G(^DGCR(399,IBXIEN,0)),U,22)
 I IBPROV D
 . S IBCARE=$S($$ISRX^IBCEF1(IBXIEN):3,1:0) ;if Rx refill bill
 . S:IBCARE=0 IBCARE=$$INPAT^IBCEF(IBXIEN,1) S:'IBCARE IBCARE=2 ;1-inp, 2-out
 F Z=1:1:3 K IBRETARR I $G(^DGCR(399,IBXIEN,"I"_Z)) D
 . D PRACT(+^DGCR(399,IBXIEN,"I"_Z),IBFRMTYP,IBCARE,IBPROV,.IBRETARR,0,$S(Z=IBCOBN:"C",1:"O"),$S('IBPROV:355.92,1:355.9))
 . K IBRET1
 . S Z0="" F  S Z0=$O(IBRETARR(Z0)) Q:Z0=""  S Z1="" F  S Z1=$O(IBRETARR(Z0,Z1)) Q:Z1=""  D
 .. ; Sort by div/id type
 .. S IBRET1($S(IBPROV:0,1:+$P(IBRETARR(Z0,Z1),U,6)),+$P(IBRETARR(Z0,Z1),U,9))=IBRETARR(Z0,Z1)
 .. Q
 . ;
 . S Z0=$O(IBRET1(""),-1) Q:Z0=""  D
 .. ; IB patch 320 - loop thru all ID's
 .. S Z1="" F  S Z1=$O(IBRET1(Z0,Z1)) Q:Z1=""  D
 ... I Z=IBCOBN S IBXSAVE("PROVINF_FAC",IBXIEN,"C",1,0,$O(IBXSAVE("PROVINF_FAC",IBXIEN,"C",1,0," "),-1)+1)=IBRET1(Z0,Z1) Q
 ... S ZZ=$S(Z=1:1,Z=2:(IBCOBN=3)+1,1:2)
 ... S IBXSAVE("PROVINF_FAC",IBXIEN,"O",ZZ,0,$O(IBXSAVE("PROVINF_FAC",IBXIEN,"O",ZZ,0," "),-1)+1)=IBRET1(Z0,Z1),IBXSAVE("PROVINF_FAC",IBXIEN,"O",ZZ)=$E("PST",Z)
 ... Q
 .. Q
 . Q
 ;
 S IBXSAVE("PROVINF_FAC",IBXIEN)=IBXIEN,IBXSAVE("PROVINF_FAC",IBXIEN,"C",1)=$E("PST",IBCOBN)
 Q
 ;
OTHID(IBXSAVE,IBXDATA,IBXIEN,PRIDSEQ,PRTYP,IBQ,IBFAC) ; From data in IBXSAVE,
 ;  determine id or qualifier to output in the 837 records OP*
 ; Returns IBXDATA array IBXDATA(n)=data
 ; IBXIEN = ien of the bill-file 399
 ; PRIDSEQ = sequence of the payer id needed
 ; PRTYP = provider type to check for data
 ; IBQ = 1 if qualifier needed, 0/null if id needed
 ; IBFAC = 1 if facility id, 0 for individual provider id
 ; 
 N Z,Z0,Z1
 S Z0="PROVINF"_$S('$G(IBFAC):"",1:"_FAC"),Z1=$S($G(IBQ):3,1:4)
 S Z=0 F  S Z=$O(IBXSAVE("OSQ",Z)) Q:'Z  D
 . I $P($G(IBXSAVE(Z0,IBXIEN,"O",Z,+$G(PRTYP),+$G(PRIDSEQ))),U,4)'="" S IBXDATA(IBXSAVE("OSQ",Z))=$P(IBXSAVE(Z0,IBXIEN,"O",Z,+$G(PRTYP),+$G(PRIDSEQ)),U,Z1)
 Q
 ;
SETSEQ(IBXIEN,IBXSAVE,IBXDATA,PRTYP,IBFAC,IBOP) ; Sets up IBXSAVE("OSQ")
 ;  array for other id seq in 837 records OP*
 ; Returns IBXDATA(n)=cob seq indicator for ids
 ; IBXIEN = ien of bill-399
 ; PRTYP = the provider type to check for data for indiv provider
 ; IBFAC = 1 if facility id, 0 for individual provider id
 ; IBOP = segement # in OP being output
 N C,Z,Z0,Z1,OK
 S C=0,Z0="PROVINF"_$S('$G(IBFAC):"",1:"_FAC")
 S:$G(IBFAC) PRTYP=0
 S Z=0 F  S Z=$O(IBXSAVE(Z0,IBXIEN,"O",Z)) Q:'Z  S OK=0 D
 . N Z1 F Z1=1:1 Q:'$D(IBXSAVE(Z0,IBXIEN,"O",Z,+$G(PRTYP),Z1))  I $P(IBXSAVE(Z0,IBXIEN,"O",Z,+$G(PRTYP),Z1),U,4)'="""" S OK=1 Q
 . I OK S C=C+1,IBXSAVE("OSQ",Z)=C
 S Z=0 F  S Z=$O(IBXSAVE("OSQ",Z)) Q:'Z  S IBXDATA(IBXSAVE("OSQ",Z))=$G(IBXSAVE(Z0,IBXIEN,"O",Z)) D:IBXSAVE("OSQ",Z)>1 ID^IBCEF2(IBXSAVE("OSQ",Z),"OP"_$G(IBOP)_" ")
 Q
 ;
PSPRV(IBIFN) ;
 Q $$PSPRV^IBCEF7(IBIFN) ; Moved
 ;

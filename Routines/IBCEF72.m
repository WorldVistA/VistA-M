IBCEF72 ;WOIFO/SS - FORMATTER AND EXTRACTOR SPECIFIC BILL FUNCTIONS ;8/6/03 10:56am
 ;;2.0;INTEGRATED BILLING;**232,320,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;Input:
 ;IBINSCO - ptr to #36
 ;IBFRMTYP 0=unknwn/both,1=UB,2=1500
 ;IBCARE - 0=unknwn or both inp/outp,1=inpatient, 2=outpatient, 3 -RX
 ;Output: X12 IDtype^ID^ID TYPE ptr to file 355.97
CH35591(IBINSCO,IBFRMTYP,IBCARE) ;
 N IB35591,IBRET,IB1
 S IB35591=0,IBRET=""
 F  S IB35591=$O(^IBA(355.91,"B",IBINSCO,IB35591)) Q:+IB35591=0  Q:IBRET'=""  D
 . S IB1=$G(^IBA(355.91,IB35591,0))
 . I '($P(IB1,"^",4)=0!(IBFRMTYP=0)) Q:$P(IB1,"^",4)'=IBFRMTYP  ;if wrong form type
 . I ($P(IB1,"^",5)=3)!(IBCARE=3) Q:IBCARE'=$P(IB1,"^",5)  ;if not RX
 . I ($P(IB1,"^",5)=1)!($P(IB1,"^",5)=2) I (IBCARE=1)!(IBCARE=2) Q:$P(IB1,"^",5)'=IBCARE  ;if wrong care type
 . S IBRET=$P($G(^IBE(355.97,+$P(IB1,"^",6),0)),"^",3)_"^"_$P(IB1,"^",7)_U_+$P(IB1,U,6)
 Q IBRET
 ;
FINDEIN(IBXIEN,IBPROV,IBFAC,IBS) ; find EIN for facility/ SSN for person
 ; IBXIEN = ien of bill entry file 399
 ; IBFAC = 1 if facility, 0 if individual provider
 ; IBPROV = ien of provider (vp format)
 ; IBS = 1 if person's EIN should be returned if there, otherwise SSN
 ; FUNCTION RETURNS 
 ;    EIN or SSN ^ 24 for EIN, 34 for SSN or null if none found
 N Z,Z0,IBARR,IBEIN,IBSSN
 S (IBEIN,IBSSN)=""
 D ALLID^IBCEP8(IBPROV,"",.IBARR)
 S Z=0 F  S Z=$O(IBARR(Z)) Q:'Z  D  Q:IBEIN'=""
 . I $G(IBFAC) Q:$P(IBARR(Z),U,7)'="EI"  S IBEIN=$P(IBARR(Z),U,2)_U_24 Q
 . I $P(IBARR(Z),U,7)="SY" D  Q
 .. I $G(IBS) S IBSSN=$P(IBARR(Z),U,2)_U_34 Q
 . S IBEIN=$P(IBARR(Z),U,2)_U_24
 . I $G(IBS),$P(IBARR(Z),U,7)="EI" S IBEIN=$P(IBARR(Z),U,2)_U_24
 I $G(IBS),IBEIN="" S IBEIN=IBSSN
 Q IBEIN
 ;
 ;
NONVAID(IBXIEN,IBX,IBFAC,IBS) ; Find the non-VA provider default id
 ; IBXIEN = the ien of the bill (file 399)
 ; IBX = id data returned if passed by reference
 ; IBFAC = 1 if getting the id for the facility or 0 for rendering prov
 ; IBS = 1 if getting id for person, but need the EIN if there
 ; Function returns the id^type of id^person/facility flag:
 ;   Type of id: 1 = SSN    2 = EIN   0 = not found
 ;   person/facility: 1 = person   2 = facility
 N Z,IBXSAVE,IBU2,IBTYPE,IBZ,IBF,IBPROV,Q,Q0
 S IBTYPE=2,IBU2=$G(^DGCR(399,IBXIEN,"U2")),IBF=2,IBPROV=""
 ;
 S Z=$P(IBU2,U,10)
 I 'Z S IBX="",IBTYPE=0 G NONVAQ ; Not a non-VA facility
 S IBPROV=Z_";IBA(355.93,"
 ;
 ; Get EIN
 I $G(IBFAC) D  G NONVAQ
 . S IBX=$P($$FINDEIN(IBXIEN,IBPROV,IBFAC),U),IBTYPE=2
 ;
 ; Get EIN/SSN
 I '$G(IBFAC) D  G NONVAQ
 . S IBX="",IBF=1
 . S Q0=($$FT^IBCEF(IBXIEN)=3)+3 ; 3 for rendering/4 for attending
 . S Q=+$O(^DGCR(399,IBXIEN,"PRV","B",Q0,0))
 . S IBPROV=$P($G(^DGCR(399,IBXIEN,"PRV",Q,0)),U,2)
 . I IBPROV S IBX=$$FINDEIN(IBXIEN,IBPROV,IBFAC,$G(IBS)),IBTYPE=$S($P(IBX,U,2)=24:2,$P(IBX,U,2)=34:1,1:0),IBX=$P(IBX,U)
 ;
NONVAQ I IBTYPE,IBX="",$P(IBU2,U,12)'="" S IBX=$P(IBU2,U,12) ; pull from 399
 S IBX=$G(IBX)
 Q IBX_U_IBTYPE_U_IBF
 ;----
 ;checks if there is data for OP* segments and 
 ;then populates PROV COB SEQ
 ;Input:
 ;IBXIEN - ien in #399
 ;IBSAVE - "in" array (i.e. IBXSAVE)
 ;IBDATA - "out" array (i.e. IBXDATA)
 ;IBFUNC - FUNCTION from #399 (1-refering, 2 -operating, etc)
 ;IBSEGM - segment record ID, optional
 ;Output:
 ; IBDATA with formatted output
PROVSEQ(IBXIEN,IBSAVE,IBDATA,IBFUNC,IBSEGM) ;
 N IB1,IB2,IBINS,IBFL
 S IBFL=$S(IBFUNC=3!(IBFUNC=4):1,1:0)
 F IB1=1,2 D
 . Q:'$$ISINSUR^IBCEF71($G(IBSAVE("PROVINF",IBXIEN,"O",IB1)),IBXIEN)  ;don't create anything if there is no such insurance
 . I IBFL S IBFUNC=$S($O(IBSAVE("PROVINF",IBXIEN,"O",IB1,3,0)):3,1:4)
 . S:$O(IBSAVE("PROVINF",IBXIEN,"O",IB1,IBFUNC,0)) IBDATA(IB1)=$G(IBSAVE("PROVINF",IBXIEN,"O",IB1))
 . I $G(IBSEGM)'="" D:$O(IBSAVE("PROVINF",IBXIEN,"O",IB1,IBFUNC,0)) ID^IBCEF2(IB1,IBSEGM)
 Q
 ;
OUTPRVID(IBXIEN,IBXSAVE) ; Extract the outside provider or facility ids
 ; into IBXSAVE array
 ; Function returns 1 if person or 2 if facility ids or "" if neither
 N Z,IBXDATA,IBPERSON,TAG
 ;WCJ;11/1/2005 Extract the first 3 chars of Z instead.
 S Z=$E($$PSPRV^IBCEF7(IBXIEN),1,3),IBPERSON=""
 ;EJK 8/23/05 IB*320 - CHANGED Z=101 TO Z=1010. Z WILL ALWAYS BE A 4 DIGIT #. 
 ; WCJ 11/1/2005 ; Removed EJK's change and added above change
 I Z=111!(Z=101) S TAG=$S(Z=101:"OUTSIDE FAC PROVIDER INF",1:"CUR/OTH PROVIDER INFO") D F^IBCEF("N-ALL "_TAG) S IBPERSON=$S('$E(Z,2):2,1:1)
 Q IBPERSON
 ;
OUTPRV(IBREC,IBXIEN,IBXSAVE) ; Extract the outside provider or facility ids
 ; into IBXSAVE array
 ; Function returns 1 if person or 2 if facility ids or "" if neither
 ; IBREC = the record whose ids should be returned
 N IBPERSON,IBFRM,IBTYPE,IBFAC
 I IBREC="SUB1"!(IBREC="OP6") D
 . K IBXSAVE("PROVINF",IBXIEN),IBXSAVE("PROVINF_FAC",IBXIEN)
 . S IBPERSON=$$OUTPRVID(IBXIEN,.IBXSAVE),IBFAC=$S(IBPERSON=1:0,1:1)
 E  D
 . K IBXSAVE("PROVINF_FAC",IBXIEN)
 . D F^IBCEF("N-ALL OUTSIDE FAC PROVIDER INF")
 . S IBPERSON=2,IBFAC=1
 S IBFRM=$$FT^IBCEF(IBXIEN),IBFRM=$S(IBFRM=2:2,1:1)
 S IBTYPE=$S(IBREC["SUB":"C",1:"O")
 D CHCKSUB^IBCEF73(IBFRM,IBREC,IBFAC,IBTYPE,.IBXSAVE)
 Q IBPERSON
 ;
 ;get IENs in file #36 for other insurances
OTHINS(IB399,IBRES) ;
 N IBFRMTYP,Z,Z1,Z2,Z4
 S Z=$$COBN^IBCEF(IB399),Z0=0
 F Z1=1:1:3 I Z1'=Z,$D(^DGCR(399,IB399,"I"_Z1)) S Z0=Z0+1,IBRES(Z0)=+$G(^DGCR(399,IB399,"I"_Z1))
 Q
 ;get other insurance EDI ID NUMBERs
OTHINSID(IB399,IBRES) ;insurance EDI 
 N IBFRMTYP,IBZ,Z0,Z1,Z4
 S IBFRMTYP=$$FT^IBCEF(IB399),IBFRMTYP=$S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0)
 S Z4=$S(IBFRMTYP=1:4,1:2) ;UB - piece4,1500 or BOTH -piece 2
 D OTHINS(IB399,.IBZ)
 S Z1=0
 F Z0=1:1:2 I $G(IBZ(Z0)) S IBRES(Z0)=$S($$MCRWNR^IBEFUNC(+IBZ(Z0)):$S(IBFRMTYP=1:"12M61",1:"SMTX1"),1:$P($G(^DIC(36,+IBZ(Z0),3)),U,Z4))
 Q
 ;
 ;get other insurance addresses
OTHINADR(IB399,IBRES,IBADDFLD) ;insurance EDI
 N IBZ,Z0,Z1,Z4
 D OTHINS(IB399,.IBZ)
 S Z1=0
 I IBADDFLD=18 D  Q
 . F Z0=1:1:2 I $G(IBZ(Z0)) D
 . . S IBRES(Z0)=$P($G(^DIC(36,+IBZ(Z0),.11)),U,1)
 . . S IBRES(Z0)=$E(IBRES(Z0),1,55)
 I IBADDFLD=18.9 D  Q
 . F Z0=1:1:2 I $G(IBZ(Z0)) D
 . . S IBRES(Z0)=$P($G(^DIC(36,+IBZ(Z0),.11)),U,1)
 . . S Z4=$P($G(^DIC(36,+IBZ(Z0),.11)),U,2) S:Z4'="" IBRES(Z0)=IBRES(Z0)_", "_Z4
 . . S Z4=$P($G(^DIC(36,+IBZ(Z0),.11)),U,3) S:Z4'="" IBRES(Z0)=IBRES(Z0)_", "_Z4
 . . S Z4=$P($G(^DIC(36,+IBZ(Z0),.11)),U,4) S:Z4'="" IBRES(Z0)=IBRES(Z0)_", "_Z4
 . . S Z4=$P($G(^DIC(5,+$P($G(^DIC(36,+IBZ(Z0),.11)),U,5),0)),U,2) S:Z4'="" IBRES(Z0)=IBRES(Z0)_", "_Z4
 . . S Z4=$P($G(^DIC(36,+IBZ(Z0),.11)),U,6) S:Z4'="" IBRES(Z0)=IBRES(Z0)_", "_Z4
 . . S IBRES(Z0)=$E(IBRES(Z0),1,157)
 I IBADDFLD=19 D  Q
 . F Z0=1:1:2 I $G(IBZ(Z0)) D
 . . S IBRES(Z0)=$P($G(^DIC(36,+IBZ(Z0),.11)),U,2)
 . . S IBRES(Z0)=IBRES(Z0)_" "_$P($G(^DIC(36,+IBZ(Z0),.11)),U,3)
 . . S IBRES(Z0)=$E(IBRES(Z0),1,55)
 I IBADDFLD=20 D  Q
 . F Z0=1:1:2 I $G(IBZ(Z0)) D
 . . S IBRES(Z0)=$P($G(^DIC(36,+IBZ(Z0),.11)),U,4)
 . . S IBRES(Z0)=$E(IBRES(Z0),1,30)
 I IBADDFLD=21 D  Q
 . F Z0=1:1:2 I $G(IBZ(Z0)) D
 . . S IBRES(Z0)=$P($G(^DIC(5,+$P($G(^DIC(36,+IBZ(Z0),.11)),U,5),0)),U,2)
 . . S IBRES(Z0)=$E(IBRES(Z0),1,2)
 I IBADDFLD=22 D  Q
 . F Z0=1:1:2 I $G(IBZ(Z0)) D
 . . S IBRES(Z0)=$P($G(^DIC(36,+IBZ(Z0),.11)),U,6)
 . . S IBRES(Z0)=$E(IBRES(Z0),1,15)
 Q
 ;
SFIDQ(IBXIEN,IBXSAVE,IBXDATA) ; Find the service facility id qualifier for
 ; 837 record SUB2-5
 ;IBXIEN = ien of 399
 ;Pass by reference: IBXSAVE (input/output)  IBXDATA (output)
 N B,Z
 K IBXSAVE("NVID")
 D  ; protect IBXDATA
 . N IBXDATA
 . D F^IBCEF("N-RENDERING INSTITUTION")
 . S:IBXDATA'="" IBXSAVE("IBFAC")=IBXDATA
 I $P($G(IBXSAVE("IBFAC")),U,2)'=1 K IBXDATA Q
 S Z=$$PSPRV^IBCEF7(IBXIEN)
 ;WCJ 11/04/2005 If a Non-VA facility 
 I $E(Z) D
 . S IBXSAVE("NVID")=$$NONVAID^IBCEF72(IBXIEN,.B,$E(Z),1)
 .; S IBXSAVE("NVID")=$$NONVAID^IBCEF72(IBXIEN,.B,'$E(Z,2),1)
 . S IBXDATA=$P("^34^24",U,$P(IBXSAVE("NVID"),U,2)+1)
 ;S Z=$$PSPRV^IBCEF7(IBXIEN),IBXSAVE("NVID")=$$NONVAID^IBCEF72(IBXIEN,.B,'$E(Z,2),1),IBXDATA=24
 Q
 ;
OTHP36(IBXIEN,IBZOUT)   ;
 N Z,Z0,Z1,IBZ
 D F^IBCEF("N-ALL INSURANCE CO 837 ID","IBZ")
 F Z=1,2,3 S IBZOUT(Z)=+$$POLICY^IBCEF(IBXIEN,1,$E("PST",Z))
 Q
 ;
 ;---------SORT-----------
 ;IBPRNUM - seq #
 ;IBPRTYP - type of provider (use FUNCTION value from file 399, fld 222)
 ;IB399 = ien file 399
 ;IBSRC,IBDST - source,destination arrays
 ;IBN - starting #
 ;Output:
 ; IBDST(1-primary/2-secondary provider,Provider type(FUNCTION),N)=
 ; =provider/VARIABLEPTR^Insurance PTR #36 or NONE^ID type^ID^Form type^Care type^state ptr #5 for state license #
 ; where N is numeration (1 for ID1, 2 for ID2, etc)
GETSSN(IBPTR)   ;look for SSN in #200 first and if not found then look at #355.9
 ;if in file #200
 I $P(IBPTR,";",2)="VA(200," Q $$SSN200^IBCEF73(IBPTR)
 ;if in 355.93 then use 355.9
 Q $$SSN3559^IBCEF73(IBPTR)
 ;--
 ;SSN3559
 ;Find SSN from 355.9
 ;Input:
 ; Variable pointer to ^VA(200 or ^IBA(355.93
 ;Output:
 ; SSN or null
 ;
PADNDC(Z) ;PAD LEADING ZERO'S INTO A NON 5-4-2 FORMAT NDC NUMBER
 ;Z IS ITERATION, ONLY PAD CURRENT NDC NUMBER
 N NDC
 S NDC=$P(IBXSAVE("OUTPT",Z,"RX"),"^",3)
 Q:$L(NDC)=13
 I $L(NDC)=14 D  Q
 . S $P(NDC,"-",1)=$E($P(NDC,"-",1),2,$L($P(NDC,"-",1)))
 . S $P(IBXSAVE("OUTPT",Z,"RX"),"^",3)=NDC
 I $L($P(NDC,"-",1))'=5 S $P(NDC,"-",1)="0"_$P(NDC,"-",1)
 I $L($P(NDC,"-",2))'=4 S $P(NDC,"-",2)="0"_$P(NDC,"-",2)
 I $L($P(NDC,"-",3))'=2 S $P(NDC,"-",3)="0"_$P(NDC,"-",3)
 S $P(IBXSAVE("OUTPT",Z,"RX"),"^",3)=NDC
 Q
 ;

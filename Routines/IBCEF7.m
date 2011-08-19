IBCEF7 ;WOIFO/SS - FORMATTER AND EXTRACTOR SPECIFIC BILL FUNCTIONS ;8/6/03 10:56am
 ;;2.0;INTEGRATED BILLING;**232,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ALLPROV ;called from #364.5 entry "N-ALL CUR/OTH PROVIDER INFO"
 I +$G(IBXSAVE("PROVINF",IBXIEN))=0 N IBZ D PROVIDER(IBXIEN,"C",.IBZ),PROVIDER(IBXIEN,"O",.IBZ) S IBXSAVE("PROVINF",IBXIEN)=IBXIEN M IBXSAVE("PROVINF",IBXIEN)=IBZ
 Q
 ;for PRV1
 ;Input:
 ; IB399 ien of #399
PRV1(IB399) ;
 N IBN,IBZ,IBZ1,IBZN,IBZD,IBRES,IBIND,IBDEF,IBDEFTYP,IBQ,IBFRMTYP,IBZNAME
 S IBFRMTYP=+$$FT^IBCEF(IB399)
 S IBN=0,IBIND=0,IBRES="",IBQ=0
 S IBDEF=$P($G(^DGCR(399,IB399,"M1")),U,$$COBN^IBCEF(IB399)+1),IBDEFTYP=""
 I IBDEF'="" S IBDEFTYP=$$SOP^IBCEP2B(IB399,"")
 I IBDEFTYP'="",$$CHCKPRV1^IBCEF73($S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0),IBDEFTYP)=0 S (IBDEF,IBDEFTYP)=""
 I IBDEF'="",IBDEFTYP'="" S IBIND=IBIND+2,$P(IBRES,U,IBIND)=(IBDEFTYP_U_IBDEF)
 F  S IBN=$O(^IBE(355.97,IBN)) Q:+IBN=0!(IBQ=1)  D
 . S IBZ=$G(^IBE(355.97,IBN,0)),IBZ1=$G(^(1))
 . Q:$P(IBZ,"^",4)=""!$P(IBZ1,U,9)  ;if no FACILITY'S DEFAULT ID #
 . Q:$P(IBZ1,"^",4)!(IBDEFTYP=$P(IBZ,U,3))
 . S IBZN=$P(IBZ,"^",3),IBZNAME=$P(IBZ,"^",1)
 . I IBFRMTYP=2 Q:IBZN="1A"!(IBZNAME="MEDICARE PART A")  ;1500
 . I IBFRMTYP=3 Q:IBZN="1B"!(IBZNAME="MEDICARE PART B")  ;UB
 . Q:$$CHCKPRV1^IBCEF73($S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0),IBZN)=0
 . I $P(IBZ,"^",2)=0!($P(IBZ,"^",2)=2) D
 . . S IBIND=IBIND+2
 . . I IBIND>14 S IBQ=1 Q
 . . S $P(IBRES,"^",IBIND)=IBZN_"^"_$P(IBZ,"^",4)
 ;Remove any duplicate entries
 N I,Q,QUAL,QUALC,IBRESTMP,SEQ
 F I=2:2:($L(IBRES,"^")-1) D
 . S QUAL=$P(IBRES,"^",I)
 . I $G(IBRESTMP(QUAL))="" S IBRESTMP(QUAL)=$P(IBRES,"^",(I+1))
 S Q=2
 S I="",QUAL=""
 K IBRES
 S IBRES=""
 S SEQ=0
 F  S QUAL=$O(IBRESTMP(QUAL)) Q:QUAL=""  D
 . S SEQ=SEQ+2
 . S $P(IBRES,"^",SEQ)=QUAL,$P(IBRES,"^",(SEQ+1))=IBRESTMP(QUAL)
 Q IBRES
 ;
 ; creates array of SUBSCR IDs for all "other insurances"
 ;Input :
 ; IBXIEN - ien in #399
 ;Output:
 ; IBZOUT(Z) - array with ien of #36 
OTHSBID(IBXIEN,IBZOUT) ;
 N Z,Z0,Z1,IBZ,C
 D F^IBCEF("N-ALL INSURANCE CO 837 ID","IBZ")
 F Z=1,2,3 S IBZ(Z)=$$POLICY^IBCEF(IBXIEN,2,$E("PST",Z))
 K IBXDATA
 S C=$$OTHINS1^IBCEF2(IBXIEN)
 F Z=1,2 I $G(IBZ(Z))'="",$E(C,Z) D
 . S IBZOUT(Z)=IBZ(+$E(C,Z))
 Q
 ;Input :
 ; IBXIEN - ien in #399
 ; IBP - # piece in address string : STR LINE1|STR LINE2|CITY|STATE|ZIP
 ;Output:
 ; IBARR - output array m by reference
ELMADD2(IBXIEN,IBP,IBARR) ;
 N IBZZZ,A,CHECK,IB1
 I '$D(IBXSAVE("OTH_INSURED_ADDR")) D OTHADD2(IBXIEN,.IBZZZ) M IBXSAVE("OTH_INSURED_ADDR")=IBZZZ
 S IB1=0
 F  S IB1=$O(IBXSAVE("OTH_INSURED_ADDR",IB1)) Q:'IB1  D
 . ;IF ANY PORTION OF ADDRESS IS NULL SET CHECK VALUE, ERASE ENTRY
 . S CHECK=0
 . F A=1,3,4,5 I $P(IBXSAVE("OTH_INSURED_ADDR",IB1),"|",A)="" S CHECK=1 K IBXSAVE("OTH_INSURED_ADDR",IB1) Q
 . I 'CHECK D
 . . I IBP=0 S IBARR(IB1)=$G(IBXSAVE("OTH_INSURED_ADDR",IB1)) Q
 . . S IBARR(IB1)=$P($G(IBXSAVE("OTH_INSURED_ADDR",IB1)),"|",IBP)
 Q
 ;creates an array with address info for all other insured persons
 ;Input :
 ; IBXIEN - ien in #399
 ;Output:
 ; IBZOUT(Z) - array with STR LINE1|STR LINE2|CITY|STATE|ZIP 
OTHADD2(IBXIEN,IBZOUT) ;
 N C,Z,Z0,Z1,IBZ,IBZIP,IB1,IBDFN1
 S IBZOUT=""
 D OTHP36^IBCEF72(IBXIEN,.IBZ) ;array with iens of file #36
 K IBXDATA
 S C=$$OTHINS1^IBCEF2(IBXIEN)
 F Z=1,2 I $G(IBZ(Z))'="",$E(C,Z) D
 . S IBINS=+IBZ(+$E(C,Z))
 . S IBDFN1=$P($G(^DGCR(399,IBXIEN,0)),"^",2)
 . S IBZOUT(Z)=$$FR2PAT(IBDFN1,IBINS)
 Q
 ;Input:
 ; IBDFN-patient ien
 ; IBINS - input array with insurance pointers to 36
 ;Output 
 ; STR LINE1|STR LINE2|CITY|STATE|ZIP
FR2PAT(IBDFN,IBINS) ;information about "other insured" address
 N Z3,Z4,Z5,IBZIP
 S Z3=$O(^DPT(IBDFN,.312,"B",$G(IBINS),0))
 Q:+Z3=0 "||||"
 S Z4=$G(^DPT(IBDFN,.312,Z3,3))
 S IBZIP=$P($G(^DIC(5,+$P(Z4,"^",9),0)),"^",2)
 S Z5=$P(Z4,"^",6,8)_"^"_IBZIP_"^"_$P(Z4,"^",10)
 Q $TR(Z5,"^","|")
 ;
 ;Input :
 ; IBXIEN - ien in #399
 ; IBP - # piece in address string : STR LINE1|STR LINE2|CITY|STATE|ZIP
 ; if IBP=0 then returns whole string
 ;Output:
 ; IBARR - output array m by reference
ELMADDR(IBXIEN,IBP,IBARR) ;
 N IB1,A,CHECK
 D:'$D(IBXSAVE("OTH_PROV_ADDR")) OTHADDR(IBXIEN)
 S IB1=0
 F  S IB1=$O(IBXSAVE("OTH_PROV_ADDR",IB1)) Q:'IB1  D
 . S CHECK=0
 . ;EXCLUDE ADD LINE 2 SECOND PC SINCE IT'S OK FOR THAT TO BE EMPTY
 . F A=1,3,4,5 I $P(IBXSAVE("OTH_PROV_ADDR",IB1),"|",A)="" D  Q
 . . ;IF ANY PORTION OF ADDRESS IS NULL SET CHECK VALUE, ERASE ENTRY
 . . S CHECK=1 K IBXSAVE("OTH_PROV_ADDR",IB1)
 . I 'CHECK D
 . . I IBP=0 S IBARR(IB1)=$G(IBXSAVE("OTH_PROV_ADDR",IB1)) Q
 . . S IBARR(IB1)=$P($G(IBXSAVE("OTH_PROV_ADDR",IB1)),"|",IBP)
 Q
 ;
 ;creates an array with address info for all insurances
 ;Input :
 ; IBXIEN - ien in #399
 ;Output:
 ; IBXSAVE("OTH_PROV_ADDR",Z) 
OTHADDR(IBXIEN) ;
 N C,Z,Z0,Z1,IBZ,IBZIP,IB1,IBINS
 D F^IBCEF("N-OTH INSURANCE CO IEN 36") ;array with iens of file #36
 M IBZ=IBXDATA
 K IBXDATA
 S C=$$OTHINS1^IBCEF2(IBXIEN)
 F Z=1,2 I $G(IBZ(Z))'="",$E(C,Z) D
 . S IBINS=+IBZ(+$E(C,Z))
 . S IBZIP=$P($G(^DIC(5,+$P($G(^DIC(36,IBINS,.11)),"^",5),0)),"^",2)
 . S IB1=$P($G(^DIC(36,IBINS,.11)),"^",1,2)_"^"_$P($G(^DIC(36,IBINS,.11)),"^",4)_"^"_IBZIP_"^"_$P($G(^DIC(36,IBINS,.11)),"^",6)
 . S IBXSAVE("OTH_PROV_ADDR",Z)=$TR(IB1,"^","|")
 Q
 ;
 ;Retrieves pointer to get info about the service provider
 ;IBIEN399 - ien in #399
 ;IBFUNC -function (3-RENDERING,etc)
 ;Output: VARIABLE POINTER (PTR;file_root)
PROVPTR(IBIEN399,IBFUNC) ;
 N IBN
 S IBN=$O(^DGCR(399,IBIEN399,"PRV","B",IBFUNC,0))
 I +IBN=0 Q 0
 Q $P($G(^DGCR(399,IBIEN399,"PRV",+IBN,0)),"^",2)
 ;
 ;Retrieves SSN from #200
 ;IBPTR-  VARIABLE POINTER to #200
PROVSSN(IBIEN399) ;
 N IBRETVAL S IBRETVAL=""
 N IBPTR,IBFT
 F IBFT=1:1:9 D
 . S IBPTR=$$PROVPTR(IBIEN399,IBFT)
 . S $P(IBRETVAL,"^",IBFT)=$$GETSSN^IBCEF72(IBPTR)
 Q IBRETVAL
 ;
 ;Input:
 ; IBPTR- ptr to ^VA(200 or ^IBA(355.93
 ;Output:
 ; SSN or null
GETNMEL(IBFULL,IBEL) ;Get name element
 D NAMECOMP^XLFNAME(.IBFULL)
 Q $G(IBFULL(IBEL))
 ;-
 ;PROVIDER
 ;Input:
 ; IB399 - ien of #399
 ; IBPROV:
 ;   "C"- to get info for CURRENT provider
 ;   "O"- to get info for all others (in this case the array will contain info fot two providers
 ; IBRES - array for results (by reference)
 ;
 ;Output:
 ; IBRES - array to get back info (by reference)
 ; IBRES(IBPROV,PRNUM,PRTYPE,SEQ#)=PROV^INSUR^IDTYPE^ID^FORMTYP^CARETYP
 ; where:
 ; IBPROV - see input parameter
 ; PRNUM: 1=primary insurance provider, 2= secondary, 3 -tretiary
 ; PRTYPE: Provider type(FUNCTION) 
 ; SEQ# : sequence number (1st is used for ID1, 2nd - for ID2, etc)
 ; PROV : provider/VARIABLEPTR
 ; INSUR: Insurance PTR #36 or NONE
 ; IDTYPE: ID type
 ; ID: ID 
 ; FORMTYP: Form type 1=UB,2=1500
 ; CARETYP: Care type 0=both inp/outp,1=inpatient, 2=outpatient
PROVIDER(IB399,IBPROV,IBRES) ;
 N IBCURR,IBZ,IBRESARR
 S IBRESARR=""
 S IBCURR=$$COB^IBCEF(IB399) ;current bill payer sequence
 Q:IBPROV="A"  ;PATIENT's bill
 I IBPROV="C" D
 . D:$$ISINSUR^IBCEF71(IBCURR,IB399) PROVINF(IB399,$S(IBCURR="T":3,IBCURR="S":2,IBCURR="P":1,1:1),.IBRESARR,1,IBPROV)
 I IBPROV="O" D
 . I IBCURR="P" D:$$ISINSUR^IBCEF71("S",IB399) PROVINF(IB399,2,.IBRESARR,1,IBPROV) D:$$ISINSUR^IBCEF71("T",IB399) PROVINF(IB399,3,.IBRESARR,2,IBPROV)
 . I IBCURR="S" D:$$ISINSUR^IBCEF71("P",IB399) PROVINF(IB399,1,.IBRESARR,1,IBPROV) D:$$ISINSUR^IBCEF71("T",IB399) PROVINF(IB399,3,.IBRESARR,2,IBPROV)
 . I IBCURR="T" D:$$ISINSUR^IBCEF71("P",IB399) PROVINF(IB399,1,.IBRESARR,1,IBPROV) D:$$ISINSUR^IBCEF71("S",IB399) PROVINF(IB399,2,.IBRESARR,2,IBPROV)
 M IBRES(IBPROV)=IBRESARR
 Q
 ;
PROVINF(IB399,IBPRNUM,IBRES,IBSORT,IBINSTP) ;
 D PROVINF^IBCEF74(IB399,IBPRNUM,.IBRES,IBSORT,IBINSTP)
 Q
 ;
PSPRV(IBIFN) ; Returns information for bill ien IBIFN for purchased svc 
 ; Returns 4 digit data in following format:
 ;  1st digit: 0 if not outside facility
 ;             1 if outside facility
 ;  2nd digit: 0 if not non-VA provider for rendering/attending
 ;             1 if non-VA provider for rendering/attending
 ;  3rd digit: 0 if not purchased svc
 ;             1 if purchased svc
 ;  4th digit: 0 if 1500 bill
 ;             1 if UB bill
 N IBSVC,Z,Z0,IBU2
 S IBSVC="000"_+$$INSFT^IBCEU5(IBIFN),IBU2=$G(^DGCR(399,IBIFN,"U2"))
 I $P(IBU2,U,10) S $E(IBSVC,1)=1 ; NON-VA FACILITY
 S Z=($$FT^IBCEF(IBIFN)=3)+3,Z0=+$O(^DGCR(399,IBIFN,"PRV","B",Z,0))
 I $P($G(^DGCR(399,IBIFN,"PRV",Z0,0)),U,2)["IBA(355.93" S $E(IBSVC,2)=1
 I $P(IBU2,U,11)>0,$P(IBU2,U,11)'>2 S $E(IBSVC,3)=1
PSPRVQ Q IBSVC
 ;
CHKADD ;CHECK ALL ADDRESS ELEMENTS PRESENT IF NOT KILL ALL ADDRESS ELEMENTS
 ;EXPECT IBXSAVE("CADR") AS SOURCE ARRAY
 N Z,CHECK
 S Z="",CHECK=0
 F Z=1,4,5,6 D
 . I $P($G(IBXSAVE("CADR")),"^",Z)="" S CHECK=1
 I CHECK=1 S IBXSAVE("CADR")=""
 Q
 ;

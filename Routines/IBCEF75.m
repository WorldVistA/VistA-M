IBCEF75 ;ALB/WCJ - Provider ID functions ;13 Feb 2006
 ;;2.0;INTEGRATED BILLING;**320,371,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 G AWAY
AWAY Q
 ;
ALLIDS(IBIFN,IBXSAVE,IBSTRIP,SEG) ; Return all of the Provider IDS 
 I '$D(IBSTRIP) S IBSTRIP=0
 I '$D(SEG) S SEG=""
 N IBXIEN,ARINFO,ARID,ARQ,IBFRMTYP,ARIEN,ARINS,Z0,DAT,I,SORT1,SORT2,SORT3,COB,IBCCOB
 ;
 S IBXIEN=IBIFN
 D ALLPROV^IBCEF7    ; Get the Person ID's (Returns IBXSAVE)
 S DAT=$$PROVID^IBCEF73(IBIFN)
 S DAT("QUAL")=IBXSAVE("ID")  ; this value was also passed back by above function
 S SORT1="" F  S SORT1=$O(IBXSAVE("PROVINF",IBIFN,SORT1)) Q:SORT1=""  D
 . S SORT2=0 F  S SORT2=$O(IBXSAVE("PROVINF",IBIFN,SORT1,SORT2)) Q:SORT2=""  D
 .. S SORT3=0 F  S SORT3=$O(IBXSAVE("PROVINF",IBIFN,SORT1,SORT2,SORT3))  Q:SORT3=""  D
 ... S IBXSAVE("PROVINF",IBIFN,SORT1,SORT2,SORT3,0)="PRIMARY"_U_U_$$STRIP^IBCEF76($P(DAT("QUAL"),U,SORT3)_U_$P(DAT,U,SORT3),1,U,IBSTRIP)
 ... F I=1:1 Q:'$D(IBXSAVE("PROVINF",IBIFN,SORT1,SORT2,SORT3,I))  D
 .... S $P(IBXSAVE("PROVINF",IBIFN,SORT1,SORT2,SORT3,I),U,3,4)=$$STRIP^IBCEF76($P(IBXSAVE("PROVINF",IBIFN,SORT1,SORT2,SORT3,I),U,3,4),1,U,IBSTRIP)
 ;
 D LFIDS^IBCEF76(IBIFN,.IBXSAVE,IBSTRIP,SEG)   ; Get the Lab/Facility IDs
 ;
 S IBFRMTYP=$$FT^IBCEF(IBIFN)
 S ARIEN=$S(IBFRMTYP=2:3,1:4)
 S IBCCOB=$$COBN^IBCEF(IBIFN)  ; Current Insurance
 F COB=1:1:3 D
 . S SORT1=$S(COB=IBCCOB:"C",1:"O")
 . S SORT2=$S(SORT1="C":1,COB=1:1,COB=2&(IBCCOB=1):1,1:2)
 . S ARINFO=$G(IBXSAVE("PROVINF",IBIFN,SORT1,SORT2,ARIEN,1))
 . ;
 . D BPIDS(IBIFN,.IBXSAVE,SORT1,SORT2,COB,IBSTRIP,SEG)
 Q
 ; 
BPIDS(IBIFN,IDS,SORT1,SORT2,COB,IBSTRIP,SEG) ; Get all the billing provider IDs and qualifiers from the claim and file 355.92
 N DAT,IBFRMTYP,IBCARE,IBDIV,IBINS,MAIN,IBCCOB,USED,PLANTYPE,I,CNT,QUAL,ARF,M1,DEF,IDDIV,IBLIMIT,IEN,ID,IB2
 ;
 S DAT=$G(^DGCR(399,IBIFN,0))
 S IBFRMTYP=$$FT^IBCEF(IBIFN),IBFRMTYP=$S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0)
 S IBCARE=$S($$ISRX^IBCEF1(IBIFN):3,1:0) ;if an Rx refill bill
 S:IBCARE=0 IBCARE=$$INPAT^IBCEF(IBIFN) S:'IBCARE IBCARE=2 ;1-inp,2-out
 S IBDIV=+$P(DAT,U,22)
 S MAIN=$$MAIN^IBCEP2B()  ; get the IEN for main Division
 S IBCCOB=$$COBN^IBCEF(IBIFN)  ; Current Insurance
 S IBINS=$P($G(^DGCR(399,IBIFN,"I"_COB)),U)
 Q:IBINS=""
 ;
 S IDS("BILLING PRV",IBIFN,SORT1,SORT2)=$E("PST",COB)
 ;
 ; Primary ID
 S IDS("BILLING PRV",IBIFN,SORT1,SORT2,0)=$$STRIP^IBCEF76($$TAXID(),1,U,IBSTRIP)
 S USED($P(IDS("BILLING PRV",IBIFN,SORT1,SORT2,0),U))=""
 ;
 ; Secondary #1 - This is the ID Emdeon uses for sorting
 S IDS("BILLING PRV",IBIFN,SORT1,SORT2,1)=$$STRIP^IBCEF76($$BPSID1(IBDIV),1,U,IBSTRIP)
 S USED($P(IDS("BILLING PRV",IBIFN,SORT1,SORT2,1),U))=""
 ;
 ; Check if this is a plan type which gets no secondary IDs
 S M1=$G(^DGCR(399,IBIFN,"M1"))
 ; the following check is the current value of the flag, not when the claim was created. 
 S PLANTYPE=$$POLTYP^IBCEF3(IBIFN,COB)
 I PLANTYPE]"",$D(^DIC(36,IBINS,13,"B",PLANTYPE)) Q 
 ;
 ; Secondary #2
 ; If there is a ID  send with quailifer (stored or computed)
 I $TR($P(M1,U,COB+1)," ")]"" D
 . S QUAL=""
 . S DAT=$P(M1,U,COB+9)
 . I DAT S QUAL=$$STRIP^IBCEF76($P($G(^IBE(355.97,DAT,0)),U,3),1,,IBSTRIP)
 . ; the null check is needed to be backwards compatible
 . I QUAL=""!(QUAL="1J") S QUAL=$$STRIP^IBCEF76($$OLDWAY(IBIFN,COB),1,,IBSTRIP)
 . S IB2=QUAL_U_$$STRIP^IBCEF76($P(M1,U,COB+1),1,,IBSTRIP)
 ;
 I $TR($P(M1,U,COB+1)," ")="" S IB2=$$STRIP^IBCEF76($$OLDWAY(IBIFN,COB),1,,IBSTRIP)_U_$$STRIP^IBCEF76($$GET1^DIQ(350.9,1,1.05),1,,IBSTRIP)
 ;
 S IDS("BILLING PRV",IBIFN,SORT1,SORT2,2)=IB2
 S IDS("BILLING PRV",IBIFN,SORT1,SORT2,2,"PTQ")=$$OLDWAY(IBIFN,COB)
 S USED($P(IB2,U))=""
 ;
 S CNT=$S('$D(IDS("BILLING PRV",IBIFN,SORT1,SORT2,2)):2,1:3)
 S IBLIMIT=8
 S IEN=0 F  S IEN=$O(^IBA(355.92,"B",IBINS,IEN)) Q:IEN=""  D  Q:CNT>IBLIMIT
 . S DAT=$G(^IBA(355.92,IEN,0))
 . Q:$P(DAT,U,8)'="A"   ; only allow additional IDs
 . Q:$P(DAT,U,7)=""  ; No Provider ID
 . Q:$P(DAT,U,6)=""  ; No ID Qualifier
 . I IBFRMTYP=1 Q:$P(DAT,U,4)=2
 . I IBFRMTYP=2 Q:$P(DAT,U,4)=1
 . ;
 . ; Check if we already have one of these
 . S QUAL=$$STRIP^IBCEF76($P(DAT,U,6),1,,IBSTRIP)
 . S QUAL=$P($G(^IBE(355.97,QUAL,0)),U,3)
 . Q:QUAL=""
 . Q:$D(USED(QUAL))
 . ;
 . S IDS("BILLING PRV",IBIFN,SORT1,SORT2,CNT)=QUAL_U_$$STRIP^IBCEF76($P(DAT,U,7),1,,IBSTRIP)
 . S CNT=CNT+1,USED(QUAL)=""
 ;
 Q
 ;
OLDWAY(IBIFN,COB) ; Figure out the qualifier the old way if it's not stored with the claim.
 ; It's based on the plan type.  This is used for Billing Provider Secondary ID #2
 N PLANTYPE
 S PLANTYPE=$$POLTYP^IBCEF3(IBIFN,COB)
 Q $$SOP^IBCEP2B(IBIFN,PLANTYPE)
 ;
BPSID1(DIV) ; Return the Billing Provider Secondary ID #1 and qualifier which Emdeon uses to sort IBIFNs
 N DATA
 S DATA=$P($$SITE^VASITE(DT,$S(DIV:DIV,1:+$$PRIM^VASITE(DT))),U,3)
 S DATA=$E("0000",1,7-$L(DATA))_$E(DATA,4,7)
 Q "G5"_U_DATA
 ;
TAXID() ; Return the Billing Provider Primary ID and qualifier which is the TAXID for the site and also the qualifier
 N DATA
 S DATA=$P($G(^IBE(350.9,1,1)),U,5)
 S DATA=$$NOPUNCT^IBCEF(DATA,1)
 Q 24_U_DATA
 ;
CLEANUP(IBXSAVE) ; Clean up 
 K IBXSAVE("PROVINF")
 K IBXSAVE("LAB/FAC")
 K IBXSAVE("BILLING PRV")
 K IBXSAVE("ID")
 Q

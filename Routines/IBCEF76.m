IBCEF76 ;ALB/WCJ - Provider ID functions ;13 Feb 2006
 ;;2.0;INTEGRATED BILLING;**320,349,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 G AWAY
AWAY Q
 ;
LFIDS(IBIFN,IDS,IBSTRIP,SEG) ;
 ;  Pass in the the internal claim number and return the array of IDS.
 ;  IDS("C"urrent or "O"ther, Order of Insurance within subscript 1, order of ID within subscript 2)
 ;  IDS("C",1)="P"
 ;  IDS("C",1,0)=Qualifier^Primary ID
 ;  IDS("C",1,1)=Qualifier^Sec ID #1
 ;  IDS("C",1,2)=Qualifier^Sec ID #2
 ;
 N DAT,IBFRMTYP,IBCARE,IBDIV,IBINS,OUTFAC,MAIN,IBCCOB,TMPIDS,COB,IBSORT1,IBSORT2,IBLIMIT,IBLF
 ;
 S DAT=$G(^DGCR(399,IBIFN,0))
 S IBFRMTYP=$$FT^IBCEF(IBIFN),IBFRMTYP=$S(IBFRMTYP=2:2,IBFRMTYP=3:1,1:0)
 S IBCARE=$S($$ISRX^IBCEF1(IBIFN):3,1:0) ;if an Rx refill bill
 S:IBCARE=0 IBCARE=$$INPAT^IBCEF(IBIFN) S:'IBCARE IBCARE=2 ;1-inp,2-out
 S IBDIV=+$P(DAT,U,22)
 S OUTFAC=$P($G(^DGCR(399,IBIFN,"U2")),U,10)
 S MAIN=$$MAIN^IBCEP2B()  ; get the IEN for main Division
 ;
 S IBCCOB=$$COBN^IBCEF(IBIFN)
 F COB=1:1:3 D
 . S IBSORT1=$S(COB=IBCCOB:"C",1:"O")
 . S IBSORT2=$S(IBSORT1="C":1,COB=1:1,COB=2&(IBCCOB=1):1,1:2)
 . S IBLIMIT=$S(IBSORT1="C":5,1:3)  ; Limit secondary IDs
 . S DAT=$G(^DGCR(399,IBIFN,"I"_COB))
 . ;
 . S IBINS=$P(DAT,U)  ; insurance PTR 36
 . Q:IBINS=""
 . ;
 . ; IB*2*400 - esg - 9/24/08, 2/24/09 - if there is no service facility for this claim at this COB, then get out
 . S IBLF=$$B^IBCEF79(IBIFN,COB)       ; billing provider/service facility function
 . I $P(IBLF,U,3)="" Q                 ; no service facility data at this COB, don't build this "LAB/FAC" area
 . ;
 . I OUTFAC]"" D  Q
 .. D NONVALF(IBIFN,OUTFAC_";IBA(355.93,",IBINS,IBFRMTYP,IBCARE,.IDS,IBSORT1,IBSORT2,COB,IBLIMIT,IBSTRIP,SEG)
 . ;
 . I OUTFAC="" D
 .. ;
 .. ; if ins co flag says to not send svc fac data and we're sending an EDI claim, then get out
 .. I '$$SENDSF^IBCEF79(IBIFN,COB),$G(^TMP("IBTX",$J,IBIFN)) Q
 .. ;
 .. S IDS("LAB/FAC",IBIFN,IBSORT1,IBSORT2,0)=$$STRIP($$TAXID^IBCEF75(),1,U,IBSTRIP)
 .. D VALF(IBIFN,IBINS,IBFRMTYP,IBDIV,.IDS,IBSORT1,IBSORT2,COB,IBLIMIT,IBSTRIP,SEG)
 Q
 ;
VALF(IBIFN,INS,FT,DIV,IDS,SORT1,SORT2,COB,IBLIMIT,IBSTRIP,SEG) ; Get VA Lab/Fac Secondary IDs
 ; Pass in INS - IEN to file 36
 ; FT - 1 = UB 2 = 1500
 ; DIV - PTR to 40.8
 ;
 N Z,Z0,ID,QUAL,MAIN,IDTBL,CNT,Z
 S MAIN=$$MAIN^IBCEP2B()  ; get the IEN for main Division
 S Z=0 F  S Z=$O(^IBA(355.92,"B",INS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:$P(Z0,U,8)'="LF"   ; Screen out anything other than Lab or Facility
 . I +$P(Z0,U,4) Q:$P(Z0,U,4)'=FT   ; Form type must match that passed in or be a 0 which allows both
 . S ID=$$STRIP($P(Z0,U,7),1,,IBSTRIP)
 . S QUAL=$$STRIP($P(Z0,U,6),1,,IBSTRIP)
 . Q:QUAL=""   ; Needs a qualifier
 . S QUAL=$P($G(^IBE(355.97,QUAL,0)),U,3)
 . I FT=1,SORT1="O" Q:$$OP3^IBCEF73(FT)'[(U_QUAL_U)   ; Institutional
 . I FT=2,SORT1="O" Q:$$OP7^IBCEF73(FT)'[(U_QUAL_U)   ; Professional
 . I $P(Z0,U,5)=""!($P(Z0,U,5)=0)!($P(Z0,U,5)=MAIN) S IDTBL("DEF",QUAL)=ID  ; set up default for main division
 . I $P(Z0,U,5)=DIV S IDTBL("DIV",QUAL)=ID  ; set up default for division
 S CNT=0
 S IDS("LAB/FAC",IBIFN,SORT1,SORT2)=$E("PST",COB)
 I $D(IDTBL("DIV")) D  Q
 . S Z="" F  S Z=$O(IDTBL("DIV",Z)) Q:Z=""  S CNT=CNT+1,IDS("LAB/FAC",IBIFN,SORT1,SORT2,CNT)=Z_U_IDTBL("DIV",Z) Q:CNT=IBLIMIT
 I $D(IDTBL("DEF")) D  Q
 . S Z="" F  S Z=$O(IDTBL("DEF",Z)) Q:Z=""  S CNT=CNT+1,IDS("LAB/FAC",IBIFN,SORT1,SORT2,CNT)=Z_U_IDTBL("DEF",Z) Q:CNT=IBLIMIT
 Q
 ;
NONVALF(IBIFN,PRV,INS,FT,PT,IDS,SORT1,SORT2,COB,IBLIMIT,IBSTRIP,SEG) ; Get Non VA Lab/Fac Secondary IDs
 ; Pass in PRV - VPTR - PTR to 355.93 (in format of variabel pointer IEN;IBA(355.93,
 ; Pass in INS - PTR to 36 of null (not provide by insurance company)
 ; FT - 1 = UB 2 = 1500
 ; PT - Patient Type - 1 inpatient 2 outpatient
 ; IDS array being returned
 ; SORT1 - "C"urrent or "O"ther
 ; SORT2 - 1 if current or (1 or 2 if other)
 N Z,Z0,ID,QUAL,IDTBL,CNT
 S Z=0 F  S Z=$O(^IBA(355.9,"B",PRV,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.9,Z,0))
 . I +$P(Z0,U,4) Q:$P(Z0,U,4)'=FT   ; Form type must match that passed in or be a 0 which allows both UB and 1500
 . I +$P(Z0,U,5) Q:$P(Z0,U,5)'=PT   ; Patient type must match that passed in or be a 0 which allows both in patient and outpatient
 . I INS]"",$P(Z0,U,2)]"",INS'=$P(Z0,U,2) Q
 . S ID=$$STRIP($P(Z0,U,7),1,,IBSTRIP)
 . Q:ID=""
 . S QUAL=$$STRIP($P(Z0,U,6),1,,IBSTRIP)
 . Q:QUAL=""   ; Needs a qualifier
 . S QUAL=$P($G(^IBE(355.97,QUAL,0)),U,3)
 . Q:QUAL=""
 . I FT=1,SORT1="O" Q:$$OP3^IBCEF73(FT)'[(U_QUAL_U)   ; Institutional
 . I FT=2,SORT1="O" Q:$$OP7^IBCEF73(FT)'[(U_QUAL_U)   ; Professional
 . I $G(SEG)="SUB1" Q:$$SUB1^IBCEF73(FT)'[(U_QUAL_U)
 . I $P(Z0,U,2)="" S IDTBL("OWN",QUAL)=ID  ; set up default of lab or facilities own ids
 . I $P(Z0,U,2)=INS S IDTBL("INS",QUAL)=ID  ; set up default for division
 ;
 S CNT=0
 S IDS("LAB/FAC",IBIFN,SORT1,SORT2)=$E("PST",COB)_U_PRV
 ; get primary
 S Z0=$G(^IBA(355.93,+PRV,0))
 I $P(Z0,U,9)]"",$P(Z0,U,13)]"" S IDS("LAB/FAC",IBIFN,SORT1,SORT2,CNT)=$$STRIP($P($G(^IBE(355.97,$P(Z0,U,13),0)),U,3)_U_$P(Z0,U,9),1,U,IBSTRIP)
 ; get secondarys in order
 I $D(IDTBL("INS")) D
 . N Z S Z="" F  S Z=$O(IDTBL("INS",Z)) Q:Z=""  S CNT=CNT+1,IDS("LAB/FAC",IBIFN,SORT1,SORT2,CNT)=Z_U_IDTBL("INS",Z) Q:CNT=IBLIMIT
 I $D(IDTBL("OWN")),CNT'=IBLIMIT D
 . N Z S Z="" F  S Z=$O(IDTBL("OWN",Z)) Q:Z=""  I '$D(IDTBL("INS",Z)) S CNT=CNT+1,IDS("LAB/FAC",IBIFN,SORT1,SORT2,CNT)=Z_U_IDTBL("OWN",Z) Q:CNT=IBLIMIT
 Q
 ;
STRIP(X,SPACE,EXC,IBSTRIP) ;
 ; Strip punctuation from data in X
 ; SPACE = flag if 1 strip SPACES
 ; EXC = list of punct not to strip
 ; 
 Q:'$G(IBSTRIP) X
 Q $$NOPUNCT^IBCEF(X,$G(SPACE),$G(EXC))
 ;
OTH(IBIFN,IBXSAVE,IBXDATA,COND,SEG) ; Procedure used in piece 2 of some output
 ; formatter segments for other insurance
 ; COND = 0/1 value passed in that determines whether or not to call the
 ;        provider ID function
 ;  SEG = name of segment for use in calling ID^IBCEF2 (4 characters)
 ;
 N Z
 D CLEANUP^IBCEF75(.IBXSAVE)
 I COND D ALLIDS^IBCEF75(IBIFN,.IBXSAVE,1)
 ;
 ; Special Check:  if Other Insurance #2 has secondary ID's while Other
 ; Insurance #1 does not, then move up #2 to be #1 here.  This is to
 ; ensure the output formatter IBXDATA array is built properly.
 ;
 I $O(IBXSAVE("LAB/FAC",IBIFN,"O",2,0)),'$O(IBXSAVE("LAB/FAC",IBIFN,"O",1,0)) D
 . K IBXSAVE("LAB/FAC",IBIFN,"O",1)
 . M IBXSAVE("LAB/FAC",IBIFN,"O",1)=IBXSAVE("LAB/FAC",IBIFN,"O",2)
 . K IBXSAVE("LAB/FAC",IBIFN,"O",2)
 . Q
 ;
 K IBXDATA
 S Z=0
 F  S Z=$O(IBXSAVE("LAB/FAC",IBIFN,"O",Z)) Q:'Z  D
 . I '$O(IBXSAVE("LAB/FAC",IBIFN,"O",Z,0)) Q
 . S IBXDATA(Z)=$P($G(IBXSAVE("LAB/FAC",IBIFN,"O",Z)),U,1)
 . I Z>1 D ID^IBCEF2(Z,SEG)
 . Q
OTHX ;
 Q
 ;

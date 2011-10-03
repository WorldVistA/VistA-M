IBCROI1 ;ALB/ARH - RATES: REPORTS CHARGE ITEM (SRCH) ; 11/22/96
 ;;2.0;INTEGRATED BILLING;**52,106,245,287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  ^TMP($J,SUB1) = report header ^ SORT1 ^ SORT2 ^ count & desc (optional)
 ;  ^TMP($J,SUB1, SUB2) = IFN of SUB2
 ;  ^TMP($J,SUB1, SUB2, SUB3, SUB4, CI IFN) = itm ^ cs ^ ef dt ^ in dt ^ chg ^ rv cd ^ mod ^ base charge
 ; 
 ; SORT1=1:  (SRCH1) SUB2 = BILLING RATE name        SORT2=1:  SUB3 = Item Name          SUB4 = Effective Date
 ; SORT1=2:  (SRCH2) SUB2 = CHARGE SET name          SORT2=2:  SUB3 = Effective Date     SUB4 = Item Name
 ; 
 ; SUB1 - first subscript to identify the search/print, set to "IBCROI" for the Charge Item report
 ; other reports may use this array and print routine, both TMPLN and TMPHDR must be called to setup array
 ; if called direct to SRCHITM with SORT3=3: sort by Item, Effective Date, SUB2 (as passed in)
 ;
SRCH1(BRL,SORT2,BDT,EDT,IBSELITM) ; search/gather items for the report, all charge sets for a particular Rate
 ; Input: BRL = List of Billing Rates to include, SORT2 = secondary sort: 1/charge item, 2/effective date
 N IBRATE,IBRATEN,IBHDR,IBSUB2,IBCS,IBCS0,IBI K ^TMP($J,"IBCROI") I '$G(SORT2)!($G(BDT)'?7N)!($G(EDT)'?7N) Q
 ;
 I +$G(BRL) S IBRATE=0 F IBI=1:1 S IBRATE=$P(BRL,U,IBI) Q:'IBRATE  D
 . S IBRATEN=$P($G(^IBE(363.3,+IBRATE,0)),U,1) Q:IBRATEN=""
 . S IBHDR="Charges for "_$S(+$P(BRL,U,2):"Selected",1:IBRATEN)_" Rates ",IBSUB2="BILLING RATE"
 . ;
 . S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 .. S IBCS0=$G(^IBE(363.1,IBCS,0)) I $P(IBCS0,U,2)'=IBRATE Q
 .. D SRCHITM(IBCS,IBSUB2,SORT2,BDT,EDT,$G(IBSELITM)) I '$D(ZTQUEUED) W "."
 .. D TMPHDR("IBCROI",IBSUB2,0,IBHDR,"1^"_SORT2,BDT,EDT)
 Q
 ;
SRCH2(CSL,SORT2,BDT,EDT,IBSELITM) ; search/gather items for the report for a group of Charge Sets
 ; Input:  CSL = list of Charge Sets to sort, SORT2 = secondary sort: 1/charge item, 2/effective date
 N IBCS,IBCSN,IBI,IBHDR K ^TMP($J,"IBCROI") I '$G(SORT2)!($G(BDT)'?7N)!($G(EDT)'?7N) Q
 ;
 I +$G(CSL) S IBCS=0 F IBI=1:1 S IBCS=$P(CSL,U,IBI) Q:'IBCS  D
 . S IBCSN=$P($G(^IBE(363.1,+IBCS,0)),U,1) Q:IBCSN=""  S IBHDR="Charges by Set for "
 . D SRCHITM(IBCS,IBCSN,SORT2,BDT,EDT,$G(IBSELITM)) I '$D(ZTQUEUED) W "."
 . D TMPHDR("IBCROI",IBCSN,IBCS,IBHDR,"2^"_SORT2,BDT,EDT)
 Q
 ;
SRCHITM(CS,SUB2,SORT2,BDT,EDT,IBSELITM) ; search/gather all items within the date range for one Charge Set
 ; Input:  CS = CS IFN, SUB2 = first data subscript, SORT2 = secondary sort: 1/charge item, 2/effective date
 N IBXRF,IBITM,IBEFDT,IBCI,IBINDT,IBITEM,IBITEMN I '$G(CS)!'$G(SORT2)!($G(SUB2)="")!($G(BDT)'?7N)!($G(EDT)'?7N) Q
 S IBXRF="AIVDTS"_+CS
 ;
 S IBITM=+$G(IBSELITM) I +IBITM S IBITM=IBITM-.0001
 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM!(+$G(IBSELITM)&(IBITM'=$G(IBSELITM)))  D
 . S IBEFDT=-(EDT+.01) F  S IBEFDT=$O(^IBA(363.2,IBXRF,IBITM,IBEFDT)) Q:'IBEFDT  D
 .. S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,IBEFDT,IBCI)) Q:'IBCI  D
 ... ;
 ... S IBINDT=$$INACTCI^IBCRU4(IBCI) I +IBINDT,IBINDT<BDT Q
 ... D TMPLN(IBCI,"IBCROI",SUB2,SORT2)
 Q
 ;
TMPLN(CI,SUB1,SUB2,SORT2) ; add charge item to TMP array
 N IBINDT,IBITEM,IBITEMN I '$G(CI)!'$G(SORT2)!($G(SUB1)="")!($G(SUB2)="") Q
 S IBINDT=$$INACTCI^IBCRU4(CI)
 S IBITEM=$G(^IBA(363.2,+CI,0)) Q:IBITEM=""  ;S $P(IBITEM,U,8)=IBINDT
 S IBITEMN=$$EXPAND^IBCRU1(363.2,.01,$P(IBITEM,U,1))_" "
 I +$P(IBITEM,U,7) S IBITEMN=IBITEMN_"- "_$P($$MOD^ICPTMOD(+$P(IBITEM,U,7),"I",DT),U,2)
 ;
 I SORT2=1 S ^TMP($J,SUB1,SUB2,IBITEMN,+$P(IBITEM,U,3),+CI)=IBITEM
 I SORT2=2 S ^TMP($J,SUB1,SUB2,+$P(IBITEM,U,3),IBITEMN,+CI)=IBITEM
 ;
 I SORT2=3 S ^TMP($J,SUB1,IBITEMN,+$P(IBITEM,U,3),SUB2,+CI)=IBITEM
 Q
 ;
TMPHDR(SUB1,SUB2,SUB2IFN,HDR,SORT,BDT,EDT) ; set up top level of the TMP array
 I '$G(SORT)!($G(SUB2)="")!($G(SUB1)="") Q
 I +$G(BDT) S HDR=$G(HDR)_" "_$$DATE^IBCRU1(BDT) I +$G(EDT) S HDR=HDR_" - "_$$DATE^IBCRU1(EDT)
 S ^TMP($J,SUB1)=HDR_U_SORT
 S ^TMP($J,SUB1,SUB2)=SUB2IFN
 Q

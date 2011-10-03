IBCRCU1 ;ALB/ARH - RATES: CALCULATION UTILITIES ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; there are two types of Charge Sets (363.1) that have Charge Item entries (363.2):
 ; 1 - ITEM: each item has an individual charge:  an item on the bill has corresponding charge item entries,
 ;     the item may have more than one Charge Item entry but they are specifically defined for that item
 ;     ex: an inpt bs, a CPT, or a drug
 ; 2 - EVENT: the charge is for an event not an item:  all charge items active on a date in the Set 
 ;     combine to give the charge for the item on the bill for that date
 ;     all items in the set define the event charge - the total charges for a set on a date is the event charge
 ;     the item does not have to match an item on the bill and is only relevant because it is then added
 ;     to the RC multiple of the bill as one of the bills charge lines
 ;     ex:  the charge for a bills opt visit date is the combined charge of all items active in the Set
 ;          on the visit date (this may be more than simply the Outpatient Visit Date bedsection charge if
 ;          there is another bedsection charge defined for that date)
 ;
CSITMS(CS) ; returns 1 (ITEM) if the CS requires a single billable item or 2 (EVENT) if all active items for date are used
 ;
 N IBX,IBCSBR,IBBEVNT,IBBLITEM,IBCHGMTH S IBX=0 I '$G(CS) G CSITMSQ
 S IBCSBR=$$CSBR^IBCRU3(+CS) I IBCSBR="" G CSITMSQ
 S IBBEVNT=$P(IBCSBR,U,1),IBBLITEM=$P(IBCSBR,U,4),IBCHGMTH=$P(IBCSBR,U,5)
 ;
 I IBBEVNT["INPATIENT BEDSECTION STAY",IBBLITEM=1,IBCHGMTH=1 S IBX=1 G CSITMSQ
 I IBBEVNT["OUTPATIENT VISIT DATE",IBBLITEM=1,IBCHGMTH=1 S IBX=2 G CSITMSQ
 I IBBEVNT["PRESCRIPTION",IBBLITEM=1,IBCHGMTH=1 S IBX=2 G CSITMSQ
 I IBBEVNT["PRESCRIPTION",IBBLITEM=3,IBCHGMTH=3 S IBX=1 G CSITMSQ
 I IBBEVNT["PRESCRIPTION",IBCHGMTH=2 S IBX=1 G CSITMSQ
 I IBBEVNT["PROSTHETICS",IBBLITEM=1,IBCHGMTH=1 S IBX=2 G CSITMSQ
 I IBBEVNT["PROSTHETICS",IBCHGMTH=2 S IBX=1 G CSITMSQ
 I IBBEVNT["PROCEDURE",IBBLITEM=2,IBCHGMTH=1 S IBX=1 G CSITMSQ
 I IBBEVNT["PROCEDURE",IBBLITEM=2,IBCHGMTH=4 S IBX=1 G CSITMSQ
 I IBBEVNT["PROCEDURE",IBBLITEM=2,IBCHGMTH=5 S IBX=1 G CSITMSQ
 I IBBEVNT["PROCEDURE",IBBLITEM=2,IBCHGMTH=6 S IBX=1 G CSITMSQ
 I IBBEVNT["INPATIENT DRG",IBBLITEM=4,IBCHGMTH=1 S IBX=1 G CSITMSQ
 I IBBEVNT["UNASSOCIATED",IBBLITEM=9,IBCHGMTH=1 S IBX=1 G CSITMSQ
CSITMSQ Q IBX
 ;
CSALL(CS,EVDT,ARR) ; returns all items billable on a given effective date for charge sets where all active items are billed (EVENT)
 ; finds most recent effective date, returns all items active on that date ie. does not check item inactive date
 ; first get all active items on date then get only those items active on most recent effective date
 ; Ouput:  ARR = chg effective date
 ;         ARR(source item pointer) =""
 ;
 N IBXRF,IBITM,IBEVDT,ARR1 K ARR S ARR=0,EVDT=$G(EVDT)\1 I '$G(CS)!(EVDT'?7N) G CSALLQ
 I +$$CSITMS(CS)'=2 G CSALLQ
 ;
 S IBXRF="AIVDTS"_CS
 S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 . S IBEVDT=$O(^IBA(363.2,IBXRF,IBITM,-(EVDT+.01))) Q:'IBEVDT
 . S ARR1(IBEVDT,IBITM)=""
 ;
 S IBEVDT=$O(ARR1(""))
 I +IBEVDT S IBITM=0 F  S IBITM=$O(ARR1(IBEVDT,IBITM)) Q:'IBITM  S ARR(IBITM)="",ARR=-IBEVDT
 ;
CSALLQ Q
 ;
CPTUNITS(CS,UNIT) ; return raw data returns CPT units based on Charge Set and item
 ; Input: CS - Charge Set of charge determines Charge Method
 ;        UNIT - total miles/minutes/hours of item
 ; Output: UNIT or calculated for miles/minutes/hours
 N IBUNITS,IBCSBR,IBCHGMTH S IBUNITS=+$G(UNIT) I 'IBUNITS G CPTUNITQ
 S CS=$G(CS) S IBCSBR=$$CSBR^IBCRU3(CS),IBCHGMTH=$P(IBCSBR,U,5)
 I +IBCHGMTH=4 S IBUNITS=$$MLUNIT^IBCRCC(UNIT) ; miles
 I +IBCHGMTH=5 S IBUNITS=$$MNUNIT^IBCRCC(UNIT) ; minutes
 I +IBCHGMTH=6 S IBUNITS=$$HRUNIT^IBCRCC(UNIT) ; hours
CPTUNITQ Q IBUNITS
 ;
CPTMOD(CS,CPT,MODS,DATE) ; check to see if a CPT-Modifier combination has a charge in this Charge Set, returns "" or CI IFN
 ; Input MODS is a list of modifiers to check separated by ','
 ; Output "" or list of modifiers with active charges in the set on date
 N IBMOD,IBI,IBX,IBY S (IBX,IBY)="" I '$G(CS)!'$G(CPT)!'$G(MODS)!'$G(DATE) G CPTMODQ
 F IBI=1:1 S IBMOD=$P(MODS,",",IBI) Q:IBMOD=""  D
 . I +$$FNDCI^IBCRU4(CS,CPT,DATE,,IBMOD) S IBX=IBX_IBY_IBMOD S IBY=","
 ;
CPTMODQ Q IBX
 ;
CHGMOD(IBIFN,CPT,EFFDT,CT) ; find charges for a procedure and a date for a bill
 ; returns: count of charges ':' list of charge items ':' list of charge modifiers
 N IB0,IBU,IBBDV,IBBCT,ARRCS,IBRS,IBCS,ARRCHG,IBFND,IBCIS,IBMODS,IBX S IBFND=0,(IBCIS,IBMODS)=""
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBU=$G(^DGCR(399,+$G(IBIFN),"U")),IBBDV=$P(IB0,U,22),IBBCT=$S($D(CT):CT,1:$P(IB0,U,27))
 I IB0'="",+IBU,+IBBDV,+$G(CPT),+$G(EFFDT) D RT^IBCRU3($P(IB0,U,7),$P(IB0,U,5),EFFDT,.ARRCS,"PROCEDURE",IBBCT) D
 . S IBRS=0 F  S IBRS=$O(ARRCS(IBRS)) Q:'IBRS  D
 .. S IBCS=0 F  S IBCS=$O(ARRCS(IBRS,IBCS)) Q:'IBCS  I +ARRCS(IBRS,IBCS) D
 ... I $$CSDV^IBCRU3(IBCS,IBBDV)<0 Q  ; check division
 ... I '$$CHGOTH^IBCRBC2(IBIFN,IBRS,EFFDT) Q  ; ckeck snf/non-snf
 ... I +$$FNDCI^IBCRU4(IBCS,CPT,EFFDT,.ARRCHG) S IBFND=IBFND+ARRCHG D
 .... S IBX=0  F  S IBX=$O(ARRCHG(IBX)) Q:'IBX  S IBCIS=IBCIS_IBX_U,IBMODS=IBMODS_$P(ARRCHG(IBX),U,7)_U
 I +IBFND S IBFND=IBFND_":"_IBCIS_":"_IBMODS
CHGMODQ Q IBFND
 ;
CPTCHG(IBIFN,CT) ; return true if bill has auto add CPT charges for the Charge Type passed in (regardless of modifier)
 N IBFND,IB0,IBU,IBBILLDV,IBBCT,IBCT,ARRCPT,ARRCS,IBRS,IBCS,IBCPT,IBCPTDA,IBCPT0 S IBFND=0,CT=$G(CT)
 ;
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) I IB0="" G CPTCHGQ
 S IBU=$G(^DGCR(399,+$G(IBIFN),"U")) I 'IBU G CPTCHGQ
 S IBBILLDV=$P(IB0,U,22),IBBCT=$P(IB0,U,27)
 ;
 S IBCT=$S(CT="BILL":IBBCT,CT="INST":1,CT="PROF":2,CT="OPST"&(IBBCT=1):2,CT="OPST"&(IBBCT=2):1,CT="":"",1:-1)
 I IBCT<0 G CPTCHGQ
 ;
 D CPT^IBCRBG1(IBIFN,.ARRCPT) I '$O(ARRCPT(0)) G CPTCHGQ
 D RT^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IBU,U,1,2),.ARRCS,"PROCEDURE",IBCT)
 ;
 S IBRS=0 F  S IBRS=$O(ARRCS(IBRS)) Q:'IBRS  D  I +IBFND Q
 . S IBCS=0 F  S IBCS=$O(ARRCS(IBRS,IBCS)) Q:'IBCS  I +ARRCS(IBRS,IBCS) D  I +IBFND Q
 .. ;
 .. S IBCPT=0 F  S IBCPT=$O(ARRCPT(IBCPT)) Q:'IBCPT  D  I +IBFND Q
 ... S IBCPTDA=0 F  S IBCPTDA=$O(ARRCPT(IBCPT,IBCPTDA)) Q:'IBCPTDA  D  I +IBFND Q
 .... ;
 .... S IBCPT0=ARRCPT(IBCPT,IBCPTDA)
 .... I $$CSDV^IBCRU3(IBCS,$P(IBCPT0,U,3),IBBILLDV)<0 Q  ; check division
 .... ;
 .... I +$$CHKIPB^IBCU7A1(IBCPT,IBCT) S IBFND=1 Q
 .... I +$$FNDCI^IBCRU4(IBCS,IBCPT,$P(IBCPT0,U,1)) S IBFND=1
 ;
CPTCHGQ Q IBFND

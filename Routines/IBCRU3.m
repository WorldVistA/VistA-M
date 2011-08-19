IBCRU3 ;ALB/ARH - RATES: UTILITIES (CS/BR) ;22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,223**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CSN(N) ; returns the IFN of the Charge Set name passed in
 N X S X="" I $G(N)'="" S X=$O(^IBE(363.1,"B",N,0))
 Q X
 ;
CSBI(CS) ; returns a Charge Set rates Billable Item (363.3,.04): 0 or BI ^ bi name
 N IBX,IBCS0,IBBI S IBX=0
 S IBCS0=$G(^IBE(363.1,+$G(CS),0)),IBBI=$P($G(^IBE(363.3,+$P(IBCS0,U,2),0)),U,4)
 I +IBBI S IBX=IBBI_U_$$EXPAND^IBCRU1(363.3,.04,IBBI)
 Q IBX
 ;
CSBR(CS) ; return data on a charge set: billable event ^ BE IFN ^ billing rate IFN ^ billable item ^ charge method
 N IBBRFN,IBBEVNT,IBLN1,IBLN,IBX S IBX=""
 S IBLN=$G(^IBE(363.1,+$G(CS),0)),IBBRFN=+$P(IBLN,U,2),IBBEVNT=$$EMUTL^IBCRU1($P(IBLN,U,3))
 S IBLN1=$G(^IBE(363.3,IBBRFN,0))
 I IBLN'="" S IBX=IBBEVNT_U_$P(IBLN,U,3)_U_IBBRFN_U_$P(IBLN1,U,4)_U_$P(IBLN1,U,5)
 Q IBX
 ;
CSDV(CS,DIV,DDIV) ; check if the division is covered by this charge set
 ; ""  if - Charge Set has no region defined (ie. covers all divisions)
 ; div if - division passed in and it is one of the divisions of the region defined for the Charge Set
 ;        - no division but default division is one of the divisions of the region defined for the Set
 ; -1     - otherwise:  division not covered by CS
 ;
 N IBX,IBCS0,IBRGFN S IBX=-1,DIV=$G(DIV),DDIV=$G(DDIV)
 S IBCS0=$G(^IBE(363.1,+$G(CS),0)),IBRGFN=$P(IBCS0,U,7) I IBCS0="" G CSDVQ
 ;
 I 'IBRGFN S IBX="" G CSDVQ
 I +IBRGFN,+DIV,$D(^IBE(363.31,+IBRGFN,11,"B",DIV)) S IBX=DIV G CSDVQ
 I +IBRGFN,'DIV,+DDIV,$D(^IBE(363.31,+IBRGFN,11,"B",DDIV)) S IBX=DDIV G CSDVQ
 ;
CSDVQ Q IBX
 ;
RT(RT,BT,EFDT,ARR,BE,CT) ; return array of all rate schedules and charge sets for a rate type and bill type and date
 ; EFDT may be passed as 'begin dt^end dt' to get CSs active within a date range, like a bill's date range
 ; output ARR = number of rate schedule-charge set combinations found
 ;        ARR(rate sched IFN,charge set IFN) = 1 if charges for set are auto added
 N IBBEG,IBEND,IBRSFN,IBRS0,IBCSI,IBBE,IBLN,IBAA K ARR S ARR=0,IBBE=""
 S RT=$G(RT),BT=$G(BT),EFDT=$G(EFDT),CT=$G(CT) I +BT S BT=$S(BT<3:1,1:3)
 S (IBBEG,IBEND)="" S IBBEG=+EFDT,IBEND=$S(+$P(EFDT,U,2):+$P(EFDT,U,2),1:IBBEG)
 I $G(BE)'="" S:+BE BE=$$EMUTL^IBCRU1(BE) S IBBE=$$MCCRUTL^IBCRU1(BE,14)
 I IBBE'=0 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,"ARB",+RT,+BT,IBRSFN)) Q:'IBRSFN  D
 . S IBRS0=$G(^IBE(363,+IBRSFN,0)) I +EFDT I (+$P(IBRS0,U,5)>IBEND)!(+$P(IBRS0,U,6)&(+$P(IBRS0,U,6)<IBBEG)) Q
 . S IBCSI=0 F  S IBCSI=$O(^IBE(363,IBRSFN,11,IBCSI)) Q:'IBCSI  D
 .. S IBLN=$G(^IBE(363,IBRSFN,11,IBCSI,0)) Q:'IBLN
 .. S IBAA=$P(IBLN,U,2)
 .. I +IBBE,+$P($G(^IBE(363.1,+IBLN,0)),U,3)'=IBBE Q
 .. I +CT,+$P($G(^IBE(363.1,+IBLN,0)),U,4)'=CT S IBAA=""
 .. S ARR=ARR+1,ARR(IBRSFN,+IBLN)=IBAA
 Q
 ;
BILLRATE(RT,BT,EVDT,FNDRATE) ; return true if the bill is a FND rate bill
 ;  - one of the auto add Charge Sets must be a FND Billing Rate
 N IBRS,IBCS,IBCS0,IBBR0,IBFND,IBRSARR S IBFND=0
 ;
 D RT(+$G(RT),+$G(BT),$G(EVDT),.IBRSARR)
 ;
 I $G(FNDRATE)'="" S IBRS=0 F  S IBRS=$O(IBRSARR(IBRS)) Q:'IBRS  D  Q:IBFND
 . S IBCS=0 F  S IBCS=$O(IBRSARR(IBRS,IBCS)) Q:'IBCS  I +IBRSARR(IBRS,IBCS) D  Q:IBFND
 .. S IBCS0=$G(^IBE(363.1,IBCS,0)),IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0))
 .. I $P(IBBR0,U,1)[FNDRATE S IBFND=1
 ;
 Q IBFND
 ;
PERDIEM(RT,BT,EVDT) ; return true (BR ifn) if the charges for the rate and bill type are perdiem charges
 ; - one of the auto add Charge Sets (except RX or Pros) must be either Tort Liable or Interagency
 N IBRS,IBCS,IBCS0,IBBEVNT,IBBR,IBBRN,IBFND,IBRSARR S IBFND=0
 ;
 D RT(+$G(RT),+$G(BT),$G(EVDT),.IBRSARR)
 ;
 S IBRS=0 F  S IBRS=$O(IBRSARR(IBRS)) Q:'IBRS  D  Q:IBFND
 . S IBCS=0 F  S IBCS=$O(IBRSARR(IBRS,IBCS)) Q:'IBCS  I +IBRSARR(IBRS,IBCS) D  Q:IBFND
 .. S IBCS0=$G(^IBE(363.1,IBCS,0)),IBBR=+$P(IBCS0,U,2),IBBRN=$P($G(^IBE(363.3,+IBBR,0)),U,1)
 .. S IBBEVNT=$$EMUTL^IBCRU1(+$P(IBCS0,U,3)) I (IBBEVNT["PRESCRIPTION")!(IBBEVNT["PROSTHETICS") Q
 .. I (IBBRN["TORTIOUSLY LIABLE")!(IBBRN["INTERAGENCY") S IBFND=IBBR
 ;
 Q IBFND
 ;
EVNTITM(RT,BT,BE,EFDT,ARR) ; return the billable item (363.3, .04) for a particular Rate Type and Billable Event (399.1) auto added
 ; EFDT may be passed as 'begin dt^end dt' to get CSs active within a date range, like a bill's date range
 ; returns:  string of billing items (code;name;quantity) separated by ^ (3;NDC #;3^1;BEDSECTION;1)
 ;           for VA Cost, code = 'VA COST' so returns 'VA COST;VA COST;2'
 ; output (if ARR passed by reference):  ARR(billable item code, rate sched IFN, charge set IFN)="" 
 N IBRS,IBCS,IBRSARR,IBCS0,IBBR0,IBBI,IBFND K ARR S IBFND=""
 ;
 I $G(BE)'="" D RT(+$G(RT),+$G(BT),$G(EFDT),.IBRSARR,$G(BE))
 ;
 S IBRS=0 F  S IBRS=$O(IBRSARR(IBRS)) Q:'IBRS  D
 . S IBCS=0 F  S IBCS=$O(IBRSARR(IBRS,IBCS)) Q:'IBCS  I +IBRSARR(IBRS,IBCS) D
 .. S IBCS0=$G(^IBE(363.1,IBCS,0)),IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0))
 .. S IBBI=$P(IBBR0,U,4) I IBBI="",$P(IBBR0,U,5)=2 S IBBI=$P(IBBR0,U,1)
 .. I IBBI'="" S IBFND=IBFND_IBBI_";"_$$EXPAND^IBCRU1(363.3,.04,IBBI)_";"_$P(IBBR0,U,5)_U,ARR(IBBI,IBRS,IBCS)=""
 Q IBFND

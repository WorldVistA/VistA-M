IBCRU6 ;ALB/ARH - RATES: UTILITIES (SPECIAL GROUPS); 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138,399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CSSG(CS,BR,TYPE,ARR) ; search for special group(s) of TYPE this CS belongs, returns IFN of first group found TYPE
 ; outputs ARR(order)=group ifn ^ groups 0 node, if passed by reference
 N IBBR,IBSGFN,IBSG0,IBSGFN1,IBSG10,IBORDER,IBFND,ARR1 K ARR,ARR1 S IBFND=""
 S IBBR=$G(BR) I 'IBBR S IBBR=+$P($G(^IBE(363.1,+$G(CS),0)),U,2) I 'IBBR G CSSGQ
 ;
 I +IBBR S IBSGFN=0 F  S IBSGFN=$O(^IBE(363.32,IBSGFN)) Q:'IBSGFN  D
 . S IBSG0=$G(^IBE(363.32,IBSGFN,0)) I +$G(TYPE),+$P(IBSG0,U,2)'=TYPE Q
 . S IBSGFN1=0 F  S IBSGFN1=$O(^IBE(363.32,IBSGFN,11,"B",IBBR,IBSGFN1)) Q:'IBSGFN1  D
 .. S IBSG10=$G(^IBE(363.32,IBSGFN,11,IBSGFN1,0)) I +$P(IBSG10,U,2),+$G(CS)'=+$P(IBSG10,U,2) Q
 .. S IBORDER=+$P(IBSG10,U,3) I +IBORDER,+$G(ARR(IBORDER)) S IBORDER=$O(ARR((IBORDER+1)),-1)+.01
 .. I 'IBORDER S IBORDER=1000 I +$G(ARR(IBORDER)) S IBORDER=$O(ARR(99999),-1)+1
 .. I '$G(ARR1(+IBSGFN)) S ARR(IBORDER)=IBSGFN_U_IBSG0,ARR1(+IBSGFN)=1
 S IBORDER=$O(ARR(0)) I +IBORDER S IBFND=+ARR(IBORDER)
CSSGQ Q IBFND
 ;
RVLNK(ITM,BR,CS,ARR) ; return the ifn^revenue code for a particular ITEM as defined by the Billing Rates Revenue Code links
 N IBBR,IBORDER,IBSGFN,IBRV,IBRVD,IBALL,SGARR S IBALL=+$G(ARR),IBRVD="" I '$G(ITM) G RVLNKQ
 S IBBR=$G(BR) I 'IBBR S IBBR=$P($G(^IBE(363.1,+$G(CS),0)),U,2) I 'IBBR G RVLNKQ
 I $P($G(^IBE(363.3,+IBBR,0)),U,4)'=2 G RVLNKQ
 ;
 I +$$CSSG(+$G(CS),IBBR,1,.SGARR) S IBORDER=0 F  S IBORDER=$O(SGARR(IBORDER)) Q:'IBORDER  D  I +IBRVD,'IBALL Q
 . S IBSGFN=+SGARR(IBORDER) I +IBSGFN S IBRV=$$GRVLNK(ITM,IBSGFN,.ARR) I +IBRV,'IBRVD S IBRVD=IBRV
RVLNKQ Q IBRVD
 ;
GRVLNK(ITM,GRP,ARR) ; return the ifn^revenue code for a particular ITEM as defined in a single group
 ; Output:  if ARR=1 on entry and passed by reference, then the array ARR will be defined on output
 ;          ARR(IFN of Rv Cd link in 363.33) = IFN of Rv Cd link in 363.33 ^ revenue code
 ;  (since ranges and specific individual ITEMs can be defined, one ITEM may be set up for more than one revenue
 ;   code, the one used on the bills will be the return value, any others will be in the array)
 ;
 N IBALL,IBRVD,IBXRF,IBRV,IBEND,IBX,IBY,IBC,IBC1,IBC2
 S IBALL=+$G(ARR),IBRVD="",GRP=+$G(GRP),ITM=+$G(ITM) I 'ITM!'GRP G GRVLNKQ
 ;
 S IBXRF="AGP",IBX=$O(^IBE(363.33,IBXRF,GRP,+ITM,0))
 I +IBX S IBRV=+IBX_U_+$G(^IBE(363.33,+IBX,0)),ARR(+IBX)=IBRV,IBRVD=IBRV I 'IBALL G GRVLNKQ
 ;
 I ITM<100000 S IBXRF="AGPE" D  G GRVLNKQ
 . S IBEND=ITM-.1 F  S IBEND=$O(^IBE(363.33,IBXRF,GRP,+IBEND)) Q:'IBEND  D  I +IBRVD,'IBALL Q
 .. S IBX=0 F  S IBX=$O(^IBE(363.33,IBXRF,GRP,+IBEND,IBX)) Q:'IBX  D  I +IBRVD,'IBALL Q
 ... S IBY=$G(^IBE(363.33,IBX,0))
 ... I +$P(IBY,U,3),$P(IBY,U,3)'>ITM S IBRV=+IBX_U_+IBY,ARR(+IBX)=IBRV I 'IBRVD S IBRVD=IBRV
 ;
 I ITM>99999 S IBXRF="AGPE",IBC=$$CODEC^ICPTCOD(ITM) D  G GRVLNKQ
 . S IBEND=99999 F  S IBEND=$O(^IBE(363.33,IBXRF,GRP,+IBEND)) Q:'IBEND  D  I +IBRVD,'IBALL Q
 .. S IBX=0 F  S IBX=$O(^IBE(363.33,IBXRF,GRP,+IBEND,IBX)) Q:'IBX  D  I +IBRVD,'IBALL Q
 ... S IBY=$G(^IBE(363.33,IBX,0))
 ... S IBC1=$$CODEC^ICPTCOD(+$P(IBY,U,3)),IBC2=IBC1 I +$P(IBY,U,4) S IBC2=$$CODEC^ICPTCOD(+$P(IBY,U,4))
 ... I IBC]IBC1,IBC']IBC2 S IBRV=+IBX_U_+IBY,ARR(+IBX)=IBRV I 'IBRVD S IBRVD=IBRV
 ;
GRVLNKQ Q IBRVD
 ;
PRVTYP(PRV,IBDT) ; find the provider type/discount group of a provider on a given date
 ; returns prv type ifn (363.34) ^ provider person class ifn ^ provider type ^ special group ^ percent
 N IBPC,IBPDIFN,IBPD0,IBPT S IBPT="",IBDT=$G(IBDT) I 'IBDT S IBDT=DT
 I +$G(PRV) S IBPC=$$GET^XUA4A72(PRV,IBDT)
 I +$G(IBPC)>0 S IBPDIFN=$O(^IBE(363.34,"D",+IBPC,0)) I +IBPDIFN D
 . S IBPD0=$G(^IBE(363.34,+IBPDIFN,0))
 . S IBPT=+IBPDIFN_U_+IBPC_U_IBPD0
 Q IBPT

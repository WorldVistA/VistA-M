IBCRBH2 ;ALB/ARH - RATES: BILL HELP DISPLAYS - CPT CHARGES ; 01-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
BCPTCHG(IBIFN) ; select a CPT code and display potential charges for a specific bill
 N IB0,IBU,IBBDV,IBCPT,IBCPTN,IBCPT1,IBRS,IBCS,IBCSN,IBEVDT,IBCI,IBLN,IBEFFDT,IBRVCD,IBCHGB,IBFND,CHGARR,ARRCS,DONEARR,IBX
 ;
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""
 S IBU=$G(^DGCR(399,+$G(IBIFN),"U")) Q:'IBU
 S IBBDV=$P(IB0,U,22)
 ;
 W @IOF,!,"Search for Procedure Charges for " I +IBBDV S IBX=$G(^DG(40.8,+IBBDV,0)) W $P(IBX,U,2)," - ",$P(IBX,U,1)
 W !,"--------------------------------------------------------------------------------",!
 ;
 D RT^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IBU,U,1,2),.ARRCS,"PROCEDURE")
 I '$O(ARRCS(0)) W !,"No Rate Schedules with Procedure charges assigned to this bill.",! H 2 Q
 ;
 F  S IBCPT=$$GETCPT^IBCRU1() Q:+IBCPT<1  S IBCPTN=$P(IBCPT,U,1),IBCPT=$P(IBCPT,U,2) W ! D
 . ;
 . S IBRS=0 F  S IBRS=$O(ARRCS(IBRS)) Q:'IBRS  S IBFND=0 D  I +IBFND W !
 .. S IBCS=0 F  S IBCS=$O(ARRCS(IBRS,IBCS)) Q:'IBCS  I +ARRCS(IBRS,IBCS) D  K DONEARR
 ... S IBCSN=$P($G(^IBE(363.1,+IBCS,0)),U,1)
 ... ;
 ... I $$CSDV^IBCRU3(IBCS,IBBDV)<0 Q  ; check division
 ... ;
 ... F IBEVDT=+IBU,+$P(IBU,U,2) I +$$FNDCI^IBCRU4(IBCS,IBCPTN,IBEVDT,.CHGARR) D  K CHGARR
 .... ;
 .... S IBCI=0 F  S IBCI=$O(CHGARR(IBCI)) Q:'IBCI  I '$D(DONEARR(IBCI)) D
 ..... S IBLN=CHGARR(IBCI),DONEARR(IBCI)="",IBFND=1
 ..... S IBEFFDT=$$FMTE^XLFDT(+$P(IBLN,U,3),2)
 ..... S IBCPT1=IBCPT I +$P(IBLN,U,7) S IBCPT1=IBCPT1_"-"_$P($$MOD^ICPTMOD(+$P(IBLN,U,7),"I",IBEFFDT),U,2)
 ..... S IBRVCD=$$RVCPT^IBCROI(+$P(IBLN,U,6),+$P(IBLN,U,1),+$P(IBLN,U,2))
 ..... S IBCHGB="" I +$P(IBLN,U,8) S IBCHGB="+"_$J($P(IBLN,U,8),0,2)
 ..... ;
 ..... W !,?4,IBCPT1,?15,IBEFFDT,?26,IBCSN,?55,$J($P(IBLN,U,5),10,2),IBCHGB,?75,IBRVCD
 . I 'IBFND W ?60,"no charge found...",!
 Q

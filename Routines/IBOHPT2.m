IBOHPT2 ;ALB/EMG  -  ON HOLD CHARGE INFO/PT CONT. ;JULY 22,1997
 ;;2.0; INTEGRATED BILLING ;**70,95,347**; 21-MAR-94;Build 24
REPORT ;
 N IBQUIT,IBPAGE,IBNOW,IBLINE,IBLINE2,IBCRT,IBBOT,IBNAME,IBN,IBDT,IBIFN
 S IBCRT=0,IBBOT=6,IBQUIT=0 I $E(IOST,1,2)="C-" S IBCRT=1,IBBOT=4
 S IBLINE="",$P(IBLINE,"=",86)="||",IBLINE=IBLINE_$E(IBLINE,1,45)
 S IBLINE2="",$P(IBLINE2,"-",75)="--"
 D NOW^%DTC S Y=X X ^DD("DD") S IBNOW=Y
 S IBNAME=$$PT^IBEFUNC(DFN)
 I IBCRT W @IOF
LOOP ;
 ;
 S IBPAGE=1 D HEADER Q:IBQUIT
 S IBDT="" F  S IBDT=$O(^TMP($J,"IB",IBDT)) Q:IBDT=""!(IBDT>0)!(IBQUIT)  D
 .S IBIFN=0 F  S IBIFN=$O(^TMP($J,"IB",IBDT,IBIFN)) Q:'IBIFN!(IBQUIT)  D
 ..D PRNTCHG,PRNTBILL:'IBQUIT
 Q
PRNTBILL ; prints bills for a charge
 N IB,IB0,IBSTAT,IBCHG,IBPD,C,Y,I,IBT,IBPCT
 D:$Y-IBBOT+1>IOSL HEADER Q:IBQUIT
 S IB="" F I=1:1 S IB=$O(^TMP($J,"IB",IBDT,IBIFN,IB)) W:'IB&(I=1) ?85,$S(IBCN:"",1:"||"),! D:$Y+IBBOT>IOSL HEADER Q:'IB!(IBQUIT)  D
 .W ?85,"||"
 .S IB0=$G(^DGCR(399,IB,0)) Q:IB0=""
 .W ?88,$P(IB0,"^",1) ; bill #
 .W ?97,$$BCHGTYPE^IBCU(+IB)
 .S IBSTAT=$P($$ARSTATA^IBJTU4(+IB),U,2)
 .W ?110,IBSTAT
 .S IBT=$J((+^DGCR(399,IB,"U1")-$P(^("U1"),"^",2)),9,2)
 .W ?113,IBT ; total charges
 .S IBPCT=$P($$BILL^RCJIBFN2(IB),"^",5) W ?128,$J(IBPCT,3,0)_"%",! D:$Y+IBBOT>IOSL HEADER
 Q
 ;
PRNTCHG ; prints a charge
 N IBACT,IBAR,IBARIFN,IBARST,IBARTR,IBTYPE,IBBILL,IBFR,IBTO,IBCHG,IBND,IBND1,IBST,IBARBN,IBAREN
 N IBRX,IBRXN,IBRF,IBRDT,IBX,IENS
 S IBND=$G(^IB(IBIFN,0)),IBND1=$G(^IB(IBIFN,1)),(IBCN,IBX)=0
 S (IBRX,IBRXN,IBRF,IBRDT)=0
 ; action id
 S IBACT=+IBND
 ; type
 S X=$P($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")," ",2,99)
 S IBTYPE=$E($P(X," ",1,$L(X," ")-1),1,6)
 ; bill #
 S IBBILL=$P($P(IBND,"^",11),"-",2)
 S IBARBN=$P(IBND,"^",11)
 ; rx info
 I $P(IBND,"^",4)["52:" S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 I $P(IBND,"^",4)["52:"  D
 .I IBRF>0 S IENS=+IBRF,IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,+IENS,52,.01)
 .E  S IENS=+IBRXN,IBRDT=$$FILE^IBRXUTL(+IENS,22)
 S IBX=$$APPT^IBCU3(IBRDT,DFN)
 ; service date
 S IBFR=$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,1:$P(IBND,"^",15)))
 ; release to ar date
 ;S IBAR=$$DAT1^IBOUTL($S($P(IBND,"^",14)'="":$P(IBND,"^",14),1:$P(IBND1,"^",4)))
 S IBAR=$S($P(IBND,"^",11):$$DAT1^IBOUTL($P(IBND1,"^",4)),1:"")
 ; ib status
 S IBST=$E($P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",2),1,6)
 ; charge$
 S IBCHG=$J(+$P(IBND,"^",7),9,2)
 S IBARTR=$S($P(IBND,"^",12):$P(IBND,"^",12),1:"")
 ; ar status
 ;S IBARST=$S(IBARTR]"":$E($P($$STNO^RCJIBFN2($$STAT^RCJIBFN2(IBIFN)),"^"),1,6),1:"")
 S IBAREN=$S(IBARTR]"":$O(^PRCA(430,"B",IBARBN,0)),1:"")
 S IBARST=$S(IBAREN]"":$E($P($$STNO^RCJIBFN2($$STAT^RCJIBFN2(IBAREN)),"^"),1,6),1:"")
 ;
 ; write data
 W IBACT,?15,IBTYPE,?28,IBBILL W:IBRX>0 ?38,"Rx #: "_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),?85,"||",!
 W:IBX=1 ?37,"*"
 W ?38,IBFR,?48,IBAR,?58,IBCHG,?70,IBARST,?79,IBST
 I $P(IBND,"^",5)=10 S IBCN=1 W ?85,"|| REASON: ",$P($G(^IBE(350.3,+$P(IBND,"^",10),0)),"^"),!
 Q
HEADER ; writes the report header
 Q:IBQUIT
 I IBCRT,$Y>1 D  Q:IBQUIT
 .F  Q:$Y>(IOSL-3)  W !
 .N T R "    Press RETURN to continue",T:DTIME I '$T!(T["^") S IBQUIT=1 Q
 I IBPAGE>1 W !,@IOF
 W "List of all HELD bills for ",$P(IBNAME,"^"),"  SSN: ",$P(IBNAME,"^",2),?110,IBNOW,"  PAGE ",IBPAGE,!,"PATIENT CHARGES",?87,"CORRESPONDING THIRD PARTY BILLS",!,IBLINE
 W !,?38,"From/",?48,"Date",?70,"AR",?79,"IB",?85,"||",?110,"AR"
 W !,"Action ID",?15,"Type",?28,"Bill#",?38,"Fill Dt",?48,"to AR",?61,"Charge",?70,"Status",?79,"Status",?85,"||",?88,"Bill#",?97,"Classf($Typ)",?110,"ST",?116,"Charge",?126,"% Paid"
 W !,IBLINE,!
 W:IBIBRX ?36,"'*' = outpt visit on same day as Rx fill date",?85,"||",!,IBLINE,!
 S IBPAGE=IBPAGE+1
 Q

IBOHLD2 ;ALB/CJM  -  REPORT OF CHARGES ON HOLD W/INS ;MAR 6,1991
 ;;2.0;INTEGRATED BILLING;**70,95,133,153,347**;21-MAR-94;Build 24
REPORT ;
 N IBQUIT,IBPAGE,IBNOW,IBLINE,IBLINE2,IBCRT,IBBOT,DFN,IBNAME,IBN
 S IBCRT=0,IBBOT=7,IBQUIT=0 I $E(IOST,1,2)="C-" S IBCRT=1,IBBOT=7
 S IBLINE="",$P(IBLINE,"=",86)="||",IBLINE=IBLINE_$E(IBLINE,1,45)
 S IBLINE2="",$P(IBLINE2,"-",75)="--"
 D NOW^%DTC S Y=X X ^DD("DD") S IBNOW=Y
 I IBCRT W @IOF
LOOP ;
 S IBPAGE=1 D HEADER Q:IBQUIT
 S IBNAME="" F  S IBNAME=$O(^TMP($J,"HOLD",IBNAME)) Q:IBNAME=""!(IBQUIT)  S DFN=0 F  S DFN=$O(^TMP($J,"HOLD",IBNAME,DFN)) Q:'DFN!(IBQUIT)  D
 .D PRNTPAT,PRNTINS W:IBII ?35,IBLINE2,! Q:IBQUIT  S IBN=0 F  S IBN=$O(^TMP($J,"HOLD",IBNAME,DFN,IBN)) Q:'IBN!(IBQUIT)  D
 ..D PRNTCHG,PRNTBILL:'IBQUIT
 Q
PRNTBILL ; prints bills for a charge
 N IB,IB0,IBSTAT,IBCHG,IBPD,C,Y,I,IBT
 D:$Y+IBBOT>IOSL HEADER Q:IBQUIT
 S IB="" F I=1:1 S IB=$O(^TMP($J,"HOLD",IBNAME,DFN,IBN,IB)) W:'IB&(I<2) ?85,"||",! Q:'IB!(IBQUIT)  D
 .W ?85,"||"
 .S IB0=$G(^DGCR(399,IB,0)) Q:IB0=""
 .W ?88,$P(IB0,"^",1) ; bill #
 .S IBSTAT=$$STA^PRCAFN(IB)
 .W:+IBSTAT>0 ?97,$E($P(IBSTAT,"^",2),1,14)
 .S IBT=$J((+^DGCR(399,IB,"U1")-$P(^("U1"),"^",2)),9,2)
 .W ?112,IBT ; total charges
 .S IBPD=$$TPR^PRCAFN(IB) S:IBPD<0 IBPD="" S IBPD=$J(IBPD,9,2) W ?123,IBPD,! D:$Y+IBBOT>IOSL HEADER
 Q
PRNTPAT ; prints patient data
 N VAERR,VADM,IBSSN D DEM^VADPT S:'VAERR IBSSN=VA("BID") ; pt id,brief
 D:$Y+IBBOT>IOSL HEADER Q:IBQUIT
 W IBLINE,!
 W $E(IBNAME,1,20),?22,IBSSN
 W:IBII ?35,"Insurance Co.",?53,"Subscriber ID",?71,"Group",?88,"Eff Dt",?102,"Exp Dt",!
 Q
PRNTINS ; prints insurance information
 Q:'$D(DFN)!(IBII=0)
 N X,IBINS,IBX
 D ALL^IBCNS1(DFN,"IBINS")
 D:$Y+IBBOT>IOSL HEADER Q:IBQUIT
 W IBLINE,!
 I '$D(IBINS) W ?35,"No Insurance Information"
 S X=0 F  S X=$O(IBINS(X)) Q:'X  S IBINS=IBINS(X,0) D
 .D:$Y+IBBOT>IOSL HEADER Q:IBQUIT
 .N COV,COVD,COVFN,IBCNT,LEDT,LIM,PLN,SP,X,X1,X2,Z0 Q:'$D(IBINS)
 .W ?36,$S($D(^DIC(36,+IBINS,0)):$E($P(^(0),"^",1),1,16),1:"UNKNOWN")
 .W ?54,$E($P(IBINS,"^",2),1,16)
 .W ?72,$E($$GRP($P(IBINS,"^",18)),1,10) S PLN=$P(IBINS,"^",18)
 .W ?88,$$DAT1^IBOUTL($P(IBINS,"^",8)),?102,$$DAT1^IBOUTL($P(IBINS,"^",4))
 .I PLN="" W !,?38,"* No Group Plan Information for this Patient - Verify Insurance Info!",! Q
 .W !,?40,"Plan Coverage   Effective Date   Covered?     Limit Comments",!
 .W ?40,"-------------   --------------   --------     --------------",!
 .S LIM=0 F  S LIM=$O(^IBE(355.31,LIM)) Q:'LIM  S COV=$P($G(^(LIM,0)),U),IBCNT=0,LEDT="" F  S LEDT=$O(^IBA(355.32,"APCD",PLN,LIM,LEDT)) Q:$S(LEDT="":IBCNT,1:0)  D  Q:LEDT=""
 ..D:$Y+IBBOT>IOSL HEADER Q:IBQUIT
 ..S COVFN=+$O(^IBA(355.32,"APCD",PLN,LIM,+LEDT,"")),COVD=$G(^IBA(355.32,+COVFN,0))
 ..I COVD="" W ?40,COV,?86,"BY DEFAULT",! Q
 ..S IBCNT=IBCNT+1
 ..S X1="  "_$S(IBCNT=1:COV,1:"") ;Don't duplicate category
 ..S X2=$$PR(X1,18)_$$PR($$DAT1^IBOUTL($P(LEDT,"-",2)),16)_$$PR($S($P(COVD,U,4):$S($P(COVD,U,4)<2:"YES",$P(COVD,U,4)=2:"CONDITIONAL",1:"UNKNOWN"),1:"NO"),14)
 ..I '$O(^IBA(355.32,COVFN,2,0)) W ?40,X2,! Q
 ..S Z0=0 F  S Z0=$O(^IBA(355.32,COVFN,2,Z0)) Q:'Z0  S SP="" W ?40,$S(Z0=1:X2_$G(^IBA(355.32,COVFN,2,Z0,0)),1:$$PR(SP,48)_$G(^IBA(355.32,COVFN,2,Z0,0))),!
 Q
GRP(IBCPOL) ; get group name/group policy
 N X,Y S X=""
 S X=$G(^IBA(355.3,+$G(IBCPOL),0))
 S Y=$S($P(X,"^",4)'="":$P(X,"^",4),1:$P(X,"^",3))
 I $P(X,"^",10) S Y="Ind Plan "_Y
GRPQ Q Y
PR(STR,LEN) ; pad right
 N B S STR=$E(STR,1,LEN),$P(B," ",LEN-$L(STR))=" "
 Q STR_$G(B)
PRNTCHG ; prints a charge
 N IBACT,IBTYPE,IBBILL,IBFR,IBTO,IBCHG,IBND,IBND1
 N IBRX,IBRXN,IBRF,IBRDT,IBX,IENS
 S IBND=$G(^IB(IBN,0))
 S IBND1=$G(^IB(IBN,1))
 S (IBRX,IBRXN,IBRF,IBRDT,IBX)=0
 ; action id
 S IBACT=+IBND
 ; type
 S IBTYPE=$P(IBND,"^",3),IBTYPE=$P($G(^IBE(350.1,IBTYPE,0)),"^",1),IBTYPE=$S(IBTYPE["PSO NSC":"RXNSC",IBTYPE["PSO SC":"RX SC",1:$E(IBTYPE,4,7))
 ; bill #
 S IBBILL=$P($P(IBND,"^",11),"-",2)
 ; rx info
 I $P(IBND,"^",4)["52:" S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 I $P(IBND,"^",4)["52:"  D
 .I +IBRF>0  D
 ..S IENS=+IBRF
 ..S IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,+IENS,52,.01)
 .I +IBRF=0  D
 ..S IENS=+IBRXN
 ..S IBRDT=$$FILE^IBRXUTL(+IENS,22)
 S IBX=$$APPT^IBCU3(IBRDT,DFN)
 ; from/rx fill date
 S IBFR=$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,1:$P(IBND,"^",15)))
 ; to date
 S IBTO=$$DAT1^IBOUTL($S($P(IBND,"^",15)'="":($P(IBND,"^",15)),1:$P(IBND1,"^",2)))
 ; charge$
 S IBCHG=$J(+$P(IBND,"^",7),9,2)
 W ?29,IBACT,?39,IBTYPE,?46,IBBILL W:IBRX>0 ?55,"Rx #: "_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),?85,"||",!
 W:IBX=1 ?54,"*"
 W ?55,IBFR,?66,IBTO,?75,IBCHG
 Q
HEADER ; writes the report header
 Q:IBQUIT
 I IBCRT,$Y>1 D  Q:IBQUIT  ;F  Q:$Y>(IOSL-1)  W !
 .W ! N T R "    Press RETURN to continue",T:DTIME I '$T!(T["^") S IBQUIT=1 Q
 I IBPAGE>1 W !,@IOF
 W ?53,"MEANS TEST CHARGES ON HOLD",?110,IBNOW,"  PAGE ",IBPAGE,!,"HELD CHARGES",?87,"CORRESPONDING THIRD PARTY BILLS",!,IBLINE
 W !,"Name",?22,"Pt.ID",?29,"Act.ID",?39,"Type",?46,"Bill#",?55,"Fr/Fl Dt",?66,"To/Rls Dt",?78,"Charge",?85,"||",?88,"Bill#",?97,"AR-Status",?115,"Charge",?128,"Paid"
 W !,IBLINE,!
 W ?20,"'*' = outpt visit on same day as Rx fill date",?85,"||",!,IBLINE,!
 S IBPAGE=IBPAGE+1
 Q

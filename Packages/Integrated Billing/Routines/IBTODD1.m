IBTODD1 ;ALB/AAS - CLAIMS TRACKING DENIED DAYS REPORT ; 27-OCT-93
 ;;2.0;INTEGRATED BILLING;**32,458**;21-MAR-94;Build 4
 ;
% I '$D(DT) D DT^DICRW
PRINT ; -- print data
 ; -- ^tmp($j,"ibtodd",event type,primary sort,secondary sort,ibtrc)=DFN ^ attending ^ treating specialty ^ service ^ ^ billing rate
 ;
 K IBCNT,IBEVNTYP,IBCNTO
 ;
 S IBEVNTYP=0 F  S IBEVNTYP=$O(^TMP($J,"IBTODD",IBEVNTYP)) Q:'IBEVNTYP!(IBQUIT)  D
 .I 'IBSUM D HDR
 .I 'IBSUM,$O(^TMP($J,"IBTODD",IBEVNTYP,""))="" W !!,"No Denials Found in Date Range." Q
 .S IBI="",IBISV=""
 .F  S IBI=$O(^TMP($J,"IBTODD",IBEVNTYP,IBI)) Q:IBI=""!(IBQUIT)  D
 ..I IBSORT'="P",IBISV'=IBI D SUBT^IBTODD2
 ..S IBISV=IBI D SUBH^IBTODD2(IBI) Q:IBQUIT
 ..S IBJ="" F  S IBJ=$O(^TMP($J,"IBTODD",IBEVNTYP,IBI,IBJ)) Q:IBJ=""!(IBQUIT)  D
 ...S IBTRC=""
 ...F  S IBTRC=$O(^TMP($J,"IBTODD",IBEVNTYP,IBI,IBJ,IBTRC)) Q:IBTRC=""!(IBQUIT)  S IBDATA=^(IBTRC) D ONE
 .I 'IBSUM D SUBT^IBTODD2
 ;
 I IBQUIT G PRINTQ
 D SUM^IBTODD2
 ;
PRINTQ Q
 ;
ONE ; -- print one entry
 ; -- ^tmp($j,"ibtodd",event type,primary sort,secondary sort,ibtrc)=DFN ^ attending ^ treating specialty ^ service ^ ^ billing rate
 ;
 S IBAPL=$$APPEAL(IBTRC)
 D CNTS
 S IBTALL=+$P($G(^IBT(356.2,+IBTRC,1)),"^",7) ;entire admission denied
 Q:IBSUM
 ;
 I IOSL<($Y+6) D HDR,SUBH^IBTODD2(IBI)
 S DFN=+IBDATA D PID^VADPT
 S IBTRCD=$G(^IBT(356.2,+IBTRC,0))
 I IBEVNTYP'=1 G LO
 ;
L1 W !,$E($P(^DPT(DFN,0),"^"),1,19),?22,VA("BID")
 S IBCDT=$$CDT($P(IBTRCD,"^",2))
 W ?28,$$DAT1^IBOUTL(+IBCDT\1) W:$P(IBCDT,"^",2) " to"
 W ?40,$J($P(IBDATA,"^",2),8)
 I IBTALL W ?54,"ALL"
 I 'IBTALL W ?54,$$DAT1^IBOUTL($P(IBTRCD,"^",15),"2P") W:$P(IBTRCD,"^",16) " to"
 I IBTALL!('$P(IBTRCD,"^",16)) W " (",$P(IBDATA,"^",7),")"
 K IBDEN,IBC S IBDEN=0,IBC=0
 F  S IBDEN=$O(^IBT(356.2,+IBTRC,12,IBDEN)) Q:'IBDEN  S IBC=IBC+1,IBC(IBC)=^(IBDEN,0)
 W:$G(IBC(1)) ?68,$E($$EXPAND^IBTRE(356.212,.01,+IBC(1)),1,25)
 W ?98,$S(+$P(IBAPL,"^",2):"YES",1:"NO")
 W ?103,$J(+IBAPL,8)
 W ?116,$E($$EXPAND^IBTRE(42.4,3,$P(IBDATA,"^",4)),1,4) W:$P(IBDATA,"^",4)="" "UNKN"
 W ?120,$$CHRG(+$P(IBDATA,"^",6))
 ;
 ;
L2 W !?28,$$DAT1^IBOUTL($P(IBCDT,"^",2)\1,"2P")
 W ?54,$$DAT1^IBOUTL($P(IBTRCD,"^",16),"2P")
 I 'IBTALL,$P(IBTRCD,"^",16) W " (",$P(IBDATA,"^",7),")"
 W ?68,$E($$EXPAND^IBTRE(356.212,.01,$G(IBC(2))),1,25)
 ;
 I $O(IBC(2)) S IBDEN=2 F  S IBDEN=$O(IBC(IBDEN)) Q:'IBDEN  W !?70,$E($$EXPAND^IBTRE(356.212,.01,$G(IBC(IBDEN))),1,25)
ONEQ W !
 Q
 ;
LO ; -- print one line for non-inpatient
 W !,$E($P(^DPT(DFN,0),"^"),1,19),?22,VA("BID")
 S IBCDT=$P($G(^IBT(356,+$P(IBTRCD,U,2),0)),U,6)
 W ?28,$$FMTE^XLFDT(+IBCDT,2)
 W ?50,$P(IBTRCD,"^",26)
 W ?78,$S(+$P(IBAPL,"^",2):"YES",1:"NO")
 W ?88,$S(+IBAPL:"YES",1:"NO")
 W ?98,$$CHRG(+$P(IBDATA,"^",6))
 Q
 ;
 ;
CNTS ; -- develop summary data
 S IBSERV=$P(IBDATA,"^",4)
 I IBSERV="" S IBSERV="UNKNOWN"
 S IBSUBT=$G(IBSUBT)+$P(IBDATA,"^",7)
 ;
 I IBEVNTYP=1 D
 .S:'$D(IBCNT(IBSERV)) IBCNT(IBSERV)=""
 .S $P(IBCNT(IBSERV),"^")=$P(IBCNT(IBSERV),"^")+$P(IBDATA,"^",7)
 .S $P(IBCNT(IBSERV),"^",2)=$P(IBCNT(IBSERV),"^",2)+$P(IBDATA,"^",6)
 .S $P(IBCNT(IBSERV),"^",3)=$P(IBCNT(IBSERV),"^",3)+1
 .S $P(IBCNT(IBSERV),"^",4)=$P(IBCNT(IBSERV),"^",4)+$G(IBAPL)
 .;S:$P(IBCNT(IBSERV),"^",6)<$P(IBDATA,"^",6) $P(IBCNT(IBSERV),"^",6)=$P(IBDATA,"^",6)
 .S IBTOTL=$G(IBTOTL)+$P(IBDATA,"^",7)
 ;
 I IBEVNTYP'=1 D
 .S:'$D(IBCNTO(IBSERV)) IBCNTO(IBSERV)=""
 .S $P(IBCNTO(IBSERV),"^",2)=$P(IBCNTO(IBSERV),"^",2)+$P(IBDATA,"^",6)
 .S $P(IBCNTO(IBSERV),"^",3)=$P(IBCNTO(IBSERV),"^",3)+1
 .S $P(IBCNTO(IBSERV),"^",4)=$P(IBCNTO(IBSERV),"^",4)+$P($G(IBAPL),U,2)
 .S $P(IBCNTO(IBSERV),"^",5)=$P(IBCNTO(IBSERV),"^",5)+$G(IBAPL)
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT  N IBEVO S IBEVO=$P($G(^IBE(356.6,+IBEVNTYP,0))," ",1)
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"MCCR/UR DENIED DAYS "_IBEVO_" Denials Dated ",$$FMTE^XLFDT(IBBDT),$S(IBBDT'=IBEDT:" to "_$$FMTE^XLFDT(IBEDT),1:""),"  "
 W ?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 I $G(IBEVNTYP)'=1 G HDRO
 W !!,?28,"Dates of",?54,"Dates",?103,"Days Approved"
 W !,"Patient",?22,"PtID",?28,"Care",?40,"Attending",?54,"Denied",?68,"Denial Reason",?94,"Appealed",?105,"on Appeal",?116,"SRVS",?125,"Amount"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
HDRO ; -- Print Header for non-Inpatient denials
 W !!,"Patient",?22,"PtID",?28,"Episode Date",?50,"Outpatient Treatment",?75,"Appealed",?85,"Approved",?103,"Amount"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
CDT(IBTRN) ; -- compute dates of care
 N X,Y S X=$G(^IBT(356,+IBTRN,0)),Y=""
 I $P(X,"^",5) S DGPM=$G(^DGPM($P(X,"^",5),0)) D
 .S Y=+DGPM
 .I $P(DGPM,"^",17) S Y=Y_"^"_+$G(^DGPM($P(DGPM,"^",17),0))
 I 'Y S Y=$P(X,"^",6)
 Q Y
 ;
APPEAL(IBTRC) ; -- Find appeals
 N X,Y,IBAPEAL,IBTRN,IBTRSV S (Y,X)=0
 S IBTRSV=IBTRC
 S IBTRC=0 F  S IBTRC=$O(^IBT(356.2,"AP",+IBTRSV,IBTRC)) Q:'IBTRC  S Y=1,X=X+$$AP(IBTRC)
 ;
 Q X_"^"_Y
 ;
AP(IBTRC) ; -- count days approved
 N X,Y,Z,AP,EV
 S (X,Z)=0
 S AP=$G(^IBT(356.2,+IBTRC,0)),EV=+$P($G(^IBT(356,+$P(AP,U,2),0)),U,18)
 I EV>1,EV<5,+$P(AP,U,29),+$P(AP,U,29)'=2 S Z=1
 I 'Z F  S X=$O(^IBT(356.2,+IBTRC,14,X)) Q:'X  S Y=$G(^(X,0)),Z=Z+$$FMDIFF^XLFDT($P(Y,"^",2),+Y)+1
 Q Z
 ;
CHRG(D) ; return charge for output
 N X,X2 S X=+$G(D),X2="0$" D COMMA^%DTC
 Q X

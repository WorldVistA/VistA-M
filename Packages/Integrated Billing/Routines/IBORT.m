IBORT ;ALB/MRL,SGD - MAS BILLING TOTALS REPORT  ;25 MAY 88 09:10
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;MAP TO DGCRORT
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBORT-1" D T0^%ZOSV ;start rt clock
 N IBDTP,IBIDX
 S:'$D(U) U="^" S:'$D(DTIME) DTIME=600 I '$D(DT) S X="T",DT="" D ^%DT S DT=Y K X,Y,^UTILITY($J)
SELECT ; chose the date type to select by
 S DIR(0)="S^1:EVENT DATE;2:BILL DATE"
 S DIR("A")="SELECT BILLS BY",DIR("B")=1,DIR("?")="^D HELP^IBORT"
 D ^DIR K DIR Q:$D(DIRUT)
 S IBDTP=$S(Y=1:"EVENT",Y=2:"BILL",1:"") Q:IBDTP=""
DATE S %DT="AEPX",%DT("A")="Start with "_IBDTP_" DATE: " D ^%DT G Q:Y<0 S IBBEG=Y I IBBEG>DT W *7," ??",!,"Date must be in the past." G DATE
DATE1 S %DT="EPX" R !,"Go to DATE: ",X:DTIME S:X=" " X=IBBEG G Q:(X="")!(X["^") D ^%DT G DATE1:Y<0 S IBEND=Y I IBEND<IBBEG W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G DATE1
 I IBEND>DT W *7," ??",!,"Date must be in the past." G DATE1
 ;
 W !!,*7,"*** Margin width of this output is 132 ***"
 ;S DGPGM="BEGIN^IBORT",DGVAR="IBBEG^IBEND^DUZ^IBDTP" D ZIS^DGUTQ G Q:POP U IO
 S %ZIS="QM" D ^%ZIS G:POP Q
 ;
 I $D(IO("Q")) K IO("Q") D  G Q
 .S ZTRTN="BEGIN^IBORT",ZTSAVE("IB*")="",ZTDESC="IB - BILLING TOTALS REPORT"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBORT" D T1^%ZOSV ;stop rt clock
BEGIN ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBORT-2" D T0^%ZOSV ;start rt clock
 S (IBL,IBL1)="",$P(IBL,"_",131)="",$P(IBL1,"=",131)="",Y=IBBEG X ^DD("DD") S IBHD="for "_$S(IBBEG'=IBEND:"period covering ",1:"")_Y I IBBEG<IBEND S Y=IBEND X ^DD("DD") S IBHD=IBHD_" through "_Y
 S X1=IBBEG,X2=-1 D C^%DTC S IBD=X_.9999,IBD1=IBEND_.2359,IBNEX=0
 F I=0:0 S IBNEX=$O(^DGCR(399.3,IBNEX)) Q:'IBNEX  S IBX=$P(^(IBNEX,0),"^",1),^UTILITY($J,"IB","T",IBX)="",^UTILITY($J,"IB","T1",IBX)=""
 S ^UTILITY($J,"IB","TT")="",^("TS")="",^UTILITY($J,"IB","T","UNKNOWN")="",^UTILITY($J,"IB","T1","UNKNOWN")=""
 S IBIDX=$S(IBDTP="BILL":"AP",1:"D")
 F I=0:0 S IBD=$O(^DGCR(399,IBIDX,IBD)) Q:'IBD!(IBD>IBD1)  S DFN="" F J=0:0 S DFN=$O(^DGCR(399,IBIDX,IBD,DFN)) Q:'DFN  I $D(^DGCR(399,+DFN,0)) S IB=^(0) I $P(IB,"^",1)'="",$P(IB,"^",3) D SET^IBORT1
 S IBB=1,X=132 X ^%ZOSF("RM") D HEAD S IBNEX=0 F I=0:0 S IBNEX=$O(^UTILITY($J,"IB","T",IBNEX)) Q:IBNEX=""  S IBP=^(IBNEX) W !,IBNEX F I1=1:2:7 D WRITE
 W !,IBL,!,"TOTALS" S IBP=^UTILITY($J,"IB","TT") F I1=1:2:7 D WRITE
 S IBB=0 D HEAD S IBNEX=0 F I=0:0 S IBNEX=$O(^UTILITY($J,"IB","T1",IBNEX)) Q:IBNEX=""  S IBP=^(IBNEX) W !,IBNEX F I1=1:2:7 D WRITE
 W !,IBL,!,"PENDING TOTALS" S IBP=^UTILITY($J,"IB","TS") F I1=1:2:7 D WRITE
Q K X,X1,X2,Y,I,I1,J,DFN,IB,IBTOT,IBN1,IBN2,%DT,%,IBD,IBD1,IBHD,IBNEX,IBP,IBTAB,IBX,POP,IBBEG,IBEND,IBL,IBL1,IBB,IBS,^UTILITY($J),IBDTP,IBIDX
 I '$D(ZTQUEUED) D ^%ZISC
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBORT" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
WRITE S IBTAB=$S(I1=1:34,I1=3:59,I1=5:84,1:109),IBN1=+$P(IBP,"^",I1),IBN2=+$P(IBP,"^",I1+1) W ?IBTAB,$J(IBN1,5) S X=IBN2,X2="2$" D COMMA^%DTC S X=X_"|" W ?(IBTAB+7),$J(X,15)
 Q
HEAD W !,@IOF,! D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") W ?94,"Date/Time Printed: ",Y,!!,$S(IBB:"Billing Summary Report ",1:"Summary of Pending Bill Authorizations "),IBHD," (by "_$S(IBDTP="EVENT":"Event Date)",1:"Date Billed)")
 W !,IBL,!
 I IBB W ?39,"INITIATED",?55,"|",?65,"PENDING",?80,"|",?89,"PRINTED",?105,"|",?114,"CANCELLED",?130,"|"
 E  W ?38,"TOTAL PENDING",?55,"|",?64,"NO ACTION",?80,"|",?89,"REVIEWED",?105,"|",?114,"AUTHORIZED",?130,"|"
 W !,"BILL TYPE" F IBTAB=33,58,83,108 W ?IBTAB,"Number         Dollars|"
 W !,IBL1 Q
HELP ; help for date type selection
 W !!,"EVENT DATE is the date beginning the bill's episode of care"
 W !!,"BILL DATE is the date the bill was initially printed"
 Q

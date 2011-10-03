IBORT1 ;ALB/MRL,SGD - MAS BILLING TOTALS REPORT (CONT.)  ;03 JUN 88 09:15
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;MAP TO DGCRORT1
 ;
 Q
SET S IBTOT=$S('$D(^DGCR(399,DFN,"U1")):0,$P(^DGCR(399,DFN,"U1"),"^",2)]"":$P(^DGCR(399,DFN,"U1"),"^",1)-$P(^DGCR(399,DFN,"U1"),"^",2),1:$P(^DGCR(399,DFN,"U1"),"^",1))
 S IBS=$S($D(^DGCR(399,DFN,"S")):^("S"),1:""),X=$S($D(^DGCR(399.3,+$P(IB,"^",7),0)):$P(^(0),"^",1),1:"UNKNOWN"),IBT=^UTILITY($J,"IB","T",X),IBT1=^UTILITY($J,"IB","T1",X)
 S IBX1=$S($P(IBS,"^",17):11,$P(IBS,"^",14):9,$P(IBS,"^",10):7,$P(IBS,"^",7):5,$P(IBS,"^",4):5,1:3)
 S $P(IBT,"^",1)=$P(IBT,"^",1)+1,$P(IBT,"^",2)=$P(IBT,"^",2)+IBTOT S IBX2=$S(IBX1=9:5,IBX1=11:7,1:3),IBX3=$S(IBX2'=3:0,1:IBX1)
 I IBX3 S $P(IBT1,"^",1)=$P(IBT1,"^",1)+1,$P(IBT1,"^",2)=$P(IBT1,"^",2)+IBTOT,$P(IBT1,"^",IBX3)=$P(IBT1,"^",IBX3)+1,$P(IBT1,"^",IBX3+1)=$P(IBT1,"^",IBX3+1)+IBTOT
 S $P(IBT,"^",IBX2)=$P(IBT,"^",IBX2)+1,$P(IBT,"^",IBX2+1)=$P(IBT,"^",IBX2+1)+IBTOT S ^UTILITY($J,"IB","T",X)=IBT,^UTILITY($J,"IB","T1",X)=IBT1
 S IBT=^UTILITY($J,"IB","TT"),IBT1=^UTILITY($J,"IB","TS") S $P(IBT,"^",1)=$P(IBT,"^",1)+1,$P(IBT,"^",2)=$P(IBT,"^",2)+IBTOT
 S $P(IBT,"^",IBX2)=$P(IBT,"^",IBX2)+1,$P(IBT,"^",IBX2+1)=$P(IBT,"^",IBX2+1)+IBTOT
 I IBX3 S $P(IBT1,"^",1)=$P(IBT1,"^",1)+1,$P(IBT1,"^",2)=$P(IBT1,"^",2)+IBTOT,$P(IBT1,"^",IBX3)=$P(IBT1,"^",IBX3)+1,$P(IBT1,"^",IBX3+1)=$P(IBT1,"^",IBX3+1)+IBTOT
 S ^UTILITY($J,"IB","TT")=IBT,^("TS")=IBT1 Q
 Q

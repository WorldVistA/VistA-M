DGMTDOM ;ALB/TET,RMO - Check if DOM/NH patient requires a means test ;6/1/92 10:00  am
 ;;5.3;Registration;**61**;Aug 13, 1993
 ;
EN ;Entry point from the movement event driver
 N DGMSGF,DGREQF
 ;I DGPMP="",$P(DGPMA,"^",2)=2,"^13^44^"[("^"_$P(DGPMA,"^",18)_"^") I $$CK(DGPMA) S DGMSGF=1 D EN^DGMTR D DIS^DGMTU(DFN)
 S DGMSGF=1 D EN^DGMTR I '$G(DGQUIET) D DIS^DGMTU(DFN)
 Q
 ;
CK(X) ;Check if patient is being transferred from a DOM or NH
 N Y
 I $D(^DGPM(+$P(X,"^",14),0)),$D(^DIC(42,+$P(^(0),"^",6),0)) S:$P(^(0),"^",3)="D"!($P(^(0),"^",3)="NH") Y=1
 Q +$G(Y)

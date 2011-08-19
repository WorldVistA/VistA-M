IBTRE0 ;ALB/AAS - CLAIMS TRACKING - COMPUTE DEFAULTS, TRIGGERS ; 27-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRE
 ;
ADT(IBTRN) ; -- compute default admission type
 ; -- called from trigger from event type field
 ;    returns default in internal 1 = scheduled, 2 = urgent 
 ;
 N X,Y,IBX
 S X=""
 S IBX=$G(^IBE(356.6,+$P(^IBT(356,IBTRN,0),"^",18),0))
 I $P(IBX,"^",3)>1 G ADTQ
 I $P(IBX,"^")["SCHEDULED" S X=1 G ADTQ ;default = scheduled
 I $P(IBX,"^")["INPATIENT" S X=2 G ADTQ ;default = urgent
ADTQ Q X

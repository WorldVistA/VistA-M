IBRFN2 ;ALB/AAS - PASS INSURANCE/BEDSECTION DATA TO A/R FOR MCCR/NDB ; 8-OCT-93
 ;;2.0;INTEGRATED BILLING;**75,80,345**;21-MAR-94;Build 28
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CRIT(IBIFN) ; Pass AR insurance data for MCCR/NDB
 ;         Input:    IBIFN -- Internal entry of Bill (ptr to #399)
 ;                            (should be same as ptr to 430)
 ;
 ;         Returns:  piece 1 = criteria 3 (type of policy)
 ;                   piece 2 = criteria 4 (how policy identified)
 ;                   piece 3 = criteria 5 (primary bedsection of bill)
 ;            see table below for values
 ;
 ;  -------------------------------------------------------------------
 ; |       |              Numeric Value                                |
 ; |-------|-----------------------------------------------------------|
 ; | Piece |        1       |       2      |      3      |       4     |
 ; |-------|----------------|--------------|-------------|-------------|
 ; |   1   |  Full Medical  | Medicare Sup |  *Other     |       -     |
 ; |   2   | *By interview  | By Data Match|   by IVM    |by pre-regist|
 ; |   3   |    Medical     |   Surgical   | Pschiatric  | *Any Other  |
 ; |       |                |              |             |including opt|
 ;  -------------------------------------------------------------------
 ;
 ; -- error, returns -1, bill does not exist
 ;
 N IBX
 S IBX=-1
 ; -- set value to defaults if okayed by vaco
 ;S IBX="3^1^4"
 ;
 I '$G(IBIFN)!($G(^DGCR(399,+$G(IBIFN),0))="") G CRITQ
 S IBX=""
 ;
 S $P(IBX,"^",1)=$$TYPOL(IBIFN)
 S $P(IBX,"^",2)=$$HOWID(IBIFN)
 S $P(IBX,"^",3)=$$BEDSC(IBIFN)
 ;
CRITQ Q IBX
 ;
 ;
TYPOL(IBIFN) ; -- compute type of policy for a bill
 N IBX,IBCDFN,IBCPOL,TYPE
 S IBX=""
 S IBCDFN=$$POL(IBIFN) I 'IBCDFN G TYPOLQ
 S IBCPOL=$P($G(^DPT(+$P($G(^DGCR(399,+$G(IBIFN),0)),"^",2),.312,IBCDFN,0)),"^",18) ; pointer to group plan (355.3)
 I 'IBCPOL S IBX=3 ; default type of policy is 3 or other
 I IBCPOL D
 .S TYPE=$P($G(^IBE(355.1,+$P($G(^IBA(355.3,+IBCPOL,0)),"^",9),0)),"^",3)
 .S IBX=$S(TYPE=1:1,TYPE=11:2,1:3) ; full medical, medicare supplementa or other
TYPOLQ I IBX<1!(IBX>3)!(IBX'?1N) S IBX=3 ; must be number from 1-3, default=3
 Q IBX
 ;
 ;
HOWID(IBIFN) ; -- compute how policy was identified
 N IBX,IBCDFN
 S IBX=""
 S IBCDFN=$$POL(IBIFN) I 'IBCDFN G HOWIDQ
 S IBX=$P($G(^DPT(+$P($G(^DGCR(399,+$G(IBIFN),0)),"^",2),.312,IBCDFN,1)),"^",9)
 ;
HOWIDQ I IBX<1!(IBX'?1N) S IBX=1 ; must be number, default=1 by interview
 Q IBX
 ;
 ;
BEDSC(IBIFN) ; -- compute primary bedsection for a bill
 ; -- based on greatest length of stay
 N IBX,IBRC,IBBS,IBUN,IBMAX
 S IBX=""
 I '$G(IBIFN) G BEDSCQ
 I $P($G(^DGCR(399,+IBIFN,0)),"^",5)>2 S IBX=4 G BEDSCQ ; opt bill
 ;
 ; -- add up all los for each rev code.
 S IBRC=0 F  S IBRC=$O(^DGCR(399,+IBIFN,"RC",IBRC)) Q:'IBRC  D
 .S IBUN=$P($G(^DGCR(399,+IBIFN,"RC",IBRC,0)),"^",3) ; units of service
 .S IBBS=$P($G(^DGCR(399,+IBIFN,"RC",IBRC,0)),"^",5) ; bedsection from 399.1
 .Q:IBBS=""
 .S IBBS(IBBS)=$G(IBBS(IBBS))+IBUN
 .Q
 ;
 ; -- find bedsection with highest los
 S IBMAX=""
 S X=0 F  S X=$O(IBBS(X)) Q:'X  I IBBS(X)>$G(IBBS(+IBMAX)) S IBMAX=X
 ;
 S IBX=$P($G(^DGCR(399.1,+IBMAX,0)),"^")
 ;
BEDSCQ S IBX=$S(IBX="":4,IBX["MEDICAL":1,IBX["SURGICAL":2,IBX["PSYCHIATRIC":3,1:4)
 Q IBX
 ;
POL(IBIFN) ; -- compute internal policy id for a bill
 N X,Y,DFN,IBDD,IBCDFN
 S IBCDFN=$P($G(^DGCR(399,+IBIFN,"MP")),"^",2)
 I 'IBCDFN D
 .S IBCNS=+$G(^DGCR(399,+IBIFN,"MP"))
 .S DFN=$P($G(^DGCR(399,+IBIFN,0)),"^",2)
 .S X="IBCNS1" X ^%ZOSF("TEST") I $T D ALL^IBCNS1(DFN,"IBDD")
 .I '$D(IBDD) Q
 .S X=0 F  S X=$O(IBDD(X)) Q:'X  I IBCNS=+$G(IBDD(X,0)) S IBCDFN=X Q
 .Q
POLQ Q IBCDFN

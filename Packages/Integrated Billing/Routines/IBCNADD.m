IBCNADD ;ALB/AAS - ADDRESS RETRIEVAL ENGINE FOR FILE 399 ; 29-AUG-93
 ;;2.0;INTEGRATED BILLING;**52,80,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ADD(DA,IBCOB) ; -- Retrieve correct billing address for a bill, mailing address of Bill Payer
 ;    assumes that new policy field points to valid ins. policy
 ;    DA = ien to file 399
 ;    IBCOB = payer sequence PST or 123 (optional)
 ;
 N X,Y,I,J,IB01,IB02,IBTYP,DFN,IBCNS,IBCDFN,IBCNT,IBAGAIN,IBFND,IBBILLTY,IBCHRGTY
 S IB02=""
 S DFN=$P($G(^DGCR(399,DA,0)),"^",2)
 S IBBILLTY=$P($G(^DGCR(399,DA,0)),"^",5),IBCHRGTY=$P($$CHGTYPE^IBCU(DA),"^;",1)
 ;
 S IBCNS=+$P($G(^DGCR(399,DA,"MP")),U,1)
 S IBCDFN=$P($G(^DGCR(399,DA,"MP")),U,2)
 ;
 ; If a specific payer sequence was passed in, get the ins. company and the policy ptr
 ; No address returned for Medicare
 I $G(IBCOB)'="" D  I $$MCRWNR^IBEFUNC(IBCNS) G MAINQ
 . S IBCOB=$TR(IBCOB,"PST","123")
 . S IBCNS=+$P($G(^DGCR(399,DA,"I"_IBCOB)),U,1)
 . S IBCDFN=+$P($G(^DGCR(399,DA,"M")),U,IBCOB+11)
 . Q
 ;
 I 'IBCNS G MAINQ
 I IBCDFN S IBCNS=+$G(^DPT(+DFN,.312,+IBCDFN,0))
 I '$D(^DIC(36,+IBCNS,0)) G MAINQ
 ;
 ; -- if send bill to employer and state is filled in use this
 I +$G(^DPT(DFN,.312,+IBCDFN,2)),+$P(^(2),"^",6) S IB02=$P(^(2),"^",2,99) G MAINQ
 ;
MAIN ; -- determine address for company for type bill
 ;
 ; -- get main address
 S IB02=$S($D(^DIC(36,+IBCNS,.11)):^(.11),1:"")
 S IBCNT=$G(IBCNT)+1
 ;
 ; -- if process the same co. more than once you are in an infinite loop
 I $D(IBCNT(IBCNS)) G MAINQ ;already processed this company  use main add
 S IBCNT(IBCNS)=""
 ;
 ; -- type of charges:   Rx charges - if ins company has an rx address use it, otherwise use opt address
 I IBCHRGTY=3 S IBTYP="R" D @IBTYP G:$D(IBFND) MAINQ I $D(IBAGAIN) K IBAGAIN G MAIN
 ;
 ; -- type of bill:   inpatient<3, outpatient>2
 S IBTYP=$S(IBBILLTY<3:"I",1:"O")
 D @IBTYP I $D(IBAGAIN) K IBAGAIN G MAIN
 ;
 ; -- return address
MAINQ Q IB02
 ;
I ; -- see if there is an inpatient address
 ; -- use if state is there
 I $P($G(^DIC(36,+IBCNS,.12)),"^",5) S IB02=$P($G(^(.12)),"^",1,6)
 ;
 ; -- if other company processes claims start again
 I $P($G(^DIC(36,+IBCNS,.12)),"^",7) S IBCNS=$P($G(^DIC(36,+IBCNS,.12)),"^",7) S IBAGAIN=1
 Q
 ;
O ; -- see if there is an outpatient address
 ; -- use if state is there
 I $P($G(^DIC(36,+IBCNS,.16)),"^",5) S IB02=$P($G(^(.16)),"^",1,6)
 ;
 ; -- if other company processes claims start again
 I $P($G(^DIC(36,+IBCNS,.16)),"^",7) S IBCNS=$P($G(^DIC(36,+IBCNS,.16)),"^",7) S IBAGAIN=1
 Q
 ;
R ; -- see if there is an Rx address
 ; -- use if state is there
 I $P($G(^DIC(36,+IBCNS,.18)),"^",5) S IB02=$P($G(^(.18)),"^",1,6) S IBFND=1
 ;
 ; -- if other company processes claims start again
 I $P($G(^DIC(36,+IBCNS,.18)),"^",7) S IBCNS=$P($G(^DIC(36,+IBCNS,.18)),"^",7) S IBAGAIN=1 K IBFND
 Q

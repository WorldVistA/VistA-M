IBCNSEVT ;ALB/AAS - NEW INSURANCE POLICY EVENT DRIVER ; 12-DEC-92
 ;;Version 2.0 ; INTEGRATED BILLING ;**6**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- Invokes items on the IB NEW INSURANCE EVENT protocol menu
 ;    Input  =:     dfn   = patient file ien
 ;              ibevtp0   = insurance type zeroth node of policy
 ;                          before editing
 ;              ibevtp1   = insurance type 1 node of policy 
 ;                          before editing
 ;              ibevtp2   = insurance type 2 node of policy
 ;                          before editing
 ;              ibevta0   = insurance type zeroth node of new policy
 ;                          contains effective/expiration dates
 ;              ibevta1   = insurance type 1 node of new policy
 ;                          contains date added and by whom
 ;              ibevta2   = insurance type 2 node of new policy
 ;               ibcdfn   = internal number of policy as in ^dpt(dfn,
 ;                          .312,ibcdfn,0))
 ;             ibevtact   = flag indicating whether action is add, edit
 ;                          or delete
 ;
 ;
 N DTOUT,DIROUT
 ;S X=$O(^ORD(101,"B","IBCN NEW INSURANCE EVENTS",0))_";ORD(101," D EN1^XQOR:X
 I IBEVTP0=IBEVTA0,IBEVTP1=IBEVTA1,IBEVTP2=IBEVTA2 G EVTQ
 S X="IBCN NEW INSURANCE EVENTS",DIC=101 D EN1^XQOR
EVTQ K X,DIC,IBEVTP0,IBEVTP1,IBEVTP2,IBEVTA0,IBEVTA1,IBEVTA2,IBEVTACT
 Q
 ;
BEFORE ; -- get insurance type values before adding/editing
 ;
 I $G(IBNEW) S (IBEVTP0,IBEVTP1,IBEVTP2)="" G BEFQ
 S IBEVTP0=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBEVTP1=$G(^DPT(DFN,.312,IBCDFN,1))
 S IBEVTP2=$G(^DPT(DFN,.312,IBCDFN,2))
BEFQ Q
 ;
AFTER ; -- get insurance type values after adding/editing. set action flag.
 ; -- get exemption after change
 ;    input  =:  dfn    = patient file ien
 ;
 S IBEVTA0=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBEVTA1=$G(^DPT(DFN,.312,IBCDFN,1))
 S IBEVTA2=$G(^DPT(DFN,.312,IBCDFN,2))
 I IBEVTP0="",IBEVTA0'="" S IBEVTACT="ADD"
 I IBEVTP0'="",IBEVTA0'="" S IBEVTACT="EDT"
 I IBEVTP0'="",IBEVTA0="" S IBEVTACT="DEL"
 Q

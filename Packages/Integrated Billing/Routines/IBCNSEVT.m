IBCNSEVT ;ALB/AAS - NEW INSURANCE POLICY EVENT DRIVER ; 12-DEC-92
 ;;2.0;INTEGRATED BILLING;**6,497**;21-MAR-94;Build 120
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ; -- Invokes items on the IB NEW INSURANCE EVENT protocol menu
 ;    Input  =:     dfn   = patient file ien
 ;              IBEVTP0   = insurance type zeroth node of policy
 ;                          before editing
 ;              IBEVTP1   = insurance type 1 node of policy 
 ;                          before editing
 ;              IBEVTP2   = insurance type 2 node of policy
 ;                          before editing
 ;              IBEVTP3   = insurance type 3 node of policy        - IB*2.0*497 (vd)
 ;                          before editing
 ;              IBEVTP7   = insurance type 7 node of policy        - IB*2.0*497 (vd)
 ;                          before editing
 ;              IBEVTA0   = insurance type zeroth node of new policy
 ;                          contains effective/expiration dates
 ;              IBEVTA1   = insurance type 1 node of new policy
 ;                          contains date added and by whom
 ;              IBEVTA2   = insurance type 2 node of new policy
 ;              IBEVTA3   = insurance type 2 node of new policy    - IB*2.0*497 (vd)
 ;              IBEVTA7   = insurance type 2 node of new policy    - IB*2.0*497 (vd)
 ;               IBCDFN   = internal number of policy as in ^dpt(dfn,
 ;                          .312,ibcdfn,0))
 ;             IBEVTACT   = flag indicating whether action is add, edit
 ;                          or delete
 ;
 ;
 N DTOUT,DIROUT
 ;S X=$O(^ORD(101,"B","IBCN NEW INSURANCE EVENTS",0))_";ORD(101," D EN1^XQOR:X
 I IBEVTP0=IBEVTA0,IBEVTP1=IBEVTA1,IBEVTP2=IBEVTA2,IBEVTP3=IBEVTA3,IBEVTP7=IBEVTA7 G EVTQ    ; IB*2.0*497 (vd)
 S X="IBCN NEW INSURANCE EVENTS",DIC=101 D EN1^XQOR
EVTQ K X,DIC,IBEVTP0,IBEVTP1,IBEVTP2,IBEVTA0,IBEVTA1,IBEVTA2,IBEVTACT
 K IBEVTP3,IBEVTP7,IBEVTA3,IBEVTA7    ; IB*2.0*497 (vd)
 Q
 ;
BEFORE ; -- get insurance type values before adding/editing
 ;
 I $G(IBNEW) S (IBEVTP0,IBEVTP1,IBEVTP2,IBEVTP3,IBEVTP7)="" G BEFQ       ; IB*2.0*497 (vd)
 S IBEVTP0=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBEVTP1=$G(^DPT(DFN,.312,IBCDFN,1))
 S IBEVTP2=$G(^DPT(DFN,.312,IBCDFN,2))
 S IBEVTP3=$G(^DPT(DFN,.312,IBCDFN,3))   ; IB*2.0*497 (vd)
 S IBEVTP7=$G(^DPT(DFN,.312,IBCDFN,7))   ; IB*2.0*497 (vd)
BEFQ Q
 ;
AFTER ; -- get insurance type values after adding/editing. set action flag.
 ; -- get exemption after change
 ;    input  =:  DFN    = patient file ien
 ;
 S IBEVTA0=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBEVTA1=$G(^DPT(DFN,.312,IBCDFN,1))
 S IBEVTA2=$G(^DPT(DFN,.312,IBCDFN,2))
 S IBEVTA3=$G(^DPT(DFN,.312,IBCDFN,3))   ; IB*2.0*497 (vd)
 S IBEVTA7=$G(^DPT(DFN,.312,IBCDFN,7))   ; IB*2.0*497 (vd)
 I IBEVTP0="",IBEVTA0'="" S IBEVTACT="ADD"
 I IBEVTP0'="",IBEVTA0'="" S IBEVTACT="EDT"
 I IBEVTP0'="",IBEVTA0="" S IBEVTACT="DEL"
 Q

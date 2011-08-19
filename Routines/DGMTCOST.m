DGMTCOST ;ALB/CAW - Copay Status change from IB  ; 12/23/92
 ;;5.3;Registration;**100**;Aug 13, 1993
 ;
EN ; Does the prior match the after?
 ;
 G:$P(IBEVTP,U,4)=$P(IBEVTA,U,4)!($P(IBEVTA,U,4)']"") ENQ
 G:$D(DGMTA)!($D(DGMTP)) ENQ
 D STATUS
 ;
ENQ ;
 K DGMTSTA,DGCOSTA,DGMT,DA,DR,DIE
 Q
 ;
STATUS ; Check if status change
 ;
 S DGMTI=+$$LST^DGMTU($P(IBEVTA,U,2),+IBEVTA,2)
 Q:'DGMTI
 ;
 ; if copay test is no longer applicable, continue processing
 ; will change status to exempt (from 10 to 7) in the ANNUAL MEANS
 ; TEST file (#408.31)
 Q:$P($G(^DGMT(408.31,DGMTI,0)),U,17)]""
 ;
 S DGCOSTA=$P($G(^DGMT(408.31,DGMTI,0)),U,3) Q:$S(DGCOSTA=7&($P(IBEVTA,U,4)=1):1,DGCOSTA=8&($P(IBEVTA,U,4)=0):1,1:0)
 S DGMTYPT=2,DGMTACT="STA" D PRIOR^DGMTEVT S DFN=$P(DGMTP,U,2)
 S DIE="^DGMT(408.31,",DA=+DGMTI,DR=".03////"_$S($P(IBEVTA,U,4)=1:7,1:8) D ^DIE
 D AFTER^DGMTEVT
 S DGMTINF=1 D EN^DGMTAUD
 Q

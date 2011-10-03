IBCNSM6 ;ALB/NLR - INSURANCE MANAGEMENT WORKSHEET, AN BEN ; 30-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BL1 ; --print subscriber's employer info, policy info, insurance co.
 ;
 W !,$TR($J(" ",IOM)," ","=")
 W !?66-($L("* PLAN *")\2),"* PLAN *"
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?6,"1.",?33-($L("** INSURANCE COMPANY **")\2),"** INSURANCE COMPANY **"
 D VLINE^IBCNSM7
 W ?72,"2.",?99-($L("** PLAN INFO, UR **")\2),"** PLAN INFO, UR **"
 W !?3,$J("Company:",23),?28,$E($$DOL(36,.01,$P($G(^DIC(36,+IBCDFND,0)),"^"),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Require UR?:",23),?108,$$DOL(355.3,.05,$$YN^IBCNSM($P(IBCPOLD,"^",5),1),IBLINE)
 W !?3,$J("Street:",23),?28,$E($$DOL(36,.111,$P($G(IBCDFNDA),"^"),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Require Pre-cert?:",23),?108,$$DOL(355.3,.06,$$YN^IBCNSM($P(IBCPOLD,"^",6),1),IBLINE)
 W !?3,$J("Street 2:",23),?28,$E($$DOL(36,.112,$P($G(IBCDFNDA),"^",2),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Benefits Assignable?:",23),?108,$$DOL(355.3,.08,$$YN^IBCNSM($P(IBCPOLD,"^",8),1),IBLINE)
 W !?3,$J("City:",23),?28,$E($$DOL(36,.114,$P(IBCDFNDA,"^",4),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Effective Date:",23),?108,$$DOL(FILE,8,$$DAT1^IBOUTL($P(IBCDFND,"^",8)),IBLINE)
 W !?3,$J("State:",23),?28,$E($$DOL(36,.115,$P(IBCDFNDA,"^",5),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Expiration Date:",23),?108,$$DOL(FILE,3,$$DAT1^IBOUTL($P(IBCDFND,"^",4)),IBLINE)
 W !,?3,$J("Phone:",23),?28,$$DOL(36,.131,$P(IBCDFNDB,"^",1),IBLINE) D VLINE^IBCNSM7
 W ?83,$J("Whose Insurance:",23),?108,$$EXPAND^IBTRE(2.312,6,$$DOL(FILE,6,$P($G(IBCDFND),"^",6),IBLINE))
 W !?3,$J("Precert Phone:",23),?28,$$DOL(36,.133,$$PHONE^IBCNSC01(IBCDFNDB),IBLINE) D VLINE^IBCNSM7
 W ?83,$J("Subscriber ID:",23),?108,$$DOL(FILE,1,$P($G(IBCDFND),"^",2),IBLINE)
 W !?3,$J("Verification Phone:",23),?28,$$DOL(36,.134,$P(IBCDFNDB,"^",4),IBLINE) D VLINE^IBCNSM7
 W ?83,$J("Insured's Name:",23),?108,$E($$DOL(FILE,17,$P($G(IBCDFND),"^",17),IBLINE),1,23)
 W !,?3,$J("Filing Time Frame:",23),?28,$$DOL(36,.12,$P($G(^DIC(36,+IBCDFND,0)),"^",12),IBLINE) D VLINE^IBCNSM7
 Q
 ;
 ;
DOL(FILE,FIELD,VALUE,LINE) ; -- data or line
 ; -- expand data if it exists or else print a blank line
 ;    if $g(line) print a line for worksheet
 N X
 ;S:VALUE'="" LINE=0 S X=""
 I VALUE="" S X=$S(LINE:"_______________________",1:"") G DOLQ
 ;I VALUE=""!(LINE) G DOLQ
 S X=$$EXPAND^IBTRE(FILE,FIELD,VALUE)
DOLQ Q X

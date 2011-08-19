IBCBB7A ;ALB/BGA,TMP - CON'T MEDICARE EDIT CHECKS ;10/16/98
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; HCPCS Rates
REVC(IBREVD,IBREVC,IBBCPT,IBREVC12,IBER) ; Continuation of revenue code edits
 ; IBREVD = data associated with revenue code
 ;    Rev code^ptr cpt^unit chg^units^total^total uncov
 ; IBREVC = revenue code
 ; IBBCPT = CPT code    IBREVC12 = the first 2 digits of the revenue code
 ; IBER = 'running' error array
 ;
 ; if rev code=26x,272,274,30x-32x,333,34x,35x,36x,40x-49x,51x-53x,61x
 ;   636,73x,74x,76x,90x-92x and 94x reqs valid HCPCS code for
 ;   type bill 13x,14x,74x,75x,83x,85x
 ;I "^13^14^74^75^83^85^"[(U_IBTOB12_U),$P(IBREVD,U,3)="" D  Q:IBQUIT
 ;. I "^272^274^333^636^"[(U_IBREVC_U)!("^26^30^31^32^34^35^36^61^73^74^76^90^91^92^94"[(U_IBREVC12_U))!(IBREVC'<400&(IBREVC'>499))!(IBREVC'<510&(IBREVC'>539)) S IBQUIT=$$IBER^IBCBB3(.IBER,208)
 ;
 ; ibrevc=274 req. a HCPCS code for bill 12x,13x,22x,23x,73x-75x,83x,85x
 I IBREVC=274,"^12^13^22^23^73^74^75^83^85^"[(U_IBTOB12_U),IBBCPT="" S IBQUIT=$$IBER^IBCBB3(.IBER,208) Q:IBQUIT
 ;
 ; ibrevc=250,270,300-305,324,329,38x,409,636,730,739,921,922,929
 ;    req a valid HCPCS code for bill type 72x
 I IBTOB12=72,IBBCPT="",(IBREVC12=38!("^250^270^300^301^302^303^304^305^324^329^409^636^730^739^921^922^929^"[(U_IBREVC_U))) S IBQUIT=$$IBER^IBCBB3(.IBER,208) Q:IBQUIT
 ;
 ; if revc=30x-31x req HCPCS code for bill 23x,24x
 I (IBREVC'<300),(IBREVC'>319),(IBTOB12=23!(IBTOB12=24)),IBBCPT="" S IBQUIT=$$IBER^IBCBB3(.IBER,208) Q:IBQUIT
 ;
 ; if revc=54x and bill 13x,23x,83x,85x req valid HCPCS
 I IBREVC12=54,"^13^23^83^85^"[(U_IBTOB12_U),IBBCPT="" S IBQUIT=$$IBER^IBCBB3(.IBER,208) Q:IBQUIT
 ;
 Q
 ;

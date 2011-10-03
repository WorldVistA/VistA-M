IBARXEVT ;ALB/AAS - IB EXEMPTION EVENT DRIVER ; 12-DEC-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- Invokes items on the IB EXEMPTION EVENT protocol menu
 ;    Input  =:  dfn      = patient file ien
 ;               ibaction = what is happening, add, chg, del
 ;               ibevt    = status^status text^reason code^date (from rxst^ibarxeu)
 ;               ibevtp   = exemption record zeroth node prior to change
 ;               ibevta   = exemption record zeroth node after change
 ;
 K DTOUT,DIROUT
 ;S X=$O(^ORD(101,"B","IB EXEMPTION EVENTS",0))_";ORD(101," D EN1^XQOR:X
 S X="IB EXEMPTION EVENTS",DIC=101 D EN1^XQOR
 K X,DIC
 Q
 ;
BEFORE ; -- get prior exemption for date
 ;    input  =:  dfn    = patient file ien
 ;               ibdt   = date of exemption
 ;
 ;    output =:  ibevtp = zeroth node of exemtpion before action
 ;
 N IBLDT
 ; -- if forcing a more recent effective date to inactive set
 ;    before to what is being canceled
 S IBLDT=$S($G(IBOLDAUT)?7N:IBOLDAUT,$G(IBFORCE)?7N:IBFORCE,1:IBDT)
 S IBEVTP=$$LST^IBARXEU0(DFN,IBLDT) ;I IBDT'=+IBEVTP K IBEVTP
 Q
 ;
AFTER ; -- get exemption after change
 ;    input  =:  dfn    = patient file ien
 ;               ibdt   = date of exemption
 ;
 ;    output =:  ibevta = zeroth node of exemtpion after action
 ;
 S IBEVTA=$$LST^IBARXEU0(DFN,IBDT) ;I IBDT'=+IBEVTA K IBEVTA
 Q

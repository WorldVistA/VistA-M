IBJTNA ;ALB/ARH - TPI INSURANCE SCREENS/ACTIONS ; 2/14/95
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; the PI view patient policies screen is based on the Patient Insurance Management screen of the
 ;       View Patient Insurance [IBCN VIEW PATIENT INSURANCE] option
 ; the VI view insurance screen is based on the Insurance Company Editor screen of the 
 ;       Insurance Company Entry/Edit [IBCN INSURANCE CO EDIT] option
 ; the VP view policy screen is based on the Patient Policy Information screen of the 
 ;       Patient Insurance Info View/Edit [IBCN PATIENT INSURANCE] option
 ; the AB annual benefits screen is based on the Annual Benefits Editor screen of the 
 ;       Patient Insurance Info View/Edit [IBCN PATIENT INSURANCE] option
 ;
 ; four Insurance Module LM Templates were duplicated for JBI so the appropriate Protocol Menus could be used
 ; also so a screen with a message could be displayed if no ins information could be found
 ;    IBJT NS PI VIEW PAT INS  ---  IBCNS VIEW PAT INS    PI
 ;    IBJT NS VIEW INS CO      ---  IBCNS VIEW INS CO     VI
 ;    IBJT NS VIEW EXP POL     ---  IBCNS VIEW EXP POL    VP
 ;    IBJT NS VIEW AN BEN      ---  IBCNS VIEW AN BEN     AB
 ;
 ; code called by template was redirected to IBJTN* routines for set up of variables
 ;
 ; these screens may be called to display insurance information for a specific bill or they may be
 ; called as part of the insurance display for the patient (from the AL screen)
 ;
 ; three actions (VI, VP, AB) are defined to open screens for a bill's insurance:  IBJT NS VIEW xxx SCREEN
 ; four actions are defined to open these screens for a patient's insurance:  IBJT NS PI VIEW xxx SCREEN
 ;
 ; for the actions related to a bills insurance, ie. actions available from bill specific screens:
 ; the actions (VI, VP, AB) have two separate functions depending on the variable passed in: opening/loading
 ; a screen and to redisplay that screen, the redisplay must only be an action on the corresponding screen
 ; if REDISP does not have a value then a new screen is opened after asking for company/policy
 ; if REDISP does have a value then the screen is rebuilt after asking for company/policy (assumes screen
 ; already open), should only be used if the screen is already displayed, ie. action should only be be used
 ; with REDISP set if called from the corresponding screen
 ;
 ; the actions (VI, VP, AB) will ask for the user to select which carrier/policy if the bill has more than one
 ; only the primary, secondary and tertiary carrier/policies for the bill may be chosen to be displayed
 ; if one of the insurance actions is chosen from a bill specific screen
 ;
HDRI ; -- IBJT NS VIEW INS CO LIST TEMPLATE:  insurance company header code
 S VALMHDR(1)="Insurance Company Information"
 I +$G(IBCNS) D HDR^IBCNSC,PST(1)
 Q
INITI ; -- IBJT NS VIEW INS CO LIST TEMPLATE: insurance company init code
 K ^TMP("IBCNSC",$J)
 I '$G(IBIFN) D PRTCL^IBJU1("IBJT SHORT MENU")
 S IBCNS=+$P(IBJPOL,U,3) I +IBCNS D INIT^IBCNSC K VALMHDR Q
 S VALMCNT=0 D BLD("Insurance data incomplete, cannot find policy.")
 Q
EXITI D EXIT^IBCNSC K ^TMP("IBCNSC",$J) Q
HELPI D HELP^IBCNSC Q
 ;
VI(REDISP) ; -- IBJT NS VIEW INS CO SCREEN ACTION: view insurance company screen: expanded insurance company information
 ;     user can select carrier if more than one on bill, REDISP set if screen to be rebuilt for different carrier
 ;
 I '$G(REDISP) N IBX,IBVIEW,IBCHANGE,IBCNS,IBCPOL,IBPPOL,IBJPOL,IBI,IBLCNT,IBCNS13
 I '$G(IBIFN)!'$G(DFN) G VIQ
 D FULL^VALM1
 S IBX=$$PST^IBJTU31(IBIFN) I 'IBX S VALMBCK="R" G VIQ
 S IBJPOL=IBX
 I '$G(REDISP) D EN^VALM("IBJT NS VIEW INS CO") G VIQ
 D INITI S VALMBCK="R"
VIQ Q
 ;
 ;
BLD(MSG) D KILL^VALM10(),SET^IBCNSP(1,1,""),SET^IBCNSP(2,1,MSG) Q
PST(X) S IBI=$P(IBJPOL,U,2),IBX=$S(IBI=1:"Primary",IBI=2:"Secondary",IBI=3:"Tertiary",1:""),VALMHDR(X)=$E(VALMHDR(X),1,68)_$J("",(79-$L(VALMHDR(X))-$L(IBX)))_IBX Q

IBCEP0B ;ALB/TMP - Functions for PROVIDER ID MAINTENANCE ;13-DEC-99
 ;;2.0;INTEGRATED BILLING;**137,296**;21-MAR-94
 ;
EN ; -- main entry point for IBCE PRVINS PARAM DISPLAY
 N IBINS,IBDSP,IBSORT ; Variables should be available throughout actions
 D FULL^VALM1
 D EN^VALM("IBCE PRVINS PARAM DISPLAY")
 Q
 ;
HDR ; -- header code
 K VALMHDR
 I $G(IBINS) S VALMHDR(1)="INSURANCE CO: "_$P($G(^DIC(36,+IBINS,0)),U)
 Q
 ;
INIT ; Initialization
 D BLD($G(IBINS))
 Q
 ;
BLD(IBINS) ; Build display for insurance co parameter display
 ; IBINS = the ien of the insurance co (file 36)
 ;
 ;ejk 4/20/05 Add IB3 to list of NEWed variables. 
 N IBLCT,IB4,IB3,IBP,Z0
 K ^TMP("IBPRV_INS_PARAM",$J)
 S IB4=$G(^DIC(36,+IBINS,4))
 ;EJK 4/20/05 Create and pass IB3 to fix undefined variable error. 
 S IB3=$G(^DIC(36,+IBINS,3))
 ;
 D PARAMS^IBCNSC1(IB4,IB3,.IBP)
 S (IBLCT,IBP)=0
 F  S IBP=$O(IBP(IBP)) Q:'IBP  D
 . S Z0=$E($J("",+IBP(IBP))_$P(IBP(IBP),U,2),1,79)
 . D SET1(Z0,.IBLCT)
BLDQ S VALMCNT=IBLCT,VALMBG=1
 Q
 ;
EXPND ;
 Q
 ;
HELP ;
 Q
 ;
EXIT ;
 K ^TMP("IBPRV_INS_PARAM",$J)
 D CLEAN^VALM10
 Q
 ;
EDIT ; Edit provider id insurance co parameters
 N IBY,DA,X,Y,DIE,DR
 D FULL^VALM1
 S IBY=",12,",DIE="^DIC(36,",DA=+$G(IBINS),DR="[IBEDIT INS CO1]"
 I DA>0 D ^DIE,BLD(IBINS)
 ;
 S VALMBCK="R"
 Q
 ;
SET1(Z0,CT) ; Set lines into display array
 S CT=CT+1
 D SET^VALM10(CT,Z0)
 Q
 ;

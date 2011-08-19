IBJTNC ;ALB/ARH - TPI INSURANCE PATIENT POLICIES ; 2/14/95
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; contains list template code and protocol entry code for the insurance screens that may be called from
 ; the Active Bills screen.  The actions (VI, VP, AB) are callable from the PI Patient Insurance Screen for any
 ; of the policies defined for the patient
 ;
HDRPI ; -- IBJT NS PI VIEW PAT INS LIST TEMPLATE:  patient insurance list header code
 N VA,VAERR D HDR^IBCNSM4
 Q
 ;
INITPI ; -- IBJT NS PI VIEW PAT INS LIST TEMPLATE:  patient insurance list init code
 I $G(DFN) D INIT^IBCNSM4
 Q
 ;
EXITPI ; -- IBJT NS PI VIEW PAT INS LIST TEMPLATE:  patient insurance list exit code
 K ^TMP("IBNSM",$J),^TMP("IBNSMDX",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
VPI ; -- IBJT NS PI VIEW PAT INS ACTION:  patient insurance list screen: displays all policies for patient
 I '$G(DFN) G VPIQ
 N IBEXP1,IBEXP2,IBCDFN,IBFILE,IBI,IBLCNT,IBN,IBCGN,IBCNT,IBDA,IBDIF,IBPPOL,IBDUZ,IBCPOL,IBCDFND1,IBCDFN,IBCNS,IBYE
 D EN^VALM("IBJT NS PI VIEW PAT INS")
VPIQ Q
 ;
NX(IBTPLNM) ; -- IBJT NS PI VIEW x ACTION, entry action for 3 action protocols on the Patient Insurance screen to select
 ;     one of the patient policies for expanded information, opens one of the insurance screens based on the
 ;     action chosen by the user
 ;            IBJT NS PI VIEW INS CO SCREEN action => IBJT NS VIEW INS CO screen
 ;            IBJT NS PI VIEW EXP POL SCREEN action => IBJT NS VIEW EXP POL screen
 ;            IBJT NS PI VIEW AN BEN SCREEN action => IBJT NS VIEW AN BEN screen
 ;
 N VALMY,I,IBSELN,IBJPOL,IBX
 N IBCPOL,IBPPOL,IBCNS,IBI,IBVIEW,IBCHANGE,IBLCNT,IBDA,IBCNT,IBYE
 N IBEXP1,IBEXP2,IBFILE,IBN,IBCGN,IBDIF,IBDUZ,IBCDFND1,IBCDFN,IBPR,IBPRD
 N IBEVDT,IBDT,IBYR,IBCAB,IBCGN,IBDUZ,OFFSET,START,IBCNS13
 ;
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1
 I $D(VALMY) S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBX=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBSELN,0)))) Q:IBX=""
 . S IBJPOL=$P(IBX,U,4)_"^^"_$P(IBX,U,5,999)
 . D EN^VALM(IBTPLNM)
 S VALMBCK="R"
 Q

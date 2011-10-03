IBCNSV ;ALB/AAS - INS. MGMT, INVOKE LIST TEMPLATE ;06-JUL-93
 ;;2.0;INTEGRATED BILLING;**276**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;also used for IA #4694
 ;
NXT(IBTMPNM) ; -- Go to next template
 ; -- Input template name
 N VALMY,I,J,IBXXV
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1 W !!
 I $D(VALMY) S IBXXV=0 F  S IBXXV=$O(VALMY(IBXXV)) Q:'IBXXV  D
 .S IBPPOL=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBXXV,0))))
 .Q:IBPPOL=""
 .S IBCNS=$P(IBPPOL,"^",5),IBCPOL=$P(IBPPOL,"^",22)
 .D EN^VALM(IBTMPNM)
 .Q
 D BLD^IBCNSM
 S VALMBCK="R"
 Q

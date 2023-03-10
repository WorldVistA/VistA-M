IBCE837N ;EDE/JWS - RPC TO RETURN EXTERNAL CLAIM NUMBER FOR IEN
 ;;2.0;INTEGRATED BILLING;**718**;23-MAY-18;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
GET(RESULT,ARG) ; return external claim # from internal number (IEN)
 ;
 N RES,DILOCKTM,DISYS,DT,DTIME,IO,IBIEN,SITE,IBCLM
 K RESULT
 D DTNOLF^DICRW
 S IBIEN=ARG("IEN399")
 ;;I IBIEN="" S RES("status")="No Claim IEN value passed" G RET
 S SITE=$P($$SITE^VASITE(),"^",3)
 I IBIEN'="" D
 . S IBCLM=$$GET1^DIQ(399,IBIEN_",",.01)
 . ;;I X="" S RES("status")="Claim IEN "_IBIEN_" does not exist on Site "_SITE G RET
 . ;;I X="" S RES("ien")=IBIEN, RES("claim")="undefined", RES("site")=SITE G RET
 . ;;S RES("status")="Claim IEN "_IBIEN_" is for Claim# "_X_" on Site "_SITE
 S RES("ien")=$S(IBIEN:IBIEN,1:0)
 S RES("site")=SITE
 S RES("claim")=$S($G(IBCLM)'="":IBCLM,1:"undefined")
 ;
RET ; setup return JSON
 ; create JSON structured message
 D ENCODE^XLFJSONE("RES","RESULT")
 D FINISH^IBCE837I
 Q
 ;

IBCE837T ;EDE/JWS - RPC to setup test claims for non-production sites;12/23/2020
 ;;2.0;INTEGRATED BILLING;**650**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
GET(RESULT,ARG) ;
 ;
 N RES,DILOCKTM,DISYS,DT,DTIME,IO,X
 N CT
 K RESULT
 ;JWS;IB*2.0*650v9;remove setting of DUZ(0)
 D DTNOLF^DICRW
 ;;S RES("site")=$P($$SITE^VASITE,U,3)
 ; 
 I $$PROD^XUPROD(1) S RES("STATUS")="This is a PRODUCTION environment, cannot setup 837 FHIR test claims" G RET
 ;
 I '$$GET1^DIQ(350.9,"1,",8.21,"I") S RES("STATUS")="837 FHIR processing is not turned ON in this environment" G RET
 ;
 I '$F(",2,3,7,*,",","_ARG("CLAIMTYPE")) S ARG("CLAIMTYPE")=""
 I ARG("NUMCLAIMS")'?.N S ARG("NUMCLAIMS")=0
 ;
 I '$D(ARG("REPEATS")) S ARG("REPEATS")=1
 D SET(ARG("NUMCLAIMS"),ARG("REPEATS"),ARG("CLAIMTYPE"))
 ;
 S RES("STATUS")=CT_" Claims setup for 837 FHIR transmission"
 ;
RET ; setup return JSON
 ; create JSON structured message
 D ENCODE^XLFJSONE("RES","RESULT")
 D FINISH^IBCE837I
 Q
 ;
 ;
SET(XCT,REPEAT,XTYPE) ;
 N IB364,IBXIEN,IBNF,IB0,IBAMT,IBTXST,IBNOTX,IBTXTEST,IBBTYP,IBQUE
 I $G(REPEAT) K ^XTMP("IBCE837T")
 I $G(XTYPE)="*" S XTYPE=""
 S IB364="A"
 F  S IB364=$O(^IBA(364,IB364),-1) Q:IB364=""  D  Q:$G(CT)=XCT
 . S X=$G(^IBA(364,IB364,0)) I +X="" Q
 . I $P(X,"^",3)="Z" Q  ;claim is closed
 . S IBXIEN=+$G(^IBA(364,IB364,0)),IBNF=""
 . I IB364'=$$LAST364^IBCEF4(IBXIEN) Q  ;make sure we have the correct 364 entry.
 . S IB0=$G(^DGCR(399,IBXIEN,0))
 . S IBAMT=$P($G(^DGCR(399,IBXIEN,"U1")),"^")
 . I IBAMT'>0 Q
 . S IBTXST=$$TXMT^IBCEF4(IBXIEN,.IBNOTX,IBNF)
 . Q:IBTXST=""  ; no txmt
 . I IB0="" Q
 . ;JWS;IB*2.0*650v7;for consistenacy, do not include claims with no primary ins pointer
 . I $P($G(^DGCR(399,IBXIEN,"M")),"^")="" Q
 . I XTYPE'="",XTYPE'=$$FT^IBCEF(IBXIEN) Q
 . S IBTXTEST=$S($G(IBTEST):2,1:+$$TEST^IBCEF4(IBXIEN))
 . S IBBTYP=$P("P^I^D",U,$S($$FT^IBCEF(IBXIEN)=7:3,1:($$FT^IBCEF(IBXIEN)=3)+1))_"-"_IBTXTEST
 . I $$TESTPT^IBCEU($P(IB0,U,2)),'IBTXTEST Q
 . I $P(IB0,U,13)>4 Q  ;IF CANCELLED SKIP
 . I '$D(^DGCR(399,IBXIEN,"CP")) Q
 . I $D(^TMP($J,"BILL",$P(IB0,U))) Q  ; do not send duplicates
 . I '$G(REPEAT),$D(^XTMP("IBCE837T",$P(IB0,U))) Q
 . ; 11/12/19 skip rebilled claim entries
 . I $F($P(IB0,U),"-") Q
 . S ^TMP($J,"BILL",$P(IB0,U))="",^XTMP("IBCE837T",$P(IB0,U))=""
 . S IBQUE=$$GET1^DIQ(350.9,"1,",8.09)
 . D SETCLM^IBCE837I(IB364,IBQUE,1) S CT=$I(CT)
 . Q
 Q
 ;

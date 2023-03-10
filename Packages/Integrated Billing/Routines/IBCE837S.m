IBCE837S ;EDE/JWS - RPC to change 837 FHIR Transmit Yes/No in IB SITE PARAMETERS;10/14/2018
 ;;2.0;INTEGRATED BILLING;**650**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PUT(RESULT,ARG) ;
 ;
 N IB837,RES,DILOCKTM,DISYS,DT,DTIME,IO,X
 K RESULT
 ;JWS;IB*2.0*650v9;remove setting of DUZ(0)
 D DTNOLF^DICRW
 S RES("site")=$P($$SITE^VASITE,U,3)
 ; 837ENABLE = 0 for NO or disble
 ;             1 for YES or enable
 S IB837=$G(ARG("837ENABLE"))
 I $$GET1^DIQ(350.9,"1,",8.21,"I")=IB837 S RES("status")="Unchanged from "_$S(IB837=1:"YES",1:"NO") G RET
 L +^IBE(350.9):5 I $T S DIE="^IBE(350.9,",DA=1,DR="8.21////"_IB837 D ^DIE
 L -^IBE(350.9)
 I $$GET1^DIQ(350.9,"1,",8.21,"I")=IB837 S RES("status")="Changed to "_$S(IB837=1:"YES",1:"NO") G RET
 S RES("status")="Unchanged from "_$$GET1^DIQ(350.9,"1,",8.21)
 ;
RET ; setup return JSON
 ; create JSON structured message
 D ENCODE^XLFJSONE("RES","RESULT")
 D FINISH^IBCE837I
 Q
 ;

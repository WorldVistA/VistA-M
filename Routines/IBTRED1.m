IBTRED1 ;ALB/AAS - CLAIMS TRACKING EDIT ; 06-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRE
 ;
NX(IBTMPNM) ; -- edit next template
 N IBXX,VALMY,IBTRV,IBTRC
 D EN^VALM(IBTMPNM)
 I '$D(IBFASTXT) D BLD^IBTRED
 S VALMBCK="R"
 Q
 ;
EDIT(IBTEMP,BLD) ; -- edit entry point for claims tracking
 ; -- Input   IBTEMP = template name or dr string
 ;               BLD = any non-zero value if calling routine is doing own
 ;                      rebuild
 ;
 D FULL^VALM1 W !
 L +^IBT(356,+IBTRN):5 I '$T D LOCKED^IBTRCD1 G EDITQ
 D SAVE
 S DIE="^IBT(356,",DA=IBTRN
 S DR=IBTEMP
 D ^DIE K DA,DR,DIC,DIE
 D COMP
 I IBDIF=1 D UPDATE,BLD^IBTRED:'$G(BLD)
 L -^IBT(356,+IBTRN)
EDITQ K ^TMP($J,"IBT")
 S VALMBCK="R"
 Q
 ;
SAVE ; -- Save the global before editing
 K ^TMP($J,"IBT")
 S ^TMP($J,"IBT",356,IBTRN,0)=$G(^IBT(356,IBTRN,0))
 S ^TMP($J,"IBT",356,IBTRN,1)=$G(^IBT(356,IBTRN,1))
 Q
 ;
COMP ; -- Compare before editing with globals
 S IBDIF=0
 I $G(^IBT(356,IBTRN,0))'=$G(^TMP($J,"IBT",356,IBTRN,0)) S IBDIF=1
 I $G(^IBT(356,IBTRN,1))'=$G(^TMP($J,"IBT",356,IBTRN,1)) S IBDIF=1
 Q
 ;
UPDATE ; -- enter date and user if editing has taken place
 ;    entry locked by edit, locks not needed here
 S DIE="^IBT(356,",DA=IBTRN
 S DR="1.03///NOW;1.04////"_DUZ
 D ^DIE K DA,DR,DIC,DIE
 Q
 ;
DICS(Y) ; -- called by input transform and screen logic for type of diagnois
 N IBY
 S IBY=0
 I Y=2 S IBY=1 G DICSQ
 I Y=1 I '$D(^IBT(356.9,"ATP",+$P($G(^IBT(356.9,DA,0)),U,2),1))!($O(^IBT(356.9,"ATP",+$P($G(^IBT(356.9,DA,0)),U,2),1,0))=DA) S IBY=1
 I Y=3 I '$D(^IBT(356.9,"ATP",+$P($G(^IBT(356.9,DA,0)),U,2),3))!($O(^IBT(356.9,"ATP",+$P($G(^IBT(356.9,DA,0)),U,2),3,0))=DA) S IBY=1
 ;I Y=3 I '$D(^IBT(356.9,"ADG",+$P($G(^IBT(356.9,DA,0)),U,2),+^(0)))!($O(^IBT(356.9,"ADG",+$P($G(^IBT(356.9,DA,0)),U,2),+^(0),0))=DA) S IBY=1
DICSQ Q IBY
 ;
BILLD(IBTRN) ; -- compute total amount billed and received for this visit
 ; -- output total amount billed (minus offset) ^ total amount recieved
 N X,Y,Z,IBY,IBZ
 S (IBY,IBZ)=0
 I '$G(IBTRN) G BILLDQ
 ;
 S (X,Y,Z)=0 F  S X=$O(^IBT(356.399,"ACB",IBTRN,X)) Q:X=""  D COMPUT
 ;
 I 'IBY,'IBZ D  ;look to 399 if no ct pointer
 .N DGPM,IBEVDT
 .S IBEVDT=$P(^IBT(356,+IBTRN,0),"^",6)
 .;inpatient
 .S DGPM=$P(^IBT(356,+IBTRN,0),"^",5) I DGPM D
 ..S (X,Y,Z)=0 F  S X=$O(^DGCR(399,"D",IBEVDT,X)) Q:'X  D COMPUT
 .;
 .;outpatient
 .I $P($G(^IBE(356.6,+$P(^IBT(356,+IBTRN,0),"^",18),0)),"^",8)=2 D
 ..S IBEVDT=+$P(IBEVDT,"."),DFN=$P(^IBT(356,+IBTRN,0),"^",2)
 ..S (X,Y,Z)=0 F  S X=$O(^DGCR(399,"AOPV",DFN,IBEVDT,X)) Q:'X  D COMPUT
 ..;I IBY S IBY=IBY_" (May include multiple visit dates)"
 ;
BILLDQ I 'IBY,$P(^IBT(356,+IBTRN,0),"^",29) S IBY=$P(^IBT(356,+IBTRN,0),"^",29)_" (Estimated)"
 Q $G(IBY)_"^"_+$G(IBZ)
 ;
COMPUT ; -- add up the numbers
 Q:$P($G(^DGCR(399,X,"S")),"^",17)
 S Y=$P($G(^DGCR(399,X,"U1")),"^",1)-$P($G(^("U1")),"^",2)
 I Y>0 S IBY=IBY+Y
 S Z=$$TPR^PRCAFN(X)
 I Z>0 S IBZ=IBZ+Y
 Q

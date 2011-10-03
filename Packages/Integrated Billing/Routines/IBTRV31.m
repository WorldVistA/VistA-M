IBTRV31 ;ALB/AAS - CLAIMS TRACKING -  REVIEW ACTIONS ; 14-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**10**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRV
 ;
RDAY(IBTRN) ; -- compute next day for review
 N X,IBDAY S IBDAY=1
 I $O(^IBT(356.1,"ATRTP",IBTRN,15,0)) S IBDAY=2
 I $O(^IBT(356.1,"ATRTP",IBTRN,30,0)) D  S IBDAY=-$O(X(""))+1 S:IBDAY<2 IBDAY=2
 .S X=0
 .F  S X=$O(^IBT(356.1,"ATRTP",IBTRN,30,X)) Q:'X  I $P($G(^IBT(356.1,X,0)),"^",3)'="" S X(-$P(^IBT(356.1,X,0),"^",3))=""
 S:IBDAY<1 IBDAY=1
 ;
 Q IBDAY
 ;
RDT(IBTRN) ; -- Compute next review date
 N IBV,IBTRVDT
 S IBV=$O(^IBT(356.1,"ATIDT",IBTRN,"")),IBTRVDT=""
 I 'IBV S IBTRVDT=DT
 I IBV S:IBV<1 IBV=-IBV S IBTRVDT=$$FMADD^XLFDT(IBV,1)
 Q IBTRVDT
 ;
ASKMORE() ; -- ask if addmore review
 N DIR,DIROUT,DUOUT,DTOUT,X,Y
 S DIR(0)="Y",DIR("A")="Add Next Review",DIR("B")="YES"
 S DIR("?")="Answer 'Yes' if you want to continue adding the review for the next day or answer 'No' if you are done for now."
 D ^DIR
 I $D(DIRUT)!($D(DUOUT))!($D(DTOUT)) S Y="^"
 Q $G(Y)
 ;
ASKSAME() ; -- ask if next review is same as the last
 N DIR,DIROUT,DUOUT,DTOUT,X,Y
 S DIR(0)="Y",DIR("A")="Is next Review exactly the Same",DIR("B")="YES"
 S DIR("?")="Answer 'Yes' if you want the next review to be exactly the same (I'll update the day for review automatically) or answer 'No' if you wish to edit the review now."
 D ^DIR
 I $D(DIRUT)!($D(DUOUT))!($D(DTOUT)) S Y="^"
 Q $G(Y)
 ;
COPY(IBTSAV) ; -- Copy a Review
 ; -- input ibtsav = internal id or review to copy
 ;
 ; -- WARNING:  This changes the value of IBTRV to the value
 ;              of the new review added
 ;
 I '$G(IBTSAV)!('$G(^IBT(356.1,+$G(IBTSAV),0))) W !!,"DUH, Nothing Added!" D PAUSE^VALM1 G COPYQ ; only stupid programmers get this message
 N I,J,X,Y,DA,DIC,DIE,DR,DIK,IBQUIT,IBTRTP,IBTRN,IBTRVD,IBTRVDT,NODE,IEN,IBNX
 S IBQUIT=0
 S IBTRVD=$G(^IBT(356.1,IBTSAV,0))
 S IBTRVDT=$$FMADD^XLFDT(+IBTRVD,1)
 S IBTRN=$P(IBTRVD,"^",2)
 S IBTRTP=30 K IBTRV
 D PRE^IBTUTL2(IBTRVDT,IBTRN,IBTRTP)
 I '$D(IBTRV) G COPYQ
 I '$G(IBRDAY) S IBRDAY=$P(IBTRVD,"^",3)+1
 ;
 ; -- copy the old review into the new one
 ;S $P(^IBT(356.1,IBTRV,0),"^",3,24)=$G(IBRDAY)_"^"_$P(IBTRVD,"^",4,23)_"^"_IBTSAV
 ;    replace the above line with following line, 20 piece is set in call to pre^ibtutl2
 S IBNX=$P(^IBT(356.1,IBTRV,0),"^",20),$P(^IBT(356.1,IBTRV,0),"^",3,24)=$G(IBRDAY)_"^"_$P(IBTRVD,"^",4,23)_"^"_IBTSAV,$P(^IBT(356.1,IBTRV,0),"^",20)=IBNX
 ;
 S $P(^IBT(356.1,IBTRV,0),"^",22)=$O(^IBE(356.11,"ACODE",30,0))
 S $P(^IBT(356.1,IBTRV,1),"^",3,12)=$P(^IBT(356.1,+IBTSAV,1),"^",3,12)
 F NODE=12,13 I $D(^IBT(356.1,IBTSAV,NODE,0)) D
 .S ^IBT(356.1,IBTRV,NODE,0)=$G(^IBT(356.1,IBTSAV,NODE,0))
 .S IEN=0 F  S IEN=$O(^IBT(356.1,IBTSAV,NODE,IEN)) Q:'IEN  I $G(^IBT(356.1,IBTSAV,NODE,IEN,0))'="" S ^IBT(356.1,IBTRV,NODE,IEN,0)=$G(^IBT(356.1,IBTSAV,NODE,IEN,0))
 ;
 S DIK="^IBT(356.1,",DA=IBTRV D IX1^DIK ; index set and kill logic
 ;
 ; -- now set next review date to value being copied
 S IBNX=$P(IBTRVD,"^",20) ; old value
 S:IBNX="" DR=".2///@" S:IBNX DR=".2////"_IBNX
 S DA=IBTRV,DIE="^IBT(356.1," D ^DIE
COPYQ Q
 ;
NXTRVDT(IBTRV) ; -- compute next review date
 N X,X1,X2
 S X=$P($G(^IBT(356.1,+$G(IBTRV),0)),"^",3)
 I $G(X)<1 S X=1
 I X>8 S X2=7 ;review every 7 days after 14
 I X<9 S X2=3 ;do 3,6,9 day reviews
 S X1=DT D C^%DTC
 Q X

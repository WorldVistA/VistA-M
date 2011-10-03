IBDFDE22 ;ALB/AAS - AICS Data Entry, check selection rules ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% G ^IBDFDE
 ;
CHK ; -- see if rules allow for more or less than one
 ;    rules 0 := select any number
 ;          1 := exactly 1
 ;          2 := at most 1
 ;          3 := at least 1 (1 or more)
 N I,IBDY,MATCH,OVERSAV
 S (MATCH,OVER,OVERSAV,ASKOTHER)=0
 ;
 ; -- check all rules for list and enforce
 S I=0 F  S I=$O(RULE(I)) Q:I=""  D  I OVER S:OVER>OVERSAV OVERSAV=OVER
 .;
 .; -- find all matches for list, and qualifier
 .S MATCH=0
 .S IBDY=0 F  S IBDY=$O(IBDPI(IBDF("PI"),IBDY)) Q:'IBDY  I $P(IBDPI(IBDF("PI"),IBDY),"^",6)=QLFR(I) S MATCH=MATCH+1
 .;
 .; -- any number allowed
 .I $G(RULE(+I))=0 D  Q
 ..I ANS="" S OVER=0 Q  ;nothing selected, don't reask
 ..I ANS'="" S OVER=1 Q  ;something selected, reask
 .;
 .; -- exactly one required
 .I $G(RULE(+I))=1 D  Q
 ..I MATCH>1 S OVER=2 W:'$G(IBDREDIT) !,"More than one selected, you must delete one" Q
 ..I MATCH=1 S OVER=0 D DELQLF Q  ;exactly one selected
 ..I MATCH<1 S OVER=1 W:'$G(IBDREDIT) !!,"A ",IOINHI,IBDASK,IOINORM," selection is required"_$S(QLFR(I)="":"",1:" for "_IOINHI_QLFR(I)_IOINORM),".",! Q
 .;
 .; -- at most one required
 .I $G(RULE(+I))=2 D  Q
 ..I MATCH>1 S OVER=2 W:'$G(IBDREDIT) !,"More than one selected, you must delete one" Q
 ..I MATCH=1 S OVER=0 D DELQLF Q  ;exactly one selected
 ..I ANS'="",MATCH<1 S OVER=1 ;if match = 0 thats okay but ask
 .;
 .; -- at least one required
 .I $G(RULE(+I))=3 D  Q
 ..S OVER=1
 ..I MATCH<1 S OVER=1 W:'$G(IBDREDIT) !!,"A ",IOINHI,IBDASK,IOINORM," selection is required"_$S(QLFR(I)="":"",1:" for "_IOINHI_QLFR(I)_IOINORM),".",! Q
 ..I MATCH>1,ANS="" S OVER=0 Q  ;more than one selected
 ..I MATCH=1,ANS="" S OVER=0 Q  ;exactly one selected
 ;
 S OVER=OVERSAV
 I OVER=2 D DEL^IBDFDE1
CHKQ Q
 ;
DELQLF ; -- delete rule, qualifier
 Q:RULE<2  ;must leave the last or only rule
 I MATCH=1 S OVER=0 K RULE(I),QLFR(I) S RULE=RULE-1
 Q
 ;
RULES ; -- look at zero node, find qualifiers and selection rule
 N Q,R,CNT
 S RULE=$P($$CHOICE^IBDFDE2(0),"^",3),QLFR="",CNT=0
 ;
 ; -- go thru rules, if primary then make #1
 F IBD=1:1 S ROW=$P(RULE,"::",IBD) Q:ROW=""  D
 .S Q(IBD)=$P(ROW,";;",1),R(IBD)=$P(ROW,";;",2)
 .I Q(IBD)="PRIMARY" D
 ..S R(IBD)=$S(R(IBD)=3:1,R(IBD)=0:2,1:R(IBD))
 ..S RULE(1)=R(IBD),QLFR(1)=Q(IBD),CNT=CNT+1 K R(IBD),Q(IBD)
 S RULE=IBD-1
 ;
 ; -- make secondary #2 if primary exists, else #1
 S IBD="" F  S IBD=$O(R(IBD)) Q:'IBD  I Q(IBD)="SECONDARY" S CNT=CNT+1,RULE(CNT)=R(IBD),QLFR(CNT)=Q(IBD) K R(IBD),Q(IBD) Q
 ;
 ; -- take the rest as they come
 S IBD="" F  S IBD=$O(R(IBD)) Q:'IBD  S CNT=CNT+1,RULE(CNT)=R(IBD),QLFR(CNT)=Q(IBD)
 ;
 ;F IBD=1:1 S ROW=$P(RULE,"::",IBD) Q:ROW=""  S QLFR(IBD)=$P(ROW,";;",1),RULE(IBD)=$P(ROW,";;",2) I QLFR(IBD)="PRIMARY" D
 ;.S RULE(IBD)=$S(RULE(IBD)=3:1,RULE(IBD)=0:2,1:RULE(IBD))
 ;S RULE=IBD-1
 Q

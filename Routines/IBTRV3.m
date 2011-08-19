IBTRV3 ;ALB/AAS - CLAIMS TRACKING -  REVIEW ACTIONS ; 14-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**40,58**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRV
 ;
ADNXT(IBTRN) ; -- Add next Hospital Review
 ; -- Input  ibtrn = internal entry in claims tracking (356)
 ;
 N IBETYP,IBTRTP,IBQUIT,IBDGPM,IBTRVDT,IBTRV,IBRDAY,IBMORE,IBSAME,IBSEL
 D FULL^VALM1
 S VALMBCK="R",IBQUIT=0
 S IBTRVDT=DT
 S IBETYP=$$TRTP^IBTRE1(IBTRN)
 I IBETYP>2 W !!,"This doesn't appear to be an admission or outpatient visit.",!,"I don't know how to review this.",! D PAUSE^VALM1 G ADNXTQ
 I IBETYP=2 D  I IBQUIT D PAUSE^VALM1 G ADNXTQ
 .S IBTDAY=1
 .S IBTRTP=50
 .I '$D(^IBT(356.1,"ATRTP",IBTRN,IBTRTP)) Q
 .W !!,"You have already entered a Review for this Outpatient Encounter.",!,"Use Quick Edit to Edit."
 .S IBQUIT=1
 .Q
 ;
 ; -- inpatient review type
 I IBETYP=1 S IBTRTP=15 I $D(^IBT(356.1,"ATRTP",IBTRN,15)) S IBTRTP=30
 S IBRDAY=$$RDAY^IBTRV31(IBTRN)
 ;
INPT D REV(IBTRN,IBTRTP)
 D:$G(IBSEL)'["^" EN^IBTRE3(IBTRN)
 D:$G(IBSEL)'["^" EN^IBTRE4(IBTRN)
 D:$G(IBSEL)'["^" EN^IBTRE5(IBTRN)
 D EDIT^IBTRVD1(".21////10;.21",1)
 G:$G(IBSEL)["^" ANOTHER
 I IBETYP'=1 G ADNXTQ
 ;
ANOTHER ; -- ask if add another if no ask next review date/status
 S IBMORE=$$ASKMORE^IBTRV31()
 I IBMORE["^" D  G ADNXTQ
 .D EDIT^IBTRVD1("1.13////0;1.15////1;.2",1)
 .Q
 ;
 ; -- if yes ask set next review date ="" ask status
 I IBMORE D
 .D EDIT^IBTRVD1(".2///@",1) ;delete next review date
 .Q
 ; -- if no g adnxtq
 I 'IBMORE S VALMBCK="R" D  G ADNXTQ
 .D EDIT^IBTRVD1("1.13////0;1.15;I 'X S Y=""@9"";.2//^S X=$$DAT1^IBOUTL($$NXTRVDT^IBTRV31(IBTRV));@9;1.17;S Y=""@99"";.2///@;@99",1)
 ;
SAME ; -- ask if same
 S IBSAME=$$ASKSAME^IBTRV31()
 D EDIT^IBTRVD1("1.13////1;1.14////"_+IBSAME,1)
 ;
 I IBSAME["^" G ADNXTQ
 ;
 ; -- if yes file / increment day ask status/clinical data g another
 I IBSAME D  G ANOTHER
 .S IBRDAY=IBRDAY+1
 .S IBTRTP=30
 .D MESS
 .D COPY^IBTRV31(IBTRV) ; after copy ibtrv will be value of new review
 .Q
 ;
 ; -- if no edit g another
 I 'IBSAME D  G INPT
 .S IBRDAY=IBRDAY+1
 .S IBTRTP=30
 ;
ADNXTQ Q
 ;
REV(IBTRN,IBTRTP) ; -- Add review
 ; -- input ibtrtp = tracking type code,
 ;          ibtrn  = internal id of tracking entry
 I '$G(IBTRTP)!('$G(IBTRN)) W !!,"DUH, Nothing Added!" D PAUSE^VALM1 G REVQ ; only stupid programmers should get this message
 N IBQUIT,IBDGPMD,IBTRVDT
 S IBQUIT=0,IBTRVDT=$$RDT^IBTRV31(IBTRN)
 ;
 I IBTRTP=30 D  G:IBQUIT REVQ
 .I '$D(^IBT(356.1,"ATRTP",IBTRN,15)) W !!,"There must be an admission review first" S IBQUIT=1 Q
 .Q
 ;
 ; -- reviews after discharge date don't make sense
 S IBDGPMD=$P($G(^DGPM(+$P(^IBT(356,IBTRN,0),"^",5),0)),"^",17)
 ; finish this here
 ;
 D PRE^IBTUTL2(+$P(IBTRVDT,"."),IBTRN,IBTRTP)
 D MESS
 I '$D(IBTRV) G REVQ
 S VA200="" D INP^VADPT
 D @IBTRTP D EDIT^IBTRVD1(.DR,1)
REVQ Q
 ;
15 ; -- Initial edit of admission review
 S DR=".03////1;D UNIT^IBTRV3(IBTRV);.01;.07////^S X=IBSPEC;.07;.23//INTERQUAL;I X'=1 S Y=""@20"";.04;.05;.06;I X=1 S Y=""@20"";12;.1;I 'X S Y=""@20"";.11;@20;11;"
 Q
 ;
30 ; -- Initial edit for continued stay
 S DR=".01;.03//^S X=$$RDAY^IBTRV31(IBTRN);D UNIT^IBTRV3(IBTRV);.07////^S X=$G(IBSPEC);.07;.23//INTERQUAL;I X'=1 S Y=""@20"";.05;.04;I $P(^IBT(356.1,DA,0),U,4),$P(^(0),U,5) S Y=""@20"";.12;13;"
 S DR=DR_".1;I 'X S Y=""@20"";.11;@20;11;"
 ;S DR="[IBTRV NEW CONT]"
 Q
 ;
50 ; -- outpatient review
 D 15
 Q
 ;
UNIT(X) ; -- determine if specialty is a specialized unit
 ;    input (review)
 ;    output 1 if unit, 0 if not
 N Y,VAIN,VAINDT,VA200
 S IBUNIT=0,VA200=""
 I '$D(DA),$G(IBTRV) N DA S DA=IBTRV
 S VAINDT=$$VDT(IBTRN,DA),VA200="" D INP^VADPT
 I $P(VAIN(3),"^",2)["ICU"!$P(VAIN(3),"^",2)["CCU" S IBUNIT=1
 S IBSPEC=$P(VAIN(3),U),IBPROV=$P(VAIN(2),U),IBATD=$P(VAIN(11),U)
 Q
 ;
INSURD(X) ; -- determine if this is tracked as an ins. claim
 Q +$P(^IBT(356,+$P(^IBT(356.1,X,0),"^",2),0),"^",24)
 ;
VDT(IBTRN,IBTRV) ; compute vaindt for day of review
 N IBX,DAY
 ;patch 40
 S IBX=$P($P(^IBT(356,+IBTRN,0),"^",6),".")_.2359 ; midnight of admission day
 I $G(IBTRV) S DAY=$P($G(^IBT(356.1,+IBTRV,0)),"^",3)
 I $G(DAY)>1 S IBX=$P($$FMADD^XLFDT(IBX,DAY-1),".")_.2359 ; midnight of review day (day1 = admission day) ; patch 40 corrects the time problem +.24
 Q IBX
 ;
MESS ; -- add message
 W:IBTRTP=30 !!,"Adding a Continued Stay Review for Review Day ",$G(IBRDAY),".",!
 W:IBTRTP=15 !!,"Adding an Admission Review",!
 W:IBTRTP=50 !!,"Adding an Outpatient Visit Review",!
 Q

IBDFDE42 ;ALB/AAS - AICS Data Entry, check selection rules ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% G ^IBDFDE
 ;
CHK ; -- see if rules allow for more or less than one
 ;    rules 0 := select any number
 ;          1 := exactly 1
 ;          2 := at most 1
 ;          3 := at least 1 (1 or more)
 N I,IBDY,MATCH
 S (MATCH,OVER,ASKOTHER)=0
 ;
 ; -- find all matches
 S MATCH=0
 S IBDY=0 F  S IBDY=$O(IBDPI(IBDF("PI"),IBDY)) Q:'IBDY  S MATCH=MATCH+1
 ;
 ; -- any number allowed
 I RULE=0 D
 .I ANS="" S OVER=0 Q  ;nothing selected, don't reask
 .I ANS'="" S OVER=1 Q  ;something selected, reask
 ;
 ; -- exactly one required
 I RULE=1 D
 .I MATCH>1 S OVER=2 W:'$G(IBDREDIT) !,"More than one selected, you must delete one" Q
 .I MATCH=1 S OVER=0 Q  ;exactly one selected
 .I MATCH<1 S OVER=1 W:'$G(IBDREDIT) !!,"A ",IOINHI,IBDASK,IOINORM," selection is required.",! Q
 ;
 ; -- at most one required
 I RULE=2 D
 .I MATCH>1 S OVER=2 W:'$G(IBDREDIT) !,"More than one selected, you must delete one" Q
 .I MATCH=1 S OVER=0 Q  ;exactly one selected
 .I ANS'="",MATCH<1 S OVER=1 ;if match = 0 thats okay but ask
 ;
 ; -- at least one required
 I RULE=3 D
 .S OVER=1
 .I MATCH<1 S OVER=1 W:'$G(IBDREDIT) !!,"A ",IOINHI,IBDASK,IOINORM," selection is required.",! Q
 .I MATCH>1,ANS="" S OVER=0 Q  ;more than one selected
 .I MATCH=1,ANS="" S OVER=0 Q  ;exactly one selected
 ;
 I OVER=2 D DEL^IBDFDE1
 D DELQLF
CHKQ Q
 ;
DELQLF ; -- delete choices if selected
 Q:(+$G(SEL)=0)
 K ^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),+$G(SEL))
 Q

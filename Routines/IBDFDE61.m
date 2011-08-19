IBDFDE61 ;ALB/AAS - AICS Manual Data Entry, process selection lists ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% G ^IBDFDE6
 ;
PARTLST(NEXT,ANS) ; -- user gave inexact match, find which one
 ;
 N I,J,K,IBD,ANS2,SEL
 S J=1,I=^TMP("IBD-PLN",$J,IBDF("CLINIC"),NEXT),IBD(J)=I,SEL=""
 D ONE^IBDFDE6(I,J)
 ;
 S K=NEXT F  S K=$O(^TMP("IBD-PLN",$J,IBDF("CLINIC"),K)) Q:$E(K,1,$L(ANS))'=ANS  D
 .S J=J+1,IBD(J)=^TMP("IBD-PLN",$J,IBDF("CLINIC"),K)
 .D ONE^IBDFDE6(IBD(J),J)
 ;
ASKNUM G:J<1 PARTLQ
 W !,"   Choose 1-",J,": " R ANS2:DTIME
 I '$T!($E(ANS2,1)="^")!(ANS2="") S SEL="" G PARTLQ
 I $E(ANS2,1)="?" W !,"Enter a number from 1 - ",J G ASKNUM
 S ANS2=+ANS2
 I ANS2<1!(ANS2>J) G ASKNUM
 I $G(IBD(ANS2))="" G ASKNUM
 W !
 S SEL=$G(IBD(ANS2))
PARTLQ I ANS2="^" S IBQUIT=1
 Q SEL
 ;
MULT(CNT,IBD) ; -- multiple appointment
 N IBDI,ANS2,RESULT
 I 'CNT!'$D(IBD) Q ""
 S RESULT=""
 ; -- Loop through appointments, same date, same clinic
 F IBDI=1:1:CNT S NODE=$G(^TMP(ARRAY,$J,IBDF("CLINIC"),$P(IBD(IBDI),"^",2),+IBD(IBDI))) Q:NODE']""  D ONE^IBDFDE6(NODE,IBDI)
 ;
ASKN G:CNT<1 MULTQ
 W !,"   Choose 1-",CNT,": " R ANS2:DTIME
 I '$T!($E(ANS2,1)="^")!(ANS2="") G MULTQ
 I $E(ANS2,1)="?" W !,"Enter a number from 1 - ",CNT G ASKN
 S ANS2=+ANS2
 I ANS2<1!(ANS2>CNT) G ASKN
 I $G(IBD(ANS2))="" G ASKN
 W !
 S RESULT=$G(^TMP(ARRAY,$J,IBDF("CLINIC"),$P(IBD(ANS2),"^",2),+IBD(ANS2)))
MULTQ I ANS2="^" S IBQUIT=1
 Q RESULT
 ;
ASKPT(CNT) ; -- select patient from list
 Q:$G(IBQUIT)
 N I,DIR,DIRUT,DUOUT,DTOUT ;F I=1:1 Q:($Y>(IOSL-3))  W !
 I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR S IBQUIT='Y
 Q
 ;
 W !,"   Choose 1-",CNT,": " R ANS2:DTIME
 I '$T!($E(ANS2,1)="^")!(ANS2="") S SEL="" G MULTQ
 I $E(ANS2,1)="?" W !,"Enter a number from 1 - ",CNT G ASKN
 S ANS2=+ANS2
 I ANS2<1!(ANS2>CNT) G ASKN
 I $G(IBD(ANS2))="" G ASKN
 W !
 S RESULT=$G(IBD(ANS2))
 Q RESULT

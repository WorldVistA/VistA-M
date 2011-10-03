IBDFDE41 ;ALB/AAS - AICS Data Entry, process selection lists ; 24-FEB-96 [ 11/13/96  3:58 PM ]
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% G ^IBDFDE
 ;
SEL(SEL) ; -- Build results array
 N IBDX,DSPTXT,IBQUIT,IBDQL,QCNT,IBDQLFR
 S IBQUIT=0
 ;
 I +SEL=SEL S CHOICE=$G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),SEL))
 I +SEL'=SEL S CHOICE=SEL
 Q:IBQUIT
 ;
 ; -- build selections
 S RESULT(0)=$G(RESULT(0))+1
 W "  ",$P(CHOICE,"^"),"   ",$P(CHOICE,"^",3)
 ;
 S RESULT(RESULT(0))=IBDF("PI")_"^"_$P(CHOICE,"^",4)_"^"_$P(CHOICE,"^")_"^^^"_$P(CHOICE,"^",3)_"^"_$G(IBDF("IEN"))
 S IBDPI(IBDF("PI"),RESULT(0))=RESULT(RESULT(0))
 ;
 ; --validate code for active problem list
 I $P($G(^IBE(357.6,IBDF("PI"),0)),"^")="PX INPUT PATIENT ACTIVE PROBLEM" D
 .N X S X=$P(CHOICE,"^",2) Q:X=""
 .I X=799.9 W !,$C(7),$G(IOINHI),"Warning: The ICD9 Diagnosis associated with this problem needs to be updated!",$G(IOINORM) Q
 .D TESTICD^IBDFN7
 .I '$D(X) W !,$C(7),$G(IOINHI),"Warning: The ICD9 code associated with this problem is inactive.",$G(IOINORM)
 ;
 Q
 ;
LST ; -- List previous selections and selections to choose from.
 N I,CNT,IBQUIT,NUM
 ;
 ; -- list previous selections
 D PREVSEL
 ;
 ; -- list available choices
 S (IBQUIT,CNT)=0
 S NUM=+$G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),0))
 W !!,"Choose from: "
 S I=0 F  S I=$O(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),I)) Q:'I!(IBQUIT)  D
 .S CHOICE=$G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),I))
 .S CNT=CNT+1,NUMBER(CNT)=I
 .W !?3,CNT,?7,$S($P(CHOICE,"^",2)'="":$P(CHOICE,"^",2),1:$P(CHOICE,"^")),?20,"  ",$P(CHOICE,"^",3)
 .I NUM>15,NUM>I,'(CNT#15) D PAUSE^IBDFDE I 'IBQUIT W $C(13),$J("",55),$C(13)
 Q
 ;
PREVSEL ; -- List previous selections
 N I,CNT
 S CNT=0
 ;
 ; -- list previous selections
 I $D(IBDPI(IBDF("PI")))>1 S I=0 F  S I=$O(IBDPI(IBDF("PI"),I)) Q:'I  D
 .Q:$P(IBDPI(IBDF("PI"),I),"^",7)'=IBDF("IEN")  ; not the same list
 .S CNT=CNT+1
 .W:CNT=1 !!,IOINHI,"   You have previously selected: ",IOINORM
 .W !,?7,$S($P($G(^IBE(357.6,+IBDPI(IBDF("PI"),I),0)),"^")="GMP INPUT CLINIC COMMON PROBLEMS":$$LEX^IBDFDE1($P(IBDPI(IBDF("PI"),I),"^",2)),1:$P(IBDPI(IBDF("PI"),I),"^",2))
 .W ?16,$P(IBDPI(IBDF("PI"),I),"^",3),?50,$P(IBDPI(IBDF("PI"),I),"^",6)
 W !
 Q
 ;
DEFAULT ; -- compute default answer
 N CNT,SEL,NAME,PIECE,SELAST
 S (CNT,SEL,SELAST)=0
 S NAME=$P($G(^IBE(357.6,+IBDF("PI"),0)),"^")
 S PIECE=$S(NAME["INPUT PROCEDURE CODE":2,NAME["INPUT DIAGNOSIS CODE":2,NAME["INPUT VISIT TYPE":2,1:3)
 F  S SEL=$O(IBDPI(IBDF("PI"),SEL)) Q:'SEL  D
 .Q:$P(IBDPI(IBDF("PI"),SEL),"^",7)'=IBDF("IEN")  ; not the same list
 .S CNT=CNT+1,SELAST=SEL
 I $G(SELAST) S DIR("B")=$P(IBDPI(IBDF("PI"),SELAST),"^",PIECE),IBDEFLT(IBDF("PI"))=DIR("B")
 D PREVSEL
 Q
 ;
PARTLST(ARY,NEXT,ANS) ; -- input has more than one match, prompt for which one
 N I,J,K,N,IBD,ANS2,SEL,CHOICE
 S SEL=0
 S NEXT=$E(NEXT,1,$L(NEXT)-1)_$C($A($E(NEXT,$L(NEXT)))-1)_"~"
 ;
 S J=0,K=NEXT F  S K=$O(@ARY@(K)) Q:$E(K,1,$L(ANS))'=ANS  D
 .S N=0 F  S N=$O(@ARY@(K,N)) Q:'N  D
 ..S J=J+1,IBD(J)=@ARY@(K,N),CHOICE=$$CHOICE^IBDFDE2(IBD(J))
 ..W !?6,J,?10,$S($P(CHOICE,"^",2)'="":$P(CHOICE,"^",2),1:$P(CHOICE,"^",3)),?20,$P(CHOICE,"^",1),?50,"   ",$P(CHOICE,"^",8),"   ",$P(CHOICE,"^",4)
 ;
ASKNUM I J<1 G PARTLQ
 W !,"   Choose 1-",J,": " R ANS2:DTIME
 I '$T!($E(ANS2,1)="^")!(ANS2="") S SEL="" G PARTLQ
 I $E(ANS2,1)="?" W !,"Enter a number from 1 - ",J G ASKNUM
 S ANS2=+ANS2
 I ANS2<1!(ANS2>J) G ASKNUM
 I $G(IBD(ANS2))="" G ASKNUM
 W !
 S SEL=$G(IBD(ANS2))
PARTLQ Q SEL

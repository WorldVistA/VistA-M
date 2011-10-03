SRODLT1 ;B'HAM ISC/ADM - REPORT OF DELAY TIME (CONT) ; 14 FEB 1992  10:45 AM
 ;;3.0; Surgery ;;24 Jun 93
 S ^TMP("SR",$J)="0^0" D UTIL
 D HDR S SRREA=0 F  S SRREA=$O(^TMP("SR",$J,SRREA)) Q:'SRREA!(SRSOUT)  S REASON=$P(^SRO(132.4,SRREA,0),"^") D DELAY
 D:'SRSOUT TOTAL
 Q
DELAY ; print delay reason data
 I $Y+5>IOSL D HDR I SRSOUT Q
 S Y=^TMP("SR",$J,SRREA),SRDLAY=$P(Y,"^"),SRDLT=$P(Y,"^",2)
 W !,$E(REASON,1,30),?33,$J(SRDLAY,5),?46,$J(SRDLT,5)
 Q
TOTAL ; print delay reason totals
 I $Y+5>IOSL D HDR I SRSOUT Q
 S Y=^TMP("SR",$J),SRDLAY=$P(Y,"^"),SRDLT=$P(Y,"^",2)
 W !!,?24,"TOTAL",?32,$J(SRDLAY,6),?45,$J(SRDLT,6)
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit.  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W !,?(80-$L(SRINST)\2),SRINST,?72,"PAGE ",PAGE,!,?29,"Report of Delay Times"
 W !,?27,"From "_SRSDT_"  To "_SREDT,! I $E(IOST)="P" W "Printed: "_SRPRINT,!,?21,"Reviewed by:",?45,"Date Reviewed:",!
 W !,?34,"# OF",?45,"MINUTES",!,"DELAY REASON",?33,"DELAYS",?45,"DELAYED",! F LINE=1:1:80 W "="
 S SRHDR=1,PAGE=PAGE+1
 Q
UTIL ; set ^TMP
 S SRREA=0 F  S SRREA=$O(^TMP("SR",$J,SRREA)) Q:'SRREA!(SRSOUT)  D SET
 Q
SET ;
 S Y=^TMP("SR",$J,SRREA),$P(^TMP("SR",$J),"^")=$P(^TMP("SR",$J),"^")+$P(Y,"^"),$P(^TMP("SR",$J),"^",2)=$P(^TMP("SR",$J),"^",2)+$P(Y,"^",2)
 Q

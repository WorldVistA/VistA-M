SRODLT2 ;B'HAM ISC/ADM - REPORT OF DELAY TIME (CONT) ; 14 FEB 1992  10:45 AM
 ;;3.0; Surgery ;;24 Jun 93
 K ^TMP("SRT",$J),SRSPEC
 D HDR S SRSS=0 F  S SRSS=$O(SRSP(SRSS)) Q:'SRSS!(SRSOUT)  S ^TMP("SRT",$J,SRSS)="0^0",SRSPEC=">> Surgical Specialty: "_$P(^SRO(137.45,SRSS,0),"^")_" <<" D SUB,DELAY,TOTAL
 K ^TMP("SRT",$J)
 Q
DELAY S SRREA=0 F  S SRREA=$O(^TMP("SR",$J,SRREA)) Q:'SRREA!(SRSOUT)  I $D(^TMP("SR",$J,SRREA,SRSS)) S REASON=$P(^SRO(132.4,SRREA,0),"^") D PRINT
 Q
PRINT ; 
 I $Y+5>IOSL D HDR I SRSOUT Q
 S Y=^TMP("SR",$J,SRREA,SRSS),SRDLAY=$P(Y,"^"),SRDLT=$P(Y,"^",2)
 S $P(^TMP("SRT",$J,SRSS),"^")=$P(^TMP("SRT",$J,SRSS),"^")+SRDLAY
 S $P(^TMP("SRT",$J,SRSS),"^",2)=$P(^TMP("SRT",$J,SRSS),"^",2)+SRDLT
 W !,$E(REASON,1,30),?33,$J(SRDLAY,5),?46,$J(SRDLT,5)
 Q
TOTAL ; print delay reason totals
 I $Y+5>IOSL D HDR I SRSOUT Q
 S Y=^TMP("SRT",$J,SRSS),SRDLAY=$P(Y,"^"),SRDLT=$P(Y,"^",2)
 W !!,?24,"TOTAL",?32,$J(SRDLAY,6),?45,$J(SRDLT,6)
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit.  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W !,?(80-$L(SRINST)\2),SRINST,?72,"PAGE ",PAGE,!,?29,"Report of Delay Times"
 W !,?27,"From "_SRSDT_"  To "_SREDT,! I $E(IOST)="P" W "Printed: "_SRPRINT,!,?21,"Reviewed by:",?45,"Date Reviewed:",!
 W !,?34,"# OF",?45,"MINUTES",!,"DELAY REASON",?33,"DELAYS",?45,"DELAYED",! F LINE=1:1:80 W "="
 S (SRHDR,SRPAGE)=1,PAGE=PAGE+1 D:$D(SRSPEC) SUB1
 Q
SUB ; print specialty sub-heading
 I $Y+7>IOSL D HDR I SRSOUT!('SRPAGE) Q
 I 'SRPAGE W !! F LINE=1:1:80 W "-"
SUB1 W !,?(80-$L(SRSPEC)\2),SRSPEC,! S SRPAGE=0
 Q

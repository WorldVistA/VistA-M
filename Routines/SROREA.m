SROREA ;B'HAM ISC/MAM - DELAY REASONS ; 3 DEC 1990 2:20 PM
 ;;3.0; Surgery ;;24 Jun 93
 I SROTOT D HDR Q:SRSOUT
 I 'SROTOT D PAGE Q:SRSOUT
 S CAUSE=0 F  S CAUSE=$O(^TMP("SR",$J,CAUSE)) Q:'CAUSE!(SRSOUT)  D PRINT
 Q:SRSOUT  W !!,"TOTAL DELAY REASONS",?65,$J(^TMP("SR",$J),5)
 Q
PRINT ; display results
 I $Y+4>IOSL D PAGE I SRSOUT Q
 W !,$P(^SRO(132.4,CAUSE,0),"^"),?65,$J(^TMP("SR",$J,CAUSE),5)
 Q
PAGE S X="" I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Enter RETURN to continue displaying the delay reasons for the entire",!,"medical center." G PAGE
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S X=$E(SRSD,4,5)_"/"_$E(SRSD,6,7)_"/"_$E(SRSD,2,3),Y=$E(SRED,4,5)_"/"_$E(SRED,6,7)_"/"_$E(SRED,2,3),PAGE=PAGE+1 I $Y W @IOF
 W:$E(IOST)="P" !,?(80-$L(SRINST)\2),SRINST,!,?32,"SURGICAL SERVICE" W !,?28,"REPORT OF DELAY REASONS",!,?27,"FROM "_X_"  TO "_Y
 I $E(IOST)="P" W !!,?21,"REVIEWED BY:",?45,"DATE REVIEWED:",!!
 W !! F LINE=1:1:80 W "="
 W !!
 Q

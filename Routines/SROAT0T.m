SROAT0T ;B'HAM ISC/MAM - ATTENDING SURGEON CUMULATIVE ; [ 05/11/04  2:33 PM ]
 ;;3.0; Surgery ;**50,129**;24 Jun 93
 I SRBOTH D PAGE I SRSOUT Q
 D HDR Q:SRSOUT  W !!,?1,"TOTAL CASES",?16,"ATTENDING CODE",!,?1,"-----------",?16,"--------------"
 S (HDR,CODE)="" F  S CODE=$O(^TMP("SRTOT",$J,CODE)) Q:CODE=""  D PRINT
 W !!,?1,$J(^TMP("SRTOT",$J),6),?16,"TOTAL CASES FROM "_$E(SRSD,4,5)_"/"_$E(SRSD,6,7)_"/"_$E(SRSD,2,3)_" TO "_$E(SRED,4,5)_"/"_$E(SRED,6,7)_"/"_$E(SRED,2,3)
 Q
PRINT I 'CODE S SRCODE="ATTENDING CODE NOT ENTERED"
 I CODE S Y=CODE,C=$P(^DD(130,.166,0),"^",2) D Y^DIQ S SRCODE=Y
 W !,?1,$J(^TMP("SRTOT",$J,CODE),6),?16,SRCODE
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I +$Y W @IOF
 W !,?(80-$L(SRINST)\2),SRINST,!,?32,"SURGICAL SERVICE",!,?22,"ATTENDING SURGEON CUMULATIVE REPORT"
 W !,?(80-$L(SRFRTO)\2),SRFRTO
 I $E(IOST)="P" W !,?30,SRPRINT,!!,?8,"REVIEWED BY: ",?53,"DATE REVIEWED: "
 W ! F LINE=1:1:80 W "="
 W !!,?(80-$L(SRATT)\2),SRATT,!,?(80-$L(SRATT)\2),SRATT1
 Q
PAGE S X="" I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Enter RETURN to continue printing the report, or '^' to exit from this option." G PAGE
 Q

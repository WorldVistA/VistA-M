ENEQRP4 ;(WASH ISC)/DH-Report of High Failure Items ;1.14.98
 ;;7.0;ENGINEERING;**48**;Aug 17, 1993
 Q
FAP ;REPORT PRINT SECTION
 I $D(^TMP($J,"ENEQFA")) G FAPC
 W !!,"There is no equipment" W:ENDVTYP'=0 " of type ",ENDVTYP W " with ",ENN," or more failures",!,"from ",$E(ENFR,4,5),"-",$E(ENFR,6,7),"-",$E(ENFR,2,3)," to ",$E(ENTO,4,5),"-",$E(ENTO,6,7),"-",$E(ENTO,2,3),".",!!
 G DONE
 ;
FAPC W:IO'=IO(0) !,"beginning report..." U IO S ENPG=0 D T F I=1:1:9 S ENT(I)=0
 W:$E(IOST,1,2)="C-" @IOF
 D FAP1 S DA="" D FAP2,FAP3 G DONE
 ;
FAP1 W:ENPG @IOF S ENPG=ENPG+1 W "EQUIPMENT REPAIRS (",$S(ENDVTYP=0:"ALL EQUIPMENT",1:ENDVTYP),")",?45,ENDATE,?70,"Page ",ENPG
 W !,?10,"From: ",$E(ENFR,4,5),"-",$E(ENFR,6,7),"-",$E(ENFR,2,3),"   To: ",$E(ENTO,4,5),"-",$E(ENTO,6,7),"-",$E(ENTO,2,3)
 W !,"Reference",?12,"Entry #",?29,"Hrs",?35,"Labor$",?43,"Mat'l$",?52,"Vndr$",?62,"Total$",?70,"Worker",! F K=1:1:79 W "-"
 S ENY=5
 Q
FAP2 S DA=$O(^TMP($J,"ENEQFA",DA)),I=1,ENA=0 Q:DA=""  ;S ENPMN="" I $D(^ENG(6914,DA,3)) S ENPMN=$P(^(3),U,6)
 ;S:ENPMN="" ENPMN="None"
FAP21 S ENR=$P(^TMP($J,"ENEQFA",DA,ENA),"^",I) I ENR="" S ENA=$O(^TMP($J,"ENEQFA",DA,ENA)) G:ENA'>0 FAP2 S I=1 G FAP21
 S ENHS=^ENG(6914,DA,6,ENR,0) S I=I+1 F J=1:1:8 S E(J)=$P(ENHS,U,J)
 S:E(1)]"" E(1)=$E(E(1),2,30)
 S E(9)=E(5)+E(6)+E(7),ENT(9)=ENT(9)+E(9) F J=4:1:7 S ENT(J)=ENT(J)+E(J)
 W !,E(1),?12,DA,?27,$J(E(4),5,1),?33,$J(E(5),8,2),?41,$J(E(6),8,2),?50,$J(E(7),8,2),?60,$J(E(9),8,2),?70,$E(E(8),1,9) S ENY=ENY+1
 G:ENY'>(IOSL-4) FAP21 D FAP4 I $D(R),$E(R)="^" K R Q
 G FAP21
FAP3 I $D(R),$E(R)="^" Q
 W ! F I=1:1:79 W "_"
 W !,"TOTAL",?27,$J(ENT(4),5,1),?35,$J(ENT(5),6,2),?43,$J(ENT(6),6,2),?52,$J(ENT(7),6,2),?62,$J(ENT(9),6,2)
 Q
FAP4 D:$E(IOST,1,2)="C-" HOLD I $D(R),$E(R)="^" G DONE
 D FAP1 Q
 ;
T S %DT="T",X="N" D ^%DT S ENNDATE=Y X ^DD("DD") S ENDATE=Y K X,Y Q
HOLD W !!,"Press <RETURN> to continue or ""^"" to escape " R R:DTIME S:'$T R="^"
 Q
DONE D:$E(IOST,1,2)="C-" HOLD W @IOF
 I '$D(ZTQUEUED),$E(IOST,1,2)="P-" D ^%ZISC
 K E,ENDA,ENDVTYP,ENFR,ENTO,ENH,ENFY,ENQT,ENHS,ENN,ENNDATE,ENPMN,ENR,ENSTR,ENT,ENVEND,ENY,ENDATE,ENA,R,ENERR,ENPG
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENEQRP4

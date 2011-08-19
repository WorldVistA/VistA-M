GMRAFN2 ;HIRMFO/WAA-FDA PART 2 MEDWATCH FORM ;11/30/95  15:19
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
FORM ;This is the main form entry point
 W !,"MEDWatch",?80,"Approved by FDA on 10/20/93"
 W !,$E(LINE1,1,42),?79,$E(LINE1,79,131)
 W !,"THE FDA MEDICAL PRODUCTS REPORTING PROGRAM",?79,"| Triage unit sequence #",?131,"|"
 W !,$E(LINE1,1,42),?79,$E(LINE1,79,131)
 W !,?79,"|",?131,"|"
 W !,?59,"Page ",GMRAPG1," of ",GMRAPG2,?79,$E(LINE1,79,131)
 W !,$E(LINE2,1,66),"|",$E(LINE2,68,131)
 W !,"A. Patient Information",?66,"| C. Suspect Medication(s)"
 W !,$E(LINE1,1,66),"|",$E(LINE1,68,131)
 W !,"1. Patient Indentifier|2. DOB: ",+$E(GMRADOB,4,5),"/",+$E(GMRADOB,6,7),"/",$E(GMRADOB,2,3),?43,"|3. Sex|4. Weight",?66,"|1. Name"
 W !,GMRAID,?22,"|   AGE: "
AGE ;Age at time of event
 I GMRAPG1=1 S X1=$P(GMRAPA1(0),U),X2=GMRADOB S X=($E(X1,1,3))-($E(X2,1,3)) S:($E(X1,4,7))<($E(X2,4,7)) X=X-1 W X K X,X1,X2 W ?39,"yrs |"
 I GMRAPG1'=1 W ?39,"yrs |"
SEX ;Sex,weight
 I GMRAPG1=1 W $P(GMRASEX,U,2),?50,"|",$J((GMRAWEI*.4536),5,1) W:GMRAWEI'="" " kg" W ?66
 I GMRAPG1'=1 W ?50,"|     kg",?66
SUSPECT ;THIS WILL GET THE NEXT SUSPECTED AGENT
 S GMRASUS=$O(^TMP($J,"GMR","A",GMRASUS)) I GMRASUS'<1 S GMRASUS1=GMRASUS
 S GMRAGNT1=$S(GMRASUS="":"",1:$G(^TMP($J,"GMR","A",GMRASUS1)))
 S:GMRASUS="" GMRASUS1=""
 W "|  #",GMRASUS1," : " W $E($P(GMRAGNT1,U),1,30)
 W !,$E(LINE2,1,66),"|",$E(LINE1,68,131)
 W !,"B. Adverse Event or Product Problem",?66
 S GMRASUS=$O(^TMP($J,"GMR","A",GMRASUS)) I GMRASUS'<1 S GMRASUS2=GMRASUS
 I GMRASUS<1 S GMRASUS2=""
 E  S GMRAGNT2=(^TMP($J,"GMR","A",GMRASUS))
 W "|" W:GMRASUS2'="" "  #",GMRASUS2," : ",$E($P(GMRAGNT2,U),1,30)
 W !,$E(LINE1,1,66),"|",$E(LINE1,68,131)
 W !,"1. [X]Adverse Event         [ ]Product problem",?66,"|2. Dose,frequency & route used",?99,"| 3. Therapy dates"
 W !,$E(LINE1,1,66),"|  #",GMRASUS1,":" W $E($P(GMRAGNT1,U,2),1,8) I $P(GMRAGNT1,U,2)'="",$P($G(^TMP($J,"GMR","A",GMRASUS1,1)),U,5)'="" W ","
 I GMRASUS1'="",$P($G(^TMP($J,"GMR","A",GMRASUS1,1)),U,5)'="" W $E($P($G(^TMP($J,"GMR","A",GMRASUS1,1)),U,5),1,8) I $P(GMRAGNT1,U,3)'="" W ","
 W $E($P(GMRAGNT1,U,3),1,8),?99,"|  #",GMRASUS1," : "
 I GMRASUS1'="",$D(^TMP($J,"GMR","A",GMRASUS1,1)) S DT=$P(^(1),U) I DT'="" S DT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) W DT
 I GMRASUS1'="",$D(^TMP($J,"GMR","A",GMRASUS1,1)) S DT=$P(^(1),U,2) I DT'="" S DT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) W "-",DT
 W !,"2. Outcomes attributed to adverse event",?66,"|",$E(LINE1,66,97),"|",$E(LINE1,99,130)
 S X1=0 W !,"   ["
 I GMRAPG1=1 W $S($P(^GMR(120.85,GMRAPA1,0),U,3)="y":"X",1:" ") S:$P(^(0),U,3)="y" X1=1 W "] death: " I X1=1 S Y=$P($G(^DPT(DFN,.35)),U) I Y'<1  W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 I GMRAPG1'=1 W " ] death:"
 W ?30,"["
 I GMRAPG1=1 W $S($P(^GMR(120.85,GMRAPA1,0),U,10)="y":"X",1:" ") S:$P(^(0),U,10)="y" X1=1 W "] disability"
 I GMRAPG1'=1 W " ] disability"
 W ?66,"|" I GMRASUS2'="" W "  #",GMRASUS2,":" W $E($P(GMRAGNT2,U,2),1,8) I $P(GMRAGNT2,U,2)'="",$P($G(^TMP($J,"GMR","A",GMRASUS2,1)),U,5)'="" W ","
 I GMRASUS2,$P($G(^TMP($J,"GMR","A",GMRASUS2,1)),U,5)'="" W $E($P($G(^TMP($J,"GMR","A",GMRASUS2,1)),U,5),1,8) I $P(GMRAGNT2,U,3)'="" W ","
 I GMRASUS2'="" W $E($P(GMRAGNT2,U,3),1,(24-$L($E($P(GMRAGNT2,U,2),1,12)))),?99,"|  #",GMRASUS2," : " D
 .I $D(^TMP($J,"GMR","A",GMRASUS2,1)) S DT=$P(^(1),U) S DT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) W DT
 .I $D(^TMP($J,"GMR","A",GMRASUS2,1)) S DT=$P(^(1),U,2) I DT'="" S DT=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) W "-",DT
 .Q
 I GMRASUS2="" W ?99,"|"
 S X2=0 W !,"   ["
 I GMRAPG1=1 W $S($P(^GMR(120.85,GMRAPA1,0),U,5)="y":"X",1:" ") S:$P(^(0),U,5)="y" X1=1 W "] life-threatening"
 I GMRAPG1'=1 W " ] life-threatening"
 S X2=0 W ?30,"["
 I GMRAPG1=1 W $S($P(^GMR(120.85,GMRAPA1,0),U,16)="y":"X",1:" ") S:$P(^(0),U,16)="y" X1=1 W "] congenital anomaly",?66,"|",$E(LINE1,68,131)
 I GMRAPG1'=1 W " ] congenital anomaly",?66,"|",$E(LINE1,68,131)
 W !,"   [" I GMRAPG1=1 D
 .I $P(^GMR(120.85,GMRAPA1,0),U,9)="y" W "X" S X1=1 Q
 .I $P(^GMR(120.85,GMRAPA1,0),U,7)="y" W "X" S X1=1 Q
 .W " "
 .Q
 I GMRAPG1'=1 W " "
 Q

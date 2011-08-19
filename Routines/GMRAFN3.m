GMRAFN3 ;HIRMFO/WAA-FDA PART 3 MEDWATCH FORM ;11/30/95  15:19
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
 S X2=0 W "] Hospitalization",?30,"["
 I GMRAPG1=1 W:$P(^GMR(120.85,GMRAPA1,0),U,17)="y" "X" S:$P(^(0),U,17)="y" (X2,X1)=1 W:'X2 " "
 W:GMRAPG1'=1 " " W "] required intervention to",?66,"|4. Diagnosis for use(indication)|5. Event abated after use"
 W !,"       initial or prolonged       prevent impairment/damage",?66,"|",?99,"|   stopped or dose reduced?"
 W ! I GMRAPG1=1 I $P(^GMR(120.85,GMRAPA1,0),U,7)="y"!($P(^(0),U,9)="y") D
 .I $P(^GMR(120.85,GMRAPA1,0),U,9)'="y" W ?7,"-------"
 .I $P(^GMR(120.85,GMRAPA1,0),U,9)="y" W ?18,"---------"
 .Q
 W ?30,"[" I GMRAPG1=1 W $S('X1:"X",1:" "),"] other"
 I GMRAPG1'=1 W " ] other"
 W ?66,"|  #",GMRASUS1,":",$E($P(GMRAGNT1,U,4),1,27),?99,"|  #",GMRASUS1,": [",$S(GMRASUS1="":"  ",$P($G(^TMP($J,"GMR","A",GMRASUS1,"LIKE")),U,3)="y":"YES",$P($G(^("LIKE")),U,3)="n":"NO",1:"N/A") W "]"
 W !,$E(LINE1,1,66),"|",$E(LINE1,68,99),"|",$E(LINE1,101,131)
 W !,"3. Date of event",?33,"|4. Date of this report"
 W ?66,"|" I GMRASUS2'="" W "  #",GMRASUS2,":",$E($P(GMRAGNT2,U,4),1,27),?99,"|  #",GMRASUS2,": [",$S($P($G(^TMP($J,"GMR","A",GMRASUS2,"LIKE")),U,3)="y":"YES",$P($G(^("LIKE")),U,3)="n":"NO",1:"N/A") W "]"
 I GMRASUS2="" W ?99,"|"
 W ! S %=$P(GMRAPA1(0),U) W ?4,$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3),?33,"|",?37 D NOW^%DTC W $E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)
 W ?66,"|",$E(LINE1,68,131)
 W !,$E(LINE1,1,66),"|6. Lot # (if known)  |7. Exp. date|8. Event reappeared after"
 W !,"5. Describe event or problem",?66,"|",?88,"|",?101,"|    reintroduction"
DESC ;This code is to find and print the reaction description
 S GMRANO=0 I GMRAPG1'=1 G DESC1
 I $D(^GMR(120.85,GMRAPA1,2,0)) S GMRANO=1,DIWL=5,DIWR=63,DIWF="" K ^UTILITY($J,"W",5) S GMRAX=0 D  K ^UTILITY($J,"W",5)
 .F  S GMRAX=$O(^GMR(120.85,GMRAPA1,2,GMRAX)) Q:GMRAX<1  S X=$P($G(^GMRD(120.83,$P($G(^GMR(120.85,GMRAPA1,2,GMRAX,0)),U),0)),U) D
 ..I X="OTHER REACTION" S X=$P($G(^GMR(120.85,GMRAPA1,2,GMRAX,0)),U,2)
 ..I GMRAX'=1 S X=", "_X
 ..D ^DIWP
 ..Q
 .S X=0 F  S X=$O(^UTILITY($J,"W",5,X)) Q:X<1  S ^TMP($J,"GMR","R",X)=$G(^UTILITY($J,"W",5,X,0))
 .Q
DESC1 W ! I GMRANO W ^TMP($J,"GMR","R",1) K ^(1) I '$D(^TMP($J,"GMR","R",2)) S GMRANO=0
 W ?66,"|  #",GMRASUS1,":",$E($P(GMRAGNT1,U,8),1,16),?88,"| #",GMRASUS1,":" I GMRASUS1'="" S GMRAX=$P($G(^TMP($J,"GMR","A",GMRASUS1,1)),U,3) D
 .I GMRAX'="" W $E(GMRAX,4,5),"/",$E(GMRAX,6,7),"/",$E(GMRAX,2,3)
 .W ?101,"|  #",GMRASUS1,": [",$S(GMRASUS1="":"  ",$P($G(^TMP($J,"GMR","A",GMRASUS1,"LIKE")),U,6)="y":"YES",$P($G(^("LIKE")),U,6)="n":"NO",1:" "),"]"
 .Q
 W ! I GMRANO W ^TMP($J,"GMR","R",2) K ^(2) I '$D(^TMP($J,"GMR","R",3)) S GMRANO=0
 W ?66,"|",$E(LINE1,68,88),"|",$E(LINE1,90,101),"|",$E(LINE1,103,131)
 W ! I GMRANO W ^TMP($J,"GMR","R",3) K ^(3) I '$D(^TMP($J,"GMR","R",4)) S GMRANO=0
 W ?66,"|  " I GMRASUS2'="" W "#",GMRASUS2,":",$E($P(GMRAGNT2,U,8),1,16)
 W ?88,"| " I GMRASUS2'="" W "#",GMRASUS2,":" S GMRAX=$P($G(^TMP($J,"GMR","A",GMRASUS2,1)),U,3) I GMRAX'="" W $E(GMRAX,4,5),"/",$E(GMRAX,6,7),"/",$E(GMRAX,2,3)
 W ?101,"|  " I GMRASUS2'="" W "#",GMRASUS2,": [",$S($P($G(^TMP($J,"GMR","A",GMRASUS2,"LIKE")),U,6)="y":"YES",$P($G(^("LIKE")),U,6)="n":"NO",1:" "),"]"
 W ! I GMRANO W ^TMP($J,"GMR","R",4) K ^(4) I '$D(^TMP($J,"GMR","R",5)) S GMRANO=0
 W ?66,"|",$E(LINE1,67,130)
 W ! I GMRANO W $S('$D(^TMP($J,"GMR","R",6)):^TMP($J,"GMR","R",5),1:"   SEE ATTACHED") K:'$D(^TMP($J,"GMR","R",6)) ^TMP($J,"GMR","R",5)
 W ?66,"|9. (Not applicable to adverse drug event reports)"
 K GMRANO W !,$E(LINE1,1,66),"|",$E(LINE1,68,131)
 K GMRAGNT1 K:GMRASUS1'="" ^TMP($J,"GMR","A",GMRASUS1)
 I GMRASUS2'="" K ^TMP($J,"GMR","A",GMRASUS2),GMRAGNT2
 Q

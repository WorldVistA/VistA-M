DGODNSM1 ;ALB/EG - INPATIENT WORKLOAD SUMMARY, TOTALS ; 3/1/89 1500
 ;;5.3;Registration;;Aug 13, 1993
 ;;V 4.5
TOT1 F I=30:10:110 W ?I,"------"
 W !,?1,"SUBTOTAL",?30,^UTILITY("DGOD",$J,"T",K,"C",1),?40,^(2),?50,^(3),?60,^(4),?70,^(5),?80,^(6),?90,^(7)
 W ?100,^UTILITY("DGOD",$J,"T",K,"R")
 W:^UTILITY("DGOD",$J,"T",K,"R")>0 ?110,"("_$J(^UTILITY("DGOD",$J,"T",K,"R")/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)_")"
 Q:^UTILITY("DGOD",$J,"T",K,"R")=0
 W !,?1,"SUBTOTAL %",?30,$J(^UTILITY("DGOD",$J,"T",K,"C",1)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2),?40,$J(^UTILITY("DGOD",$J,"T",K,"C",2)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)
 W ?50,$J(^UTILITY("DGOD",$J,"T",K,"C",3)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2),?60,$J(^UTILITY("DGOD",$J,"T",K,"C",4)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)
 W ?70,$J(^UTILITY("DGOD",$J,"T",K,"C",5)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2),?80,$J(^UTILITY("DGOD",$J,"T",K,"C",6)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)
 W ?90,$J(^UTILITY("DGOD",$J,"T",K,"C",7)/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)
 W ?100,$J(^UTILITY("DGOD",$J,"T",K,"R")/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)
 Q
 ;
TOT W ! F I=30:10:100 W ?I,"======"
 W !,?1,"TOTAL",?30,^UTILITY("DGOD",$J,"T","C",1),?40,^(2),?50,^(3),?60,^(4),?70,^(5),?80,^(6),?90,^(7)
 W ?100,^UTILITY("DGOD",$J,"T","C")
 W !,?1,"TOTAL %",?30,$J(^UTILITY("DGOD",$J,"T","C",1)/^UTILITY("DGOD",$J,"T","C")*100,2,2),?40,$J(^UTILITY("DGOD",$J,"T","C",2)/^UTILITY("DGOD",$J,"T","C")*100,2,2)
 W ?50,$J(^UTILITY("DGOD",$J,"T","C",3)/^UTILITY("DGOD",$J,"T","C")*100,2,2),?60,$J(^UTILITY("DGOD",$J,"T","C",4)/^UTILITY("DGOD",$J,"T","C")*100,2,2)
 W ?70,$J(^UTILITY("DGOD",$J,"T","C",5)/^UTILITY("DGOD",$J,"T","C")*100,2,2),?80,$J(^UTILITY("DGOD",$J,"T","C",6)/^UTILITY("DGOD",$J,"T","C")*100,2,2)
 W ?90,$J(^UTILITY("DGOD",$J,"T","C",7)/^UTILITY("DGOD",$J,"T","C")*100,2,2)
 W ?100,$J(^UTILITY("DGOD",$J,"T","C")/^UTILITY("DGOD",$J,"T","C")*100,2,2),!
 Q
 ;

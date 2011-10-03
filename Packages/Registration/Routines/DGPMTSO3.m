DGPMTSO3 ;ALB/LM - TREATING SPECIALTY INPATIENT COUNTS BY TS ;2-2-93
 ;;5.3;Registration;;Aug 13, 1993
 ;
START Q:'PTCTS
 S REPORT="< <  PATIENT COUNT BY TREATING SPECIALTY  > >"
 S (PAGE,TOTAL)=0
 D HEAD^DGPMTSO
 D SUBHEAD
 ;
DIV S DIV="" F DIV1=0:0 S DIV=$O(^TMP($J,"PTCTS",DIV)) Q:DIV=""  D:$Y+8>IOSL HEAD^DGPMTSO,SUBHEAD Q:END  W !?5,"DIVISION: ",$S($D(^DG(40.8,DIV,0)):$P(^(0),"^"),1:"EMPTY") D TREAT Q:END  D SUB Q:END
 ;
 G:END END
 D:$Y+8>IOSL HEAD^DGPMTSO,SUBHEAD Q:END
 W !?63 F L=1:1:(IOM-66) W "-"
 W !!?69,"TOTAL   =  ",$J($P(TOTAL,"^",1),4),?89,$J($P(TOTAL,"^",2),4),?97,$J($P(TOTAL,"^",3),4),?105,$J($P(TOTAL,"^",4),4),?114,$J($P(TOTAL,"^",5),4),?124,$J($P(TOTAL,"^",6),4)
 S PTCTS=0
 ;
END K ABBRV,DGTS,DGTS1,DIV,DIV1,I,INFO,L,PAGE,REPORT,SERVICE,SUBCOUNT,TOTAL,TREAT,TREAT1,SV,SV1,PTCTS
 Q
 ;
TREAT S TREAT="" F TREAT1=0:0 S TREAT=$O(^TMP($J,"PTCTS",DIV,TREAT)) Q:TREAT=""  D DGTS Q:END
 Q
 ;
DGTS S DGTS="" F DGTS1=0:0 S DGTS=$O(^TMP($J,"PTCTS",DIV,TREAT,DGTS)) Q:DGTS=""  D SV Q:END
 Q
 ;
SV S SV="" F SV1=0:0 S SV=$O(^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV)) Q:SV=""  D:$Y+8>IOSL HEAD^DGPMTSO,SUBHEAD Q:END  D INFO Q:END
 Q
 ;
INFO S ABBRV=$S($D(^DIC(45.7,DGTS,0)):$P(^DIC(45.7,DGTS,0),"^",3),1:"")
 S INFO=^TMP($J,"PTCTS",DIV,TREAT,DGTS,SV)
 S $P(INFO,"^",6)=$P(INFO,"^")-$P(INFO,"^",3)-$P(INFO,"^",4)-$P(INFO,"^",5) ; Current patient minus absences except Pass equals patient's remaining.
 ;
 I $Y+8>IOSL D HEAD^DGPMTSO,SUBHEAD Q:END
LINE W !?3,TREAT,?35,ABBRV,?43,$S(SV'=0:SV,1:""),?80,$J($P(INFO,"^",1),4),?89,$J($P(INFO,"^",2),4),?97,$J($P(INFO,"^",3),4),?105,$J($P(INFO,"^",4),4),?114,$J($P(INFO,"^",5),4),?124,$J($P(INFO,"^",6),4)
 Q
 ;
 ;
SUB D:$Y+6>IOSL HEAD^DGPMTSO Q:END
 S SUBCOUNT=^TMP($J,"PTCTS",DIV)
 S $P(SUBCOUNT,"^",6)=$P(SUBCOUNT,"^")-$P(SUBCOUNT,"^",3)-$P(SUBCOUNT,"^",4)-$P(SUBCOUNT,"^",5) ; Current patient minus absences except Pass equals patient's remaining.
 W !?66 F L=1:1:(IOM-69) W "-"
 W !!?66,"SUBCOUNT   =  ",$J($P(SUBCOUNT,"^",1),4),?89,$J($P(SUBCOUNT,"^",2),4),?97,$J($P(SUBCOUNT,"^",3),4),?105,$J($P(SUBCOUNT,"^",4),4),?114,$J($P(SUBCOUNT,"^",5),4),?124,$J($P(SUBCOUNT,"^",6),4),!
 ;
TOTAL S $P(TOTAL,"^",1)=$P(TOTAL,"^",1)+$P(SUBCOUNT,"^",1) ; current patients
 S $P(TOTAL,"^",2)=$P(TOTAL,"^",2)+$P(SUBCOUNT,"^",2) ; pass
 S $P(TOTAL,"^",3)=$P(TOTAL,"^",3)+$P(SUBCOUNT,"^",3) ; aa
 S $P(TOTAL,"^",4)=$P(TOTAL,"^",4)+$P(SUBCOUNT,"^",4) ; ua
 S $P(TOTAL,"^",5)=$P(TOTAL,"^",5)+$P(SUBCOUNT,"^",5) ; asih
 S $P(TOTAL,"^",6)=$P(TOTAL,"^")-$P(TOTAL,"^",3)-$P(TOTAL,"^",4)-$P(TOTAL,"^",5) ; Current patient minus absences except Pass equals patient's remaining.
 Q
 ;
SUBHEAD ;
 Q:END
 W !!!,"DIVISION",!?3,"FACILITY TREATING SPECIALTY",?35,"ABBRV",?43,"TREATING SPECIALTY SERVICE",?76,"PATIENTS",?89,"PASS",?99,"AA",?107,"UA",?114,"ASIH",?122,"PTS REM",!
 F L=1:1:(IOM-3) W "-"
 Q

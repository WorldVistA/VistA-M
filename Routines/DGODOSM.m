DGODOSM ;ALB/EG - OUTPATIENT WORKLOAD SUMMARY ; 2/28/89 1600
 ;;5.3;Registration;;Aug 13, 1993
 ;;V 4.5
 S A1X="AS^AN^B^C^N^X^U"
 S HR="Outpatient Workload Summary",^UTILITY("DGOD",$J,"T","C")=0 W @IOF,!,?((IOM-$L(HR))/2),HR,?IOM-20,T2,!
 W !,?1,"DATE RANGE: FROM  " S Y=DGBD X ^DD("DD") W Y,"  TO  " S Y=DGND X ^DD("DD") W Y,!
 F K=1:1:DGTN S ^UTILITY("DGOD",$J,"T",K,"R")=0 F I=1:1:A2 S ^UTILITY("DGOD",$J,"T",K,I,"R")=0 F J=1:1:7 S (^UTILITY("DGOD",$J,"T1",K,I,J),^UTILITY("DGOD",$J,"T",K,I,J))=0,^UTILITY("DGOD",$J,"T",K,"C",J)=0
 F J=1:1:7 S ^UTILITY("DGOD",$J,"T","C",J)=0
 F K=1:1:DGTN F I=1:1:A2 S ^UTILITY("DGOD",$J,"T",K,I)=0
 F K=1:1:DGTN F I=1:1:A2 F DGMT=1:1:7 S DGDV=$E($P(A(I),U,2)_"     ",1,5) I ^UTILITY("DGOD",$J,DGJB,K,"TOT",DGDV)>0 S ^UTILITY("DGOD",$J,"T1",K,I,DGMT)=^UTILITY("DGOD",$J,"T1",K,I,DGMT)+^UTILITY("DGOD",$J,DGJB,K,"TOT",DGDV,$P(A1X,U,DGMT))
 F K=1:1:DGTN F I=1:1:A2 F DGMT=1:1:7 S DGDV=$E($P(A(I),U,2)_"     ",1,5) I ^UTILITY("DGOD",$J,DGJB,K,"TOT",DGDV)>0 S ^UTILITY("DGOD",$J,"T",K,I,DGMT)=^UTILITY("DGOD",$J,"T",K,I,DGMT)+^UTILITY("DGOD",$J,"T1",K,I,DGMT)
 F K=1:1:DGTN F I=1:1:A2 F DGMT=1:1:7 S ^UTILITY("DGOD",$J,"T",K,I,"R")=^UTILITY("DGOD",$J,"T",K,I,"R")+^UTILITY("DGOD",$J,"T",K,I,DGMT),^UTILITY("DGOD",$J,"T",K,"C",DGMT)=^UTILITY("DGOD",$J,"T",K,"C",DGMT)+^UTILITY("DGOD",$J,"T",K,I,DGMT)
 F K=1:1:DGTN F I=1:1:A2 S ^UTILITY("DGOD",$J,"T",K,"R")=^UTILITY("DGOD",$J,"T",K,"R")+^UTILITY("DGOD",$J,"T",K,I,"R")
 F K=1:1:DGTN W ! D HDR F I=1:1:A2 D PRI,TOT1^DGODOSM1:I=A2
 F K=1:1:DGTN S ^UTILITY("DGOD",$J,"T","C")=^UTILITY("DGOD",$J,"T","C")+^UTILITY("DGOD",$J,"T",K,"R") F J=1:1:7 S ^UTILITY("DGOD",$J,"T","C",J)=^UTILITY("DGOD",$J,"T","C",J)+^UTILITY("DGOD",$J,"T",K,"C",J)
 D TOT^DGODOSM1 W ! F I=1:1:4 W !,$P($T(LEG+I),";;",2)
END K A,A1X,A2,DGDV,DGMT,HDR1,HR,I,J,K
 Q
PRI Q:^UTILITY("DGOD",$J,"T",K,I,"R")=0
 S ZRT1="Hit RETURN to continue" I (IOST["C-")&(IO=IO(0))&(IOSL-$Y<4) W !,?IOM-$L(ZRT1)-2,ZRT1 R ZRT:DTIME S:'$T ZRT=U W @IOF D:$D(ZRT) HDR
 W !,?1,$P(A(I),U,2),?7,$P(A(I),U,1)
 W ?30,^UTILITY("DGOD",$J,"T",K,I,1),?40,^(2),?50,^(3),?60,^(4),?70,^(5),?80,^(6),?90,^(7)
 W ?100,^UTILITY("DGOD",$J,"T",K,I,"R")
 W ?110,"("_$J(^UTILITY("DGOD",$J,"T",K,I,"R")/^UTILITY("DGOD",$J,"T",K,"R")*100,2,2)_")",!
 Q
HDR S HDR1=$P($T(HD+K),";;",2) W !,?1,HDR1,!
 W !,?1,"DIVISION",?30,"AS",?40,"AN",?50,"B0",?60,"C0",?70,"N0",?80,"X0",?90,"U0",?100,"TOTAL",?110,"%",!
 Q
LEG ;
 ;;LEGEND: AS - Category A SC          N0 - Nonveteran
 ;;        AN - Category A NSC         X0 - Not Applicable
 ;;        B0 - Category B             U0 - Require means test
 ;;        C0 - Category C             
HD ;;
 ;;OUTPATIENT VISITS - W/O  10-10 VISITS
 ;;OUTPATIENT VISITS - 10/10 VISITS
 ;;OUTPATIENT VISITS - RESEARCH WORKLOAD

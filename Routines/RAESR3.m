RAESR3 ;HISC/GJC-Exam Statistics Rpt ;1/20/95  08:31
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PRT ; Update total and Print out date, # of visits, # of exams,
 ; # of completed exams, and category statistics.
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD
 F I=1:1:(RACNB+3) S $P(RATOT,"^",I)=$P(RATOT,"^",I)+$P(RASTAT,"^",I)
 W !,RADAT("X"),?13,$J(+$P(RASTAT,"^"),6),?20,$J(+$P(RASTAT,"^",2),6),?29,$J(+$P(RASTAT,"^",3),6),?35 F I=4:1:(RACNB+3) W ?($X+1),$J(+$P(RASTAT,"^",I),6)
 Q
TOT ; Print total line
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD
 W !,?13,"------",?20,"------",?29,"------",?35
 F T=1:1 Q:T>RACNB  W ?($X+1),"------"
 S:T1=1 RATOT=$G(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM))
 S:T1=2 RATOT=$G(^TMP($J,"RASTAT","RALOC",RADNM,RAINM))
 S:T1=3 RATOT=$G(^TMP($J,"RASTAT","RADIV",RADNM))
 S:T1=4 RATOT=$G(^TMP($J,"RASTAT","RATOT"))
TOT1 W !,"TOTAL",?13,$J(+$P(RATOT,"^"),6),?20,$J(+$P(RATOT,"^",2),6),?29,$J(+$P(RATOT,"^",3),6),?35 F I=4:1:(RACNB+3) W ?($X+1),$J(+$P(RATOT,"^",I),6)
 Q
HD ; Print out header info for each new location and each new division
 W:$E(IOST,1,2)="C-"!(RAPGE) @IOF
 W !?20,">>>>> EXAMINATION STATISTICS <<<<<"
 S RAPGE=RAPGE+1 W ?70,"Page: ",RAPGE
 S RADNM=$G(RADNM),RAINM=$G(RAINM),RALNM=$G(RALNM)
 I T1=1 D
 . W !!,"Division: ",$E(RADNM,1,25),?40,"Location: ",$E(RALNM,1,25)
 . W !,"Run Date: ",RARUNDT,?40,"Imaging Type: ",$E(RAINM,1,25)
 I T1=2 D
 . W !!,"Division: ",$E(RADNM,1,25),?40,"Location: "
 . W !,"Run Date: ",RARUNDT,?40,"Imaging Type: ",$E(RAINM,1,25)
 I T1=3 D
 . W !!,"Division: ",$E(RADNM,1,25),?40,"Location: "
 . W !,"Run Date: ",RARUNDT,?40,"Imaging Type: "
 I T1=4 D
 . W !!,"Division: ",?40,"Location: "
 . W !,"Run Date: ",RARUNDT,?40,"Imaging Type: "
 W !,$$CJ^XLFSTR(RATMEFRM,IOM)
 W !!,?27,"COMPLETE",?36,"--------------EXAM CATEGORY--------------"
 W !,"DATE",?13,"VISITS",?21,"EXAMS",?30,"EXAMS",?35 F T=1:1 Q:T>RACNB  W ?($X+4),$E($P(RADU,";",T),3,5)
 W !,RALINE
 Q

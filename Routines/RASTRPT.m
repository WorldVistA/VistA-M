RASTRPT ;HISC/DAD,FPT,SS AISC/TMP-Status Tracking Statistics Report ;2/12/99  14:45
 ;;5.0;Radiology/Nuclear Medicine;**8,10,20,24**;Mar 16, 1998
 ;Last Modifications by SS on July 25,2000 for patch P24
 S (RAPG,RACTR)=0,RACPT="" K RAFR U IO
 F RADV=0:0 D:$D(RAFR)&('RAXIT) SUM S RADV=$O(^TMP($J,"RASTAT",RADV)) Q:RADV'>0!RAXIT  D
 . I ^TMP($J,"RASTAT",RADV)=0 D NEGRPT Q
 . D:$G(RADRPTYN,0)=1 RPTP20^RASTRPT1 ;P20 by SS; if detailed needed P20A
BP1 . F RAFR=0:0 S RAFR=$O(^TMP($J,"RASTAT",RADV,"PROC",RAFR)) Q:RAFR'>0!RAXIT  D
 .. F RATO=0:0 S RATO=$O(^TMP($J,"RASTAT",RADV,"PROC",RAFR,RATO)) Q:RATO'>0!RAXIT  D HDR1,PROC
 .. Q
 . Q
 G Q
 ;
PROC F RAPRC=0:0 S RAPRC=$O(^TMP($J,"RASTAT",RADV,"PROC",RAFR,RATO,RAPRC)) Q:RAPRC'>0!RAXIT  S RAPROC=^TMP($J,"RASTAT",RADV,"PROC",RAFR,RATO,RAPRC) D DET1
 Q:'$D(^TMP($J,"RASTAT",RADV,"SUM",RAFR,RATO))!RAXIT
 S RASUM=$G(^TMP($J,"RASTAT",RADV,"SUM",RAFR,RATO)) D DET2
 Q
SUM Q:^TMP($J,"RASTAT",RADV)=0
 D HDR2 Q:RAXIT  F I1=0:0 S I1=$O(^TMP($J,"RASTAT",RADV,"SUM",I1)) Q:I1'>0!RAXIT  F I2=0:0 S I2=$O(^TMP($J,"RASTAT",RADV,"SUM",I1,I2)) Q:I2'>0!RAXIT  S RASUM=^TMP($J,"RASTAT",RADV,"SUM",I1,I2) D SUM1
 D:'RAXIT SUM2
 Q
DET1 W ! D CPT W RACPT,?32,$P(RAPROC,"^",4),?44,$P(RAPROC,"^",2)
 S X=$P(RAPROC,"^",6)\$P(RAPROC,"^",5) D MINUTS^RAUTL1 W ?56,Y,?70,$J($P(RAPROC,"^",5),5) S RACTR=RACTR+1
 I $Y>(IOSL-4) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) I 'RAXIT D HDR1
 K RAPROC
 Q
DET2 W !,?31,"----------",?43,"----------",?55,"----------",?67,"----------",!,?4,"Overall:" W ?32,$P(RASUM,"^",4),?44,$P(RASUM,"^",2)
 S X=$P(RASUM,"^",6)\$P(RASUM,"^",5) D MINUTS^RAUTL1 W ?56,Y,?70,$J($P(RASUM,"^",5),5)
 S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0)
 K RASUM
 Q
SUM1 W !,?4,"From: ",$S($D(^RA(72,+I1,0)):$P(^(0),"^"),1:"Unknown"),!,?4,"To  : ",$S($D(^RA(72,+I2,0)):$P(^(0),"^"),1:"Unknown")
 W ?32,$P(RASUM,"^",4),?44,$P(RASUM,"^",2)
 S X=$P(RASUM,"^",6)\$P(RASUM,"^",5) D MINUTS^RAUTL1 W ?56,Y,?70,$J($P(RASUM,"^",5),5),! S RACTR=RACTR+3
 I $Y>(IOSL-4) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) I 'RAXIT D HDR2
 K RASUM
 Q
SUM2 W !,?31,"----------",?43,"----------",?55,"----------",?67,"----------",!,?4,"From: ",$S($D(^RA(72,+RA(1),0)):$P(^(0),"^"),1:"Unknown"),!,?4,"To  : ",$S($D(^RA(72,+RA,0)):$P(^(0),"^"),1:"Unknown")
 Q:'$D(^TMP($J,"RASTAT",RADV,"COMPLETE"))  S RACOMP=^("COMPLETE") W ?32,$P(RACOMP,"^",4),?44,$P(RACOMP,"^",2)
 S X=$P(RACOMP,"^",6)\$P(RACOMP,"^",5) D MINUTS^RAUTL1 W ?56,Y ;P20 by SS
 I $Y>(IOSL-2) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) I 'RAXIT D HDR2 ;P20 by SS
 W !!?4,"Total number of exams moved to a status of COMPLETE" ;P20 by SS
 W !?4,"for period  ",$E(BEGDATE,4,5),"/",$E(BEGDATE,6,7),"/",$E(BEGDATE,2,3)," - ",$E(ENDDATE,4,5),"/",$E(ENDDATE,6,7),"/",$E(ENDDATE,2,3),": ",?70,$J($P(RACOMP,"^",5),5) ;P20 by SS
 Q:$O(^TMP($J,"RASTAT",RADV))'>0
 S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0)
 Q
HDR1 ; Header for non-division summary report
 S RAPG=RAPG+1 W:$E(IOST,1,2)="C-" @IOF
 I $E(IOST,1,2)="P-",(RAPG>1) W @IOF
 W !,?20,"** Status Tracking Statistics Report **",?71,"Page: ",$J(RAPG,3),!,?23,"Division Summary Procedure Detail",!!,?2,"Run Date: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3)
 W ?40,"For Period: ",$E(BEGDATE,4,5),"/",$E(BEGDATE,6,7),"/",$E(BEGDATE,2,3)," - ",$E(ENDDATE,4,5),"/",$E(ENDDATE,6,7),"/",$E(ENDDATE,2,3)
 W !?2,"Division: ",$E($P($G(RACCESS(DUZ,"DIV",RADV,+$O(RACCESS(DUZ,"DIV",RADV,0)))),U,2),1,25),?40,"Imaging Type: ",$E(RAIMAGE(0),1,25)
 W !?2,$$GETLOC^RASTRPT1(),?40,$$GETPROC^RASTRPT1() ;P20 by SS
 W !!,?10,"From: ",$S($D(^RA(72,+RAFR,0)):$P(^(0),"^"),1:"Unknown"),!,?10,"To  : ",$S($D(^RA(72,+RATO,0)):$P(^(0),"^"),1:"Unknown")
 W !!,?33,"Minimum",?45,"Maximum",?57,"Average",!,?34,"Time",?46,"Time",?58,"Time",?67,"Number of",!,?4,"Procedure (CPT)",?31,"(DD:HH:MM)",?43,"(DD:HH:MM)",?55,"(DD:HH:MM)",?67,"Procedures"
 W !,?4,"---------------",?31,"----------",?43,"----------",?55,"----------",?67,"----------",!
 S RACTR=0
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
HDR2 ; Header for division summary
 S RAPG=RAPG+1 W:$E(IOST,1,2)="C-" @IOF
 I $E(IOST,1,2)="P-",(RAPG>1) W @IOF
 W !?20,"** Status Tracking Statistics Report **",?71,"Page: ",$J(RAPG,3),!,?28,"Division Summary Overall",!!,?2,"Run Date: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3) ;P20
 W ?40,"For Period: ",$E(BEGDATE,4,5),"/",$E(BEGDATE,6,7),"/",$E(BEGDATE,2,3)," - ",$E(ENDDATE,4,5),"/",$E(ENDDATE,6,7),"/",$E(ENDDATE,2,3)
 W !?2,"Division: ",$E($P($G(RACCESS(DUZ,"DIV",RADV,+$O(RACCESS(DUZ,"DIV",RADV,0)))),U,2),1,25),?40,"Imaging Type: ",$E(RAIMAGE(0),1,25)
 W !?2,$$GETLOC^RASTRPT1(),?40,$$GETPROC^RASTRPT1() ;P20 by SS
 W !!,?33,"Minimum",?45,"Maximum",?57,"Average",!,?34,"Time",?46,"Time",?58,"Time",?67,"Number of",!,?31,"(DD:HH:MM)",?43,"(DD:HH:MM)",?55,"(DD:HH:MM)",?67,"Procedures"
 W !,?31,"----------",?43,"----------",?55,"----------",?67,"----------",!
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
Q K BEGDATE,ENDDATE,I,I1,I2,POP,RA,RACOMP,RACPT,RACTR,RADIVN,RADV,RAFR,RAI,RAIMAGE,RAMTIME,RAPG,RAPRC,RAQUIT,RASTAT,RATO,RAXIT,VAL,VAR,X,X1,X2,Y,Y1
 D CLOSE^RAUTL
 Q
 ;
CPT S RACPT=$G(^RAMIS(71,+RAPRC,0)) Q:RACPT=""
 S RAZZZ=$P($$NAMCODE^RACPTMSC(+$P(RACPT,"^",9),DT),"^")
 S RACPT=$E($P(RACPT,"^"),1,25)_"("_RAZZZ_")"
 K RAZZZ
 Q
NEGRPT ;
 S RADIVN(0)=$P($G(^DIC(4,RADV,0)),U,1)
 D HDR2 Q:RAXIT
 W !,"There are no statistics for this Division and Imaging Type combination.",!
 I $O(^TMP($J,"RASTAT",RADV))]"" S RAXIT=$$EOS^RAUTL5()
 Q
 ;

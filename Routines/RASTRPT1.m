RASTRPT1 ;HISC/SS-Status Tracking Statistics Report ;4/28/00  10:00
 ;;5.0;Radiology/Nuclear Medicine;**20**;Mar 16, 1998
 ;Last Modifications by SS on MAY 15,2000 for patch P20
RPTP20 ;P20, create report by requesting locations from ^TMP with proc details
 N RARL ;requesting location
 N RADV1 S RADV1=RADV,RARL=0
 N RAZZSSFL S RAZZSSFL="DETAILS"
 F  S RARL=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL)) Q:RARL=""!RAXIT  D
 .S RAFR=0 F  S RAFR=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"PROC",RAFR)) Q:RAFR'>0!RAXIT  D
 ..S RATO=0
 ..F  S RATO=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"PROC",RAFR,RATO)) Q:RATO'>0!RAXIT  D HDR3,PROC
 ..Q
 .Q
 D RPTP20S
 I +RA20RLOC>1 D PUTNOST(RAIMAGE,RADV1,$J)
 Q
RPTP20S ;P20, create report by requesting locations from ^TMP proc summary
 N RARL ;requesting location
 N RADV1 S RADV1=RADV,RARL=0
 N I1,I2
 N RAZZSSFL S RAZZSSFL="SUMMARY"
 F  S RARL=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL)) Q:RARL=""!RAXIT  D HDR3 Q:RAXIT  D
 .S RAFR=0 F  S RAFR=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"PROC",RAFR)) Q:RAFR'>0!RAXIT  D
 ..S RATO=0
 ..F  S RATO=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"PROC",RAFR,RATO)) Q:RATO'>0!RAXIT  S RASUM=^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"SUM",RAFR,RATO) D SUM1
 ..Q
BP2 .D:'RAXIT SUM2
 .Q
 Q
HDR3 ; Header for detailed report by requesting locations
 S RAPG=RAPG+1 W:$E(IOST,1,2)="C-" @IOF
 I $E(IOST,1,2)="P-",(RAPG>1) W @IOF
 W !,?20,"** Status Tracking Statistics Report **",?71,"Page: ",$J(RAPG,3)
 I RAZZSSFL="DETAILS" W !,?20,"Procedure Detail by Requesting Location"
 E  W !,?19,"Division Summary Requesting Location Details"
 I +RA20RLOC=0 W !?14,"(Only requesting locations with data are included)"
 W !!,?2,"Run Date: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3)
 W ?42,"For Period: ",$E(BEGDATE,4,5),"/",$E(BEGDATE,6,7),"/",$E(BEGDATE,2,3)," - ",$E(ENDDATE,4,5),"/",$E(ENDDATE,6,7),"/",$E(ENDDATE,2,3)
 W !?2,"Division: ",$E($P($G(RACCESS(DUZ,"DIV",RADV,+$O(RACCESS(DUZ,"DIV",RADV,0)))),U,2),1,25),?40,"Imaging Type: ",$E(RAIMAGE(0),1,25)
 Q:RAZZSSFL="NOSTAT"
 W !?2,"Requesting Location: ",$E(RARL,1,76)
 I RAZZSSFL="DETAILS" W !!,?10,"From: ",$S($D(^RA(72,+RAFR,0)):$P(^(0),"^"),1:"Unknown"),!,?10,"To  : ",$S($D(^RA(72,+RATO,0)):$P(^(0),"^"),1:"Unknown")
 W !,?33,"Minimum",?45,"Maximum",?57,"Average",!,?34,"Time",?46,"Time",?58,"Time",?67,"Number of",!
 I RAZZSSFL="DETAILS" W ?4,"Procedure (CPT)"
 W ?31,"(DD:HH:MM)",?43,"(DD:HH:MM)",?55,"(DD:HH:MM)",?67,"Procedures"
 I RAZZSSFL="DETAILS" W !,?4,"---------------"
 W !?31,"----------",?43,"----------",?55,"----------",?67,"----------",!
 I RAZZSSFL="DETAILS" S RACTR=0
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
 ;
PROC F RAPRC=0:0 S RAPRC=$O(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"PROC",RAFR,RATO,RAPRC)) Q:RAPRC'>0!RAXIT  S RAPROC=^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"PROC",RAFR,RATO,RAPRC) D DET1
 Q:'$D(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"SUM",RAFR,RATO))!RAXIT
 S RASUM=$G(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"SUM",RAFR,RATO)) D DET2
 Q
DET1 W !
 I RAZZSSFL="DETAILS" D CPT W RACPT
 W ?32,$P(RAPROC,"^",4),?44,$P(RAPROC,"^",2)
 S X=$P(RAPROC,"^",6)\$P(RAPROC,"^",5) D MINUTS^RAUTL1 W ?56,Y,?70,$J($P(RAPROC,"^",5),5) S RACTR=RACTR+1
 I $Y>(IOSL-4) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) I 'RAXIT D HDR3
 K RAPROC
 Q
 ;
DET2 W !,?31,"----------",?43,"----------",?55,"----------",?67,"----------",!,?4,"Overall:" W ?32,$P(RASUM,"^",4),?44,$P(RASUM,"^",2)
 S X=$P(RASUM,"^",6)\$P(RASUM,"^",5) D MINUTS^RAUTL1 W ?56,Y,?70,$J($P(RASUM,"^",5),5)
 S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0)
 K RASUM
 Q
 ;
CPT S RACPT=$G(^RAMIS(71,+RAPRC,0)) Q:RACPT=""
 S RAZZZ=$P($$NAMCODE^RACPTMSC(+$P(RACPT,"^",9),DT),"^")
 S RACPT=$E($P(RACPT,"^"),1,25)_"("_RAZZZ_")"
 K RAZZZ
 Q
 ;
GETLOC() ;P20 by SS
 N RA20 S RA20="Requesting Location:"
 I +RA20RLOC=0 Q RA20_"ALL"
 I +RA20RLOC=1 Q RA20_$E($P(RA20RLOC,"^",2),1,16)
 Q RA20_"ALL SELECTED"
GETPROC() ;P20 by SS
 N RA20 S RA20="Procedure:"
 I +RAPROCED=0 S RA20=RA20_"ALL"
 E  S RA20=RA20_$E($P(RAPROCED,"^",2),1,25)
 Q RA20
 ;
SUM1 W !,?4,"From: ",$S($D(^RA(72,RAFR,0)):$P(^(0),"^"),1:"Unknown"),!,?4,"To  : ",$S($D(^RA(72,+RATO,0)):$P(^(0),"^"),1:"Unknown")
 W ?32,$P(RASUM,"^",4),?44,$P(RASUM,"^",2)
 S X=$P(RASUM,"^",6)\$P(RASUM,"^",5) D MINUTS^RAUTL1 W ?56,Y,?70,$J($P(RASUM,"^",5),5),! S RACTR=RACTR+3
 I $Y>(IOSL-4) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) I 'RAXIT D HDR3
 K RASUM
 Q
SUM2 W !,?31,"----------",?43,"----------",?55,"----------",?67,"----------",!,?4,"From: ",$S($D(^RA(72,+RA(1),0)):$P(^(0),"^"),1:"Unknown"),!,?4,"To  : ",$S($D(^RA(72,+RA,0)):$P(^(0),"^"),1:"Unknown")
 Q:'$D(^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"COMPLETE"))  S RACOMP=^("COMPLETE") W ?32,$P(RACOMP,"^",4),?44,$P(RACOMP,"^",2)
 N RAZZSS1 S RAZZSS1=^TMP($J,"RAST",RAIMAGE,RADV1,RARL,"COUNT")
 S X=$P(RACOMP,"^",6)\$P(RACOMP,"^",5) D MINUTS^RAUTL1 W ?56,Y
 I $Y>(IOSL-2) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) I 'RAXIT D HDR3
 W !!?4,"Total number of exams moved to a status of COMPLETE"
 W !?4,"for period  ",$E(BEGDATE,4,5),"/",$E(BEGDATE,6,7),"/",$E(BEGDATE,2,3)," - ",$E(ENDDATE,4,5),"/",$E(ENDDATE,6,7),"/",$E(ENDDATE,2,3),": ",?70,$J(RAZZSS1,5)
 Q:$O(^TMP($J,"RASTAT",RADV1))'>0
 S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0)
 Q
 ;
PUTNOST(RAIM1,RADV1,RA20J) ;P20 by SS Display all locations which have not exams
 N RA20A,RA20B,RA20C,RA20PASS,RA20FL
 S RAZZSSFL="NOSTAT"
 S RA20PASS=0,RA20FL=0,RA20B="There are no statistics for following selected requesting locations:",$P(RA20C,"-",70)=""
STRT I RA20PASS>0 D HDR3 W !?2,RA20B,!?2,RA20C
 S RA20A=0
 F  S RA20A=$O(^TMP(RA20J,"RA REQ-LOC",RA20A)) G:RA20A="" LST I '$$ISTHERE(RAIM1,RADV1,RA20A) S RA20FL=1 Q:RA20PASS=0  W !?2,RA20A I $Y>(IOSL-4) S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0) Q:RAXIT  D HDR3 W !?2,RA20B,!?2,RA20C
LST I RA20PASS>0 S RAXIT=$S($E(IOST)="C":$$EOS^RAUTL5(),1:0)
 I RA20PASS=0,RA20FL=0 Q
 I RA20PASS=0 S RA20PASS=1 G STRT
 Q
ISTHERE(RAIM,RADV,RALOC) ;Does this requesting location have exams is in ^TMP($J..)
 N RA20A,RA20B,RA20C
 S (RA20A,RA20B)=0
 F  S RA20A=$O(^TMP($J,"RAST",RAIM,RADV,RA20A)) Q:RA20A=""  I RA20A=RALOC S RA20B=1 Q
 Q RA20B

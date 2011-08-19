RALWKL1 ;HISC/GJC-Workload Reports By Functional Area ;4/12/96  10:18
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ; Entry point
 S X="NOW",%DT="T" D ^%DT K %DT D D^RAUTL S RATDY=Y,$P(RALN,"-",81)=""
 S BEGDATE("X")=$$FMTE^XLFDT(BEGDATE,1)
 S ENDDATE("X")=$$FMTE^XLFDT(ENDDATE,1),RAPG=0 W:$Y>0 @IOF
 I RASUM D EN1^RALWKL4 Q  ; Do summary report quit.
 S RADIV=$O(^TMP($J,"RA","")),RAIMG=$O(^TMP($J,"RA",RADIV,""))
 S RADIV="" F  S RADIV=$O(^TMP($J,"RA",RADIV)) Q:RADIV']""  D  Q:RAXIT
 . S RAIMG="" F  S RAIMG=$O(^TMP($J,"RA",RADIV,RAIMG)) Q:RAIMG']""  D  Q:RAXIT
 .. S RAFLD=""
 .. F  S RAFLD=$O(^TMP($J,"RA",RADIV,RAIMG,RAFLD)) Q:RAFLD']""  D  Q:RAXIT
 ... S RATTL0=$G(^TMP($J,"RA",RADIV,RAIMG,RAFLD)),RAWWU1=$P(RATTL0,"^",5)
 ... S RATTL1=0 F I=1:1:4 S RATTL1=RATTL1+$P(RATTL0,"^",I)
 ... S RAMIS=0
 ... F  S RAMIS=$O(^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS)) Q:RAMIS'>0  D  Q:RAXIT
 .... Q:RAMIS'<25&(RAMIS'=27)&(RAMIS'=99)  S RAPRC=""
 .... F  S RAPRC=$O(^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS,RAPRC)) Q:RAPRC']""  D  Q:RAXIT
 ..... D PRT1
 ..... Q
 .... Q
 ... D:'RAXIT TOT
 ... Q
 .. D:'RAXIT IMGCHK^RALWKL2
 .. Q
 . D:'RAXIT&(RADIFLG(RADIV)>1) DIVCHK^RALWKL2
 . Q
 Q
PRT1 ; Tabulate the data for non summary report, output the data.
 S RATTL2=$G(^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS,RAPRC))
 S RAWWU2=$P(RATTL2,"^",5),RATTL3=0 ; Total up the first four pieces.
 F I=1:1:4 S RATTL3=RATTL3+$P(RATTL2,"^",I)
 D:'RAPG HD Q:RAXIT
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD Q:RAXIT
 W !,$E(RAPRC,1,28),?30,$J(+$P(RATTL2,"^"),5),?36,$J(+$P(RATTL2,"^",2),5)
 W ?42,$J(+$P(RATTL2,"^",3),5),?48,$J(+$P(RATTL2,"^",4),5)
 W ?55,$J(RATTL3,5),?62,$J($S(RATTL1:(100*RATTL3)/RATTL1,1:0),5,1)
 I $D(RAFL) D
 . W ?68,$J(RAWWU2,5),?75,$J($S(RAWWU1:(RAWWU2*100)/RAWWU1,1:0),5,1)
 . Q
 Q
TOT ; Total within Service, Ward, Clinic, etc.
 I 'RATTL1,('RAWWU1) Q
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD Q:RAXIT
 W !!,$G(RATITLE)_" Total"
 W ?30,$J(+$P(RATTL0,"^"),5),?36,$J(+$P(RATTL0,"^",2),5)
 W ?42,$J(+$P(RATTL0,"^",3),5),?48,$J(+$P(RATTL0,"^",4),5)
 W ?55,$J(RATTL1,5)
 W:$D(RAFL) ?68,$J(RAWWU1,5)
 W !,RALN N RA1 S RA1=$O(^TMP($J,"RA",RADIV,RAIMG,RAFLD))
 I RA1]"" N RAFLD S RAFLD=RA1,RAXIT=$$EOS^RAUTL5() D:'RAXIT HD
 Q
HD ; Header
 I RAPG!($E(IOST,1,2)="C-") W:$Y>0 @IOF
 S RAPG=RAPG+1
 W !?5,">>> "_RATITLE_" Workload Report <<<"
 W ?70,"Page: ",RAPG
 W !!?4,"Division: ",$S($D(^DIC(4,+RADIV,0)):$P(^(0),U,1),1:"UNKNOWN")
 W:'$D(RADIVSUM) !,"Imaging Type: ",$S($D(^RA(79.2,+$P(RAIMG,"-",2),0)):$P(^(0),U,1),1:"UNKNOWN")
 W ?52,"For period: ",?64,BEGDATE("X"),?77,"to"
 W !?4,"Run Date: ",RATDY,?64,ENDDATE("X")
 W !!?32,"-------Examinations------",!?62,"% of" W:$D(RAFL) ?75," % of"
 W !,$S('RASUM:"Procedure",1:RATITLE),?30," Inpt",?36,"  Opt"
 W ?42,"  Res",?48,"Other",?55,"Total",?62,"Exams"
 W:$D(RAFL) ?68,"  WWU",?75," WWU"
 W !,RALN
 W:$D(RADIVSUM) !?10,"(Division Summary)" ; set in DIVCHK^RALWKL2
 W:$D(RAIMGSUM) !?10,"(Imaging Type Summary)" ; set in IMGCHK^RALWKL2
 W:'$D(RADIVSUM)&('$D(RAIMGSUM))&('RASUM) !?10,RATITLE,": ",$G(RAFLD)
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
DISPXAM(A) ; Display Examination Statuses which meet certain criteria.
 ; 'A' is the equivalent of the variable 'RACRT'.  This code is related
 ; to the 'CRIT^RAUTL1' subroutine.  This sets up the RACRT local array
 ; according to I-Type.
 N RA,RAHD,UNDRLN,X,Y,Z
 S RAHD(0)="The entries printed for this report will be based only"
 S RAHD(1)="on exams that are in one of the following statuses:"
 W !!?(IOM-$L(RAHD(0))\2),RAHD(0),!?(IOM-$L(RAHD(1))\2),RAHD(1)
 S X="" F  S X=$O(^TMP($J,"RA I-TYPE",X)) Q:X']""  D  Q:RAXIT
 . I $D(^RA(72,"AA",X)) K UNDRLN S Y="" D
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 .. S $P(UNDRLN,"-",($L(X)+1))="" W !!?10,X,!?10,UNDRLN
 .. F  S Y=$O(^RA(72,"AA",X,Y)) Q:Y']""  D  Q:RAXIT
 ... S Z=0 F  S Z=$O(^RA(72,"AA",X,Y,Z)) Q:'Z  D  Q:RAXIT
 .... S RA(0)=$G(^RA(72,Z,0)),RA(.3)=$G(^RA(72,Z,.3))
 .... S RA(.3,A)=$P(RA(.3),"^",A)
 .... I RA(0)]"",(RA(.3)]""),(RA(.3,A)]""),("Yy"[RA(.3,A)) D
 ..... S RACRT(Z)=X ; Where 'X' is the I-Type
 ..... I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D
 ...... W @IOF,!?10,X,!?10,UNDRLN
 ...... Q
 ..... W !?15,$P(RA(0),"^")
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
 Q

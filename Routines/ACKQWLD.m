ACKQWLD ;AUG/JLTP BIR/PTD-Print A&SP Capitation Report ; [ 03/28/96   10:45 AM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
OPTN ;Introduce option.
 W @IOF,!,"This option produces a four-part capitation report.",!,"It includes demographic, diagnostic, procedure, and CDR data.",!
 D GETDT^ACKQWL G:$D(DIRUT) EXIT D INIT^ACKQWL
DEV W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^ACKQWLD",ZTDESC="QUASAR - Print A&SP Capitation Report",ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK G EXIT
DQ ;Entry point when queued.
 U IO
 D NOW^%DTC S ACKCDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0 K ^TMP("ACKQWLD",$J)
 D COMPILE,PRINT
EXIT ;ALWAYS EXIT HERE
 K %I,ACKBFY,ACKCDT,ACKDA,ACKEM,ACKM,ACKPG,AS,CDR,CPT,DIR,DIRUT,DTOUT,DUOUT,I,ICD,LN,T,X,XAS,Y,ZIP,^TMP("ACKQWLD",$J)
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
COMPILE ;Compile properly sorted data in ^TMP global.
 N AS,CPT,ICD,XAS,ZIP
 ;For all visits.
 S I=0 F  S I=$O(^ACK(509850.7,ACKDA,3,I)) Q:'I  D
 .S X=^ACK(509850.7,ACKDA,3,I,0)
 .S ^TMP("ACKQWLD",$J,1,$P(X,U,5),$P(X,U))=$P(X,U,2,4)
 .Q
 ;For ICD statistics.
 S I=0 F  S I=$O(^ACK(509850.7,ACKDA,1,I)) Q:'I  D
 .S X=^ACK(509850.7,ACKDA,1,I,0)
 .S ^TMP("ACKQWLD",$J,2,$P(X,U,4),$P(X,U),$P(X,U,5))=$P(X,U,2,3)
 .Q
 ;For CPT statistics.
 S I=0 F  S I=$O(^ACK(509850.7,ACKDA,2,I)) Q:'I  D
 .S X=^ACK(509850.7,ACKDA,2,I,0)
 .S ^TMP("ACKQWLD",$J,3,$P(X,U,4),+X,$P(X,U,5))=$P(X,U,2,3)
 .Q
 Q
PRINT ;Print/display results.
 D DHD I '$O(^TMP("ACKQWLD",$J,0)) D LINE W !!,"No data found for report specifications." Q
 D HD1
ZIP ;For all visits.
 S AS=0 F  S AS=$O(^TMP("ACKQWLD",$J,1,AS)) Q:'AS!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD1
 .S XAS=$S(AS=203:"Audiology",1:"Speech")
 .W !!,XAS,":"
 .S (ZIP,T)="" F  S ZIP=$O(^TMP("ACKQWLD",$J,1,AS,ZIP)) Q:ZIP=""!($D(DIRUT))  D
 ..I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD1
 ..S X=^TMP("ACKQWLD",$J,1,AS,ZIP)
 ..W !,ZIP,?20,$J($P(X,U,2),5),?30,$J($P(X,U,3),5),?40,$J($P(X,U),5)
 ..S $P(T,U)=T+X,$P(T,U,2)=$P(T,U,2)+$P(X,U,2),$P(T,U,3)=$P(T,U,3)+$P(X,U,3)
 .Q:$D(DIRUT)
 .S $P(LN,"-",48)="" W !,LN
 .W !,XAS," Total: ",?20,$J($P(T,U,2),5),?30,$J($P(T,U,3),5),?40,$J(+T,5)
 Q:$D(DIRUT)
ICD ;For ICD statistics.
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD2
 S AS=0 F  S AS=$O(^TMP("ACKQWLD",$J,2,AS)) Q:'AS!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD2
 .S XAS=$S(AS=203:"Audiology",1:"Speech")
 .W !!,XAS,":"
 .S ICD="" F  S ICD=$O(^TMP("ACKQWLD",$J,2,AS,ICD)) Q:ICD=""!($D(DIRUT))  D
 ..S (ZIP,X)="" F  S ZIP=$O(^TMP("ACKQWLD",$J,2,AS,ICD,ZIP)) Q:ZIP=""!($D(DIRUT))  D
 ...I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD2
 ...S Y=^TMP("ACKQWLD",$J,2,AS,ICD,ZIP) F I=1,2 S $P(X,U,I)=$P(X,U,I)+$P(Y,U,I)
 ..Q:$D(DIRUT)
 ..W !,ICD,?20,$J($P(X,U),5),?30,$J($P(X,U,2),5)
 .Q:$D(DIRUT)
 Q:$D(DIRUT)
CPT ;For CPT statistics.
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD3
 S AS=0 F  S AS=$O(^TMP("ACKQWLD",$J,3,AS)) Q:'AS!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD3
 .S XAS=$S(AS=203:"Audiology",1:"Speech")
 .W !!,XAS,":"
 .S CPT=0 F  S CPT=$O(^TMP("ACKQWLD",$J,3,AS,CPT)) Q:'CPT!($D(DIRUT))  D
 ..S (ZIP,X)=""  F  S ZIP=$O(^TMP("ACKQWLD",$J,3,AS,CPT,ZIP)) Q:ZIP=""!($D(DIRUT))  D
 ...I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD3
 ...S Y=^TMP("ACKQWLD",$J,3,AS,CPT,ZIP) F I=1,2 S $P(X,U,I)=$P(X,U,I)+$P(Y,U,I)
 ..Q:$D(DIRUT)
 ..W !,CPT,?20,$J($P(X,U),5),?30,$J($P(X,U,2),5)
 .Q:$D(DIRUT)
 Q:$D(DIRUT)
CDR ;For CDR information.
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD4
 S (CDR,T)=0 F  S CDR=$O(^ACK(509850.7,ACKDA,4,CDR)) Q:'CDR!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD4
 .S X=^ACK(509850.7,ACKDA,4,CDR,0)
 .S Y=$O(^ACK(509850,"B",$P(X,U),0))
 .S Y=$P($G(^ACK(509850,+Y,0)),U,2)
 .W !,$P(X,U),?10,Y,?60,$J($P(X,U,2),6,2)
 .S T=T+$P(X,U,2)
 Q:$D(DIRUT)
 W !,"Total:",?60,$J(T,6,2),!!
 Q
DHD ;
 N X
 S ACKPG=ACKPG+1 W @IOF,"Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 F X="Audiology & Speech Pathology","Capitation Report","for",$$XDAT^ACKQUTL(ACKM) W ! D CNTR^ACKQUTL(X)
 W ! Q
HD1 ;Header for all visits.
 N X
 W !,"ZIP CODE",?21,"VISITS",?31,"UNIQUE",?42,"C&P"
 D LINE
 Q
HD2 ;Header for ICD statistics.
 N X
 W !,"ICD",?21,"VISITS",?31,"UNIQUE"
 D LINE
 Q
HD3 ;Header for CPT statistics.
 N X
 W !,"CPT",?21,"VISITS",?31,"UNIQUE"
 D LINE
 Q
HD4 ;Header for CDR statistics.
 N X
 W !,"CDR ACCOUNT",?58,"% WORKLOAD"
 D LINE
 Q
LINE S X="",$P(X,"-",IOM)="-" W !,X Q

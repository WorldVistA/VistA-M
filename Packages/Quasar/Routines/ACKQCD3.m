ACKQCD3 ;AUG/JLTP BIR/PTD-Generate A&SP Service CDR - CONTINUED ; [ 12/07/95   9:52 AM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
PRINT ;
 D HDR I '$O(^TMP("ACKQCDR",$J,"ACKH",0)) W !!,"No data found for report specifications." Q
 D FIELD^DID(509850,3,"","POINTER","X") K ACKCAT
 F I=1:1:($L(X("POINTER"),";")-1) S Y=$P(X("POINTER"),";",I),ACKCAT($P(Y,":"))=$P(Y,":",2)
 S (HD,X1)=0
 F  S HD=$O(ACKCAT(HD)) Q:'HD!($D(DIRUT))  S NEWHD=1 F  S X1=$O(^TMP("ACKQCDR",$J,"ACKCAT",HD,X1)) Q:'X1!($D(DIRUT))  D
 .I $D(^TMP("ACKQCDR",$J,"ACKH",X1)),($P(^(X1),U)>0) D
 ..I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR W !
 ..I NEWHD W !!?5,ACKCAT(HD)
 ..W !?5,$P(^TMP("ACKQCDR",$J,"ACKCAT",HD,X1),U),?15,$P(^(X1),U,2),?65,$J(^TMP("ACKQCDR",$J,"ACKH",X1),6,2)
 ..S NEWHD=0
 W:'$D(DIRUT) !!?55,"Total:",?65,$J(ACKTP,6,2),"%"
 Q
HDR ;
 S ACKPG=ACKPG+1 W @IOF,"Printed: ",ACKPDT,?(IOM-8),"Page: ",ACKPG,!
 F X="Audiology & Speech Pathology","Cost Distribution Report","for",ACKXRNG W ! D CNTR^ACKQUTL(X)
 S X="",$P(X,"-",IOM)="-" W !,X
 Q

ACKQCDD3 ;AUG/JLTP BIR/PTD HCIOFO/AG-Generate A&SP Service CDR for Division- CONTINUED ; [ 12/07/95   9:52 AM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
PRINT ;
 D HDR1
 I '$O(^TMP("ACKQCDD",$J,"ACKH",0)) D  Q
 . W !!,"No data found for report specifications."
 D FIELD^DID(509850,3,"","POINTER","X") K ACKCAT
 F I=1:1:($L(X("POINTER"),";")-1) S Y=$P(X("POINTER"),";",I),ACKCAT($P(Y,":"))=$P(Y,":",2)
 S (HD,X1)=0
 F  S HD=$O(ACKCAT(HD)) Q:'HD!($D(DIRUT))  D
 .S NEWHD=1
 .F  S X1=$O(^TMP("ACKQCDD",$J,"ACKCAT",HD,X1)) Q:'X1!($D(DIRUT))  D
 ..I $D(^TMP("ACKQCDD",$J,"ACKH",X1)),($P(^(X1),U)>0) D
 ...I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HDR W !
 ...I NEWHD W !!?5,ACKCAT(HD)
 ...W !?5,$P(^TMP("ACKQCDD",$J,"ACKCAT",HD,X1),U),?15,$P(^(X1),U,2)
 ...W ?65,$J(^TMP("ACKQCDD",$J,"ACKH",X1),6,2)
 ...S NEWHD=0
 W:'$D(DIRUT) !!?55,"Total:",?65,$J(ACKTP,6,2),"%"
 Q
 ;
HDR W @IOF
HDR1 S ACKPG=ACKPG+1
 W "Printed: ",ACKPDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Cost Distribution Report")
 W ! D CNTR^ACKQUTL("for "_ACKXRNG)
 W ! D CNTR^ACKQUTL("for DIVISION: "_$$DIVNAME(ACKDIV))
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
DIVNAME(ACKDIV) ; get division name
 Q $$GET1^DIQ(40.8,ACKDIV_",",.01)

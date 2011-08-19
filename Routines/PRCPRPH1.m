PRCPRPH1 ;WISC/RFJ-physical count form for prim and sec (cont);02 Feb 93 ; 3/22/99 11:30am
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;come here to print report
 K PRCPFLAG,^TMP($J,"PRCPRPHP")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S GROUP=+$P($G(^(ITEMDA,0)),"^",21) D
 .   I $D(^TMP($J,"PRCPRPH","NO",GROUP)) Q
 .   I GROUP,'$D(GROUPALL),'$D(^TMP($J,"PRCPRPH","YES",GROUP)) Q
 .   I 'GROUP,'$D(GROUPALL) Q
 .   S %=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),MAIN=+$P(%,"^",6),MAIN=$$STORELOC^PRCPESTO(MAIN) S:MAIN="?" MAIN=" ?"
 .   S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) S:DESCR="" DESCR=" "
 .   S ^TMP($J,"PRCPRPHP",MAIN,GROUP,$E(DESCR,1,15),ITEMDA)=DESCR_"^"_$$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/")_"^"_$P(%,"^",7)
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S MAIN="" F  S MAIN=$O(^TMP($J,"PRCPRPHP",MAIN)) Q:MAIN=""!($G(PRCPFLAG))  D
 .   W !!?5,"MAIN STORAGE LOCATION: ",MAIN
 .   S GROUP="" F  S GROUP=$O(^TMP($J,"PRCPRPHP",MAIN,GROUP)) Q:GROUP=""!($G(PRCPFLAG))  D
 .   .   W !?10,"GROUP CATEGORY: ",$$GROUPNM^PRCPEGRP(GROUP)
 .   .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRPHP",MAIN,GROUP,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRPHP",MAIN,GROUP,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   .   .   W !,$E($P(D,"^",1),1,40),?42,ITEMDA,?47,$J($P(D,"^",2),10)
 .   .   .   I PRCPOH=1 W $J($P(D,"^",3),12)
 .   .   .   W ?71,"_________"
 .   .   .   S X=0 F Y=1:1 S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,1,X)) Q:'X  S D=$G(^(X,0)) I D'="" D
 .   .   .   .   I Y=1 W !?20,"ADD STORAGE: "
 .   .   .   .   I $X>50 W !?20
 .   .   .   .   W $E($$STORELOC^PRCPESTO($P(D,"^")),1,15),"   "
 .   .   .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   .   I $G(PRCPFLAG) Q
 .   .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   I $G(PRCPFLAG) Q
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 .   I $G(PRCPFLAG) Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I '$G(PRCPFLAG) D END^PRCPUREP
Q K ^TMP($J,"PRCPRPH"),^TMP($J,"PRCPRPHP") D ^%ZISC Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PHYSICAL COUNT FORM: ",$E(PRCP("IN"),1,12),?(80-$L(%)),%
 S %="",$P(%,"-",81)="" W !,"DESCRIPTION",?42,"MI",?50,"UNIT/ISS"
 I PRCPOH=1 W ?62,"ON HAND"
 W ?71,"NEW COUNT",!,%
 Q

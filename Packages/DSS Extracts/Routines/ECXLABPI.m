ECXLABPI ;BIR/DMA-One Time Routine to Print Lab Tests ; 08 Aug 94 / 6:50 AM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 W !!,"This will print a list of your lab products from the Lab extract file"
 S %ZIS="Q" D ^%ZIS K %ZIS Q:POP
 I $D(IO("Q")) S ZTDESC="Lab product list",ZTRTN="EN^ECXLABPI" D ^%ZTLOAD,^%ZISC K ZTRTN,ZTDESC Q
 ;
EN ;
 K ^TMP($J)
 F J=0:0 S J=$O(^ECX(727.813,J)) Q:'J  S EC=$G(^(J,0)) I EC]"" S ABR=$P(EC,U,11),TES=$P(EC,U,12),TEN=$P($G(^LAB(60,+TES,0)),U),^TMP($J,ABR,TES)=TEN
 ;
 D HEAD S ABR="" F  S ABR=$O(^TMP($J,ABR)) Q:ABR=""  F J=0:0 S J=$O(^TMP($J,ABR,J)) Q:'J  W !,?7,ABR,?15,J,?25,^(J) I $Y+4>IOSL D HEAD
 D ^%ZISC S ZTREQ="@" K ^TMP($J) Q
 ;
HEAD W:$Y @IOF W !,?20,"LAB EXTRACT PRODUCTS",!,"ACCESSION",?12,"NUMBER",?30,"DESCRIPTION",!!
 Q

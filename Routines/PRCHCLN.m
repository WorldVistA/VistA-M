PRCHCLN ;WISC/AKS-Routine to correct Food Groups in Item Master file ;7/7/93  09:35
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K ^TMP($J) N N,FLG,FGRP,PRC,%,HDRFLG,M,POP,PRCHDT,PRCHDY,PRCHPAGE,PRCHPDAT,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,C,PRCHPDAT
 W !!,"This option will loop through your 'ITEM MASTER' file and correct any Food Group",!,"that it can i.e. from 01 to 1, 02 to 2 etc. If it finds any Food Group for which",!
 W "the correct Food Group can not be determined, it will print the report."
 S N="" F  S N=$O(^PRC(441,N)) Q:N=""!(N'?1.N)  I $P($G(^PRC(441,N,3)),U,7)]"" S FLG=0,FGRP=$P(^(3),U,7) S:((+FGRP>0)&(+FGRP<7)) $P(^PRC(441,N,3),U,7)=+FGRP,FLG=1 S:'FLG ^TMP($J,N)=FGRP
 I '$D(^TMP($J)) W !!,"No items with 'Uncorrectable' Food Groups have been found." Q
 I $D(^TMP($J)) S ZTRTN="EN^PRCHCLN" W !!,"Some items in your 'ITEM MASTER' file have invalid Food Groups that the system  cannot correct. Select a device to print the list of those items."
 W ! D SELDEV^PRCHUTL1 Q:POP  Q:'$D(IO(0))  Q:IO(0)=IO
 S M="Generate Invalid Food Groups report" D ENRDAT^PRCHUTL1 Q:X["^"
 S ZTDTH=PRCHPDAT,ZTDESC="Report of items with invalid Food Group"
 K ZTSAVE S ZTSAVE("PRC*")="",ZTSAVE("U")="",ZTSAVE("DUZ*")="",ZTSAVE("^TMP($J,")=""
 D ^%ZTLOAD,ENK3^PRCHUTL1 Q
EN ;
 D NOW^%DTC S Y=$P(%,"."),PRCHDT=% D DD^%DT S PRCHPDAT=Y S M=0,PRCHPAGE=0,PRCHDY=0,HDRFLG=0 F  S M=$O(^TMP($J,M)) Q:M=""  G Q:$$S^%ZTLOAD D:'HDRFLG!(PRCHDY>(IOSL-5)) HDR D
 .W !,"          ",$J(M,8)," ---------------------- ",^TMP($J,M) S PRCHDY=PRCHDY+1
 G Q
HDR S PRCHPAGE=PRCHPAGE+1 W @IOF,"Report Of Invalid Food Groups",?57,PRCHPDAT,?73,"PAGE ",PRCHPAGE,!
 W "-------------------------------------------------------------------------------- ",!
 W "              ITEM NO.                FOOD GROUP",! S PRCHDY=PRCHDY+3
 S HDRFLG=1
 QUIT
Q I $$S^%ZTLOAD W !,$$SQUE^PRCHUTL1($T(+0)),!
 K ^TMP($J)
 Q

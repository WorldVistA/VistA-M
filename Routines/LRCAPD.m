LRCAPD ;SLC/AM/DALOI/FHS - WORKLOAD CODE LIST REPORT;1/16/91 15:34
 ;;5.2;LAB SERVICE;**105,163,153,278**;Sep 27, 1994
EN ;
 W !!?5,"I will produce a list of WKLD codes in your file 60 "
 K %ZIS,DX S %ZIS="QN",%ZIS("A")="Printer Name " D ^%ZIS G:POP CLEAN
 I IO'=IO(0)!($D(IO("Q"))) S ZTRTN="DQ^LRCAPD",ZTIO=ION,ZTDESC="PRINT WKLD CODES FROM ^LAB(60 " W !!?10,"Report Queued to "_ION,! D ^%ZTLOAD,^%ZISC G CLEAN
DQ ;
 D START
 D CLEAN
 Q
START ;
 K ^TMP("LR",$J,"CAP"),^TMP("LR",$J,"CAPN")
 S (LRTS,LREND,LRPAG)=0,$P(LRLINE,"_",(IOM+1))=""
 ;test list
 W:$E(IOST,1,2)="C-" @IOF
 D HEAD
 S LRTSN=""
 F  S LRTSN=$O(^LAB(60,"B",LRTSN)) Q:(LRTSN="")!($G(LREND))  D
 .S LRTS=$O(^LAB(60,"B",LRTSN,0))
 .I LRTS>0,'$G(^LAB(60,"B",LRTSN,LRTS)) D PRNT
 Q:$G(LREND)
 D PAUSE
 ;CAP code list
 W @IOF
 D HEAD2
 S I=$O(^TMP("LR",$J,"CAP",0))
 I '$L(I) W !!?5,"NONE",! S LREND=1
 E  D
 .S DIC="^LAM(",(DR,LRI)=0
 .F  S LRI=$O(^TMP("LR",$J,"CAP",LRI)) Q:(LRI="")!($G(LREND))  S DA=^(LRI) D
 ..I $Y>(IOSL-8) D
 ...D PAUSE Q:$G(LREND)
 ...W @IOF
 ...D HEAD2
 ..Q:$G(LREND)
 ..S S=$Y D EN^DIQ
 Q:$G(LREND)
NLTPRT W !! W:$E(IOST,12)="P-" @IOF I $O(^TMP("LR",$J,"CAPN",0))'="" D
 . D HEAD3
 . S DIC="^LAM(",(DR,LRI)=0
 . F  S LRI=$O(^TMP("LR",$J,"CAPN",LRI)) Q:(LRI="")!($G(LREND))  S DA=^(LRI) D
 .. I $Y>(IOSL-8) D  Q:$G(LREND)
 ... D PAUSE Q:$G(LREND)
 ... W @IOF
 ... D HEAD3
 .. Q:$G(LREND)
 .. S S=$Y D EN^DIQ
 Q:$G(LREND)
 D PAUSE
 Q
PRNT ;
 Q:$G(LREND)
 I $Y>(IOSL-8) D  Q:$G(LREND)
 . D PAUSE Q:$G(LREND)
 . W @IOF D HEAD
 I '($D(^LAB(60,LRTS,0))#2) Q
 S (NAME1,NAME)=""
 I $G(^LAB(60,LRTS,64)) S LRCC=+^(64) D
 . D NAME W ?5,"National VA Lab Code: ",$P($G(^LAM(+LRCC,0)),U,2)_"  "_$P(^(0),U),!
 . I $O(^LAM(+LRCC,4,0)) W ?15 D  W !
 . . S N=0 F  S N=$O(^LAM(+LRCC,4,"B",N)) Q:N=""!($G(LREND))  W "[ CPT ",N," ] "
 . G ERR:'$D(^LAM(LRCC,0)) S ^TMP("LR",$J,"CAPN",$P(^(0),U))=LRCC
 I $P($G(^LAB(60,LRTS,64)),U,2) S LRCC=$P(^(64),U,2) D
 . D NAME W ?5,"Result NLT Code: ",$P($G(^LAM(+LRCC,0)),U,2)_"  "_$P(^(0),U),!
 . G ERR:'$D(^LAM(LRCC,0)) S ^TMP("LR",$J,"CAPN",$P(^(0),U))=LRCC
 S LRJ=0,LRJ=$O(^LAB(60,LRTS,9,LRJ)) I LRJ>0 D  Q:$G(LREND)
 .D NAME W ?15,"Verify",! D
 ..D:$D(^LAB(60,LRTS,9,LRJ,0))#2 PCC
 ..F LRK=0:0 S LRJ=$O(^LAB(60,LRTS,9,LRJ)) Q:(LRJ<1)!($G(LREND))  D:$D(^LAB(60,LRTS,9,LRJ,0))#2 PCC
 Q:$G(LREND)
 S LRJ=+$O(^LAB(60,LRTS,9.1,0))
 Q:'LRJ
 D NAME W ?15,"Accession",! D  Q:$G(LREND)
 .D:$D(^LAB(60,LRTS,9.1,LRJ,0))#2 PCC2
 .F LRK=0:0 S LRJ=$O(^LAB(60,LRTS,9.1,LRJ)) Q:LRJ<1!($G(LREND))  D:$D(^LAB(60,LRTS,9.1,LRJ,0))#2 PCC2
 Q:$G(LREND)
 S LRJ=+$O(^LAB(60,LRTS,3,1,9,0))
 Q:'LRJ
 D NAME W ?15,"Sample",! D
 .D:$D(^LAB(60,LRTS,3,1,9,LRJ,0))#2 PCC3
 .F LRK=0:0 S LRJ=$O(^LAB(60,LRTS,3,1,9,LRJ)) Q:(LRJ<1)!($G(LREND))  D:$D(^LAB(60,LRTS,3,1,9,LRJ,0))#2 PCC3
 Q
PCC ;
 Q:$G(LREND)
 S LRX=^LAB(60,LRTS,9,LRJ,0),LRCC=+LRX G ERR:'$D(^LAM(LRCC,0)) S ^TMP("LR",$J,"CAP",$P(^(0),U))=LRCC
 I $Y>(IOSL-6) D
 .D PAUSE Q:$G(LREND)
 .S NAME1=0 W @IOF D HEAD,NAME W ?15,"Verify",!
 Q:$G(LREND)
 W ?10,$S($D(^LAM(LRCC,0))#2:$S($P(^(0),U,5):"+"_$P(^(0),U),1:$P(^(0),U)),1:""),?50,$P(LRX,U,2),?73,$S($P(LRX,U,3):$P(LRX,U,3),1:"1"),!
 Q
PCC2 ;
 Q:$G(LREND)
 S LRX=^LAB(60,LRTS,9.1,LRJ,0),LRCC=+LRX G ERR:'$D(^LAM(LRCC,0)) S ^TMP("LR",$J,"CAP",$P(^(0),U))=LRCC
 I $Y>(IOSL-6) D
 .D PAUSE Q:$G(LREND)
 .S NAME1=0 W @IOF D HEAD,NAME W ?15,"Accession",!
 Q:$G(LREND)
 W ?10,$S($D(^LAM(LRCC,0))#2:$S($P(^(0),U,5):"+"_$P(^(0),U),1:$P(^(0),U)),1:""),?50,$P(LRX,U,2),?73,$S($P(LRX,U,3):$P(LRX,U,3),1:"1"),!
 Q
PCC3 ;
 Q:$G(LREND)
 S LRX=^LAB(60,LRTS,3,1,9,LRJ,0),LRCC=+LRX G ERR:'$D(^LAM(LRCC,0)) S ^TMP("LR",$J,"CAP",$P(^(0),U))=LRCC
 I $Y>(IOSL-6) D
 .D PAUSE Q:$G(LREND)
 .S NAME1=0 W @IOF D HEAD,NAME W ?15,"Sample",!
 Q:$G(LREND)
 W ?10,$S($D(^LAM(LRCC,0))#2:$S($P(^(0),U,5):"+"_$P(^(0),U),1:$P(^(0),U)),1:""),?50,$P(LRX,U,2),?73,$S($P(LRX,U,3):$P(LRX,U,3),1:"1"),!
 Q
HEAD ;
 Q:$G(LREND)
 S LRPAG=$G(LRPAG)+1
 W !!?21,"LIST OF FILE 60 WKLD CODES",?70,"Page ",$J(LRPAG,3),!
 W !,"IEN",?15,"WKLD Code  [TYPE]  ",?50,"WKLD Number",?73,"X",!,LRLINE,!
 Q
HEAD2 ;
 Q:$G(LREND)
 S LRPAG=$G(LRPAG)+1
 W !!?10,"Alphabetical Listing of WKLD Codes Defined"
 W ?72,"Page ",$J(LRPAG,3),!
 Q
HEAD3 ;
 Q:$G(LREND)
 S LRPAG=$G(LRPAG)+1
 W !!?10,"Alphabetical Listing of NLT or Result NLT Codes Defined"
 W ?72,"Page ",$J(LRPAG,3),!
 Q
NAME ;
 S LRTY=$P(^LAB(60,LRTS,0),U,3) W:'$G(NAME1) !,LRTS,?6,$P(^LAB(60,LRTS,0),U),"[ "_$S(LRTY="I":"INPUT",LRTY="O":"OUTPUT",LRTY="B":"BOTH",1:"NEITHER")_" ]",!
 S NAME1=1
 Q
ERR W !?10,$C(7)," Error in WKLD Code pointer (",$G(LRCC),") *****  ",!
 Q
PAUSE ;
 Q:$G(LREND)
 Q:$E(IOST,1,2)'="C-"
 K DIR,X,Y S DIR(0)="E" D ^DIR
 S:($D(DTOUT))!($D(DUOUT)) LREND=1
 Q
CLEAN I $D(ZTQUEUED) S ZTREQ="@"
 W !! W:$E(IOST,1,2)="P-" @IOF
 D ^%ZISC
 K %ZIS,DA,DIC,DR,LRI,LRLINE,LRHED,LRI,LRJ,LRK,LRTS,LRTSN,LRX,NAME,NAME1
 K %,LRCC,LREND,X,Y,ZTSK,DTOUT,DUOUT,DIRUT,LRPAG,DIR,DX,S
 K ^TMP("LR",$J,"CAP"),^TMP("LR",$J,"CAPN")
 Q

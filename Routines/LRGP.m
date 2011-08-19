LRGP ;DALOI/CJS/RWF - INSTRUMENT GROUP DELTA CHECK DISPLAY ;2/5/91  13:19
 ;;5.2;LAB SERVICE;**153,269**;Sep 27, 1994
 ;
 N LASQ,LRPAGE,LRVBY
 ;
 S LASQ=0,LRGVP="",LRDCNT=0
 K ^TMP("LR",$J)
 D ^LRPARAM
 I $G(LREND) D CLOSE Q
 D ^LRGP1
 I $G(LREND) D CLOSE Q
 ;
 S LRDCNT=0,%ZIS="Q"
 D ^%ZIS
 I POP D CLOSE Q
 I $D(IO("Q")) D  Q
 . N ZTDTH,ZTRTN,ZTSAVE,ZTDESC
 . K IO("Q")
 . S ZTRTN="DQ^LRGP",ZTSAVE("LR*")="",ZTSAVE("^TMP(""LR"",$J,")="",ZTDESC="Group unverified review (EA, EL, EW)"
 . D ^%ZTLOAD
 . U IO(0) W !,"Task ",$S($G(ZTSK):ZTSK,1:"NOT")," Queued"
 . D CLOSE
 ;
 ;
DQ ;
 U IO
 S LRNOW=$$NOW^XLFDT,LRDT=$$FMTE^XLFDT(LRNOW,"5MZ"),LRPAGE=0
 D ACC:LRWT="A",LRTRAY:LRWT="T",MACHSQ:LRWT="M",WRKLST:LRWT="W"
 W:'LRDCNT !!,"No data to report",!!
 W:$E(IOST,1,2)="P-" @IOF
 ;
CLOSE ;
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 D ^LRGVK
 Q
 ;
 ;
ACC ;
 S LRHED="By Accession list: "_LRNAME D LRHED
 S LRAN=LRFAN
 F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:LRAN<1!(LRAN>LRLIX)  D  Q:$G(ZTSTOP)
 . S LASQ=0
 . D WRK2 Q:$G(ZTSTOP)
 . D LRHED:$E(IOST,1,2)'="C-"&($Y+3>IOSL)
 . I 'LASQ D
 . . W !,"No Unverified instrument Data for Acc#: ",LRAN
 . . D DASH^LRX
 Q
 ;
 ;
LRHED ;
 S LRPAGE=LRPAGE+1
 W @IOF
 W !,"Group unverified review listing",?50,"Page: ",LRPAGE
 W !,LRHED,?50,"Date: ",LRDT,!!
 Q
 ;
 ;
LRTRAY ;
 S LRHED="By Tray. Load list: "_$P(^LRO(68.2,LRLL,0),U,1)
 D LRHED
 ;
 F LRTRAY=LRFTRAY:1:LRLTRAY W !!,"Start LRTRAY: ",LRTRAY D  Q:$G(ZTSTOP)
 . F LRCUP=LRFCUP:1:$S(LRTRAY=LRLTRAY:LRLCUP,1:LRMAXCUP) D  Q:$G(ZTSTOP)
 . . S LRITC=LRTRAY_";"_LRCUP,LRSQ=0
 . . F  S LRSQ=$O(^LAH(LRLL,1,"B",LRITC,LRSQ)) Q:LRSQ<1  D PRINT  Q:$G(ZTSTOP)
 Q
 ;
 ;
MACHSQ ;
 S LRHED="By Machine Sequence number. Load/Work list: "_$P(^LRO(68.2,LRLL,0),U,1)
 D LRHED
 ;
 S LRSQ=LRSQ-1
 F  S LRSQ=$O(^LAH(LRLL,1,LRSQ)) Q:LRSQ<1!(LRSQ>LRESEQ)  D PRINT  Q:$G(ZTSTOP)
 ;
 Q
 ;
 ;
WRKLST ;
 S LRHED="By Work list: "_$P(^LRO(68.2,LRLL,0),U,1)
 D LRHED
 S LRC=LRCUP-1
 F  S LRC=$O(^LRO(68.2,LRLL,1,1,1,LRC)) Q:LRC<1!(LRC>LRECUP)  D  Q:$G(ZTSTOP)
 . N LRX
 . S LRX=$G(^LRO(68.2,LRLL,1,1,1,LRC,0))
 . I LRX="" Q
 . S LRAA=$P(LRX,"^"),LRAD=$P(LRX,"^",2),LRAN=$P(LRX,"^",3)
 . D WRK2
 Q
 ;
 ;
WRK2 ; Display results for each accession number.
 ;
 S LRSQ=0
 F  S LRSQ=$O(^LAH(LRLL,1,"C",LRAN,LRSQ)) Q:LRSQ<1  D PRINT  Q:$G(ZTSTOP)
 Q
 ;
 ;
PRINT ;
 ; Check that results belong to same accession area and date since
 ; results can belong to different accession areas and dates but have
 ; the same acession number.
 ;
 ; Check if task has been asked to stop.
 I $D(ZTQUEUED),$$S^%ZTLOAD D  Q
 . S ZTSTOP=1
 . W !!,"*** Report requested to stop by TaskMan ***"
 . W !,"*** Task #",$G(ZTQUEUED,"UNKNOWN")," stopped at ",$$HTE^XLFDT($H)," ***"
 ;
 Q:'$D(^LAH(LRLL,1,LRSQ,0))
 ;
 S LRSQ(0)=^LAH(LRLL,1,LRSQ,0)
 ;
 ; Different accession area
 I $P(LRSQ(0),"^",3),LRAA'=$P(LRSQ(0),"^",3) Q
 ; Different accession date
 I $P(LRSQ(0),"^",4),LRAD'=$P(LRSQ(0),"^",4) Q
 ;
 D LRHED:$E(IOST,1,2)'="C-"&($Y+LRVTS>IOSL)
 W !!,?4,"Seq #: ",LRSQ
 S LRTRAY=$P(LRSQ(0),"^",1),LRCUP=$P(LRSQ(0),"^",2)
 I $L(LRTRAY) W ?43,"Tray: ",LRTRAY
 I $L(LRCUP) W ?51,"  Cup: ",LRCUP
 ;
 ;
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 ;
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRORD=$S($D(^(.1)):^(.1),1:0),LRODT=$S($P(^(0),U,4):$P(^(0),U,4),1:$P(^(0),U,3)),LRSN=$P(^(0),U,5)
 Q:LRSN<1
 ;
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 D DISPLAY
 D VER^LRVR1
 D DASH^LRX
 S LRDCNT=LRDCNT+1,LASQ=1
 Q
 ;
 ;
DISPLAY ; Display accession info/results
 W !,?5,"Name: ",PNM,?44,"SSN: ",SSN
 W:LRORD !,"  Order #: ",LRORD
 ;
 W !,"Accession: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 I $P(LRSQ(0),"^",10) W ?30," Results received: ",$$FMTE^XLFDT($P(LRSQ(0),"^",10),"1M")
 W !,?6,"UID: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"UNKNOWN"),"^")
 I $P(LRSQ(0),"^",11) W ?34," Last updated: ",$$FMTE^XLFDT($P(LRSQ(0),"^",11),"1M")
 ;
 Q

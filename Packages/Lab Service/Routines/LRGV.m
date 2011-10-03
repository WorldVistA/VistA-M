LRGV ;DALIO/RWF - INSTRUMENT GROUP VERIFY DATA ;2/5/91  13:26
 ;;5.2;LAB SERVICE;**269**;Sep 27, 1994
 ;
 N LRANYAA,LRUID,LRVBY
 ;
 D ^LRGVK,^LRPARAM
 I $G(LREND) D END Q
 ;
 S U="^",LRSS="CH",LROUTINE=$P(^LAB(69.9,1,3),U,2),(LRANYAA,LRUID,LRVBY)=""
 ;
 ; Get user's initials to use to verify results
 S X=DUZ D DUZ^LRX
 X ^%ZOSF("EOFF")
 N DIR
 S DIR(0)="FAO^1:10",DIR("A")="Please enter your initials to verify: "
 D ^DIR K DIR
 X ^%ZOSF("EON")
 I $D(DIRUT)!(Y'=LRUSI) D END Q
 ;
 D ^LRGP1
 I LREND D END Q
 ;
 D COM
 I LREND D NOP,END Q
 ;
 S %ZIS="Q" D ^%ZIS
 I POP D END Q
 ;
 I $D(IO("Q")) D  Q
 . N ZTDTH,ZTRTN,ZTSAVE,ZTDESC
 . K IO("Q")
 . S ZTRTN="DQ^LRGV",ZTSAVE("LR*")="",ZTSAVE("^TMP(""LR"",$J,")="",ZTDESC="Group verify (EA, EL, EW)"
 . D ^%ZTLOAD
 . U IO(0) W !,"Task ",$S($G(ZTSK):ZTSK,1:"NOT")," Queued"
 . D END
 ;
DQ ;
 U IO
 S LRNOW=$$NOW^XLFDT,LRDT=$$FMTE^XLFDT(LRNOW,"1M"),(LREND,LRPAGE)=0
 S LRLLNM=$P(^LRO(68.2,LRLL,0),"^")
 D HDR
 D LRTRAY:LRWT="T",ACCLST:LRWT="A",SEQ:LRWT="M",WRKLST:LRWT="W"
 I $E(IOST,1,2)="P-" W @IOF
 ;
END ;
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 D ^LRGVK
 K LRCSQQ,LRLLNM,LRNGS,LRPAGE
 Q
 ;
 ;
ACCLST ; Verify by accession number/UID
 ;
 S LRVWLE=""
 ;
 ; Verify by accession number
 I LRVBY=1 D
 . S LRAN=LRFAN
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:LRAN<1!(LRAN>LRLIX)  D ACC2  Q:LREND
 . I $L(LRVWLE) D
 . . S $P(^LRO(68,LRAA,1,LRAD,2),"^")=LRUSI
 . . S $P(^LRO(68,LRAA,1,LRAD,2),"^",4)=LRVWLE
 ;
 ; Verify by UID
 I LRVBY=2 D
 . S LRANYAA=+$P($G(^LRO(68.2,LRLL,10,LRPROF,0)),"^",3),LRUID=""
 . F  D NEXT^LRVRA Q:LRUID=""  D ACC2  Q:LREND
 ;
 Q
 ;
 ;
ACC2 ; Only select those entries in ^LAH that match the accession area and
 ; date selected by the user.
 ;
 I $Y>(IOSL-10) D HDR Q:LREND
 W ! D DASH^LRX
 W !,"Accession #: ",LRAN
 I LRVBY=2 D
 . W " [UID: ",LRUID,"]"
 . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D  Q
 . . W " No accession on file for this UID."
 . W " <",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^"),">"
 ;
 I '$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",3) D  Q
 . W " Has not been received. Unable to verify."
 ;
 I +^LRO(68,LRAA,1,LRAD,1,LRAN,3)>$$NOW^XLFDT D  Q
 . W " Has a collection time in the future. Unable to verify."
 ;
 I $O(^LAH(LRLL,1,"C",LRAN,0))<1 D  Q
 . W " NO Instrument Data Found."
 ;
 S LRSQ=0
 F  S LRSQ=$O(^LAH(LRLL,1,"C",LRAN,LRSQ)) Q:LRSQ<1  D  Q:LREND
 . S X=^LAH(LRLL,1,LRSQ,0)
 . I LRAA'=$P(X,"^",3)!(LRAD'=$P(X,"^",4)) Q
 . S LRAN=$P(X,"^",5)
 . I LRAN D STUFF^LRGV1
 Q
 ;
 ;
LRTRAY ; Verify by tray/cup
 ;
 F LRTRAY=LRFTRAY:1:LRLTRAY D  Q:LREND
 . I $Y>(IOSL-10) D HDR Q:LREND
 . W ! D DASH^LRX
 . W !!,"Start TRAY: ",LRTRAY
 . D TR2
 Q
 ;
 ;
TR2 ; Verify by tray/cup
 ; Only select those entries in ^LAH that match the accession area and date
 ; selected by the user.
 N LRSC,LREC,X
 ;
 ; Figure out starting and ending cups for this tray
 S LRSC=$S(LRTRAY=LRFTRAY:LRFCUP,1:1)
 S LREC=$S(LRTRAY=LRLTRAY:LRLCUP,1:LRMAXCUP)
 ;
 F LRCUP=LRSC:1:LREC D  Q:LREND
 . S LRITC=LRTRAY_";"_LRCUP
 . I $Y>(IOSL-10) D HDR Q:LREND
 . W ! D DASH^LRX
 . W !,"Tray ",$J(LRTRAY,3)," Cup ",$J(LRCUP,3)
 . I $O(^LAH(LRLL,1,"B",LRITC,0))<1 W ?35,"No Instrument Data Found" Q
 . ;
 . S LRSQ=0
 . F  S LRSQ=$O(^LAH(LRLL,1,"B",LRITC,LRSQ)) Q:LRSQ<1  D  Q:LREND
 . . I '$D(^LAH(LRLL,1,+LRSQ,0)) D  Q
 . . . K ^LAH(LRLL,1,"B",LRTIC,LRSQ)
 . . . W ?35,"No Instrument Data Found"
 . . S X=^LAH(LRLL,1,LRSQ,0)
 . . I LRAA'=$P(X,"^",3)!(LRAD'=$P(X,"^",4)) Q
 . . S LRAN=$P(X,"^",5)
 . . I LRAN D STUFF^LRGV1 Q
 . . W ?35," Does not have a link to an Accession."
 Q
 ;
 ;
SEQ ; Verify by sequence number
 ; Only select those entries in ^LAH that match the accession area and date
 ; selected by the user.
 ;
 N X
 ;
 S LRSQ=LRSQ-1
 F  S LRSQ=$O(^LAH(LRLL,1,LRSQ)) Q:LRSQ<1!(LRSQ>LRESEQ)  D  Q:LREND
 . I $Y>(IOSL-10) D HDR Q:LREND
 . W ! D DASH^LRX
 . S X=^LAH(LRLL,1,LRSQ,0)
 . I LRAA'=$P(X,"^",3)!(LRAD'=$P(X,"^",4)) Q
 . S LRAN=$P(X,"^",5)
 . I LRAN D STUFF^LRGV1 Q
 . W !!,"SEQ: ",LRSQ,". Does not have a link to an Accession."
 Q
 ;
 ;
WRKLST ; Verify by worklist
 ; Only select those entries in file #68.2 that match the profile selected
 ; by the user.
 ;
 N X
 ;
 S LRCUP=LRCUP-1
 F  S LRCUP=$O(^LRO(68.2,LRLL,1,1,1,LRCUP)) Q:'LRCUP!(LRCUP>LRECUP)  D  Q:LREND
 . I $Y>(IOSL-10) D HDR Q:LREND
 . W ! D DASH^LRX
 . S X=^LRO(68.2,LRLL,1,1,1,LRCUP,0)
 . I $P(X,"^",4),$P(X,"^",4)'=LRPROF Q
 . S LRAA=$P(X,"^"),LRAD=$P(X,"^",2),LRAN=$P(X,"^",3)
 . W !,"Sequence #",$J(LRCUP,4)
 . I $O(^LAH(LRLL,1,"C",+LRAN,0))<1 W ?35,"No Instrument Data Found" Q
 . ;
 . S LRSQ=0
 . F  S LRSQ=$O(^LAH(LRLL,1,"C",LRAN,LRSQ)) Q:LRSQ<1  D STUFF^LRGV1  Q:LREND
 Q
 ;
 ;
COM ; Ask common questions
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S LRVRFYAL=0
 I $D(^XUSEC("LRSUPER",DUZ))!1 D
 . S DIR(0)="YAO",DIR("B")="NO"
 . S DIR("A",1)="Verify accessions specified, even if"
 . S DIR("A")=" DELTA check or CRITICAL range flag? "
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . S LRVRFYAL=Y
 ;
 I LREND Q
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Everything OK",DIR("B")="YES"
 D ^DIR
 I $D(DIRUT)!(Y'=1) S LREND=1
 Q
 ;
 ;
NOP ;
 W !!,"NOTHING VERIFIED"
 Q
 ;
 ;
HDR ;
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 I $E(IOST,1,2)="C-",'$D(ZTQUEUED),LRPAGE D
 . S DIR(0)="E" D ^DIR
 . I $D(DIRUT) S LREND=1
 I LREND Q
 ;
 I LRPAGE!($E(IOST,1,2)="C-") W @IOF
 S LRPAGE=LRPAGE+1
 W "Group verification report - Verify with",$S(LRVRFYAL:"",1:"out")," flags"
 W ?(IOM-27)," Date: ",LRDT
 W !,"Load/Work list: ",LRLLNM,"  Panel: ",LRPANEL,?(IOM-27)," Page: ",LRPAGE
 ;
 ; Check if task has been asked to stop.
 I $D(ZTQUEUED),$$S^%ZTLOAD D  Q
 . S (LREND,ZTSTOP)=1
 . W !!,"*** Report requested to stop by TaskMan ***"
 . W !,"*** Task #",$G(ZTQUEUED,"UNKNOWN")," stopped at ",$$HTE^XLFDT($H)," ***"
 Q

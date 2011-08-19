LRGV1 ;DALOI/RWF - PART2 OF INSTRUMENT GROUP VERIFY DATA ;2/8/91  09:29
 ;;5.2;LAB SERVICE;**112,153,269**;Sep 27, 1994
 ;
STUFF ;from LRGV
 ;
 ; Check if task has been asked to stop.
 I $D(ZTQUEUED),$$S^%ZTLOAD D  Q
 . S ZTSTOP=1
 . W !!,"*** Report requested to stop by TaskMan ***"
 . W !,"*** Task #",$G(ZTQUEUED,"UNKNOWN")," stopped at ",$$HTE^XLFDT($H)," ***"
 ;
 N LRQUIT
 ;
 S LRQUIT=0
 ;
 L +^LAH(LRLL,1,LRSQ):1
 I '$T W !,"Unable to obtain lock on sequence #",LRSQ Q
 ;
 ; Skip this sequence number if accession number is for a different area/date
 S LRSQ(0)=^LAH(LRLL,1,LRSQ,0)
 I $P(LRSQ(0),U,3)=LRAA,$P(LRSQ(0),U,4)=LRAD,$P(LRSQ(0),U,5)=LRAN
 I '$T L -^LAH(LRLL,1,LRSQ) Q
 ;
 I '$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),U,2) D
 . W !?5,"Corrupt Accession ",!
 . D NOP
 ;
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 S LRDFN=+X,LRODT=+$P(X,U,4),LRSN=+$P(X,U,5),LRLLOC=$P(X,U,7)
 S:'$L(LRLLOC) LRLLOC=0
 S LRORD=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.1)),"^")
 S X(3)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 S LRIDT=$P(X(3),U,5)
 S:'LRIDT LRIDT=9999999-X(3)
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 ;
 K LRSA,LRSB,X
 W " Auto Sequence #",LRSQ
 I '$D(^LRO(68,+LRAA,1,+LRAD,1,+LRAN,0))!'$D(^(3)) D  Q
 . W ?40,"Accession NOT found."
 . L -^LAH(LRLL,1,LRSQ)
 ;
 K ^TMP("LR",$J,"TMP")
 D TEST^LRVR1
 ;
 ; Check for more than one sequence relating to this accession
 S LRI=0
 F  S LRI=$O(^LAH(LRLL,1,"C",LRAN,LRI)) Q:'LRI  D  Q:LRQUIT
 . I LRI=LRSQ Q
 . S LRI(0)=$G(^LAH(LRLL,1,LRI,0))
 . I $P(LRI(0),"^",3,5)'=LRAA_"^"_LRAD_"^"_LRAN Q
 . S LRQUIT=1
 . D INFO,NOP
 I LRQUIT Q
 ;
 S LRMETH=$P(^LAH(LRLL,1,LRSQ,0),U,7)
 I $O(^LAH(LRLL,1,LRSQ,1))<1 D  Q
 . W ?45,"There's NO Instrument Data "
 . D NOP
 ;
 ; Get patient demographics
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX
 S:'$L($G(SEX)) SEX="M"
 S:'$L($G(AGE)) AGE=99
 W ! D DISPLAY^LRGP
 ;
 L +^LR(LRDFN,"CH",LRIDT):1
 I '$T W !,"Unable to obtain lock on LAB DATA file" Q
 ;
 S LR0=$G(^LR(LRDFN,"CH",LRIDT,0))
 I LR0="" W !,"DATA HEADER MISSING " D NOP Q
 ;
 S X=+$P(LR0,U,5),LRSPEC=-1,LRSPNAM="??"
 I X S LRSPNAM=$P(^LAB(61,+X,0),U,1),LRSPEC=X
 W !," Specimen: ",LRSPNAM
 W ?26," Collection date/time: ",$$FMTE^XLFDT($P(LR0,"^"),"1M"),!
 ;
 I LRDPF'=62.3,LRSPEC'=$P(LR0,U,5) D  Q
 . W !,"  << SPECIMEN IS NOT ",LRSPNAM," >> "
 . D NOP
 ;
 S LRVF=+$P(LR0,U,3)
 I LRVF W !,"Some Data Already Verified ",!
 ;
 I '$T,$O(^LR(LRDFN,"CH",LRIDT,1))>1 D  Q
 . W !,"Some Unverified Data Already Entered. "
 . D NOP
 ;
 D ^LRGV2
 ;
 L -^LR(LRDFN,"CH",LRIDT)
 L -^LAH(LRLL,1,LRSQ)
 ;
 Q
 ;
NOP ; unlock from above
 L -^LR(LRDFN,"CH",LRIDT)
 L -^LAH(LRLL,1,LRSQ)
 W !,">> Accession: ",LRAN," NOT VERIFIED <<"
 I $E(IOST,1,2)="C-" W $C(7)
 Q
 ;
 ;
INFO ;
 N X
 W !,"Sequence #: ",LRSQ
 S X=^LAH(LRLL,1,LRSQ,0)
 ;
 I LRWT="T" D
 . I $P(X,"^") W ?20,"TRAY: ",$P(X,"^")
 . I $P(X,"^",2) W ?33,"CUP: ",$P(X,"^",2)
 ;
 W ?45,"DUPLICATE "
 Q

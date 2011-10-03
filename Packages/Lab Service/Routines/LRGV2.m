LRGV2 ;DALOI/RWF - PART2 OF INSTRUMENT GROUP VERIFY DATA ;8/11/97
 ;;5.2;LAB SERVICE;**121,153,269**;Sep 27, 1994
 ;
 N LRGVP,LRSB,LRX
 ;
 I $P(LR0,U,8)'[LRMETH S $P(^LR(LRDFN,"CH",LRIDT,0),U,8)=LRMETH_";"_$P(LR0,U,8)
 S LRLDT=LRIDT
 D FINDPS
 I LRLDT="" W !,"NO DELTA SAMPLE",!
 ;
 ; If results exist in ^LR then delete results from LAH.
 I LRVF D
 . S LRX=1
 . F  S LRX=$O(^LR(LRDFN,"CH",LRIDT,LRX)) Q:LRX'>0  I ^(LRX)'["pending" K ^LAH(LRLL,1,LRSQ,LRX)
 ;
 S LRX=1
 F  S LRX=$O(^LAH(LRLL,1,LRSQ,LRX)) Q:LRX'>0  S LRSB(LRX)=^LAH(LRLL,1,LRSQ,LRX)
 ;
 S LRVRM=1,(LRDELTA,LRCRIT,LRCNT,LRNX)=0
 F  S LRNX=$O(LRORD(LRNX)) Q:LRNX'>0  D DC
 ;
 I 'LRVRFYAL,(LRDELTA!LRCRIT) D NOP Q
 ;
 S LREXEC=LRCFL D ^LREXEC:LRCFL]""
 ;
 S:'$P(^LR(LRDFN,"CH",LRIDT,0),U,5) $P(^LR(LRDFN,"CH",LRIDT,0),U,5)=LRSPEC
 ;
 ; Move comments from LAH to LR
 I $O(^LAH(LRLL,1,LRSQ,1,0)) D LRSBCOM^LRVR4
 ;
 ; Verify results and update files.
 K LRPRGSQ
 D V11^LRVR3
 W !!,">> Accession #: ",LRAN," VERIFIED <<"
 ;
 ; Display results which were not verified.
 I $O(^LAH(LRLL,1,LRSQ,1))>1 D
 . W !,"  STILL TO BE VERIFIED:"
 . S LRX=1
 . F  S LRX=$O(^LAH(LRLL,1,LRSQ,LRX)) Q:LRX<1  W ?25,$$GET1^DID(63.04,LRX,"","LABEL"),!
 ;
 D DASH^LRX
 ;
 K LRSB
 Q
 ;
 ;
DC ; Perform range and delta checks
 ;
 N LRCW,LRQ,X,Y
 ;
 S LRSB=+LRORD(LRNX),LRTS=$S($D(^TMP("LR",$J,"TMP",LRSB)):^(LRSB),1:0) Q:'LRTS
 S X=$P($G(LRSB(LRSB)),U),X1="",LRFLG=""
 I X=""!(X["pending") Q
 I LRLDT'="" S X1=$G(^LR(LRDFN,"CH",LRLDT,LRSB))
 ;
 ; Setup variable for range and delta checking
 D V25^LRVER5
 ;
 ; Do range checking
 S LRQ=""
 D RANGE^LRVR4
 I LRFLG["*" S LRCRIT=1
 ;
 ; Display test name, results, flags and units
 S X=$P(LRSB(LRSB),"^"),LRCW=8
 ;W !,$P(^LAB(60,+LRTS,0),"^"),?31,@LRFP," ",$$LJ^XLFSTR(LRFLG,2)," ",$$LJ^XLFSTR($P(LRNGS,"^",7),10)
 W !,$P(^LAB(60,+LRTS,0),"^"),?31,@LRFP," ",$$LJ^XLFSTR(LRFLG,2)," ",$P(LRNGS,"^",7)
 I LRFLG["*" D
 . N X
 . S X="CRITICAL "_$S(LRFLG["L":"LOW",LRFLG["H":"HIGH",1:"")_"!!"
 . I $E(IOST,1,2)="C-" W " ",@LRVIDO,X,@LRVIDOF,$C(7,7,7)
 . E  W " ",X
 ;
 ; Do delta checking
 S X=$P(LRSB(LRSB),"^")
 S Y=0 I LRDEL'="" X LRDEL S:Y LRDELTA=Y
 Q
 ;
 ;
NOP ;
 W !,">> Accession #: ",LRAN," NOT VERIFIED"
 I LRDELTA W " - DELTA check flag"
 I LRCRIT W " - CRITICAL range flag"
 W " <<"
 I $E(IOST,1,2)="C-" W $C(7)
 Q
 ;
 ;
INFO ;
 W !,"Sequence #: ",LRSQ
 S X=$P(^LAH(LRLL,1,LRSQ,0),"^",1),Y=$P(^(0),"^",2)
 W:$L(X)!$L(Y) ?20,"TRAY: ",X,?33,"CUP: ",Y,?45,"DUPLICATE "
 Q
 ;
 ;
FINDPS ; Find previous specimen to use for delta check
 ; Specimen needs to be within "days back (LRTM60)" parameter and have
 ; a dataname in common with a dataname on the sequence entry in LAH.
 ;
 N LRQUIT,LRX
 ;
 S LRQUIT=0
 F  S LRLDT=$O(^LR(LRDFN,"CH",LRLDT)) Q:'LRLDT  D  Q:LRQUIT
 . I LRLDT>LRTM60 S LRLDT="",LRQUIT=1 Q
 . S LRX=$G(^LR(LRDFN,"CH",LRLDT,0))
 . I $P(LRX,U,5)'=LRSPEC!('$P(LRX,U,3)) Q
 . S LRX=1
 . F  S LRX=$O(^LAH(LRLL,1,LRSQ,LRX)) Q:LRX'>0  I $D(^LR(LRDFN,"CH",LRLDT,LRX)) S LRQUIT=1 Q
 ;
 Q

LRLABXT ;SLC/TGA - REPRINTS DEMAND LABELS ;2/19/91  10:38
 ;;5.2;LAB SERVICE;**80,161**;Sep 27, 1994
 ;
EN ; Reprint labels
 D IOCHK
 I '$D(LRLABLIO) D K Q
 D OPEN^%ZISUTL("LRHOME","HOME") ; Setup handle for user's "HOME" device.
 D USE^%ZISUTL("LRHOME")
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:Range of Accessions;2:Selected Accessions",DIR("A")="Selection Method",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D K Q
 S LRTYPE=+Y
ASK ;
 D USE^%ZISUTL("LRHOME")
 S (LRACC,LREXMPT)=1,(LRCNT,LRQUIT)=0
 K ^TMP("LRLABXT",$J)
 I LRTYPE=1 D
 . D ^LRWU4
 . I LRAN<1 S LRQUIT=1 Q  ; User aborted selection.
 . S FIRST=LRAN,X=$O(^LRO(68,LRAA,1,LRAD,1,":"),-1)
 . W !
 . S DIR(0)="NO^"_LRAN_":"_X_":0",DIR("A")="Reprint from "_LRAN_" to",DIR("B")=LRAN
 . D ^DIR K DIR
 . I $D(DIRUT) S LRQUIT=1 Q
 . W !
 . S LRAN=FIRST-1,LAST=Y
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LAST)  D
 . . W:$X>(IOM-1) ! W "." ; Let user know we're looking.
 . . D SETTMP
 I LRTYPE=2 F  D  Q:LRQUIT!(LRAN<1)
 . D ^LRWU4
 . I $D(DTOUT)!($D(DUOUT)) S LRQUIT=1 Q
 . I LRAN<1 S:'$D(^TMP("LRLABXT",$J)) LRQUIT=1 Q
 . D SETTMP
 I 'LRQUIT,LRCNT>10 D
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="YO",DIR("A",1)="Reprinting labels for "_LRCNT_" accessions!",DIR("A")="Are you sure",DIR("B")="NO"
 . D ^DIR
 . I Y<1!($D(DIRUT)) S LRQUIT=1 Q
 I LRQUIT D K Q
 I $D(LRLABLIO("Q")) D  G ASK
 . S ZTIO=LRLABLIO,ZTRTN="LOAD^LRLABXT",ZTDESC="Reprint Lab Accession Labels"
 . S ZTSAVE("^TMP(""LRLABXT"",$J,")=""
 . D ^%ZTLOAD
 . W !,"Labels ",$S($G(ZTSK):"queued to "_$P(LRLABLIO,";")_" Task #"_ZTSK,1:"NOT queued"),!
 . K ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE
 W !!,"Printing labels on ",$P(LRLABLIO,";"),!
 D USE^%ZISUTL("LRLABEL")
LOAD ; Tasked entry point and from above.
 D PSET^LRLABLD
 F  S LRLABX=$Q(^TMP("LRLABXT",$J)) Q:LRLABX=""  Q:$QS(LRLABX,1)'="LRLABXT"!($QS(LRLABX,2)'=$J)  D
 . S LRAA=$QS(LRLABX,3),LRAD=$QS(LRLABX,4),LRAN=$QS(LRLABX,5)
 . D LBLTYP^LRLABLD
 . D PRINT
 . K @LRLABX
 I $D(ZTQUEUED) D K Q
 G ASK
 ;
PRINT ;
 ; Called by above, LRLABXOL
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRSN=+$P(X,U,5),LRODT=+$P(X,U,4),LRLLOC=$P(X,U,7)
 S LRCE=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.1)),"^")
 S LRACC=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 S LRRB=0
 D LRBAR^LRLABLD
 D GO^LRLABLD
 Q
 ;
IOCHK ; Select and check label printer.
 ; Called from above, LRLABXOL
 I '$D(LRLABLIO) D
 . D ^LRLABLIO
 . ; Time delay - allow port to be reopened if closed in call to LRLABLIO
 . I $D(LRLABLIO),'$D(IO("Q")) H 2
 I '$D(LRLABLIO) Q
 I '$D(LRLABLIO("Q")) D
 . N %ZIS,IOP
 . S %ZIS="",IOP=LRLABLIO
 . D OPEN^%ZISUTL("LRLABEL",IOP,.%ZIS) ; Setup handle for user's LABEL device.
 . I POP D
 . . W !,$C(7),"Unable to open device"
 . . K LRLABLIO
 Q
 ;
SETTMP ; Setup TMP global with accession to reprint.
 S LRCNT=LRCNT+1,^TMP("LRLABXT",$J,LRAA,LRAD,LRAN)=""
 Q
 ;
K ; Cleanup
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D CLOSE^%ZISUTL("LRLABEL"),CLOSE^%ZISUTL("LRHOME"),PKILL^%ZISP
 D KVAR^LRX
 K %,IO("Q"),A,B,DIC,I,I1,IOP,J,K,L,LAST,N,POP,R,S1,S2,T,X,Y,Z
 K LRAA,LRACC,LRAD,LRAN,LRCE,LRCNT,LRDAT,LRDPF,LREXMPT,LRINFW,LRLABEL,LRLF,LRDFN,LRODT,LRPREF,LRSSP
 K LRNOLABL,LRPRAC,LRTJ,LRTJDATA,LRLABX,LRQUIT,LRTOP,LRTS,LRTYPE,LRTV,LRTVOL,LRTXT,LRVOL,LRLABLIO,LRFN,LRAD,LRLLOC,LRNN,LRRB,LRSN
 K LRX,LRXL,LRBAR,LRBAR1,LRBAR0,LRBARID,LRUID,LRURG,LRURG0,LRURGA
 K ^TMP("LRLABXT",$J)
 Q

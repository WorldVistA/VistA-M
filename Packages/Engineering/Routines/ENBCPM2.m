ENBCPM2 ;(WASH ISC)/DH-Bar Coded PMI ;4.9.97
 ;;7.0;ENGINEERING;**1,35**;Aug 17, 1993
UPDATE ;   Update File 6914
 N DIE,DA,DR,TAG
 I '$D(^ENG(6914,ENEQ,0)) S ENMSG="ITEM NOT IN DATABASE.",ENMSG(0,1)="Label was scanned incorrectly or Equipment File is corrupted." D XCPTN Q
 L +^ENG(6914,ENEQ):5 I '$T S ENMSG="RECORD LOCKED. Equipment ID#: "_ENEQ,ENMSG(0,1)="This record is being edited by another user at this time.",ENMSG(0,2)="Please update the inventory data manually." D XCPTN Q
 S TAG="XCPTN^ENBCPM2" D FLAG^ENEQNX2
 S ENOLDLOC=""
 I $P($G(^ENG(6914,ENEQ,2)),U,13)=DT D  I ENOLDLOC=ENLOC L -^ENG(6914,ENEQ) Q  ;Record already updated
 . S X=$P($G(^ENG(6914,ENEQ,3)),U,5) I X]"",X'["E",X=+X S ENOLDLOC=$P($G(^ENG("SP",X,0)),U)
 . Q:ENLOC=ENOLDLOC
 . I ENLOC["E" S ENOLDLOC=$TR(ENOLDLOC,"e","E")
 S ENLOC(0)=ENLOC
 I ENLOC]"",'$D(^ENG("SP","B",ENLOC)),ENLOC["E" F  S ENLOC(0)=$P(ENLOC(0),"E")_"e"_$P(ENLOC(0),"E",2,99) I $D(^ENG("SP","B",ENLOC(0)))!(ENLOC(0)'["E") Q
 I '$D(^ENG("SP","B",ENLOC(0))) L -^ENG(6914,ENEQ) S ENMSG="BAD LOCATION",ENMSG(0,1)="Location not in Space File.  Can't update the Equipment Record." D XCPTN Q
 S DIE="^ENG(6914,",DA=ENEQ,DR="24///^S X=ENLOC(0);23///^S X=DT"
 D ^DIE L -^ENG(6914,ENEQ)
 Q
 ;
XCPTN ;  Print Exception Messages
 U IO
 D:ENY=0!(ENY>(IOSL-5)) HDR W !!,ENMSG,! W:$D(ENLBL) "   Label scanned as: ",ENLBL W:$D(ENLOC) "   Location: ",ENLOC S ENY=ENY+3
 I $D(ENMSG(0)) F I=0:0 S I=$O(ENMSG(0,I)) Q:I'=+I  W !,ENMSG(0,I) S ENY=ENY+1
 K ENMSG
 Q
 ;
HDR ;  New page for exception printing
 U IO
 I IO=IO(0),$E(IOST,1,2)="C-",ENY>0 D HOLD
 I ENPG!($E(IOST,1,2)="C-") W @IOF
 S ENPG=ENPG+1
 W "BAR CODED PMI EXCEPTION MESSAGES  (Time stamp: "_ENCTTI(0)_")",?(IOM-8),ENDATE
 W !,"   Global Reference: ^PRCT(446.4,"_ENCTID_",2,"_ENCTTI_",1,",?(IOM-10),"Page ",ENPG
 K X S $P(X,"-",(IOM-1))="-" W !,X
 S ENY=4
 Q
HOLD I $E(IOST,1,2)="C-" W !,"Press RETURN to continue..." R X:DTIME
 Q
ZTSK ;Schedule processing for later time (from ENBCPM1)
 K IO("Q") S ZTIO=IO,ZTRTN="NEWLOC^ENBCPM1",ZTDESC="Record PMI (Bar code)",ZTSAVE("EN*")="",ZTSAVE("DT")=""
 D ^%ZTLOAD K ZTSK
 G EXIT^ENBCPM5
 ;ENBCPM2

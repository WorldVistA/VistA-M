ENSA2 ;(WASH ISC)/DH-Process MedTester Data ;1/9/2001
 ;;7.0;ENGINEERING;**1,14,21,68**;Aug 17, 1993
PMN S ENEQ(0)=0 I '$D(^ENG(6914,"C",ENLBL)) S ENMSG="LOOK-UP ON EQUIPMENT FILE FAILED.",ENMSG(0,1)="Attempt was by PM #: "_ENLBL D XCPTN Q
 S ENPMN=ENLBL,ENEQ=$O(^ENG(6914,"C",ENLBL,0)) Q:ENEQ=""
 G UPDATE1
UPDATE ;Update File 6914
 S ENEQ(0)=0
 I ENLBL[" EE",$P(ENLBL," ")'=ENSTA D  I $D(ENMSG) D XCPTN Q
 . K ENMSG S ENMSG="FOREIGN EQUIPMENT."
 . F I=1:1:8 I ENSTAL(I),$E(ENLBL,1,ENSTAL(I))=ENSTA(I) K ENMSG Q
 . I $D(ENMSG) S ENMSG(0,1)="Cannot process a bar code label from another VAMC."
UPDATE1 N DIE,DA,DR I '$D(^ENG(6914,ENEQ,0)) S ENMSG="ITEM NOT IN DATABASE.",ENMSG(0,1)="Control Number entered incorrectly or Equipment File is corrupted." D XCPTN Q
 L +^ENG(6914,ENEQ):10 I '$T S ENMSG="RECORD LOCKED.",ENMSG(0,1)="This record is being written to by another user at this time.",ENMSG(0,2)="Please make the update manually." D XCPTN Q
 S ENOLDLOC=""
 I $P($G(^ENG(6914,ENEQ,2)),U,13)=ENSTDT D  I ENLOC=ENOLDLOC L -^ENG(6914,ENEQ) Q  ;Record already updated
 . S X=$P($G(^ENG(6914,ENEQ,3)),U,5) I X]"",X'["E",X=+X S ENOLDLOC=$P($G(^ENG("SP",X,0)),U)
 . Q:ENLOC=ENOLDLOC
 . I ENOLDLOC["e" S ENOLDLOC=$TR(ENOLDLOC,"e","E")
 S DIE="^ENG(6914,",DA=ENEQ
 I ENLOC]"" D
 . I $D(^ENG("SP","B",ENLOC)) S DR="24///^S X=ENLOC" D ^DIE Q
 . I ENLOC["E" D
 .. S ENLOC(0)=ENLOC F  S ENLOC(0)=$P(ENLOC(0),"E")_"e"_$P(ENLOC(0),"E",2,99) I $D(^ENG("SP","B",ENLOC(0)))!(ENLOC(0)'["E") Q
 .. I $D(^ENG("SP","B",ENLOC(0))) S DR="24///^S X=ENLOC(0)" D ^DIE
 .. Q
 S:ENSTDT="" ENSTDT=DT S DR="23///^S X=ENSTDT" D ^DIE
 L -^ENG(6914,ENEQ)
 Q
 ;
XCPTN ;Print Exception Messages
 I 'ENPAPER D:ENY=0!(ENY>(IOSL-6)) HDR
 U IO W !,ENMSG,! W:$D(ENLBL) "  Control Number: ",ENLBL W:$D(ENLOC) "  Location: ",ENLOC S ENY=ENY+3
 I $D(ENMSG(0)) D
 . F I=0:0 S I=$O(ENMSG(0,I)) Q:I'=+I  W !,ENMSG(0,I) S ENY=ENY+1
 . W ! S ENY=ENY+1
 K ENMSG
 Q
HDR ;New page for exception printing
 I $E(IOST,1,2)="C-",ENY>0 D HOLD
 U IO I ENPG!($E(IOST,1,2)="C-") W @IOF
 S ENPG=ENPG+1 W "MedTester EXCEPTION MESSAGES",?(IOM-15),ENDATE
 W !,"   Uploaded by: ",$S($D(DUZ):$P(^VA(200,DUZ,0),U),1:"UNIDENTIFIED USER"),?(IOM-15),"Page ",ENPG
 K % S $P(%,"-",(IOM-1))="-" W !,%
 S ENY=4
 Q
HOLD W !,"Press RETURN to continue..." R X:DTIME
 Q
 ;ENSA2

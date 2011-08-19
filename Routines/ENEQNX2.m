ENEQNX2 ;(WASH ISC)/DH-Update Equipment Record ;2.24.97
 ;;7.0;ENGINEERING;**1,35**;Aug 17, 1993
 ;
UPDATE ;   Update File 6914
 N DIE,DA,DR,TAG
 I '$D(DT) S U="^",%DT="",X="T" D ^%DT S DT=+Y
 I '$D(^ENG(6914,ENEQ,0)) S ENMSG="ITEM NOT IN DATABASE.",ENMSG(0,1)="Label was scanned incorrectly or File 6914 is corrupted." D XCPTN^ENEQNX1 Q
 L +^ENG(6914,ENEQ):5 I '$T S ENMSG="RECORD LOCKED. Equipment ID#: "_ENEQ,ENMSG(0,1)="This record is being edited by another user at this time.",ENMSG(0,2)="Please update the inventory record manually." D XCPTN^ENEQNX1 Q
 S TAG="XCPTN^ENEQNX1" D FLAG
 S ENOLDLOC=""
 I $P($G(^ENG(6914,ENEQ,2)),U,13)=DT D  I ENLOC=ENOLDLOC L -^ENG(6914,ENEQ) Q  ;Record already updated
 . S X=$P($G(^ENG(6914,ENEQ,3)),U,5) I X]"",X'["E",X=+X S ENOLDLOC=$P($G(^ENG("SP",X,0)),U)
 . Q:ENLOC=ENOLDLOC
 . I ENOLDLOC["e" S ENOLDLOC=$TR(ENOLDLOC,"e","E")
 S ENLOC(0)=ENLOC
 I ENLOC]"",'$D(^ENG("SP","B",ENLOC)),ENLOC["E" F  S ENLOC(0)=$P(ENLOC(0),"E")_"e"_$P(ENLOC(0),"E",2,99) I $D(^ENG("SP","B",ENLOC(0)))!(ENLOC(0)'["E") Q
 I '$D(^ENG("SP","B",ENLOC(0))) L -^ENG(6914,ENEQ) S ENMSG="BAD LOCATION",ENMSG(0,1)="Location not in Space File.  Can't update the Equipment Record." D XCPTN^ENEQNX1 Q
 S DIE="^ENG(6914,",DA=ENEQ,DR="24///^S X=ENLOC(0);23///^S X=DT"
 D ^DIE L -^ENG(6914,ENEQ)
 Q
 ;
FLAG ;  Something special about this equipment
 N ENMSG,ENWO,I,J,X
 S X=$$GET1^DIQ(6914,ENEQ,20) I X]"","TURNED IN^LOST OR STOLEN"[X S ENMSG(0,1)="Use Status indicates that this equipment is "_X_"."
 S ENWO=0 F  S ENWO=$O(^ENG(6920,"G",ENEQ,ENWO)) Q:'ENWO  D
 . Q:$P($G(^ENG(6920,ENWO,5)),U,2)]""
 . S J=0 F  S J=$O(^ENG(6920,ENWO,8,J)) Q:'J  I $P($G(^ENG(6920,ENWO,8,J,0)),U)=8 D
 .. S (J,ENWO)=9999999999,I=$S($D(ENMSG(0,1)):2,1:1)
 .. S ENMSG(0,I)="There is an open HAZARD ALERT on this piece of equipment."
 I $D(ENMSG(0,1)) S ENMSG="EQUIPMENT FLAG" D @TAG
 Q
 ;
HOLD I $E(IOST,1,2)="C-" W !,"Press <RETURN> to continue..." R X:DTIME
 Q
 ;
EXIT I $E(IOST,1,2)="C-",$D(ENY),ENY>0 D HOLD
 K EN,ENA,ENB,ENEQ,ENLBL,ENSTA,ENSTAL,ENMSG,ENCTID,ENCTTI,ENX,ENX1,ENY,ENCTID
 K ENLOC,ENOLDLOC,ENLKAHD,ENPG,ENDATE,ENDA,I,J,K,DIC,DIC,DA,DR,%DT,%,X
 W @IOF
 I $E(IOST,1,2)="P-",'$D(ZTQUEUED) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENEQNX2

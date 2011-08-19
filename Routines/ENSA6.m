ENSA6 ;(WASH ISC)/DH-MedTester Utilities ;1/2/2001
 ;;7.0;ENGINEERING;**54,67**;Aug 17, 1993
MSG ;Opening message to user
 W !!,"The system is now ready to update the Equipment File on the basis of",!,"data acquired from the MedTester."
 W !!,"If the system encounters data that cannot be processed in the normal fashion",!,"it will give you written notice in the form of a MedTester Exception Message."
 W !,"These messages will provide notification of such things as test failures",!,"and database inconsistencies."
 W !!,"If a device fails a MedTester test sequence, the site is expected to",!,"evaluate the failure and issue a regular work order for corrective action."
 W !,"If a PM work order exists for such a device and if you have elected to use",!,"MedTester data to close out that worklist, then the PM status will be set to"
 W !,"'CORRECTIVE ACTION TAKEN/REQUESTED' but the PM work order will remain open",!,"and nothing will be posted to the Equipment History. Once corrective action"
 W !,"has been taken, the PM work order should be closed out manually. The WORK",!,"PERFORMED field should contain a reference to the regular work order."
 W !!,"You will soon select a hard copy device (printer) to receive MedTester",!,"Exception Messages, but first we need to know whether or not you want paper"
 W !,"copies of the actual test results.",!
 Q
WOCHK ;Has PM already been posted?
 ;Expects ENEQ, ENPMWO, ENREC
 F I=0:0 S I=$O(^ENG(6914,ENEQ,6,I)) Q:I'>0  I $P(^ENG(6914,ENEQ,6,I,0),U,2)[ENPMWO S ENWOX=I,ENPMWO(0)=$P(^(0),U,2) S ^TMP($J,$S($P(^(0),U,3)="C":"FAIL",1:"PASS"),ENEQ)="" Q
 Q:'ENWOX  ; nothing presently recorded
 Q:ENTEST=""  ; need this to know if duplicate or additional
 Q:$P(^ENG(6914,ENEQ,6,ENWOX,0),U,9)[ENTEST  ; duplicate
 I 'ENFAIL,$D(^TMP($J,"FAIL",ENEQ)) Q  ; already have reg work order
 S ENMSG=$S(ENFAIL:"FAILed MedTester, but PM Work Order has already been posted for ID#: ",1:"PM Work Order already posted for Equipment ID#: ")_ENEQ
 I ENFAIL!($D(^TMP($J,"FAIL",ENEQ))) S ENMSG(0,1)="You should manually enter a work order for corrective action."
 E  S ENMSG(0,1)="MedTester time and labor will be added."
 S ENMSG(0,2)="MedTester REC # "_ENREC S:$D(ENPMWO(0)) ENMSG(0,2)=ENMSG(0,2)_"     Work Order Ref: "_ENPMWO(0)
 D XCPTN^ENSA2
 ;
ADDMT ;  add anything we have from MedTester to existing entry
 ;  enwox is now the ien of the mult
 ;  enemp, entec, entest & entime from ensa*
 Q:ENFAIL  ; nothing to add
 L +^ENG(6914,ENEQ,6):5 Q:'$T  ; bag it
 S $P(^ENG(6914,ENEQ,6,ENWOX,0),U,9)=$E($P(^ENG(6914,ENEQ,6,ENWOX,0),U,9)_" "_ENTEST,1,140)
 N LABOR,WAGE
 S (LABOR,WAGE)=0
 S $P(^ENG(6914,ENEQ,6,ENWOX,0),U,4)=$P(^(0),U,4)+ENTIME
 I ENTEC>0 S PMTOT(ENSHKEY,ENTEC)=$G(PMTOT(ENSHKEY,ENTEC))+ENTIME
 S WAGE=$S($G(ENTEC):$P($G(^ENG("EMP",ENTEC,0)),U,3),1:$P($G(^DIC(6910,1,0)),U,4)) S:WAGE="" WAGE=0 S X=WAGE*ENTIME,X(0)=2 D ROUND^ENLIB S LABOR=+Y
 S $P(^ENG(6914,ENEQ,6,ENWOX,0),U,5)=$P(^ENG(6914,ENEQ,6,ENWOX,0),U,5)+LABOR
 I $P(^ENG(6914,ENEQ,6,ENWOX,0),U,8)'=$E(ENEMP,1,15) S $P(^(0),U,8)="MULTIPLE"
 L -^ENG(6914,ENEQ,6)
 Q
 ;ENSA6

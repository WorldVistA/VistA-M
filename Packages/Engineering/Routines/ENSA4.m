ENSA4 ;(WASH ISC)/DH-Post MedTester PMI ;5.26.99
 ;;7.0;ENGINEERING;**9,14,35,54**;Aug 17, 1993
POST ;Post PMI to Equip Hist
CHK1 I ENFAIL,'$D(^TMP($J,"FAIL",ENEQ)),$D(^TMP($J,"PASS",ENEQ)) D  Q
 . S ENMSG="Equipment Entry # "_ENEQ_" FAILED INSPECTION but passed a prior MedTester exam."
 . S ENMSG(0,1)="The first test was posted to the equipment history, which means that you should"
 . S ENMSG(0,2)="manually enter a corrective work order for the failure." I ENTEST]"" S ENMSG(0,2)=ENMSG(0,2)_" Test failed: "_ENTEST
 . D XCPTN^ENSA2
CHK2 I ENFAIL,$D(^TMP($J,"FAIL",ENEQ)) Q  ; already failed
 I ENPMWO="" G POST1^ENSA5 ; not processing worklist
 S ENWOX=0 D WOCHK^ENSA6 ; maybe work already posted
 Q:ENWOX  ; WO has been closed ; MedTester time & labor cost added
 F DA=0:0 S DA=$O(^ENG(6920,"G",ENEQ,DA)) Q:DA'>0  I $P(^ENG(6920,DA,0),U,1)[ENPMWO D POST1 Q
 D:DA'>0 POST1^ENSA5
 Q
POST1 ;PM work order to be closed
 S ENTEC(0)=$P($G(^ENG(6920,DA,2)),U,2)
 I ENTEC'=ENTEC(0)!(ENTIME>0) D
 . I ENTEC]"",ENTEC'=ENTEC(0) D
 .. S $P(^ENG(6920,DA,2),U,2)=ENTEC
 .. S:'$D(^ENG(6920,DA,7,0)) ^ENG(6920,DA,7,0)="^6920.02PA^1^1"
 .. S ^ENG(6920,DA,7,1,0)=ENTEC_U_$P($G(^ENG(6920,DA,5)),U,3)_U_ENSHKEY
 .. I ENTIME'>0 D
 ... S ENH=$P(^ENG(6920,DA,7,1,0),U,2) Q:ENH=""
 ... S ENW="" I $D(^ENG("EMP",ENTEC,0)) S ENW=$P(^(0),U,3)
 ... I ENW="",$D(^DIC(6910,1,0)) S ENW=$P(^(0),U,4)
 ... I ENW>0 S X=ENH*ENW,X(0)=2 D ROUND^ENLIB S $P(^ENG(6920,DA,5),U,6)=+Y
 . I ENTIME>0 D
 .. S $P(^ENG(6920,DA,5),U,3)=ENTIME I $D(^ENG(6920,DA,7,1,0)) S $P(^(0),U,2)=ENTIME
 .. S ENW="" I ENTEC>0,$D(^ENG("EMP",ENTEC,0)) S ENW=$P(^(0),U,3)
 .. I ENW="",$D(^DIC(6910,1,0)) S ENW=$P(^(0),U,4)
 .. I ENW>0 S X=ENTIME*ENW,X(0)=2 D ROUND^ENLIB S $P(^ENG(6920,DA,5),U,6)=+Y
 I ENFAIL S ^TMP($J,"FAIL",ENEQ)="" G POST13^ENSA8
 S ^TMP($J,"PASS",ENEQ)=""
 D:$D(^ENG(6914,ENEQ,6)) PRVPST
 S:ENSTDT="" ENSTDT=DT
 S DIE="^ENG(6920,",DR="35.2///P;36////^S X=ENSTDT;32///^S X=""COMPLETED"""
 I $D(^ENG(6920,DA,5)) S ENWP(0)=$P(^(5),U,7) S:ENWP(0)]"" ENWP(0)=ENWP(0)_"; " S ENWP(0)=ENWP(0)_ENWP S:ENTEST]"" ENWP(0)=ENWP(0)_" "_ENTEST S $P(^(5),U,7)=$E(ENWP(0),1,140)
 K ENWP D ^DIE
 I ENTEC>0 S:ENTIME'>0 ENTIME=$P($G(^ENG(6920,DA,5)),U,3) I ENTIME>0 S PMTOT(ENSHKEY,ENTEC)=$G(PMTOT(ENSHKEY,ENTEC))+ENTIME
 I ENDEL="Y",$E(^ENG(6920,DA,0),1,3)="PM-" S DIK="^ENG(6920," D ^DIK
 K EN
 Q
 ;
PRVPST ;Check for previous (and direct) posting
 L +^ENG(6914,ENEQ,6):5 Q:'$T
 F I=0:0 S I=$O(^ENG(6914,ENEQ,6,I)) Q:I'>0  S ENSA2=$P(^ENG(6914,ENEQ,6,I,0),U,1) I $E(ENSA2,1,6)=$E(ENSTDT,2,7),$P(^(0),U,9)["MedTester" K ^ENG(6914,ENEQ,6,I,0) Q
 I I'>0 L -^ENG(6914,ENEQ,6) Q
 S J=0,I1="" F I=0:0 S I=$O(^ENG(6914,ENEQ,6,I)) Q:I'>0  S I1=I,J=J+1
 S:J=0 J="" S ^ENG(6914,ENEQ,6,0)=$P(^ENG(6914,ENEQ,6,0),U,1,2)_U_I1_U_J
 L -^ENG(6914,ENEQ,6)
 Q
 ;ENSA4

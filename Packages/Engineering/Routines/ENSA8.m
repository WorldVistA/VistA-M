ENSA8 ;(WASH ISC)/DH-MedTester PMI ;5.26.99
 ;;7.0;ENGINEERING;**1,14,35,54**;Aug 17, 1993
POST13 ;Device failed
 N PROBLEM,NUMBER,WARD S PROBLEM="Device failed a MedTester Inspection"
 S ENMSG="Equipment Entry # "_ENEQ_" FAILED INSPECTION. CORRECTIVE ACTION REQUIRED."
 S ENMSG(0,3)="MEDTESTER UPLOAD."
 S $P(^ENG(6920,DA,5),U,8)="C"
 I ENTEC>0,$D(^ENG("EMP",ENTEC,0)) D
 . I '$D(^ENG(6920,DA,7)) S ^ENG(6920,DA,7,0)="^6920.02PA^1^1"
 . S:ENTIME'>0 ENTIME=$P($G(^ENG(6920,DA,5)),U,3)
 . S ^ENG(6920,DA,7,1,0)=ENTEC_U_ENTIME_U_ENSHKEY
 . I ENTIME>0 D
 .. S $P(^ENG(6920,DA,5),U,3)=ENTIME
 .. S ENW=$P($G(^ENG("EMP",ENTEC,0)),U,3)
 .. I ENW="" S ENW=$P($G(^DIC(6910,1,0)),U,4)
 .. I ENW>0 S X=ENW*ENTIME,X(0)=2 D ROUND^ENLIB S $P(^ENG(6920,DA,5),U,6)=+Y
EXST S EN2=0 F EN1=0:0 S EN1=$O(^ENG(6920,"G",ENEQ,EN1)) Q:EN2!(EN1'>0)  D  I EN2 D XCPTN^ENSA2 Q
 . I $D(^ENG(6920,EN1,5)),$P(^(5),U,2)]"" Q
 . I $E(^ENG(6920,EN1,0),1,3)="Y2-" Q
 . I $E(^ENG(6920,EN1,0),1,3)="PM-" Q
 . I $D(^ENG(6920,EN1,1)),$P(^(1),U)=.5 S EN2=1 D  Q
 .. S ENMSG(0,1)="PM work order "_$P(^ENG(6920,DA,0),U)_" is being closed."
 .. S ENMSG(0,2)="Regular work order "_$P(^ENG(6920,EN1,0),U)_" is open."
 .. N ENDA S ENDA=DA,NUMBER=$P(^ENG(6920,EN1,0),U)
 .. D WOPOST
 . I $D(^ENG(6920,EN1,2)),$P(^(2),U)=ENSHKEY S EN2=1 D  Q
 .. N X S:'$D(^ENG(6920,EN1,1)) ^(1)=""
 .. S X=$P(^ENG(6920,EN1,1),U,2)
 .. I X'["cf:" S $P(^ENG(6920,EN1,1),U,2)=X_" cf: "_$P(^ENG(6920,DA,0),U)
 .. S NUMBER=$P(^ENG(6920,EN1,0),U)
 .. S ENMSG(0,1)="PM work order "_$P(^ENG(6920,DA,0),U)_" is being closed."
 .. S ENMSG(0,2)="Regular work order "_NUMBER_" is open."
 .. N ENDA S ENDA=DA
 .. D WOPOST
 Q:EN2
NEWWO N ENDA S ENDA=DA
 N SHOPKEY,CODE,DA,DR
 S SHOPKEY=ENSHKEY
 D WONUM^ENWONEW
 I NUMBER="" D  D XCPTN^ENSA2 Q
 . S ENMSG(0,1)="Work order "_$P(^ENG(6920,ENDA,0),U)_" will remain open."
 . S ENMSG(0,2)="When closed, it should contain a reference to a regular work order."
 S ENMSG(0,1)="PM work order "_$P(^ENG(6920,ENDA,0),U)_" is being closed out."
 S ENMSG(0,2)="Regular work order "_NUMBER_" has been generated."
 D WOPOST
 S DIE="^ENG(6920,",DR=".05///^S X=NUMBER;1///^S X=DT;2///^S X=""C"";6///^S X=PROBLEM;7.5////^S X=.5;9////^S X=ENSHKEY;16////^S X=ENTEC;17///^S X=""A"";18///^S X=ENEQ;32///^S X=""PENDING"""
 D ^DIE
 I ENLOC]"" D
 . I $D(^ENG("SP","B",ENLOC)) S DR="3///^S X=ENLOC" D ^DIE Q
 . I ENLOC["E" D
 .. S ENLOC(0)=ENLOC F  S ENLOC(0)=$P(ENLOC(0),"E")_"e"_$P(ENLOC(0),"E",2,99) I $D(^ENG("SP","B",ENLOC(0)))!(ENLOC(0)'["E") Q
 .. I $D(^ENG("SP","B",ENLOC(0))) S DR="3///^S X=ENLOC(0)" D ^DIE
 .. Q
 S EN1=$O(^ENG(6920.1,"B","GENERAL REPAIR (In-house)",0)) I EN1>0 S ^ENG(6920,DA,8,0)="^6920.035PA^1^1",^ENG(6920,DA,8,1,0)=EN1
 S ^ENG(6920,DA,6,0)="^^1^"_DT,^ENG(6920,DA,6,1,0)="Generated on the basis of MedTester upload  "_$P($G(^ENG(6920,ENDA,0)),U)_"."
 I ENWP]"" S $P(^ENG(6920,DA,6,0),U,3)=2,^ENG(6920,DA,6,2,0)=ENWP
 I $D(^ENG(6910.2,1,0)) S ENAUTO=$P(^(0),U,2) D  K ENAUTO
 . I ENAUTO]"","LS"[ENAUTO D
 .. S ENAUTO(0)=$P(^DIC(6922,SHOPKEY,0),U,3)
 .. I ENAUTO(0)]"",$D(^%ZIS(1,ENAUTO(0),0)) S WARD=0 D WOPRNT^ENWONEW
 . Q
 D XCPTN^ENSA2
 Q
 ;
WOPOST N DA,DR,EN1,X,X1 D
 . I ENTEC>0,$D(^ENG("EMP",ENTEC,0)) S X=ENTEC
 . E  S X=$P($G(^ENG(6920,ENDA,2)),U,2)
 . I ENTIME>0 S X1=ENTIME
 . E  S X1=$P($G(^ENG(6920,ENDA,7,1,0)),U,2)
 . I X>0,X1>0 S PMTOT(ENSHKEY,X)=$G(PMTOT(ENSHKEY,X))+X1
 S:'$D(^ENG(6920,ENDA,5)) ^ENG(6920,ENDA,5)=""
 S EN1=$P(^ENG(6920,ENDA,5),U,7) S:EN1]"" EN1=EN1_" "
 S EN1=EN1_"cf: "_NUMBER_" MedTester" S:ENTEST]"" EN1=EN1_" "_ENTEST
 S $P(^ENG(6920,ENDA,5),U,7)=$E(EN1,1,140)
 S DA=ENDA,DIE="^ENG(6920,",DR="36////^S X=DT;32///^S X=""COMPLETED"""
 D ^DIE
 I ENDEL="Y",$E(^ENG(6920,DA,0),1,3)="PM-" S DIK="^ENG(6920," D ^DIK
 Q
 ;ENSA8

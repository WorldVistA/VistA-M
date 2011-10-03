ENEQPMR1 ;(WASH ISC)/DH-Regular PMI Close Out ;1/2/2001
 ;;7.0;ENGINEERING;**1,15,35,42,54,67**;Aug 17, 1993
CO ;Close out Pm worklist
 S ENDEL="" I $D(^DIC(6910,1,0)) S ENDEL=$P(^(0),U,5)
 N PMTOT
 I ENDEL']"" R !!,"Should PM work orders be deleted after close out? YES//",X:DTIME G:X="^" EXIT S X=$$UP^XLFSTR(X) S:X=""!(X["Y") ENDEL="Y" I ENDEL'="Y",$E(X)'="N" D COBH1^ENEQPMR4 G CO
COF S DIC="^ENG(6920,",DIC(0)="AEQM",DIC("A")="Please enter first PM work order to be closed: ",DIC("S")="I $P(^(0),U,1)[""PM-""" D ^DIC K DIC("S") G:Y'>0 EXIT S DA=+Y,ENPMWO=$P(^ENG(6920,DA,0),U,1)
 S DIE="^ENG(6920,",DR=$S($D(^DIE("B","ENZPMCLOSE")):"[ENZPMCLOSE]",1:"[ENPMCLOSE]")
 S ENSHKEY=$S($D(^ENG(6920,DA,2)):$P(^(2),U),1:"") G:ENSHKEY="" EXIT
 I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" W *7,!!,"This work order has already been closed out and posted. If you wish to change",!,"the data, please use the EDIT WORK ORDER option." G CO1
 D ^DIE G:$D(Y) EXIT
 I $D(DA),$P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="PM-" D
 . I $P(^ENG(6920,DA,5),U,8)="C" D REGLR
 . D PMHRS^ENEQPMR4,PMINV^ENEQPMR4
 . I ENDEL="Y" S DIK="^ENG(6920," D ^DIK K DIK
CO1 S ENPMWO(1)=$O(^ENG(6920,"B",ENPMWO)) G:$P(ENPMWO(1),"-",2)'=$P(ENPMWO,"-",2) EXIT
CO2 W !!,"Next work order (or sequential portion), '^' to quit: "_ENPMWO(1)_"// " R X:DTIME G:X="^" EXIT I X?1.N S:$L(X)<3 X=$S($L(X)=1:"00"_X,1:"0"_X) S X=$P(ENPMWO,"-",1,2)_"-"_X W !,?10,"  ("_X_")"
 I X="" S X=ENPMWO(1)
 I $E(X,1,3)'="PM-" D COH2^ENEQPMR4 G CO2
 S ENPMWO=X,DIC="^ENG(6920,",DIC(0)="X",DIC("S")="I $D(^(2)),$P(^(2),U)=ENSHKEY,$E(^(0),1,3)=""PM-""" D ^DIC K DIC("S") I Y'>0 W "??",*7 D COH2^ENEQPMR4 G CO2
 S DA=+Y I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" W !!,*7,"This work order has already been closed out and posted. If you need to change",!,"the data, please use the EDIT WORK ORDER option." G CO1
 S DIE="^ENG(6920," D ^DIE G:$D(Y) EXIT
 I $D(DA),$P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="PM-" D
 . I $P(^ENG(6920,DA,5),U,8)="C" D REGLR
 . D PMHRS^ENEQPMR4,PMINV^ENEQPMR4
 . I ENDEL="Y" S DIK="^ENG(6920," D ^DIK K DIK
 G CO1
 ;
EXIT K ENPM,ENPMMN,ENPMWK,ENDEL,ENSHABR,ENSHOP,DIC,DIE,DIK,DA,DR,ENY,EN1,ENLOC
 I $D(ENPMWO) D
 . S X=$P(ENPMWO,"-",2),ENPMDT=""
 . F I=1:1:$L(X) S:$E(X,I)?1N ENPMDT=ENPMDT_$E(X,I)
 . S ENPMDT=$E(ENPMDT,1,4)
 . I $D(PMTOT) D COUNT^ENBCPM8
 K ENPMWO,ENPMDT,ENSHKEY
 Q
 ;
HOLD I $E(IOST,1,2)="C-" R !,"<cr> to continue, '^' to quit...",X:DTIME
 S ENY=1
 Q
 ;
REGLR ;Failed PM
 Q:'$D(^ENG(6920,DA,3))  N ENEQ,SHOPKEY,X,EN,DIE,DR,WARD,ADDWO
 S ENEQ=$P(^ENG(6920,DA,3),U,8) Q:ENEQ=""  Q:'$D(^ENG(6914,ENEQ,0))
 Q:'$D(^ENG(6920,DA,2))  S SHOPKEY=$P(^(2),U) Q:SHOPKEY=""
 S ADDWO=0
 F EN1=0:0 S EN1=$O(^ENG(6920,"G",ENEQ,EN1)) Q:EN1'>0  I $D(^ENG(6920,EN1,2)),$P(^(2),U)=SHOPKEY,$E($P(^(0),U),1,3)'="PM-",$E($P(^(0),U),1,3)'="Y2-" Q:'$D(^(5))  Q:$P(^(5),U,2)=""
 I EN1>0 D  Q:'ADDWO
 . W !!,"Work Order ",$P(^ENG(6920,EN1,0),U)," is open."
 . I $D(^ENG(6920,EN1,1)) W !,$P(^(1),U,2)
 . S DIR(0)="Y",DIR("A")="Would you like to edit it",DIR("B")="YES"
 . D ^DIR K DIR I 'Y S:Y=0 ADDWO=1 Q
 . N DA
 . S DIE="^ENG(6920,",DA=EN1
 . S DR="6" D ^DIE Q:$D(DTOUT)
 . S DR=$S($D(^DIE("B","ENZWOEDIT")):"[ENZWOEDIT]",1:"[ENWOEDIT]") D ^DIE
 . S X=$O(^ENG(6914,ENEQ,6,0))
 . I X>0 D
 .. S EN=^ENG(6914,ENEQ,6,X,0) Q:$P(EN,U,2)'=ENPMWO
 .. S $P(^ENG(6914,ENEQ,6,X,0),U,9)=$P(EN,U,9)_" cf: "_$P(^ENG(6920,EN1,0),U)
 S DIR(0)="Y",DIR("A")="Would you like to generate a regular work order"
 D ^DIR K DIR Q:Y'>0
 N CODE,NUMBER,DA
 D WONUM^ENWONEW Q:NUMBER=""
 S X=$O(^ENG(6914,ENEQ,6,0))
 I X>0 D
 . S EN=^ENG(6914,ENEQ,6,X,0) Q:$P(EN,U,2)'=ENPMWO
 . S $P(^ENG(6914,ENEQ,6,X,0),U,9)=$P(EN,U,9)_" cf: "_NUMBER
 S ENLOC=""
 I $D(^ENG(6914,ENEQ,3)) S X=$P(^(3),U,5) I X=+X,$D(^ENG("SP",X,0)) S ENLOC=$P(^(0),U)
 S DIE="^ENG(6920,",DR=".05///^S X=NUMBER;1///^S X=DT;2///^S X=""C"";7.5////^S X=DUZ;9////^S X=SHOPKEY;17///^S X=""A"";18///^S X=ENEQ;32///^S X=""IN PROGRESS"";3///^S X=ENLOC;6//^S X=""Failed PMI"""
 D ^DIE Q:$D(DTOUT)
 S DR=$S($D(^DIE("B","ENZWOEDIT")):"[ENZWOEDIT]",1:"[ENWOEDIT]")
 S WARD=0
 D ^DIE,WOPRNT^ENWONEW
 Q
 ;ENEQPMR1

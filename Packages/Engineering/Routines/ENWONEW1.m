ENWONEW1 ;(WASH ISC)/DLM/JED/DH/SAB-Work Order Transfer ;5/8/1998
 ;;7.0;ENGINEERING;**1,35,53**;Aug 17, 1993
TRANS ;Entry point
 N SHOPKEY,NEWSHOP,CODE,NUMBER,DONE,WARD
 S U="^",DONE=0 I $D(ENSHKEY),ENSHKEY>0 S DIC("B")=$P(^DIC(6922,ENSHKEY,0),U)
 S DIC="^DIC(6922,",DIC(0)="AEQM" D ^DIC S:Y>0 SHOPKEY=+Y K DIC
 Q:'$D(SHOPKEY)
 S DR=$S($D(^DIE("B","ENZWOXFER")):"[ENZWOXFER]",1:"[ENWOXFER]")
NEXT ;Loop thru (.) code until DONE
 F  D  Q:DONE
 . W !!,"Transfer a work order from ",$P(^DIC(6922,SHOPKEY,0),U)," to another shop?"
 . S DIR(0)="Y",DIR("B")=$S($D(CODE):"NO",1:"YES")
 . D ^DIR I Y'>0 S DONE=1 Q
 . S DIC("S")="I $P($G(^(5)),U,2)="""",$P($G(^(2)),U)=SHOPKEY,$E($P(^(0),U),1,3)'=""PM-"""
 . D WO^ENWOUTL Q:Y'>0  S DA=+Y
 . L +^ENG(6920,DA):5 I '$T W !,*7,"This work order is being edited by another user.  Please try again later." Q
 . I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" W !,*7,"This work order has already been closed out.  Transfer aborted." L -^ENG(6920,DA) Q
 . S DIC="^DIC(6922,",DIC(0)="AEQ",DIC("A")="Transfer to which shop: "
 . ; set a screen to prevent selection of same shop
 . S DIC("S")="I Y'="_SHOPKEY
 . D ^DIC K DIC("A"),DIC("S") I Y'>0 L -^ENG(6920,DA) Q
 . S NEWSHOP=+Y
 . S NUMBER="" D NEWNUM W:NUMBER]"" !,"New WORK ORDER #: ",NUMBER
 . I NUMBER="" D
 .. L -^ENG(6920,DA)
 .. W !!,*7,"Work order transfer unsuccessful."
 .. W !,"Please try again later or contact your IRM Service."
 . Q:NUMBER=""
 . W !,"Edit this work order?"
 . S DIR(0)="Y",DIR("B")="YES"
 . D ^DIR I Y>0 S DIE="^ENG(6920," D ^DIE
 . L -^ENG(6920,DA)
 . S WARD=0 S SHOPKEY(0)=SHOPKEY,SHOPKEY=NEWSHOP D WOPRNT^ENWONEW S SHOPKEY=SHOPKEY(0)
 Q
 ;
NEWNUM ;Change the WORK ORDER #
 N DR
 I '$D(DT) S %DT="",X="T" D ^%DT S DT=+Y
 S CODE=$P(^DIC(6922,NEWSHOP,0),U,2)_$E(DT,2,7)_"-"
 L +^ENG(6920,"B"):20 Q:'$T
 F I=1:1 S X=CODE_$S(I<10:"00"_I,I<100:"0"_I,1:I) I '$D(^ENG(6920,"B",X)),'$D(^ENG(6920,"H",X)) S NUMBER=X Q
 I NUMBER]"" S DIE="^ENG(6920,",DR=".01///"_NUMBER_";9///"_NEWSHOP D ^DIE
 L -^ENG(6920,"B")
 Q
 ;ENWONEW1

ENWONEW2 ;(WASH ISC)/DH-Work Order Entry ;5.29.97
 ;;7.0;ENGINEERING;**1,25,35,42**;Aug 17, 1993
 ;
TRNIN ;  Entry point to get work order for de-installation of equipment
 ;  Expects DUZ
 ;  Expects EQUIPMENT ID in piece 1 of WODATA, LOCATION in piece 2
 ;  Expects that SERVICE POINTER may be in local variable PRCNSRV
 ;  Returns work order number as ENWO and internal entry number as ENDA
 I $G(DUZ),+$G(WODATA)
 E  Q  ;Insufficient information to proceed
 N SHOPKEY,NUMBER,NAME,PHONE,ITEM,LOC,SERVICE,WARD
 N DIC,DIE,DIQ,DA,DR
 S SHOPKEY=$P($G(^DIC(6910,1,20)),U) D:'SHOPKEY  Q:'SHOPKEY
 . S SHOPKEY=$P($G(^DIC(6910,1,0)),U,6) D:'SHOPKEY
 .. S DIC="^DIC(6922,",DIC(0)="AEQM",DIC("S")="I Y#100>89" D ^DIC K DIC("S") S:Y>0 SHOPKEY=+Y
 Q:'$D(^DIC(6922,SHOPKEY,0))
 D WONUM^ENWONEW ;create work order
 I NUMBER="" W !!,"Can't seem to add a new work order at this time. Suggest that you",!,"contact IRM.",*7 Q
 W !,"Work Order #: ",NUMBER S ENDA=DA,ENWO=NUMBER
 L +^ENG(6920,ENDA):0 I '$T W !!,"Bad news. Another user is already editing the work order that you just",!,"created. Please make a note of the work order number and advise Engineering",!,"Service of the problem."
FILL ;Fill in the work order
 S DIC="^VA(200,",DR=".01;.131;.132;.133;.134;.135",DIQ="TMP",DIQ(0)="E",DA=DUZ
 D EN^DIQ1
 S NAME=$E(TMP(200,DA,.01,"E"),1,15)
 F X=".131",".132",".133",".134",".135" S PHONE=TMP(200,DA,X,"E") Q:PHONE]""
 K TMP
LOAD S DIE="^ENG(6920,",DA=ENDA,DR="1///N;.05///^S X=NUMBER;7.5////"_DUZ_";9///"_SHOPKEY_";2///C"
 S DR=DR_";7///"_NAME_";17///A" S:PHONE]"" DR=DR_";8///^S X=PHONE"
 S ITEM=$P(WODATA,U),LOC=$P(WODATA,U,2)
 I LOC=+LOC S LOC=$P($G(^ENG("SP",LOC,0)),U)
 I LOC']"" S LOC=$P($G(^ENG(6914,ITEM,3)),U,5) S:LOC=+LOC LOC=$P(^ENG("SP",LOC,0),U)
 S DR=DR_";18///^S X=ITEM" I LOC]"" S DR=DR_";3///^S X=LOC"
 I $G(PRCNSRV) S SERVICE=$P($G(^DIC(49,+PRCNSRV,0)),U),DR=DR_";23///^S X=SERVICE"
 S DR=DR_";6///Prepare equipment for turn-in.;32///^S X=2;35///R2"
 D ^DIE
 S DR=$S($D(^DIE("B","ENZTIWO")):"[ENZTIWO]",$D(^DIE("B","ENTIWO")):"[ENTIWO]",1:"")
 D:DR]"" ^DIE
 L -^ENG(6920,ENDA)
 S WARD=1 D WOPRNT^ENWONEW
 Q
 ;
AUTODEV ;Get device from ENG SECTION (null if unsuccessful)
 S DEVICE="",X=$P(^DIC(6922,SHOPKEY,0),U,3)
 I X]"",$D(^%ZIS(1,X,0)) S DEVICE=$P(^(0),U) S IOP=DEVICE,%ZIS="NQ" D ^%ZIS K IOP
 I WARD,DEVICE="" Q
 I DEVICE="" S %ZIS="NQ" D ^%ZIS S DEVICE=$S(POP:"",IO(0)=IO:"HOME",1:ION)
 I ION="NULL" D HOME^%ZIS S DEVICE=""
 Q
 ;
 ;ENWONEW2

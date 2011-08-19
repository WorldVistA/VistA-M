ENSA ;(WASH ISC)/DH-MedTester Interface ;1/11/2001
 ;;7.0;ENGINEERING;**14,21,68**;Aug 17, 1993
EN ;Upload test results from MedTester
 S ENSTA=$P($G(^DIC(6910,1,0)),U,2),ENSTAL=$L(ENSTA)
 I ENSTA="" W !!,"Can't seem to find your STATION NUMBER. Please check File 6910.",!,"Your IRM staff may need to assist you.",*7 G ERR^ENSA3
 F I=1,2,3,4,5,6,7,8 S ENSTA(I)="",ENSTAL(I)=0
 I $G(^DIC(6910,1,3,0))]"" D
 . S (I,ENX)=0 F  S ENX=$O(^DIC(6910,1,3,ENX)) Q:'ENX!(I>8)  D
 .. S I=I+1,ENSTA(I)=$P(^DIC(6910,1,3,ENX,0),U)
 .. S ENSTAL(I)=$L(ENSTA(I))
 D NOW^%DTC S ENTID=% S:'$D(DTIME) DTIME=600 D UPLD^ENSA1 G:POP EXIT
 G:'$D(ENTID) EXIT I '$D(^ENG("TMP",ENTID)) G EXIT
 S ENPMWO="",X="T",U="^",%DT="" D ^%DT S DT=+Y X ^DD("DD") S ENDATE=Y
MSG W @IOF,"MedTester UPLOAD MODULE:",!!,"Should data from the MedTester be used to close out work orders on a",!,"PM worklist" S %=1 D YN^DICN G:%<0 ERR^ENSA3 G:%=2 EN3 I %=0 D MSGXTD G MSG
 W !! S Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="For which month do you wish to record PMI's: ",%DT("B")=Y,%DT="AEPMX" D ^%DT G:Y'>0 ERR^ENSA3 S ENPMDT=$E(Y,2,5),ENPM="M"
MORW W !,"Are you recording a MONTHLY (as opposed to a WEEKLY) worklist" S %=1 D YN^DICN G:%<0 ERR^ENSA3 G:%=0 MORW I %=1 G EN1
WEEK R !,"Week number (enter an integer from 1 to 5): ",X:DTIME G:X="^" ERR^ENSA3 I X?1N,X>0,X<6 S ENPM="W"_X G EN1
 W "??",*7 G WEEK
EN1 S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC G:Y'>0 ERR^ENSA3 S ENSHKEY=+Y,ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1),ENSHABR=$P(^(0),U,2)
 S ENPMWO="PM-"_ENSHABR_ENPMDT_ENPM
EN2 S ENDEL="" I $D(^DIC(6910,1,0)) S ENDEL=$P(^(0),U,5)
 I ENDEL="" R !,"Should existing PM work orders be deleted after close out? YES// ",X:DTIME G:X="^" ERR^ENSA3 S:X=""!("Yy"[$E(X)) ENDEL="Y"
 I ENDEL="","Nn"'[$E(X) D COBH1^ENEQPMR4 G EN2
EN3 D MSG^ENSA6
 ;Physical processing of uploaded data
 I '$D(^ENG("TMP",ENTID)) W !!,*7,"No data to process." D HOLD G EXIT
PAPER W !,"Do you want a paper copy of test results (will be printed on same",!,"device as Exception Messages)" S %=2 D YN^DICN G:%<0 ERR^ENSA3 G:%<1 PAPER S ENPAPER=$S(%=1:1,1:0)
 K IO("Q") W ! S %ZIS="MQ",%ZIS("A")="Select Device for EXCEPTION MESSAGES: " D ^%ZIS G:POP ERR^ENSA3
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="CONT^ENSA",ZTDESC="Upload from MedTester",ZTSAVE("EN*")="",ZTSAVE("DT")="" D ^%ZTLOAD K ZTSK D HOME^%ZIS G EXIT1^ENSA3
CONT D PROCS^ENSA1
 G EXIT
HOLD W !,"Press <RETURN> to continue..." R X:DTIME
 Q
MSGXTD ;Extended help text
 W !!,"If MedTester is being used in conjunction with a specific Preventive",!,"Maintenance worklist, you should answer 'YES' to this question. You will then"
 W !,"be asked to identify the worklist."
 W !!,"If you say 'NO' at this point, safety tests stored in the MedTester will be",!,"posted to the Equipment Histories without affecting a PM worklist in any",!,"way.",! D HOLD
 Q
EXIT ;
 G EXIT^ENSA3
 ;ENSA

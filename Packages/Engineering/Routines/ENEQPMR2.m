ENEQPMR2 ;(WASH ISC)/JED/DH-Rapid PMI Close Out ;1/4/2001
 ;;7.0;ENGINEERING;**35,42,67**;Aug 17, 1993
RCO ;  Close out using defaults
 N PMTOT,PMTECH
RCOA S Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="Select Worklist Month: ",%DT("B")=Y,%DT="AEPMX" D ^%DT K %DT G:Y'>0 EXIT
 I $E(Y,4,5)="00" W !,"Date of worklist must contain a month.",*7 G RCOA
 S ENPMYR=$E(Y)+17,ENPMDT=$E(Y,2,5),ENPMMN=+$E(Y,4,5)
 S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC G:Y'>0 EXIT S ENSHKEY=+Y,ENSHOP=$P(^DIC(6922,ENSHKEY,0),U),ENSHABR=$P(^(0),U,2)
 ;
RCO1 R !,"MONTHLY or WEEKLY PM List: MONTHLY// ",X:DTIME G:X="^" EXIT S ENPM=$S(X="":"M",$E(X)="M":"M",$E(X)="W":"W",1:"") G:ENPM="M" RCO15 I ENPM']"" D RCOH1 G RCO1
RCO11 R !,"Which week? ",X:DTIME G:X="^" EXIT I X<1!(X>5) W !,"Enter a number, 1 to 5." G RCO11
 S ENPMWK=X,ENPM=ENPM_ENPMWK
RCO15 S Y=(ENPMYR-17)_ENPMDT_"00" X ^DD("DD") S %DT("B")=Y
 W !!,"COMPLETION DATE (future dates will not be accepted). MONTH and YEAR are"
 S %DT("A")="required, DAY is optional: ",%DT="AEP",%DT(0)="-NOW" D ^%DT K %DT G:Y'>0 EXIT
 I $E(Y,4,5)="00" W !!,"Completion date must contain a month.",*7 G RCO15
 S ENCDATE=Y X ^DD("DD") S ENCDATE("E")=Y
 ;
RCO2 S ENDEL="" I $D(^DIC(6910,1,0)) S ENDEL=$P(^(0),U,5)
 I ENDEL']"" R !!,"Should PM work orders be deleted after close out? YES//",X:DTIME G:X="^" EXIT S:X=""!($E(X)="Y")!($E(X)="y") ENDEL="Y" I ENDEL'="Y",$E(X)'="N",$E(X)'="n" D COBH1^ENEQPMR4 G RCO2
 ;
RCO3 S I=0,PMTECH(I)=""
 W ! K DIR S DIR("A")="Do you wish to substitute one technician for another",DIR("B")="NO",DIR(0)="Y"
 S DIR("?",1)="If all of the work assigned to TECHNICIAN A has actually been done by"
 S DIR("?",2)="TECHNICIAN B then you should enter 'YES' at this point and then 'Replace'"
 S DIR("?")="TECHNICIAN A 'With' TECHNICIAN B."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 I Y D  G:$D(DTOUT)!($D(DUOUT)) EXIT
 . W !!,"Work orders without a technician already assigned should be closed indivi-"
 . W !,"dually. You'll have a chance to do this before Rapid Close Out begins."
 . S DIC="^ENG(""EMP"",",DIC(0)="AEQM"
 . F  W ! K DIC("S") S DIC("A")="Replace: ",I=I+1 D ^DIC K DIC("A") Q:Y'>0  S PMTECH(I,0)=+Y,PMTECH(I,0,"E")=$P(Y,U,2) D  S:Y>0 PMTECH(I,1)=+Y,PMTECH(I,1,"E")=$P(Y,U,2) I Y'>0 K PMTECH(I) Q
 .. S DIC("A")="With: ",DIC("S")="I $P(^(0),U)'=PMTECH(I,0,""E"")" D ^DIC K DIC("A"),DIC("S")
 ;
RCO4 W !!,"This option will scan the ",$S(ENPM="M":"MONTHLY",ENPM["W":"WEEKLY",1:"")," PM Worklist of the ",ENSHOP," Shop",!,"for ",$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER","^",ENPMMN)
 W ", "_ENPMYR_$E(ENPMDT,1,2)_$S(ENPM["W":" (Week "_ENPMWK_")",1:"")_". It will automatically assign a PM Status of 'PASSED'"
 W !,"and a completion date of "_ENCDATE("E")," to each work order on the list,"
 W !,"except for those that you close out individually."
 W !!,"Default values for labor and material costs (if any) from the Equipment File",!,"will be posted to the Equipment History during Rapid Close Out."
 I $O(PMTECH(0)) D
 . W !!,"The PRIMARY TECHNICIANS will be changed as follows:" S I=0
 . F  S I=$O(PMTECH(I)) Q:I'>0  W !,?10,PMTECH(I,0,"E")_" will be changed to "_PMTECH(I,1,"E")
 W !!,"Are you sure you want to proceed " S %=2 D YN^DICN G:%=0 RCO4 G:%'=1 EXIT
 S (ENPMWO,ENPMWO("P"))="PM-"_ENSHABR_ENPMDT_ENPM_"-"
 L +^ENG("PMLIST",ENPMWO):1 I '$T W !!,"Another user is processing this worklist. Please try again later.",*7 G EXIT
 K ^ENG("TMP",ENPMWO) S J=""
 F  S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO=""!(ENPMWO'[ENPMWO("P"))  S DA=$O(^ENG(6920,"B",ENPMWO,0)) Q:DA'>0  I $P($G(^ENG(6920,DA,5)),U,2)="" S J=$P(^ENG(6920,DA,0),U) Q
 I J="" W !!,"There are no open work orders on this list. Nothing to process.",*7 G EXIT
 W !!,"Please enter any PM work orders (or the sequential portion thereof) that you",!,"wish to close out individually. Press <RETURN> to terminate the process."
 ;
RCO41 W !!,"Work order (ex: '",J,"' or just '",+$P(J,"-",3),"'): " R X:DTIME G:X=""!(X="^") RCO6^ENEQPMR3 I X="?" D RCOH4 G RCO41
 S:X?1.2N X=$S($L(X)=1:"00"_X,1:"0"_X) I X?.N S X=ENPMWO("P")_X
 S DIC="^ENG(6920,",DIC(0)="X",DIC("S")="I $P(^(0),U,1)[ENPMWO(""P"")" D ^DIC K DIC("S") I Y'>0 D RCOH4 G RCO41
 S DA=+Y I $P($G(^ENG(6920,DA,5)),U,2)]"" W ?40,"Already closed." G RCO41
 S ENPMWO=$P(^ENG(6920,DA,0),U),DIE="^ENG(6920,",DR=$S($D(^DIE("B","ENZPMCLOSE")):"[ENZPMCLOSE]",1:"[ENPMCLOSE]")
 D ^DIE S ^ENG("TMP",ENPMWO("P"),ENPMWO)=""
 I $D(DA),$P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="PM-" D
 . I $P(^ENG(6920,DA,5),U,8)="C" D REGLR^ENEQPMR1
 . D PMHRS^ENEQPMR4,PMINV^ENEQPMR4
 . I ENDEL="Y" S DIK="^ENG(6920," D ^DIK K DIK
 ;
RCO5 R !!,"Next work order (or sequential portion), <RETURN> to quit: ",X:DTIME G:X=""!(X="^") RCO6^ENEQPMR3 S:X?1.2N X=$S($L(X)=1:"00"_X,1:"0"_X)
 S ENPMWO=$S(X?3.N:ENPMWO("P")_X,1:X),X=ENPMWO,DIC="^ENG(6920,",DIC(0)="X",DIC("S")="I $P(^(0),U)[ENPMWO(""P"")" D ^DIC K DIC("S") I Y'>0 W "??" G RCO5
 S DA=+Y I $P($G(^ENG(6920,DA,5)),U,2)]"" W !,?30,ENPMWO_" is already closed." G RCO5
 D ^DIE S ^ENG("TMP",ENPMWO("P"),ENPMWO)=""
 I $D(DA),$P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="PM-" D
 . I $P(^ENG(6920,DA,5),U,8)="C" D REGLR^ENEQPMR1
 . D PMHRS^ENEQPMR4,PMINV^ENEQPMR4
 . I ENDEL="Y" S DIK="^ENG(6920," D ^DIK K DIK
 G RCO5
 ;
RCOH1 W !,"A MONTHLY PMI list contains work orders for ANNUAL, SEMI-ANNUAL, QUARTERLY,",!,"BI-MONTHLY, and MONTHLY preventive maintenance inspections."
 W !,"A WEEKLY PMI list is for WEEKLY and BI-WEEKLY inspections."
 Q
 ;
RCOH4 W !!,"Please enter an existing PM work order, or the sequential portion thereof.",!,"If there are no work orders to be closed out individually, enter <cr>.",!
 W !,"Would you like a list of existing work orders" S %=1 D YN^DICN Q:%'=1
 N J1 S J1=ENPMWO,ENY=1 F  S J1=$O(^ENG(6920,"B",J1)) Q:J1'[ENPMWO("P")!(J1="")  S DA=$O(^ENG(6920,"B",J1,0)) I DA>0,$P($G(^ENG(6920,DA,5)),U,2)="" D:IOSL-ENY<3 HOLD Q:X="^"  S ENY=ENY+1 W !,?5,J1
 Q
 ;
EXIT K EN,ENPMWO,ENPM,ENPMDT,ENPMYR,ENPMMN,ENPMWK,ENDATE,ENDEL,ENSHABR,ENSHOP
 K DIC,DIE,DIK,DA,DR,I,J,ENY,EN1
 Q
 ;
HOLD I $E(IOST,1,2)="C-" R !,"<cr> to continue, '^' to quit...",X:DTIME
 S ENY=1
 Q
 ;ENEQPMR2

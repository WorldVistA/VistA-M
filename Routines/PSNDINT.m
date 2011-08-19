PSNDINT ;BIR/DMA-ENTER/EDIT INTERACTIONS ;27 Aug 98 / 10:39 AM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
GO W !!
 S PSNDF=1
 S DIC=50.416,DIC(0)="AEMQZ",DIC("A")="Choose first ingredient ",DIC("S")="I '$P(^(0),""^"",2)" D ^DIC G OUT:Y<0 S PSN1=+Y,PSNN($P(Y(0),"^"))=""
 S DIC("A")="Choose second ingredient ",DIC("S")=DIC("S")_",+Y'=PSN1" D ^DIC G OUT:Y<0 S PSN2=+Y,PSNN($P(Y(0),"^"))=""
 S DA=$O(^PS(56,"AE",PSN1,PSN2,0)) I DA S PSN=^PS(56,DA,0),PSNL=$G(^("L")) D  G GO
 .I DA<15000,$P(PSN,"^",4)=1,'PSNL W !!,"That interaction is nationally entered and may not be edited." Q
 .S DIR(0)="Y",DIR("A")="That interaction already exists.  Do you wish to edit it" D ^DIR Q:'Y  K DIR S DIR(0)="56,3" D ^DIR Q:'Y  S DIE="^PS(56,",DR="3////"_Y_";6////1" D ^DIE Q
 S PSNNN=$O(PSNN(""))_"/"_$O(PSNN($O(PSNN(""))))
 K DA,DIR S DIR(0)="56,3" D ^DIR G OUT:$D(DTOUT)!$D(DUOUT) S PSN=Y
 W !,PSNNN,"   Severity : ",Y(0)
 S DIR(0)="Y",DIR("A")="OK to add " D ^DIR G OUT:$D(DTOUT)!$D(DUOUT) I 'Y K PSNN,PSNNN G GO
 F  L +^PS(56):3 Q:$T
 S DINUM=$O(^PS(56," "),-1)+1 I DINUM<15000 S DINUM=15000
 S DIC("DR")="1////"_PSN1_";2////"_PSN2_";3////"_PSN_";6////1",DIC="^PS(56,",DIC(0)="L",X=PSNNN K DD,DO D FILE^DICN L -^PS(56)
 K PSN,PSN1,PSN2,PSNN,PSNNN G GO
 ;
OUT K PSN,PSN1,PSN2,PSNDF,PSNL,PSNN,PSNNN,DA,DIC,DIR,DIRUT,DR,X,Y Q

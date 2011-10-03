ECXWRDX ;ALB/MRY - Assign DSS Dept. to Ward ;Mar 2, 2010
 ;;3.0;DSS EXTRACTS;**8,127**;Dec 22, 1997;Build 36
 ;
EN ;entry point from menu option
 ;lookup ward
 N DIC,DIR,DTOUT,DUOUT,DIRUT,X,Y,DSSID,OUT,JJ,DA,DR,DIE,SS,DIQ
 S DIC(0)="AEMQZ",DIC="^DIC(42," D ^DIC G:$D(DTOUT)!($D(DUOUT))!(+Y<1) EXIT
 S ECXWARD=+Y,DSSID=""
 S DR=".01;.02;.03;.015;.017",DIQ(0)="IE",DIQ="ECX",DA=ECXWARD,DIC="^DIC(42," K ECX D EN^DIQ1
 S ECXWARD=ECXWARD_U_$G(ECX(42,+ECXWARD,.01,"E"))
 W !!,"Ward: ",?18,$P(ECXWARD,U,2)
 S ECXDIV=$G(ECX(42,+ECXWARD,.015,"I"))
 I +ECXDIV>0 D
 .S ECXDIV=ECXDIV_U_ECX(42,+ECXWARD,.015,"E")_"/"_$P(^DG(40.8,+ECXDIV,0),U,2)
 W !,"Ward Bedsection: ",?18,$G(ECX(42,+ECXWARD,.02,"E"))
 W !,"Ward Specialty: ",?18,$G(ECX(42,+ECXWARD,.017,"E"))
 W !,"Ward Service: ",?18,$G(ECX(42,+ECXWARD,.03,"E"))
 I +ECXDIV>0 W !,"Division: ",?18,$P(ECXDIV,U,2)
 ;dss id for division is needed to derive dss dept code
 I ECXDIV="" D  G EN
 .W !!,"Cannot proceed with assignment of DSS Department code for ward,"
 .W !,"because the ward is not associated with a Medical Center Division."
 .W !
 .I $E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR W !
 I '$D(^ECX(727.4,+ECXWARD)) D
 .S (X,DINUM)=+ECXWARD,DIC(0)="L",DLAYGO=727.4,DIC="^ECX(727.4,"
 .K DD,DO D FILE^DICN K DIC,DINUM,DLAYGO,X,Y
 S DIR(0)="727.4,1",DIR("A")="DSS Department for Ward" K X,Y
 W !! D ^DIR K DIR Q:$D(DIRUT)
 S ECXDEPT=Y
 S DA=+ECXWARD,DIE="^ECX(727.4,",DR="1///"_ECXDEPT W !! D ^DIE
 K X,Y
 Q
EXIT ;common exit point
 K ECX,ECXWARD,ECXDEPT,ECXSVC,ECXDIV
 Q

ENEQPMP1 ;(WIRMFO)/DH/SAB-Maintain PMI Parameters ;7.29.97
 ;;7.0;ENGINEERING;**35,43**;Aug 17, 1993
PMSD ;  Display device PM schedule
 N DIC,DIE,DA,DR,X,I,J,I1,TAG,K
 W @IOF,!! S DIC(0)="AEQM",(DIC,DIE)="^ENG(6914," D ^DIC G:Y'>0 EXIT S DA=+Y D DINV^ENEQPMP3 G:'$D(ENXP) PMSD G EXIT
 ;
DTD ;  Display Equipment Category PM data
 N DIC,DIE,DA,DR,X,I,J,I1,TAG,K
 S DIC(0)="AEQM" D DTL G:ENDTYP'>0 EXIT D DDT^ENEQPMP3 W @IOF
 Q
 ;
DTE ;  Edit Equipment Category PM data
 I '$D(^XUSEC("ENEDPM")) W !!,"Sorry, you need Security Key 'ENEDPM'." D HLD G EXIT
 N DIC,DIE,DA,DR,I,J,X,I1,TAG,K
 S DIC(0)="AEQML",DLAYGO=6911 D DTL K DLAYGO G:ENDTYP'>0 EXIT
 L +^ENG(6911,ENDTYP):1 I '$T W !!,*7,"Someone else is editing this record." G EXIT
 S DA=ENDTYP,DR="[ENEQPMP]"
DTE1 D DDT^ENEQPMP3,^DIE
 L -^ENG(6911,ENDTYP)
 G:'$D(DA) DTE
DTE2 W !,"Are you finished with this Equipment Category" S %=1 D YN^DICN G:%=2 DTE1 G:%<0 DTE I %=0 W !,"Please enter 'YES' or 'NO'." G DTE2
 S ENDVTYP=$P($G(^ENG(6911,ENDTYP,0)),U)
DTE3 I $O(^ENG(6911,ENDTYP,4,0)) W !,"Do you wish to assign this PM schedule to ALL existing equipment records",!,"in the category of "_ENDVTYP
 E  W !,"Do you want to delete existing PM schedules (if any) from equipment records",!,"in the category of "_ENDVTYP
 S %=2 D YN^DICN S TAG=$S(%=1:"DTE5",%=2:"DTE",1:"DTE4") G @TAG
DTE4 D DTEH G DTE3
DTE5 W !,"Do you wish to confirm each transaction" S %=2 D YN^DICN G:%<1 DTEH1 S ENCONF=$S(%=1:1,1:0)
 F DA=0:0 S DA=$O(^ENG(6914,"G",ENDTYP,DA)) Q:DA'>0  W !,DA W:$D(^ENG(6914,DA,3)) ?10,$P(^(3),U,6) D DTE51
 D HLD G DTE
DTE51 I 'ENCONF D PMSE3^ENEQPMP Q
 W "  OK" S %=1 D YN^DICN D:%=1 PMSE3^ENEQPMP
 Q
 ;
DTL W @IOF,!! S (DIC,DIE)="^ENG(6911," D ^DIC S ENDTYP=+Y
 Q
 ;
DTEH W !!,"'YES' will cause the system to immediately find every equipment record of",!,"type "_ENDVTYP_" and assign each of them the PM schedule just entered."
 W !,"The ENTRY NUMBER of each affected equipment record will be displayed at",!,"your terminal, but you will not be asked to confirm the transaction unless",!,"you say that you want to."
 W !,"Once this process has begun, it should not be interrupted."
 Q
DTEH1 W !!,"You should enter 'YES' if you want to apply the revised schedule to some",!,ENDVTYP,"'s but not others."
 W !,"Enter 'NO' if you want the revised schedule applied to all equipment of",!,"type ",ENDVTYP,"."
 G DTE5
SKPCK ;SKP MNTHS = ENA ;Called by FileMan Input X-form
 S ENA=X,ENB=$P(ENA,"-",2),ENA=$P(ENA,"-",1)
 I ENA'="JUN",ENA'="SEP",ENA'="MAY",ENA'="OCT",ENA'="APR",ENA'="AUG",ENA'="JUL",ENA'="NOV",ENA'="MAR",ENA'="DEC",ENA'="FEB",ENA'="JAN" S ENA="ERR"
 I ENB'="JUN",ENB'="SEP",ENB'="MAY",ENB'="OCT",ENB'="APR",ENB'="AUG",ENB'="JUL",ENB'="NOV",ENB'="MAR",ENB'="DEC",ENB'="FEB",ENB'="JAN" S ENA="ERR"
 I ENA="ERR"!(ENB="ERR") D EN^DDIOL("You seem to have an invalid entry for 'SKIP MONTHS'. Valid abbreviations are") D EN^DDIOL("JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV, and DEC. Please re-edit.")
 Q
HLD I $E(IOST,1,2)="C-" R !,"Press <RETURN> to continue...",X:DTIME
 Q
EXIT K ENDTYP,ENDVTYP,ENA,ENB,ENCRIT,ENXP,ENC,ENCONF,ENX
 Q
 ;
RT ;Reassign a Technicians PMI Responsibilities
 ;
RTASK ; ask user
 W !
 S DIC=6929,DIC(0)="AQEM",DIC("A")="Replace this TECHNICIAN: "
 D ^DIC K DIC G:Y'>0 RTEX S ENTEC("O")=+Y,ENTECN("O")=$P(Y,U,2)
 ;
 S DIC=6929,DIC(0)="AQEM",DIC("A")="With this TECHNICIAN: "
 D ^DIC K DIC G:Y'>0 RTEX S ENTEC("N")=+Y,ENTECN("N")=$P(Y,U,2)
 ;
 S DIR(0)="S^0:ONE RESPONSIBLE SHOP;1:ALL RESPONSIBLE SHOPS"
 S DIR("A")="For PM schedules by",DIR("B")="ALL"
 D ^DIR K DIR G:$D(DIRUT) RTEX S ENSHKEY("ALL")=Y
 ;
 I 'ENSHKEY("ALL") D  I ENSHKEY'>0 G RTEX
 . S DIC=6922,DIC(0)="AQEM" D ^DIC K DIC S ENSHKEY=+Y,ENSHOP=$P(Y,U,2)
 ;
 S DIR(0)="Y",DIR("A")="Do you want to individually edit each entry"
 S DIR("B")="NO"
 S DIR("?",1)="If YES is entered here, the system will pause after each entry"
 S DIR("?",2)="for which TECHNICIAN "_ENTECN("O")_" has been changed"
 S DIR("?",3)="and allow you to edit the TECHNICIAN field."
 S DIR("?",4)=" "
 S DIR("?")="Enter YES or NO"
 D ^DIR K DIR G:$D(DTOUT) RTEX S ENEDTEC=Y
 ;
 W !!,"All occurrences of TECHNICIAN in both the EQUIPMENT CATEGORY and"
 W !,"EQUIPMENT INV. preventive maintenance schedules will be changed"
 W !,"from ",ENTECN("O")," to ",ENTECN("N"),"."
 W !,"This change will be made for "
 I ENSHKEY("ALL") W "the PM schedules of ALL responsible shops."
 E  W "only the PM schedules of the ",ENSHOP," shop."
 I ENEDTEC W !,"You will be able to individually edit the TECHNICAN."
 W ! S DIR(0)="Y",DIR("A")="OK to Proceed"
 D ^DIR K DIR G:'Y!$D(DIRUT) RTEX
 ;
RTDO S END=0
 W !!,"Updating EQUIPMENT CATEGORY file"
 I ENEDTEC S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S END=1 G RTEX
 S (ENC,ENT)=0
 S ENDA=0 F  S ENDA=$O(^ENG(6911,ENDA)) Q:'ENDA  D  Q:END
 . S ENI=0 F  S ENI=$O(^ENG(6911,ENDA,4,ENI)) Q:'ENI  D  Q:END
 . . S ENT=ENT+1
 . . I 'ENEDTEC W:'(ENT#50) "."
 . . S ENY=$G(^ENG(6911,ENDA,4,ENI,0))
 . . S ENRS=$P(ENY,U)
 . . I 'ENSHKEY("ALL"),ENRS'=ENSHKEY Q
 . . I $P(ENY,U,2)'=ENTEC("O") Q
 . . ;W !,"  ENDA: ",ENDA,?12,"ENI: ",ENI,?20,ENY
 . . S $P(^ENG(6911,ENDA,4,ENI,0),U,2)=ENTEC("N")
 . . S ENC=ENC+1
 . . I ENEDTEC D
 . . . S ENDTYP=ENDA,ENNOHLD=1 D DDT^ENEQPMP3
 . . . W !!,"For the ",$P($G(^DIC(6922,ENRS,0)),U)," SHOP PM Schedule:"
 . . . S DIE="^ENG(6911,"_ENDA_",4,",DA(1)=ENDA,DA=ENI,DR="1"
 . . . D ^DIE K DA S:$D(Y) END=1
 W !,"  ",ENC,$S(ENC=1:" entry was",1:" entries were")," changed."
 G:END RTEX
 ;
 W !!,"Updating EQUIPMENT INV. file"
 I ENEDTEC S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S END=1 G RTEX
 S (ENC,ENT)=0
 I 'ENSHKEY("ALL") S ENRS=ENSHKEY D RTSHOP
 I ENSHKEY("ALL") S ENRS=0 F  S ENRS=$O(^ENG(6914,"AB",ENRS)) Q:'ENRS  D RTSHOP Q:END
 W !,"  ",ENC,$S(ENC=1:" entry was",1:" entries were")," changed."
 ;
RTEX ; reassign tech exit
 K DA,DIC,DIE,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 K ENC,END,ENDA,ENDTYP,ENDVTYP,ENEDTEC,ENI,ENNOHLD,ENRS
 K ENSHKEY,ENSHOP,ENT,ENTEC,ENTECN,ENX,ENY
 Q
 ;
RTSHOP ; update all entries for responsible shop ENRS
 S ENDA=0 F  S ENDA=$O(^ENG(6914,"AB",ENRS,ENDA)) Q:'ENDA  D  Q:END
 . S ENT=ENT+1
 . I 'ENEDTEC W:'(ENT#50) "."
 . S ENI=$O(^ENG(6914,"AB",ENRS,ENDA,0))
 . S ENY=$G(^ENG(6914,ENDA,4,ENI,0))
 . I $P(ENY,U,2)'=ENTEC("O") Q
 . ;W !,"  ENDA: ",ENDA,?12,"ENI: ",ENI,?20,ENY
 . S $P(^ENG(6914,ENDA,4,ENI,0),U,2)=ENTEC("N")
 . S ENC=ENC+1
 . I ENEDTEC D
 . . S DA=ENDA,ENNOHLD=1 D DINV^ENEQPMP3
 . . W !!,"For the ",$P($G(^DIC(6922,ENRS,0)),U)," SHOP PM Schedule:"
 . . S DIE="^ENG(6914,"_ENDA_",4,",DA(1)=ENDA,DA=ENI,DR="1"
 . . D ^DIE K DA S:$D(Y) END=1
 Q
 ;
 ;ENEQPMP1

ENEQNX5 ;(WASH ISC)/DH-Manual Update of Equipment Inventory ;9.26.97
 ;;7.0;ENGINEERING;**35,43**;Aug 17, 1993
EN ;Update NX Inventory (Single record mode)
DIC W @IOF,!! D GETEQ^ENUTL G:Y'>0 EXIT S DA=+Y
 I '$D(^ENG(6914,DA)) S ENMSG="RECORD NOT FOUND.",ENMSG(0,1)="Suspect database degrade." D XCPTN^ENEQNX1 G DIC
 S EN(2)=$S($D(^ENG(6914,DA,2)):^(2),1:""),EN(3)=$S($D(^(3)):^(3),1:"") S ENLOC=$P(EN(3),U,5),ENOLDLOC=$P(EN(3),U,8),ENINVDT=$P(EN(2),U,13) I ENINVDT]"" S Y=ENINVDT X ^DD("DD") S ENINVDT=Y
 I ENLOC=+ENLOC,$D(^ENG("SP",ENLOC,0)) S ENLOC=$P(^(0),U)
 W !!,"Entry Number: ",DA S ENPMN=$P(EN(3),U,6) I ENPMN]"" W ?30,"PM Number: ",ENPMN
 W !,?5,"Location: ",ENLOC,?30,"Previous location: ",ENOLDLOC
 W !,?5,"Last inventoried: ",ENINVDT
CNFRM W !!,"Do you wish to update this record" S %=1 D YN^DICN G:%=0 CNFRM G:%'=1 DIC
 S DIE="^ENG(6914,",DR="24;23///^S X=""T""" D ^DIE
 G DIC
 ;
UPDT(DA,ENDT,ENLOC) ;  Update PHYSICAL INVENTORY DATE
 ;
 ;  DA => IEN to Equipment File (not returned)
 ;  ENDT => Date (internal format)
 ;  ENLOC => Location from Work Order (internal format)
 ;  Called by work order routines, mainly PM close-out
 ;
 Q:DA']""  Q:'$D(^ENG(6914,DA,0))
 N CURNT,DIE,DR
 S CURNT=$P($G(^ENG(6914,DA,2)),U,13)
 S DIE="^ENG(6914,"
 I ENDT>CURNT D
 . S DR="23///^S X=ENDT" D ^DIE
 . I ENLOC]"",$D(^ENG("SP",ENLOC,0)),ENLOC'=$P($G(^ENG(6914,DA,3)),U,5) S DR="24////^S X=ENLOC" D ^DIE
 K DA
 Q
 ;
EXIT K EN,ENLOC,ENOLDLOC,ENINVDT,DA,ENPMN
 Q
 ;ENEQNX5

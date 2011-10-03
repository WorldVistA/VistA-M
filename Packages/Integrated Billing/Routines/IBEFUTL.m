IBEFUTL ;ALB/AAS - INTEGRATED BILLING - FILER UTILITIES ; 26-FEB-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
START ;  -turn IB filer on, task manually
 ;***
 ;S XRTL=$ZU(0),XRTN="START^IBEFUTL-1" D T0^%ZOSV ;start rt clock
 ;
 W !!,"This option will start the IB Background Filer running.  If one filer"
 W !,"is currently running a second filer will be started.  Manually starting"
 W !,"the filer with this option is not ordinarily necessary, as it will start"
 W !,"itself when needed.  However, if the Filer job should be killed or"
 W !,"your system goes down with the filer running, you may need to use this"
 W !,"option."
 ;
 I '$D(^IBE(350.9,1,0)) W !!,"You must enter/edit site parameters first" G STARTQ
 I $P(^IBE(350.9,1,0),"^",4)]"" W !!,*7,"<<<<WARNING!!!  ","Filer appears to have been started on " S Y=$P(^(0),"^",4) D DT^DIQ W ">>>>"
 ;
 W !! S DIR("A")="Are you sure",DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR I 'Y W !!,"Nothing queued!" G STARTQ
 ;
S1 N Y S DIE="^IBE(350.9,",DA=1,DR=".03////1;.04///@" D ^DIE K DIE,DA,DR
 D ZTSK^IBEF
STARTQ K %H,D,DIC,X,Y,ZTSK
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="START^IBEFUTL" D T1^%ZOSV ;stop rt clock
 Q
 ;
STOP ;  -stop IB filer
 ;***
 ;S XRTL=$ZU(0),XRTN="STOP^IBEFUTL-1" D T0^%ZOSV ;start rt clock
 ;
 W !,"This option will edit the IB site parameter file and allow for the"
 W !,"graceful shutdown of the IB Background filer.  Use of this option"
 W !,"will cause the IB Engine to file in the foreground until the site"
 W !,"parameter FILE IN BACKGROUND is edited to yes."
 W !!,"After using this option the filer may attempt to complete filing"
 W !,"posted transactions prior to stopping.  This option should be used"
 W !,"prior to stopping taskmanager when doing an orderly system shutdown."
 W !!,"REMEMBER: If you use this option, you must edit the site parameter"
 W !,"FILE IN BACKGROUND to yes to allow the filer to restart, or use the"
 W !,"Start IB filer option."
 ;
 W !! S DIR("A")="Are you sure",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR I 'Y W !!,"Nothing stopped!" G STOPQ
 S DIE="^IBE(350.9,",DA=1,DR=".03////0" D ^DIE K DA,DIE,DR,DIC
 W !,"IB Background Filing stopped"
 ;
STOPQ K %H,D,X
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="STOP^IBEFUTL" D T1^%ZOSV ;stop rt clock
 Q
 ;
EDIT ;  -edit IB site parameters
 ;***
 ;S XRTL=$ZU(0),XRTN="EDIT^IBEFUTL-1" D T0^%ZOSV ;start rt clock
 ;
 I '$D(^IBE(350.9,1,0)) K DD,DO S DIC="^IBE(350.9,",DIC(0)="L",(X,DINUM)=1 D FILE^DICN K DIC,DD,DO W !!,*7,"Creating Site Parameter Entry!  You may now Edit"
 ;
 I '$D(^IBE(350.9,1,0)) W !!,*7,"<<<WARNING:  There appears to be a problem in the parameter file.>>>" G EDITQ
 ;
 L +^IBE(350.9,1,0):0 I '$T W !,"Site Parameteres being edited by another user!" G EDITQ
 ;
 S DA=1,DR="[IB EDIT SITE PARAM]",DIE="^IBE(350.9," D ^DIE
 L -^IBE(350.9,1,0)
 ;
EDITQ K %H,DA,DR,DIE,DIC,X,Y
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EDIT^IBEFUTL" D T1^%ZOSV ;stop rt clock
 Q
 ;
CLEAR ;  - clear the start date and tasked flags from file 350.9
 ;***
 ;S XRTL=$ZU(0),XRTN="CLEAR^IBEFUTL-1" D T0^%ZOSV ;start rt clock
 ;
 S DA=1,DIE="^IBE(350.9,",DR="[IB EDIT CLEAR]" D ^DIE K DA,DIE,DR,DIC
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="CLEAR^IBEFUTL" D T1^%ZOSV ;stop rt clock
 Q

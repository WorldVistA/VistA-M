SROPRE ;B'HAM ISC/MAM - PRE-INIT FOR VERSION 3 ; 16 JAN 1990  9:20 AM
 ;;3.0; Surgery ;**9**;24 Jun 93
 W !!!,"SURGERY VERSION 3.0",!
 S SRINST=$O(^SRO(133,0)) I 'SRINST D NEW Q
 S Z=$P($G(^SRO(133,SRINST,0)),"^",3) Q:Z["3.0"  K SRINST
 W !!,"The pre-initialization routine will delete the display graphs stored in",!,"the ^SRS global for all dates up to two weeks prior to today.  The option",!,"SRTASK-SCRAP has been modified to clean up this global on "
 W "a regular basis.",!! D ^SROPRE0
 S X="T-14" D ^%DT S EDATE=Y S SROR=0 F  S SROR=$O(^SRS(SROR)) Q:'SROR  S SRSDATE=0 F  S SRSDATE=$O(^SRS(SROR,"SS",SRSDATE)) Q:SRSDATE>EDATE!('SRSDATE)  D OR
 W !!,"Updating existing schedule graphs to new 24 hour format..."
UP S SROR=0 F  S SROR=$O(^SRS(SROR)) Q:'SROR  S SRSDATE=0 F  S SRSDATE=$O(^SRS(SROR,"SS",SRSDATE)) Q:'SRSDATE  D GRAPH
 D MORE W !!!
 Q
NEW W !!,"Prior to using the Surgery package, an entry must be made in the Surgery",!,"Site Parameters file.  Please enter the name of the institution that will",!,"appear on all of your Surgery Reports.",!!
 K DIC S DIC=4,DIC(0)="QEAMZ",DIC("A")="Enter Institution for Surgery Site Parameters: " D ^DIC K DIC S:Y>0 SRINST=+Y
 Q
OR ; kill "S" and "SS" nodes
 K ^SRS(SROR,"S",SRSDATE),^SRS(SROR,"SS",SRSDATE)
 Q
MORE W !!!,"The pre-initialization routine will delete the data dictionary for the",!,"SURGERY WAITING LIST file.  The SRINITs will re-create the DDs later.  The",!,"entries in this file will NOT be deleted.  The pre-initialization "
 W "routine",!,"will also delete the option 'Complications of Surgical Procedures' from",!,"your OPTION file.  The functionality of this option has been moved into",!,"the 'Morbidity and Mortality Reports' option."
 W !!,"Three other options that will be deleted from your OPTION file are",!,"'Calculate Average Operation Times', 'Lock Surgery Cases', and 'Delete"
 W !,"Outstanding Requests'.  The functionality of these three options has",!,"been moved into 'Surgery Nightly Cleanup and Updates' which will need",!,"to be tasked to run each night.",!!!
DD ; delete DDs for file 133.8
 W !,"Deleting data dictionaries for the SURGERY WAITING LIST file..."
 S DIU="^SRO(133.8,",DIU(0)="" D EN^DIU2
OPT ; delete the option 'Complication of Surgical Procedures'
 I $O(^DIC(19,"B","SROCMP",0)) K DA W !!,"Deleting 'Complication of Surgical Procedures' option..." S (DA,SROPT)=$O(^DIC(19,"B","SROCMP",0)) I DA>0 D CLEAN K DIK,DA S DA=SROPT,DIK="^DIC(19," D ^DIK
TASK ; delete obsolete tasked options
 I $O(^DIC(19,"B","SRTASK-OP TIMES",0)) K DA W !!,"Deleting 'Calculate Average Operation Times' option..." S DA=$O(^DIC(19,"B","SRTASK-OP TIMES",0)) I DA>0 K DIK S DIK="^DIC(19," D ^DIK
 I $O(^DIC(19,"B","SRTASK-LOCK",0)) K DA W !!,"Deleting 'Lock Surgery Cases' option..." S DA=$O(^DIC(19,"B","SRTASK-LOCK",0)) I DA>0 K DIK S DIK="^DIC(19," D ^DIK
 I $O(^DIC(19,"B","SRTASK-SCRAP",0)) K DA W !!,"Deleting 'Delete Outstanding Requests' option..." S DA=$O(^DIC(19,"B","SRTASK-SCRAP",0)) I DA>0 K DIK S DIK="^DIC(19," D ^DIK
 K DIK,DA
 Q
GRAPH ; update graph to 24 hour format
 I $D(^SRS(SROR,"S",SRSDATE,1)),$L(^(1))<90 S MM=^(1),X=$E(MM,1,10)_"|____|____|____|____|____|____|____"_$E(MM,11,99)_"____|____|____|",^SRS(SROR,"S",SRSDATE,1)=X
 I $D(^SRS(SROR,"SS",SRSDATE,1)),$L(^(1))<90 S MM=^(1),X=$E(MM,1,10)_"|____|____|____|____|____|____|____"_$E(MM,11,99)_"____|____|____|",^SRS(SROR,"SS",SRSDATE,1)=X
 Q
CLEAN ; remove option from any menu
 S SRM=0 F  S SRM=$O(^DIC(19,"AD",SROPT,SRM)) Q:'SRM  K DA,DIK S DA(1)=SRM,DA=$O(^DIC(19,"AD",SROPT,SRM,0)),DIK="^DIC(19,"_DA(1)_",10," D ^DIK
 Q
OPT1 ; Entry point for SR*3*9 if Surgery v3 already installed
 K DA,DIK S DA=$O(^DIC(19,"B","SROCMP",0)) I DA>0 W !,"Deleting 'Complication of Surgical Procedures' option..." S DIK="^DIC(19," D ^DIK K DA,DIK
XUHALT G:$D(^DIC(19,1,0)) FINE G:$O(^DIC(19,"B","XUHALT",0)) FINE
 K DIC S X="XUHALT",DIC="^DIC(19,",DIC(0)="L",DLAYGO=19,DINUM=1 D FILE^DICN K DIC,DINUM,DLAYGO I Y<0 G FINE
 W !,"Re-adding option XUHALT..."
 S SROPT=+Y,SRHELP=$O(^DIC(9.2,"B","XUHALT",0))
 S SRACT="S:'$D(XQCH) XQCH=""HALT"" G:$L(XQCH)>2 HALT^XQ12 S XQUR=""HALT"" G XPRMP^XQ12"
 K DIE,DA,DR S DIE=19,DA=SROPT,DR="1////Halt;4////A;20////"_SRACT_";3.6////.5;3.7////"_SRHELP D ^DIE K DA,DIE,DR
 S SRDES(1,0)="^^2^11^",SRDES(1,0,0,99999999)="^10^11^99999999",SRDES(1,0,"W")=75,SRDES(10,0)="^19.01IP^0^0",SRDES(99)="52902,63309",SRDES(99.1)="55438,42614"
 S SRDES(1,10,0)="This is the command which is used to terminate processing in the Menu",SRDES(1,11,0)="Manager."
 S %X="SRDES(",%Y="^DIC(19,SROPT," D %XY^%RCR
FINE K SRACT,SRDES,SRHELP,SROPT W !,"Finished."
 Q

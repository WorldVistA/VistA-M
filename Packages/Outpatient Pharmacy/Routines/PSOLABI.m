PSOLABI ;BHAM ISC/JMB ; ADD PSO LAB MONITOR OPTION ; 5/6/94
 ;;6.0;OUTPATIENT PHARMACY;**100,118**;APRIL 1993
CHK W @IOF I $G(^DD(52,0,"VR"))'="6.0" W !!,*7,"Version 6.0 must be installed before running this routine." G EX
 W !!,"Installing PSO LAB MONITOR option and adding it to the PSO SUPERVISOR MENU.",!
 S DA=$O(^DIC(19,"B","PSO LAB MONITOR",0)) G:'DA OPTION
 W !,*7,*7,"The PSO LAB MONITOR option has already been installed." G MENU
 W !,*7,*7,"*** Another 'PSO LAB MONITOR' option already exist on your system.",!,"    You must rename the existing option then rerun this routine before",!,"    the lab on action profile option can be installed." G EX
OPTION S DIC="^DIC(19,",DIC(0)="MZ",X="PSO LAB MONITOR",DIC("DR")="1///Mark/Unmark Lab Monitor Drugs;4///R;25///EDIT^PSOLAB;1.1///MARK/UNMARK LAB MONITOR DRUGS"
 K DD,DO D FILE^DICN K DIC
 S DA=+Y,^DIC(19,DA,1,0)="^^3^3^2931203^^^^",^DIC(19,DA,1,1,0)="This option selects a drug that will print the most recent lab value on"
 S ^DIC(19,DA,1,2,0)="the Action/Information Profile. The lab test, specimen type, and number",^DIC(19,DA,1,3,0)="of days back to search for lab data are entered."
 W !,"Option installed!"
MENU S DA(1)=$O(^DIC(19,"B","PSO SUPERVISOR",0))
 I 'DA(1) W !!,*7,*7,"*** The PSO LAB MONITOR option has not been added to the PSO SUPERVISOR menu",!,"    because the PSO SUPERVISOR menu does not exist on your system. Install"
 I  W !,"    the PSO SUPERVISOR menu then rerun this routine again." G EX
 S THERE=$O(^DIC(19,DA(1),10,"B",DA,0))
 I THERE W !,*7,*7,"The PSO LAB MONITOR option has already been added to the PSO SUPERVISOR menu.",!!,"Finished!",! G EX
 S X=DA,DIC="^DIC(19,"_DA(1)_",10,",DIC(0)="MZ" S:'$D(^DIC(19,DA(1),10,0)) ^DIC(19,DA(1),10,0)="^19.01IP^^" K DD,DO D FILE^DICN K DIC
 W !,"Option added to PSO SUPERVISOR menu!"
EX K DA,THERE,X,Y Q

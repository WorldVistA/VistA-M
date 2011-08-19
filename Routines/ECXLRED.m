ECXLRED ;ALB/TMD - Add/Edit Lab Results Translation Values ; 8/1/02 10:27am
 ;;3.0;DSS EXTRACTS;**46**;Dec 22, 1997
 ;
EN ; Entry point
 N X,Y,DA,DR,DIC,DIE,DLAYGO
 W @IOF
 W "ADD/EDIT LAB RESULTS TRANSLATION TABLE",!!!
 I '$O(^ECX(727.7,0)) W "Lab Results Translation file does not exist",!! R X:5 K X Q
 W "This option allows the editing of existing entries or the addition of new"
 W !,"entries in the LAB RESULTS TRANSLATION file (#727.7).  Free text results"
 W !,"(non-numeric) are stored in this file with their corresponding translation codes",!!
 S QFLG=0 F  Q:QFLG  D
 .S DIC=727.7,DIC(0)="AELNV",DIC("DR")=".01;1",DLAYGO=727.7 D ^DIC I Y<0!$D(DUOUT) S QFLG=1 Q
 .I '$P(Y,U,3) S DIE=DIC,DA=+Y,DR=".01;1" D ^DIE
 Q

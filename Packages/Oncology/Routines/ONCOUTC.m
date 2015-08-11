ONCOUTC ;Hines OIFO/GWB - [UTL *..Utility Options DS, DP, SQ and EA] ;03/17/11
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
 ;
INQ ;[PI Patient/Primary Inquiry]
 ;OUT OF ORDER MESSAGE: Marked for deletion
 D PAT G EX:Y<0
 I $$PFTD^ONCFUNC(ONCOD0)="N" D  G INQ
 .W !!?5,ONCONM," has no primaries for division: ",$$GET1^DIQ(4,DUZ(2),99)
 D SDD^ONCOCOM G INQ
 ;
DUMP ;[RD Print Oncology Patient Record]
 ;OUT OF ORDER MESSAGE: Marked for deletion
 ;W !,?5,"This option will display the entire Oncology Record from"
 ;W !?5,"both the ONCOLOGY PATIENT and the ONCOLOGY PRIMARY files",!!
SEL ;S DIC(0)="AEQZ",DIC="^ONCO(160," D ^DIC G EX:Y<0 S ONCODA=+Y
 ;S %ZIS="Q" W !! D ^%ZIS I POP S ONCOUT="" G EX
 ;I '$D(IO("Q")) D DIQ W !!! G SEL
 ;S ZTRTN="DIQ^ONCOUTC",ZTSAVE("ONCODA")="",ZTSAVE("DUZ(2)")=""
 ;S ZTDESC="ONCOLOGY PATIENT RECORD"
 ;D ^%ZTLOAD
 ;K ZTDESC,ZTRTN,ZTSAVE
 ;D EX
 ;Q
 ;
EN2 ;[DP Delete Oncology Patient]
 D PAT G EX:Y<0
 I $D(^ONCO(165.5,"C",ONCOD0)) D SDD^ONCOCOM
 W !?5,"Deleting a patient will also delete any primaries associated"
 W !?5,"with your division."
 S DIR("A")="     Are you sure you want to delete this ONCOLOGY PATIENT"
 S DIR("B")="NO",DIR(0)="Y" W ! D ^DIR G EX:Y=U!(Y=""),EN2:'Y
 W !
 I $D(^ONCO(165.5,"C",ONCOD0)) S ONCOP0=0 F  S ONCOP0=$O(^ONCO(165.5,"C",ONCOD0,ONCOP0)) Q:ONCOP0'>0  I $$DIV^ONCFUNC(ONCOP0)=DUZ(2) D DP
 I $D(^ONCO(165.5,"C",ONCOD0)) D  G EN2
 .S ONCOP0=$O(^ONCO(165.5,"C",ONCOD0,0))
 .S ONCDIV=$P($G(^ONCO(165.5,ONCOP0,"DIV")),U,1)
 .W !?5,"Unable to delete ONCOLOGY PATIENT."
 .W !?5,"This patient has primaries which belong to division: ",ONCDIV,!
 S DA=ONCOD0,DIK="^ONCO(160,"
 W !!?5,"Deleting ONCOLOGY PATIENT..." D ^DIK G EN2
 ;
EN3 ;[DS Delete Primary Site/GP Record]
 D PAT G EX:Y<0
 S UTL="DELETE" D PRIM G EN3:Y<0
 S ONCOSIT=$P(Y,U,2),ONCOP0=+Y
 W !!?5,ONCONM,?35,$P(^ONCO(164.2,ONCOSIT,0),U),!!
 S DIR("A")=" Are you sure you want to delete this primary"
 S DIR("B")="NO",DIR(0)="Y" D ^DIR G EX:(Y="")!(Y=U),EN3:Y=0
 D DP G EN3
 ;
EN1 ;[EA Edit Site/AccSeq# Data]
 D PAT G EX:Y<0
SP S UTL="EDIT" D PRIM G:Y'>0 EN1 D DIE1
 S DIR("A")="Data OK",DIR("B")="Y",DIR(0)="Y"
 D ^DIR Q:Y=U!(Y="")  G:Y=0 SP G EN1
 ;
PRIM ;Select ONCOLOGY PRIMARY (165.5)
 I $$PFTD^ONCFUNC(ONCOD0)="N" D  S Y=-1 Q
 .W !!?5,ONCONM," has no primaries for division: ",$$GET1^DIQ(4,DUZ(2),99)
 S D0=ONCOD0 D SDD^ONCOCOM W !?5,"Select primary to ",UTL,!
 S D="C",DIC="^ONCO(165.5,",DIC(0)="EZ",X=ONCOD0 D IX^DIC Q:(Y<0)!(Y=U)
 Q
 ;
DIE1 ;Edit ONCOLOGY PRIMARY (165.5)
 S (D0,ONCODP0,DA)=+Y,DR="[ONCO UTL CORRECT DATA]",DIE="^ONCO(165.5,"
 S ONCOL=0
 L +^ONCO(165.5,ONCODP0):0 I $T D ^DIE L -^ONCO(165.5,ONCODP0) S ONCOL=1
 I 'ONCOL W !,"Record being edited by another user." D EX G PRIM
 S Y=0
 S ONCOD0P=D0
 S ABSTAT=$P($G(^ONCO(165.5,ONCOD0P,7)),U,2)
 I ABSTAT=3 S EAFLAG="YES" D CHANGE^ONCGENED
 D EX
 Q
 ;
PAT ;Select ONCOLOGY PATIENT (160)
 W ! S DIC="^ONCO(160,",DIC(0)="AEZM" D ^DIC K DIC Q:Y<0
 S (ONCOD0,D0)=+Y,ONCONM=Y(0,0)
 N Y K DIQ,ONC S DIC="^ONCO(160,",DR="2;3;8;10",DA=ONCOD0,DIQ="ONC"
 D EN^DIQ1 W !
 W !?2,"SSN..........: ",ONC(160,ONCOD0,2)
 W ?35,"Race.........: ",ONC(160,ONCOD0,8)
 W !?2,"Date of Birth: ",ONC(160,ONCOD0,3)
 W ?35,"Sex..........: ",ONC(160,ONCOD0,10)
 Q
 ;
DP ;Delete ONCOLOGY PRIMARY (165.5)
 W !?5,"Deleting ONCOLOGY PRIMARY: ",$$GET1^DIQ(165.5,ONCOP0,20)
 S DA=ONCOP0,DIK="^ONCO(165.5," D ^DIK S D0=ONCOD0 H 2 W !
 Q
 ;
DUPSQ ;[SQ Find Duplicate Acc/Seq numbers]
 K ONCPRLST S ONCTTLDP=0 W !
 S ONCACSQ="" F  S ONCACSQ=$O(^ONCO(165.5,"D",ONCACSQ)) Q:ONCACSQ=""  D
 .S ONCTTL=0,ONCDUPS=""
 .F ZZIEN=0:0 S ZZIEN=$O(^ONCO(165.5,"D",ONCACSQ,ZZIEN)) Q:ZZIEN'>0  D
 ..S ONCTTL=ONCTTL+1,ONCDUPS=ONCDUPS_ZZIEN_"^"
 ..I ONCTTL>1 D
 ...I '$D(ONCPRLST(ONCACSQ)) S ONCTTLDP=ONCTTLDP+1
 ...S ONCPRLST(ONCACSQ)=ONCDUPS
 I '$D(ONCPRLST) W !!?8,"No duplicate Accession/Sequence Numbers Found.",! K DIR S DIR(0)="E" D ^DIR Q
 W ! D HDR^ONCOCOML
 S ONCACSQ="" F  S ONCACSQ=$O(ONCPRLST(ONCACSQ)) Q:ONCACSQ=""  D  W !
 .F X=1:1:999 S ONCXD1=$P(ONCPRLST(ONCACSQ),U,X) Q:ONCXD1=""  D DIS2^ONCOCOML
 W !!?5,"A total of ",ONCTTLDP," Accession/Sequence numbers with duplicates found.",!?5,"You may use the EA 'Edit Site/AccSeq # Data' option to fix duplicates.",! K DIR S DIR(0)="E" D ^DIR Q
 K ONCPRLST,ONCTTLDP,ONCTTL,ONCACSQ,ONCDUPS,ZZIEN Q
 ;
EX ;Kill variables
 K %ZIS,ABSTAT,D,D0,DA,DIC,DIE,DIK,DIQ,DIR,DR,EAFLAG,ONC,ONCDIV
 K ONCOD0P,ONCODA,ONCODP0,ONCOL,ONCONM,ONCOP0,ONCOSIT,ONCOUT,POP,UTL,X,Y
 Q
 ;
CLEANUP ;Cleanup
 K ONCOD0

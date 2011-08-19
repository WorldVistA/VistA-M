ESPMNI2 ;DALISC/CKA - MASTER NAME EDIT;5/92
 ;;1.0;POLICE & SECURITY;**14**;Mar 31, 1994
EN ;
 D DT^DICRW
MNI S DIR(0)="PO^910:AEQMZ" D ^DIR K DIR
 G:Y'>0!$D(DIRUT) EXIT
 S ESPFN=+Y
FDISP ;Displays a master name input record- ESPFN must be defined
 ;Called from ESPMNI, ESPMNI1,
 ;Returns ESPFN
 G:'$D(^ESP(910,ESPFN,0)) EXIT
 S ESP0=^ESP(910,ESPFN,0),ESP1=$G(^(1)),ESP2=$G(^(2)),ESP3=$G(^(3))
 ;Initializing ESPD array to print record
 F I=1:1:11 S ESPD(I)=$P(ESP0,U,I)
 F I=12:1:17 S ESPD(I)=$P(ESP1,U,I-11)
 F I=18:1:23 S ESPD(I)=$P(ESP2,U,I-17)
 F I=24:1:29 S ESPD(I)=$P(ESP3,U,I-23)
 W !!,"1) Name: ",ESPD(1),?40,"2) Height: ",ESPD(24)
 W !?3,"SSN: ",ESPD(2),?43,"Weight: ",ESPD(25)
 W !?3,"DOB: " S Y=ESPD(3) D DD^%DT W Y,?43,"Hair Color: ",$S($G(^ESP(910.7,+ESPD(26),0))]"":$P(^(0),U),1:""),!?3,"SEX: ",ESPD(8)
 W ?43,"Eye Color: ",$S($G(^ESP(910.7,+ESPD(27),0))]"":$P(^(0),U),1:"")
 W !?3,"RACE: ",$S($G(^DIC(10,+ESPD(9),0))]"":$P(^(0),U),1:"")
 W ?43,"Skin Tone: ",$S($G(^ESP(910.7,+ESPD(28),0))]"":$P(^(0),U),1:"")
 W !?3,"Category: ",ESPD(4)
 W ?43,"Scars/Marks: "
 W !?3,"Driver's License #: ",ESPD(10),?43,$E(ESPD(29),1,35)
 W !?3,"State: ",$S($G(^DIC(5,+ESPD(11),0))]"":$P(^(0),U,1),1:"")
 W !,"3) Service: ",$S($G(^DIC(49,+ESPD(5),0))]"":$P(^(0),U,1),1:"")
 W !?3,"ID Badge: ",ESPD(7)
 D MORE G:$D(DTOUT) EXIT I 'Y G RD
 W !,"4) Place of Employment: ",?40,"5) Home Address: "
 W !?3,ESPD(6),?43,ESPD(12)
 W !?3,"Address: ",?43,"Home Address [Line 2]: "
 W !?3,ESPD(18),?43,ESPD(13)
 W !?3,"Address [Line 2]: ",?43,"City: ",ESPD(14)
 W !?3,ESPD(19),?43,"State: ",$S($G(^DIC(5,+ESPD(15),0))]"":$P(^(0),U),1:"")
 W !?3,"City: ",ESPD(20),?43,"Zip: ",ESPD(16)
 W !?3,"State: ",$S($G(^DIC(5,+ESPD(21),0))]"":$P(^(0),U),1:""),?43,"Home Phone: ",ESPD(17)
 W !?3,"Zip: ",ESPD(22)
 W !?3,"Office Phone: ",ESPD(23)
 D MORE G:$D(DTOUT) EXIT I 'Y G RD
 ;Print Aliases
 W !,"6) " S ESPAKA=0 W:$O(^ESP(910,ESPFN,10,ESPAKA))'>0 "Alias: "
 F I=1:1 S ESPAKA=$O(^ESP(910,ESPFN,10,ESPAKA)) Q:ESPAKA'>0  S ESPAKA(I)=$P(^(ESPAKA,0),U) W:I'=1 ?3 W "Alias ",I,": ",ESPAKA(I),!
 ;Print Remarks
 W !,"7) Remarks: " K ^UTILITY($J,"W") S DIWL=10,DIWR=70,DIWF="W",ESPREM=0
 F ESPZ=1:1 S ESPREM=$O(^ESP(910,ESPFN,20,ESPREM)) Q:ESPREM'>0  S X=^(ESPREM,0) D ^DIWP
 D ^DIWW
RD R !,"Enter: <RET> to continue or 1-7 to edit: ",X:DTIME
 G:X["?" HELP
 G:'X EXIT
 F I=1:1 S ESPX(I)=$P(X,",",I) Q:ESPX(I)=""
 F I=1:1:$L(ESPX(I),",") I ESPX(I)<1!(ESPX(I)>7) W !,$C(7),"NUMBER MUST BE 1-7" S ER=1
 I $D(ER) K ER W ! G RD
EDIT ;
 W !!
 L +^ESP(910,ESPFN):0
 E  W !!?5,"Record is in use.  Try later.",!,$C(7) G EXIT
 S DIE="^ESP(910,",DA=ESPFN,DR=""
 F I=1:1 Q:ESPX(I)=""  S DR=DR_$P($T(DR+ESPX(I)),";;",2) I ESPX(I+1)'="" S DR=DR_";"
 D ^DIE K DR,DIE
 L -^ESP(910,ESPFN):0
 G:$D(DTOUT) EXIT
 W !!,"Editing completed."
REV S DIR(0)="Y",DIR("A")="Do you want to review again",DIR("B")="YES" D ^DIR K DIR I Y G FDISP
EXIT W:$D(DTOUT) $C(7)
 K %X,%Y,DA,DIC,DIE,DIR,DIRUT,DIWF,DIWL,DIWR,DR,ER,ESP0,ESP1,ESP2,ESP3,ESPAKA,ESPD,ESPDOB,ESPJ,ESPNO,ESPREM,ESPX,ESPZ,I,IEN,X,Y,^TMP($J,"MNI")
 QUIT
MORE S DIR(0)="Y",DIR("A")="Show More",DIR("B")="YES" D ^DIR K DIR Q
HELP W !!,"Enter '^' to stop or <RET> to continue or enter the number by the fields you want to edit.  You may enter any combination of numbers separated by commas (ex: 1,3,5)",! G RD
DR ;
 ;;.01;.02;.03;.08;.09;.04;.1;.11
 ;;3.01:3.06
 ;;.05;.07;2.06
 ;;.06;2.01:2.06
 ;;1.01:1.06
 ;;10
 ;;20

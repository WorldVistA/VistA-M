MCARSUP ;WISC/TJK-MEDICINE PACKAGE MANAGEMENT OPTIONS ;7/2/92  10:23
V ;;2.3;Medicine;;09/13/1996
EN1 ;
1 Q:'$D(MCARCODE)  S DIC="^MCAR(695,",DLAYGO=695,DIC(0)="AEQLM" D ^DIC G OUT1:Y<0 S DA=+Y G DEL:$D(^MCAR(695,"C",MCARCODE,+Y)) S DR="1///"_MCARCODE,DIE=DIC K DIC,DLAYGO D ^DIE K DIE,DA,DR
 W !,*7,"Drug marked as a ",$S(MCARCODE="G":"GI",MCARCODE="P":"PULMONARY",MCARCODE="R":"RHEUMATOLOGY",1:"CARDIOLOGY")," Drug" G 1
EN2 ;
2 S DIC="^MCAR(693.6,",(DIDEL,DLAYGO)=693.6,DIC(0)="AEQLM" D ^DIC G OUT1:Y<0 S DA=+Y,DR=.01,DIE=DIC K DIC,DLAYGO D ^DIE K DA,DIE,DR G 2
EN3 ;
3 Q:'$D(DIC)  S MCDICS=DIC("S"),DIC(0)="AEQLM" D ^DIC G OUT1:Y<0 S DA=+Y,DR=.01,DIE=DIC,DIDEL=DLAYGO D ^DIE K DA S DIC("S")=MCDICS G 3
DEL K DIC,DA,DLAYGO,DIR
 S DA(1)=+Y
 S DIR("A",1)="Drug already marked as a "_$S(MCARCODE="G":"GI",MCARCODE="P":"PULMONARY",MCARCODE="R":"RHEUMATOLOGY",1:"CARDIOLOGY")_" Drug."
 S DIR("A")="Do you wish to delete it",DIR("B")="N",DIR(0)="Y"
 D ^DIR
 I Y S DA=$O(^MCAR(695,"C",MCARCODE,DA(1),0)),DIK="^MCAR(695,"_DA(1)_",1," D ^DIK K DA,DIK,%,Y,X W !!,"Deleted"
 G 1
OUT1 K %,%H,C,D0,DI,DIG,DIH,DIU,DIV,DIW,DQ,I,Z,Y,X,DIC,DLAYGO,DIE,MCARCODE,%Y,DR,DQ,D1,%Y1,%Y2,DICMX,DIPGM,DIXX,VA,DIDEL,MCDICS Q
HELP ;DISPLAY LIST OF DRUGS ALREADY MARKED
 IF $D(^MCAR(695,"C",$G(MCARCODE,U))) D  ;JCC,5/15/96
 .  S DIR("A")="Do you wish to see list of drugs already marked for this area of Medicine"
 .  S DIR("B")="N",DIR(0)="Y"
 .  D ^DIR
 .  IF Y D
 ..    W !!,"Drugs already marked for this area of Medicine: ",!
 ..    F I=0:0 S I=$O(^MCAR(695,"C",MCARCODE,I)) Q:I=""  W:$X>50 ! W $E($P(^PSDRUG(I,0),U)_"                                        ",1,40)
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 Q

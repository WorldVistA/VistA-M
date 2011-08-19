QAOEDT0P ;HISC/DAD-PEER REVIEW LEVEL EDIT ;2/3/93  15:57
 ;;3.0;Occurrence Screen;;09/14/1993
REVLEV S (QAOSQUIT,QAOSNEWF)=0,QAOSREVR(0)=+^QA(741,QAOSD0,"REVR",QAOSD1,0)
 K DR S DIE="^QA(741,"_QAOSD0_",""REVR"",",DR=".01"
 S (D0,DA(1))=QAOSD0,(D1,DA)=QAOSD1 D ^DIE G:('$D(DA))!($D(Y)) EXIT
 S QAOSREVR(1)=+^QA(741,QAOSD0,"REVR",QAOSD1,0)
 I QAOSREVR(0)'=QAOSREVR(1) D RESET^QAOEDT0 G REVLEV
 K DR S DIE="^QA(741,"_QAOSD0_",""REVR"",",DR=".02T;.03"
 S (D0,DA(1))=QAOSD0,(D1,DA)=QAOSD1 D ^DIE G:$D(Y) EXIT
FINDING ;
 S QAOSFIND(1)=$P($G(^QA(741,QAOSD0,"REVR",QAOSD1,0)),"^",5)
 K DR S DIE="^QA(741,"_QAOSD0_",""REVR"",",DR="4"
 S (D0,DA(1))=QAOSD0,(D1,DA)=QAOSD1 D ^DIE G:$D(Y) EXIT
 S QAOSFIND(2)=$P($G(^QA(741,QAOSD0,"REVR",QAOSD1,0)),"^",5)
 S QAOSNEWF=0 I QAOSFIND(1),QAOSFIND(2)'=QAOSFIND(1) S QAOSNEWF=1
 S QAOS=+$G(^QA(741.6,+QAOSFIND(2),0))
 I QAOSFDSP("F")[("^"_QAOS_"^") S (QAOSQUIT,QAOSFDSP)=1
ACTION ;
 I QAOSNEWF W !!?5,"Since the findings have been changed, you must review the actions.",!?5,"Delete any old actions that no longer apply, and add new actions that",!?5,"are now appropriate."
 S:$D(^QA(741,QAOSD0,"REVR",QAOSD1,2,0))[0 ^(0)="^741.15PA^^"
 K DR S DIE="^QA(741,"_QAOSD0_",""REVR"","
 S DR="5"_$S(QAOSQUIT:"//^S X=1",1:""),(D0,DA(1))=QAOSD0,(D1,DA)=QAOSD1
 D ^DIE G:$D(Y) EXIT
 D CHKACT^QAOEDT0
 K DR S DIE="^QA(741,"_QAOSD0_",""REVR"",",DR="10;1;9//NO"
 S (D0,DA(1))=QAOSD0,(D1,DA)=QAOSD1 D ^DIE G:$D(Y) EXIT
ATTRIB ;
 W !!?5,"Do you wish to enter peer attributions"
 S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT
 I '% D  G ATTRIB
 . W !!?10,"Enter Y(es) to edit the individual, medical team, and"
 . W !?10,"hospital location attribution data."
 . W !?10,"Enter N(o) to skip the attribution edit."
 . Q
 ;
 S QAOSSERV=$P($G(^QA(741,QAOSD0,"REVR",QAOSD1,0)),"^",10)
 F QAOFIELD=24:1:26 W ! D  Q:QAOSQUIT
 . S QAOSUBDD="741.0"_QAOFIELD
 . S QAOSNODE="ATR"_$S(QAOFIELD=24:"I",QAOFIELD=25:"T",QAOFIELD=26:"L")
 . S:'$D(^QA(741,QAOSD0,QAOSNODE,0)) ^(0)="^"_QAOSUBDD_"PA^^"
AGAIN . K DA,DIC,DIE,DR
 . S DIC="^QA(741,"_QAOSD0_","""_QAOSNODE_""",",DIC(0)="AELMNQ"
 . S DIC("S")="S QA=$P($G(^(0)),""^"",2) I QA=""""!(QA=QAOSSERV)"
 . S DA(1)=QAOSD0,DLAYGO=QAOSUBDD
 . D ^DIC S QAOSD1=+Y
 . I Y'>0 S QAOSQUIT=$S($D(DUOUT):1,$D(DTOUT):1,1:0) Q
 . S DIE=DIC,(D0,DA(1))=QAOSD0,(D1,DA)=QAOSD1
 . S DR=".01" S:QAOSSERV DR=DR_";.02///`"_QAOSSERV
 . D ^DIE
 . G AGAIN
EXIT ;
 Q

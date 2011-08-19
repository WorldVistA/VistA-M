QAMEDT6 ;HISC/DAD-GROUP FILE EDIT ;7/12/93  14:24
 ;;1.0;Clinical Monitoring System;;09/13/1993
 S QAMBRACE=$S($D(^QA(740,1,"QAM"))#2:$P(^("QAM"),"^",6),1:0)
EN1 K DIC,DIE,DR,DLAYGO,DIDEL,DIK,DO S DIC="^QA(743.5,",DIC(0)="AELMNQ",DIC("A")="Select GROUP: ",DLAYGO=743.5 W ! D ^DIC G:Y'>0 EXIT
 K DIC,DIE,DR,DLAYGO,DIDEL,DIK,DO S (QAMD0,DA)=+Y,DIE="^QA(743.5,",DR=".01;.02" D ^DIE G:($D(DA)[0)!($D(Y)) EN1
 S:$D(^QA(743.5,QAMD0,"GRP",0))[0 ^(0)="^743.51A^^" S QAMD1=+$P(^(0),"^",3),QAMDFLT=$S($D(^QA(743.5,QAMD0,"GRP",QAMD1,0))#2:$P(^(0),";"),1:"")
 D GRPMEMBR G EN1
EXIT ;
 K %,C,D0,D1,DA,DI,DIC,DIDEL,DIE,DIK,DGA1,DGT,DLAYGO,DQ,DR,QADIROUT,QADIRPNT,QAMD0,QAMD1,QAMD2,QAMBRACE,QAMDFLT,QAMDIC,QAMID,QAMIDENT,QAMINPUT,QAMQUIT,QAMTEXT,QAMY,VAERR,X,Y
 Q
GRPMEMBR ; *** EDIT GROUP MEMBERS
 W !,"Select GROUP MEMBER: " W:QAMDFLT]"" QAMDFLT,"// " R X:DTIME S:'$T X="^" S:(X="")&(QAMDFLT]"") X=QAMDFLT S QAMDFLT="",QAMINPUT=X Q:($E(X)="^")!(X="")
 I $E(X)="?" W !!?5,"You may enter `[GROUP MEMBER' to select all entries that CONTAIN",!?5,"the text `GROUP MEMBER'.  Enter `[*' to select ALL entries."
 I  W !?5,"You may use a prefix of minus (-) to delete a range of group",!?5,"members, for example `-[GROUP MEMBER' or `-[*'.",!?5,"WARNING: Use of the contains operator ([) is very computer intensive!"
 I  W !?5,"If you are having trouble adding another group member at the 'Select",!?5,"GROUP MEMBER:' prompt try enclosing the new entry in quotes, e.g.,",!?5,"""GROUP MEMBER""."
 I QAMINPUT?.1"-"1"[".1"*".E S QAMQUIT=0 D CONTAIN G:QAMQUIT=1 GRPMEMBR
 K DA,DIC,DIE,DIK,DINUM,DO,DR,DLAYGO,DIDEL,DIK S DIC="^QA(743.5,"_QAMD0_",""GRP"",",DIC(0)="EMQZ"_$S($E(X)'="`":"L",1:""),(DIDEL,DLAYGO)=743.5,(DA(1),D0)=QAMD0 D ^DIC G:Y'>0 GRPMEMBR
 K DIC,DIE,DR,DLAYGO,DIDEL,DIK,DO S DIE="^QA(743.5,"_QAMD0_",""GRP"",",DR=.01,(DLAYGO,DIDEL)=743.5,(DA,D1)=+Y,(DA(1),D0)=QAMD0 D ^DIE K DIDEL
 G GRPMEMBR
CONTAIN ; *** PROCESS CONTAINS OPERATOR
 I QAMBRACE'>0 W !!?3,"*** This function ([) has been turned off in the site parameter file ***",*7,! S QAMQUIT=2 Q
 S QAMTEXT=$P(QAMINPUT,"[",2) I QAMTEXT="" S QAMQUIT=2 Q
 W *7
ASK W !!?2,$S($E(QAMINPUT)="-":"Delete",1:"Add")," ",$S(QAMTEXT="*":"ALL entries",1:"all entries that contain `"_QAMTEXT_"' ") S %=2 D YN^DICN S QAMQUIT=% I (%=-1)!(%=2) W ! Q
 I '% W !!?5,"Please answer Y(es) or N(o)." G ASK
 W !,"Working",! G:QAMINPUT?1"-[".E DELETE
 S QAMDIC(0)=$S($D(^QA(743.5,QAMD0,0))#2:+$P(^(0),"^",2),1:0),QAMDIC=$S($D(^DIC(QAMDIC(0),0,"GL"))#2:^("GL"),1:"") I QAMDIC="" S QAMQUIT=2 Q
 F QAMD2=0:0 S QAMD2=$O(@(QAMDIC_"QAMD2)")) Q:QAMD2'>0  D ADD W "."
 W ! Q
ADD ;
 I $E(QAMTEXT)'="*" S Y=$P(@(QAMDIC_"QAMD2,0)"),"^"),C=$P(^DD(QAMDIC(0),.01,0),"^",2) D Y^DIQ K C Q:Y'[QAMTEXT
 K DIC,DIE,DR,DLAYGO,DIDEL,DIK,DO S DIC="^QA(743.5,"_QAMD0_",""GRP"",",DIC(0)="LMN",DIC("W")="W """"",(DA(1),D0)=QAMD0,DLAYGO=743.5,X="`"_QAMD2 D ^DIC
 Q
DELETE ;
 F QAMD1=0:0 S QAMD1=$O(^QA(743.5,QAMD0,"GRP",QAMD1)) Q:QAMD1'>0  D DEL W "."
 W ! Q
DEL S X=$S($D(^QA(743.5,QAMD0,"GRP",QAMD1,0))#2:$P(^(0),";"),1:"") I $E(QAMTEXT)'="*" Q:X'[QAMTEXT
 W "  ",X,"  " K DIC,DIE,DR,DLAYGO,DIDEL,DIK,DO S DIK="^QA(743.5,"_QAMD0_",""GRP"",",(DA,D1)=QAMD1,(DA(1),D0)=QAMD0,DIDEL=743.5 D ^DIK K DIK,DIDEL
 Q

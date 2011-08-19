DGWAIT ;ALB/JDS - ENTER PATIENTS INTO WAIT LIST; 21 APR 84  13:57
 ;;5.3;Registration;;Aug 13, 1993
 ;
DIV K DIE("NO^"),DIC W !! S DGWAIT=1,DIC="^DGWAIT(",DIC(0)="AEQMZL" D ^DIC K DIC G Q:Y'>0 S DIV=+Y
 ;
PAT K DIC,DIE,DE,DQ W !! S:'($D(^DGWAIT(DIV,"P",0))\10) ^DGWAIT(DIV,"P",0)="^42.51PA^^" S DA(1)=DIV,DIC="^DGWAIT("_DIV_",""P"",",DIC(0)="AEQMZL" D ^DIC G DIV:Y'>0
EDIT S DIE=DIC,DGI=DA(1),(DGI1,DA)=+Y,DR=$P($T(T),";;",2,999),DP=42.51 D ^DIE K DR I '$D(DA) W !!,"Patient Deleted from Waiting List",*7 K DGI,DGI1 G PAT:DGWAIT,Q
 S DGD=^DGWAIT(DGI,"P",DGI1,0),DGER=0
 S DGF="^DATE/TIME OF APPLICATION^^ACTION^BEDSECTION APPLYING TO^IN ANOTHER HOSPITAL^VA FACILITY^HOSPITAL NAME^PRIORITY GROUPING^TREATING SPECIALTY^^HOSPITAL/NHCU APPLICATION^CATEGORY OF NEED"
 I $P(DGD,"^",2)'["." S X=2,X1="does not include time..." D W
 F X=12,5,10,4,9 I $P(DGD,"^",X)']"" S X1="is not specified..." D W
 I $P(DGD,"^",12)="h",$P(DGD,"^",13)']"" S X=13,X1="not specified for HOSPITAL applicant..." D W
 S X=$P(DGD,"^",12) I X]"",$P(DGD,"^",9)]"",$D(^DIC(42.55,+$P(DGD,"^",9),0)),$P(^(0),"^",5)'=X,$P(^(0),"^",5)'="a" S X=9,X1="inconsistent with "_$S($P(DGD,"^",12)="h":"Hospital",1:"NHCU")_" application..." D W
 G CD:'$P(DGD,"^",6) F X=7,8 I $P(DGD,"^",X)']"" S X1="must be specified if currently hospitalized..." D W
CD I 'DGER W !!,"Patient Entered on Waiting List" G PAT:DGWAIT,Q
 W !!,"Above inconsistencies must be corrected before continuing.",! S DA(1)=DGI,Y=DGI1 G EDIT
 ;
Q K DGER,DR,DIE,DGI,DGI1,DA,DIC,DGD,DGF,X,X1,DIV,DGWAIT Q
DIVK K DIE("NO^"),DIC W !! S DIC("A")="Delete WAITING LIST entry from which DIVISION: ",DIC="^DGWAIT(",DIC(0)="AEQMZ" D ^DIC K DIC G Q:Y'>0 S DIV=+Y
PATK K DIC,DIE,DE,DQ W !! S DIC("A")="Delete WAITING LIST entry for which patient: ",DA(1)=DIV,DIC="^DGWAIT("_DIV_",""P"",",DIC(0)="AEQMZ" D ^DIC G DIVK:Y'>0 S DA=+Y
OKD S %=2 W !,"OK to delete ",$P(^DPT(+^DGWAIT(DIV,"P",DA,0),0),"^",1)," WAITING LIST entry" D YN^DICN I '% W !,"ANSWER 'Y'ES OR 'N'O" G OKD
 I %=1 S DIK=DIC,DA(1)=DIV D ^DIK W !,"*DELETED*" G Q
 G Q
W W:'DGER ! W !," > ",$P(DGF,"^",X)," ",X1 S DGER=1 Q
T ;;S DIE("NO^")="",DFN=+^DGWAIT(DA(1),"P",DA,0);S SC=$S('$D(^DPT(DFN,.3)):0,$P(^(.3),"^",1)="Y":1,1:0);.01;2//NOW;12//HOSPITAL;I X'="h" S Y=1;13//GENERAL;1;1.5;3.5;I 'X S Y=4;3.6;3.7;4//PENDING;3///^S X=SC;K SC;5;K DIE("NO^");10;

DGPMGL2 ;ALB/LM - ADC INFO; 5 NOV 90
 ;;5.3;Registration;**59**;Aug 13, 1993
 ;
A S DGHX=""
 F DGN=0:0 S DGN=$O(^DG(40.8,DGN)) Q:'DGN  K DR I $D(^(DGN,0)) I '$P(^(0),"^",3) W !!,"SITE: ",$P(^(0),"^") D DGN G Q:'$D(^DG(40.8,DGN,"CEN",RD,0)) F I=2:1:12 S $P(DGHX,"^",I)=$P(DGHX,"^",I)+$P(^DG(40.8,DGN,"CEN",RD,0),"^",I)
 ;
Q K DGN,I,DGHX
Q1 K DA,DIE,DP,DR,X,Y Q
 ;
DGN I '$D(^DG(40.8,DGN,"CEN",0)) S Y=RD W " WHAT WAS THE CENSUS ON " D DT^DIQ R "? ",X:DTIME Q:X["^"  I $S((X\1'=X):1,X'=0:1,1:0) W !?4,"Enter a WHOLE NUMBER without fractions or '0' or up-arrow [""^""] to QUIT!!",*7,! G DGN
 S:'$D(^DG(40.8,DGN,"CEN",0)) ^(0)="^40.802^^"
 ; S DR="5///"_X  ; this was in original code but ? was it used
 K Y
DGN1 I $P($G(^DG(40.8,DGN,"CEN",RD,0)),U,4)="" D
 . ; brings in default values from previous date
 .N X,Y
 .I $D(^DG(40.8,DGN,"CEN",PD,0)) S X=^(0)
 .I '$G(X) S Y=+$O(^DG(40.8,DGN,"CEN",RD),-1),X=$S('Y:"",1:^(Y,0))
 .S ^DG(40.8,DGN,"CEN",RD,0)=RD_"^"_$P(X,U,2,99)
 .K X,Y
 S DR="3;" ; Cum Planned ADC
 S DR=DR_"S:'+$P(^DG(43,1,0),U,20) Y=""@1"";1;@1;" ; Cum Planned NH ADC
 S DR=DR_"S:'+$P(^DG(43,1,0),U,21) Y=""@2"";1.25;@2;" ; Cum Planned Dom ADC
 S DR=DR_"2;" ; Monthly Planned ADC
 S DR=DR_"S:'+$P(^DG(43,1,0),U,20) Y=""@3"";2.25;@3;" ; Monthly Planned NH ADC
 S DR=DR_"S:'+$P(^DG(43,1,0),U,21) Y=""@4"";2.5;@4;" ; Monthy Planned Dom ADC
 S DR=DR_"4///0;20" ; 4=Dialysis patients  20=Corrections to Previous G&L's
 S DIE="^DG(40.8,"_DGN_",""CEN"","
 S DA=RD,DA(1)=DGN,DP=40.802 K Y
 D ^DIE
 D Q1
 Q

DGPTOLC1 ;ALB/AS - SUMMARY by ADM Rpt, lists diagnoses, sur, pro ; 2 AUG 88 @ 1300
 ;;5.3;Registration;;Aug 13, 1993
 ;
 D LO^DGUTL S DGPTF=0,DIC="^DGPT(",DIC(0)="EQMZ",DIC("S")="I $P(^(0),U,11)=1"
 F PTF=1:0:20 W !,"Select ",$S(PTF>1:"another",1:"PTF PATIENT") R " RECORD: ",DGX:DTIME D HELP:DGX["?" Q:DGX=""!(DGX["^")!('$T)  S X=DGX D ^DIC I Y>0 D PAT
 G:DGX["^"!('$T) Q I $D(DGPTF)'=11 W !,"no PTF Patient Records selected" G Q
 S DGPGM="EN^DGPTOLC2",DGVAR="DGPTF#^DUZ" D ZIS^DGUTQ G:POP Q U IO G EN^DGPTOLC2
PAT S DGNAME=$P(^DPT(+^DGPT(+Y,0),0),"^"),DGADM=$P(^DGPT(+Y,0),"^",2) Q:$D(DGPTF(+Y))
 S DGPTF(+Y)=DGNAME_"^"_DGADM,PTF=PTF+1 Q
Q K DGADM,DGNAME,DGPGM,DGPTF,DGVAR,DIC,POP,PTF,DGX,X,Y Q
HELP W !?4,"Enter PTF record # or patient name",!?4,"You may select up to 20 PTF Patient Records",!?4,"Enter <RETURN> when all desired PTF Patient Records have been selected" Q
Q2 W ! D CLOSE^DGUTQ K DGADM,DGBS,DGC,DGDT,DGELIG,DGF,DGFEE,DGICD,DGLOS,DGLV,DGM,DGNAME,DGPG,DGMD,DGPGM,DGPRO,DGPT,DGPTF,DFN,DGPTX,DGS,DGSTAT,DGSUR,DGVAR,DG70,DGPMIFN,D1,DIC,POP,PTF,X,Y,X1,X2,% Q

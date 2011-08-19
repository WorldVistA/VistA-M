SOWKDB2 ;B'HAM ISC/SAB-Data Base Assessment profile Continued ;  [ 06/17/96  9:40 AM ]
 ;;3.0; Social Work ;**14,17,38,44**;27 Apr 93
 D CHK^SOWKDB G:$G(SWX)["^" CL W !?5,"4.  Describe Social Support System: " I $O(^SOWK(655.2,DFN,13,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,13,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB G:$G(SWX)["^" CL W !?5,"5.  Present use of Community Resources: " I $O(^SOWK(655.2,DFN,14,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,14,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 S CL=$P(^DD(655.2,15,0),"^",3),DB=$P(^SOWK(655.2,DFN,0),"^",15)
 D CHK^SOWKDB G:$G(SWX)["^" CL W !?5,"6.  Current Living arrangements: " I DB]"" W ?$X+2 S CL=$P(CL,DB_":",2),DB=$F(CL,";") W $E(CL,1,DB-2)
 E  W "UNSPECIFIED",!
 D CHK^SOWKDB G:$G(SWX)["^" CL W !?5,"7.  Social/Family Assessment: " I $O(^SOWK(655.2,DFN,16,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,16,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB G:$G(SWX)["^" CL W !!,"VI.  Legal Situation:" G:'$D(^SOWK(655.2,DFN,22)) LEG
 I '$P(^SOWK(655.2,DFN,22),"^") G GUA
 D CHK^SOWKDB G:$G(SWX)["^" CL W !!?5,"Power of Attorney:",!?9,$P(^SOWK(655.2,DFN,22),"^",4),!?9,$P(^(22),"^",5) W:$P(^(22),"^",6)]"" !?9,$P(^(22),"^",6)
 D CHK^SOWKDB W !?9,$P(^SOWK(655.2,DFN,22),"^",7),$S($P(^(22),"^",8):", "_$P(^DIC(5,$P(^(22),"^",8),0),"^"),1:" ")_"  "_$P(^SOWK(655.2,DFN,22),"^",9),!?9,$S($P(^(22),"^",10):"Phone: "_$P(^(22),"^",10),1:"")
GUA W !!?5,"Living Will: "_$S($P(^SOWK(655.2,DFN,22),"^",2):"YES",1:"NO"),!
 D CHK^SOWKDB I '$P(^SOWK(655.2,DFN,22),"^",3) G LEG
 D CHK^SOWKDB G:$G(SWX)["^" CL W !?5,"Guardianship: ",$S($P($G(^SOWK(655.2,DFN,22)),U,3)=1:"YES",1:"O"),!?9,$P($G(^SOWK(655.2,DFN,22)),"^",11),!?9,$P($G(^(22)),"^",12) W:$P($G(^SOWK(655.2,DFN,25)),U)'="" !?9,$P(^SOWK(655.2,DFN,25),"^")
 D CHK^SOWKDB W:$P($G(^SOWK(655.2,DFN,25)),U,2)'="" !?9,$P(^SOWK(655.2,DFN,25),"^",2)_", "
 I $D(^SOWK(655.2,DFN,25)) W $S($P(^SOWK(655.2,DFN,25),"^",3):$P(^DIC(5,$P(^SOWK(655.2,DFN,25),"^",3),0),"^"),1:"")_"  "_$P(^SOWK(655.2,DFN,25),"^",4),!?9,"Phone: "_$P(^(25),"^",5)
LEG D CHK^SOWKDB G:$G(SWX)["^" CL W !!?5,"Legal Assessment: " I $O(^SOWK(655.2,DFN,15,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,15,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB G:$G(SWX)["^" CL W !!,"VII.  Current Substance Abuse Problems: "_$S($P(^SOWK(655.2,DFN,0),"^",25)=1:"YES",$P(^(0),"^",25)=2:"NO",1:"UNKNOWN")
 D CHK^SOWKDB G:$G(SWX)["^" CL W !!?5," Comments on Substance Abuse: " I $O(^SOWK(655.2,DFN,8,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,8,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB G:$G(SWX)["^" CL W !!,"VIII. Psycho-Social Assessment: " I $O(^SOWK(655.2,DFN,19,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,19,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 S GG=0 D CHK^SOWKDB G:$G(SWX)["^" CL W !!,"IX.  Preliminary List of Problems"
 I $O(^SOWK(655.2,DFN,17,0)) F G=0:0 S G=$O(^SOWK(655.2,DFN,17,G)) Q:'G  S GG=GG+1 D CHK^SOWKDB G:$G(SWX)["^" CL W !?5,GG_". ",$P(^SOWK(655.201,$P(^SOWK(655.2,DFN,17,G,0),"^"),0),"^")
 I 'GG F T=1:1:3 W !?5,T_". " F G=1:1:50 W "_"
 D CHK^SOWKDB G:$G(SWX)["^" CL W !!?5,"Initial Plan of Action" F SOWKG=0:0 S SOWKG=$O(^SOWK(655.2,DFN,10,SOWKG)) Q:'SOWKG  D CHK^SOWKDB G:$G(SWX)["^" CL S X=^SOWK(655.2,DFN,10,SOWKG,0) D ^DIWP
 D ^DIWW
CL W !!! D:$E(IOST)'["C" TR^SOWKDB W !!!
 W:$E(IOST)'["C" @IOF D ^%ZISC K D,GG,TI,DB,CL,ADM,CB,DFN,DIC,DOB,E,EP,F,G,I,IC,L,POP,PRD,PW,Q,SC,ST,SOWKG,PG,DA
 K X1,X2,ED,EDL,SX,T,W,X,Y,Z,ZTRTN,ZTSAVE D KVA^VADPT Q

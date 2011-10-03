PSOPOST1 ;BHAM ISC/SAB - post routine to view status of background jobs ; 6/26/97
 ;;7.0;OUTPATIENT PHARMACY;**12,29,87**;DEC 1997
 ;External Ref. to ^ORD(101, is supp. by DBIA# 872
 K %ZIS,IOP,ZTSK S PSOION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP G EX
 I $D(IO("Q")) D  S IOP=PSOION D ^%ZIS G EX
 .S ZTDESC="Outpatient Pharmacy Background Job Status",ZTRTN="EN^PSOPOST1",ZTSAVE("ZTREQ")="@" D ^%ZTLOAD
 .W:$D(ZTSK) !,"Report Queued to Print!",! K X,Y,IO("Q"),ZTSK
EN K DIC,DR,DA,DIQ,PSOPOST
 S DIC=59.7,DA=1,DR=".01;49.99;49.981;49.982",DIQ="PSOPOST" D EN^DIQ1
 Q
 I $G(PSOPOST(59.7,1,49.99))<7 D
 .K PSOPOST(59.7,1,49.981),PSOPOST(59.7,1,49.982),PSOPOST(59.7,1,49.983),PSOPOST(59.7,1,49.984)
 D NOW^%DTC S $P(LINE,"-",IOM)="-",HDR="Outpatient Pharmacy Background Job Status",Y=% X ^DD("DD")
 U IO W @IOF,!?1,HDR_"  "_$P(Y,"@")_"  "_$P(Y,"@",2)_"       Page 1",!,LINE
 W !?17,"Site Name: "_PSOPOST(59.7,1,.01),!?1,"Current Version Installed: "_$G(PSOPOST(59.7,1,49.99)),!
 W !?1,"Background Conversion Job Started: "_$S($G(PSOPOST(59.7,1,49.981))]"":$P(PSOPOST(59.7,1,49.981),"@")_"  "_$P(PSOPOST(59.7,1,49.981),"@",2),1:"Job Not Started Yet!")
 W !?21,"Job Completed: "_$S($G(PSOPOST(59.7,1,49.982))]"":$P(PSOPOST(59.7,1,49.982),"@")_"  "_$P(PSOPOST(59.7,1,49.982),"@",2),1:"")
EX D ^%ZISC K DIC,DR,DA,DIQ,PSOPOST,LINE,HDR,Y,X,%I,D0,PSOION
 Q
OPT ;PSO*7.0*12 deletes PSO CANCEL protocol in preinstall
 S DA=$O(^ORD(101,"B","PSO CANCEL",0)) I DA S DIK="^ORD(101," D ^DIK K DIK,DA
NDCM ;PSO*7*29 data conv. rout. to move data of field#11 NDC piece 13 from File 52.1(Refills) Node 0 to piece 3 of Node 1
 N V1,V2
 S V1=0 F  S V1=$O(^PSRX(V1)) Q:'V1  S V2=0 F  S V2=$O(^PSRX(V1,1,V2)) Q:'V2  S NDC=$P($G(^(V2,0)),"^",13) S:NDC]"" $P(^(1),"^",3)=NDC,$P(^(0),"^",13)=""
 Q
NDC ;PSO*7.0*29 Pre-install, to remove field#11 (NDC) of file 52.1 (Refills) in order to increase the length of field#1.2 (Current Unit Price of Drug) from 99.999 to 999.9999
 S DIK="^DD(52.1,",DA=11,DA(1)=52.1 D ^DIK K DIK,DA
 Q
NDCQ ;Post-install display
 W !  ;S DIR(0)="Y",DIR("B")="YES"
 W !,"In this patch field NDC (#11) in the REFILL sub-file (#52.1) is moved to"
 W !,"a new node within the multiple. The data in the old location can be moved to "
 W !,"it's new location now by selecting a time to queue the background job or can be"
 W !,"moved later by using the entry point NDCQ^PSOPOST1. This job can run at least"
 W !,"an hour or more depending on the amount of data that is in the PRESCRIPTION"
 W !,"file (#52). If you do not want to queue the background job at this time"
 W !,"enter '^' at the prompt."
 W !,"Be aware at this point that the cursor is hidden and the characters you enter"
 W !,"here will not be seen as the whole process is under the control of KIDS."
NDCG ;PSO*7*29 post-install background bob Date/Time selection
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue Post-install Job to run Date/Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) G NDCX
 S ZTDTH=$G(Y),ZTIO="",ZTRTN="NDCM^PSOPOST1",ZTDESC="Outpatient Pharmacy V7 Patch 29 Data Conversion",ZTIO=""
 D ^%ZTLOAD W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 Q
NDCX W !!,"Task not queued !",!
 Q
MISIG ;post install for PSO*7*87
 F RX=0:0 S RX=$O(^PSRX(RX)) Q:'RX  I $G(^PSRX(RX,"SIG"))="^",$P($G(^("OR1")),"^",3) D
 .S RXN=$P(^PSRX(RX,"OR1"),"^",3) I $P($G(^PSRX(RXN,"SIG")),"^")]"" S ^PSRX(RX,"SIG")=^PSRX(RXN,"SIG") D EN^DDIOL(".","","?1")
 K RX,RXN
 Q

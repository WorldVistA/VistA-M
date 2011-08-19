PSOLAB ;BHAM ISC/JMB - prints most recent lab value on action profile ; 5/6/94
 ;;7.0;OUTPATIENT PHARMACY;**29**;DEC 1997
 ;External Ref. to ^LAB(60, is supp. by DBIA# 333
 ;External Ref. to ^LR(LRDFN,"CH", is supp. by DBIA# 844
 ;External Ref. to ^PSDRUG(MDRUG,"CLOZ", is supp. by DBIA# 221
PRINT ;
 I '$D(^DPT(DFN,"LR")) W !,"*** NO LAB DATA ON FILE ***" Q
 S LRDFN=+$P(^DPT(DFN,"LR"),"^") Q:'LRDFN
 S MDRUG=+$P(RX0,"^",6),TST=+$P(^PSDRUG(MDRUG,"CLOZ"),"^"),MDAYS=+$P(^("CLOZ"),"^",2),TSTSP=+$P(^("CLOZ"),"^",3)
 G:'TST!('MDAYS)!('TSTSP) CLEAN
 S TSTN=$P($G(^LAB(60,TST,0)),"^"),LDN=$S($D(^(.2)):+^(.2),1:+$P($P($G(^(0)),"^",5),";",2))
 I $G(^LAB(60,TST,.2))=""&($P($P($G(^LAB(60,TST,0)),"^",5),";",2)="") W !,"*** Results for a panel cannot be printed! Only a lab test result can be printed for marked drugs." G CLEAN
EDATE S X="T-"_MDAYS K %DT D ^%DT S EDT=Y,EDL=(9999999-EDT)_".999999",INDIC=0
BEG F BDL=0:0 S BDL=$O(^LR(LRDFN,"CH",BDL)) Q:BDL=""!(BDL>EDL)  D  Q:INDIC=1
 .Q:'$D(^LR(LRDFN,"CH",BDL,LDN))!('$D(^(0)))
 .Q:$P(^LR(LRDFN,"CH",BDL,0),"^",3)=""!($P(^(0),"^",5)'=TSTSP)
 .S Y=$S(+$P($P(^LR(LRDFN,"CH",BDL,0),"^"),"."):+$P($P(^(0),"^"),"."),1:$P(^(0),"^",3))
 .W !,"*** MOST RECENT "_$G(TSTN)_" PERFORMED "_$E(Y,4,5)_"-"_$E(Y,6,7)_"-"_$E(Y,2,3)_" = "_$P($G(^LR(LRDFN,"CH",BDL,LDN)),"^")_" "_$P($G(^LAB(60,TST,1,TSTSP,0)),"^",7) S INDIC=1
 W:INDIC=0 !,"*** NO RESULTS FOR "_TSTN_" SINCE "_$E(EDT,4,5)_"-"_$E(EDT,6,7)_"-"_$E(EDT,2,3)
CLEAN K BDL,EDL,EDT,INDIC,LDN,LRDFN,MDAYS,MDRUG,TST,TSTN,TSTSP,X,Y
 K DA,DIRUT,DR,DTOUT,DUOUT,IEN50,LIEN
 Q

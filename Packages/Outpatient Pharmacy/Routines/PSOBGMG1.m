PSOBGMG1 ;BHAM ISC/LC - BINGO BOARD MANAGER (CONT'D) ; 12/06/94
 ;;7.0;OUTPATIENT PHARMACY;**10,22,60,268**;DEC 1997;Build 9
INDX ;Re-index "ANAM" & "BA" X-REF
 N DA,DIE,DR,MNY,MRX,NNM,ONM,PTR
 F EN=0:0  S EN=$O(^PS(52.11,"ANAM",ADA,NAME,EN)) Q:'EN  D
 .I '$D(^PS(52.11,EN)) K ^PS(52.11,"ANAM",ADA,NAME,EN) Q
 .S ONM=$P(^PS(52.11,EN,1),"^"),MNY=$P(^PS(52.11,EN,1),"^",3),MRX=$P(^PS(52.11,EN,1),"^",4)
 .S PTR=$P(^PS(52.11,EN,0),"^"),NNM=$P(^DPT(PTR,0),"^") I NNM'=ONM D
 ..K ^PS(52.11,"ANAM",ADA,NAME,EN)
 ..S ^PS(52.11,"ANAM",ADA,MNY_MRX_" "_NNM,EN)=""
 ..S DA=EN,DR="8////"_NNM_"",DIE="^PS(52.11," L +^PS(52.11,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) E  W !!,$C(7),ONM_" is being edited!",! Q
 ..D ^DIE K DIE L -^PS(52.11,DA)
 Q
WAIT ;compute/compare avg and normal wait times
 S AWT=0
 I $G(^PS(59.2,DT,1,PSOSITE,0)) D NOW^%DTC S BBH=$E($P(%,".",2),1,2),BBM=$E($P(%,".",2),3,4) D
 .S:$G(BBM)>30 BBH=BBH+1 S:BBH'>9 AWT=0
 .I $G(BBH)=10 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",5)+$P(^(0),"^",7)),NUM=($P(^(0),"^",4)+$P(^(0),"^",6)) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=11 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",7)+$P(^(0),"^",9)),NUM=($P(^(0),"^",6)+$P(^(0),"^",8)) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=12 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",9)+$P(^(0),"^",11)),NUM=($P(^(0),"^",8)+$P(^(0),"^",10)) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=13 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",11)+$P(^(0),"^",13)),NUM=($P(^(0),"^",10)+$P(^(0),"^",12)) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=14 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",13)+$P(^(0),"^",15)),NUM=($P(^(0),"^",12)+$P(^(0),"^",14)) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=15 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",15)+$P(^(0),"^",17)),NUM=$P(^(0),"^",14)+$P(^(0),"^",16) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=16 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",17)+$P(^(0),"^",19)),NUM=($P(^(0),"^",16)+$P(^(0),"^",18)) S:$G(NUM) AWT=WTT/NUM
 .I $G(BBH)=17 S WTT=($P(^PS(59.2,DT,1,PSOSITE,0),"^",19)+$P(^(0),"^",21)),NUM=($P(^(0),"^",18)+$P(^(0),"^",20)) S:$G(NUM) AWT=WTT/NUM
 .S:$G(BBH)>18 AWT=0
 S:AWT["." AWT2=$P(AWT,".",2),AWT=$P(AWT,".") S:$E($G(AWT2))'<5 AWT=AWT+1
 S TTX=$S($G(AWT)'>$G(NWT):"NORMAL WAITING TIME IS "_NWT_" MINUTES",$G(AWT)>$G(NWT):"AVERAGE WAITING TIME IS "_AWT_" MINUTES",1:"")
 Q
DEV ;select device
 K NODV N DA,DR,DIC I '$D(DEV),($P($G(^PS(59.3,ADA,0)),"^",4)'="") D
 .S DEV=$P($G(^PS(59.3,ADA,0)),"^",4)
 .S DIC="^%ZIS(1,",DA=DEV,DR=".01;3",DIQ="DPTR",DIQ(0)="I" D EN^DIQ1
 .S DEV=$G(DPTR(3.5,DA,.01,DIQ(0))),DEVSB=$G(DPTR(3.5,DA,3,DIQ(0)))
 .S DIC="^%ZIS(2,",DA=DEVSB,DR=".01",DIQ="DEVSB1",DIQ(0)="I" D EN^DIQ1
 I $D(DEV) S %ZIS("B")=DEV,%ZIS("S")="I $E($G(DEVSB1(3.2,DA,.01,DIQ(0))),1,4)=""C-VT""",%ZIS="Q" D ^%ZIS S DV=ION I POP S NODV=1 Q
 I '$D(DEV) S %ZIS="LQ",%ZIS("S")="I $E($G(^%ZIS(2,+$G(^(""SUBTYPE"")),0)),1,4)=""C-VT""" D ^%ZIS S DV=ION I POP S NODV=1 Q
 I $G(IOST)'["C-VT" W !,$C(7),"Improper device selected. Try again!",! G DEV
 K DPTR,DEVSB,DEVSB1,DIQ
 I $D(IO("Q")) D QUE,^%ZISC Q
 U IO D:$G(TCK)'="T" ANAME^PSOBGMGR D:$G(TCK)="T" TICKET^PSOBGMGR D ^%ZISC
 Q
QUE ;que job
 S (ZTSAVE("PSOSITE"),ZTSAVE("DEV"),ZTSAVE("ZV"),ZTSAVE("ZH"),ZTSAVE("PSOUT"),ZTSAVE("FLG"),ZTSAVE("TOP"),ZTSAVE("BOT"),ZTSAVE("VOFF"))=""
 S (ZTSAVE("VON"),ZTSAVE("COLM"),ZTSAVE("DWT"),ZTSAVE("NWT"),ZTSAVE("ADA"),ZTSAVE("FTX"),ZTSAVE("STOP"),ZTSAVE("TCK"))=""
 S ZTIO=DV,ZTRTN=$S($G(TCK)'="T":"ANAME^PSOBGMGR",1:"TICKET^PSOBGMGR"),ZTDESC="Run Bingo Board Display"
 D ^%ZTLOAD
 I $D(ZTSK) S TASK=ZTSK D
 .S DA=ADA,DR="15////"_TASK_"",DIE="^PS(59.3," L +^PS(59.3,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) E  W !!,$C(7),"File is being edited!",! Q
 .D ^DIE K DIE,DR L -^PS(59.3,DA)
 I $D(ZTSK)[0 W !!?5,"Auto-start aborted!"
 E  W !!?5,"Bingo Board has been queued!"
 S:$D(ZTQUEUED) ZTREQ="@"
 D HOME^%ZIS
 Q

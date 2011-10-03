PSOBGMGR ;BHAM ISC/LC - BINGO BOARD MANAGER ;2/15/06 1:03pm
 ;;7.0;OUTPATIENT PHARMACY;**12,232,268**;DEC 1997;Build 9
 ;
 ;PSO*232 add check for bad ATIC xref and cleanup
 ;
CODE D:'$D(PSOPAR) ^PSOLSET G:'$D(PSOPAR) END
 S:$P($G(^PS(59,PSOSITE,1)),"^",20)'="" DGP=$P($G(^PS(59,PSOSITE,1)),"^",20)
 G ERASE:$G(FLAG)=3,STOPIT:$G(FLAG)=2,DISP:$G(FLAG)=1
TEST S DIK="^PS(52.11," F TEST=0:0 S TEST=$O(^PS(52.11,TEST)) Q:'TEST  D
 .S TEST1=$P($P($G(^(TEST,0)),"^",5),".") I $G(TEST1)<DT S DA=TEST D ^DIK
 K DIK,TEST,TEST1
BEGI S ROLL=1,(ZV,ZH,PSOUT,FLG)=0 I $G(IOST(0))']"" W !,"Please check Device Type and try again" Q
 S X="IODHLT;IODHLB;IORVOFF;IORVON" D ENDR^%ZISS S TOP=IODHLT,BOT=IODHLB,VOFF=IORVOFF,VON=IORVON K IODHLT,IODHLB,IORVOFF,IORVON,DIC
 S:$G(DGP) DIC("B")=DGP S (DIC,DIE)=59.3,DIC(0)="AEQMZ" D ^DIC K DIC Q:+Y'>0  S (ADA,DA)=+Y
 I $P($G(^PS(59.3,ADA,3)),"^")=1,'$G(^PS(59.3,ADA,"STOP")) W !,"Board has already been started!",$C(7) G END
 S COLM=$P($G(^PS(59.3,ADA,3)),"^",5),DWT=$P($G(^(3)),"^",6),NWT=$P($G(^(3)),"^",7)
 S FTX="PRESCRIPTIONS ARE READY FOR:"
 S ^PS(59.3,ADA,"STOP")=0,STOP=0 S TCK=$P(^PS(59.3,ADA,0),"^",2) I $G(TCK)="T" D TICKDV G END
 D DEV^PSOBGMG1 W:$G(NODV) !,"No device selected." G END
ANAME G:$G(^PS(59.3,ADA,"STOP")) END H:ZV 20
 I $P($G(^PS(59.3,ADA,3)),"^")=1&($P($G(^PS(59.3,ADA,3)),"^",4)'="") D
 .D NOW^%DTC S:$E($P($G(%),".",2),1,4)'<$E($P($P($G(^PS(59.3,ADA,3)),"^",4),".",2),1,4) ^PS(59.3,ADA,"STOP")=1,STOP=1 D:STOP ASTOP^PSOBGMG2
 D:$G(DWT) WAIT^PSOBGMG1
 W @IOF F NOTE=0:0 S NOTE=$O(^PS(59.3,ADA,2,NOTE)) Q:'NOTE!($G(^PS(59.3,ADA,"STOP")))  S NOTES=^PS(59.3,ADA,2,NOTE,0) W !?2,TOP,NOTES,!?2,BOT,NOTES H 3
 G:$G(^PS(59.3,ADA,"STOP")) END W @IOF
 I $G(DWT) S DX=1,DY=1 X IOXY W TOP,TTX,!?1,BOT,TTX,!
 S DX=1,DY=1 S:$G(DWT) DY=3 X IOXY W TOP,FTX S DY=DY+1 X IOXY W BOT,FTX,!
 S ZH=$S($G(COLM):1,1:10),ZV=4 S:$G(DWT) ZV=6
 S NAME="" F  S NAME=$O(^PS(52.11,"ANAM",ADA,NAME)) Q:""[NAME!($G(^PS(59.3,ADA,"STOP")))  D
 .I '$G(COLM) D INDX^PSOBGMG1 I ZV>18 D
 ..H 20 W @IOF I $G(DWT) S DX=1,DY=1 X IOXY W TOP,TTX,!?1,BOT,TTX,!
 ..S DX=1,DY=1 S:$G(DWT) DY=3 X IOXY W TOP,FTX S DY=DY+1 X IOXY W BOT,FTX,! S ZV=4,ZH=10 S:$G(DWT) ZV=6
 .I $G(COLM) D INDX^PSOBGMG1 I ZV>18,ZH>39 D
 ..H 20 W @IOF I $G(DWT) S DX=1,DY=1 X IOXY W TOP,TTX,!?1,BOT,TTX,!
 ..S DX=1,DY=1 S:$G(DWT) DY=3 X IOXY W TOP,FTX S DY=DY+1 X IOXY W BOT,FTX,! S ZV=4,ZH=1 S:$G(DWT) ZV=6
 .I $G(COLM),ZH>39 S ZV=ZV+2,ZH=1
 .S DX=ZH,DY=ZV X IOXY W TOP,$E(NAME,1,18) S DY=DY+1 X IOXY W BOT,$E(NAME,1,18),! S:'$G(COLM) ZV=ZV+2 S:$G(COLM) ZH=ZH+20 Q:$G(^PS(59.3,ADA,"STOP"))
 G:$G(^PS(59.3,ADA,"STOP")) END Q:STOP  G ANAME
TICKDV D DEV^PSOBGMG1 W:$G(NODV) !,"No device selected." G END
TICKET G:$G(^PS(59.3,ADA,"STOP")) END H:ZV 20
 I $P($G(^PS(59.3,ADA,3)),"^")=1&($P($G(^PS(59.3,ADA,3)),"^",4)'="") D
 .D NOW^%DTC S:$E($P($G(%),".",2),1,4)'<$E($P($P($G(^PS(59.3,ADA,3)),"^",4),".",2),1,4) ^PS(59.3,ADA,"STOP")=1,STOP=1 D:STOP ASTOP^PSOBGMG2
 D:$G(DWT) WAIT^PSOBGMG1
 W @IOF F NOTE=0:0 S NOTE=$O(^PS(59.3,ADA,2,NOTE)) Q:'NOTE!($G(^PS(59.3,ADA,"STOP")))  S NOTES=^PS(59.3,ADA,2,NOTE,0) W !?2,TOP,NOTES,!?2,BOT,NOTES H 3
 G:$G(^PS(59.3,ADA,"STOP")) END W @IOF
 I $G(DWT) S DX=1,DY=1 X IOXY W TOP,TTX,!?1,BOT,TTX,!
 S DX=1,DY=1 S:$G(DWT) DY=3 X IOXY W TOP,FTX S DY=DY+1 X IOXY W BOT,FTX,!
 S ZH=$S($G(COLM):1,1:15),ZV=4 S:$G(DWT) ZV=6
 S TICK="" F  S TICK=$O(^PS(52.11,"ATIC",ADA,TICK)) Q:'TICK!($G(^PS(59.3,ADA,"STOP")))  D
 .;check for Bad records and kill orphaned xrefs             PSO*232
 .I $$ATICCHK(ADA,TICK) Q
 .I ZV>20 D
 ..H 20 W @IOF I $G(DWT) S DX=1,DY=1 X IOXY W TOP,TTX,!?1,BOT,TTX,!
 ..S DX=1,DY=1 S:$G(DWT) DY=3 X IOXY W TOP,FTX S DY=DY+1 X IOXY W BOT,FTX,! S ZV=4,ZH=$S($G(COLM):1,1:15) S:$G(DWT) ZV=6
 .I $G(COLM),ZH>16 S ZV=ZV+2,ZH=1
 .S DX=ZH,DY=ZV X IOXY W TOP,TICK S DY=DY+1 X IOXY W BOT,TICK,! S:'$G(COLM) ZV=ZV+2 S:$G(COLM) ZH=ZH+8
 G:$G(^PS(59.3,ADA,"STOP")) END I '$G(COLM),ZV<6 H 20
 I ($G(COLM))&(ZV<6)&(ZH<39) H 20
 G TICKET
STOPIT K DIC S:$G(DGP) DIC("B")=DGP S (DIC,DIE)=59.3,DIC(0)="AEQMZ" D ^DIC K DIC Q:+Y'>0  S (ADA,DA)=+Y
 I $G(^PS(59.3,ADA,"STOP")) W !!,$C(7),"Board has already been stopped."
 I  S DIR("A")="Do you want to purge the remaining entries for this display group",DIR(0)="YO",DIR("B")="N" D ^DIR K DIR G:$G(DIRUT) STOPEX G:Y PRG I 'Y W !!,"No data purged." G STOPEX
 S ^PS(59.3,ADA,"STOP")=1,STOP=1 W !!,"Board Stopped!!",!!
CNT S CNT1=0 F CNT=0:0 S CNT=$O(^PS(52.11,CNT)) Q:'CNT  S:$P($G(^PS(52.11,CNT,0)),"^",3)=ADA CNT1=CNT1+1
 I 'CNT1 W !!,"There are no entries to purge from the display group.",! G STOPEX
 W !!,$C(7),CNT1," entries still remain in the display group.",!
PRG K DIR S DIR(0)="YO",DIR("A")="Purge this display's data now",DIR("B")="N" D ^DIR K DIR G:$D(DIRUT) STOPEX I 'Y W !!,"No data purged." G STOPEX
 W !!,"Purging data. Please wait."
 S DIK="^PS(52.11,",DA=0 F  S DA=$O(^PS(52.11,DA)) Q:'DA  D:$P($G(^PS(52.11,DA,0)),"^",3)=ADA ^DIK
 W "   Purge complete!",!
STOPEX K ADA,AS,CNT,CNT1,DA,DIK,DIRUT,FLAG,STOP,Y Q
DISP W !! K DIC,DA,DR
 S (DIC,DIE,DLAYGO)=59.3,DIC(0)="AELQMZ" D ^DIC K DIC G:+Y'>0 DISPEX S (ADA,DA)=+Y I $G(^PS(59.3,ADA,"STOP"))=0 W !!,$C(7),"This display group has been started.",!,"It must be stopped before you can edit it." G DISPEX
 W !! S DR="[PSO DISPLAY EDIT]",DIE("NO^")="BACKOUTOK" L +^PS(59.3,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) G:'$T DISPEX1
 D ^DIE G:'$D(DA) DISP L -^PS(59.3,DA) G:'$D(^PS(59.3,DA,2,0)) DISP G:$G(DIRUT) DISPEX1
 ;
 I '$D(Y),$P($G(^PS(59.3,DA,0)),"^",4),$P($G(^PS(59.3,DA,3)),"^") K DIR S DIR(0)="Y",DIR("A")="Do you want to initialize auto-start now",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT) DISPEX1 S EDT=Y
 I $G(EDT) D STRTM^PSOBGMG2 G:'$G(EDT) DISPEX1 D INIJ^PSOBGMG2
DISPEX1 K EDT,DIE,DIR,DR Q
 ;
ATICCHK(DV,TK) ;check ATIC xref if points to non-existent recs, then cleanup
 ; Return 0 - if no cleanup
 ;        1 - if had to cleanup
 ;       
 Q:($G(DV)="")!($G(TK)="") 0
 N QT,P52 S P52=$O(^PS(52.11,"ATIC",DV,TK,"")),QT=0
 ;if record pointed to is no longer on file (probably deleted),
 ;then insure no orphanned xrefs
 I '$D(^PS(52.11,P52)) D  S QT=1
 . K ^PS(52.11,"ATIC",DV,TK,P52)
 . K ^PS(52.11,"ANAMK",P52)
 . K ^PS(52.11,"ANAM",DV,TK,P52)
 . K ^PS(52.11,"C",TK,P52)
 . K ^PS(52.11,"AD",DV,P52)
 . N PA,PAI
 . S PA="" F  S PA=$O(^PS(52.11,"ANAM",DV,PA)) Q:PA=""  D
 . . S PAI="" F  S PAI=$O(^PS(52.11,"ANAM",DV,PA,PAI)) Q:PAI=""  D
 . . . I PAI=P52 K ^PS(52.11,"ANAM",DV,PA,PAI)
 Q QT
 ;
TEXT ;display text about setting up dedicated device
 W !!,"In order to automatically start and stop the bingo board monitor,"
 W !,"a dedicated device must be setup by your IRM Service.",!!
 W "Once a dedicated device is setup, the bingo board can be scheduled"
 W !,"to automatically start and/or stop at user-defined times."
 W !!,"Enter 'NO' at the DISPLAY SETUP HELP TEXT prompt to not display this help text.",!
 Q
 ;
 K ^UTILITY($J,"W") S DIWL=1,DIWR=40,DIWF="C40" F NODE=0:0 S NODE=$O(^PS(59.3,DA,2,NODE)) Q:'NODE  S X=^(NODE,0) D ^DIWP
 F NODE=0:0 S NODE=$O(^UTILITY($J,"W",1,NODE)) Q:'NODE  S NODE1=^(NODE,0) S ^PS(59.3,DA,2,NODE,0)=NODE1,$P(^PS(59.3,DA,2,0),"^",3)=NODE,$P(^(0),"^",4)=NODE S LNODE=NODE
 N LAST F NODE=0:0 S NODE=$O(^PS(59.3,DA,2,NODE)) Q:'NODE  S LAST=NODE
 I LAST>LNODE S DA(1)=DA,DIK="^PS(59.3,"_DA(1)_",2,",DA=LNODE F  S DA=$O(^PS(59.3,DA(1),2,DA)) Q:'DA  D ^DIK
 G DISP
DISPEX K ADA,DA,FLAG,LAST,LNODE,NODE,NODE1,^UTILITY($J,"W"),X,Y Q
ERASE S REC=$O(^PS(52.11,0)) I 'REC W !!,"All data has been purged!" K REC Q
 W !! K DIR S DIR("A")="Purge patient data for all or a specific display group",DIR(0)="SBO^A:All display groups;S:Specific display group"
 S DIR("?")="Enter 'A' to delete all patient data from all display groups.",DIR("?",1)="Enter 'S' to delete all patient data from a specific display group." D ^DIR K DIR G:$G(DIRUT) END1 S AS=Y K Y
 S:$G(DGP) DIC("B")=DGP
 G:AS="A" ALL S DIC=59.3,DIC(0)="AEQMZ" D ^DIC K DIC G:+Y'>0 ERASE S ADA=+Y K Y D CNT G ERASE
ALL W !!,$C(7),"*** THIS WILL PURGE ALL BINGO BOARD PATIENT DATA FOR ALL DISPLAY GROUPS. ***",!!
 S DIR(0)="YO",DIR("A")="Purge now",DIR("B")="N" D ^DIR K DIR G:$G(DIRUT) ERASE W:Y !!,"Purging data.  Please wait..." I 'Y W !!,"No data purged!" G ERASE
PUR S DIK="^PS(52.11,",DA=0 F  S DA=$O(^PS(52.11,DA)) Q:'DA  D ^DIK
 K DIR,DIK,DA W "   Purge complete.",! G ERASE
END S ZTREQ="@" I $G(ADA)'="" S:$G(^PS(59.3,ADA,"STOP")) STOP=1
END1 K ADA,AGROUP,BIG,BIGO,BOT,CNT,CNT1,DA,DGP,DR,FLAG,GROUP,NOTE,NAME,NOTES,PSOUT,ROLL,TICK,TOP,X,X1,Y,ZV,ZH,TCK,FTX,COLM,DIWF,DIWL,DIWR,FLG,VOFF,VON
 K %,%ZIS,AWT,AWT1,AWT2,BBH,BBM,DEV,DLAYGO,DTOUT,DV,DWT,DX,DY,EN,IOXY,NTXT,NUM,NWT,POP,TASK,TTX,WTT
 I $G(STOP) K STOP W @IOF D ^%ZISC G H^XUS
 K STOP Q

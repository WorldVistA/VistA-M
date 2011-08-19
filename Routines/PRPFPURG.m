PRPFPURG ;CTB/WASH-ISC@ALTOONA  PATIENT FUNDS PURGE ;3/18/97  1:49 PM
V ;;3.0;PATIENT FUNDS;**6,9**;JUNE 1, 1989
 N PERCENT,MIN,SEC,TIME,DX,DY,HOURS,TREC,LREC,LINE,DA,LASTENT,XPOS,A,BTIME,XCOUNT,COUNT,LASTARCH,PURGDATE,RETURN,LY
 W @IOF,!!!
 S %A="This program will summarize and remove entries from the Patient Funds card and",%A(1)="make a BALANCE CARRIED FORWARD entry for the summarized amount.",%A(2)="OK to Continue",%=1 D ^PRPFYN
 Q:%'=1
 S LASTARCH=$O(^PRPF(470.9,"AC",0))
 I LASTARCH="" S X="This data has never been archived, purging cannot be accomplished until the archive is completed.*7" D MSG^PRPFU1 S X="No action taken.*7" D MSG^PRPFU1 QUIT
 S LASTARCH=10000000-LASTARCH,Y=LASTARCH,LY=$$FMADD^XLFDT(DT,-400) S:Y>LY Y=LY S %DT(0)=-Y D D^PRPFU1 ; By REW for 3*9
DT S %DT("B")=$P(Y,"@") W !!,"The Summarize Through date must be no later than "_%DT("B"),!,"  --  the earlier of 400 days before today and the date of the latest archive.",!
 S %DT="AEXP",%DT("A")="Select the desired Summarize Through date: "
 D ^%DT K %DT(0) Q:Y<0  ; By REW for 3*9
DTZ ;W !! S %DT="AEXP",%DT("A")="Select ending date for summarization: ",%DT("B")=$P(Y,"@") D ^%DT Q:Y<0
 ; I Y>LASTARCH S Y=LASTARCH D D^PRPFU1 S X="The date you selected exceeds the last archive date of "_Y_".  You may NOT purge data that has not been archived.*7" D MSG^PRPFU1 G DT ; can no longer happen! rew 3*9
 S PURGDATE=$P(Y,".")
 S TREC=$P(^PRPF(470,0),"^",4)
 ; G DONE???? rather than Q: ????????? why did I ever want to ??????
 Q:TREC<1  ; By REW for 3*9  QUIT:TREC=0
 S MESSAGE="Loading Purgemaster for Patient Funds purge.  ITEMS BEING PROCESSED = DAYS"
 D BEGIN^PRPFU
 S DA=0 F  D  S XCOUNT=XCOUNT+COUNT D:'$D(ZTQUEUED) PERCENT^PRPFU Q:'DA
 . F COUNT=1:1:LREC S DA=$O(^PRPF(470,DA)) S:'DA COUNT=COUNT-1 Q:'DA  D ADD^PRCGPM1("ONE^PRPFPUR1",DA_","_PURGDATE,.RETURN)
 . QUIT
 K X S $P(X," ",40)=""
 W !!!!,"100% complete."_$P(X," ",1,40),!
 D:$G(XPDNM)="" KILL^%ZISS
X W !! S X="For PurgeMaster to run, you must execute the PRCG PURGEMASTER SITE EDIT option and then schedule the PRCG PURGEMASTER (TASKMANAGER) option to run daily."
 D MSG^PRPFQ
 ;DONE  --  was label of next line
 D ADD^PRPFARC("PURGE",PURGDATE)
 QUIT
 ;
OT ;OPTION TERMINATED
 S X="  <Option Terminated, No Action Taken.>*" D MSG^PRPFU1
 Q

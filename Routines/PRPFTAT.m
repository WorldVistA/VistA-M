PRPFTAT ;ALTOONA/CTB  REVIEW STATUS ON ALL PATIENT FUNDS ACCOUNTS ;4/25/97  8:29 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
UPDAT W !,"This routine will insert the Active/Inactive indicator into the file for",!,"each patient based upon the following:",!!?5,"Balance not zero  -  ACTIVE"
 W !?5,"Zero Balance - Last Transaction less than 30 days  -  ACTIVE"
 W !?5,"Zero Balance - Last Transaction more than 30 days  -  INACTIVE"
 W !?5,"Zero Balance - No Transactions  -  INACTIVE"
 W !!,"The system will automatically convert the status to ACTIVE when any transaction",!,"is entered into the account."
 W "  Finally, this program will print a report showing all accounts on which the STATUS was changed.",! S %A="ARE YOU READY TO CONTINUE",%B="",%=1 D ^PRPFYN
 I %=1 S ZTRTN="ALL^PRPFTAT",ZTDESC=$P($T(ALL),";",3) D ^PRPFQ
OUT K %,%X,BAL,DA,DATE,DFN,DG1,DGT,DGX,DIJ,DP,IOY,NEW,OLD,TDATE,X,Y,ZTQUEUED Q
ALL ;;UPDATE THE 'ACTIVE'/'INACTIVE' STATUS OF ALL ACCOUNTS
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D WAIT^PRPFYN
 S %DT="",X="T-30" D ^%DT S TDATE=Y K %DT,%H,%I,^PRPF(470,"AJ","Y") F DA=0:0 S DA=$O(^PRPF(470,DA)) Q:'DA  S OLD="" S:$D(^(DA,0)) OLD=$P(^(0),"^",2) D CHECK
 I '$D(^TMP("PRPFAJ",$J)) W @IOF,!,"PATIENT FUNDS CHANGE IN ACCOUNT STATUS LISTING" S Y=DT D D^PRPFU1 W ?$X+10,Y,!!,"No change required in any account." W:$D(ZTSK) @IOF Q
 S IOP=$S($D(PRIOP):PRIOP,1:ION),DIC="^PRPF(470,",L=0,L(0)=1,BY=".01",(FR,TO)="",BY(0)="^TMP(""PRPFAJ"",$J,",FLDS="[PRPF NEW ACCOUNT STATUS]",DIOEND="K ^TMP(""PRPFAJ"",$J)"
 D EN1^DIP
 D DIKILL^PRPFQ Q
CHECK ;THIS LINE CHECKS THE CURRENT STATUS OF THE ACCOUNT AND UPDATES THE
 ;STATUS WHEN NECESSARY
 Q:'$D(^PRPF(470,DA,0))  S DATE=$P(^PRPF(470,DA,0),"^",11),BAL=0 S:$D(^(1)) BAL=$P(^(1),"^",4)
 I +BAL'=0 Q:OLD="A"  S NEW="A" G CR
 I DATE<TDATE Q:OLD="I"  S NEW="I" G CR
 Q:OLD="A"  S NEW="A" G CR
 Q
CR S ^TMP("PRPFAJ",$J,DA)="",$P(^PRPF(470,DA,0),"^",2)=NEW,^PRPF(470,"AC",NEW,DA)="" K:OLD'="" ^PRPF(470,"AC",OLD,DA) Q

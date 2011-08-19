RGVCCMR1 ;GAI/TMG-CMOR ACTIVITY SCORE GENERATOR (PART 1) ;01/15/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**2,19**;30 Apr 99
 ;Reference to ^DPT("ACMORS" and ^DPT(0 supported by IA #2070
 ;
EN ;  this routine contains entry points to start/restart the batch cmor
 ;  score initialization, flag a running
 ;  initialization to stop, calculate and file an activity score for an
 ;  individual patient, and display the status of the cmor initialization 
START ; entry point to start or restart the cmor activity score initialization
 N RGY
 S U="^"
 S NODE=$G(^RGSITE(991.8,1,"CMOR"))
 I '(+$P(NODE,U)) D  G QUIT
 .W !!,"This is the initial run of the CMOR patient activity score generator."
 .S RUNTYPE="I",RGDFN=0 D TASK
 S STATUS=$P(NODE,U,7)
 I STATUS="R" D  I RUN G QUIT
 .S RUN=0
 .S ZTSK=+$P(NODE,U,9)
 .I 'ZTSK D INT Q
 .D STAT^%ZTLOAD
 .I ZTSK(1)=0!(ZTSK(1)=3)!(ZTSK(1)=4) D INT Q
 .I ZTSK(1)=1 W !!,"CMOR Patient Activity Score queued task #",ZTSK,!,"is waiting to run.  Do not start another job at this time." S RUN=1 Q
 .I ZTSK(1)=2 W !!,"CMOR Patient Activity Score queued task #",ZTSK,!,"is currently running.  Do not start another job at this time." S RUN=1 Q
 .I ZTSK(1)=5 W !!,"CMOR Patient Activity Score queued task #",ZTSK,!,"was interrupted abnormally, possibly from a system error." D INT
 I STATUS="SN" D
 .S STOPDT=$P(NODE,U,3) I +STOPDT D
 ..S STOPDT=$$FMTE^XLFDT(STOPDT,"1P")
 ..W !!,"The CMOR patient activity score generator",!,"completed successfully on ",STOPDT,"."
 .W !
 .S DIR(0)="Y",DIR("A")="Would you like to reset all patient activity scores",DIR("B")="N" D ^DIR S RGY=Y
 .I RGY=1 S DIR(0)="Y",DIR("A")="This will take quite a while.  Are you sure",DIR("B")="N" D ^DIR S RGY=Y
 .I RGY=1 S RUNTYPE="R",RGDFN=0 D TASK
 I STATUS="SM"!(STATUS="INT") D 
 .S STOPDT=$P(NODE,U,3) D
 ..I +STOPDT S STOPDT=$$FMTE^XLFDT(STOPDT,"1P")
 ..W !!,"The CMOR patient activity score generator was "
 ..W:STATUS="SM" ! W $S(STATUS="SM":"STOPPED MANUALLY",1:"INTERRUPTED ABNORMALLY.") I STATUS="SM" W " on ",STOPDT,"."
 .I +$P(NODE,U) D
 ..S LASTDFN=$P(NODE,U),LASTPT=$P($G(^DPT(+LASTDFN,0)),U),LASTSSN=$P(^(0),U,9)
 ..W !,"The last patient processed was ",LASTPT,"   SSN: ",LASTSSN,!?31,"[RECORD# ",LASTDFN,"]"
 .W ! S DIR(0)="Y",DIR("A")="Would you like to start with this patient and continue",DIR("B")="N" D ^DIR S RGY=Y
 .W ! I RGY=1 D
 ..S DIR(0)="Y",DIR("A")="This will take quite a while.  Are you sure"
 ..S DIR("B")="N" D ^DIR I Y=1 S RUNTYPE="RS",RGDFN=LASTDFN D TASK
 .W ! I RGY=0 D
 ..S DIR(0)="Y",DIR("A")="Would you like to rerun the CMOR calculation for all patients"
 ..S DIR("B")="N" D ^DIR I Y=1 D
 ...W ! S DIR(0)="Y",DIR("A")="This will take quite a while.  Are you sure",DIR("B")="N" D ^DIR I Y=1 S RUNTYPE="RS",RGDFN=0 D TASK
 G QUIT
STOP ;  entry point to flag a running cmor score initialization to stop
 S U="^"
 S NODE=$G(^RGSITE(991.8,1,"CMOR"))
 I $P(NODE,U,7)'="R" W !,"The CMOR activity score generation is NOT running." G QUIT
 W !,"This option will stop the CMOR patient activity score generation"
 W !,"after it has completed calculating and filing the score for the current"
 W !,"patient."
 W ! S DIR("A")="Are you sure you want to do this",DIR("B")="N",DIR(0)="Y" D ^DIR K DIR S RGY=Y
 W ! S DIR("A")="Stop patient activity score generation after the current patient",DIR("B")="N",DIR(0)="Y" D ^DIR S RGY=Y
 ;I RGY=1 S DA=1,DIE="^RGSITE(991.8,",DR="21////Y;24////SM" D ^DIE
 I RGY=1 D
 .S $P(^RGSITE(991.8,1,"CMOR"),U,4)="Y"
 .W !!,"CMOR patient activity generation is flagged to stop after"
 .W !,"it has completed the current patient.  This may take a short time."
 .W !,"Please check the status later."
 G QUIT
INDIV ;  entry point to allow a cmor score for an individual patient to be
 ;  calculated and filed
 N MNODE
 S U="^"
 S DIC="^DPT(",DIC(0)="AEQMNZ" D ^DIC K DIC Q:+Y<0  S RGDFN=+Y
 S PTNAM=$P(Y(0),"^"),SSN=$P(Y(0),"^",9),FILE=1
 S MNODE=$$MPINODE^MPIFAPI(RGDFN)
 I $P($G(MNODE),U,7)'="" D
 .S FILE=0
 .S SCOREDT=$$FMTE^XLFDT($P(MNODE,U,7),"1P")
 .S CURSCORE=$P(MNODE,U,6) W !!,"This patient has an existing CMOR score of ",+CURSCORE," calculated on ",SCOREDT,".",!
 .S DIR(0)="Y",DIR("A")="Do you want to calculate and file a new score for this patient",DIR("B")="NO" D ^DIR I Y=1 S FILE=1
 I FILE=1 D
 .W !!,"Working.  Please standby..." S FILEFLG=0 D CALCI^RGVCCMR2
 .I 'FILEFLG W !!,"No Patient Activity in the Past Three Years - No Score Filed!" Q
 .W !!,"CMOR Activity Score: ",SCORE," filed for ",PTNAM,"  SSN: ",SSN,"."
 G QUIT
DISPLAY ;  displays the status of the background cmor score initialization
 W !,"The CMOR Activity Score Generator",!
 ;count number of CMOR scores"
 W !,"..one moment please...",!
 S (SCORE,CNT)=0
 F  S SCORE=$O(^DPT("ACMORS",SCORE)) Q:'SCORE  D
 .S RGDFN=0 F  S RGDFN=$O(^DPT("ACMORS",SCORE,RGDFN)) Q:'RGDFN  D
 ..S CNT=CNT+1
 W !,"There are ",$P(^DPT(0),U,4)," records in your PATIENT file."
 W !,"The last record number is ",$P(^DPT(0),U,3),"."
 I $P($G(^RGSITE(991.8,1,"CMOR")),U)'="" D CHKSTAT
 I $P($G(^RGSITE(991.8,1,"CMOR")),U)="" D
 . W !,"The CMOR Calculation has NEVER been run on your system."
 G QUIT
CHKSTAT S NODE=$G(^RGSITE(991.8,1,"CMOR"))
 S PTNAM="-Unknown-",SSN="---"
 S RGDFN=+NODE I RGDFN,$D(^DPT(RGDFN,0)) D
 .S PTNAM=$P(^(0),U),SSN=$P(^(0),U,9)
 S OSTARTED="UNSPECIFIED" I $P(NODE,U,2)'="" D
 .S OSTARTED=$$FMTE^XLFDT($P(NODE,U,2),"1P")
 S OSTOPPED="UNSPECIFIED" I $P(NODE,U,3)'="" D
 .S OSTOPPED=$$FMTE^XLFDT($P(NODE,U,3),"1P")
 S ORESTART=$G(^XTMP("RGVCCMR","@@@@","RESTARTED"))
 I +ORESTART S ORESTART=$$FMTE^XLFDT(ORESTART,"1P")
 S ODFNCT=""
 I $D(^XTMP("RGVCCMR","@@@@","DFNCOUNT")) S ODFNCT=^XTMP("RGVCCMR","@@@@","DFNCOUNT")
STATUS S ST=$P(NODE,U,7)
 ;if status is RUNNING, check to see if task errored out
 I ST="R" D
 .S ZTSK=$P(NODE,U,9) I $D(ZTSK) D
 ..D STAT^%ZTLOAD
 ..I ZTSK(1)=5 D INT S ST="INT"
 S STATUS=$S(ST="R":"RUNNING.",ST="SM":"STOPPED MANUALLY",ST="SN":"SUCCESSFULLY COMPLETED",ST="INT":"INTERRUPTED ABNORMALLY.",1:"- NO STATUS LISTED -")
 ;S PERCOMP=((ODFNCT/$P(^DPT(0),U,4))*100),PERCOMP=$P(PERCOMP,".")_"."_$E($P(PERCOMP,".",2),1,2)
 W !,"Last Patient Processed: ",PTNAM,"   SSN: ",SSN,"   [RECORD# ",RGDFN,"]"
 W !!,"The CMOR score initialization last started on ",OSTARTED,"."
 I ORESTART]"" W !,"Job was restarted on ",ORESTART,"."
 I +ODFNCT W !,ODFNCT," patient records have been processed."
 W !,"Status: ",STATUS I ST'="R"&(ST'="INT") W " on ",OSTOPPED,"."
 W !,"CMOR Score Count: ",CNT
 ;
 G QUIT
 ;
INT ;Set status to INTERRUPTED for abnormally stopped jobs
 S $P(^RGSITE(991.8,1,"CMOR"),"^",7)="INT"
 S STATUS="INT"
 Q
TASK S ZTIO="",ZTRTN="^RGVCCMR2",ZTDESC="BACKGROUND CMOR SCORE CALCULATOR"
 S (ZTSAVE("RUNTYPE"),ZTSAVE("RGDFN"))=""
 ; change ztsave("*")="" to specific variables when done
 D ^%ZTLOAD
 I $D(ZTSK) W "   Task#, ",ZTSK," queued" S $P(^RGSITE(991.8,1,"CMOR"),U,9)=ZTSK
 D ^%ZISC
 Q
QUIT K RGDFN,DIC,DIR,FILE,LASTDFN,LASTPT,LASTSSN,ODFNCT,ORESTART,OSTARTED
 K OSTOPPED,PTNAM,RUNTYPE,SCORE,SSN,ST,STATUS,X,Y,%DT,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K CURSCORE,SCOREDT,NODE,STOPDT,FILEFLG,SCORE,CNT,RGDFN,RUN
 ;kill variables leftover from the CALI^RGVCCMR2 entry point
 K LRCODE,DA,DR,DIE,APSTDT,LRCODE,LRSCORE,NXPC,NXPTF,NXSCE,NXRX,NXXR,PCCODE,PSOVER,PTF0,RXDT,STDT,XRCODE,XRSTDT,YR
 Q

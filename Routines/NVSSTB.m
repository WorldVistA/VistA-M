NVSSTB ;slciofo/mdb-options for VMS/Cache systems to start TM/Broker/MailMan;
 ;;2.0;EMC SYSTEM UTILITIES; Apr 28, 2003
 ;
 ;Options to manually start and stop Taskman, Broker Listener(s) and the
 ;network mail background listener.
 ;
 ; *****NOTE*****
 ; additions made by MW@VISN20 on 9/9/04 to include options to
 ; stop TaskMan and Broker listener(s).
 ; 
 ; modified listing to indicate instance per item    jls             1/21/06  NOON
 ; 
 ; **************
 ;
 ; the function OS^%ZOSV is not present in DSM systems, check for DSM system...
 I $ZV'["Cache for OpenVMS" W !,"This routine is for Cache systems only." Q
 ; VMS/Cache only...
 I $$OS^%ZOSV()'="VMS" W !,"This routine is for VMS/Cache systems only." Q
 ;
 I $G(IOF)="" D HOME^%ZIS
 S NVSNODE=$ZU(110)
 S NVSVOL=$ZU(5)
 S NVSCFG=$P($ZU(86),"*",2)
 F  D  Q:$D(DIRUT)
 .I $G(IOF)'="" W @IOF
 .W !!,$$CJ^XLFSTR("START/STOP BROKER LISTENER(S), TASK MANAGER AND NETWORK MAIL LISTENER",80)
 .W !!,$$CJ^XLFSTR("** NOTE **",80)
 .W !,$$CJ^XLFSTR("Task Manager and any Broker listener(s) on this node",80)
 .W !,$$CJ^XLFSTR("must be started by a call to a VMS command file to insure that",80)
 .W !,$$CJ^XLFSTR("these processes are started with the appropriate privileges.",80)
 .W !,$$CJ^XLFSTR("**********",80)
 .W !!?3,"Current Node : ",NVSNODE
 .W !?3,"Namespace    : ",NVSVOL
 .W !?3,"Cache Config : ",NVSCFG
 .S DIR(0)="NA^1:7"
 .S DIR("A",1)="   1 = Start Task Manager for config "_NVSCFG_" on node "_NVSNODE
 .S DIR("A",2)="   2 = Start Broker Listener(s) for config "_NVSCFG_" on node "_NVSNODE
 .S DIR("A",3)="   3 = Start Network Mail Listener for config "_NVSCFG_" on node "_NVSNODE
 .S DIR("A",4)="   4 = Start All (TM, Broker, Network Mail) for config "_NVSCFG_" on node "_NVSNODE
 .S DIR("A",5)="   5 = Stop Task Manager and Sub-managers for config "_NVSCFG_" on node "_NVSNODE
 .S DIR("A",6)="   6 = Stop Broker Listener(s) for config "_NVSCFG_" on node "_NVSNODE
 .S DIR("A",7)="   7 = Exit"
 .S DIR("A",8)=" "
 .S DIR("A")="  Select OPTION NUMBER (1-7): "
 .S DIR("B")=7
 .S DIR("?")="or enter ""^"" to exit."
 .S DIR("?",1)="?? Please enter an OPTION NUMBER, 1 through 7"
 .W ! D ^DIR K DIR
 .I Y=7 S DIRUT=1
 .I $D(DIRUT) Q
 .S NVSANS=Y
 .I NVSANS=1 D TM Q
 .I NVSANS=2 D BL Q
 .I NVSANS=3 D ML Q
 .I NVSANS=4 D  Q
 ..D TM
 ..D BL
 ..D ML
 .I NVSANS=5 D STM Q
 .I NVSANS=6 D SBL
 K DIRUT,DTOUT,NVSANS,NVSCFG,NVSNODE,NVSVOL,X,Y
 Q
 ;
TM ; start Task Manager...
 N DIR,DIRUT,DTOUT,X,Y
 I NVSVOL="VAH" D
 .W !!,"Submitting batch job for USER$:[CACHEMGR]TASKMAN_START.COM to start"
 .W !,"TaskMan in VAH..."
 .S X=$ZF(-1,"SUBMIT/USER=CACHEMGR/QUE=SYS$BATCH USER$:[CACHEMGR]TASKMAN_START.COM")
 I NVSVOL'="VAH" D
 .W !!,"Submitting batch job for USER$:[CACHEMGR]",NVSVOL,"_TASKMAN_START.COM to"
 .W !,"start TaskMan in ",NVSVOL,"..."
 .S X=$ZF(-1,"SUBMIT/USER=CACHEMGR/QUE=SYS$BATCH USER$:[CACHEMGR]"_NVSVOL_"_TASKMAN_START.COM")
 ;I NVSVOL="TST" S X=$ZF(-1,"SUBMIT/USER=CACHEMGR/QUE=SYS$BATCH USER$:[CACHEMGR]TST_TASKMAN_START.COM")
 ;I NVSVOL'="VAH"&(NVSVOL'="TST") W !!,$C(7),"This Configuration is not VAH or TST."
 S DIR(0)="EA"
 S DIR("A")="Press <enter> to return to the main menu..."
 W ! D ^DIR K DIR
 Q
 ;
BL ;start Broker Listeners...
 N DIR,DIRUT,DTOUT,X,Y
 I NVSVOL="VAH" D
 .W !!,"Submitting batch job for USER$:[CACHEMGR]BROKER_START.COM to start Broker"
 .W !,"listener(s) in VAH..."
 .S X=$ZF(-1,"SUBMIT/USER=CACHEMGR/QUE=SYS$BATCH USER$:[CACHEMGR]BROKER_START.COM")
 I NVSVOL'="VAH" D
 .W !!,"Submitting batch job for USER$:[CACHEMGR]",NVSVOL,"_BROKER_START.COM to"
 .W !,"start Broker listener(s) in ",NVSVOL,"..."
 .S X=$ZF(-1,"SUBMIT/USER=CACHEMGR/QUE=SYS$BATCH USER$:[CACHEMGR]"_NVSVOL_"_BROKER_START.COM")
 ;I NVSVOL="TST" S X=$ZF(-1,"SUBMIT/USER=CACHEMGR/QUE=SYS$BATCH USER$:[CACHEMGR]TST_BROKER_START.COM")
 ;I NVSVOL'="VAH"&(NVSVOL'="TST") W !!,$C(7),"This Configuration is not VAH or TST."
 S DIR(0)="EA"
 S DIR("A")="Press <enter> to return to the main menu..."
 W ! D ^DIR K DIR
 Q
 ;
ML ; start network mail listener...
 W !!,"JOBbing the routine ^XMRONT..."
 J ^XMRONT::5
 I $T'=1 W !?2,"ERROR -- the command JOB ^XMRONT failed!"
 I $T=1 W "JOB command executed successfully."
 S DIR(0)="EA"
 S DIR("A")="Press <enter> to return to the main menu..."
 W ! D ^DIR K DIR
 Q
 ;
STM ; stop Task Manager and Sub-managers...
 N DIR,DIRUT,DTOUT,NVSTMLIS,NVSTMPID,X,Y
 D TMSTAT(.NVSTMLIS)
 I +$G(NVSTMLIS)=0 D  Q
 .S DIR(0)="EA"
 .S DIR("A")="Press <enter> to return to main menu..."
 .W ! D ^DIR K DIR
 W !
 S NVSTMNOD=""
 F  S NVSTMNOD=$O(NVSTMLIS(NVSTMNOD)) Q:NVSTMNOD=""!($D(DIRUT))  D
 .S DIR(0)="YA"
 .S DIR("A")="Stop Task Manager in "_NVSTMNOD_"? "
 .S DIR("B")="NO"
 .S DIR("?")="Answer YES or NO, or enter ""^"" to abort"
 .D ^DIR K DIR
 .I $D(DIRUT) Q
 .I Y'=1 Q
 .W !?2,"stopping the manager..."
 .D SMAN^ZTMKU(NVSTMNOD)
 .S NVSTMPID=NVSTMLIS(NVSTMNOD)
 .F I=1:1:10 Q:'$D(^%ZTSCH("STATUS",NVSTMPID))  W "." H 1
 .I $D(^%ZTSCH("STATUS",NVSTMNOD)) W !?2,"ERROR -- Manager job would not stop!" Q
 .W "done."
 .W !?2,"stopping any idle sub-manager(s)..."
 .D SSUB^ZTMKU(NVSTMNOD)
 .W "done."
 K DIRUT,DTOUT,NVSTMNOD,X,Y
 S DIR(0)="EA"
 S DIR("A")="Press <enter> to return to the main menu..."
 W ! D ^DIR K DIR
 Q
 ;
TMSTAT(LIST) ; check and list current Task Manager status...
 ; LIST = an array name passed by reference into which current TM jobs are listed
 ; returns LIST=number of TM manager jobs in ^%ZTSCH("STATUS")
 ;         LIST(node name)=TM job status line from ^%ZTSCH("STATUS",pid)
 N NVSTMDAT,NVSTMPID
 S LIST=0
 W !!,"Current Task Manager status:"
 I '+$O(^%ZTSCH("STATUS",0)) D  Q
 .W $C(7)
 .W !,"**NO TASK MANAGER JOBS FOUND IN ^%ZTSCH(""STATUS"")!**"
 W !!,"Process ID"
 W ?20,"Node"
 W ?35,"Status"
 S NVSTMPID=0
 F  S NVSTMPID=$O(^%ZTSCH("STATUS",NVSTMPID)) Q:'NVSTMPID  D
 .S NVSTMDAT=^%ZTSCH("STATUS",NVSTMPID)
 .W !,NVSTMPID
 .W ?20,$P(NVSTMDAT,"^",3)
 .W ?35,$P(NVSTMDAT,"^",2)," ",$P(NVSTMDAT,"^",4)
 .S LIST=LIST+1
 .S LIST($P(NVSTMDAT,"^",3))=NVSTMPID
 .K NVSTMDAT
 Q
 ;
SBL ; stop broker listener...
 N base,maxpid,DIR,DIRUT,DTOUT,NVSBDEV,NVSBLIS,NVSBPORT,NVSJPID,NVSROU,X,Y
 ; search process table for Broker listener(s)...
 S NVSBLIS=0
 s base=$v($zu(40,2,47),-2,"S")
 s maxpid=$v($zu(40,2,118),-2,4)
 W !!,"Searching process table for any Broker listener(s) running in"
 W !,"configuration ",NVSCFG,"..."
 f i=1:1:maxpid s NVSJPID=$v(i*4+base,-3,4) I NVSJPID>0 D
 .S NVSROU=$ZU(67,5,NVSJPID)
 .I NVSROU'="XWBTCPL" K NVSROU Q
 .S NVSBDEV=$ZU(67,7,NVSJPID)
 .I NVSBDEV="" K NVSBDEV,NVSROU Q
 .S NVSBLIS=NVSBLIS+1
 .S NVSBLIS($P(NVSBDEV,"|",3))=""
 .K NVSBDEV,NVSROU
 I NVSBLIS=0 W !!,"**NO Broker listener jobs were found here!**"
 I NVSBLIS>0 D  K DIRUT,DTOUT,X,Y
 .W !!,"Broker listener job",$S(NVSBLIS>1:"s",1:"")," found on "
 .W $S(NVSBLIS>1:"these ",1:"this "),"port",$S(NVSBLIS>1:"s:",1:":")
 .S NVSBPORT=0
 .F  S NVSBPORT=$O(NVSBLIS(NVSBPORT)) Q:'NVSBPORT  W !?2,NVSBPORT
 .F  D  Q:$D(DIRUT)
 ..S DIR(0)="NA^"_+$O(NVSBLIS(0))_":"_+$O(NVSBLIS(""),-1)_"^K:'$D(NVSBLIS(X)) X"
 ..S DIR("A")="Stop Broker Listener on PORT: "
 ..I NVSBLIS=1 S DIR("B")=+$O(NVSBLIS(0))
 ..S DIR("?")="Enter a PORT NUMBER from the list above"
 ..W ! D ^DIR K DIR
 ..I $D(DIRUT) Q
 ..S NVSBPORT=+Y
 ..W !?2,"Calling STOP^XWBTCP(",NVSBPORT,")..."
 ..D STOP^XWBTCP(NVSBPORT)
 ..K NVSBPORT
 ..I NVSBLIS=1 S DIRUT=1
 S DIR(0)="EA"
 S DIR("A")="Press <enter> to return to the main menu..."
 W ! D ^DIR K DIR
 Q

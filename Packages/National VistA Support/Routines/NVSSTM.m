NVSSTM ;BJS/DALLAS OIFO  START/STOP TASKMAN FOR CACHE v2011 ; 7/23/12 3:18pm
 ;;2.0;;NVSMENU;;Build 5
 ;
 ;
 S NVSTMOS=$$OS^%ZOSV
 ;
 I $G(IOF)="" D HOME^%ZIS
 S NVSNODE=$P($ZU(110),".")
 S NVSVOL=$ZDEFNSP
 S NVSCFG=$P($ZU(86),"*",2)
 ;
 F  D  Q:$D(DIRUT)
 .I $G(IOF)'="" W @IOF
 .W !!,$$CJ^XLFSTR("START/STOP TASK MANAGER",80)
 .W !!,$$CJ^XLFSTR("** NOTE **",80)
 .W !,$$CJ^XLFSTR("Task Manager must be started by a call to",80)
 .W !,$$CJ^XLFSTR("a "_$G(NVSTMOS)_" file to insure that the process",80)
 .W !,$$CJ^XLFSTR("is started with the appropriate privileges.",80)
 .W !,$$CJ^XLFSTR("**********",80)
 .W !!?3,"Current Node : ",NVSNODE
 .W !?3,"Namespace    : ",NVSVOL
 .W !?3,"Cache Config : ",NVSCFG
 .S DIR(0)="NA^1:3"
 .S DIR("A",1)="   1 = Start Task Manager for config "_NVSCFG_" on "_NVSNODE
 .S DIR("A",2)="   2 = Stop Task Manager and Sub-managers for config "_NVSCFG_" on "_NVSNODE
 .S DIR("A",3)="   3 = Exit"
 .S DIR("A",4)=" "
 .S DIR("A")="  Select OPTION NUMBER (1-3): "
 .S DIR("B")=3
 .S DIR("?")="or enter ""^"" to exit."
 .S DIR("?",1)="?? Please enter an OPTION NUMBER, 1 through 3"
 .W ! D ^DIR K DIR
 .I Y=3 S DIRUT=1
 .I $D(DIRUT) Q
 .S NVSANS=Y
 .I NVSANS=1 D TM Q
 .I NVSANS=2 D STM Q
 K DIRUT,DTOUT,NVSANS,NVSCFG,NVSNODE,NVSVOL,NVSTMOS,X,Y
 Q
 Q
TM S U="^"
 S:'$D(DTIME) DTIME=300
CHECK D TMSTAT
 I '$G(NVSTMRUN) G NSP    ;taskman is not already running
 I $G(NVSTMRUN) D
 .K NVSTMRUN
 .W !!,"It appears Taskman is already running for config ",NVSCFG
 .K DIR S DIR(0)="Y",DIR("A")="Are you sure you want to continue?",DIR("B")="NO"
 .W ! D ^DIR K DIR
 .Q:$D(DIRUT)!(Y'=1)
 .I Y=1 G NSP
 .;
 .Q
 ;
 ;
 Q
NSP ;
 W !!,"What Namespace would you like to start Task Manager in?"
 W !,"Namespace: "_$ZDEFNSP R "// ",NVSTMNSP:DTIME
 G:$T=0 EXIT
 G:NVSTMNSP[U EXIT
 I NVSTMNSP="" S NVSTMNSP=$ZDEFNSP G START
 I NVSTMNSP["?" D HELPTM G NSP
CHKNSP ;if default NSP wasn't selected, check to make sure namespace entered is valid
 ;$ZU function to test if namespace exists
 ;I $ZU(90,10,$G(NVSTMNSP))'=1 W !!,"The namespace "_NVSTMNSP_" does not exist!",!! G NSP
 ;testing class method
 ;
 I '##Class(%SYS.Namespace).Exists(NVSTMNSP) W !!,"The namespace "_NVSTMNSP_" does not exist!",!! G NSP
 ;Namespace exists - so drop through to START
 ;	
START ;start Taskman in the identified namespace
 S DIR(0)="Y",DIR("A")="Are you ready to start Task Manager in "_NVSTMNSP,DIR("B")="Yes" D ^DIR I Y=1 G START1
 Q
START1 ;
 D TASKMAN^|"%SYS"|ZSTU(NVSTMNSP)
 W !!,"Starting Task Manager in "_NVSTMNSP_".....",!! H 3
 D EXIT
 Q
EXIT K NVSTMNSP
 Q
STM ;stop taskman
 ; *** under developement ***
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
TMSTAT(LIST) ; check and list current Task Manager status...
 ; LIST = an array name passed by reference into which current TM jobs are listed
 ;returns LIST=number of TM manager jobs in ^%ZTSCH("STATUS")
 ;LIST(node name)=TM job status line from ^%ZTSCH("STATUS",pid)
 N NVSTMDAT,NVSTMPID,NVSTMRUN
 S LIST=0
 W !!,"Current Task Manager status:"
 I '+$O(^%ZTSCH("STATUS",0)) D  Q
 .W $C(7)
 .W !,"**NO TASK MANAGER JOBS FOUND IN ^%ZTSCH(""STATUS"") FOR "_$G(NVSVOL)_"!**"
 W !!,"Process ID"
 W ?20,"Node"
 W ?35,"Status"
 S NVSTMPID=0,NVSTMRUN=1
 F  S NVSTMPID=$O(^%ZTSCH("STATUS",NVSTMPID)) Q:'NVSTMPID  D
 .S NVSTMDAT=^%ZTSCH("STATUS",NVSTMPID)
 .W !,NVSTMPID
 .W ?20,$P(NVSTMDAT,"^",3)
 .W ?35,$P(NVSTMDAT,"^",2)," ",$P(NVSTMDAT,"^",4)
 .S LIST=LIST+1
 .S LIST($P(NVSTMDAT,"^",3))=NVSTMPID
 .K NVSTMDAT
 Q
HELPTM ;
 W !!,"Please enter the name of the Namespace which you would"
 W !,"like to start Task Manager in.",!
 D LIST^%NSP
 W !,"The default Namespace for this configuration is ",$ZDEFNSP,!
 Q

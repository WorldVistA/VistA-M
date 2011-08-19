XTLATSET ;SF/RWF - BUILD SITE LT_LOAD.COM, LTPROT, and LT_PTR.DAT FILEs ;07/28/2005  16:41
 ;;7.3;TOOLKIT;**11,75,90**;Apr 25, 1995
A ;This routine sets up the files for LAT device setup
 N EXIT,OS,DIR,XTWHEN,TX,XFIO,NODE,PORT,SPEED,Q,Y,DA,XTRM,DEV,FN,VAH
 N CMDFN,DI,I,QUE,T,XTIO
 I '$D(DT) S DT=$$DT^XLFDT
 S EXIT=1 D
 . S OS=^%ZOSF("OS")
 . I OS["DSM" S EXIT=0 Q
 . I OS["OpenM",$$OS^%ZOSV["VMS" S EXIT=0 Q
 . I OS["GT.M",OS["VMS" S EXIT=0 Q
 . Q
 I EXIT W !!,"Not running on a VAX. Not a valid routine to run." G EXIT
 ;
 W !!,"This routine will build new LT_LOAD.COM, LT_PTR.DAT, TSC_LOAD.COM files"
 S DIR(0)="Y",DIR("A")="Want to proceed",DIR("A",1)="Do not use unless you are in the startup account",DIR("A",2)="where the correct VMS files are present!",DIR("B")="No",DIR("?")="See option description"
 D ^DIR G EXIT:Y'=1!$D(DIRUT)
 S IO=$I,U="^",X=$S($D(DUZ)[0:"Unknown",$D(^VA(200,DUZ,0)):$P(^(0),U,1),1:"Unknown"),XTWHEN="$! This version made on "_$$NOW^XLFDT()_", by "_X
 D GETENV^%ZOSV S VAH=$P(Y,"^",1) ;Get UCI name
 ;Open files
 F X=1,2,4 S FN=$P($T(OP+X),";;",2)  D
 . I VAH'="VAH" S FN=$P(FN,"]",1)_"]"_VAH_"_"_$P(FN,"]",2)
 . S XFIO(X)=FN,TX="TX"_X
 . D OPEN(XFIO(X))
 . U IO
 . D TX
 ;Build files
 S XTIO="_"
 F DI=0:0 S XTIO=$O(^%ZIS(1,"C",XTIO)) Q:XTIO=""  D
 . F DA=0:0 S DA=$O(^%ZIS(1,"C",XTIO,DA)) D:DA>0  Q:DA'>0
 . . S X=$S($D(^%ZIS(1,DA,0)):^(0),1:""),Y=$S($D(^("VMS")):^("VMS"),1:"")
 . . I $D(^%ZIS(1,DA,90)),^(90)>0,DT'>^(90) Q  ;OutOfService
 . . D FILE
 . . Q
 . Q
 ;Finish up and close
 U 0 W !!,"The following files have been updated:",!!
 F X=1,2,4 D
 .W !?2,XFIO(X)
 .D @("CL"_X)
 .X "C XFIO(X)"
 W !!,"To update the VMS configuration, the following COM"
 W !,"procedures must be run on your cluster:"
 W !!?2,"DO @"_XFIO(1) ; SYS$MANAGER:[VAH_]LT_LOAD.COM
 W !?2,"DO @SYS$MANAGER:SYSPRINT.COM",!
 S DIR(0)="Y",DIR("A")="Want to run them now",DIR("B")="Yes" D ^DIR
 I Y=1 D RUN
 ;
EXIT K DIR,XTWHEN,TX,XFIO,NODE,PORT,SPEED,Q,Y,DA,XTRM,DEV,OS Q
 ;
RUN ;Run the com files
 S CMDFN="SYS$MANAGER:LT_EXECUTE.COM" D OPEN(CMDFN)
 U CMDFN
 W "$! Run LT_LOAD and SYSPRINT on the cluster"
 W !,"MCR SYSMAN"
 W !,"SET E/C"
 W !,"DO @"_XFIO(1) ; SYS$MANAGER:[VAH_]LT_LOAD.COM
 W !,"DO @SYS$MANAGER:SYSPRINT.COM"
 W !,"EXIT"
 W !,"$EXIT",!
 X "C CMDFN"
 D DOCMD("PURGE "_CMDFN) ;Purge the COM file
 D DOCMD("@"_CMDFN) ;Run the COM file
 Q
 ;
OPEN(FN) ;Open file for write
 I OS["DSM" X "O FN:NEWVERSION"
 I OS["OpenM" X "O FN:(""NWS""):1"
 I OS["GT.M" X "O FN:(newversion)"
 Q
DOCMD(CMD) ;Do a VMS command
 W !,"Execute command: "_CMD
 I OS["OpenM" X "S X=$ZF(-1,CMD)" Q
 I OS["DSM" X "S X=$ZC(%SPAWN,CMD)" Q
 I OS["GT.M" X "ZSYSTEM CMD" Q
 Q
 ;
FILE ;write data for this device
 S DEV=$P(X,U,2),NODE=$P(Y,U,1),PORT=$P(Y,U,2),SPEED=$S($P(Y,U,4)]"":$P(Y,U,4),1:9600)
 Q:(NODE="")!(PORT="")  U IO W !," setup "_$P(X,U)
 S QUE=$S($P(Y,U,3)]"":$P(Y,U,3),1:"n")
 S XTRM=$S($D(^%ZIS(1,DA,"SUBTYPE")):^("SUBTYPE"),1:0),XTRM=$S($D(^%ZIS(2,+XTRM,1)):+^(1),1:80) ;Get value from TT file
 S XTRM=$S(XTRM<1:80,XTRM>511:511,1:XTRM),XTRM=$E(1000+XTRM,2,4) ;Check range 80-511
 S XTRM=255 ;Force value
1 ;Write to LT_LOAD
 U XFIO(1) W "create port "_DEV_" /nolog ! "_$P(X,U),!
 W "set port "_DEV_" /app /queue /nolog /node="_NODE_" /port="_PORT,!
2 ;Write to LT_PTR
 U XFIO(2) W QUE_XTRM_$E(DEV_"     ",1,9)_$E(SPEED_"     ",1,5)_"  ! "_$P(X,U),!
3 ;U XFIO(3) W "$ prot "_$P(X,U,2),!
4 ;TSC_LOAD
 U XFIO(4) W "@PR "_NODE_" "_PORT_" "_SPEED,!
 S DA=0 Q  ;Force end of loop on DA
 ;
OP ;File names to open
 ;;SYS$COMMON:[SYSMGR]LT_LOAD.COM
 ;;SYS$COMMON:[SYSMGR]LT_PTR.DAT
 ;;place holder
 ;;SYS$COMMON:[DECSERVER]TSC_LOAD.COM
CL1 U XFIO(1) W "exit",!,"$ EXIT 1" Q
CL2 U XFIO(2) W "$ EXIT" Q
CL3 U XFIO(3) W "$ EXIT" Q
CL4 U XFIO(4) W "$ EXIT" Q
 ;
TX U XFIO(X) W XTWHEN,! F I=0:1 S T=$T(@TX+I),T=$P(T,";;",2,9) Q:T=""  W T,!
 Q
TX1 ;;$! Create and set DECserver ports
 ;;$ SET NOON
 ;;$ RUN SYS$SYSTEM:LATCP
 ;;
TX2 ;;$ This file is used as input to SYSPRINT.com
 ;;
TX3 ;;$ prot:= set prot=(O:rwlp,G:rwlp,W:rwlp)/device/owner=[100,1]/nolog
 ;;$! set device protection
 ;;
TX4 ;;$! Create file to set DECservers for printers
 ;;$ tsc:= run DS5CFG
 ;;

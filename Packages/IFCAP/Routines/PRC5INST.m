PRC5INST ;WISC/RFJ-version 5 IFCAP installation main program ;30 Jun 94
 ;;5.0;IFCAP;;4/21/95
 ;
 N %,%H,%I,DA,DIC,DIE,DIK,DR,PRC5INS1,PRC5INS2,PRC5PRC,PRC5PRCP,PRC5STRT,PRCEND,PRCINSTL,PRCNAME,PRCPFLAG,PRCSTART,PRCTEXT,PRCVERS,X,Y
 ;
 D NOW^%DTC S PRC5STRT=%
 ;  prcvers used to check version number
 ;  prc5inst used in environmental check
 S PRCVERS=$P($T(PRC5INST+1),";",3),PRC5INST=1
 ;
 ;  display introduction
 W !!,"=================== *** IFCAP INSTALLATION INTRODUCTION *** ==================="
 W !,"|",?78,"|"
 W !,"|  Before running this program, please make sure you do not have users",?78,"|"
 W !,"|  on the system.  Also, please make sure you have a working backup of",?78,"|"
 W !,"|  your system disks.",?78,"|"
 S %="",$P(%,"-",80)="" W !,%
 ;
 ;  run environmental check routine
 D ^PRC5INS1 I '$G(PRC5INST) Q
 D EN^PRC5C I '$D(PRC5INST) Q
 ;
 ;  check called routines and last ifcap routine
 S PRCPFLAG=0 I $D(^%ZOSF("TEST")) F X="PRC5INS1","PRCPUYN","PRCPUX2","PRCPXTRM","PRCPINIT","PRCINIT","PRCTRED" X ^%ZOSF("TEST") I '$T S PRCPFLAG=1 Q
 I PRCPFLAG K X S X(1)="It does not look like all of the IFCAP Version "_PRCVERS_" routines have been successfully loaded.  Please re-load the routines and run this program again." D DISPLAY^PRCPUX2(1,78,.X) Q
 ;
 ;  find last version loaded
 S (DA,X)=0 F  S DA=$O(^DIC(9.4,"C","PRC",DA)) Q:'DA  S %=$G(^DIC(9.4,DA,"VERSION")) I %>X S PRC5PRC=DA_"^"_%,X=%
 I X,X'>3.9999 K X S X(1)="YOU MUST BE RUNNING IFCAP VERSION 4.0 OR GREATER BEFORE INSTALLING VERSION "_PRCVERS_"." D DISPLAY^PRCPUX2(1,78,.X) Q
 S (DA,X)=0 F  S DA=$O(^DIC(9.4,"C","PRCP",DA)) Q:'DA  S %=$G(^DIC(9.4,DA,"VERSION")) I %>X S PRC5PRCP=DA_"^"_%,X=%
 ;
 W !!,"================== *** IFCAP INSTALLATION INITIALIZATION *** =================="
 W !,"The installation of IFCAP Version ",PRCVERS," has two parts to it as follows:"
 S PRC5INS1=$G(^DIC(9.4,+$G(PRC5PRCP),22,+$O(^DIC(9.4,+$G(PRC5PRCP),22,"B",PRCVERS,0)),0)),Y=$P(PRC5INS1,"^",3) I Y D DD^%DT S $P(PRC5INS1,"^",3)=Y
 S PRC5INS2=$G(^DIC(9.4,+$G(PRC5PRC),22,+$O(^DIC(9.4,+$G(PRC5PRC),22,"B",PRCVERS,0)),0)),Y=$P(PRC5INS2,"^",3) I Y D DD^%DT S $P(PRC5INS2,"^",3)=Y
 S PRCTEXT(10,0)="PART 1: Generic Inventory Package     "_$S($P(PRC5INS1,"^",3)'="":"previously installed "_$P(PRC5INS1,"^",3),1:"NOT INSTALLED") W !,"     ",PRCTEXT(10,0)
 S PRCTEXT(11,0)="PART 2: IFCAP Main System             "_$S($P(PRC5INS2,"^",3)'="":"previously installed "_$P(PRC5INS2,"^",3),1:"NOT INSTALLED") W !,"     ",PRCTEXT(11,0)
 ;
 W ! S XP="ARE YOU SURE YOU WANT TO START/CONTINUE THE INSTALLATION OF IFCAP",XH="Enter 'YES' to install IFCAP, 'NO' or '^' to exit." I $$YN^PRCPUYN(2)'=1 Q
 ;
 ;  clean up package file
 W !!,"======================= *** CLEANING UP PACKAGE FILE *** ======================"
 ;  clean out old prc entries
 S PRCNAME="PR" F  S PRCNAME=$O(^DIC(9.4,"C",PRCNAME)) Q:PRCNAME=""!($E(PRCNAME,1,2)'="PR")  D
 .   I PRCNAME="PRCA" Q
 .   I $E(PRCNAME,1,3)'="PRC",$E(PRCNAME,1,3)'="PRX" Q
 .   S DA=0 F  S DA=$O(^DIC(9.4,"C",PRCNAME,DA)) Q:'DA  I DA'=+$G(PRC5PRC),DA'=+$G(PRC5PRCP) W !?5,PRCNAME," (internal entry #",DA,") ..." S DIK="^DIC(9.4," D ^DIK W "  deleted."
 ;  reset name if wrong
 I $G(PRC5PRC),$D(^DIC(9.4,+PRC5PRC,0)),$P(^(0),"^")'="IFCAP" S DIE="^DIC(9.4,",DA=+PRC5PRC,DR=".01///IFCAP" D ^DIE
 ;
 D CONTINUE^PRC5INS1
 Q

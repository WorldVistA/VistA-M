NVSMENU ;WJW,JLS/OIOFO - CACHE Systems Utility                1/21/06  NOON  
 ;;1.8
 ;
INIT S U="^",$P(DASH,"-",80)="" S:'$D(DTIME) DTIME=300 D HOME^%ZIS
 ;
MENU W @IOF,!,DASH,!?25,"NVS Utilities ",$P($T(NVSMENU+1),";;",2),!,DASH,!
 K DIR
 S DIR(0)="SO^R:Routine Utilities;G:Global Utilities;Z:$ZU Calls"
 S DIR("A")="Select one of the above items, or '^' to quit"
 W ! D ^DIR
 I Y<0!($D(DIRUT)) G EXIT
 S USRSEL=Y K X,Y S DISTYPE=$S(USRSEL="R":"ROUTINE",USRSEL="G":"GLOBAL",USRSEL="Z":"$ZU CALL",1:"")
LIST S MAX=0 K NVSARR W @IOF,!,"#",?6,"CACHE ",DISTYPE," UTILITY SET",?50,"ITEM",!,DASH,!
 F NUM=1:1 S LINE=$P($T(@USRSEL+NUM),";;",2) Q:LINE=""  D  I $Y>(IOSL-4) S DIR(0)="E",DIR("A")="Press RETURN to go back to the list" W ! D ^DIR W @IOF
 .S ITEM=$P(LINE,";"),COMD=$P(LINE,";",2),TYPE=$P(LINE,";",3),OOS=$P(LINE,";",4)
 .Q:TYPE'=USRSEL
 .W !,NUM,?6,ITEM,?50,COMD I $G(OOS)]"" W ?75,OOS
 .S NVSARR(NUM)=ITEM
 .S MAX=MAX+1
 .Q
SELECT K DIR S DIR(0)="NO^1:"_MAX_"",DIR("A")="Select Cache Utility item number to run or '^' to quit"
 S DIR("?")="^D MENU^NVSHELP" W ! D ^DIR
 I Y<0!($D(DIRUT)) G MENU
 S LINE=$P($T(@USRSEL+Y),";;",2,999)
 S ITEM=$P(LINE,";"),COMD=$P(LINE,";",2),TYPE=$P(LINE,";",3),OOS=$P(LINE,";",4),ROUHID=$P(LINE,";",5),ROUSPL=$P(LINE,";",6),OBJTAG=$P(LINE,";",7),ROUAXP=$P(LINE,";",8)
 I OOS]"" W !!,"<<< This utility is currently not available, please choose another item. >>>" H 3 G MENU
ROUCHK I TYPE="R" D  I $G(NOROU)=-1 G LIST
 .K NOROU
 .I $G(ROUHID)="" D
 ..I $G(ROUSPL)="O" D
 ...I '$$EXIST^%R(COMD_".OBJ") S NOROU=-1 D NOROU
 ...Q
 ..I $G(ROUSPL)'="O" D
 ...I '$L($T(@COMD)) S NOROU=-1 D NOROU
 ...Q
 ..Q
 .I $G(ROUHID)]"" D
 ..I '$L($T(@ROUHID)) S NOROU=-1 D NOROU
 ..Q
 .Q
DOIT W !!,"--- ",ITEM," ---",!
 S ITEM=$P(LINE,";"),COMD=$P(LINE,";",2),TYPE=$P(LINE,";",3),OOS=$P(LINE,";",4),ROUHID=$P(LINE,";",5),ROUSPL=$P(LINE,";",6),OBJTAG=$P(LINE,";",7)
 I OOS]"" W !!,"<<< This utility is currently not available, please choose another item. >>>" H 3 G MENU
 I USRSEL="R" I COMD["NVSMENU" D  G:$G(NVSKEEP)=1 LIST Q
 .S NVSKEEP=1
 .I $G(ROUHID)]"" D @ROUHID ; -- 'SHOW' and 'CHANGE'
 .Q
 I USRSEL="R"!(USRSEL="G") D  G LIST
 .I $G(OBJTAG)]"" S COMD=OBJTAG_U_COMD
 .I $G(COMD)]"" I $G(ROUHID)="" H 2 W @IOF D @COMD
 .I $G(COMD)]"" I $G(ROUHID)]"" H 2 W @IOF D @ROUHID
 .K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W !! D ^DIR
 .Q
 I USRSEL="Z" D  G LIST
 .W !
 .I $G(ROUSPL)="" W !,@COMD
 .I $G(ROUSPL)="S" D @COMD
 .K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W !! D ^DIR
 .Q
 Q
 ;
NOROU ; -- display info for missing routine(s) --
 W !!,"<<< Routine ",COMD," is not found in the routine directory. >>>",!
 W !,"This routine can be retrieved from an FTP server at DOWNLOAD.VISTA.MED.VA.GOV"
 W !,"in the [ANONYMOUS.VSTS.AXP.CACHECONV] directory, or you can log a Remedy ticket"
 W !,"for assistance."
 I $G(ROUAXP)]"" D
 .W !!,"This routine is described in ",ROUAXP," and can be reviewed on FORUM in the"
 .W !,"Shared Mail AXP ",$S(ROUAXP["ALERT":"ALERT",1:"INFO")," MESSAGE mail basket or at the VSTS Technical Support Team"
 .W !,"web address at http://vaww.va.gov/custsvc/cssupp/axp/",!
 .Q
 K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue"
 W ! D ^DIR
 Q
 ; -----------------------------------------------------------------------
MENUS ;     MENU ITEM GROUPS - 'R' (routine), 'G' (global), 'Z' ($zu)
         ;
 ;     to add a new item, add new line with format in group section at the
 ;     END of the group list to preserve the item number order, and also
 ;     update help routine NVSHELP for online doc for the new item.
 ;     
 ;     ;;$p1 - menu item display name
 ;     ; $p2 - routine or $zu call
 ;     ; $p3 - item type 'R', 'G', 'Z'
 ;     ; $p4 - out of service message
 ;     ; $p5 - hidden routine call
 ;     ; $p6 - 'S' denotes TAG call in NVSMENU or 'O' for object code
 ;     ; $p7 - if object code routine, this is the tag called
 ;     ; $p8 - associated AXP message reference with 'Alert' or 'Info'
 ;
 ; -----------------------------------------------------------------------
 Q
R ; --- ROUTINE MENU ITEMS ---
 ;;VistA and VMS device setup;^NVSMKPRN;R;;;;
 ;;Start/Stop TM/Broker/Mailman;^NVSSTB;R;;;;
 ;;System wide System Status;^NVSVCSS;R;;;;
 ;;Show current namespace and DAT;^%DIR;R;;;;
 ;;Show defined namespaces;LIST^%NSP;R;;;;
 ;;Show info about current Namespace;SHOW^NVSMENU;R;;SHOW;S
 ;;Change Namespace;CD^NVSMENU;R;;CD;S
 ;;Show DAT file;DSET^NVSMENU;R;;DSET;S
 ;;Change to a different DAT file;CHANGE^NVSMENU;R;;CHANGE;S
 ;;Clean Inactive Job Nodes in TMP;^NVSTMPC;R;;;;
 ;;Check Enhanced Cube Security;%ZVASEC;R;;;O;info;AXP Info #27
 ;;Check Cache DCL Level Security;%ZVASDCL;R;;;O;DCLinfo;AXP Info #27
 ;;Free Block Counts for configuration files;ALL^%FREECNT;R;;;;
 ;;Display Cluster Master;REHASH^NVSMENU;R;;REHASH;S
 ;;HL Link Ping Test;PING^HLMA;R;;;;
 ;;Show System Error Log;SYSLOG^NVSMENU;R;;SYSLOG;S
 ;;Queue Management;QUEMGT^NVSMENU;R;;QUEMGT;S
 Q
G ; --- GLOBAL MENU ITEMS ---
 ;;Show Mapping for a global;^NVSMENU;G;;GLX;S
 ;;Get node counts in a global;^NVSLOOP;G;;;;
 Q
Z ; --- $ZU CALL MENU ITEMS ---
 ;;Show current config signed into;$ZU(86);Z;;;;
 ;;Show namespace;$ZU(5);Z;;;;
 ;;Show VMS node name;$ZU(110);Z;;;;
 ;;Primary MAC address;$ZU(114,0);Z;;;;
 ;;Ethernet Device;$ZU(114,1);Z;;;;
 ;;Show Current Journal File;$ZU(78,3);Z;;;;
 ;;Journaling Status (Started/Stopped?);JSTAT;Z;;;S;
 ;;Allow unsubscripted kills (this session);KILLYES;Z;;;S;
 ;;Disallow unsubscripted kills (this session);KILLNO;Z;;;S;
 Q
 ; --------------------------------------------------------------------
CALLS ;     ROUTINE/GLOBAL/$ZU CALLS WITHIN NVSMENU ROUTINE
 ; --------------------------------------------------------------------
 ;
JSTAT H 2 W "Journaling ",$S(+$ZU(78,22)=1:"started.",1:"stopped.")
 Q
 ;
KILLYES H 2 S X=$ZU(68,28,0) W "<<< WARNING: Unsubscripted Kills Allowed! >>>" K X
 Q
 ;
KILLNO H 2 S X=$ZU(68,28,1) W "Good: Unsubscripted Kills *NOT* Allowed." K X
 Q
 ;
REHASH K DIR,NVSCMD,NVSYS,X
 S NVSYS=$P($ZU(86),"*",2) I $G(NVSYS)="" W !!,"Unable to resolve configuration name!" H 2 Q
 S NVSCMD="CACHE/ENV="_NVSYS_" ""-U%SYS"" ""^REHASH"""
 H 2 X "S X=$ZF(-1,NVSCMD)" K NVSCMD,NVSYS,X
 K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 Q
 ;
DSET H 2 S %U="",MGDIR="%SYS" F %I=0:0 S %U=$O(^|MGDIR|SYS("UCI",%U)) W !,%U Q:%U=""
 K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 Q
 ;
GLX K DIR,NVS,NVSCHAR,NVSFLAG,NVSG,NVSGU,NSP,X,Y
 S DIR(0)="FO",DIR("A")="Enter Global Name without the '^'"
 S DIR("?")="^W !,"" --- Global Listing ---"",! D ^%GD"
 H 2 W ! D ^DIR
 I Y<0!($D(DIRUT)) K DIR,NVSG,NVSGU Q
 S NVSFLAG=1 D  I NVSFLAG=0 W !!,"<<< Global name contains erroneous characters, please try again! >>>",! G GLX
 .K NVSCHAR
 .F NVS=1:1:$L(Y) Q:NVSFLAG=0  S NVSCHAR(NVS)=$E(Y,NVS) D
 ..I $A(NVSCHAR(NVS))=37 Q  ; -- percent "%" okay --
 ..I $A(NVSCHAR(NVS))>32 I $A(NVSCHAR(NVS))<48 S NVSFLAG=0 Q  ; -- "!" to "/" ascii range --
 ..I $A(NVSCHAR(NVS))>57 I $A(NVSCHAR(NVS))<65 S NVSFLAG=0 Q  ; -- ":" to "@" ascii range --
 ..I $A(NVSCHAR(NVS))>90 I $A(NVSCHAR(NVS))<97 S NVSFLAG=0 Q  ; -- "[" to "'" ascii range --
 ..Q
 .Q
 S NVSG=Y,NVSGU=U_Y
 I '$D(@NVSGU) W !,"No such global.",! G GLX
 S NSP=$ZU(90,4)
 W !!,NVSG," in namespace ",NSP," is mapped to: ",$$getdest^%GXLINF1(NSP,NVSG) G GLX
 Q
 ;
CD W !,"<<< WARNING - This will switch to another namespace and exit this utility! >>>",!
 K DIR S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO"
 H 2 W ! D ^DIR W !
 I Y=0!($D(DIRUT)) Q
 W !!,"To switch back use utility D ^%CD and enter ",$ZU(5),!
 K NVSKEEP D EXIT D ^%CD
 Q
 ;
SHOW H 2 S NSP=$ZU(5) D SHOW^%NSP(NSP)
 K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 Q
 ;
CHANGE K DIR,NVSDIR,X,Y
 H 2 W !,"<<< WARNING - This will switch to another DAT file and exit this utility! >>>",!
 K DIR S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO"
 W ! D ^DIR W !
 I Y=0!($D(DIRUT)) Q
 K DIR S DIR(0)="F^3:30",DIR("A")="Enter the DAT you want to change to (ex: VAA,VBB,ZSHARE)"
 S DIR("?")="^S %U="""",MGDIR=""%SYS"" F %I=0:0 S %U=$O(^|MGDIR|SYS(""UCI"",%U)) W !,%U Q:%U="""""
 W ! D ^DIR
 I Y<0!($D(DIRUT)) K DIR,X,Y Q
 I Y=$ZU(90,4) W !,"Please use utility D ^%CD to switch back to default namespace." H 2 K DIR,X,Y Q
 D  I NVSDIR="" W !!,"<<< DAT file not found, please try again >>>",! H 2 G CHANGE
 .S %U="",NVSDIR="",MGDIR="%SYS"
 .F %I=0:0 S %U=$O(^|MGDIR|SYS("UCI",%U)) S:%U[Y NVSDIR=%U Q:%U=""
 .Q
 W !,"Changing to ",NVSDIR S NVSDIR="^^"_NVSDIR
 W !!,"To switch back use utility D ^%CD and enter ",$ZU(90,4),!
 D EXIT X ("ZR  O:NVSDIR?1""^^"".e 63:NVSDIR I $ZU(5,NVSDIR)") K NVSDIR,NVSKEEP
 Q
 ;
SYSLOG ; -- show Cache System Error Log entries --
 H 2
 D SCREEN^|"%SYS"|SYSLOG K %ST
 Q
 ;
QUEMGT ; -- call Carl's queue_management_menu.com in USER$:[AXP] --
 H 2
 N NVSCHK,NVSFILE,NVSPEC S NVSPEC("QUEUE_MANAGEMENT_MENU.COM")="" S NVSCHK=$$LIST^%ZISH("USER$:[AXP]","NVSPEC","NVSFILE")
 I NVSCHK=0 D  Q
 .W !,"<<< File QUEUE_MANAGEMENT_MENU.COM not found in the USER$:[AXP] directory. >>>",!
 .W !,"This file can be retrieved from an FTP server at DOWNLOAD.VISTA.MED.VA.GOV"
 .W !,"in the [ANONYMOUS.VSTS.AXP.CACHECONV] directory, or you can log",!,"a Remedy ticket for assistance."
 .K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 .Q
 W !,"This item provides a sub-menu of options to manage vms queues.",!
 N X S X=$ZF(-1,"@USER$:[AXP]QUEUE_MANAGEMENT_MENU")
 Q
 ;
EXIT K COMD,DASH,DIR,DIRUT,DISTYPE,I,ITEM,LINE,MAX,MENUFLAG,MGDIR,NOROU,NSP,NUM,NVSG
 K NVSARR,NVSGU,NVSKEEP,NVSNS,OBJTAG,OOS,POP,ROUAXP,ROUHID,ROUSPL,TYPE,USRSEL,X,Y
 Q

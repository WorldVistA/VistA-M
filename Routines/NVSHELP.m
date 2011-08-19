NVSHELP ;JLS/OIOFO  -  NVSMENU HELP                           1/21/06  NOON
 ;;1.8
 ;
MENU ; -- called from routine NVSMENU if user enters '?' at item listing --
 ;
 Q:$D(NVSARR)=""
 W @IOF,!,DASH,!,$S(USRSEL="R":"ROUTINE",USRSEL="G":"GLOBAL",1:"ZCALL")," HELP",!,DASH,!
 S NUMH="" F  S NUMH=$O(NVSARR(NUMH)) Q:NUMH=""  D
 .S ITEMH=$G(NVSARR(NUMH)) S USRHLP=USRSEL_NUMH
 .F LINO=0:1 S LINH=$P($T(@USRHLP+LINO),";",2) Q:LINH=""  D
 ..I $Y>(IOSL-4) S DIR(0)="E",DIR("A")="Press RETURN to go continue" W ! D ^DIR W @IOF
 ..I LINO=0 S LINH=NUMH_"  "_LINH W !!,LINH Q
 ..S:$G(LINH)=999 LINH="No help text available." W !?3,LINH
 .Q
 K ITEMH,LINH,LINO,NUMH,USRHLP
 Q
 ;
R1 ;- VistA and VMS device setup -
 ;This item allows you to add or edit a Vista device, create a Vista
 ;terminal type, reload the VMS LAT table, or reload the VMS Outbound
 ;Telnet table.
 Q
R2 ;- Start/Stop TM/Broker/Mailman -
 ;This item will manually start or stop Taskman, RPC Broker and Mailman on
 ;the current node the utility is running on.  It will initially check for
 ;existing processes and ask if you are sure you wish to start or stop the
 ;process(es).
 Q
R3 ;- System wide System Status -
 ;This item lists a cluster-wide system status.
 ;NOTE: This item uses the Fileman Browser for display, ie, to scroll through
 ;the screen pages use the Up/Down Arrow keys, *NOT* the RETURN key. For
 ;additional help on navigation function details, use <PF1>H for online help.
 Q
R4 ;- Show current namespace and DAT -
 ;This item displays the current namespace and default directory.
 Q
R5 ;- Show defined namespaces -
 ;This item lists the all namespaces for the running Cache configuration.
 Q
R6 ;- Show info about current Namespace -
 ;This item lists global mapping and routine directory locations for the
 ;current namespace.
 Q
R7 ;- Change Namespace -
 ;This item switches from your current process namespace to a different
 ;namespace. Using this option will exit from the utility.
 Q
R8 ;- Show DAT file -
 ;This item lists all configuration DAT file locations.
 Q
R9 ;- Change to a different DAT file -
 ;This item will switch from the default DAT file location to another DAT
 ;file location. Using this option will exit from the utility.
 Q
R10 ;- Clean Inactive Job Nodes in TMP -
 ;This item will check/purge old data from the cluster node's ^TMP global.
 ;This needs to be run on each node in the cluster as ^TMP is local to all
 ;nodes. 
 Q
R11 ;- Check Enhanced Cube Security -
 ;This item will display the current settings for the Cache Cube enhanced
 ;security including defined classes, location of the CACHEUAF.SYS file and
 ;software version. 
 Q
R12 ;- Check Cache DCL Level Security -
 ;This item displays cluster user information regarding DCL access to Cache.
 Q
R13 ;- Free Block Counts for configuration files -
 ;This item displays all configuration DAT files listing total blocks, free
 ;blocks, expansion capability, and file directory locations.
 Q
R14 ;- Display Cluster Master -
 ;This item displays the configuration nodes, the 'CLUSTER' node
 ;identifies the current Cache master node.
 Q
R15 ;- HL Link Ping Test -
 ;This item will perform a ping test to check the network link status to
 ;another domain in VHA. Note - if a remote link is disabled this test can
 ;take minutes to complete.
 Q
R16 ;- Show System Error Log -
 ;This item displays system error log information.
 Q
R17 ;- Queue Management -
 ;This item provides a menu to start, stop and maintain vms queues.
 Q
 ;;;
G1 ;- Show Mapping for a global -
 ;This item displays namespace mapping information for a selected global.
 Q
G2 ;- Get node counts for a global -
 ;This item will list global node counts for a selected global,
 ;ie ^TMP or ^XTMP.
 Q
 ;;;
Z1 ;- Show current config signed into -
 ;This call displays the directory location of the Cache configuration CPF
 ;file and configuration name.
 Q
Z2 ;- Show namespace -
 ;This call displays the name of the namespace the process is running in.
 Q
Z3 ;- Show VMS node name -
 ;This call displays the name of the node the process is running on.
 Q
Z4 ;- Primary MAC address -
 ;This call displays the MAC address for the node the process is running on. 
 Q
Z5 ;- Ethernet Device -
 ;This call displays the Ethernet address for the node the running process.
 Q
Z6 ;- Show Current Journal File -
 ;This call displays the directory location and name of the current open
 ;Journal file.
 Q
Z7 ;- Journaling Started/Stopped? -
 ;This call displays the Journaling status for the Cache configuration.
 Q
Z8 ;- Allow unsubscripted kills (this session) -
 ;WARNING: This call will enable unsubscripted global kills, ie, K ^TMP will
 ;be allowed and DELETE the entire global. Use this with extreme caution!
 Q
Z9 ;- Disallow unsubscripted kills (this session) -
 ;This call will disable unsubscripted global kills, ie, attempting a K ^TMP
 ;will be prohibited resulting in a <PROTECT> error message displayed.
 Q
 ;;;

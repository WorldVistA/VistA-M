XTINOK ;SFISC/RWF - CHECK TO SEE IF OK TO LOAD ;02/13/95  16:16
 ;;7.3;TOOLKIT;;Apr 25, 1995
A I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user to initialize." G BAD
 I DUZ(0)'="@" W *7,!!,">> You must have programmer access (DUZ(0)=@) to run this init." G BAD
 W !,"I'm checking to see if it is OK to install Toolkit v",$P($T(+2),";",3),!," in this account.",!
 S %=$$VERSION^XPDUTL("XU") G:%&(%<7.1) OLD
OK ;
 W !!,"Everything looks OK, Lets continue.",!
 X "S DTIME=84000" K XUINTIME S XUINTIME(1)=$H
 N DA,DIC,DIE,DR
 S DIC="^DIC(9.4,",DIC(0)="X",X="DHCP Software Tools" D ^DIC
 I Y>0 S DA=+Y,DIE=DIC,DR=".01///^S X=""TOOLKIT""" D ^DIE
 Q
OLD W !!,*7,"It looks like you currently have version ",%," of KERNEL installed."
 W !,*7,"You must first install KERNEL V7.1 before this version can be installed.",!
BAD K DIFQ Q

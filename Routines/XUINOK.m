XUINOK ;SFISC/RWF - CHECK TO SEE IF OK TO LOAD ;06/02/95  12:23
 ;;8.0;KERNEL;;Jul 10, 1995
 N Y
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user to initialize." G EXIT
 ;
 W !,"I'm checking to see if it is OK to install KERNEL v",$P($T(+2),";",3)," in this account.",!
 W !!,"Checking the %ZOSV routine" D GETENV^%ZOSV
 I $P(Y,"^",4)="" W !,"The %ZOSV routine isn't current.",!,"Check the second line of the routine, or your routine map table." G EXIT
 ;must have Kernel 7.1
 S Y=$$VERSION^XPDUTL("XU") G:Y&(Y<7.1) OLD
 ;during Install, check global access,MM routine, and OS
 ;XPDDIQ = don't ask DISABLE OPTIONS question
 ;XPDNOQUE = not to allow queueing during install
 I $G(XPDENV) D GBLOK,MMCHK,OS S XPDDIQ("XPZ1")=0,XPDNOQUE=1
 Q:$G(XPDQUIT)
 W !!,"Everything looks OK, Lets continue.",!
 
 Q
 ;
OLD W !!,*7,"It looks like you currently have version ",Y," of KERNEL installed."
 W !,*7,"You must first install KERNEL v7.1 before this version can be installed.",!
ABRT S XPDQUIT=1 Q
EXIT S XPDQUIT=2 Q
 ;
 Q
GBLOK ;Check to see if we have write access to needed globals.
 W !,"Now to check protection on GLOBALS.",!,"If you get an ERROR, you need to add Write access to that global.",!
 F Y="^%ZIS","^%ZISL","^%ZTER","^%ZUA" W !,"Checking ",Y S @(Y_"=$G("_Y_")")
 Q
MMCHK ;check XMGAPI4
 N X
 S X="XMGAPI4" X ^%ZOSF("TEST") E  Q
 ;if exists, skip routine during load
 S X=$$RTNUP^XPDUTL("XMGAPI4",2)
 Q
OS ;checks OS and skips all other ZU routines
 ;XUZURTN = ZU routine to save, checked in XUINPRE
 N X,XUNU,XUNU1,XUOS
 S X=$G(^%ZOSF("OS")),XUOS="VXD^DTM^MSM^MSQ"
 F XUNU=1:1:4 S XUNU1=X[$P("DSM^DTM^MSM^M/SQL",U,XUNU) Q:XUNU1
 Q:'XUNU1
 F XUNU1=1:1:4 S:XUNU'=XUNU1 X=$$RTNUP^XPDUTL("ZU"_$P(XUOS,U,XUNU1),2)
 S XUZURTN="ZU"_$P(XUOS,U,XUNU)
 Q

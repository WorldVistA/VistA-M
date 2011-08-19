ES1P46E ;PHOENIX/KLD - Patch ES*1*46 Environment check; 5/13/09  3:22 PM
 ;;1.0;POLICE & SECURITY;**46**;May 8.2009;Build 12
ST N DIC,X,Y S DIC="^DIC(9.4,",DIC(0)="M",X="POLICE & SECURITY" D ^DIC
 I Y<1 D AB(1) Q
 ;Now check if 3 options exist
 S DIC="^DIC(19,",X="ESP ACTIVITY ADD/EDIT" D ^DIC I Y<1 D AB(2) Q
 S X="ESP ADD JOURNAL ENTRY" D ^DIC I Y<1 D AB(2) Q
 S X="ESP CAR POOL AVAILABILITY" D ^DIC I Y<1 D AB(2) Q
 ;Now check if 2 routines exist
 S X="ESPVAL" X ^%ZOSF("TEST") I '$T D AB(3) Q
 S X="ESPVEH" X ^%ZOSF("TEST") I '$T D AB(3) Q
 Q
 ;
AB(X) W !!,"Aborting install - Police ",$P("package^options^routines",U,X)," not present!"
 S XPDQUIT=1 Q

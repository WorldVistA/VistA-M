ZTMCHK ;SEA/RDS-Taskman: Option, ZTMCHECK, Part 1 ;01/12/95  08:12
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 N ZTF,ZTJ,ZTN,ZTOS,ZTPAIR,ZTPN,ZTPS,ZTPT,ZTRET,ZTS,ZTSIZ,ZTSLO,ZTV,ZTVLI,ZTVMJ,ZTVOL,ZTVSN,ZTVSS,ZTX,DTOUT,DUOUT,X,Y
CHECK ;Main Entry Point For Environment Check
 S U="^",%ZIS="",IOP="HOME" D ^%ZIS
 W @IOF,!!,"Checking Task Manager's Environment."
 ;
GLOB ;Checking Task Manager's Globals
 W !!,"Checking Taskman's globals..."
 F ZT="^%ZTSCH","^%ZTSK","^%ZTSK(-1)","^%ZIS(14.5,0)","^%ZIS(14.6,0)","^%ZIS(14.7,0)" D
 . W !?5,ZT," is ",$S($D(@ZT):"",1:"not "),"defined!" W:'$D(@ZT) $C(7)
 . Q
 ;
NODES ;Check Required %ZOSF Nodes
 W !!,"Checking the ^%ZOSF nodes required by Taskman..."
 S ZTF=1 F ZTN="ACTJ","AVJ","MAXSIZ","MGR","OS","PROD","TRAP","UCI","UCICHECK","VOL" D
 . I $D(^%ZOSF(ZTN))[0 W !?5,"^%ZOSF('",ZTN,"') is missing!",$C(7) S ZTF=0
 . Q
 I 'ZTF K ZTF,ZTN Q
 W !?5,"All ^%ZOSF nodes required by Taskman are defined!"
 ;
 D LOOKUP
CONT ;program is continued in ZTMCHK1
 G ^ZTMCHK1
 ;
LOOKUP ;lookup TaskMan site parameters
 N Y D GETENV^%ZOSV S ZTVOL=$P(Y,U,2),ZTPAIR=$P(Y,U,4)
 S ZTOS=^%ZOSF("OS")
 S ZTVSN=$O(^%ZIS(14.5,"B",ZTVOL,""))
 S ZTVSS=$G(^%ZIS(14.5,+ZTVSN,0))
 S ZTVLI=$P(ZTVSS,U,2)
 ;
 S ZTPN=$O(^%ZIS(14.7,"B",ZTPAIR,"")),ZTPS=$G(^%ZIS(14.7,+ZTPN,0))
 S ZTPT=$P(ZTPS,U,4),ZTSIZ=+$P(ZTPS,U,5)
 I 'ZTSIZ,ZTOS'["VAX DSM",ZTOS["DSM" S ZTSIZ=32
 S ZTRET=+$P(ZTPS,U,6),ZTVMJ=+$P(ZTPS,U,7),ZTSLO=+$P(ZTPS,U,8)
 Q
 ;
PARAMS ;
 N ZTF,ZTJ,ZTN,ZTOS,ZTPAIR,ZTPN,ZTPS,ZTPT,ZTRET,ZTS,ZTSIZ,ZTSLO,ZTV,ZTVLI,ZTVMJ,ZTVOL,ZTVSN,ZTVSS,ZTX,DTOUT,DUOUT,X,Y
 D LOOKUP,INFO^ZTMCHK1
 Q

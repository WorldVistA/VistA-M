A1B2PST ;ALB/MJK - ODS Post Init ; 14 JAN 1991
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
EN ; -- entry point to run post-init
 D DEL
 Q
 ;
MG ; -- add confirmation mail group
 S DIC="^XMB(3.8,",DIC(0)="L",DIC("DR")="4////PU;5////"_DUZ,X="ODS CONFIRMATION" D ^DIC K DIC
 G MGQ:'$P(Y,U,3)
 S ^XMB(3.8,+Y,2,0)="^^2^2^2900625^"
 S ^XMB(3.8,+Y,2,1,0)="This mail group will receive confirmation messages from ODS National Rollup"
 S ^XMB(3.8,+Y,2,2,0)="Database System."
 W !!,">>> New 'ODS CONFIRMATION' confirmation mail group added..."
MGQ Q
 ;
 ;
DIEZ ; -- compile input templates
 ;
 W !!,">>> Will now compile three DG and SD input templates affected"
 W !,"    by this package (3 templates)..."
 K A1B2LINE S U="^",$P(A1B2LINE,"=",81)="",A1B2MAX=^DD("ROU")
 F A1B2X="DGADM","DGADMASIH","SDM1" S Y=+$O(^DIE("B",A1B2X,0)) I $D(^DIE(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) S X=$P(^("ROUOLD"),"^"),DMAX=A1B2MAX D EN^DIEZ W !!,A1B2LINE
 W !!,*7,">>> Also, please use the 'Recompile HINQ templates' option"
 W !,"    to recompile the 'DVBHINQ UPDATE' input template."
 ;
 K A1B20,A1B2X,A1B2MAX,A1B2EMP,DGI,A1B2LINE Q
 ;
POS ; -- add ODS period of service
 S X="OPERATION DESERT SHIELD",DIC="^DIC(21,",DIC(0)="ML"
 S DIC("DR")=".02////ODS;.03////6;.04////2910115;.06////W;.07///1973;20////ACTIVE DUTY FROM ODS;10///OTHER FEDERAL AGENCY;15///ODS;.08////1"
 D ^DIC K DIC
 I Y<1 W !,*7,">>> Could not add 'OPERATION DESERT SHIELD' Period of Service." Q
 I $P(Y,U,3) W !,">>> 'OPERATION DESERT SHIELD (Code: 6)' Period of Service has been added."
 Q
 ;
PAR ; -- set up parameter file entry
 Q:$D(^A1B2(11500.5,1,0))
 S Y=$O(^DIC(4.2,"B","ISC-ALBANY.VA.GOV",0))
 S DIC(0)="L",X=1,DIC="^A1B2(11500.5,",DIC("DR")=".02////0;.06////"_Y
 D ^DIC K DIC
 I $P(Y,U,3) W !!,">>> ODS PARAMETER file entry added."
 Q
 ;
DEL ; -- call to remove delete routines
 I '$D(^%ZOSF("DEL")) W !,"^%ZOSF(""DEL"") does not exist" G QD
ASK W !!,">>> This routine will permanantly remove the routines:"
 W !,"              A1B2NAT"
 W !,"              A1B2P1",!
 W !,"    WARNING:  If either of the listed routines are mapped, they"
 W !,"              must first be removed from the mapped set to avoid"
 W !,"              further complications!",!
 W !,"Are you sure you want to continue" S %=2 D YN^DICN G QD:%=-1!(%=2) I '% W !?5,"Respond 'Y'es or 'N'o" G ASK
 W !,"Routine deletion starting..."
 F A1B2X="A1B2NAT","A1B2P1" S X=A1B2X X ^%ZOSF("TEST") I $T W !?5,"...removing ",X X ^%ZOSF("DEL")
 W !,"Routine deletion completed."
QD K A1B2X,X,% Q
 ;
BOS ; -- check Branch of Service entries
 ;
 W !!,">>> Will now check entries in your 'Branch of Service' file..."
 S E=0,DOTS=". . . . . . . . . . ."
 F I=1:1 S X=$P($T(NAMES+I),";",3) Q:X="$END"  W !?10,X,$E(DOTS,1,25-$L(X)) S Y=$O(^DIC(23,"B",X,0)) W $S($D(^DIC(23,+Y,0)):"",1:"not "),"present" I 'E,'$D(^DIC(23,+Y,0)) S E=1
 I E W !!,"    You should use VA FileMan to enter/edit missing branches."
 K I,E,X,Y,DOTS Q
 ;
NAMES ; -- BOS names
 ;;AIR FORCE
 ;;ARMY
 ;;COAST GUARD
 ;;MARINE CORPS
 ;;NAVY
 ;;NOAA
 ;;USPHS
 ;;$END

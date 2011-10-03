PRCBFCP1 ;WISC@ALTOONA/CTB-EDIT CONTROL POINT CONT. ;9-6-90/10:26
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OUT K C,D,DQ,D0,DI,DLAYGO,DWLW,I,J,NEW,NEWNAME,OLD,OLDNAME,OLDNUM,PRCFA,Y,X,DIC,DIE,DR,DA Q
REA ;REACTIVATE AN INAACTIVE FUND CONTROL POINT
 K PRCFA S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S PRCFA("REACTIVATE")="",DA(1)=PRC("SITE"),DIC="^PRC(420,"_DA(1)_",1,",DIC(0)="AEMQN" D ^DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to reactivate this Fund Control Point",%B="",%=1 D ^PRCFYN I %'=1 G OUT:%<0,REA:%=2
 S $P(^PRC(420,DA(1),1,DA,0),"^",22,24)="0^^",X=" --Fund Control Point has been reactivated*" D MSG^PRCFQ S DIC("A")="Select Next Fund Control Point: " G REA
DEA ;DEACTIVATE A CONTROL POINT
 K PRCFA S PRCF("X")="AS" D ^PRCFSITE Q:'%  S DA(1)=PRC("SITE"),DIC="^PRC(420,"_DA(1)_",1,",DIC(0)="AEMQN" D ^DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to deactivate this Fund Control Point",%B="",%=1 D ^PRCFYN I %'=1 G OUT:%<0,DEA:%=2
 S $P(^PRC(420,DA(1),1,DA,0),"^",22,24)="1^"_DUZ_"^"_DT,X=" --Fund Control Point has been deactivated*" D MSG^PRCFQ W ! S DIC("A")="Select Next FUND CONTROL POINT: " G DEA

SCMCRT0 ;ALB/SCK - PCM REPORT OUTPUTS ; 10/30/95
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1T1; Primary Care Management
 ;
 Q
 ;
TMPRFL ;   Team Profile Report Entry point
 ;
 N SCTMS,SCPOS,SCBRK,SCTEAMS
 I '$$SELTM G EXIT
 I '$$SELPOS(SCTMS) G EXIT
 S SCBRK=$$PAGEBRK("Team") G:SCBRK="" EXIT
 IF '$$GETDEV G EXIT
 IF $D(IO("Q")) D QUE  G EXIT
 W ! D WAIT^DICD
 D START^SCMCRT1(SCTMS,SCPOS,.SCTEAMS,SCBRK)
EXIT ;
 D:'$D(ZTQUEUED) ^%ZISC
 K ^TMP("PCMTP",$J)
 Q
 ;
SELTM() ;
 N SCOK
 S SCOK=1
 W !!,$$LINE("Team Selection")
 I '$$TMS S SCOK=0 G SELTMQ
 IF SCTMS="S" S SCTMS=10 D  G:'SCOK SELTMQ
 . S DIC="^SCTM(404.51,",VAUTSTR="Team",VAUTVB="SCTEAMS",VAUTNI=2
 . D FIRST^VAUTOMA
 . I Y<0 K SCTMS S SCOK=0
 S:SCTMS="A" SCTMS=1
 S:SCTMS="I" SCTMS=0
 ;
SELTMQ Q SCOK
 ;
SELPOS(SCTMS) ;
 N SCOK
 S SCOK=1
 IF SCTMS=0 S SCPOS=-1  G SELPSQ
 ;
 W !!,$$LINE("Position Selection")
 S DIR(0)="S^A:Active Positions;I:Inactive Positions;P:All Positions"
 S DIR("A")="Positons: ",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S SCOK=0 G SELPSQ
 S:Y="A" SCPOS=1
 S:Y="I" SCPOS=0
 S:Y="P" SCPOS=-1
SELPSQ Q SCOK
 ;
GETDEV() ;
 N SCOK
 S SCOK=0
 W !!,"This report is formatted for standard letter size output",!
 S %ZIS="PMQ" D ^%ZIS  G DEVQ:POP
 S SCOK=1
DEVQ Q (SCOK)
 ;
TMS() ;
 N SCOK
 S SCOK=1
 S DIR(0)="S^A:Active Teams;I:Inactive Teams;S:Select Teams"
 S DIR("A")="Teams: ",DIR("B")="A"
 D ^DIR
 S SCTMS=Y
 I $D(DIRUT) S SCOK=0
TMSQ Q SCOK
 ;
LINE(STR) ;
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X,"_",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
PAGEBRK(STR) ;
 N X
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want a page break as the "_STR_" changes?"
 D ^DIR
 I $D(DIRUT) S Y=""
 Q Y
 ;
QUE ;
 S ZTRTN="QSTART^SCMCRT1",ZTDESC="TEAM PROFILE REPORT"
 F X="SCTMS","SCPOS","SCTEAMS(","SCBRK" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"TASK #",ZTSK
 D HOME^%ZIS K IO("Q")
 Q

PRCNSERP ;SSI/ALA-Service Priority Report ;[ 02/04/97  6:44 PM ]
 ;;1.0;PRCN;**3,7**;Sep 13, 1996
EN ;  Begin report by selecting a service
 S DIR(0)="SM^O:Select One Service;A:Select All Services",DIR("A")="Select Print Type "
 D ^DIR K DIR S VTI=$TR(X,"ao","AO") I VTI["^" G EXIT
 I VTI="O" D SRV G EXIT:$G(SRV)=""
 S $P(LIN,"-",80)="",PG=0
 S %ZIS="MQ" D ^%ZIS G EXIT:POP>0
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BEG^PRCNSERP",ZTDESC="Service Priority Report"
 . S ZTSAVE("VTI")="",ZTSAVE("LIN")="",ZTSAVE("PG")="",ZTSAVE("SRVNM")=""
 . I $G(SRV)'="" S ZTSAVE("SRV")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK,%ZTLOAD,ZTREQ
 I $E(IOST)="P" U IO
BEG I VTI="O" S PRI="",TOTAL=0 D HDR G PRI
 S SRV=""
ALL S SRV=$O(^PRCN(413,"P",SRV)) I SRV="" D CONT G EXIT
 S PRI="",TOTAL=0,SRVNM=$P(^DIC(49,SRV,0),U) D  Q:$G(PRCNC)'=""
 . I $E(IOST)'="P",PG>0 D  Q:$G(PRCNC)'=""
 . . R !,"Press RETURN to continue or '^' to quit. ",PRCNC:DTIME S:'$T PRCNC=U
 . . K:PRCNC'?1"^".E PRCNC
 . D HDR
PRI S PRI=$O(^PRCN(413,"P",SRV,PRI))
 I PRI="" G ALL:VTI'="O" I VTI="O" D CONT G EXIT
 S TRN=""
TRN S TRN=$O(^PRCN(413,"P",SRV,PRI,TRN)) G PRI:TRN=""
 S PRCNDAT0=$G(^PRCN(413,TRN,0)) I PRCNDAT0="" K ^PRCN(413,"P",SRV,PRI,TRN) G TRN
 S PRCNL=$P(PRCNDAT0,U,9),PRCNLDD=$P(^DD(413,8,0),U,3)
 S PRCNF="" F LL=1:1 Q:$P(PRCNLDD,";",LL)=""  I $P(PRCNLDD,";",LL)[PRCNL_":" S PRCNF=$P($P(PRCNLDD,";",LL),":",2) Q
 I $G(PRCNC)'="" D EXIT Q
 W !,$P(PRCNDAT0,U),?20,PRI,?40,$E(PRCNF,1,8)
 S NL=NL+1 D CHKPG G EXIT:$G(PRCNC)'=""
 S RQ=0 F  S RQ=$O(^PRCN(413,TRN,1,RQ)) Q:RQ'>0  D
 . S PRCNIT0=^PRCN(413,TRN,1,RQ,0),COST=$P(PRCNIT0,U,4),QTY=$P(PRCNIT0,U,5)
 . S SBTOT=COST*QTY,TOTAL=TOTAL+SBTOT
 . S PRCNL=$P(PRCNDAT0,U,9),PRCNLDD=$P(^DD(413.015,8,0),U,3)
 . S PRCNF="" F LL=1:1 Q:$P(PRCNLDD,";",LL)=""  I $P(PRCNLDD,";",LL)[PRCNL_":" S PRCNF=$P($P(PRCNLDD,";",LL),":",2) Q
 . D ITD
 G TRN
SRV S DIC(0)="AEQZ",DIC="^DIC(49," D ^DIC Q:+Y<0
 S SRV=+Y,SRVNM=$P(Y,U,2) K DIC,Y
 Q
CONT Q:$G(PRCNC)
 I $G(TOTAL)'="" W !,?72,$E(LIN,1,7),!,?70,$J(TOTAL,9,2) D CHKPG
 I $G(TOTAL)=""!($G(TOTAL)=0) W !,?35,"***  NO RECORDS TO PRINT *** "
 I $E(IOST)="P" W @IOF
EXIT K SRV,SRVNM,PRI,VTI,PRCNF,PRCNIT0,PRCNL,PRCNLDD,QTY,RQ,RDQ,SBTOT,TOTAL
 K LIN,LL,NL,PG,PI,PRCNDAT0,RQD,COST,QTY,TRN,TXT,X,DN,C,PRCNC,I,Y,Z
 K DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX
 D ^%ZISC
 Q
CHKPG ; If printing to screen & it is full, clear screen, if printing to
 ; a printer take appropriate action
 Q:$G(PRCNC)'=""
 Q:IOSL>(NL+6)
 I $E(IOST)="C" W !,"Press RETURN to continue or '^' to quit. " R PRCNC:DTIME S:'$T PRCNC=U K:PRCNC'?1"^".E PRCNC  Q:$G(PRCNC)'=""
 D HDR
 Q
HDR ; Print a header for the report
 U IO S PG=PG+1,$P(TXT," ",40)="" W @IOF
 W !,"REQUESTS BY SERVICE PRIORITY"
 W $J("",IOM-$L(TXT)\2) S X="N",%DT="T" D ^%DT
 W $$FMTE^XLFDT(Y,"1P")_"  PAGE: "_PG,!
 W !,"TRANSACTION #",?20,"PRIORITY",?40,"TYPE",?54,"COST",?62,"QUANTITY",?73,"TOTAL"
 W !,?39,"PARENT SYSTEM",!,?5,"ITEM DESCRIPTION",?39,"/ COMPONENT"
 W !,?40,"JUSTIFICATION",!,LIN,!
 W !,"SERVICE: ",SRVNM,!
 S NL=10
 Q
ITD ;  Get item description and format
 K ^UTILITY($J,"W") S DIWR=27,DIWL=1,DIWF=""
 S RQD=0 F  S RQD=$O(^PRCN(413,TRN,1,RQ,1,RQD)) Q:RQD'>0  S X=^PRCN(413,TRN,1,RQ,1,RQD,0) D ^DIWP
 I $G(^UTILITY($J,"W",DIWL))="" Q
 F PI=1:1:^UTILITY($J,"W",DIWL) S NL=NL+1 D CHKPG Q:$G(PRCNC)'=""  W !,?5,^UTILITY($J,"W",DIWL,PI,0) I PI=1 D
 . W ?38,$E(PRCNF,1,12),?54,$J(COST,6,2),?62,$J(QTY,4,0),?73,$J(SBTOT,6,2)
 Q

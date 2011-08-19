PRCFPR1 ;WISC/LDB-PRINT FROM STACKED DOCUMENTS LIST ;6/29/00  12:16
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SELECT N DA,DIC,DIE,DIR,X,Y D ENS^%ZISS K ^TMP($J),^TMP("PRCREC")
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DIR("A")="Select the type of report to print",DIR(0)="S^1:PURCHASE ORDERS;2:RECEIVING REPORTS;3:1358s;4:2237s (GPFs)" D ^DIR G:$D(DIRUT) EXIT S TYPE=+Y
 I '$D(^PRC(421.8,"AC",TYPE)) W !,"THERE ARE NO RECORDS OF THIS TYPE TO PRINT." G EXIT
 W ! S DIR("A")="Would you like to print ALL the PROCESSED records of this type",DIR("B")="YES",DIR(0)="Y" D ^DIR S ALL=Y I $D(DUOUT)!($D(DTOUT)) G EXIT
 G:'ALL DT
 W ! S DIR("A")="Print ALL records including those that have been previously PRINTED",DIR("B")="NO",DIR(0)="Y" D ^DIR S PRNT=Y I $D(DTOUT)!$D(DUOUT) G EXIT
 S DATE1=$O(^PRC(421.8,"AC",TYPE,0)) D NOW^%DTC S DATE2=$E(%,1,12) G TASK
DT W ! K DIR S DIR(0)="DO^"_$O(^PRC(421.8,"AC",TYPE,0))_":"_(DT+.9999)_":EXT^S:X="""" X=$O(^PRC(421.8,""AC"",TYPE,0))",DIR("B")=$$DATE($O(^PRC(421.8,"AC",TYPE,0)))
 S DIR("A")="Begin with which date",DIR("?",1)="Time is optional.",DIR("?")=" Enter the date to start range-"
 D ^DIR S:'Y DATE1=$O(^PRC(421.8,"AC",TYPE,0)) G:$D(DTOUT)!$D(DUOUT) EXIT
 S:Y DATE1=Y S DATEX=$P(DATE1,".")
 W ! K DIR S DIR("A")="End with which date",DIR("?",1)="Time is optional.",DIR("?")=" Enter the date that will end the range-"
 D NOW^%DTC S %=$E(%,1,12) S DIR(0)="DO^"_DATEX_":"_(DT+.9999)_":ET",DIR("B")=$$DATE(%) D ^DIR G:$D(DIRUT) EXIT S:$P(Y,".",2)="" $P(Y,".",2)=9999 S DATE2=Y,Y=0
 I 'ALL D LST G:OUT EXIT
 I 'ALL,'ZZ W !!,"NO RECORDS WERE PROCESSED" G EXIT
RELST I 'ALL,Y K DIR S DIR(0)="YO",DIR("B")="NO",DIR("A")="Relist the requests" D ^DIR I Y D LST G:OUT EXIT G RELST
 I 'ALL K DIR D
 .S DY=18,DX=0 X IOXY S DIR(0)="LO^1:"_ZZ_"^K:X[""."" X",DIR("A")="Select the highlighted number(s) to print from the list",(DIR("??"),DIR("?"))="^D HLP^PRCFPR1"
 .D ^DIR Q:$D(DIRUT)  F P=1:1 S DA=$P(Y,",",P) Q:DA=""  S:$G(^TMP($J,"PRCREC",DA)) TMP=^(DA),^TMP("PRCREC",$J,+TMP,$P(TMP,U,2))=""
 G:'ALL&$D(DIRUT) EXIT
TASK ;SET TASKMAN VARIABLES
 W !
 K %ZIS,DEV,IOP S %ZIS="NM",DEV=$O(^PRC(421.8,"AC",TYPE,0)),DEV=$O(^(DEV,0)),DEV=$O(^(DEV,0)),DEV=$S($D(^PRC(421.8,DEV,0)):$P(^(0),U,6),1:""),%ZIS("B")=DEV,IOP="Q" D ^%ZIS G:POP EXIT
 S ZTRTN="DQ^PRCFPR3",ZTSAVE("TYPE")="",ZTSAVE("ALL")="",ZTSAVE("PRNT")="",ZTSAVE("DATE1")="",ZTSAVE("DATE2")=""
 S ZTDESC="PRINT STACKED FISCAL DOCUMENTS"
 I $D(^TMP("PRCREC",$J)) S ZTSAVE("^TMP(""PRCREC"",$J,")=""
 D ^%ZTLOAD
EXIT D ^%ZISC,KILL^%ZISS
 K %,%ZIS,D0,D1,DA,DAT,DATE,DATE1,DATE2,DATEX,DIC,DIE,DIR,DTOUT,DUOUT,OUT,P,POP,PRC,PRCF,PRCHXXD1,PRNT,REC,TMP,TYPE,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZZ
 K ^TMP("PRCREC",$J) Q
 ;
DATE(Y) D DD^%DT S DATE=Y
 Q DATE
 ;
HDR W @IOF,!,IOINHI,?30,"LISTING OF ",$S(TYPE=1:"PURCHASE ORDERS",TYPE=2:"RECEIVING REPORTS",TYPE=4:"2237s (GPFs)",1:"1358s")
 W ! S X="",$P(X,"=",IOM)="" W !,X
 W !,"RECORD NUMBER",?35,"PROCESSED",?57,"PRINTED"
 W ! S X="",$P(X,"=",IOM)="" W X,!,IOINLOW
 Q
 ;
LST I 'ALL D HDR S (ZZ,OUT)=0,DAT=(DATE1-.0001) F  S DAT=$O(^PRC(421.8,"AC",TYPE,DAT)) Q:'DAT!(DAT>(DATE2+.9999))!OUT  D
 .S REC=0 F  S REC=$O(^PRC(421.8,"AC",TYPE,DAT,REC)) Q:REC=""  S DA=0 F  S DA=$O(^PRC(421.8,"AC",TYPE,DAT,REC,DA)) Q:'DA!OUT  I $D(^PRC(421.8,DA,0)) D
 ..Q:$P(^PRC(421.8,DA,0),"^",8)'=PRC("SITE")
 ..S ZZ=ZZ+1 W !,IORVON,ZZ,".)",IORVOFF,?5," ",REC,?38,$$DATE(DAT) W:$P(^PRC(421.8,DA,0),U,7) ?60,$$DATE($P(^PRC(421.8,DA,0),U,7)) S ^TMP($J,"PRCREC",ZZ)=+^PRC(421.8,DA,0)_"^"_DA I ($Y+6)>IOSL D  Q:OUT
 ...R !,"Press RETURN to continue or '^' to exit: ",OUT:DTIME S:OUT="^" OUT=1 D:'OUT HDR
 Q
 ;
HLP D LST S DY=18,DX=0 X IOXY W !,"Enter the highlighted number(s) or range of highlighted number(s) from the list.",!,"Examples are: 1    or   1,2,5   or   1-3,5"
 S DY=20,DX=0 X IOXY Q

PRCGARC ;WIRMFO@ALTOONA/CTB  IFCAP ARCHIVE ;12/10/97  9:48 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D HOME^%ZIS
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DEVIO=IO,DEVIOST=IOST,DEVXY=IOXY
HDR W !!,"You now need to enter the header information, This is typically",!,"the name and address of your medical center."
 S DIR(0)="FA^3:30",DIR("A")="Select Header Line 1: ",DIR("B")=$S($D(LINE(1)):LINE(1),1:"VA MEDICAL CENTER"),DIR("?")="Enter the first line of the header you would like to be printed on the archive record tape or an '^' to quit"
 D ^DIR K DIR I $$DIR^PRCGU D TERM QUIT
 S LINE(1)=Y
 S DIR(0)="FA^3:30",DIR("A")="Select Header Line 2: ",DIR("?")="Enter the second line of the header you would like to be printed on the archive record tape or an '^' to quit" S:$D(LINE(2)) DIR("B")=LINE(2)
 D ^DIR K DIR I $$DIR^PRCGU D TERM QUIT
 S LINE(2)=Y
 S DIR(0)="FOA^3:30",DIR("A")="Select Header Line 3: ",DIR("?")="Enter the third line of the header you would like to be printed on the archive record tape or an '^' to quit" S:$D(LINE(3)) DIR("B")=LINE(3)
 D ^DIR K DIR I Y]"",$$DIR^PRCGU D TERM QUIT
 S LINE(3)=Y
 S DIR(0)="D^::E",DIR("A")="Select Fiscal Year of This Archive",DIR("?")="Enter the Fiscal Year selected during the FIND option or an '^' to quit"
 S DIR("?",1)="If you select an exact date, I will convert it to the"
 S DIR("?",2)="last day of the FISCAL YEAR."
 S:$D(THRUDATE) DIR("B")=THRUDATE
 D ^DIR K DIR I Y]"",$$DIR^PRCGU D TERM QUIT
 I $E(Y,4,5)>9 S Y=($E(Y,1,3)+1)_"0930"
 E  S Y=$E(Y,1,3)_"0930"
 D DD^%DT S THRUDATE=Y
 W !! F I=1:1:3 W LINE(I),!
 W !,THRUDATE,!
 D NOW^%DTC S Y=% D DD^%DT S LINE(4)=Y
 S DIR("A")="IS THIS OK",DIR(0)="Y" D ^DIR I $$DIR^PRCGU D TERM QUIT
 I 'Y W !!,"OK, you may now edit this information.",! G HDR
 U DEVIO W !,"Please hold on while I count the number of documents to be archived."
 S N=0,NUMBER=0 F  S N=$O(^PRC(443.9,N)) Q:'N  I $P($G(^(N,0)),"^",2)'=2 S NUMBER=NUMBER+1
 U DEVIO W !,"  "_NUMBER_" Documents Found."
 S %ZIS("A")="Select Tape/HFS Device: "
 D ^%ZIS I POP D TERM,^%ZISC QUIT
 S MTIO=IO D HOME^%ZIS
 U MTIO W "1^IFCAP ARCHIVE^"_LINE(4),!,"2^"_LINE(1),!,"2^"_LINE(2)
 U MTIO I $G(LINE(3))]"" W !,"2^"_LINE(3)
 U MTIO W !,"3^~~PRCG~~^"_NUMBER_"^^"_THRUDATE
 U MTIO W !,"4^PO_NUMBER^VENDOR"
 U MTIO W !,"5^PORTRAIT^COURIER NEW^24",!
 S TREC=$P(^PRC(443.9,0),"^",4)
 S MESSAGE="ARCHIVING IFCAP RECORDS",ITEMS="documents"
 U DEVIO D BEGIN^PRCGU
 K LINE
 S NEXT=0
X F  U MTIO D  S XCOUNT=XCOUNT+ZCOUNT U DEVIO D PERCENT^PRCGU Q:NEXT=""
 . F ZCOUNT=1:1:5 S NEXT=$O(^PRC(443.9,"AC",NEXT)) Q:NEXT=""  D  S:IXX>1 ZCOUNT=ZCOUNT+(IXX-1)
 . . S NEXTDA=0 F IXX=0:1 S NEXTDA=$O(^PRC(443.9,"AC",NEXT,NEXTDA)) Q:'NEXTDA  D
 . . . I "13"'[$P($G(^PRC(443.9,NEXTDA,0)),"^",2) QUIT
 . . . I $P($G(^PRC(442,NEXTDA,0)),"-")'=PRC("SITE") QUIT
 . . . D DOC^PRCGARC1(NEXTDA)
 . . . QUIT
 . . QUIT
 . QUIT
 D END^PRCGU
 QUIT
TERM W !,"OPTION TERMINATED",*7
 QUIT

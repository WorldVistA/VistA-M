PRCFARRA ;WISC@ALTOONA/CTB-RELEASE RECEIVING REPORTS IN 442.9 TO AUSTIN ;2/1/95  13:35
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S %A="Are you ready to send the receiving reports to Austin",%B="A 'YES' will start the transmission process, a 'NO' or an '^'",%B(1)="will exit this option." S %=1 D ^PRCFYN I %'=1 G OUT
 W ! S %A="Have you printed and reviewed the list of Receiving Reports",%A(1)="to be released",%B="",%=2 D ^PRCFYN Q:%<0
 I %=2 W !!,"Please review the list for accuracy before continuing." H 3 G OUT
 W ! S %A="Are you ready to continue",%B="",%=2 D ^PRCFYN G:%'=1 OUT
 D ES^PRCFACR I $D(FAIL) K FAIL G OUT
 S ZTDESC="RELEASE RECEIVING REPORTS TO AUSTIN",ZTRTN="QUE^PRCFARRA",ZTSAVE("DUZ")="",ZTSAVE("PRC*")="",ZTDTH=$H D ^PRCFQ
OUT K %,C,DA,DIJ,DLAYGO,DN,DP,ER,I,IOY,J,K,P,POP,PRC,PRCFA,PRCFN,PRIOP,X1,XJ,XMDUZ,XMKK,XMLOCK,XMMG,XMN,XMQF,XMR,XMSUB,XMT,XMTEXT,XMZ,Y5,ZTDESC,ZTDTH,ZTRTN,ZTSAVE Q
DELETE ;DELETE ENTRY FROM FILE 442.9
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
D1 S DIC=442.9,DIC(0)="AEMQ" S:'$D(DIC("A")) DIC("A")="Select Receiving Report to be deleted: " S DIC("S")="I +^(0)=PRC(""SITE"")" D ^DIC K DIC Q:Y<0
 S %A="OK to delete",%B="",%=2 D ^PRCFYN Q:%<0  G DELETE:%=2
 S DIK="^PRC(442.9,",DA=+Y D ^DIK S X=" <Deleted from list>*" D MSG^PRCFQ S DIC("A")="Select Next Receiving Report: " G D1
PRINT ;PRINT LIST OF RECEIVING REPORTS
 S PRCF("X")="AS" D ^PRCFSITE I '% S X="Inadequate information to continue.*" D MSG^PRCFQ G OUT
 S DIC="^PRC(442.9,",L=0,(BY,FLDS)="[PRCFA RECEIVING REPORT LIST]" D EN1^DIP Q
QUE ;RELEASE RECEIVING REPORTS IN 442.9 FOR PRC("SITE")
 D:$D(ZTQUEUED) KILL^%ZTLOAD
 K ^PRC(442.9,"AC",1) S LDA=0 F XJ=1:1 S LDA=$O(^PRC(442.9,LDA)) Q:'LDA  I $D(^PRC(442.9,LDA,0))#2 D A
 S IOP=PRIOP,DIC="^PRC(442.9,",L=0,(BY,FLDS)="[PRCFA REC RPT TRANS LIST]" D EN1^DIP
 D ^%ZISC D NOW^PRCFQ S DT=X K %,%X,X,Y
 S DA=0,DIK="^PRC(442.9," F I=1:1 S DA=$O(^PRC(442.9,"AC",1,DA)) Q:'DA  D ^DIK
 K DIK G OUT
A K PRCFA("RETRANS") S X=^PRC(442.9,LDA,0) Q:+X'=PRC("SITE")  S %=1 F I=2:1:4 I $P(X,"^",I)="" S %=-1 Q
 Q:%<0  Q:$P(X,"^",4)>DT
 I $P(X,"^",6)]""!($P(X,"^",7)]"") S DIK="^PRC(442.9,",DA=LDA D ^DIK K DA Q
 S PRCFA("PODA")=$P(X,"^",2),PRCFA("PARTIAL")=$P($P(X,"^"),".",2)
 Q:'$D(^PRC(442,PRCFA("PODA"),11,PRCFA("PARTIAL"),0))  S PRC("PER")=$P(X,"^",3) S:$P(X,"^",5)=1 PRCFA("RETRANS")="" D ^PRCFARRT Q:$G(LCKFLG)
 S $P(^PRC(442.9,LDA,0),"^",6,7)=XMZ_"^1",^PRC(442.9,"AC",1,LDA)=""
 Q
CHANGE ;CHANGE TRANSMISSION DATE
 S DIC=442.9,DIC(0)="AEMQ",DIC("A")="Select Receiving Report.Partial Number: " D ^DIC K DIC Q:Y<0
 S DA=+Y,DR=3,DIE="^PRC(442.9," D ^DIE W ! S DIC("A")="Select Next Receiving Report.Partial Number: " G CHANGE
AP(X) ;Return Accounting Period for Receiver
 N Y S X=^PRC(442.9,X,0),Y=$P(X,U,2),X=$P($P(X,U),".",2)
 S Y=$P($G(^PRC(442,Y,11,+X,1)),U,17) ;  + added by REW for DAY-0396-41053 - patch 90
 S X=$S(Y="":"",1:$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,+$E(Y,4,5))_" "_(1700+$E(Y,1,3)))
 Q X

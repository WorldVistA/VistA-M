PRCHQRP6 ;WISC/KMB-UNAWARDED RFQS BY STATUS 3/5/96 ;8/6/96  21:06
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N SCR,X,Y,VALUE,TITLE,DIR,POP,DIRUT
 W @IOF
 W !,"Using this option, you can create a report of unawarded RFQs"
 W !,"sorted by status or sorted by status for a selected purchasing agent"
 S DIR(0)="SM^A:Status;B:RFQs entered by selected PA"
 S DIR("?")="Enter A to select a status, B to enter a PA name"
 S DIR("A")="Enter A, B, or '^' to exit"
 D ^DIR Q:$D(DIRUT)  S VALUE=Y K DIR
 ;
 D @VALUE G START
A ;
 W @IOF
 S DIS(0)="I $P($G(^PRC(444,D0,0)),""^"",8)'=5,$P($G(^PRC(444,D0,0)),""^"",8)'=0",TITLE="STATUS" D PRINT QUIT
B ;
 W @IOF
B1 S DIC("A")="Select purchasing agent name, or '^' to exit: "
 S DIC="^VA(200,",DIC(0)="AEQZ" D ^DIC K DIC Q:+Y<1  S VALUE=+Y
 I +$P($G(^VA(200,VALUE,400)),"^")<3 W !?5,$P($G(^VA(200,VALUE,0)),U)," is not a purchasing agent." G B1
 S DIS(0)="I $P($G(^PRC(444,D0,0)),""^"",4)=VALUE,$P($G(^PRC(444,D0,0)),""^"",8)'=5,$P($G(^PRC(444,D0,0)),""^"",8)'=0",TITLE="PURCHASING AGENT"
 D PRINT QUIT
 ;
PRINT ;
 S L=0,BY=7,DIC="^PRC(444,",DHD="UNAWARDED RFQ REPORT BY "_TITLE,FLDS="[PRCHQ UNAWARDED]"
 S DIOEND="I $E(IOST,1,2)=""C-"",'$D(ZTQUEUED) R !,""Press return to continue "",X:DTIME"
 D EN1^DIP
 K L,FLDS,DIC,DIS,BY,DIOEND,DHD
 Q

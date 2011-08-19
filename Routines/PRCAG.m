PRCAG ;WASH-ISC@ALTOONA,PA/CMS-Reprint Statement/Letter Option Entries ;8/23/93  2:42 PM
V ;;4.5;Accounts Receivable;**149,165,198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
REP ;ENTRY FROM REPRINT PAT STATEMENT
 NEW BEG,END,DAT,DATE,DEB,DIC,HDAT,IOP,SITE,TYP,X,Y,ZTDESC,ZTRTN,ZTSAVE,%DT
 W !!
ADT S %DT="AEXP",%DT(0)="-NOW",%DT("A")="Enter a Date to Reprint: " D ^%DT I Y<1 G REPQ
 S Y=$P(Y,".")
 I $P($O(^RC(341,"C",Y)),".")'=Y W !!,*7,"No notifications sent on that date",! G ADT
 S DAT=9999999-Y
 W !!,"Press return at the 'Patient:' prompts to reprint all patient statements",!,"for the date selected or select a start and/or end point."
 W !,"NOTE: The range is in print order not alphabetic!",!
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^RCD(340,",DIC(0)="AEMNQ",DIC("A")="Start from Patient: ",DIC("S")="I $P(^(0),U,1)[""DPT""" D ^DIC I ($D(DTOUT))!(X["^") G REPQ
 S BEG=0,Y=+Y
 I Y>0 S BEG=-1,DEB=+Y,TYP=+$O(^RC(341.1,"AC",2,0)) F DATE=DAT-.0001:0 S DATE=$O(^RC(341,"AD",DEB,TYP,DATE)) Q:$P(DATE,".")'=DAT  S BEG=$O(^RC(341,"AD",DEB,TYP,DATE,0)) Q
 I BEG=0 S BEG=$O(^RC(341,"C",+$O(^RC(341,"C",9999999-DAT)),0)) S:'BEG BEG=-1
 I BEG<0 W *7,!," Sorry, Debtor Statement not found on this date!" G ADT
 S DIC="^RCD(340,",DIC(0)="AEMNQ",DIC("A")="End after Patient: ",DIC("S")="I $P(^(0),U,1)[""DPT""" D ^DIC I ($D(DTOUT))!(X["^") G REPQ
 S END="*",Y=+Y
 I Y>0 S END=-1,DEB=+Y,TYP=+$O(^RC(341.1,"AC",2,0)) F DATE=DAT-.0001:0 S DATE=$O(^RC(341,"AD",DEB,TYP,DATE)) Q:$P(DATE,".")'=DAT  S END=$O(^RC(341,"AD",DEB,TYP,DATE,0)) Q
 I END<0 W *7,!," Sorry, Debtor Statement not found on this date!" G ADT
 I END'="*",END<BEG W *7,!,"Ending bill is before starting bill!" G ADT
 S HDAT=9999999-DAT
REPD W !! S %ZIS="QN",IOP="Q",%ZIS("B")=$P($G(^RC(342,1,0)),U,8) D ^%ZIS G:POP REPQ
 I '$D(IO("Q")) W !!,*7,"YOU MUST QUEUE THIS OUTPUT",! G REPD
 S ZTRTN="REP^PRCAGS",ZTDESC="Reprint AR Patient Statements",ZTSAVE("BEG")="",ZTSAVE("END")="",ZTSAVE("HDAT")="" D ^%ZTLOAD
REPQ D ^%ZISC Q
UB ;ENTRY FROM REPRINT UB BILLS
 S ETY="UB" ;set event type to UB and use REB sub-routine
REB ;ENTRY FROM REPRINT FOLLOW-UP LETTERS
 NEW BEG,END,DAT,DATE,DEB,DIC,IOP,SITE,TYP,X,Y,ZTDESC,ZTRTN,ZTSAVE,%DT
 D SITE^PRCAGU
 S:'$D(ETY) ETY="FL"
REBDT S %DT="AEXP",%DT(0)="-NOW",%DT("A")="Enter a Date to Reprint: " D ^%DT G:Y<1 REBQ
 S Y=$P(Y,".")
 I $P($O(^RC(341,"C",Y)),".")'=Y W !!,*7,"No notifications sent on that date",! G REBDT
 S DAT=9999999-Y
 W !!,"Press return at the 'Bill:' prompts to reprint all ",ETY," Letters",!,"for the date selected or select a start and/or end point."
 W !,"Do not select bills that print on the Patient Statement."
 W !,"NOTE: The range is in print order not alphabetic!",!
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(430,",DIC(0)="AEMNQ",DIC("A")="Start from Bill: ",DIC("S")="I "",18,25,5,24,1,2,3,4,23,22,""'[("",""_$P(^(0),U,2)_"","")" D ^DIC I ($D(DTOUT))!(X["^") G REBQ
 S BEG=0,Y=+Y
 I Y>0 S BEG=-1,DEB=+$P($G(^PRCA(430,Y,0)),U,9),TYP=+$O(^RC(341.1,"AC",$S(ETY="UB":9,1:10),0)) F DATE=DAT-.0001:0 S DATE=$O(^RC(341,"AD",DEB,TYP,DATE)) Q:$P(DATE,".")'=DAT  D
 .F DA=0:0 S DA=$O(^RC(341,"AD",DEB,TYP,DATE,DA)) Q:'DA  I +$G(^RC(341,DA,5))=Y S BEG=DA,DEB=0 Q
 .Q
 I BEG=0 S BEG=$O(^RC(341,"C",+$O(^RC(341,"C",9999999-DAT)),0)) S:'BEG BEG=-1
 I BEG<0 W *7,!," Sorry, not found!" G REBDT
 S DIC("A")="End after Bill: " D ^DIC I ($D(DTOUT))!(X["^") G REBQ
 S END="*",Y=+Y
 I Y>0 S END=-1,DEB=+$P($G(^PRCA(430,Y,0)),U,9),TYP=+$O(^RC(341.1,"AC",$S(ETY="UB":9,1:10),0)) F DATE=DAT-.0001:0 S DATE=$O(^RC(341,"AD",DEB,TYP,DATE)) Q:$P(DATE,".")'=DAT  D
 .F DA=0:0 S DA=$O(^RC(341,"AD",DEB,TYP,DATE,DA)) Q:'DA  I +$G(^RC(341,DA,5))=Y S END=DA,DEB=0 Q
 .Q
 I END<0 W *7,!," Sorry, not found!" G REBDT
 I END'="*",END<BEG W *7,!,"Ending bill is before starting bill!" G REBDT
 W !!
REBD I ETY="UB" S ZTIO="" G REBD1
 S %ZIS("B")=$P($G(^RC(342,1,0)),U,8),%ZIS="QN",IOP="Q" D ^%ZIS G:POP REBQ
 I '$D(IO("Q")) W !!,*7,"YOU MUST QUEUE THIS OUTPUT",! G REBD
REBD1 S ZTRTN="BILL^PRCAGS",ZTSAVE("BEG")="",ZTSAVE("END")="",ZTSAVE("DAT")="",ZTSAVE("SITE")="",ZTSAVE("ETY")=""
 S ZTDESC=$S(ETY="UB":"AR Reprint UB Letters",1:"Reprint AR Follow-up Letters") D ^%ZTLOAD
REBQ K ETY D ^%ZISC Q
PRDT ;ENTRY FROM PRINT STATEMENT/LETTER BY DATE OPTION
 D PRDT^PRCAGP
 Q

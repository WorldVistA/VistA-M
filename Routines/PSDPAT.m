PSDPAT ;B'ham ISC/BJW - Prt Data from TRAKKER (Patient/Drug) ; 11 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,1:0)
 ;I 'OK W $C(7),!!,"Contact your Nursing ADP Coordinator for access to display the Dispensing Report.",!! K OK Q
SUM ;ask detail or summary
 K DA,DIR,DIRUT S DIR(0)="SO^D:DETAIL LISTING ONLY;S:SUMMARY LISTING ONLY"
 S DIR("A")="Select Dispensing Report(s) to Print"
 S DIR("?",1)="Answer 'D' to print only the transaction detail for this report,",DIR("?",2)="answer 'S' to print only the summary totals  or <RET> to quit."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y
ASKN ;select NAOU for report
 K DA,DIC
 S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: ",DIC("B")=$G(NAOUN)
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
 I '+$P($G(^PSD(58.8,NAOU,2)),"^",5) W !!,"This NAOU does not maintain a perpetual inventory balance to list",!,"Dispensing data.",!! K NAOU,NAOUN G ASKN
CHKD I '$O(^PSD(58.8,NAOU,1,0)) W !!,"There are no CS stocked drugs for the NAOU you selected.",!! G ASKN
DRUG ;ask drug
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 W ! K DA,DIC
 F  S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***""",DA(1)=+NAOU,DIC(0)="QEAMZ",DIC="^PSD(58.8,"_NAOU_",1," D ^DIC K DIC Q:Y<0  D
 .S PSDRG(+Y)=+$P(Y(0),"^",4)
 I '$D(PSDRG)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DATE W ! K %DT S %DT="AEPXR",%DT("A")="Start with Date and Time: " D ^%DT I Y<0 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date and Time: " D ^%DT I Y<0 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.0001
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
DEV ;sel device
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM" D ^%ZIS I POP W !!,"NO DEVICE SELECTED OR REPORT PRINTED!!",! G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPAT1",ZTDESC="CS PHARM Compile Patient/Drug Activity" D SAVE,^%ZTLOAD K ZTSK G END
 U IO G START^PSDPAT1
END ;
 D KVAR^VADPT K VA
 K %,%DT,%H,%I,%ZIS,ALL,CNT,DA,DATE,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,LOOP,NAOU,NAOUN,NODE,NODE9,NUR1,NUR2
 K PAT,PG,POP,PSD,PSD1,PSDA,PSDATE,PSDED,PSDOUT,PSDPN,PSDR,PSDRG,PSDRGN,PSDSD,TYP,QTY,SUM,X,Y
 K ^TMP("PSDPAT",$J),^TMP("PSDPATL",$J),ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;sets variables for queueing
 S (ZTSAVE("NAOU"),ZTSAVE("NAOUN"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"),ZTSAVE("PSDIO"),ZTSAVE("SUM"))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDRG) ZTSAVE("PSDRG(")=""
 Q

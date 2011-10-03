SPNLEGA ;WDE/SD EDIT OLD DATA ;11/7/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;
EN ;Starting point
 I $D(IOF) W @IOF
 W !!,"This edit option is limited to OLDER outcomes only, i.e., outcomes on file"
 W !,"before the adoption of the 'episode of care' clinical model."
 W !,"Editing an older outcome record will not convert it to the new model."
 W !,"This option is not intended for regular use, but does provide a way to"
 W !,"access older, heritage outcomes to correct data inaccuracies.",!
PAT ;Select an Outcome from 154.1
 ;
 S SPNFEXIT=0
 K DIC
 S DIC("S")="I $P($G(^SPNL(154.1,+Y,8)),U,3)="""""
 ;S DIC("W")="I $P(^SPNL(154.1,+Y,0),U,4)"
 W ! S DIC="^SPNL(154.1,",DIC(0)="AEMQ" D ^DIC
 I +Y'>0 S SPNFEXIT=1 D ZAP^SPNCTINA Q
 S DA=+Y
EDIT ;Set up the dr string based on the record type FIM, FAM, Diener, etc
 S SPNRTYP=$P($G(^SPNL(154.1,DA,0)),U,2)
 I $G(SPNRTYP)="" D ZAP^SPNCTINA Q
 I SPNRTYP=1 S DR=".024;.03;.16;.17;.13;.14;.15;.05;.06;.07;.08;.09;.1;.11;.12;2.01;2.02;2.03;2.04;2.05;2.08;2.09;2.13;2.06;2.07" ;Self Rpt
 I SPNRTYP=2 S DR=".024;.05;.06;.07;.08;.09;.1;.11;.12;.13;.14;.15;.161;.16;.17;.181;.18;.191;.19;.2;.21;.22" ;FIM
 I SPNRTYP=3 S DR=".024;7.01;7.02;7.03;7.04;7.05;7.06;7.07;7.08;7.09;7.1;7.11;7.12;7.13;7.14" ;ASIA
 I SPNRTYP=4 S DR="4.1;4.2;4.3;4.4;4.5;4.6" ;CHART
 I SPNRTYP=5 S DR=".024;5.09;5.02;5.03;5.04;5.06;5.05;5.07;5.11;5.12;5.1;5.08;5.01" ;FAM
 I SPNRTYP=6 S DR=".024;6.01" ;DIENER
 I SPNRTYP=7 S DR=".024;6.02" ;DUSOI
 I SPNRTYP=8 S DR=".024;3.1;3.2;3.3;3.4;3.5;3.6;3.7;3.8;3.9" ;MS
 I $D(IOF) W @IOF
 S SPNDFN=$P($G(^SPNL(154.1,DA,0)),U,1)
 I $G(SPNDFN)="" K SPNRTYP,SPNDFN,SPNSSN,DA,DIC,DIE,DR,Y,SPNFEXIT Q
 S SPNSSN=$P($G(^DPT(SPNDFN,0)),U,9) S SPNSSN=$E(SPNSSN,1,3)_"-"_$E(SPNSSN,4,5)_"-"_$E(SPNSSN,6,9)
 W !!,"Patient: ",$P(^DPT(SPNDFN,0),U,1),"    SSN: ",SPNSSN
 W !,"Record Type: ",$$GET1^DIQ(154.1,DA_",",.02)
 W "      Date Recorded : ",$$FMTE^XLFDT($P($G(^SPNL(154.1,DA,0)),U,4),"5DZP")
 W !,"--------------------------------------------------------------------------",!
 ;
 S DIE=154.1
 I $G(SPNRTYP)'="" D ^DIE
 K DIE,DIC,DA,DR,Y,SPNFEXIT,SPNRTYP
 Q
INQ ;Inquire to an outcome
 W ! S DIC="^SPNL(154.1,",DIC(0)="AEMQ" D ^DIC
 I +Y'>0 S SPNFEXIT=1 D ZAP^SPNCTINA Q
 S DA=+Y
 S DIQ(0)="C"
 I $D(IOF) W @IOF
 D EN^DIQ
 K DIC,DIQ,DA,Y,SPNFEXIT
 Q

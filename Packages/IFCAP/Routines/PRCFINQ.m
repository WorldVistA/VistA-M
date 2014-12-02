PRCFINQ ;WISC/CLH,LEM-AUDIT REPORTS ;3/18/93  9:01 AM
V ;;5.1;IFCAP;**185**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;PRC*5.1*185 Add switch PRCPRTTF to inquiry EN1 & EN3 to prevent
 ;            the full PCARD number from displaying.  Modified files
 ;            410 & 442 PCARD number field to display last 4 digits
 ;            of PCARD number when switch set to on.
 ;
 ;FULL INQUIRE TO FILE 410
EN1 S PRCPRTTF=1,DIC=410,DIC(0)="AEMQ",DIC("A")="Select CONTROL POINT ACTIVITY NUMBER: " D ^DIC G Q:+Y<0 W:$D(IOF) @IOF W !!,"Processing History for:",!!,$C(7) S DA=+Y,DIQ(0)="AC" D EN^DIQ G EN1     ;PRC*5.1*185
 ;FULL INQUIRE TO FILE 430
EN2 I '$D(^DIC(430)) S X="No Accounts Receivable information available in File 430 on this system.*" D MSG^PRCFQ G Q
 S DIC=430,DIC(0)="AEMQ",DIC("A")="Select ACCOUNTS RECEIVABLE NUMBER: " D ^DIC G Q:+Y<0 W:$D(IOF) @IOF W !!,"Processing History for:",!!,$C(7) S DA=+Y,DIQ(0)="AC" D EN^DIQ G EN2
 ;FULL INQUIRE TO FILE 442
EN3 S PRCPRTTF=1,DIC=442,DIC(0)="AEMQ" D ^DIC G Q:+Y<0 W:$D(IOF) @IOF W !!,"Processing History for:",!!,$C(7) S DA=+Y,DIQ(0)="AC" D EN^DIQ G EN3     ;PRC*5.1*185
Q K PRCPRTTF,DIC,X,Y,DA,DIQ Q    ;PRC*5.1*185

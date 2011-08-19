PRCFINQ ;WISC/CLH,LEM-AUDIT REPORTS ;3/18/93  9:01 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;FULL INQUIRE TO FILE 410
EN1 S DIC=410,DIC(0)="AEMQ",DIC("A")="Select CONTROL POINT ACTIVITY NUMBER: " D ^DIC Q:+Y<0  W:$D(IOF) @IOF W !!,"Processing History for:",!!,$C(7) S DA=+Y,DIQ(0)="AC" D EN^DIQ G EN1
 ;FULL INQUIRE TO FILE 430
EN2 I '$D(^DIC(430)) S X="No Accounts Receivable information available in File 430 on this system.*" D MSG^PRCFQ Q
 S DIC=430,DIC(0)="AEMQ",DIC("A")="Select ACCOUNTS RECEIVABLE NUMBER: " D ^DIC Q:+Y<0  W:$D(IOF) @IOF W !!,"Processing History for:",!!,$C(7) S DA=+Y,DIQ(0)="AC" D EN^DIQ G EN2
 ;FULL INQUIRE TO FILE 442
EN3 S DIC=442,DIC(0)="AEMQ" D ^DIC Q:+Y<0  W:$D(IOF) @IOF W !!,"Processing History for:",!!,$C(7) S DA=+Y,DIQ(0)="AC" D EN^DIQ G EN3

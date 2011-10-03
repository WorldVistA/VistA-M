PRCAHOL ;SF-ISC/YJK-HOLD,REMOVE,LIST LETTERS ;9/10/93  9:12 AM
V ;;4.5;Accounts Receivable;**198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This releases the holding Collection Letter.
 ;This lists the holding Collection Letters.
HOLD ;============== HOLD SENDING LETTER =================================
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(430,",DIC(0)="AEQM" D ^DIC G:Y<0 HEND S DA=+Y
 I $P($G(^RCD(340,+$P(^PRCA(430,DA,0),"^",9),0)),"^")[";DPT(" D  G HOLD
 .W *7,!!,"Patient bills can no longer be put on hold!",!
 .S X=$G(^PRCA(430,DA,1))
 .I $P(X,"^")]"" W !,"Hold Letter Date: ",$$SLH^RCFN01($P(X,"^"))
 .I $P(X,"^",2)]"" W !,"Hold Letter Reason: ",$P("PERSONAL LETTER^PHONE CALL^PERSONAL VISIT^OTHERS","^",$F("LPVO",$P(X,"^",2))-1)
 .I $P(X,"^",3)]"" W !,"Hold Letter Comment: ",$P(X,"^",3)
 .I $P(X,"^")]""!($P(X,"^",2)]"")!($P(X,"^",3)]"") W !!,"NOTICE: 'HOLD LETTER' information deleted from bill",!!,"Please use the 'Suspend an AR Bill' option if you want this bill on 'hold'.",!  S $P(^PRCA(430,DA,1),"^",1,3)=""
 .Q
 S DR="21;22;23",DIE=DIC D ^DIE G HOLD
HEND K DA,DIC,DIE,DR Q
RELHOLD ;=============== RELEASE HOLDING LETTER =============================
DIC N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(430,",DIC(0)="AEQM" D ^DIC G:Y<0 REND S DA=+Y
ASK S %=2 W !!,"ARE YOU SURE YOU WANT TO REMOVE HOLD ON FOLLOW-UP FOR THIS ACCOUNT " D YN^DICN I %=0 D YN^PRCAMESG G ASK
 G:%'=1 REND
 K ^PRCA(430,DA,1) W *7,!!,"OK, THE HOLD HAS BEEN REMOVED !",! G RELHOLD
NOTH W !," <NOTHING CHANGED> " G RELHOLD
REND K DIC,DA,% Q
 ;
LISTHOL ;================= LIST OF HOLDING LETTERS ==========================
 S DIC="^PRCA(430,",BY="HOLD LETTER DATE,BILL NO.",FR=",",TO=",",L=0,DHD="LIST OF ACCOUNTS WITH HOLDS",FLDS="[PRCA LIST HOLD]" D EN1^DIP
LEND K FLDS,L,FR,TO,DIC,DHD,BY Q

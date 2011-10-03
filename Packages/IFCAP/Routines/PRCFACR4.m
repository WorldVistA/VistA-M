PRCFACR4 ;WISC@ALTOONA/CTB-EDIT CODE SHEET CODE ;4/15/93  13:08
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
KILL S DIK=DIC D WAIT^PRCFYN,^DIK W "  <CODE SHEET DELETED>",$C(7) R X:3 K DIK
OUT K %,%H,D0,DA,DIC,DIE,DQ,DR,DWLW,I,J,K,LN,LNTH,N,PRCFA,Q,Q1,X,X1,Y,Z Q
EDIT ;EDIT THE CODE OF AN EXISTING CODE SHEET
 K PRCFDEL S PRCF("X")="AS" D ^PRCFSITE G:'% OUT
 S:'$D(PRCFASYS) PRCFASYS="FEEFENIRSCLI" S DIC="^PRCF(423,",DIC(0)="AEMNQZ",DIC("S")="S ZX=^(0) I $P(ZX,U,10)]"""",PRCFASYS[$P(ZX,U,10),$P(ZX,U,2)=PRC(""SITE"")" D ^DIC K DIC("A"),DIC("S") I Y<0 K PRCFASYS G OUT
 I $P(Y(0),U)["KP"!($P(Y(0),U)["BCH") G ED
 I '$D(^PRCF(423,+Y,"CODE")) W $C(7),!,"This code sheet may not be edited until it has been released for transmission." D OUT G EDIT
 S DIE=DIC,(PRCFA("CSDA"),DA)=+Y
Q2 W !,$C(7) S %A="This Code Sheet will no longer be editable using the standard option."
Q3 S %A(1)="OK to Continue",%=1 D Q4,^PRCFYN G:%<0!(%=2) EDIT
 S DIE=DIC,X="KP-"_$P(Y(0),"^"),(PRCFA("CSDA"),DA)=+Y,X1=X,DR=".01////"_X_";.3///@",PRCFA("Y0")=Y(0) D ^DIE W "  ID has been changed to ",X1 K X1 S Y=DA
ED S:$D(PRCFA("Y0")) Y(0)=PRCFA("Y0") S PRCFA("TTLEN")=$P(Y(0),"^",8),PRCFA("SYS")=$P(Y(0),"^",10),DIE=DIC,(PRCFA("CSDA"),DA)=+Y
 I $D(^PRCF(423,DA,"CODE")) S A3=$P(^PRCF(423,DA,"CODE",0),"^",3)
 I $D(A3),A3>0 S N=0 K Q1 F I=1:1 S N=$O(^PRCF(423,DA,"CODE",N)) Q:+N=0  S Q1(I)=^PRCF(423,DA,"CODE",N,0)
 K A3 S N=0,LNTH=70 D RENUM^PRCFACR3
 S N=0 F I=1:1 S N=$O(Q1(N)) Q:+N=0  S ^PRCF(423,DA,"KEY",I,0)=Q1(N)
 D NOW^%DTC S ^PRCF(423,DA,"KEY",0)="^^"_I-1_"^"_I-1_"^"_%
ED1 S DR=112 D ^DIE S N=0,LNTH=80 D RE1^PRCFACR3,XM^PRCFACR3,XM^PRCFACXM G EDIT
Q4 S %B="Answering 'YES' to this option will cause the Code Sheet ID to be changed.",%B(1)="This change will cause the Code Sheet to be uneditable using standard edit",%B(2)="options." Q

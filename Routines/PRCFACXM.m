PRCFACXM ;WISC@ALTOONA/CTB-CODE SHEET STRING GENERATOR ;4/26/93  2:49 PM ; 4/26/93  11:48 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCFACX1
XM S PRCFX=+$P(^PRCF(423,PRCFA("CSDA"),"TRANS"),"^",15)
 W !!,"TRANSMITTED CODE SHEET WILL BE AS FOLLOWS:" I 'PRCFX W !
 ;'$D(PRCHLOG),PRCFA("SYS")'="CAP" W !
 E  W !,"         1         2         3         4         5         6         7         8" S Y="",$P(Y,"1234567890",9)="" W !,Y S Y="",$P(Y,"----+----|",9)="" W !,Y
 S X="",X1=0 F I=1:1 S X=$O(PRCFCS(X)) Q:X=""  W !,PRCFCS(X) S X1=X1+$L(PRCFCS(X))
 I PRCFX I X1'=PRCFX W !!,$C(7),"Code sheet does not equal "_PRCFX_" characters.",! G EDIT
 W ! S %A="Do you wish to TRANSMIT this Code Sheet to "_$S(PRCFA("SYS")="ISM":"ISMS",1:"LOG")
 S %=1,%B="'YES' will mark the code sheet for transmission.",%B(1)="'NO' will give you a chance to edit the code sheet."
 S %B(2)="'^' will delete the code sheet." D ^PRCFYN G:%=1 TRANSMIT G:%<0 DEL
EDIT S %A="Do you want to edit this Code Sheet",%B="'YES' to edit, 'NO' or '^' for chance to delete code sheet."
 S %=2 D ^PRCFYN I %'=1 S DA=PRCFA("CSDA") D DEL Q
 S DA=PRCFA("CSDA"),DIE="^PRCF(423," K PRCFCS
 S DR="" S:$D(PRCFA("EDIT")) DR=PRCFA("EDIT")
 I $D(PRCFA("CSNAME")),PRCFA("CSNAME")["KP" S DR=112
 I DR="" W !,"Error in editing this code sheet. Please re-enter.",$C(7) G DEL
 D ^DIE I DR=112 D RE1^PRCFACR3,XM^PRCFACR3 G XM
 G V
TRANSMIT G:'$D(^PRCF(423,DA,"TRANS")) ^PRCFACX0
 I $D(^PRCF(423,DA,"TRANS")),$P(^("TRANS"),U,1)'="Y" G ^PRCFACX0
 W $C(7) S %A="THIS CODE SHEET HAS ALREADY BEEN PRINTED.",%A(1)="DO YOU WISH TO RETRANSMIT IT",%B="'YES' to mark for retransmission.",%B(1)="'NO' or '^' to hold in file."
 S %=2 D ^PRCFYN I %'=1 W !,$C(7),"NO ACTION TAKEN " R X:3 K PRCFA("PODA") Q
 S DR=".3////N;.4///@",DIE="^PRCF(423," D ^DIE
 G ^PRCFACX0
OUT K B,D,D0,DG,DIC,DIE,DIG,DIH,DIU,DIV,DIW,DLAYGO,DR,K,Q,PRCFCS,S,X,XL1 Q
DEL ;KILL THE CODE SHEET AND CROSS REFERENCES
 S %A="Are you sure you want to delete this Code Sheet",%B="'YES' to delete, 'NO' or '^' to retain, but not transmit.",%=2 D ^PRCFYN I %'=1 S X="  <Code Sheet Retained in File>*" D MSG^PRCFQ S PRCFA("CSHOLD")="" Q
 D WAIT^PRCFYN S DA=PRCFA("CSDA"),DIK="^PRCF(423," D ^DIK S X=" CODE SHEET DELETED*" D MSG^PRCFQ
 K K,X,DA,PRCFA("CSNAME"),PRCFA("CSDA"),PRCFCS(0) S PRCFDEL="" G OUT
 Q

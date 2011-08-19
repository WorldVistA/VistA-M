PRCHCS8 ;WISC/RHD-EDIT DEPOT RECEIVING LOG CODE SHEETS ;12/1/93  09:53
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN S PRCHN("PO")=$P($P(^PRC(442,PRCHPO,0),"-",2),U,1),PRCFA("SYS")="LOG",PRCFA("REF")=PRCHN("PO"),PRCHAUTO="" W !," Now creating LOG code sheets ."
 S DA=$P($G(^PRC(442,PRCHPO,11,PRCHRPT,1)),U,7)
 I 'DA D ^PRCHCS1 Q:'$D(PRCFA)  W "."
 S:'$D(DA) DA="" I 'DA W !,"No code sheets created !",$C(7) K PRCHPO G Q
1 S PRCH=DA,IOP="" D:'$D(IOF) ^%ZIS W !! D HDR^PRCHCS0
11 I '$D(^PRCF(423,PRCH,300))!('$D(^("CODE",1,0))) D ERR1 G 3
 S Y=^PRCF(423,PRCH,"CODE",1,0) W !,Y I $L(Y)'=80!($O(^PRCF(423,PRCH,"CODE",1))) D ERR^PRCHCS0 G 3
2 W ! S %A="Do you want to transmit this code sheet",%B="'YES' will mark the code sheets for transmission.",%B(1)="'NO' will give you a chance to edit code sheet."
 S %B(2)="'^' will delete code sheet." D ^PRCFYN G TRAN:%=1,DEL1:%<0
3 S %A="Do you want to edit this code sheet",%B="'YES' to edit code sheet.",%B(1)="'NO' or '^' for chance to delete code sheet." D ^PRCFYN G DEL:%'=1
4 K PRCHLOG S DIE="^PRCF(423,",DA=PRCH,DR=PRCFA("EDIT") D ^DIE S PRCHLOG=1 D ^PRCFACX1
 G 1
TRAN I '$D(DT) D NOW^%DTC S DT=$P(%,".",1)
 S %DT="AEXF",%DT("A")="TRANSMISSION DATE: ",%DT("B")="TODAY",%DT(0)=DT D ^%DT G:Y<0 3 S PRCHDT=Y
 D SIG^PRCHCS0 I '$D(PRCHNM) D:$D(PRCHLOG) DEL1 K PRCHPO G Q
 S DA=PRCH,PRCHBTYP=5 D MRK^PRCHCS
 W !!,$C(7),"CODE SHEET MARKED FOR TRANSMISSION!"
Q G Q^PRCHCS0
ERR1 W !?5,"Code sheet has not been completed and needs to be edited !",$C(7)
 W !! S %A="Do you want to re-create the code sheet",%B="'YES' will rebuild the code sheet from the P.O. data as it was before",%B(1)="editing.  Any other answer will do nothing.",%=1 D ^PRCFYN Q:%'=1
 D ^PRCHCS1 Q:'$D(PRCFA)  I $D(DA),DA S PRCH=DA
 Q
DEL S %=1,%A="Delete code sheet for this "_$S(PRCHTYP="R":"Partial",1:"Order"),%B="'YES' or '^' to delete the code sheet.",%B(1)="'NO' to have another chance to transmit." D ^PRCFYN G:%=2 1
DEL1 ;DELETES ALL CODE SHEETS
 S DIK="^PRCF(423,",DA=PRCH D ^DIK K DIK S DA="" D SETR^PRCHCS1
 W !,"CODE SHEET DELETED FOR THIS "_$S(PRCHTYP="R":"PARTIAL",1:"ORDER")_" !",$C(7) K PRCHPO G Q

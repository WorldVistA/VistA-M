PRCHCS3 ;WISC/RHD-EDIT LOG CODE SHEETS ;9/16/94  12:23 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN S PRCFA("SYS")="LOG",PRCFA("REF")="",PRCHAUTO="" W !," Now creating LOG code sheets ."
 S PRCHLI=0,PRCHLCNT=0 F PRCHI=1:1 S PRCHLI=$O(^PRCS(410,PRCHR,"IT",PRCHLI)) Q:'PRCHLI  D SET S:$D(DA) PRCHLCNT=PRCHLCNT+1 I '$D(DA) D ^PRCHCS5 Q:'$D(PRCFA)  W "." I $D(DA),DA S PRCHLCNT=PRCHLCNT+1
 I PRCHLCNT'>0 W !,"No code sheets created !",$C(7) K PRCHR G Q
1 D:'$D(IOF) HOME^%ZIS W !! D HDR^PRCHCS0
 S PRCHLI=0 F PRCHI=1:1 S PRCHLI=$O(^PRCS(410,PRCHR,"IT",PRCHLI)) Q:'PRCHLI  S PRCH="" D CHK S:$D(DA) PRCH=DA D:'PRCH ERR1 D:PRCH 11
 G 2
11 I '$D(^PRCF(423,PRCH,300))!('$D(^("CODE",1,0))) D ERR1 Q
 S X=+^PRCF(423,PRCH,300),Y=^("CODE",1,0) W !,"  Line Item: ",X,!,Y D ERR^PRCHCS0:$L(Y)'=80!($O(^PRCF(423,PRCH,"CODE",1))),ASK^PRCHCS0:'(PRCHLI#9)
 Q
2 G:'PRCH DEL G:$L(Y)'=80!($O(^PRCF(423,PRCH,"CODE",1))) 3
 W ! S %A="Do you want to transmit these code sheets",%B="'YES' will mark the code sheets for transmission.",%B(1)="'NO' will give you a chance to edit code sheets."
 S %B(2)="'^' will delete code sheets." D ^PRCFYN G TRAN:%=1,DEL1:%<0
3 S %A="Do you want to edit any code sheets",%B="'YES' to edit any code sheet.",%B(1)="'NO' or '^' for chance to delete code sheets." D ^PRCFYN G DEL:%'=1
4 D LI G:Y<0 2 K PRCHLOG S DIE="^PRCF(423,",DR=PRCFA("EDIT") D ^DIE S PRCHLOG=1 D ^PRCFACX1,DSP^PRCHCS0
 G 4
TRAN I '$D(DT) D NOW^%DTC S DT=$P(%,".",1)
 S %DT="AEXF",%DT("A")="TRANSMISSION DATE: ",%DT("B")="TODAY",%DT(0)=DT D ^%DT G:Y<0 3 S PRCHDT=Y
 D SIG^PRCHCS4 I PRCSIG'=1 D:$D(PRCHLOG) DEL1 K PRCHR G Q
 S PRCHLI=0 F PRCHI=1:1 S PRCHLI=$O(^PRCS(410,PRCHR,"IT",PRCHLI)) Q:'PRCHLI  D CHK I $D(DA) S PRCSIG="" D  G:PRCSIG<1 QQ S DIE="^PRCF(423,",DR="999////"_+PRC("PER")_";.5///"_PRCHDT_";.6///5;.8///3;300.1///"_PRCHKEY D ^DIE
 .D ENCODE^PRCFES1(DA,DUZ,.PRCSIG) S ROUTINE=$T(+0)
 S DA=PRCHR I $D(^PRC(443,DA,0)) S DIK="^PRC(443," D ^DIK K DIK
 W !!,$C(7),"CODE SHEETS MARKED FOR TRANSMISSION!" G Q
QQ S:'$D(ROUTINE) ROUTINE=$T(+0) W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!",$C(7) S DIR(0)="EAO",DIR("A")="Press <return> to continue" D ^DIR K ROUTINE
Q G Q^PRCHCS4
SET ;S PRCH0=^PRCS(410,PRCHR,"IT",PRCHLI,0),I=+$P(^(0),U,5),PRCH2=$S($D(^(100)):^(100),1:""),PRCHI0=$S($D(^PRC(441,I,0)):^(0),1:""),PRCHIV0=$S($D(^PRC(441,I,2,+^PRCS(410,PRCHR,2),0)):^(0),1:"")
 S PRCH0=^PRCS(410,PRCHR,"IT",PRCHLI,0),I=+$P(^(0),U,5),PRCH2=$G(^(100)),PRCHI0=$G(^PRC(441,I,0)),PRCHIV0=$G(^PRC(441,I,2,+^PRCS(410,PRCHR,2),0))
CHK ;SEE WHETHER CODE SHEET ALREADY ON FILE
 S DA=$P($G(^PRCS(410,PRCHR,"IT",PRCHLI,0)),U,9) I $D(DA),$D(^PRCF(423,+DA,0)) Q
 K DA
 Q
ERR1 W !?5,"Code sheet for line/item number "_PRCHLI_" has not been completed",!,"and needs to be edited !",$C(7)
 W !! S %A="Do you want to re-create the code sheet for this line/item ",%B="'YES' will rebuild the code sheet from the Issue Request data as it was before",%B(1)="editing.  Any other answer will do nothing." D ^PRCFYN Q:%'=1
 D SET,^PRCHCS5 Q:'$D(PRCFA)  I $D(DA),DA S PRCH=DA
 Q
LI K DA,DIC,PRCHDA S D0=PRCHR,DIC="^PRCS(410,PRCHR,""IT"",",DIC(0)="AEMQ" S DIC("S")="I $D(^(0)) S PRCHDA=$P(^(0),U,9) I PRCHDA"
 D ^DIC K DIC Q:Y<0  S PRCHLI=+Y S:$D(PRCHDA) DA=PRCHDA K PRCHDA
 Q
DEL S %A="Delete all code sheets for this Issue Request",%B="'YES' or '^' to delete all code sheets.",%B(1)="'NO' to delete selected Line Item code sheets." D ^PRCFYN G:%'=2 DEL1
DEL0 W !?3,"Delete selected Line Item Code Sheets:" D LI G:'$D(DA) 1 S DIK="^PRCF(423," D ^DIK S DA="" D SETR^PRCHCS5 G DEL0
DEL1 ;DELETES ALL CODE SHEETS
 S DIK="^PRCF(423," D WAIT^DICD
 S PRCHLI=0 F PRCHI=1:1 S PRCHLI=$O(^PRCS(410,PRCHR,"IT",PRCHLI)) Q:'PRCHLI  D CHK I $D(DA) D ^DIK S DA="" D SETR^PRCHCS5
 K DIK W !,"ALL CODE SHEETS DELETED FOR THIS ISSUE REQUEST!",$C(7) K PRCHR G Q

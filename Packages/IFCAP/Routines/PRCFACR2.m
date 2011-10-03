PRCFACR2 ;WISC@ALTOONA/CTB-MISC ROUTINES FOR MANIPULATING BATCH CONTENTS ;4/12/93  13:09
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ADD S:'$D(PRCFASYS) PRCFASYS="FEEFENIRSCLI"
 S DIC(0)="AEMNQ",DIC=423,DIC("S")="S XXX=^(0) I $P(XXX,U)'[""BCH"",PRCFASYS[$P(XXX,U,10)" D ^DIC K XXX,DIC G:Y<0 KILL S CSDA=+Y
 I $D(^PRCF(423,CSDA,"TRANS")),$P(^("TRANS"),"^",5)'="" D W1,OUT Q
A S DIC("A")="Select BATCH NUMBER: ",DIC(0)="AEMNQZ",DIC=421.2,DIC("S")="S XXX=^(0) I $P(XXX,U,3)=""B"",PRCFASYS[$P(XXX,""-"",2)" D ^DIC K DIC,XXX G:Y<0 OUT S BADA=+Y,PBAT=$P(Y,U,2),PTR=$P(Y(0),U,2)
 I $P(^PRCF(421.2,BADA,0),"^",4)["" D QUES G:%'=1 OUT
 S PBHDR="BCH-"_PBAT S HDDA=$S('$D(^PRCF(423,"B",PBHDR)):"",1:$O(^PRCF(423,"B",PBHDR,0)))
 S DA=CSDA,$P(^PRCF(423,DA,"TRANS"),"^",1)="Y",$P(^("TRANS"),"^",5)=PBAT,$P(^("TRANS"),"^",6)=3,$P(^("TRANS"),"^",8)=PTR K ^PRCF(423,"AC","N",DA) S ^PRCF(423,"AD",PBAT,DA)=""
 I HDDA]"",$D(^PRCF(423,HDDA,"CODE",1,0)) S A=$P(^(0),".",4),A=A+1,A=$E("0"_A,$L(A),$L(A)+1),$P(^(0),".",4)=A
 W "  Done",!
 S %A="Do you wish to add another code sheet to a batch",%B="",%=1 D ^PRCFYN G:%=1 ADD
KILL K %,A,CSDA,D,DIC,DIE,DA,DR,BADA,PBAT,PTR,HDDA,PBHDR Q
OUT D KILL S X="  <Option Terminated>*" D MSG^PRCFQ Q
REMOV ;REMOVE CODE SHEET FROM BATCH
 S:'$D(PRCFASYS) PRCFASYS="FEEFENIRSCLILOG"
 S DIC(0)="AEMNQ",DIC=423,DIC("S")="I $P(^(0),U)'[""BCH""" D ^DIC K DIC G:Y<0 OUT S CSDA=+Y
 I '$D(^PRCF(423,CSDA,"TRANS")) W !,"There is an error in this code sheet, please edit it to insure it is correct!" D OUT Q
 I $P(^PRCF(423,CSDA,"TRANS"),"^",5)="" W !,"This Code sheet has not been assigned to a batch, no action is necessary." D OUT Q
 S PBAT=$P(^PRCF(423,CSDA,"TRANS"),"^",5),PBHDR="BCH-"_PBAT,HDDA=$S('$D(^PRCF(423,"B",PBHDR)):"",1:$O(^PRCF(423,"B",PBHDR,0)))
 W ! S %A="I will now remove this code sheet from batch "_PBAT_".",%A(1)="OK TO CONTINUE",%B="",%=1 D ^PRCFYN G OUT:%<0 I %=2 S X="  <No Action Taken>*" D MSG^PRCFQ G REMOV
 S X="  <Removal Completed>*" D MSG^PRCFQ
 S $P(^PRCF(423,CSDA,"TRANS"),"^",5)="" K ^PRCF(423,"AD",PBAT,CSDA)
 I HDDA]"",$D(^PRCF(423,HDDA,"CODE",1,0)) S A=$P(^(0),".",4),A=A-1,A=$E("0"_A,$L(A),$L(A)+1),$P(^(0),".",4)=A
 E  I PRCFASYS'["LOG" W !,"I was unable to correct the Batch Header in batch ",PBAT,".  Please use",!,"the 'Edit Keypunched Code Sheet' option to correct prior to transmission.",!!,$C(7) R X:3
D S %=1 S %A="Do you wish to add this code sheet to another batch",%B="" D ^PRCFYN I %=1 G A
E S %=1 W ! S %A="Will this Code Sheet be transmitted at a later date",%B="A 'YES' will queue the code sheet for retransmission." D ^PRCFYN I %=1 S DA=CSDA,DIE="^PRCF(423,",DR=".3////N;.4///@;.5;.6" D ^DIE G KILL
 W !,"Code Sheet has been retained in File, but will not be transmitted.  " R X:3 G KILL
 Q
QUES S %A="Batch "_PBAT_" has already been released to Austin.",%A(1)="Are you sure you want to continue"
 S %B="If you will not be retransmitting the batch, you are not permitted to",%B(1)="remove a code sheet from that batch." D ^PRCFYN Q
W1 W !,$C(7),"This code sheet has already been assigned to Batch ",$P(^PRCF(423,CSDA,"TRANS"),"^",5),!,"You must remove the code sheet from the batch before assigning it to another." R X:3 Q

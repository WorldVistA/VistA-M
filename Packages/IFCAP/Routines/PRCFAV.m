PRCFAV ;WISC@ALTOONA/CTB-ROUTINE TO PROCESS ADJUSTMENT VOUCHERS ;4/30/93  2:48 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCFSITE Q:'%
 K FAIL D ES I $D(FAIL) K FAIL G OUT1
 K DIC("A") S D="C",DIC("S")="I +$P(^(0),U)=PRC(""SITE"")",DIC("A")="Select Purchase Order Number: ",DIC=442,DIC(0)="AEQZ"
 D IX^DIC K DIC("S"),DIC("A") G:+Y<0 OUT1
 S PO(0)=Y(0),PO=Y,PRCFPODA=+Y,PRCFA("PODA")=+Y
 I '$D(^PRC(442,+PO,6)) D NOA G OUT1
 I $P(^PRC(442,+PO,6,0),"^",4)<0 D NOA G OUT1
 S DIC="^PRC(442,"_+PO_",6,",DIC("A")="Select ADJUSTMENT VOUCHER",DIC(0)="AEMNZQ" D ^DIC K DIC("A") G:Y<0 OUT1 S PO(6)=Y(0),PO(6,1)=^PRC(442,+PO,6,+Y,1),PRCFA("AV")=+Y
 I $P(PO(6,1),"^",5)'="" S %A="This Adjustment Voucher has already been processed by Fiscal,",%A(1)="ARE YOU SURE YOU WISH TO CONTINUE",%B="",%=2 D ^PRCFYN I %'=1 G OUT1
 W ! S %A="Do you need to process a code sheet for this Adjustment Voucher",%B="",%=1 D ^PRCFYN Q:%<1  G:%=2 OUT D AM^PRCFAC
AGAIN S PRCFA("PODA")=PRCFPODA W ! S %A="Do you need to enter an additional code sheet",%B="",%=2 D ^PRCFYN I %'=1 G OUT D AM^PRCFAC G AGAIN
OUT ;D Q15 S $P(^PRC(442,PRCFA("PODA"),6,PRCFA("AV"),1),"^",5)=+PRC("PER"),$P(^(1),"^",6)=X
 S $P(^PRC(442,PRCFA("PODA"),6,PRCFA("AV"),1),"^",5)=+PRC("PER") D Q15
 S PRCHQ="^PRCHPAM",PRCHQ("DEST")="S8",D0=PRCFA("PODA"),D1=PRCFA("AV") D ^PRCHQUE
OUT1 K P,DIC,PRCFA,PRCFPODA Q
 Q
NOA W !,$C(7),"No Adjustment Vouchers are entered for this order, please check with Supply.  ",!,?20,"Option is being aborted." R X:3 Q
ES ;
ES1 K FAIL
 N MESSAGE S MESSAGE=""
 D ESIG^PRCUESIG(DUZ,.MESSAGE)
 G FAIL1:MESSAGE=-1!(MESSAGE=-2)!(MESSAGE=-3),FAIL:MESSAGE=0
 Q
FAIL S FAIL="" W $C(7),"  SIGNATURE CODE FAILURE " R X:3 Q
FAIL1 S FAIL="" Q
Q15 S MESSAGE=""
 D ENCODE^PRCHES7(PRCF("PODA"),PRCFA("AV"),DUZ,.MESSAGE)
 K MESSAGE
 Q

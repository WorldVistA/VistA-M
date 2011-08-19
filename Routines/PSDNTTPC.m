PSDNTTPC ;BIR/JPW-Transfer Green Sheet - Receive this NAOU ; 8/15/07 11:42am
 ;;3.0; CONTROLLED SUBSTANCES ;**64**;13 Feb 97;Build 33
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Coordinator for access to transfer",!,?12,"narcotic orders.",!!,"PSJ RNURSE or PSD NURSE security key required.",! K OK Q
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH Q
 W !!,"Receive a transferred Green Sheet into this NAOU" S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^")
ASKN ;ask transfer to naou
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select Receive Transfer In NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S AOU=+Y,AOUN=$P(Y,"^",2)
GS ;select green sheet #
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",11)=10,'$P($G(^(7)),""^"",4),($P($G(^(7)),""^"",3)=AOU)!($P(^(0),""^"",18)=AOU)"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S ORD=+$P(Y(0),"^",20),PSDRG=+$P(Y(0),"^",5),PSDRGN=$P($G(^PSDRUG(PSDRG,0)),"^")
 S NAOUF=+$P(Y(0),"^",18),NAOUFN=$P($G(^PSD(58.8,+NAOUF,0)),"^")
 S PSDSP=$P($G(^PSD(58.8,NAOUF,1,PSDRG,3,ORD,0)),"^",14)
 S MFG=$P(Y(0),"^",13),LOT=$P(Y(0),"^",14),EXP=$P(Y(0),"^",15),PSDS=+$P(Y(0),"^",3)
 S QTY=+$P(Y(0),"^",6) I $D(^PSD(58.81,+PSDA,4)),+$P(^(4),"^",3) S QTY=+$P(^(4),"^",3)
 S RQTY=+$P($G(^PSD(58.81,PSDA,7)),"^",7)
 S NAOU=+$P($G(^PSD(58.81,PSDA,7)),"^",3),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^")
 S PAT=+$P($G(^PSD(58.81,PSDA,9)),U)
 I RQTY W !!,"Transfer quantity is greater than 0.",!,"Use option 'Receive Green Sheet & Drug from another NAOU'.",! G END
 I STAT'=10 W !!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please contact your Pharmacy Coordinator for assistance.",! G END
 D CHK G:PSDOUT END N X,X1 D SIG^XUSESIG G:X1="" END
 D ^PSDNTTP1  ;;*64
END K %,%DT,%H,%I,AOU,AOUN,D,DA,DIC,DIE,DIK,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,EXP,FLAG,JJ,LOT,MFG
 K NAOU,NAOUF,NAOUFN,NAOUN,NAOUT,NAOUTN,OK,ORD,PAT,PSDA,PSDOUT,PSDPN,PSDREC,PSDRG,PSDRGN,PSDRN,PSDS,PSDSP,PSDT,PSDUZ,PSDUZN,QTY,RECD,RECDT,RQTY,STAT,STATN,X,Y
 K XMDUZ,XMSUB,XMTEXT,XMY,^TMP("PSDNTMSG",$J)
 Q
CHK ;check transfer to naou
 S PSDOUT=0 W !!,?5,"The Green Sheet # ",PSDPN," and quantity of ",RQTY
 I AOU'=NAOU W " was being transferred",!,?10,"*** from ",NAOUFN,!,?10,"*** to ",NAOUN,".",!!,$C(7),?5,"You are transferring it from ",NAOUFN,!,?10,"*** to ",AOUN,"."
 I AOU=NAOU W " is being transferred ",!,?10,"*** from ",NAOUFN,!,?10,"*** to ",NAOUN,"."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you wish to complete this transfer",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to complete this Green Sheet transfer,",DIR("?")="answer 'NO' or '^' to quit without completing the transfer."
 D ^DIR K DIR I 'Y!($D(DIRUT)) S PSDOUT=1 W !!,"Receive Green Sheet # ",PSDPN," transfer into another NAOU not completed.",!! Q
 Q

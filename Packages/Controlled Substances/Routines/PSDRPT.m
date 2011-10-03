PSDRPT ;BIR/BJW-Reprint Misc (VA FORM 10-2321) ; 3 Mar 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,69**;13 Feb 97;Build 13
 ;**Y2K compliance** display 4 digit year on va forms
 ;Reference to PSD(58.8 supported by DBIA # 2711
 ;Reference to ^PSD(58.81 supported by DBIA2808
 ;Reference to ^PSD(58.86 supported by DBIA4472
 ;Reference to ^PSDRUG( supported by DBIA #221
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,$D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Coordinator for access to reprint",!,?12,"this transfer copy of VA FORM 10-2321.",!!,"PSJ RNURSE, PSD NURSE, PSJ RPHARM or PSD TECH ADV security key required.",! K OK Q
 W !!,"Reprint Transfer Between NAOUs VA FORM 10-2321",!
 W $C(7),!,"Please note that you may reprint only the copy of the VA FORM 10-2321 for",!,"Green Sheets transferred from your NAOU that have NOT BEEN RECEIVED on",!,"the transfer to NAOU.",!
ASKN ;ask transfer from naou
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select Transfer From NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S AOU=+Y,AOUN=$P(Y,"^",2)
 S TYPE=3 G GS
TYPE ;select type return to stock or turn in for destruction
 K DA,DIR,DIRUT S DIR(0)="SO^1:RETURN TO STOCK;2:TURN IN FOR DESTRUCTION"
 S DIR("A")="Select Type of VA FORM 10-2321 to Reprint"
 S DIR("?",1)="Answer '1' to reprint a Return to Stock VA FORM 10-2321,"
 S DIR("?",2)="answer '2' to reprint a Turn in For Destruction VA FORM 10-2321 or",DIR("?")="answer '^' to quit without reprinting any forms."
 D ^DIR K DIR G:$D(DIRUT) END S TYPE=Y
 G:TYPE'=2 GS
CHK ;check for type of destructions
 W ! K DA,DIR,DIRUT S DIR(0)="YO",DIR("B")="YES",DIR("A")="Is this a Green Sheet Turn in for Destructions reprint"
 S DIR("?",1)="Answer 'YES' to enter Green Sheet number, 'NO' to select",DIR("?")="a Holding for Destructions number, or '^' to quit."
 D ^DIR K DIR I $D(DIRUT) D MSG1 G END
 I 'Y D LOOK G:PSDOUT END G PRINT
GS ;select green sheet #
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S:TYPE=1 DIC("S")="I $P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",12)=3"
 S:TYPE=2 DIC("S")="I $P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",12)=2"
 S:TYPE=3 DIC("S")="I $P(^(0),""^"",11)=10,$P(^(0),""^"",18)=AOU"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S PSDPN=$P(Y(0),"^",17),PSDR=+$P(Y(0),"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 S MFG=$P(Y(0),"^",13),LOT=$P(Y(0),"^",14),EXP=$P(Y(0),"^",15),PSDS=+$P(Y(0),"^",3)
 I TYPE'=3,'$D(^PSD(58.81,PSDA,3)) D MSG G:PSDOUT END
 I TYPE=3,'$D(^PSD(58.81,PSDA,7)) D MSG G:PSDOUT END
 I TYPE'=3 S NODE=^PSD(58.81,PSDA,3) S:TYPE=1 RECD=$P(NODE,"^"),RQTY=$P(NODE,"^",2),REAS=$P(NODE,"^",3) S:TYPE=2 RECD=$P(NODE,"^",4),RQTY=$P(NODE,"^",5),PSDHLD=$P(NODE,"^",8),REAS=$P(NODE,"^",6)
 I TYPE=3 S NODE=^PSD(58.81,PSDA,7),RECD=$P(NODE,"^"),NAOUT=+$P(NODE,"^",3),RQTY=$P(NODE,"^",7),NAOUTN=$P($G(^PSD(58.8,NAOUT,0)),"^")
PRINT ;print 2321
 ;2nd line added for E3R# 3771 to print comments.
 S REPRINT=1 S:'$D(REAS) REAS=""
 S:$D(^PSD(58.86,+$G(PSDHLD),2)) PSDCOMS=$P(^(2),"^",1)
 W !!,"Number of copies of VA FORM 10-2321? " R NUM:DTIME I '$T!(NUM="^")!(NUM="") W !!,"No copies printed!!",!! Q
 S COMP=$S(TYPE=1:3,TYPE=2:2,1:999)
 I NUM'?1N!(NUM=0)  W !!,"Enter a whole number between 1 and 9",! G PRINT
 S Y=RECD X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4)
 S (PG,PSDOUT)=0,RECDT=$E(RECD,4,5)_"/"_$E(RECD,6,7)_"/"_PSDYR
 I EXP S (EXP1,EXPD)=$$FMTE^XLFDT(EXP,"5D") S:'$P(EXP1,"/",2) EXPD=$P(EXP1,"/")_"/"_$P(EXP1,"/",3) S EXP=EXPD
 D ^PSDGSRV2
END K %,%DT,%H,%I,AOU,AOUN,COMP,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXP1,EXPD,LOT,MFG
 K NAOUT,NAOUTN,NODE,NUM,OK,ORD,PG,PSDCOMS,PSDA,PSDHLD,PSDOK,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDTYP,PSDUZ,PSDYR,REAS,RECD,RECDT,REPRINT,RQTY,STAT,STATN,SUM,TYPE,X,Y
 Q
MSG ;check and write msg if not ok
 W !!,"Green Sheet #",PSDPN," has not been ",$S(TYPE=1:"returned to stock",TYPE=2:"turned in for destruction",1:"transferred between NAOUs"),".",!
MSG1 W !,"No Reprint of VA FORM 10-2321",!!
 S PSDOUT=1
 Q
LOOK ;lookup destructions #
 S PSDOUT=0
 W ! K DA,DIC S DIC=58.86,DIC(0)="QEAZ",DIC("A")="Select Destructions Holding #: "
 S DIC("S")="I $P(^(0),""^"",7)=+PSDS,'+$P(^(0),""^"",11)" D ^DIC K DIC I Y<0 D MSG1 Q
 S PSDHLD=+Y,RQTY=+$P(Y(0),"^",3),RECD=+$P(Y(0),"^",6),PSDOK=1,PSDR=+$P(Y(0),"^",2),PSDRN=$S(PSDR:$P($G(^PSDRUG(+PSDR,0)),"^"),1:$G(^PSD(58.86,+PSDHLD,1)))
 S:PSDRN']"" PSDRN="UNKNOWN" S (MFG,LOT,EXP)=""
 Q

PSDGSRV1  ;BIR/BJW/PWC-Complete GS for Ret Stk/Destroy ; 7 Apr 98
 ;;3.0; CONTROLLED SUBSTANCES ;**4,8,9,56,62,67**;13 Feb 97;Build 8
 ;**Y2K compliance** display 4 digit year on va forms
 ;modified for NOIS:NCH-1296-41051;amended to update dest. bal
 ;modified for NOIS: FAV-0498-70549
QTY ;
 W ! K DIR,DIRUT S DIR(0)="NA^.01:"_QTY_":2"    ;pwc PSD*3*67 - for return to stock
 S DIR("A")="Quantity of "_NBKU_" "_$S(COMP=3:"Returned to Stock",1:"Turned in for Destruction")_": "
 S DIR("?")="Enter a quantity from .01 to "_QTY
 D ^DIR K DIR I 'Y!$D(DIRUT) D MSG G END
 S RQTY=+Y K DIRUT
ASKN K DA,DIR,DTOUT,DUOUT S DIR("A")="RETURNED BY NURSE",DIR(0)="58.81,29O" D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MSG G END
 S NURS=$P(Y,"^") I NURS S NURSN=$P($G(^VA(200,+NURS,0)),"^")
REAS K DA,DIR,DTOUT,DUOUT S DIR(0)=$S(COMP=3:"58.81,36O",1:"58.81,39O") D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S REAS=Y
OK K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Is this OK",DIR("B")="YES"
 S DIR("?",1)="Answer 'YES' to post this completed Green Sheet data,",DIR("?")="answer 'NO' to edit or '^' to quit."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 I 'Y G QTY
UPDATE ;update 58.81
 W !!,"Accessing Green Sheet information...",!
 D NOW^%DTC S RECDT=+% D:COMP=3 SUB
 K DA,DIE,DR S DA=PSDA,DIE=58.81
 S:COMP=3 DR="34////"_RECDT_";35////"_RQTY_";41////"_BAL_";33////"_PSDUZ_";10////"_CSTAT_";11////"_COMP_";22////"_+$E(RECDT,1,12)_";29////"_NURS_";36///^S X=REAS"  ; <*62 RJS>
 S:COMP=2 DR="37////"_RECDT_";38////"_RQTY_";33////"_PSDUZ_";10////"_CSTAT_";11////"_COMP_";22////"_+$E(RECDT,1,12)_";29////"_NURS_";39///^S X=REAS"  ; <*62 RJS>
 D ^DIE K DA,DIE,DR
 W !!,"Updating your records..."
ORDER ;update order info in 58.8
 ;chged last line to d desta
 W "nursing records now..."
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////"_CSTAT_";11////"_COMP_";12////"_RECDT D ^DIE K DA,DIE,DR
 ;monthly total
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,0)) S ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,$E(DT,1,5)*100,0)) K DIC S DIC="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=+PSDS,DA(1)=PSDR D ^DIC K DIC,DA,DINUM,DLAYGO
 K DA,DIE,DR S DIE="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DA(2)=+PSDS,DA(1)=PSDR,DA=$E(DT,1,5)*100,DR=$S(COMP=3:"11////^S X=$P($G(^(0)),""^"",7)+RQTY",1:"12////^S X=$P($G(^(0)),""^"",8)+RQTY") D ^DIE K DA,DIE,DR
 W "done.",!!
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?2,"*** The status of your Green Sheet #"_PSDPN_" *** ",!
 S CSTAT=$P($G(^PSD(58.81,PSDA,0)),"^",12) W ?6,$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" "_$P($G(^PSD(58.83,CSTAT,0)),"^")
 I COMP=3 S MFG=$P(^PSD(58.81,PSDA,0),"^",13),LOT=$P(^(0),"^",14),EXP=$P(^(0),"^",15) D PRINT G END
 I COMP=2 D DESTA
END K %,%DT,%H,%I,BAL,C,COMP,CPBY,CSTAT,D,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT
 K EXP,EXP1,EXPD,LOT,MFG,NAOU,NBKU,NODE,NOK,NUM,NURS,NURSN,OCOMP,OK,ORD,PG,POP,PSDA,PSDCT,PSDEV,PSDHLD,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDTYP,PSDUZ,PSDUZN,PSDYR
 K QTY,REAS,RECD,RECDT,RQTY,STAT,STATN,SUB,WARDBAL,X,Y
 Q
MSG ;
 W $C(7),!!,"*** THIS GREEN SHEET HAS NOT BEEN COMPLETED ***",!,"The status remains "_STATN,! S PSDOUT=1 Q
 Q
SUB ;add balance,Line 4,6,9 added 7/9/97 to update naou bal.
 F  L +^PSD(58.8,+PSDS,1,PSDR,0):0 I  Q
 D NOW^%DTC S RECDT=+%
 S BAL=+$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)
 S WARDBAL=+$P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)
 S $P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)+RQTY
 ;PSD*3*56;REMOVED CHECK FOR PATIENT ID
 S $P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)=$P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)-RQTY
 L -^PSD(58.8,+PSDS,1,PSDR,0)
 W !!!,"Old Balance: ",BAL,?25,"New Balance: ",BAL+RQTY,!!
 W !!,"(NAOU) Old Balance: ",WARDBAL,?32,"(NAOU) New Balance: ",WARDBAL-RQTY,!!
 Q
DESTA ;update naou balance added 8/19/96
 F  L +^PSD(58.8,+PSDS,1,PSDR,0):0 I  Q
 S WARDBAL=+$P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)
 ;PSD*3*56;REMOVED CHECK FOR PATIENT ID
 S $P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)=$P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)-RQTY
 L -^PSD(58.8,+PSDS,1,PSDR,0)
 W !!!,"(NAOU) Old Balance: ",WARDBAL,?32,"(NAOU) New Balance: ",WARDBAL-RQTY,!
DEST ;set up file 58.86
 S PSDOUT=0,PSDCT=1
 W !!,"Accessing your transaction history...",!!
 S NODE=^PSD(58.81,PSDA,0),PSDTYP=$P(NODE,"^",2),(MFG,LOT,EXP)=""
 I PSDTYP=9 S COMP=2,REAS=$P(NODE,"^",16),RECDT=$E($P(NODE,"^",4),1,12),RQTY=$P(NODE,"^",6),RQTY=$E(RQTY,2,6),PSDS=$P(NODE,"^",3)
 I  S PSDR=$P(NODE,"^",5),PSDRN=$P($G(^PSDRUG(+PSDR,0)),"^"),PSDUZ=DUZ,NBKU=$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),"^",8)
 I PSDTYP=2 S REAS=$P($G(^PSD(58.81,PSDA,3)),"^",6),MFG=$P(NODE,"^",13),LOT=$P(NODE,"^",14),EXP=$P(NODE,"^",15)
 W !!,"Creating an entry in the Destruction file..."
 F  L +^PSD(58.86,0):0 I  Q
FIND S PSDHLD=$P(^PSD(58.86,0),"^",3)+1 I $D(^PSD(58.86,PSDHLD)) S $P(^PSD(58.86,0),"^",3)=PSDHLD G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.86,DIC(0)="L",(X,DINUM)=PSDHLD D ^DIC K DIC,DLAYGO
 L -^PSD(58.86,0)
 W !!,"Your Destruction Holding number is ",PSDHLD
 K DA,DIE,DR S DIE=58.86,DA=PSDHLD,DR="1////"_PSDR_";2////"_RQTY_";3////"_PSDUZ_";5////"_RECDT_";6////"_PSDS_";8////"_PSDA_";"_$S($D(NURSN):"4//^S X=NURSN",1:"4")_";11//^S X=PSDCT;12//^S X=NBKU"
 D ^DIE K DIE,DA,DR S $P(^PSD(58.81,PSDA,3),"^",8)=PSDHLD
 I $D(DTOUT)!$D(Y) W !!,"Incomplete information.  You must use the Reprint Disp/Receiving Report",!,"for VA FORM 10-2321 to be printed.",! Q
PRINT ;print 2321
 W !!,"Number of copies of VA FORM 10-2321? " R NUM:DTIME I '$T!(NUM="^")!(NUM="") W !!,"No copies printed!!",!! Q
 I NUM'?1N!(NUM=0)  W !!,"Enter a whole number between 1 and 9",! G PRINT
 S Y=RECDT X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4)
 S PG=0,RECDT=$E(RECDT,4,5)_"/"_$E(RECDT,6,7)_"/"_PSDYR
 I EXP S (EXP1,EXPD)=$$FMTE^XLFDT(EXP,"5D") S:'$P(EXP1,"/",2) EXPD=$P(EXP1,"/")_"/"_$P(EXP1,"/",3) S EXP=EXPD
 D ^PSDGSRV2
 Q
